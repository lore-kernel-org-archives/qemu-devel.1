Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA238C282DD
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 02:49:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A44D22177E
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 02:49:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r+oazMr8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A44D22177E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46468 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hU0GV-0008K7-OL
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 22:49:03 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1hU0Fg-0007z0-TN
	for qemu-devel@nongnu.org; Thu, 23 May 2019 22:48:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1hU0Fg-000234-1E
	for qemu-devel@nongnu.org; Thu, 23 May 2019 22:48:12 -0400
Received: from mail-it1-x130.google.com ([2607:f8b0:4864:20::130]:33110)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1hU0Ff-000222-RP; Thu, 23 May 2019 22:48:11 -0400
Received: by mail-it1-x130.google.com with SMTP id j17so9826609itk.0;
	Thu, 23 May 2019 19:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:content-transfer-encoding:mime-version:subject:message-id:date
	:cc:to; bh=wzPyWuEnJ4AV3dOBrZfUV4FnzdFXO8bkjuYbmFh8R2k=;
	b=r+oazMr8n4PItDOkmrH0Ftcnk5ZEIC1tYtUHRxaa14JaPgqGUdxJnhxd13eNGxgHy3
	2BH1PMrmNq9CanP/uHYdFH04kDZ/CimUfE1z8x3IMzn02hUIzUX8y274w1XyuCXFI49g
	26cI7QJRqO8SzN3x17qBxx+TNNub0OcRyAY4V7rmz0XZiwrudr5CYydwqrbs9wcwnt1v
	2u5+ZGCmpEbooxq5vjNabCGldvVMk0IvhlEvk1fC7wGJa//1A8oBicWizql8ZAu/yI8g
	GxZKjBAULARJsVlBSD/LAHVButsl6UDlQmzRBOTSuroAgQlAq1fSMCzwOrms3vWFS+SJ
	pgRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:content-transfer-encoding:mime-version
	:subject:message-id:date:cc:to;
	bh=wzPyWuEnJ4AV3dOBrZfUV4FnzdFXO8bkjuYbmFh8R2k=;
	b=obv/E4DbAESi+GCnH3K5RohrFXn2uU0JWnaFD+4Q2IA9vuORd7uJYTTuq4vll4BeBZ
	eFOgJCdulXHr3k5qEW46evh2NQpKmEivFlbgEfZ6HMZ86tVF2KS4ZnEbLdLKar0CRlR3
	8x00yAhbmHJNdxE3QGL0QREIRT9C4YgY/hLgjQL7tC27sX9wLehLpKANbL7TSTy4G7OC
	cctlv2nB3dPC2uCU40SrKfdUGEVwG8/PwS6gZ6pVbzXr0fpG5COqDbOmBzE+vhrlhIud
	/DT9AuuGCzX9CzKwIl0c2bd1ZCHItwXecOarm56nN2WnsvIkg0lPom52chzH4t0PA5SY
	Gy7w==
X-Gm-Message-State: APjAAAVbtov+InV2LqHPpVyHgAYWt28sXZ3zPcI+43tVe8sKa4W3lWAO
	as7eAoI8Gd6BgXGyWKtwQjNJnKvy
X-Google-Smtp-Source: APXvYqyleb/4isuhaVRLbymGogxkc6dFY5b3OIhaFECPFjUO6HliXHPUl6Zzlo6ktksL3zcNyN1fnQ==
X-Received: by 2002:a24:f9c3:: with SMTP id
	l186mr16613308ith.176.1558666090342; 
	Thu, 23 May 2019 19:48:10 -0700 (PDT)
Received: from [192.168.0.6] (d14-69-20-184.try.wideopenwest.com.
	[69.14.184.20])
	by smtp.gmail.com with ESMTPSA id t63sm646122ita.42.2019.05.23.19.48.09
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 23 May 2019 19:48:09 -0700 (PDT)
From: Programmingkid <programmingkidx@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Message-Id: <B954C7EE-DC27-433A-A271-D7ADF380550A@gmail.com>
Date: Thu, 23 May 2019 22:48:07 -0400
To: qemu Developers <qemu-devel@nongnu.org>,
 qemu-ppc <qemu-ppc@nongnu.org>
X-Mailer: Apple Mail (2.3273)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::130
Subject: [Qemu-devel] Patch causing qemu-system-ppc to crash
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: David Gibson <david@gibson.dropbear.id.au>,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Recently I have noticed that qemu-system-ppc is crashing while booting =
up my Mac OS X VM. A bit of git bisecting shows this is the patch that =
causes this issue:

commit 1e262b49b5331441f697461e4305fe06719758a7
Author: Richard Henderson <richard.henderson@linaro.org>
Date:   Mon Mar 18 12:02:54 2019 -0700

    tcg/i386: Implement tcg_out_dupm_vec
   =20
    At the same time, improve tcg_out_dupi_vec wrt broadcast
    from the constant pool.
   =20
    Signed-off-by: Richard Henderson <richard.henderson@linaro.org=

