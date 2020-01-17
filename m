Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37363C33CAF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 00:47:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0152A20748
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 00:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dD89FT5g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0152A20748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isFna-0003Bs-Va
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 19:47:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38404)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1isFmQ-0001rE-RJ
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 19:46:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1isFmP-0005zz-J1
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 19:46:30 -0500
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533]:42033)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1isFmP-0005zU-Bj
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 19:46:29 -0500
Received: by mail-pg1-x533.google.com with SMTP id s64so10769556pgb.9
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2020 16:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=xiFIm0ldyrjVNogQ3aHi2+1VAbwRXPGCKZqKhUePPa0=;
 b=dD89FT5gBSZGknnFbR4zz2L2bGSjGkekqwFwnRKTkpvBYBVZu/hgbezUclzeGYy5Cq
 PLBwq4CcDspSopeX42E/sIshG5QcHQyyLNFgUGyjPVFJugLNoVj8l9uH3pk+Zj10VR92
 S6lEcEapdQuRGZFejnI+lm+9mJKkIOxLKkumXBMx38gnl6i0SbuWqp8Wa2v7Z56fq+SM
 JvSKU5Yhx/J/cOpTbbWZwiG08kSdvpPAR9lfsUa1PFCT4RgRvQMp3eTpSdTqOc+E7OHT
 4JL6eZhIAAFqzk1DmuI3VPFIY/yqeAoMJtfsDLPB9XFqhSB6h8WIy3pgDSTQtgewCOz7
 6vUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=xiFIm0ldyrjVNogQ3aHi2+1VAbwRXPGCKZqKhUePPa0=;
 b=KGq9WE6vfSl5zyUxC9jWYgmUjiYZb8YwpVGg8t7Qk9eRFo4ERxOKnptB7+bq8g7Vk9
 r1J0rKP8GFXiD224thi5N3nIzvtKLzTcgQd8WGimwFQaNZlcQ2Ks8HccgSxkDvGcD/5R
 Q2MqxqGrkzxPUEzXfLnwm2DtEoDyVVXyoSmypzq/z96N1diNiWRYpsfZFOh4nzMKXKhW
 Wb6fC7tc0007awaO+I0qpbCb4haKww1eyuBkcuVQ6Zk1tEno+3GAd5JeIo6QfPoQE/B/
 G1488MoPC6U83aQCNhzvNxjWki4a/CBGjA/jhSF42xYFqFnI8YUw5ROwqrFRzan/1Bb1
 uOQw==
X-Gm-Message-State: APjAAAW9NgzIbIO4PRDCe9bfJ9u0RYfI9XkYDnDLDxkDsBiLKDcz4SN0
 FFIrXlLz0rXBosx1T1VDljVF5XI3Peo=
X-Google-Smtp-Source: APXvYqw7PlZqBuj/5BH3ZJautxITLJSft/mTyAUK9ClBrwLVHH9d0sq+Z1YN+H/LtyphpcOakAPgBQ==
X-Received: by 2002:a63:4664:: with SMTP id v36mr41838509pgk.147.1579221987376; 
 Thu, 16 Jan 2020 16:46:27 -0800 (PST)
Received: from localhost.localdomain (rrcs-66-91-136-155.west.biz.rr.com.
 [66.91.136.155])
 by smtp.gmail.com with ESMTPSA id 81sm27663582pfx.30.2020.01.16.16.46.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2020 16:46:26 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/2] target/arm: Fix ISSIs16Bit
Date: Thu, 16 Jan 2020 14:46:16 -1000
Message-Id: <20200117004618.2742-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::533
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org,
 jeff.kubascik@dornerworks.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Changes in v2:
  - Include the merge_syn_data_abort fix, as a self-contained patch.


r~


Jeff Kubascik (1):
  target/arm: Return correct IL bit in merge_syn_data_abort

Richard Henderson (1):
  target/arm: Set ISSIs16Bit in make_issinfo

 target/arm/tlb_helper.c | 2 +-
 target/arm/translate.c  | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

-- 
2.20.1


