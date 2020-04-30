Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF36C83003
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 02:06:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 424FA208E0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 02:06:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OUmd3//9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 424FA208E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTyae-0000JE-BQ
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 22:06:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37300)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jTyYt-0006yJ-DH
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 22:04:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jTyXc-0004j3-Pr
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 22:04:27 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035]:54183)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jTyXc-0004io-8n
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 22:03:08 -0400
Received: by mail-pj1-x1035.google.com with SMTP id hi11so58504pjb.3
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2020 19:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=YBh1WI1a1TP6+dKybZ3Tp11UoKtEzApwzqoS5j2+O2k=;
 b=OUmd3//9MC9DA8Jh4G0OIkUwjTLaPqpx+QnUmGOu52jnebDvr0Wa3SDzK0t5SPehqe
 KXT4ltCSVXx7PT99xmxyMQdfluIbmYOZgJYxSEJS+c8e9pOdTmXRdCafVsquPC4C75J1
 p0F2/tmj2tJu9oJHfnGLMV8nazg6RNLrrDHu7DZ2CCVMUp6zHnFU3Mw2oVqiK/EDuC67
 oFube606YTzgprGPPsbU2jOJtK7QTQaWWRu8FJsvZzcsGEpfmcZzgEInER9lxn3wx3RP
 wG2Z0g07Ouq0bKM8DD0xEZL8PnUYiqe1i9ppU45CxQmiCWR/Lcxd9l9m7iaS3KcgECZ5
 xlRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=YBh1WI1a1TP6+dKybZ3Tp11UoKtEzApwzqoS5j2+O2k=;
 b=pTwHR8AaRieH0EezCJ5vyHBi9iBBKKlGqhVEx1r9++rkgA+/w8z2h7DW/NMtGUOygG
 RmYVjWUGSwsxKGx+dB3yRacYBVZUEV60fQ7Y2Qn4+4GnrfO7sGik8a0rMN/eX5S0tvbz
 MEbivZHdQVQK8OBso6t9F+jxqtaANPyHAGp+YV3tzgUdGnmZgeS+wiqMStHzULrLZaew
 UJYjF/mmae3LkopcxehgQ/sHEmsekDKisyDw7kOCldUYBDe+UMMdGQuiGUpYxNOFRdug
 wvknfQTV9dSvQLj/a0v/w6hqq10gtFOyNdo1rvto7pOoZ/nVZMFoSYLkU+O1ukdjtLOq
 1mrQ==
X-Gm-Message-State: AGi0PuYdv/MkeTIpNpt5R5rdEBmU4dJgYbSDKZ5Us85DEDnkg4Asq9bi
 iuK5QBSMa16iKMO8TcFlJU46XF8qv84=
X-Google-Smtp-Source: APiQypIz5Kf3RkBIstoXEz/TyE7rqBomUxs77aPp/PC/A79AQxBSanhoJyBMNZWQ+wHYknawAvop6w==
X-Received: by 2002:a17:902:a405:: with SMTP id
 p5mr1437161plq.36.1588212185207; 
 Wed, 29 Apr 2020 19:03:05 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id y3sm409284pjb.41.2020.04.29.19.03.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2020 19:03:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 0/9] target/arm: Implement SVE2 Crypto Extensions
Date: Wed, 29 Apr 2020 19:02:54 -0700
Message-Id: <20200430020303.20264-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::1035
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
Cc: steplong@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Stephen, what I was looking for when I talked about modifying
the existing helpers is patch 1, which simplifies the final 3
patches for the new SVE2 insns.

In the process I found that the existing implementation of the
AdvSIMD insns is buggy wrt SVE.  We need to clear the bits in
the Zreg destination beyond the first 128.

I could have done this via clear_vec_high in translate-a64.c,
but since we already have a function call, we're better off
doing the clearing out of line.  This means adding a desc
parameter so that we know the total vector length.


r~


Based-on: https://github.com/rth7680/qemu/commit/8c3a91e4e487ef840193a489e5457165530666fc

Richard Henderson (9):
  target/arm: Convert aes and sm4 to gvec helpers
  target/arm: Convert rax1 to gvec helpers
  target/arm: Convert sha512 and sm3 to gvec helpers
  target/arm: Convert sha1 and sha256 to gvec helpers
  target/arm: Split helper_crypto_sha1_3reg
  target/arm: Split helper_crypto_sm3tt
  target/arm: Implement SVE2 crypto unary operations
  target/arm: Implement SVE2 crypto destructive binary operations
  target/arm: Implement SVE2 crypto constructive binary operations

 target/arm/cpu.h           |  10 ++
 target/arm/helper.h        |  45 ++++---
 target/arm/translate-a64.h |   2 +
 target/arm/vec_internal.h  |  10 ++
 target/arm/sve.decode      |  17 +++
 target/arm/crypto_helper.c | 267 ++++++++++++++++++++++++++-----------
 target/arm/translate-a64.c | 211 +++++++++++++----------------
 target/arm/translate-sve.c |  79 +++++++++++
 target/arm/translate.c     | 125 +++++++++--------
 target/arm/vec_helper.c    |  10 --
 10 files changed, 491 insertions(+), 285 deletions(-)

-- 
2.20.1


