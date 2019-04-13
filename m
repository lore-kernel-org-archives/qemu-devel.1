Return-Path: <SRS0=HErD=SP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D63A1C10F0E
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2019 01:15:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91BF62084E
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2019 01:15:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EDgGig90"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91BF62084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44989 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hF7Gr-00016q-Ar
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 21:15:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36689)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jbi.octave@gmail.com>) id 1hF7Ew-0008Rc-8R
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 21:13:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jbi.octave@gmail.com>) id 1hF7Eu-0000hY-Al
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 21:13:54 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:33461)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jbi.octave@gmail.com>)
	id 1hF7Es-0000fp-B7
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 21:13:51 -0400
Received: by mail-wr1-x444.google.com with SMTP id q1so14160548wrp.0
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 18:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=bdcWQRWxDRCqwpDIYam/k2kUcLVlAShN7bAM4JCxTWM=;
	b=EDgGig90Oew4/0KzyaxpFrD8m/hAd/z1L0nyHFW0NQAkf2yqSzNvM2DxiwXplrVm82
	TYAgbUn5dG9GKKq+tvO+VVhJOTVmehewHQLImACIfz4RE1SZri2xTt5Mioe79vY+SBfa
	N577qr/+LhiNSPfKRrcgMQrLgWKchylTgzEMXRSbUiocAlzN9I5+ykCm3oUn4VMqOCOi
	7io6ocwjE8u1Vxnb0sFVxgoLGSD3zbUL+dftgy5+XG1P6ilGZPmDLrhnbbRhWJ0Ghqay
	hwkNQSUSWLfdA7OJtayrTs+8N5Y8xLf0/snoSh3qUUcWgNu6HHK66tiVlyebU4I6907C
	DzDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=bdcWQRWxDRCqwpDIYam/k2kUcLVlAShN7bAM4JCxTWM=;
	b=WDBWrjTQMrtPnDKlo0BV8OtG3AcnvCDDigSQirZMQKsVtTNbcYLUqQke3BsA/5pJog
	ETjH0jMl0iqmts4tnQgwh75I9zRW2TKQjvX+ISb5LJ5K0gwyJD0twLCy25a/Z3BjnI96
	ZcnRNkaR/q0TA2P4N+2eZWpUvhbfaPTkptU7VXZDg0L0XJwpdfI/GHtEUHGwUXyMQAR3
	ZN/gfZWBOku9eT2DVQVguKzT1cYh+/+OI8NDAPQS925Az1PH7hDSPpvW67jrNzVtgcqo
	XNu+TN2Kyf1CQL+gtqoiHo//Wq/T0NhDlcD6n1k5xdLNQEZzEaI+H5BW0sjCftuR2l7y
	ufGg==
X-Gm-Message-State: APjAAAXTDkhTjGMUxoWXJ/PMzCyIuKLN5wD1nyd8xelHt59R4q43ncoG
	0rIomCUJCPsZ9vILbj79XJ8kw409Rk3h
X-Google-Smtp-Source: APXvYqywlyNoNqwCZmcH7DqcXiNiNQqZKXJPn5rokWtGuOnollOJtMxStByZDobpfzEHdNcgIju6Eg==
X-Received: by 2002:a5d:638d:: with SMTP id p13mr35981109wru.202.1555118026928;
	Fri, 12 Apr 2019 18:13:46 -0700 (PDT)
Received: from ninjahub.lan (host-2-103-80-5.as13285.net. [2.103.80.5])
	by smtp.gmail.com with ESMTPSA id
	g13sm7398293wmh.11.2019.04.12.18.13.46
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 12 Apr 2019 18:13:46 -0700 (PDT)
From: Jules Irenge <jbi.octave@gmail.com>
To: qemu-devel@nongnu.org
Date: Sat, 13 Apr 2019 02:12:59 +0100
Message-Id: <20190413011302.6610-1-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PATCH v4 0/3] target/mips: Errors and warnings cleanup
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
Cc: arikalo@wavecomp.com, Jules Irenge <jbi.octave@gmail.com>,
	aurelien@aurel32.net, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190413011259.MV3m1S3g7fPrRGAcPbfJxAYJXUvDW1PwXlS2w4oYLsM@z>

This v4 series combines two previously distinct patches into one patch
replace tab code indent patch and the add or rmove space into 
one patch add or remove space patch.

Jules Irenge (3):
  target/mips: add or remove space to fix checkpatch errors
  target/mips: realign comments to fix checkpatch warnings
  target/mips: wrap lines to fix checkpatch errors

 target/mips/cpu.h | 211 +++++++++++++++++++++++++---------------------
 1 file changed, 117 insertions(+), 94 deletions(-)

-- 
2.20.1


