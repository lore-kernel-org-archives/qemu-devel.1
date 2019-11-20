Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 392E3C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 02:27:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0211F222CD
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 02:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dhLrLZ4q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0211F222CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXFiB-0006T2-43
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 21:27:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58473)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iXFhT-00064a-3M
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 21:26:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iXFhQ-0004nz-Nv
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 21:26:34 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:33498)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iXFhQ-0004mz-IJ
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 21:26:32 -0500
Received: by mail-ot1-x342.google.com with SMTP id u13so19883762ote.0
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2019 18:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=WeTITXWdsgOsRRusmwAgaBUglFu9RBPE8O1qzSZTPBs=;
 b=dhLrLZ4q2wciMnxiy1PEmPLNbQUBuz93TVCFcCtrkM5zc6Pzw+rrp/YHHbXX6Nbbhj
 AENfLKwKXGIFw16bEAelUMaz8d+TP0RYeXaj+ZBwYCZ0GpHyIoVJTd07VFRBxQWk67Wz
 m3CPrL9gLKEftptlttz2KGhyALlDDU1cqjAz+wjLhYivfbpfxxmlSzuGFqy/xpPqVrZq
 Fq/eB0I2givWtfWrTK1aU9rANn5B2XFI0WSRXKkMFJwJiDn7uoHBTWOg5bpGH5Ycq+9E
 9K5WHw9nIi+93dgTrDx75uj2o0ic/BS+whN3xZl4YdG43SIGUiFgj0iLIFl2lnX8l24g
 pQSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=WeTITXWdsgOsRRusmwAgaBUglFu9RBPE8O1qzSZTPBs=;
 b=ng7ANeqdqlnV1A2S3wMf+hNAqlsFZnSgqH+iIN709L4gIB7pnWF7CTGkSJ7mysgeXJ
 OKDtoNmglCXGVFOX5qN3/ZprwOnxz+47ksKO23fN4k/yYUL8lNgC6u75rkcyUIjxGqwS
 u1N5ktricdUYfr4McwmYYjpbWQXW/m1+J5qz6WXLZ2b1kwxI6vlZeFc5lPg+YPg29N0K
 Li3Vo2VoTY+im94ryQ2AcQ6zTftEeRKq/tnR7FpFgeUt+pjyd4FUi38WfEcCpEt2MdUA
 5O4kWOLsVCuAV6XDOqrdBiHA8xW9i7r+1ArLvYgn1Y368oQ3OQGzZOgOO7x05dgCqn1N
 NW1Q==
X-Gm-Message-State: APjAAAW7SuFYn86xUUXNjkHRI9XP74lxfgL+w55lmQCdka7styZHh9Nq
 9nH6TEX37Yq4PZXMRmSltDQd689d/Q+MdIXQt6Q=
X-Google-Smtp-Source: APXvYqz21hMOocs0hqxPUAmC24fm5kdSazzoKH+ZYQsJ+6kcLK3pRAlXuwQoCaUIJKyIruVbukeuaIbFjrm6Xcqi+IM=
X-Received: by 2002:a05:6830:81:: with SMTP id a1mr123208oto.64.1574216791722; 
 Tue, 19 Nov 2019 18:26:31 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6830:1391:0:0:0:0 with HTTP; Tue, 19 Nov 2019 18:26:31
 -0800 (PST)
In-Reply-To: <82dfa44e-0a27-080e-2653-b004c27fc3d1@linaro.org>
References: <1574121497-2433-1-git-send-email-tsimpson@quicinc.com>
 <a77ce406-5307-cee8-8e0b-7c08056fb0df@redhat.com>
 <BYAPR02MB488666AA94EBB57C2A318004DE4C0@BYAPR02MB4886.namprd02.prod.outlook.com>
 <82dfa44e-0a27-080e-2653-b004c27fc3d1@linaro.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Wed, 20 Nov 2019 03:26:31 +0100
Message-ID: <CAL1e-=gmLywnyUoySxuDPS1FQRx=WiH1kYrqEJDGAAcO5vDg4A@mail.gmail.com>
Subject: Re: [PATCH] Add minimal Hexagon target - First in a series of patches
 - linux-user changes + linux-user/hexagon + skeleton of
 target/hexagon -
 Files in target/hexagon/imported are from another project and therefore do
 not conform to qemu coding standards
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000ab8f400597bde8bf"
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
Cc: Taylor Simpson <tsimpson@quicinc.com>,
 "riku.voipio@iki.fi" <riku.voipio@iki.fi>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 "laurent@vivier.eu" <laurent@vivier.eu>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000ab8f400597bde8bf
Content-Type: text/plain; charset="UTF-8"

On Tuesday, November 19, 2019, Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 11/19/19 6:22 PM, Taylor Simpson wrote:
> > - Laurent suggested I split the patch into two parts: linux-user and
> target/hexagon.  If I do that, which one should contain the changes to
> common files (e.g., configure)?  Also, note that we won't be able to build
> until both patches are merged.  Is that OK?
>
> The configure parts should be a third, last, patch.
>
> The series is bisectable, because before the configure patch,
> none of the hexagon code is compiled at all.
>
>
I don't think this is a good advice. Yes, at first glance, that would make
the submitter's job easier - since he could divide the whole code into
parts practicaly arbitrarily - but the resulting series will be of
suboptimal quality. If the submitter was forced from the outset to add
segments of his solution so that each step actually (not only ostensibly)
compiles, he would also be forced to organize patches in much more coherent
way, organize his code in much more modular way, possibly improve initial
organization, additionally making reviews much easier.

Aleksandar


>
> r~
>
>

--000000000000ab8f400597bde8bf
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Tuesday, November 19, 2019, Richard Henderson &lt;<a href=3D"mai=
lto:richard.henderson@linaro.org">richard.henderson@linaro.org</a>&gt; wrot=
e:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-l=
eft:1px #ccc solid;padding-left:1ex">On 11/19/19 6:22 PM, Taylor Simpson wr=
ote:<br>
&gt; - Laurent suggested I split the patch into two parts: linux-user and t=
arget/hexagon.=C2=A0 If I do that, which one should contain the changes to =
common files (e.g., configure)?=C2=A0 Also, note that we won&#39;t be able =
to build until both patches are merged.=C2=A0 Is that OK?<br>
<br>
The configure parts should be a third, last, patch.<br>
<br>
The series is bisectable, because before the configure patch,<br>
none of the hexagon code is compiled at all.<br>
<br></blockquote><div><br></div><div>I don&#39;t think this is a good advic=
e. Yes, at first glance, that would make the submitter&#39;s job easier - s=
ince he could divide the whole code into parts practicaly arbitrarily - but=
 the resulting series will be of suboptimal quality. If the submitter was f=
orced from the outset to add segments of his solution so that each step act=
ually (not only ostensibly) compiles, he would also be forced to organize p=
atches in much more coherent way, organize his code in much more modular wa=
y, possibly improve initial organization, additionally making reviews much =
easier.</div><div><br></div><div>Aleksandar</div><div>=C2=A0</div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc so=
lid;padding-left:1ex">
<br>
r~<br>
<br>
</blockquote>

--000000000000ab8f400597bde8bf--

