Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C847C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 11:55:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47BEC22482
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 11:55:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AHgz42T+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47BEC22482
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxqrn-0002sC-Jy
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 07:55:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51786)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jxqr9-0002Qn-34
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 07:54:47 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:36005)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jxqr6-0006pK-Vh
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 07:54:46 -0400
Received: by mail-wr1-x430.google.com with SMTP id 88so10633741wrh.3
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2020 04:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=w6X2yUdmxT1tqAPVc91KtLNDzOPPe/C1KWZ8Fl9k/98=;
 b=AHgz42T+/QvwxWdDUdz9m1BtICuOAM2f2oO3yW405nv+I9cbx20vu6F3/AYaqLYwmw
 bSd5cdZ7VK2+7p7iZDMSv5vo33/T3Tg+whok8CTfZ0p5/smlIwTguKL/8DwobFDbB9HW
 l0NFUCrFwdCtTp2GhN52Fx27ctGRQRciVvBJy70U3O2ZyziDITYU+6/KYKBJ4QjSuYMx
 +MtqvMcHNfp6YumJsoxBbjGVetH9YZleEcdq7J1r0s0a35tOxvHo3P6PLFwNS8blkfCx
 eeTrNngGlfedsEpqE7PuXYId/MjFGnn27+1Nspnp7JBt+RcOcDttSSRWoo2Ih4LAwMg/
 5mYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=w6X2yUdmxT1tqAPVc91KtLNDzOPPe/C1KWZ8Fl9k/98=;
 b=s8TzLoVY2JATufyTWqhvJ2lD6baR9bcftbHrHH8z7YV4dZ7l7/DsX9hHChgp46Lh7E
 P6XWB2uFPuS5+kGkCMW+LNZ0L7ALLSAX87wRk7QzBqVJDSFAzvLOJ2D32v6wgNn6jmDk
 /uVJiJx/fIPZQPAQdjj2Dywtpyx7Umnh7CeR6EXiIDDi6DopUMIMvZ5D3XwLXwPEin0D
 /tQeyBiroc+hiMNrCZR8EHJ/60CgiNQg5b3Xer0+iYJ1HLGlC6qhW5wqWUZdRv/kDBCs
 auL2CmZiRbQZ3AI57na2CylsbfVufJ61P07sVqe1QojlJJ2JLNULV2NkiUSqabc5aLOt
 IxvA==
X-Gm-Message-State: AOAM5333yQOdGjIwI8u2l0QgfVzfBvuvNaEho7N2tXJoUM0q1SVNotoK
 qdvfSNWsd/8GrBtmdkNXLCRQmw==
X-Google-Smtp-Source: ABdhPJz1WtwWHEziD1QGlx+f8AhlF45hUzOfj8rz9TBAlvtvQlHIpGBcSOiEBqv4Dr2uJOsa1IFqHw==
X-Received: by 2002:adf:c981:: with SMTP id f1mr5198164wrh.14.1595332483145;
 Tue, 21 Jul 2020 04:54:43 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id j145sm3452029wmj.7.2020.07.21.04.54.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2020 04:54:41 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3724C1FF7E;
 Tue, 21 Jul 2020 12:54:41 +0100 (BST)
References: <CALTWKrVvaA7HWxsHNS+tCygLu+x4FCjSZn=+AP0hnEWOCp8vww@mail.gmail.com>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
Subject: Re: [REPORT] [GSoC - TCG Continuous Benchmarking] [#5] Finding
 Commits Affecting QEMU Performance
In-reply-to: <CALTWKrVvaA7HWxsHNS+tCygLu+x4FCjSZn=+AP0hnEWOCp8vww@mail.gmail.com>
Date: Tue, 21 Jul 2020 12:54:41 +0100
Message-ID: <87y2ndulq6.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x430.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>, luoyonggang@gmail.com,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Ahmed Karaman <ahmedkhaledkaraman@gmail.com> writes:

> Hi,
>
> The fifth report of the TCG Continuous Benchmarking project concludes
> a mini-series of three reports that dealt with the performance
> comparison and analysis of QEMU 5.0 and 5.1-pre-soft-freeze.
>
> The report presents a new Python script that utilizes "git bisect" for
> running a binary search within a specified range of commits to
> automatically detect the commit causing a performance improvement or
> degradation.

Excellent stuff.

> The new script is then used to find the commit introducing the PowerPC
> performance degradation as well as that introducing the performance
> improvement in MIPS. The results obtained for both commits proves the
> correctness of the conclusions and analyses presented in the two
> previous reports.

I can certainly envision a mechanism where 0673ec slows things down. I
wonder if it would come back if instead of inline function calls we
ended up making concrete flattend versions, e.g.:

bool QEMU_FLATTEN float64_eq(float64 a, float64 b, float_status *s)
{
    return float64_compare(a, b, s) =3D=3D float_relation_equal;
}

PPC is of course more affected by these changes than others because
HARDFLOAT never gets a chance to kick in. Looking at the objdump of
f64_compare there should surely be an opportunity to loose some of the
branches when looking for a certain test result?

>
> Report link:
> https://ahmedkrmn.github.io/TCG-Continuous-Benchmarking/Finding-Commits-A=
ffecting-QEMU-Performance/
>
> Previous reports:
> Report 1 - Measuring Basic Performance Metrics of QEMU:
> https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg06692.html
> Report 2 - Dissecting QEMU Into Three Main Parts:
> https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg09441.html
> Report 3 - QEMU 5.0 and 5.1-pre-soft-freeze Dissect Comparison:
> https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg01978.html
> Report 4 - Listing QEMU Helpers and Function Callees:
> https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg04227.html
>
> Best regards,
> Ahmed Karaman


--=20
Alex Benn=C3=A9e

