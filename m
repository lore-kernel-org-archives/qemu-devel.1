Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E9CC4363D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 13:57:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0D99207BC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 13:57:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KXJDlJ9S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0D99207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPQzn-0008Oz-LD
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 09:57:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53962)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kPQyQ-000784-1N
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 09:56:19 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:53391)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kPQyO-0000NI-KJ
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 09:56:17 -0400
Received: by mail-wm1-x32e.google.com with SMTP id f21so3465589wml.3
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2020 06:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=2o8pQnaV6jx+33KumWBlrHoy1B3kkbh0WO/pEaQSKfQ=;
 b=KXJDlJ9Sm7JV5Co5Fwo6ZBd5lWJUzXqj2pbX/WCOznO72/gDAuNh1l5vVM348GG2no
 R+m4FmvsT1K+PASnhjoMhkQzEABSwI4y0+urvmFC4iClkn4/M68hhgwk/pOz/k0zam2Q
 o8IJv9bkSTY2VNrKiS0W3KE5qpWt6t1406L2/MkYx36EmmllZbxlhK27tiJisO7s/Pkm
 Hy/RxJDHMBMmGzopQc8LC6X0gyIm0HHrh0gajRV6rIKuZIH10Ql7jj3rdhE5H2bmKlrC
 +Hsxqelj7Ka7DWn+6xNgEIg5a9+nStAl192zvW4BQ6Mkq4FaNhynVigFUfRrRE9qA6ZT
 2ghw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=2o8pQnaV6jx+33KumWBlrHoy1B3kkbh0WO/pEaQSKfQ=;
 b=NZ9tJPT44xISt+AVdbC4AdNDoisyOSgFWe3wqPEyOUY0Fz4aPN1YpsohirpF4A6r9Q
 V4wxSeW3gzCrzSxjtpm+MB+1vhz66QNDYmOf9gljIG8QRMNCOMs0Cgyp3mjLRHHK6pEr
 J0AwjIFhEngQNWmo2Ph/QI/Vkq6PukuOgH2k4wusceIokgcJO8P4ZOG7pUwqP0vM4WiZ
 6d5F44b2MSSii3qfpAqzRdxZojK5pObsV15euSL/+5sm4ce+KX3PaTffkgPwe7ObYvvW
 LugoQPmHDwzhKl86/o70zp9e8S/kzlTynqK9wrXIOHD5gueV8ZVSkVowxPCT0gvw27Dl
 1PiQ==
X-Gm-Message-State: AOAM532+32CSviMAvVz9ovchCkheqJu9mNgXoh1IHKaQVrIhFEKcvVEV
 vugsaWr0GLQumMpKvc1GiK9ZBxjTEzE=
X-Google-Smtp-Source: ABdhPJyE1l+lxjvx3RJEwLXJpG0CE3NLAkHR5GwQAe8Z5J/7CAxOCdsITGcW1fbMU7iL/Xfwf1Amlw==
X-Received: by 2002:a1c:1bd1:: with SMTP id
 b200mr17882877wmb.171.1601906172888; 
 Mon, 05 Oct 2020 06:56:12 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6468:f312:2e86:3d8b:8b70:920c])
 by smtp.gmail.com with ESMTPSA id c8sm13406559wmd.18.2020.10.05.06.56.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2020 06:56:12 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/4] Convert remaining submodules to meson,
 cleanup env var handling
Date: Mon,  5 Oct 2020 15:56:09 +0200
Message-Id: <20201005135613.435932-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wm1-x32e.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.248,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: marcandre.lureau@redhat.com, richard.henderson@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The main purpose of this series is to have a correct and consistent
handling of CFLAGS/CXXFLAGS/LDFLAGS environment variables:

- correct: avoid that the -pie flag, used for the compiler checks in
the configure script, ends up being passed to Meson if an LDFLAGS
environment variable exists (patch 3)

- consistent: ensure that CFLAGS that are set in the configure
script are persistent even if Meson is restarted; to do so,
make the configure script store them in the cross file it generates.

In order to avoid having to deal with recursive make, patches 1
and 2 integrate the Meson-based build system with the build of
embedded slirp and libfdt.  This follows the lead of Richard's
patches to do the same with Capstone.

Based-on: <20201003093851.324923-1-richard.henderson@linaro.org>
Supersedes: <20200923092617.1593722-1-pbonzini@redhat.com>

Paolo Bonzini (4):
  slirp: Convert Makefile bits to meson bits
  dtc: Convert Makefile bits to meson bits
  configure: do not clobber environment CFLAGS/CXXFLAGS/LDFLAGS
  configure: consistently pass CFLAGS/CXXFLAGS/LDFLAGS to meson

 Makefile                                      |  28 +--
 configure                                     | 222 +++++-------------
 default-configs/targets/aarch64-softmmu.mak   |   1 +
 default-configs/targets/arm-softmmu.mak       |   1 +
 .../targets/microblaze-softmmu.mak            |   1 +
 .../targets/microblazeel-softmmu.mak          |   1 +
 default-configs/targets/mips64el-softmmu.mak  |   1 +
 default-configs/targets/ppc-softmmu.mak       |   1 +
 default-configs/targets/ppc64-softmmu.mak     |   1 +
 default-configs/targets/riscv32-softmmu.mak   |   1 +
 default-configs/targets/riscv64-softmmu.mak   |   1 +
 default-configs/targets/rx-softmmu.mak        |   1 +
 meson.build                                   | 164 +++++++++++--
 meson_options.txt                             |   6 +
 net/meson.build                               |   2 +-
 tests/qtest/meson.build                       |   6 +-
 16 files changed, 225 insertions(+), 213 deletions(-)

-- 
2.26.2


