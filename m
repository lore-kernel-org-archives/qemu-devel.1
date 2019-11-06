Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 862FDC5DF62
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 11:51:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4926D2173E
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 11:51:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p2aRHxCL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4926D2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSJqg-0008LM-3P
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 06:51:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43151)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iSJng-0005Eo-NP
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 06:48:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iSJnf-0000Sq-Br
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 06:48:36 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:45336)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iSJnf-0000SZ-3S
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 06:48:35 -0500
Received: by mail-wr1-x443.google.com with SMTP id q13so25396706wrs.12
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2019 03:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=TLarDIijmpBjLdygBTLpnER/Gx2aEyb/IRnKgHGgsSs=;
 b=p2aRHxCLIQ/beSQLBsLamzvrUkWJd0EYQqBCsMxNTm8EcqeKtkWTZf7cxJg4iRIbPZ
 wOOm3Q2Akk51jLl9D11mcyBZ9iSKQ38mLWKg0vtDhImsYqivV9sAO6Nni/pmLDpHuhCD
 eHqliOlm4A+TvOl1Vh1oNzLH4TqopZyFrXHWYVyfrMqz9bkMECLl0tv37XSlvRzpc6nj
 2Hy5TAaB59Szd3Jlwx9r7b+PkLmy4UBz8gW0PrATTOVQnO/jGxLZ4VnQHKOkbpTfdpT8
 ZLMRmg/MyzIACdhRr6hfOT4jXFMlkpgsP02i0bot3IhHPK3OVG5f0SMIXSDu73uUlagW
 NoIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=TLarDIijmpBjLdygBTLpnER/Gx2aEyb/IRnKgHGgsSs=;
 b=PtJOW8FYa9F12vO/E59sO4PKyrt54l5EXNf02jBs19i6KMvwT9HiEl+1EaExkLFU42
 kDBoAmcTxyoWPC3L9OJfEZXS4v1T2Y2SYWskAuX10zlhzG7EaeE56eiYBEN7SQsim5X4
 QzBE/TRhB/u7H7srwWjP3LtWjGetpRzJumu55iuhfd2fSzq6RAuHuyL/twefTQoQnNdZ
 xShxHX8VrH9icGYUsKgCM8EyVDYcFxMH0A2vli8ZLUiH71Z7zXMC8iz7A348mXv3xmF+
 OtTCHiTYD92gDJQhsqU3irILV9lX4QaHAxbAigif2CiSNyZ+FZwNNw7U7qlQALhn3ZGg
 AIlw==
X-Gm-Message-State: APjAAAVhXC882oupu/TtyJKAjYvsXL031SmBY3ddAhUcrlnk9/Mq1Zwo
 QnEiuU1liB0AdQ0NvX2g4h3VCQ==
X-Google-Smtp-Source: APXvYqyABjp71MPJENd3D5hA9JQplTR+oSuOy0R+WIw751nLbhWkEp2vcXyZsJB6B2/IE2tIe2aSYg==
X-Received: by 2002:a5d:570a:: with SMTP id a10mr2190144wrv.107.1573040913688; 
 Wed, 06 Nov 2019 03:48:33 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id y8sm2114535wmi.9.2019.11.06.03.48.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2019 03:48:32 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A4BCA1FF87;
 Wed,  6 Nov 2019 11:48:31 +0000 (GMT)
References: <20191025203427.20181-1-ehabkost@redhat.com>
 <CAFEAcA-F0iB2vzi3Z0J9FPAt6JpuMh+V0wsfXWLuAGX5_d69xw@mail.gmail.com>
 <20191105195748.GG3812@habkost.net> <87y2wuhy00.fsf@linaro.org>
 <20191106103633.GE91675@redhat.com>
 <CAFEAcA9LqhboQH5_NAJF5XbE+PbX16dYuRd60Tz_R_Y215QhMw@mail.gmail.com>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 0/1] Require Python >= 3.5 to build QEMU
In-reply-to: <CAFEAcA9LqhboQH5_NAJF5XbE+PbX16dYuRd60Tz_R_Y215QhMw@mail.gmail.com>
Date: Wed, 06 Nov 2019 11:48:31 +0000
Message-ID: <87v9rxi5tc.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 Ed Maste <emaste@freebsd.org>, Eduardo Habkost <ehabkost@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Cleber Rosa <crosa@redhat.com>,
 =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On Wed, 6 Nov 2019 at 10:36, Daniel P. Berrang=C3=A9 <berrange@redhat.com=
> wrote:
>> At what point do we declare that NetBSD CI is broken and is no longer
>> considered a supported platform from POV of blocking the merging of
>> PULL requests ? It has been preventing the dropping of python2 for
>> quite a while now. It isn't the end of the world in this particular
>> case, as dropping py2 is mostly just a cleanup, but I feel like we
>> might benefit from setting expectations for ongoing platform maintenance,
>> otherwise these kind of issues could drag on indefinitely.
>
> It works fine for me, and it means we have coverage of a host
> OS we otherwise would not. To me that is definitely more important
> than being able to drop Python 2 support. Also, AIUI the problem
> that's blocking updating the NetBSD image isn't related to
> NetBSD at all but is a bug in some combination of QEMU itself
> and our test framework

These have been addressed in:

  Subject: [PATCH  v1 0/6] testing/next (netbsd stuff)
  Date: Mon,  4 Nov 2019 17:36:48 +0000
  Message-Id: <20191104173654.30125-1-alex.bennee@linaro.org>

but I have a non-trivial failure rate running tests (~20% of runs fail)

> -- both of those are things we need to
> fix anyway.
>
> thanks
> -- PMM


--
Alex Benn=C3=A9e

