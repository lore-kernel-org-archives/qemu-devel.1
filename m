Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6CAAC43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 14:27:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66A0E229F0
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 14:27:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MM7xtWfc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66A0E229F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFebD-0007IO-Ct
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 10:27:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38084)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kFeaO-0005Rq-NI
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 10:27:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53719
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kFeZX-0006m2-T4
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 10:27:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599575167;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=AigchT0IqpQTMPs2wbwFMKYiR3x5TIxf3jJNE6ATp5A=;
 b=MM7xtWfc0LarIaa2YpEvUdb+gNlWQ6j81/5xBLPNLtVOYjjEG1iZydU4lc1cnKJpGVOkFX
 H2R2co4HL5l9TjN4nx0NuR1y64qbUjqrIQOALUbsnYSNMNbEVsmR70V3qmjwF3XlHRtdOj
 c8RXPKYI9RNfdmPGGFs5ykrJ8oaQwsc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-532-IuAUhXi0PVycYoBRpPQrsw-1; Tue, 08 Sep 2020 10:26:02 -0400
X-MC-Unique: IuAUhXi0PVycYoBRpPQrsw-1
Received: by mail-wm1-f70.google.com with SMTP id x6so519634wmi.1
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 07:26:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=AigchT0IqpQTMPs2wbwFMKYiR3x5TIxf3jJNE6ATp5A=;
 b=Q43FUj3lHfQXaRXc+Ul6hsP7UGu2nTs3mwQqgQLd8dDFZabudfnA0w5Z1Svl9ubcnS
 oQKBx3S35uhXZhcbVKqixQpLb3GBwJG+xPB/EoqbXXLVjDiofIxTiGFzSOYaIaGa8HE0
 LHvpL5U5RQ7e8N+9L+rQfbBNZZyNOPgI4QdlyF3Fzl1zUbf1pGxxdDB2aUQK7z1JL5+J
 MvngAXRoc1gQ+XPHk615v+HFyKEw/ScTrZuAKM9VbrzrQs4IRdJGUil3wIuw4+4lFqLt
 +D7oK+xQbjA6CyHJZIFm1QfoDbbryvHH05cqvy0vjx+QDUGVKx5ljEl8RryupeivXiiT
 Fo4g==
X-Gm-Message-State: AOAM530F28cXGC8PTLQsNi0gFiMJcWaZyGAJA4Pu6dVtx9CQftRRCFZa
 QrCZdwQLGIXFXHPyFfWlSaBjWu7n/a4or21f0WKJ/bDikOhRenKGRkUJAXRB6FfLT9Q0SkTPM16
 0LD6ZUpXhA0eRVdw=
X-Received: by 2002:adf:e989:: with SMTP id h9mr29297444wrm.38.1599575161423; 
 Tue, 08 Sep 2020 07:26:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxsWz2CkHeEuhNarNgmaivVi6iopBf5ujS65WHyGjJQWXzXJi1ZEAq7Y9Gv1FoWsJeCqXsz6A==
X-Received: by 2002:adf:e989:: with SMTP id h9mr29297414wrm.38.1599575161222; 
 Tue, 08 Sep 2020 07:26:01 -0700 (PDT)
Received: from localhost.localdomain (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id 189sm33177412wmb.3.2020.09.08.07.26.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 07:26:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/5] hw/xen: Housekeeping
Date: Tue,  8 Sep 2020 16:25:54 +0200
Message-Id: <20200908142559.192945-1-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 02:10:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Paul Durrant <paul@xen.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, xen-devel@lists.xenproject.org,
 Anthony Perard <anthony.perard@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hard to make an exciting cover of this series.

Basically:
- Make better separation between Xen accel and Xen hardware,
- Move stuff around to restrict PCMachineState to hw/i386/.

Philippe Mathieu-Daudé (5):
  hw/i386/q35: Remove unreachable Xen code on Q35 machine
  hw/i386/xen: Rename X86/PC specific function as xen_hvm_init_pc()
  stubs: Split accelerator / hardware related stubs
  hw/xen: Split x86-specific declaration from generic hardware ones
  typedefs: Restrict PCMachineState to 'hw/i386/pc.h'

 include/hw/i386/pc.h     |  4 ++--
 include/hw/xen/xen-x86.h | 15 ++++++++++++
 include/hw/xen/xen.h     |  2 --
 include/qemu/typedefs.h  |  1 -
 accel/stubs/xen-stub.c   | 41 +--------------------------------
 hw/i386/pc_piix.c        |  8 +++----
 hw/i386/pc_q35.c         | 13 ++---------
 hw/i386/xen/xen-hvm.c    |  3 ++-
 stubs/xen-hw-stub.c      | 49 ++++++++++++++++++++++++++++++++++++++++
 MAINTAINERS              |  1 +
 stubs/meson.build        |  1 +
 11 files changed, 77 insertions(+), 61 deletions(-)
 create mode 100644 include/hw/xen/xen-x86.h
 create mode 100644 stubs/xen-hw-stub.c

-- 
2.26.2


