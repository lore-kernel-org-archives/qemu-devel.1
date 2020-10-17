Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52EABC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 02:30:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1F60206CB
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 02:30:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QlKZWubA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1F60206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTbyz-0008C8-DD
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 22:30:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57128)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kTby0-0006lm-0V
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 22:29:08 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:34739)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kTbxy-0007uN-2B
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 22:29:07 -0400
Received: by mail-pg1-x542.google.com with SMTP id f5so2514986pgb.1
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2020 19:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=YZMLFV5Ei0DzvvOkOg98W90m+qGQEz9/RS//5BEDF+c=;
 b=QlKZWubA7jYf0MlQx9Hs6YN20ZpBN3KUCt0T3EFMYAinN56Sd4qhXG4z1oViAQ8JFd
 fvxnHO09ww0Flb/m6p1Y8SYnIw4ttknVHIsEaMHxmqItMHMxyHeLrc4+I+xM1zz1x2DW
 LRq8IPXR87D6qM4VOT89GEBknIZRvbk7c1nN31QJ0J6pzecPsHTtLnSnN8iANiCiNIf0
 0x3cMMySaOYJqBuGNeTuamv3OnLyMWOCxnD0rHGT0brQSkkcjc85PHwJtqimS4ngJ3ud
 9zWfgK1KmV1oZWUEFSeOtSEdwBHWfeRk0nqyQSkifuPH53T0/MLhss39XWipgKQwHK3K
 I14w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=YZMLFV5Ei0DzvvOkOg98W90m+qGQEz9/RS//5BEDF+c=;
 b=Y0dAsJaXEJd4qk+AZrsHkYlS2T7/JDgoOG9dbxs14891CanPhrMwmBe1gsvLcE5Mak
 Iy9ArMVQagvxtbN+Ogf0QyZ54L27d2muqb7/l2I8ab+lgM81NA4nM7XBmTpr/++amJ9g
 T1pmCqlEMOCP6DfjcDbehActsL5g9Ga6QPULb2AIYvJvxSwCI/6CDWaTK2cWikZe0kWp
 iHpY9udbJ5c1i1YCOB1J2AfsJ520zXLT88O78XERi5X5CbM6Q4nbfGiTL+WQlHg1SsRP
 cUrWmlqDzDBzkf8cEwdbunxc6RlzF6GwnaTOPx/8vvmtSTYlE1e+3jKUCfK7IcOJytOH
 ESXQ==
X-Gm-Message-State: AOAM533FBomba2kYWexSJJaTcUsY5J8f7BsKLa66H8p2EBOXBTbv01Kv
 bsAdTceN9hefQsSF5hNBISkPgnxlfCtxfA==
X-Google-Smtp-Source: ABdhPJxUPKoHCYtCrnpiPwbnLjju5pyIOv3EN3gcBZk+bMyPyvYG0P7HklTmyfx6Vrf7n2difaYZJg==
X-Received: by 2002:a63:474b:: with SMTP id w11mr5529151pgk.376.1602901743666; 
 Fri, 16 Oct 2020 19:29:03 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id k9sm4150818pgt.72.2020.10.16.19.29.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2020 19:29:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/4] target/s390x: Improve carry computation
Date: Fri, 16 Oct 2020 19:28:57 -0700
Message-Id: <20201017022901.78425-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x542.google.com
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
Cc: david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

While testing the float128_muladd changes for s390x host,
emulating under x86_64 of course, I noticed that the code
we generate for strings of ALCGR and SLBGR is pretty awful.

I realized that we were missing a trick: the output cc is
based only on the output (result and carry) and so we don't
need to save the inputs.  And once we do that, we can use
the output carry as a direct input to the next insn.

For subtract, computing carry as per the PoO (a + ~b + c),
in tcg is less efficient than computing borrow.  We can
convert between the two simply by adding or subtracting 1.

As an example from float128_muladd,

0x400003f014:  b90b 0019       slgr     %r1, %r9
0x400003f018:  b989 002a       slbgr    %r2, %r10
0x400003f01c:  b989 0030       slbgr    %r3, %r0

Before:

  -- guest addr 0x000000400003f014
0x7fcbf811a4bc:  4d 8b f5                 movq     %r13, %r14
0x7fcbf811a4bf:  4c 8b 7d 48              movq     0x48(%rbp), %r15
0x7fcbf811a4c3:  4d 2b ef                 subq     %r15, %r13
0x7fcbf811a4c6:  4c 89 6d 08              movq     %r13, 8(%rbp)
  -- guest addr 0x000000400003f018
0x7fcbf811a4ca:  4c 8b d3                 movq     %rbx, %r10
0x7fcbf811a4cd:  4c 8b 5d 50              movq     0x50(%rbp), %r11
0x7fcbf811a4d1:  49 2b db                 subq     %r11, %rbx
0x7fcbf811a4d4:  4d 3b f7                 cmpq     %r15, %r14
0x7fcbf811a4d7:  41 0f 92 c6              setb     %r14b
0x7fcbf811a4db:  45 0f b6 f6              movzbl   %r14b, %r14d
0x7fcbf811a4df:  49 2b de                 subq     %r14, %rbx
0x7fcbf811a4e2:  48 89 5d 10              movq     %rbx, 0x10(%rbp)
0x7fcbf811a4e6:  4c 8b c3                 movq     %rbx, %r8
  -- guest addr 0x000000400003f01c
0x7fcbf811a4e9:  4c 8b 75 18              movq     0x18(%rbp), %r14
0x7fcbf811a4ed:  4d 8b fe                 movq     %r14, %r15
0x7fcbf811a4f0:  4c 8b 4d 00              movq     (%rbp), %r9
0x7fcbf811a4f4:  4d 2b f1                 subq     %r9, %r14
0x7fcbf811a4f7:  48 8b fd                 movq     %rbp, %rdi
0x7fcbf811a4fa:  be 12 00 00 00           movl     $0x12, %esi
0x7fcbf811a4ff:  49 8b d2                 movq     %r10, %rdx
0x7fcbf811a502:  49 8b cb                 movq     %r11, %rcx
0x7fcbf811a505:  ff 15 4d 01 00 00        callq    *0x14d(%rip)
0x7fcbf811a50b:  83 f8 02                 cmpl     $2, %eax
0x7fcbf811a50e:  41 0f 92 c2              setb     %r10b
0x7fcbf811a512:  45 0f b6 d2              movzbl   %r10b, %r10d
0x7fcbf811a516:  45 8b d2                 movl     %r10d, %r10d
0x7fcbf811a519:  4d 2b f2                 subq     %r10, %r14
0x7fcbf811a51c:  4c 89 75 18              movq     %r14, 0x18(%rbp)
0x7fcbf811a520:  48 8b 4d 00              movq     (%rbp), %rcx
0x7fcbf811a524:  4d 8b c6                 movq     %r14, %r8

After:

  -- guest addr 0x000000400003f014
0x7fd1d011a23c:  45 33 f6                 xorl     %r14d, %r14d
0x7fd1d011a23f:  4c 8b 7d 48              movq     0x48(%rbp), %r15
0x7fd1d011a243:  4d 2b ef                 subq     %r15, %r13
0x7fd1d011a246:  4d 1b f6                 sbbq     %r14, %r14
0x7fd1d011a249:  4c 89 6d 08              movq     %r13, 8(%rbp)
  -- guest addr 0x000000400003f018
0x7fd1d011a24d:  49 03 de                 addq     %r14, %rbx
0x7fd1d011a250:  49 83 d6 00              adcq     $0, %r14
0x7fd1d011a254:  4c 8b 7d 50              movq     0x50(%rbp), %r15
0x7fd1d011a258:  49 2b df                 subq     %r15, %rbx
0x7fd1d011a25b:  49 83 de 00              sbbq     $0, %r14
0x7fd1d011a25f:  48 89 5d 10              movq     %rbx, 0x10(%rbp)
  -- guest addr 0x000000400003f01c
0x7fd1d011a263:  4c 8b 7d 18              movq     0x18(%rbp), %r15
0x7fd1d011a267:  4d 03 fe                 addq     %r14, %r15
0x7fd1d011a26a:  49 83 d6 00              adcq     $0, %r14
0x7fd1d011a26e:  4c 8b 55 00              movq     (%rbp), %r10
0x7fd1d011a272:  4d 2b fa                 subq     %r10, %r15
0x7fd1d011a275:  49 83 de 00              sbbq     $0, %r14
0x7fd1d011a279:  4c 89 7d 18              movq     %r15, 0x18(%rbp)


r~


Richard Henderson (4):
  target/s390x: Improve cc computation for ADD LOGICAL
  target/s390x: Improve ADD LOGICAL WITH CARRY
  target/s390x: Improve cc computation for SUBTRACT LOGICAL
  target/s390x: Improve SUB LOGICAL WITH BORROW

 target/s390x/internal.h    |  11 +-
 target/s390x/cc_helper.c   | 123 +++-------------
 target/s390x/helper.c      |  10 +-
 target/s390x/translate.c   | 286 ++++++++++++++++++++-----------------
 target/s390x/insn-data.def |  76 +++++-----
 5 files changed, 213 insertions(+), 293 deletions(-)

-- 
2.25.1


