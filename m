Return-Path: <SRS0=PlQC=BZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B782DC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 15:03:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 814AC22DCC
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 15:03:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jMTlG/Vz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 814AC22DCC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6xic-0006aM-Nt
	for qemu-devel@archiver.kernel.org; Sat, 15 Aug 2020 11:03:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43714)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6xd7-0008UF-9D
 for qemu-devel@nongnu.org; Sat, 15 Aug 2020 10:57:57 -0400
Received: from mail-qv1-xf36.google.com ([2607:f8b0:4864:20::f36]:40338)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6xd2-0005Hq-JL
 for qemu-devel@nongnu.org; Sat, 15 Aug 2020 10:57:56 -0400
Received: by mail-qv1-xf36.google.com with SMTP id s15so5687718qvv.7
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2020 07:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=HNjgEQCzoNGIiEGwjQluN/mSWTCRv8H7Gh+UybIw+Yg=;
 b=jMTlG/VzuCjqx/dYdpfWBph9sVf8XGPYS//OZSGCgcNyGHMPxhihCcYzbC/mLc+zJ2
 fY9qo5Jf3GfS7mx0Um0jOYqtofcMB4qcH7Hd22gv6rl1ere4d/ntKTkzDMYf4NFdkZ2o
 RTCkIoGbbs539Ss38r5cSxc1vcOmkRP29K9qmZeZidwL1PyJiviHz2UqlYofpAMF5u9q
 E5lPgXfhwpO630Bkg5WYDbxRSqogOSmBGkUMk6SfqLKk0zVFTLy9Ddo5mfB+bJ8FgN34
 o3FMD2e8+lRQTgfhnE6LxYgeGwQvL45u/UO4ASjljL61k0xOIStjYV7jcQZyFPBkuLEj
 biVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=HNjgEQCzoNGIiEGwjQluN/mSWTCRv8H7Gh+UybIw+Yg=;
 b=qsatuYcbg9rHbS5UgVVQF0pJDh+Niib/K205FLWY5FF+YvvjiKSxNUO4z4sik9nu+i
 quGlnTMDZ8a04XTPVg88OokK+TV/9HBtJCT9SbVEC//KtRO2ztiFi8gIPIq4MoRSs2j0
 0URsEVR5hzYPPbNp5+8VWs/BOUU1QX7EZgPCv9lPqcCWFwh1+8ic7LbXFsbnvwMrOovn
 htep/3HD0JAzBVPRiUD81WkBoHn3HPrslq6qCfExZuNBLjvN4SwdzZBrOcTGq5tpPHZF
 SlkhQfsebU/3xHxiFUNzfEFcKzjpkNN++J/ZORunHttA6GjKj+pdTmmHHft5GGNQAerZ
 lfEg==
X-Gm-Message-State: AOAM532RcRf5/hEYGJiYYhwxxJQ67v7rwzXBJ1MXOImGu5vR2ANBuDWT
 M1cCrycXwOGfQbEYA4hpSCGeL4oRPEMchw==
X-Google-Smtp-Source: ABdhPJxAfjeZKtNrgFV32E/NV/JpK9zTdacK0Oc4D+01Nvgu1KbSQidOu5Mx+fovK3M4cRT+zW6hJw==
X-Received: by 2002:a62:cf85:: with SMTP id b127mr3685231pfg.89.1597455107937; 
 Fri, 14 Aug 2020 18:31:47 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id y196sm10625528pfc.202.2020.08.14.18.31.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2020 18:31:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/20] target/arm: SVE2 preparatory patches
Date: Fri, 14 Aug 2020 18:31:25 -0700
Message-Id: <20200815013145.539409-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f36;
 envelope-from=richard.henderson@linaro.org; helo=mail-qv1-xf36.google.com
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is collection of cleanups and changes that are required by
SVE2, but do not directly implement it.  The final 3 patches are
relevant to Peter's aa32 neon work.


r~


Richard Henderson (20):
  qemu/int128: Add int128_lshift
  target/arm: Split out gen_gvec_fn_zz
  target/arm: Split out gen_gvec_fn_zzz, do_zzz_fn
  target/arm: Rearrange {sve,fp}_check_access assert
  target/arm: Merge do_vector2_p into do_mov_p
  target/arm: Clean up 4-operand predicate expansion
  target/arm: Use tcg_gen_gvec_bitsel for trans_SEL_pppp
  target/arm: Split out gen_gvec_ool_zzzp
  target/arm: Merge helper_sve_clr_* and helper_sve_movz_*
  target/arm: Split out gen_gvec_ool_zzp
  target/arm: Split out gen_gvec_ool_zzz
  target/arm: Split out gen_gvec_ool_zz
  target/arm: Tidy SVE tszimm shift formats
  target/arm: Generalize inl_qrdmlah_* helper functions
  target/arm: Fix sve_uzp_p vs odd vector lengths
  target/arm: Fix sve_zip_p vs odd vector lengths
  target/arm: Fix sve_punpk_p vs odd vector lengths
  target/arm: Convert integer multiply (indexed) to gvec for aa64
    advsimd
  target/arm: Convert integer multiply-add (indexed) to gvec for aa64
    advsimd
  target/arm: Convert sq{,r}dmulh to gvec for aa64 advsimd

 include/qemu/int128.h      |  16 ++
 target/arm/helper-sve.h    |   5 -
 target/arm/helper.h        |  28 +++
 target/arm/translate.h     |   1 +
 target/arm/sve.decode      |  35 ++--
 target/arm/sve_helper.c    | 129 +++++-------
 target/arm/translate-a64.c | 110 ++++++++--
 target/arm/translate-sve.c | 399 +++++++++++++++----------------------
 target/arm/vec_helper.c    | 182 ++++++++++++-----
 9 files changed, 492 insertions(+), 413 deletions(-)

-- 
2.25.1


