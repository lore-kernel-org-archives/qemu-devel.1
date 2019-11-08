Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7BA7C5DF60
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 13:03:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6BF3206A3
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 13:03:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K7RWnAZT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6BF3206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT3vI-0004x5-T4
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 08:03:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49665)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iT3uT-0004Tg-8j
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 08:02:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iT3uS-0001wc-13
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 08:02:41 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:37304)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iT3uR-0001vr-QQ
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 08:02:39 -0500
Received: by mail-oi1-x243.google.com with SMTP id y194so5168693oie.4
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2019 05:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=UGKJaJGPglj/xEf7Hk5rkTO0EWi879TZsvBP11vl6g0=;
 b=K7RWnAZT7fF1HahbhWoaJkca+8P874HH0T3A/EhZrikmhgpLN82GnQs3MpT1cGKsKW
 D5qX/HEXMIMmoSfhsLyx7VN+H2v7hv2mmFt5Lmo5QXSNyk9i8zoVsbnnvc4uXrsLqZxy
 3Y8YDUvE+DVanP3v1y80W/evM2D86hcenQUshwJUcAyA3FB3M0YQwlYF+HN3yrvoBOJf
 /HEUd9U5zf8GeESi0vflCU6LY8uNqIB+lV1eKPvsxgscGJXdswtt2PThalxEvv49XwGg
 Vd/C9srjCFHmwVrGN58SiKxMmH/pgIpuQuQ6mCx7F4T17RF3rI9q5QpfZqduMfrepzXl
 yfkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UGKJaJGPglj/xEf7Hk5rkTO0EWi879TZsvBP11vl6g0=;
 b=lYn7f1kGYBc4gaq4H0a30RD9WilqeCQBbvX7xEN4KdPO/JaI7/YRy+wPHbncm3cL4E
 BzrECZ36rP2rLiPfrUxLhOWnhnzSD/IeRc80PaB9gaTjvoCCLMI4U6vYr0WGKY7z/SbF
 MviwKLu72mX3XKFYLLpIqOAGOs03DwuoHtDKtiisH5NK0RlPhwxtk1e16JYayCkIYiqr
 6aZjWr2LCsJZvPVrTQkvlF7OYUSUZg0Qbpt4VBXZnuOgW6zv0Q+sTA3z6UNhzUHF3sWR
 vi7L1T/KTIUsor8+JoyB+Az6WEAdg2wZAp+6rX99gmXI3Sbp3LlvomeUFsjlPsWVxRjN
 EGlw==
X-Gm-Message-State: APjAAAU/UQNMNXqXXpn/u/lQ/RPlzOE0yQRSjTrnmwQuyzje0jsTI5xJ
 UaUfBWRmF3PQykL0DaAHBcaHz/2c3d7eth96odnZmA==
X-Google-Smtp-Source: APXvYqwV4mUeoHhkZIrq5KQDZyWuYaCS8JROJ8HFRqR0sC0iEJvXvsaN3tWpuV2YlVQk/CvNeK1OTpXq5PohKVJ4vOo=
X-Received: by 2002:aca:cf12:: with SMTP id f18mr9165421oig.48.1573218158810; 
 Fri, 08 Nov 2019 05:02:38 -0800 (PST)
MIME-Version: 1.0
References: <20191108110714.7475-1-david@redhat.com>
 <CAFEAcA-mD3-Zg2JunGpMqbcaT1qboCenhqEFytZD0FmFcL2i9Q@mail.gmail.com>
 <5dd613c0-6d9e-b943-b64d-7ba1791cbefe@redhat.com>
In-Reply-To: <5dd613c0-6d9e-b943-b64d-7ba1791cbefe@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 Nov 2019 13:02:28 +0000
Message-ID: <CAFEAcA-4r53vM-K24WYr1OFSOufhZ7hDHeZBhnywyaJ0gpMO1g@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] s390x/cpumodel: Introduce "best" model variants
To: David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Janosch Frank <frankja@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 qemu-s390x <qemu-s390x@nongnu.org>, Michael Mueller <mimu@linux.ibm.com>,
 Jiri Denemark <jdenemar@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 8 Nov 2019 at 12:46, David Hildenbrand <david@redhat.com> wrote:
> There is a small but important difference between "max"/"host" and
> "best". Max really means "all features", including deprecated ones.
> "best", however, can disable experimental or deprecated features. Or any
> other features we don't want to be enabled when somebody selects a model
> manually.
>
> On s390x, the feature "csske" is deprecated. New HW still has it, but we
> want new guests to run without this facility. Dropping it from "max"
> would affect existing setups. We already changed the default model
> (e.g., -cpu z13) to disable it with never QEMU machines.
>
> E.g., nested virtualization features on some architectures could be a
> feature set you want to disable, although contained in the "max" model.
> (e.g., no migration support yet).
>
>
> I am not completely against calling these "max" models instead of "best"
> models, but I think this makes it clearer that there is indeed a difference.

Hmm. I see the distinction, but is it one that's sufficiently
worth making that we want to expose it to our users, possibly
try to add it to the other architectures, etc ? How bad is it
if the CPU provides some legacy deprecated feature that the
guest just doesn't use ?

'max' already shouldn't include experimental features, at least
for Arm -- those should be off by default, because they're
experimental and you only want users to get them if they
explicitly opt in via '-cpu something,+x-my-feature'.

thanks
-- PMM

