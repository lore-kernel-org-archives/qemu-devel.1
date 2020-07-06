Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE884C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 10:25:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A84E720739
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 10:25:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=cam.ac.uk header.i=@cam.ac.uk header.b="QwLS5Mh8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A84E720739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cl.cam.ac.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsOJ8-0005UY-LC
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 06:25:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58272)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alr48@hermes.cam.ac.uk>)
 id 1jsOHN-0003O5-Qe; Mon, 06 Jul 2020 06:23:17 -0400
Received: from ppsw-32.csi.cam.ac.uk ([131.111.8.132]:37740)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alr48@hermes.cam.ac.uk>)
 id 1jsOHL-00073c-26; Mon, 06 Jul 2020 06:23:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cam.ac.uk; 
 s=20180806.ppsw;
 h=Sender:Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CV14eKLNAeAzlJkwjnWkbyhiRKz8m9XvLDvFxgC1l98=; b=QwLS5Mh87UKJ7BAEKqcLgPxKyM
 O0YUcZVSFtkAU+wvikQrL2WEUHwU+KcTIkmFQr2DuUKSLNDDQOjbim4FJK5RHIpRzBw6f8Eb48aTr
 ywH1+JvcqH+GoOKqMAY7Dlqqnky+mIT1P0IM60j2t+Sa2If02QzJlmPIyf4uorHZJFR4=;
X-Cam-AntiVirus: no malware found
X-Cam-ScannerInfo: http://help.uis.cam.ac.uk/email-scanner-virus
Received: from mail-io1-f41.google.com ([209.85.166.41]:36110)
 by ppsw-32.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.156]:587)
 with esmtpsa (PLAIN:alr48) (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
 id 1jsOHF-000F7J-35 (Exim 4.94)
 (return-path <alr48@hermes.cam.ac.uk>); Mon, 06 Jul 2020 11:23:10 +0100
Received: by mail-io1-f41.google.com with SMTP id y2so38749522ioy.3;
 Mon, 06 Jul 2020 03:23:09 -0700 (PDT)
X-Gm-Message-State: AOAM530Dr4jtze/PORklJOEh3+olUSMGiPrpnyM/xHE0JRI70YUbg++I
 JdV3Oy/GVa73mJ7GUgfJYNjEPNJoGGma0M6InPk=
X-Google-Smtp-Source: ABdhPJwiCTOCipz0b/eeOxADDgjJiu37q8JnZVwmCTdKGpiauFCW9uDp+r1ODGUiBE8Yl1Hp/oNiYxv6tVHJybP5D9I=
X-Received: by 2002:a5e:cb42:: with SMTP id h2mr24283572iok.43.1594030988870; 
 Mon, 06 Jul 2020 03:23:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200703161515.25966-1-Alexander.Richardson@cl.cam.ac.uk>
 <013da4b5-be9e-aeae-5e88-82188a26d4bf@amsat.org>
In-Reply-To: <013da4b5-be9e-aeae-5e88-82188a26d4bf@amsat.org>
From: Alexander Richardson <Alexander.Richardson@cl.cam.ac.uk>
Date: Mon, 6 Jul 2020 11:22:51 +0100
X-Gmail-Original-Message-ID: <CAEeofcjJjAffMTg+cj5Y+HUZ9+bfkKMtKQRXMdk6FQgm-45KWQ@mail.gmail.com>
Message-ID: <CAEeofcjJjAffMTg+cj5Y+HUZ9+bfkKMtKQRXMdk6FQgm-45KWQ@mail.gmail.com>
Subject: Re: [PATCH] Fix MIPS add.s after
 1ace099f2acb952eaaef0ba7725879949a7e4406
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=131.111.8.132;
 envelope-from=alr48@hermes.cam.ac.uk; helo=ppsw-32.csi.cam.ac.uk
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 06:23:10
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -52
X-Spam_score: -5.3
X-Spam_bar: -----
X-Spam_report: (-5.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: qemu-trivial@nongnu.org,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Philippe,

On Fri, 3 Jul 2020 at 19:40, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =
wrote:
>
> Hi Alex,
>
> On 7/3/20 6:15 PM, Alex Richardson wrote:
> > After merging latest QEMU upstream into our CHERI fork, I noticed that
> > some of the FPU tests in our MIPS baremetal testsuite
>
> I understand by baremetal your soft core implementation running on
> a FPGA, right?
>
By baremetal I mean small test binaries running without a host OS.
The test suite was originally written for the CHERI FPGAs, but it also
supports various MIPS simulators, our executable formal model written
in sail and our fork of QEMU (https://github.com/CTSRD-CHERI/qemu).
Unfortunately it cannot be run with upstream QEMU as it requires a
special MTC0 instruction to dump register values in a textual format
to the logfile.

> > (https://github.com/CTSRD-CHERI/cheritest) started failing. It turns ou=
t
> > this commit accidentally changed add.s into a subtract.
>
> Fixes: 1ace099f2a ("target/mips: fpu: Demacro ADD.<D|S|PS>")
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>
> Thanks for your quick fix!
>
> Phil.
>
> > Signed-off-by: Alex Richardson <Alexander.Richardson@cl.cam.ac.uk>
> > ---
> >  target/mips/fpu_helper.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/target/mips/fpu_helper.c b/target/mips/fpu_helper.c
> > index 7a3a61cab3..56beda49d8 100644
> > --- a/target/mips/fpu_helper.c
> > +++ b/target/mips/fpu_helper.c
> > @@ -1221,7 +1221,7 @@ uint32_t helper_float_add_s(CPUMIPSState *env,
> >  {
> >      uint32_t wt2;
> >
> > -    wt2 =3D float32_sub(fst0, fst1, &env->active_fpu.fp_status);
> > +    wt2 =3D float32_add(fst0, fst1, &env->active_fpu.fp_status);
> >      update_fcr31(env, GETPC());
> >      return wt2;
> >  }
> >
>

