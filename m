Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3917C3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 12:27:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B955120856
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 12:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aluBQY7T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B955120856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2x2l-0007eU-Og
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 08:27:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47137)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i2wlR-0002GB-Sq
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 08:09:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i2wlQ-0004Cs-Rq
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 08:09:25 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:40165)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i2wlQ-0004CZ-MR
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 08:09:24 -0400
Received: by mail-wm1-x342.google.com with SMTP id t9so1443056wmi.5
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2019 05:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=XcTHFRC9i2WFejx4BecSd/XK7WjxEFySMuLBYAt9kJQ=;
 b=aluBQY7Tn7B3/AM+mWKCSjt2exv75JGoipB3JPHQjZ3hesFr/ul+S39l5Gt3CCtuk/
 Vh6AZHWSlIaBRdq8ltml33gdXocJS38oCaANe7TKAo5qaSP7FOP7Kwh8tI+Xs1laVvIE
 n5sbJxXPgbrp4fK6PJYsf/k3S/vxKjKHBowoL8DIwu3E6STmhwYJNSP20rxlr5cuYTZg
 Jf1h00uVYvUp3icNBxmHlREIFfv4z70CeiMypOHp9E0bm3TxDGbMgo8Q76AU3kAMPPiX
 3Bur6c1IJeH2GOVYFLv54L2TG79deaUIfWsgXNOqo1/MN5lUq86/i9zwO/UhslNh0ctA
 C+GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=XcTHFRC9i2WFejx4BecSd/XK7WjxEFySMuLBYAt9kJQ=;
 b=X5l5Hz6FkFEyvJYYWvrLiUmSHhCckuVHOruYwQbHJ/dayi/FCdPxtmrgicsmygmGbF
 JpWzQ73seoJnaK8OctQ6sINNBI6w14G51adF4K5Ge7bvLbwhvWX15djCRIPcsPY2fPEa
 1za3eQThL6HhoD73E569QLxd9ltVch9ehQzydr1uhF7FWYmjT/n3xVLaWgH5axXAhnHD
 Q/kTIRWeZuxtlip7MH03sCxyJAg8mXI28tf/Ov8+GU1LSxnbFpsfTKsJbl/x+cNJKdSW
 UvSh4F74Lj9N11gPOTU/LJbJ6GcmaUx3i/ycbX+GzVJLz2+prTh5sMMCI+UcmlvCDfCd
 ftbA==
X-Gm-Message-State: APjAAAVISnds2H4bsU0cZGotOGboI9ElIZhVrid18fwT1Fp1gADaiT2r
 ohMbAfq2s0tgK7F+nPLP51fl5fWymnA=
X-Google-Smtp-Source: APXvYqyMrRk2zZBZdgo9t/wSL1hZOYfnJzGNSMxVeDvv6grZSTc//2T0H6+rRuicmLP8UHTLFltyjA==
X-Received: by 2002:a05:600c:21c1:: with SMTP id
 x1mr4235249wmj.37.1566994163433; 
 Wed, 28 Aug 2019 05:09:23 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id i5sm2902547wrn.48.2019.08.28.05.09.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2019 05:09:22 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D9EC31FF87;
 Wed, 28 Aug 2019 13:09:21 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 28 Aug 2019 13:09:13 +0100
Message-Id: <20190828120921.9586-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [PATCH  v1 0/8] various gitdm and mailmap updates
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

With another release out of the door and KVM Forum approaching it is a
good time to clean up our gitdm stats. As usual updates for academic
institutions and individual contributors involve a bit of guess work
so I have CC'd those affected for their confirmation. There is also a
large amount of verbiage added to the mailmap and aliases files to
(hopefully) better explain what they are trying to do.

Alex Bennée (3):
  .mailmap/aliases: add some further commentary
  contrib/gitdm: add RT-RK to domain-map
  contrib/gitdm: add more entries individuals and academics

Markus Armbruster (2):
  contrib/gitdm: filetype interface is not in order, fix
  contrib/gitdm: Add armbru@pond.sub.org to group-map-redhat

Philippe Mathieu-Daudé (3):
  mailmap: Reorder by sections
  mailmap: Update philmd email address
  mailmap: Add many entries to improve 'git shortlog' statistics

 .mailmap                            | 137 ++++++++++++++++++++++++++--
 contrib/gitdm/aliases               |  20 +++-
 contrib/gitdm/domain-map            |   1 +
 contrib/gitdm/filetypes.txt         |   2 +-
 contrib/gitdm/group-map-academics   |   3 +
 contrib/gitdm/group-map-individuals |   7 +-
 contrib/gitdm/group-map-redhat      |   1 +
 7 files changed, 159 insertions(+), 12 deletions(-)

-- 
2.20.1


