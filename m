Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE5BC10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 11:23:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFEA020828
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 11:22:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BPFzIMMy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFEA020828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBGUs-0000gp-Fa
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 07:22:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47684)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jBGU5-00083p-Jq
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 07:22:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jBGU4-0004BN-Lt
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 07:22:09 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:44291)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jBGU4-0004Av-Fu
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 07:22:08 -0400
Received: by mail-ot1-x342.google.com with SMTP id v22so9110377otq.11
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2020 04:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=pOq5RnEKPS98y3EO2VedHaP73ZUs54LPZ/GTSOLQznI=;
 b=BPFzIMMyl6zSZ6JkANnmVsjjykfUlWd20NWVB9+72w/Zvg9SIq8uQ2uvNOhRWLYIvs
 WptO+qaLW51BHsuAIMFury8EdXuhunJzFC+gviEcE2ysqPLA8T7bbA30C88IHPAyFFmV
 nvgoR8gQ6M7bjnNaKL8b1a41SASUNQw7tLVlHO+J/cKvFKjl236kKAmAD2pkqQpr9x1Y
 gB9IYpxYndwIpQUzX0XzLdp/gELGRJLJYkc8tQLNRW/u/+bkW+/p7z87fPTU1D2T7XJa
 MrJH2BMiJkYD4mqBvnggfwI3O7YoENN6eRzqJO8V4W01mnUCgxJmfkL6i3KPDKjDs5tH
 VVfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=pOq5RnEKPS98y3EO2VedHaP73ZUs54LPZ/GTSOLQznI=;
 b=hFXyPavDiZGT0EE+Trb1ntirefLgv7jHe9VnvnPS28gW6/p6ZibyaQTkA3mzLCDGYS
 kbqkjlX2e8biYsIHAMh8+2/m3PhgBcZ2WC3zMEADFYav2MrYkVPrghgg1PqdgecOAUZy
 hSj250o91xHaLwW+qZUPJXA6K0vegFcI6pRAr8EWkBnEBwxfRZNTKQoqvNAK/cL3UOoJ
 S2z1wB6iYoxC1KrHGfiq8lunohUkEtksW231ctVDfOaGROA6Z73xbtI837V5dD1r+x71
 BznsJiub1gVE/d9XylgX6vg2BSE6N+UD5l5LVSBsue+EZ0j1ThDerTk65GRk0bl+CYOv
 yKcw==
X-Gm-Message-State: ANhLgQ3w4msbr68j9P7lEVWruehXmKzbelbwtya5oiil9wBk+M+uJtWT
 OJ05ZboutZN+Cd1ud3EtMMz2vCV/8Sxf+FJjhrMWFg==
X-Google-Smtp-Source: ADFU+vtGxC43jQXbkrSNvVXi+IQQwcCxTNAv1HFc9fqXbwVbQNfIdMB7omjfuCGa4ksDoYZ7OFKkQbXpfsVADIFX9Ds=
X-Received: by 2002:a05:6830:19e2:: with SMTP id
 t2mr5130301ott.97.1583752927505; 
 Mon, 09 Mar 2020 04:22:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200301215029.15196-1-nieklinnenbank@gmail.com>
 <20200301215029.15196-19-nieklinnenbank@gmail.com> <871rq876h3.fsf@linaro.org>
 <CAPan3WrNnrnngwE4pGeYpR9HS7Vr936-ojPZZovNo8ZdoAA0sg@mail.gmail.com>
In-Reply-To: <CAPan3WrNnrnngwE4pGeYpR9HS7Vr936-ojPZZovNo8ZdoAA0sg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Mar 2020 11:21:56 +0000
Message-ID: <CAFEAcA_6Lm-JwbXFLWeetc7+fhnrc5m2+YU28ymFw0MSoKOhwg@mail.gmail.com>
Subject: Re: [PATCH v6 18/18] docs: add Orange Pi PC document
To: Niek Linnenbank <nieklinnenbank@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Jason Wang <jasowang@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Beniamino Galvani <b.galvani@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 4 Mar 2020 at 20:55, Niek Linnenbank <nieklinnenbank@gmail.com> wro=
te:
>
> Hello Alex,
>
> On Wed, Mar 4, 2020 at 11:35 AM Alex Benn=C3=A9e <alex.bennee@linaro.org>=
 wrote:
>>
>>
>> Niek Linnenbank <nieklinnenbank@gmail.com> writes:
>> > ---
>> >  docs/orangepi.rst | 226
>> > ++++++++++++++++++++++++++++++++++++++++++++++
>>
>> I suspect there is a better place to put this is than the top level. I
>> wonder if it should be docs/specs?
>
>
> Yeah I'm fine to move it to a different subdirectory if needed. Right now=
 its placed in docs,
> as it seems that documents for machines are also placed there, for exampl=
e docs/microvm.rst

The only things in the top level docs/ are a handful of
legacy-ish files that went there because we didn't yet have
a better place to put them. We should avoid increasing the
number of orphan files in the top level (and indeed should
try to move the existing orphans elsewhere).

>> When Peter's document PR goes in later this week there will also be a:
>>
>>   docs/system/target-arm.rst
>>
>> which would benefit from a section for the Orange Pi in it.

Yes, this is now the right place to put arm board-specific
documentation (the rearranging and conversion from texinfo
is now in master). I should move microvm.rst's contents there
I guess.

thanks
-- PMM

