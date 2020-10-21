Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4DEEC55ABD
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 04:53:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AC0C22200
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 04:53:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ltCSuz7a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AC0C22200
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kV67R-0001tp-Q2
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 00:53:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57450)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kV66O-0000HV-Ml
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 00:51:56 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534]:42824)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kV66M-0005eP-MC
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 00:51:56 -0400
Received: by mail-pg1-x534.google.com with SMTP id s22so728372pga.9
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 21:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=58+YAXN+ZyyDA3DV/NMmCQZJEKF07N6mcAgTxSZE354=;
 b=ltCSuz7auLDrnJEm68RAsbdRl1xa5c86noLV+Y1HJSM+dkh3REl6H5fV3vZt7vogFH
 Q7LsMYKpoOUjEAu3ozZeEeRhN4x++5mzGDTrnsaSP/kBnUuyC1/+KvcS2oYmJsTP0Ewo
 8u3Lzk8fWhmLXBxb9CSBZyJqWeN4ahGWgEGKzxXYUiywluiAg61IoxTEKnsZkExtlvnJ
 oAmg/715GpvkPcp27oabOHrbgQPucQpQlC51LeTlfYbs1cEEUeHb1o5WUXSVfnplVRuV
 WB/3Ed7EqT45EUPwp6oQFk8XPoArkuCW6lMUo/A2tBc//yBkqch0XTfu3ark+18wRPZX
 AfqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=58+YAXN+ZyyDA3DV/NMmCQZJEKF07N6mcAgTxSZE354=;
 b=FPX/52sNQZEf7iWRzm9uyqkMwVSziG7RDwNQMcQ0BHlojwPNBwcvxRSBt+b0s9M648
 Jt38BRRD1mmMbsuu74wHuXP+vixRcTql80hLFSBytrvhkRc72aDXNCykeu+oSrLLEZ/a
 eKf+CqjoY8n07b6S0dPkURM7guuDlhk3GSwpfZOqJaZT4g90tN0t7Aj5XnrGa+TFF3lV
 YFrIbehedR3vHxVIiU9K6g/5JpcLgf6GJL8r1WhpOuDyD/IgYSlqxkwHinTKiFpEYckQ
 wRjGxbVmC+vFYXQXRDTROCTzfEkKfCkufbPc3FvlrWJSgMLsGW67KnPghTBDyaIh8kkr
 Gy0g==
X-Gm-Message-State: AOAM5338TpZYXZTYVokPWHngFNlB/6mRjZ2EW0JWLdvy8jykLD0qVMSA
 XApHryEAimIjIMwtFLrdvbk1iZ+1kmpXXQ==
X-Google-Smtp-Source: ABdhPJyIYcVMYndH1LKKZSNiYPW/op2yQqC6DS4z4eWeQJ+F9NChbFC5kNhJe2VUeETilI1r60i4nA==
X-Received: by 2002:a63:e57:: with SMTP id 23mr1556461pgo.278.1603255911364;
 Tue, 20 Oct 2020 21:51:51 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id j11sm620070pfh.143.2020.10.20.21.51.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2020 21:51:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 00/15] softfloat: alternate conversion of float128_addsub
Date: Tue, 20 Oct 2020 21:51:34 -0700
Message-Id: <20201021045149.1582203-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
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
Cc: alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Alex,

Here's my first adjustment to your conversion for 128-bit floats.

The Idea is to use a set of macros and an include file so that we
can re-use the same large chunk of code that performs the basic
operations on various fraction lengths.  It's ugly, but without
proper language support it seems to be less ugly than most.

While I've just gone and added lots of stuff to int128... I have
had another idea, half-baked because I'm tired and it's late:

typedef struct {
    FloatClass cls;
    int exp;
    bool sign;
    uint64_t frac[];
} FloatPartsBase;

typedef struct {
    FloatPartsBase base;
    uint64_t frac;
} FloatParts64;

typedef struct {
    FloatPartsBase base;
    uint64_t frac_hi, frac_lo;
} FloatParts128;

typedef struct {
    FloatPartsBase base;
    uint64_t frac[4]; /* big endian word ordering */
} FloatParts256;

This layout, with the big-endian ordering, means that storage
can be shared between them, just by ignoring the least significant
words of the fraction as needed.  Which may make muladd more
understandable.

E.g.

static void muladd_floats64(FloatParts128 *r, FloatParts64 *a,
                            FloatParts64 *b, FloatParts128 *c, ...)
{
    // handle nans
    // produce 128-bit product into r
    // handle p vs c special cases.
    // zero-extend c to 128-bits
    c->frac[1] = 0;
    // perform 128-bit fractional addition
    addsub_floats128(r, c, ...);
    // fold 128-bit fraction to 64-bit sticky bit.
    r->frac[0] |= r->frac[1] != 0;
}

float64 float64_muladd(float64 a, float64 b, float64 c, ...)
{
    FloatParts64 pa, pb;
    FloatParts128 pc, pr;

    float64_unpack_canonical(&pa.base, a, status);
    float64_unpack_canonical(&pb.base, b, status);
    float64_unpack_canonical(&pc.base, c, status);
    muladd_floats64(&pr, &pa, &pb, &pc, flags, status);

    return float64_round_pack_canonical(&pr.base, status);
}

Similarly, muladd_floats128 would use addsub_floats256.

However, the big-endian word ordering means that Int128
cannot be used directly; so a set of wrappers are needed.
If added the Int128 routine just for use here, then it's
probably easier to bypass Int128 and just code it here.

Thoughts?


r~


Richard Henderson (15):
  qemu/int128: Add int128_or
  qemu/int128: Add int128_clz, int128_ctz
  qemu/int128: Rename int128_rshift, int128_lshift
  qemu/int128: Add int128_shr
  qemu/int128: Add int128_geu
  softfloat: Use mulu64 for mul64To128
  softfloat: Use int128.h for some operations
  softfloat: Tidy a * b + inf return
  softfloat: Add float_cmask and constants
  softfloat: Inline float_raise
  Test split to softfloat-parts.c.inc
  softfloat: Streamline FloatFmt
  Test float128_addsub
  softfloat: Use float_cmask for addsub_floats
  softfloat: Improve subtraction of equal exponent

 include/fpu/softfloat-macros.h |  89 ++--
 include/fpu/softfloat.h        |   5 +-
 include/qemu/int128.h          |  61 ++-
 fpu/softfloat.c                | 802 ++++++++++-----------------------
 softmmu/physmem.c              |   4 +-
 target/ppc/int_helper.c        |   4 +-
 tests/test-int128.c            |  44 +-
 fpu/softfloat-parts.c.inc      | 339 ++++++++++++++
 fpu/softfloat-specialize.c.inc |  45 +-
 9 files changed, 716 insertions(+), 677 deletions(-)
 create mode 100644 fpu/softfloat-parts.c.inc

-- 
2.25.1


