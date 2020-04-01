Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A19C43331
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 20:16:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 896B520719
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 20:16:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P+ZrnUER"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 896B520719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJjnE-0003bd-M9
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 16:16:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44779)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jJjm7-0002vl-L2
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 16:15:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jJjm6-0001Qp-Dc
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 16:15:47 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a]:37425)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jJjm5-0001Q5-Px
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 16:15:46 -0400
Received: by mail-ot1-x32a.google.com with SMTP id g23so995676otq.4
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2020 13:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=CowhTqXDmQ7gom2iX0IacZpSQRlL5uV0HFBIWsOvq4Y=;
 b=P+ZrnUERmnN2v3vbPt/s5wo8RWtsNjLkBpGQU0xh9zhfcqU/2bdB42Z8r39PzcUXkc
 fCobbAcYg6CZZ9NkUdnXgD/HiAeACz9E0MeitL8nZ8mxpoLN3cFFOFVRJ0PZUZump/s9
 xKZjVm6pctmYt+o2+8TX0k2RxF6McV/PPA1SYzQ8bQzkPMY26ckkW3n4bAhjeC5THq/r
 rck1ioyJ/Gu5F+EhxFpzBuYnLSgK80Q6Yo67fMQTooE1fM+Ge15vVoAsqfJjnq9KnhPw
 CDttz9vYODyFl9v8lCTmKRHHDnbv8KiPS5177uNSFZXS/y3clm+wp6FCpUE+SAUM/H5h
 DCrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=CowhTqXDmQ7gom2iX0IacZpSQRlL5uV0HFBIWsOvq4Y=;
 b=RU0CVxSZXJBiTtBDf0bFerFNvr56tQOpBm7mDF+bcDDp2dMkW7fJpfWsottZPqq52Q
 zbivFXF1RmIYugN/cx3K8/RB4Ex9S5INSY15/wW7NE7ZkQ8d4q5PP9eqw1a0yMHS8jOR
 hbpgi4sTsrggSVxRrwEi3IuRZ+OHDKd5RTLLyVrdYB/tK3HzsXxzJfW1SvKg/PurkKuq
 XHOPa8d4yZSPOAxGgsW6pKxKQTDg8Rt7zlsvKuX0BjulAMkaDKUX0jux67MBh+p3RI0C
 55NoJ2WfKpUpWkxOk9g7hkVi5iOj6yoyNY2RlFBLtXuyYs5BmGEt7ufZmRbizcyIwW7F
 i9pQ==
X-Gm-Message-State: AGi0PuYt6P7QqJTNIPOhpvcVqTD0HYxfcPWsXU3h6/EDchdKhKdEeqNl
 6XbzLz9mSL7CnsDgkYV+f2ziLV4z+tLIXGI/YKKSbg==
X-Google-Smtp-Source: APiQypKFyWnGHKED54oVIk8XTvES3boNLDQceyMhGhsJXjEbOsRSY9gU1QaV891yh8EHwhjzo3qR1i3om7O7H+fRHXY=
X-Received: by 2002:a4a:a226:: with SMTP id m38mr35162ool.94.1585772144230;
 Wed, 01 Apr 2020 13:15:44 -0700 (PDT)
MIME-Version: 1.0
References: <87o8sblgto.fsf@dusky.pond.sub.org>
In-Reply-To: <87o8sblgto.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 1 Apr 2020 21:15:32 +0100
Message-ID: <CAFEAcA_b1gZ-B4NaEdQS2zffdvobW=FUx4ysEgXVAz+=cZ+R3Q@mail.gmail.com>
Subject: Re: Questionable aspects of QEMU Error's design
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32a
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 1 Apr 2020 at 10:03, Markus Armbruster <armbru@redhat.com> wrote:
>
> QEMU's Error was patterned after GLib's GError.  Differences include:

From my POV the major problem with Error as we have it today
is that it makes the simple process of writing code like
device realize functions horrifically boilerplate heavy;
for instance this is from hw/arm/armsse.c:

        object_property_set_link(cpuobj, OBJECT(&s->cpu_container[i]),
                                 "memory", &err);
        if (err) {
            error_propagate(errp, err);
            return;
        }
        object_property_set_link(cpuobj, OBJECT(s), "idau", &err);
        if (err) {
            error_propagate(errp, err);
            return;
        }
        object_property_set_bool(cpuobj, true, "realized", &err);
        if (err) {
            error_propagate(errp, err);
            return;
        }

16 lines of code just to set 2 properties on an object
and realize it. It's a lot of boilerplate and as
a result we frequently get it wrong or take shortcuts
(eg forgetting the error-handling entirely, calling
error_propagate just once for a whole sequence of
calls, taking the lazy approach and using err_abort
or err_fatal when we ought really to be propagating
an error, etc). I haven't looked at 'auto propagation'
yet, hopefully it will help?

thanks
-- PMM

