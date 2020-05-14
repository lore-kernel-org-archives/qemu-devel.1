Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5801EC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:57:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2352E205CB
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:57:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CpXsLBKn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2352E205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZFIh-0004Yp-7g
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 10:57:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41568)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZEwZ-00037F-FL
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:34:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23991
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZEwY-0000qy-Hk
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:34:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589466877;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=oHcjS/gDSvJi5JV1G/ZxayYlfSvkuPGEpEPtZBkMcI0=;
 b=CpXsLBKnBX4oTIpZh8UJd31R0KVS1UjfTF/+T8vuwVBzR7QRTVXNiPrmMnS3mntmzQKvSf
 W3U4RN6jwPEe65En5wv37+jqQmgtwDer3btIRVaKae2RSO/tVbuwN3ZZe0aa9qK8K1uRZW
 3RXfUjqPQtTYKEqX0mHrjIS9u5AeyO4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-53-dhxElA4LNpS6NCuniscG2Q-1; Thu, 14 May 2020 10:34:36 -0400
X-MC-Unique: dhxElA4LNpS6NCuniscG2Q-1
Received: by mail-wr1-f71.google.com with SMTP id r7so1673294wrc.13
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 07:34:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=oHcjS/gDSvJi5JV1G/ZxayYlfSvkuPGEpEPtZBkMcI0=;
 b=DNXsi7FmOgBG3qVRQu8+axAxWGXYZ8XKK4WfMdKtiyzwSFiP90BXqdfg2Mhhnc5tDC
 ogSt2UDe4I1MGWfntypnIoHrl/7jMBMIgNLN110CgWocYRPQ210BIO2uBeKRBMSPqk+d
 oyuOmm1a5mcmNZHk4r41KJ5hTyICuXSHj7J7bpTF5+N5cVSA+jms3VWAjafaZfAYDkfy
 OCR3aubaD5thLvBMqd/gsXmxbEVtxdKwny8DAjPmaHYhbvli+H0+3lfLHtU2b9iSsudU
 xnfjin7uvGZkrNFpj/FI21xV4VNeWmrLLaiE6Zhx7aDx35MDlX0CqJwCRn0ZQb8Xxl7F
 WLxA==
X-Gm-Message-State: AGi0PubuXRHozpGH4bFd+6xx600feghExbFm8qiz5hs23oBnKF2gBzqo
 eyeumGFMGNY9x5vo4JgxRmA1KLnd/ncl17+/0rBzvVPn3OxEOVLox4lsoZOlsc4rtjYOA0PZwcy
 7nPCEJMgZ4gGCXH0=
X-Received: by 2002:a05:600c:230e:: with SMTP id
 14mr21660366wmo.45.1589466875048; 
 Thu, 14 May 2020 07:34:35 -0700 (PDT)
X-Google-Smtp-Source: APiQypJ5AviXNwcgzxFDFwewltqdpAsnylScSQa3zE0apVgXT6sJqjXl8Ttuv6dmUeD36XtKuPWJcA==
X-Received: by 2002:a05:600c:230e:: with SMTP id
 14mr21660341wmo.45.1589466874797; 
 Thu, 14 May 2020 07:34:34 -0700 (PDT)
Received: from x1w.redhat.com (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id y10sm4529626wrd.95.2020.05.14.07.34.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2020 07:34:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/6] tests/fuzz: Review notes
Date: Thu, 14 May 2020 16:34:27 +0200
Message-Id: <20200514143433.18569-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 22:25:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, Bandan Das <bsd@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I took some code notes while testing Alex's toy.
Sending them as patches.

Alex, I had theses issues while building following
docs/devel/fuzzing.txt:

    CC      nbd/server.o
  nbd/server.c:1937:1: error: unused function 'glib_listautoptr_cleanup_NBDExtentArray' [-Werror,-Wunused-function]
  G_DEFINE_AUTOPTR_CLEANUP_FUNC(NBDExtentArray, nbd_extent_array_free);
  ^
  /usr/include/glib-2.0/glib/gmacros.h:462:22: note: expanded from macro 'G_DEFINE_AUTOPTR_CLEANUP_FUNC'
    static inline void _GLIB_AUTOPTR_LIST_FUNC_NAME(TypeName) (GList **_l) { g_list_free_full (*_l, (GDestroyNotify) func); } \
                       ^
  /usr/include/glib-2.0/glib/gmacros.h:443:48: note: expanded from macro '_GLIB_AUTOPTR_LIST_FUNC_NAME'
  #define _GLIB_AUTOPTR_LIST_FUNC_NAME(TypeName) glib_listautoptr_cleanup_##TypeName
                                                 ^
Solved by using './configure ... --extra-cflags=-Wno-unused-function'

    LINK    i386-softmmu/qemu-fuzz-i386
  /usr/lib64/clang/9.0.1/lib/linux/libclang_rt.asan-aarch64.a(asan_interceptors_vfork.S.o): warning: common of `__interception::real_vfork' overridden by definition
  /usr/lib64/clang/9.0.1/lib/linux/libclang_rt.asan-aarch64.a(asan_interceptors.cc.o): warning: defined here

I simply ignore this warning.

Alex, could you provide few more examples (in particular about
instantiating devices, or useful libfuzzer arguments)?

Also, I suppose you are using a script to generate the bug reports:

  I can reproduce it in qemu 5.0 using:

  cat << EOF | qemu-system ...
  outl 0xcf8 ...
  outl 0xcfc ...
  ...
  EOF

Is this script available in the QEMU repository? I couldn't find it.

Regards,

Phil.

Philippe Mathieu-Daudé (6):
  tests/fuzz/Makefile: Do not link code using unavailable devices
  Makefile: List fuzz targets in 'make help'
  tests/fuzz: Add missing space in test description
  tests/fuzz: Remove unuseful/unused typedefs
  tests/fuzz: Extract pciconfig_fuzz_qos() method
  tests/fuzz: Extract ioport_fuzz_qtest() method

 Makefile                          |  6 +++-
 tests/qtest/fuzz/i440fx_fuzz.c    | 47 ++++++++++++++++++++-----------
 tests/qtest/fuzz/Makefile.include |  6 ++--
 3 files changed, 38 insertions(+), 21 deletions(-)

-- 
2.21.3


