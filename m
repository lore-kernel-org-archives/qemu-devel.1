Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF00C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 23:21:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDF2F20663
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 23:21:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OzbzQiq3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDF2F20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDz32-0003by-4H
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 19:21:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39066)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <npiggin@gmail.com>) id 1jDz2F-00036S-ST
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 19:20:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <npiggin@gmail.com>) id 1jDz2D-0007sF-Tq
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 19:20:39 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:35370)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <npiggin@gmail.com>)
 id 1jDz2B-0007XF-AA; Mon, 16 Mar 2020 19:20:35 -0400
Received: by mail-pj1-x1043.google.com with SMTP id mq3so9503812pjb.0;
 Mon, 16 Mar 2020 16:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :user-agent:message-id:content-transfer-encoding;
 bh=RxitBX2wmDaqOJMkoLn0PDjoYn/6B9kD7YTS9J4vrDE=;
 b=OzbzQiq3WeMgf4ywHdIYG2bNcEE3uD+0FQOu/RSNWQ9d9f/xCGcMzpHuOyznJ5UcPX
 HrtF5nadvIkQI2m6JiI2qJG6owhayScls0QVU0k0SUuLXoE46hC4SG+qMzUorVqjt6LB
 vQ9PYMNKWTEZ9hj2KQsJIZr2M1Y3vnxasarpI+VnV93cgPPfAvDD/smvblQuhkBo/Y/K
 bgWIUbatLu5+aydnHaITs6mf6eT5v5zCjISfJzj25w5YcryoHogVoBboEh56ms8yG4aA
 M/S2BQ7RW08bP6u/rR88cigEeGcGcFtvftrwrg1bs9VuX2dQV/JeXy2VDG3z3Wy4O1zq
 UWXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:user-agent:message-id:content-transfer-encoding;
 bh=RxitBX2wmDaqOJMkoLn0PDjoYn/6B9kD7YTS9J4vrDE=;
 b=dUKmdSrIohOyHCRX62oHU84y282GwBTarUxw4qmqP2iEymiYovep7SSuanCppCObTR
 gUysjDQS+GSuRL7bk/9fsy/TRMOiVIaf/GfLOERRtHq/8MZEOZsKg/7ZCSeF5HY1EU40
 CrmbITNokATYedmrfHIJ8YQCwyco+yHIVZQy+28/fckdKE/7FqJ6fsxR1XkKG0oaETWK
 vMtkaH4deJIXBOj7bezH9h+5hsOi8ODR3dehBobLyqM46WEYEXWY23hWeCbfH85RaYqc
 /vc8CLj+A6+dPZ4ThF99bDr01S/QDfiNkfWbRNIDRfK6tdkWm+VmDroQdd0EScbyVxvA
 0m6A==
X-Gm-Message-State: ANhLgQ0ykaXbJmQTYL3X3UGsWC5T0lSc57GGZQ051Ygajbq/tJ+ZMTl8
 6iVgDMgygqiWLPgBH7AA830=
X-Google-Smtp-Source: ADFU+vtYzU5Q7ItXP8WZghzrOjg4+or4ycrXP4SPAJ+t3wAQGcuzXSEMT+j57OpbhzQdp7D7E+zy9g==
X-Received: by 2002:a17:90b:238e:: with SMTP id
 mr14mr2024552pjb.146.1584400834105; 
 Mon, 16 Mar 2020 16:20:34 -0700 (PDT)
Received: from localhost (203-213-47-190.tpgi.com.au. [203.213.47.190])
 by smtp.gmail.com with ESMTPSA id b9sm509385pgi.75.2020.03.16.16.20.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 16:20:33 -0700 (PDT)
Date: Tue, 17 Mar 2020 09:19:57 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 4/8] ppc/spapr: Fix FWNMI machine check interrupt
 delivery
To: =?iso-8859-1?q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-ppc@nongnu.org
References: <20200316142613.121089-1-npiggin@gmail.com>
 <20200316142613.121089-5-npiggin@gmail.com>
 <2ff9bfbf-5a6a-2a79-e14e-4b7c76aff062@kaod.org>
In-Reply-To: <2ff9bfbf-5a6a-2a79-e14e-4b7c76aff062@kaod.org>
MIME-Version: 1.0
User-Agent: astroid/0.15.0 (https://github.com/astroidmail/astroid)
Message-Id: <1584400226.tr4pv2h852.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1043
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
Cc: Aravinda Prasad <arawinda.p@gmail.com>, qemu-devel@nongnu.org,
 Ganesh Goudar <ganeshgr@linux.ibm.com>, Greg Kurz <groug@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

C=C3=A9dric Le Goater's on March 17, 2020 3:59 am:
> On 3/16/20 3:26 PM, Nicholas Piggin wrote:
>> FWNMI machine check delivery misses a few things that will make it fail
>> with TCG at least (which we would like to allow in future to improve
>> testing).
>=20
> I don't understand which issues are addressed in the patch.

The existing code does not compute hflags, at least.

There's a few possible other things, I didn't dig into qemu enough
to know if they might be a problem (e.g., reservation and TLB). I
figure it's better to keep these consistent.

Keep in mind this is a bit academic right now, because we can't
(AFAIKS) inject an MCE from TCG. It would be good to wire that up,
but I didn't get to it.

>> It's not nice to scatter interrupt delivery logic around the tree, so
>> move it to excp_helper.c and share code where possible.
>=20
> It looks correct but this is touching the ugliest routine in the QEMU=20
> PPC universe. I would split the patch in two to introduce the helper
> powerpc_set_excp_state().
>=20
> It does not seem to need to be an inline also.

Yeah it's all pretty ugly. I didn't yet find a nice way to do
split things up that did not require a lot of code churn, but that
can come later.

Inline was just because powerpc_excp is inline, I didn't want to
change behaviour too much there (it obviously wants to do a lot of
constant propagation but maybe only on the case statement). Anyway
I just wanted to be minimal for now, it could be changed.

Thanks,
Nick

=

