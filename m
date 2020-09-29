Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6BAFC4727F
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 11:15:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0516121D41
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 11:15:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gHnoJn/H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0516121D41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNDb3-0001b3-Ti
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 07:15:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59598)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kNDZX-0000DJ-4j
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 07:13:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43742)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kNDZS-0004BF-Le
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 07:13:26 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601378001;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=CRguNcvNj88yueONHcRc+FKzzR5bnujAgdymSfU9c7k=;
 b=gHnoJn/Ho4YuqdJ5SK4cgcqUFHTMRbFoMPhI4YBrzuB+cmaPi4R878wV710C5al/wabphV
 CeinGHL1tEILwp9cjZgfKXQQWyhGFmnNHAZXHqrjgLwOpJCLnyizmFKLdxrrv4sJ3fUHby
 4TzNw8yu2C03Fwck9dwLgnKr0ceUp4U=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-3PyMjnFGNW-SafuLPOvkfg-1; Tue, 29 Sep 2020 07:13:19 -0400
X-MC-Unique: 3PyMjnFGNW-SafuLPOvkfg-1
Received: by mail-wr1-f72.google.com with SMTP id v12so1619138wrm.9
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 04:13:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=CRguNcvNj88yueONHcRc+FKzzR5bnujAgdymSfU9c7k=;
 b=TVSkv2kYXfJJcNmemDSff9hmGPDA27Uad5EPwzwRMHKiqU6l+LnJu2RqFqJ8+Ei0u6
 XRGBe+LmxGWC4WWijN2Skp0nrHRsFMjwV+eFNoNBgXB0ktWzTBZxF5j63uQL+gF5Yxml
 fMwZLxGs/QLOQOy/AxKLln7SSy3oIxEVEyCmfsssdbOFm1pJOwDUxpSA+6ODxwMf7RjU
 6oWP2kdFp/vdtPYQsgRxZMpQ0Jslcc5aAkWchBfoZ8Xt7jMxWvLKgzJclPjYKSxpGqcQ
 vljj+vMFW9e6drSPlsec9zYUk/SFOk4iixFUjzn8Kk9jZ7iknf9iCHthn0yDaeL2bPvH
 1YxA==
X-Gm-Message-State: AOAM5313czzdwfLYeWSiVykBGE8zvgccB1JV1VAs3sJ6uUJR0JfrYBxq
 Gl/lCeZE2cJW6OpRnspsyUQo0bhJCVucPV+pbWIrgsj6iAM1dwHrFbrXAchd6aCII3qXqSVjBYe
 lb2VRhdDTI+I65Jw=
X-Received: by 2002:a1c:20ce:: with SMTP id g197mr4147754wmg.72.1601377997422; 
 Tue, 29 Sep 2020 04:13:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwS1aE+cpT1uFeOpQi+b1AMooEea3jqhRp8rv85yi3LMXpSTLOmtS6MRvjZKw6IGvfWr4jWtw==
X-Received: by 2002:a1c:20ce:: with SMTP id g197mr4147714wmg.72.1601377996971; 
 Tue, 29 Sep 2020 04:13:16 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id t6sm6300883wre.30.2020.09.29.04.13.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 04:13:15 -0700 (PDT)
Date: Tue, 29 Sep 2020 07:13:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/1] acpi: fixup
Message-ID: <20200929111255.381871-1-mst@redhat.com>
MIME-Version: 1.0
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 02:22:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 213057383c9f73a17cfe635b204d88e11f918df1:

  Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into staging (2020-09-29 11:10:29 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to f142e4ede72853aaa7d306bc79b099caed45769b:

  tests/acpi: drop unnecessary files (2020-09-29 07:10:37 -0400)

----------------------------------------------------------------
acpi: fixup

My last pull included a ton of useless files by mistake.
Drop them all.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Michael S. Tsirkin (1):
      tests/acpi: drop unnecessary files

 tests/test-qapi-event.c                            |  198 --
 tests/test-qmp-introspect.c                        |   58 -
 tests/test-qmp-marshal.c                           |  383 ---
 tests/.vhost-user-test.c.swo                       |  Bin 16384 -> 0 bytes
 tests/Makefile.include.orig                        | 1012 ------
 tests/Makefile.orig                                |  569 ----
 tests/bios-tables-test.c.orig                      |  925 -----
 tests/data/acpi/diff-aml.sh                        |    0
 tests/data/acpi/disassemle-aml.py                  |   21 -
 tests/data/acpi/microvm/APIC.dsl                   |   56 -
 tests/data/acpi/microvm/DSDT.dsl                   |  121 -
 tests/data/acpi/microvm/FACP.dsl                   |  196 --
 tests/data/acpi/pc/APIC.acpihmat.dsl               |  112 -
 tests/data/acpi/pc/APIC.bridge                     |  Bin 120 -> 0 bytes
 tests/data/acpi/pc/APIC.bridge.dsl                 |  104 -
 tests/data/acpi/pc/APIC.cphp.dsl                   |  146 -
 tests/data/acpi/pc/APIC.dimmpxm.dsl                |  129 -
 tests/data/acpi/pc/APIC.dsl                        |  104 -
 tests/data/acpi/pc/APIC.hpbridge                   |  Bin 120 -> 0 bytes
 tests/data/acpi/pc/APIC.ipmikcs                    |  Bin 120 -> 0 bytes
 tests/data/acpi/pc/APIC.ipmikcs.dsl                |  104 -
 tests/data/acpi/pc/APIC.memhp                      |  Bin 120 -> 0 bytes
 tests/data/acpi/pc/APIC.memhp.dsl                  |  104 -
 tests/data/acpi/pc/APIC.numamem                    |  Bin 120 -> 0 bytes
 tests/data/acpi/pc/APIC.numamem.dsl                |  104 -
 tests/data/acpi/pc/APIC.roothp                     |  Bin 120 -> 0 bytes
 tests/data/acpi/pc/DSDT.acpihmat.dsl               | 1619 ---------
 tests/data/acpi/pc/DSDT.bridge.dsl                 | 1800 ----------
 tests/data/acpi/pc/DSDT.cphp.dsl                   | 1466 --------
 tests/data/acpi/pc/DSDT.dimmpxm.dsl                | 1719 ----------
 tests/data/acpi/pc/DSDT.dsl                        | 1407 --------
 tests/data/acpi/pc/DSDT.ipmikcs.dsl                | 1337 --------
 tests/data/acpi/pc/DSDT.memhp.dsl                  | 1625 ---------
 tests/data/acpi/pc/DSDT.numamem.dsl                | 1321 --------
 tests/data/acpi/pc/FACP.acpihmat                   |  Bin 116 -> 0 bytes
 tests/data/acpi/pc/FACP.acpihmat.dsl               |   99 -
 tests/data/acpi/pc/FACP.bridge                     |  Bin 116 -> 0 bytes
 tests/data/acpi/pc/FACP.bridge.dsl                 |   99 -
 tests/data/acpi/pc/FACP.cphp                       |  Bin 116 -> 0 bytes
 tests/data/acpi/pc/FACP.cphp.dsl                   |   99 -
 tests/data/acpi/pc/FACP.dimmpxm                    |  Bin 116 -> 0 bytes
 tests/data/acpi/pc/FACP.dimmpxm.dsl                |   99 -
 tests/data/acpi/pc/FACP.dsl                        |   99 -
 tests/data/acpi/pc/FACP.hpbridge                   |  Bin 116 -> 0 bytes
 tests/data/acpi/pc/FACP.ipmikcs                    |  Bin 116 -> 0 bytes
 tests/data/acpi/pc/FACP.ipmikcs.dsl                |   99 -
 tests/data/acpi/pc/FACP.memhp                      |  Bin 116 -> 0 bytes
 tests/data/acpi/pc/FACP.memhp.dsl                  |   99 -
 tests/data/acpi/pc/FACP.numamem                    |  Bin 116 -> 0 bytes
 tests/data/acpi/pc/FACP.numamem.dsl                |   99 -
 tests/data/acpi/pc/FACP.roothp                     |  Bin 116 -> 0 bytes
 tests/data/acpi/pc/FACS.acpihmat                   |  Bin 64 -> 0 bytes
 tests/data/acpi/pc/FACS.acpihmat.dsl               |   32 -
 tests/data/acpi/pc/FACS.bridge                     |  Bin 64 -> 0 bytes
 tests/data/acpi/pc/FACS.bridge.dsl                 |   32 -
 tests/data/acpi/pc/FACS.cphp                       |  Bin 64 -> 0 bytes
 tests/data/acpi/pc/FACS.cphp.dsl                   |   32 -
 tests/data/acpi/pc/FACS.dimmpxm                    |  Bin 64 -> 0 bytes
 tests/data/acpi/pc/FACS.dimmpxm.dsl                |   32 -
 tests/data/acpi/pc/FACS.dsl                        |   32 -
 tests/data/acpi/pc/FACS.hpbridge                   |  Bin 64 -> 0 bytes
 tests/data/acpi/pc/FACS.ipmikcs                    |  Bin 64 -> 0 bytes
 tests/data/acpi/pc/FACS.ipmikcs.dsl                |   32 -
 tests/data/acpi/pc/FACS.memhp                      |  Bin 64 -> 0 bytes
 tests/data/acpi/pc/FACS.memhp.dsl                  |   32 -
 tests/data/acpi/pc/FACS.numamem                    |  Bin 64 -> 0 bytes
 tests/data/acpi/pc/FACS.numamem.dsl                |   32 -
 tests/data/acpi/pc/FACS.roothp                     |  Bin 64 -> 0 bytes
 tests/data/acpi/pc/HMAT.acpihmat.dsl               |  132 -
 tests/data/acpi/pc/HMAT.dsl                        |  132 -
 tests/data/acpi/pc/HPET.acpihmat                   |  Bin 56 -> 0 bytes
 tests/data/acpi/pc/HPET.acpihmat.dsl               |   43 -
 tests/data/acpi/pc/HPET.bridge                     |  Bin 56 -> 0 bytes
 tests/data/acpi/pc/HPET.bridge.dsl                 |   43 -
 tests/data/acpi/pc/HPET.cphp                       |  Bin 56 -> 0 bytes
 tests/data/acpi/pc/HPET.cphp.dsl                   |   43 -
 tests/data/acpi/pc/HPET.dimmpxm                    |  Bin 56 -> 0 bytes
 tests/data/acpi/pc/HPET.dimmpxm.dsl                |   43 -
 tests/data/acpi/pc/HPET.dsl                        |   43 -
 tests/data/acpi/pc/HPET.hpbridge                   |  Bin 56 -> 0 bytes
 tests/data/acpi/pc/HPET.ipmikcs                    |  Bin 56 -> 0 bytes
 tests/data/acpi/pc/HPET.ipmikcs.dsl                |   43 -
 tests/data/acpi/pc/HPET.memhp                      |  Bin 56 -> 0 bytes
 tests/data/acpi/pc/HPET.memhp.dsl                  |   43 -
 tests/data/acpi/pc/HPET.numamem                    |  Bin 56 -> 0 bytes
 tests/data/acpi/pc/HPET.numamem.dsl                |   43 -
 tests/data/acpi/pc/HPET.roothp                     |  Bin 56 -> 0 bytes
 tests/data/acpi/pc/NFIT.dimmpxm.dsl                |  115 -
 tests/data/acpi/pc/NFIT.dsl                        |  115 -
 tests/data/acpi/pc/SLIT.cphp.dsl                   |   31 -
 tests/data/acpi/pc/SLIT.dsl                        |   31 -
 tests/data/acpi/pc/SLIT.memhp.dsl                  |   31 -
 tests/data/acpi/pc/SRAT.acpihmat.dsl               |  137 -
 tests/data/acpi/pc/SRAT.cphp.dsl                   |  168 -
 tests/data/acpi/pc/SRAT.dimmpxm.dsl                |  194 --
 tests/data/acpi/pc/SRAT.dsl                        |  108 -
 tests/data/acpi/pc/SRAT.memhp.dsl                  |  125 -
 tests/data/acpi/pc/SRAT.numamem.dsl                |  108 -
 tests/data/acpi/pc/SSDT.dsl                        |  205 --
 tests/data/acpi/pc/WAET.acpihmat                   |  Bin 40 -> 0 bytes
 tests/data/acpi/pc/WAET.acpihmat.dsl               |   31 -
 tests/data/acpi/pc/WAET.bridge                     |  Bin 40 -> 0 bytes
 tests/data/acpi/pc/WAET.bridge.dsl                 |   31 -
 tests/data/acpi/pc/WAET.cphp                       |  Bin 40 -> 0 bytes
 tests/data/acpi/pc/WAET.cphp.dsl                   |   31 -
 tests/data/acpi/pc/WAET.dimmpxm                    |  Bin 40 -> 0 bytes
 tests/data/acpi/pc/WAET.dimmpxm.dsl                |   31 -
 tests/data/acpi/pc/WAET.dsl                        |   31 -
 tests/data/acpi/pc/WAET.hpbridge                   |  Bin 40 -> 0 bytes
 tests/data/acpi/pc/WAET.ipmikcs                    |  Bin 40 -> 0 bytes
 tests/data/acpi/pc/WAET.ipmikcs.dsl                |   31 -
 tests/data/acpi/pc/WAET.memhp                      |  Bin 40 -> 0 bytes
 tests/data/acpi/pc/WAET.memhp.dsl                  |   31 -
 tests/data/acpi/pc/WAET.numamem                    |  Bin 40 -> 0 bytes
 tests/data/acpi/pc/WAET.numamem.dsl                |   31 -
 tests/data/acpi/pc/WAET.roothp                     |  Bin 40 -> 0 bytes
 tests/data/acpi/q35/APIC.acpihmat.dsl              |  112 -
 tests/data/acpi/q35/APIC.bridge                    |  Bin 120 -> 0 bytes
 tests/data/acpi/q35/APIC.bridge.dsl                |  104 -
 tests/data/acpi/q35/APIC.cphp.dsl                  |  146 -
 tests/data/acpi/q35/APIC.dimmpxm.dsl               |  129 -
 tests/data/acpi/q35/APIC.dsl                       |  104 -
 tests/data/acpi/q35/APIC.ipmibt                    |  Bin 120 -> 0 bytes
 tests/data/acpi/q35/APIC.ipmibt.dsl                |  104 -
 tests/data/acpi/q35/APIC.memhp                     |  Bin 120 -> 0 bytes
 tests/data/acpi/q35/APIC.memhp.dsl                 |  104 -
 tests/data/acpi/q35/APIC.mmio64                    |  Bin 120 -> 0 bytes
 tests/data/acpi/q35/APIC.mmio64.dsl                |  104 -
 tests/data/acpi/q35/APIC.numamem                   |  Bin 120 -> 0 bytes
 tests/data/acpi/q35/APIC.numamem.dsl               |  104 -
 tests/data/acpi/q35/APIC.tis                       |  Bin 120 -> 0 bytes
 tests/data/acpi/q35/APIC.tis.dsl                   |  104 -
 tests/data/acpi/q35/DSDT.acpihmat.dsl              | 3436 -------------------
 tests/data/acpi/q35/DSDT.bridge.dsl                | 3141 -----------------
 tests/data/acpi/q35/DSDT.cphp.dsl                  | 3283 ------------------
 tests/data/acpi/q35/DSDT.dimmpxm.dsl               | 3535 --------------------
 tests/data/acpi/q35/DSDT.dsl                       | 3351 -------------------
 tests/data/acpi/q35/DSDT.ipmibt.dsl                | 3156 -----------------
 tests/data/acpi/q35/DSDT.memhp.dsl                 | 3442 -------------------
 tests/data/acpi/q35/DSDT.mmio64.dsl                | 3377 -------------------
 tests/data/acpi/q35/DSDT.numamem.dsl               | 3138 -----------------
 tests/data/acpi/q35/DSDT.tis.dsl                   | 3321 ------------------
 tests/data/acpi/q35/FACP.acpihmat                  |  Bin 244 -> 0 bytes
 tests/data/acpi/q35/FACP.acpihmat.dsl              |  179 -
 tests/data/acpi/q35/FACP.bridge                    |  Bin 244 -> 0 bytes
 tests/data/acpi/q35/FACP.bridge.dsl                |  179 -
 tests/data/acpi/q35/FACP.cphp                      |  Bin 244 -> 0 bytes
 tests/data/acpi/q35/FACP.cphp.dsl                  |  179 -
 tests/data/acpi/q35/FACP.dimmpxm                   |  Bin 244 -> 0 bytes
 tests/data/acpi/q35/FACP.dimmpxm.dsl               |  179 -
 tests/data/acpi/q35/FACP.dsl                       |  179 -
 tests/data/acpi/q35/FACP.ipmibt                    |  Bin 244 -> 0 bytes
 tests/data/acpi/q35/FACP.ipmibt.dsl                |  179 -
 tests/data/acpi/q35/FACP.memhp                     |  Bin 244 -> 0 bytes
 tests/data/acpi/q35/FACP.memhp.dsl                 |  179 -
 tests/data/acpi/q35/FACP.mmio64                    |  Bin 244 -> 0 bytes
 tests/data/acpi/q35/FACP.mmio64.dsl                |  179 -
 tests/data/acpi/q35/FACP.numamem                   |  Bin 244 -> 0 bytes
 tests/data/acpi/q35/FACP.numamem.dsl               |  179 -
 tests/data/acpi/q35/FACP.tis                       |  Bin 244 -> 0 bytes
 tests/data/acpi/q35/FACP.tis.dsl                   |  179 -
 tests/data/acpi/q35/FACS.acpihmat                  |  Bin 64 -> 0 bytes
 tests/data/acpi/q35/FACS.acpihmat.dsl              |   32 -
 tests/data/acpi/q35/FACS.bridge                    |  Bin 64 -> 0 bytes
 tests/data/acpi/q35/FACS.bridge.dsl                |   32 -
 tests/data/acpi/q35/FACS.cphp                      |  Bin 64 -> 0 bytes
 tests/data/acpi/q35/FACS.cphp.dsl                  |   32 -
 tests/data/acpi/q35/FACS.dimmpxm                   |  Bin 64 -> 0 bytes
 tests/data/acpi/q35/FACS.dimmpxm.dsl               |   32 -
 tests/data/acpi/q35/FACS.dsl                       |   32 -
 tests/data/acpi/q35/FACS.ipmibt                    |  Bin 64 -> 0 bytes
 tests/data/acpi/q35/FACS.ipmibt.dsl                |   32 -
 tests/data/acpi/q35/FACS.memhp                     |  Bin 64 -> 0 bytes
 tests/data/acpi/q35/FACS.memhp.dsl                 |   32 -
 tests/data/acpi/q35/FACS.mmio64                    |  Bin 64 -> 0 bytes
 tests/data/acpi/q35/FACS.mmio64.dsl                |   32 -
 tests/data/acpi/q35/FACS.numamem                   |  Bin 64 -> 0 bytes
 tests/data/acpi/q35/FACS.numamem.dsl               |   32 -
 tests/data/acpi/q35/FACS.tis                       |  Bin 64 -> 0 bytes
 tests/data/acpi/q35/FACS.tis.dsl                   |   32 -
 tests/data/acpi/q35/HMAT.acpihmat.dsl              |  132 -
 tests/data/acpi/q35/HMAT.dsl                       |  132 -
 tests/data/acpi/q35/HPET.acpihmat                  |  Bin 56 -> 0 bytes
 tests/data/acpi/q35/HPET.acpihmat.dsl              |   43 -
 tests/data/acpi/q35/HPET.bridge                    |  Bin 56 -> 0 bytes
 tests/data/acpi/q35/HPET.bridge.dsl                |   43 -
 tests/data/acpi/q35/HPET.cphp                      |  Bin 56 -> 0 bytes
 tests/data/acpi/q35/HPET.cphp.dsl                  |   43 -
 tests/data/acpi/q35/HPET.dimmpxm                   |  Bin 56 -> 0 bytes
 tests/data/acpi/q35/HPET.dimmpxm.dsl               |   43 -
 tests/data/acpi/q35/HPET.dsl                       |   43 -
 tests/data/acpi/q35/HPET.ipmibt                    |  Bin 56 -> 0 bytes
 tests/data/acpi/q35/HPET.ipmibt.dsl                |   43 -
 tests/data/acpi/q35/HPET.memhp                     |  Bin 56 -> 0 bytes
 tests/data/acpi/q35/HPET.memhp.dsl                 |   43 -
 tests/data/acpi/q35/HPET.mmio64                    |  Bin 56 -> 0 bytes
 tests/data/acpi/q35/HPET.mmio64.dsl                |   43 -
 tests/data/acpi/q35/HPET.numamem                   |  Bin 56 -> 0 bytes
 tests/data/acpi/q35/HPET.numamem.dsl               |   43 -
 tests/data/acpi/q35/HPET.tis                       |  Bin 56 -> 0 bytes
 tests/data/acpi/q35/HPET.tis.dsl                   |   43 -
 tests/data/acpi/q35/MCFG.acpihmat                  |  Bin 60 -> 0 bytes
 tests/data/acpi/q35/MCFG.acpihmat.dsl              |   36 -
 tests/data/acpi/q35/MCFG.bridge                    |  Bin 60 -> 0 bytes
 tests/data/acpi/q35/MCFG.bridge.dsl                |   36 -
 tests/data/acpi/q35/MCFG.cphp                      |  Bin 60 -> 0 bytes
 tests/data/acpi/q35/MCFG.cphp.dsl                  |   36 -
 tests/data/acpi/q35/MCFG.dimmpxm                   |  Bin 60 -> 0 bytes
 tests/data/acpi/q35/MCFG.dimmpxm.dsl               |   36 -
 tests/data/acpi/q35/MCFG.dsl                       |   36 -
 tests/data/acpi/q35/MCFG.ipmibt                    |  Bin 60 -> 0 bytes
 tests/data/acpi/q35/MCFG.ipmibt.dsl                |   36 -
 tests/data/acpi/q35/MCFG.memhp                     |  Bin 60 -> 0 bytes
 tests/data/acpi/q35/MCFG.memhp.dsl                 |   36 -
 tests/data/acpi/q35/MCFG.mmio64                    |  Bin 60 -> 0 bytes
 tests/data/acpi/q35/MCFG.mmio64.dsl                |   36 -
 tests/data/acpi/q35/MCFG.numamem                   |  Bin 60 -> 0 bytes
 tests/data/acpi/q35/MCFG.numamem.dsl               |   36 -
 tests/data/acpi/q35/MCFG.tis                       |  Bin 60 -> 0 bytes
 tests/data/acpi/q35/MCFG.tis.dsl                   |   36 -
 tests/data/acpi/q35/NFIT.dimmpxm.dsl               |  115 -
 tests/data/acpi/q35/NFIT.dsl                       |  115 -
 tests/data/acpi/q35/SLIT.cphp.dsl                  |   31 -
 tests/data/acpi/q35/SLIT.dsl                       |   31 -
 tests/data/acpi/q35/SLIT.memhp.dsl                 |   31 -
 tests/data/acpi/q35/SRAT.acpihmat.dsl              |  137 -
 tests/data/acpi/q35/SRAT.cphp.dsl                  |  168 -
 tests/data/acpi/q35/SRAT.dimmpxm.dsl               |  194 --
 tests/data/acpi/q35/SRAT.dsl                       |  108 -
 tests/data/acpi/q35/SRAT.memhp.dsl                 |  125 -
 tests/data/acpi/q35/SRAT.mmio64.dsl                |  108 -
 tests/data/acpi/q35/SRAT.numamem.dsl               |  108 -
 tests/data/acpi/q35/SSDT.dsl                       |  205 --
 tests/data/acpi/q35/TPM2.dsl                       |   38 -
 tests/data/acpi/q35/TPM2.tis.dsl                   |   38 -
 tests/data/acpi/q35/WAET.acpihmat                  |  Bin 40 -> 0 bytes
 tests/data/acpi/q35/WAET.acpihmat.dsl              |   31 -
 tests/data/acpi/q35/WAET.bridge                    |  Bin 40 -> 0 bytes
 tests/data/acpi/q35/WAET.bridge.dsl                |   31 -
 tests/data/acpi/q35/WAET.cphp                      |  Bin 40 -> 0 bytes
 tests/data/acpi/q35/WAET.cphp.dsl                  |   31 -
 tests/data/acpi/q35/WAET.dimmpxm                   |  Bin 40 -> 0 bytes
 tests/data/acpi/q35/WAET.dimmpxm.dsl               |   31 -
 tests/data/acpi/q35/WAET.dsl                       |   31 -
 tests/data/acpi/q35/WAET.ipmibt                    |  Bin 40 -> 0 bytes
 tests/data/acpi/q35/WAET.ipmibt.dsl                |   31 -
 tests/data/acpi/q35/WAET.memhp                     |  Bin 40 -> 0 bytes
 tests/data/acpi/q35/WAET.memhp.dsl                 |   31 -
 tests/data/acpi/q35/WAET.mmio64                    |  Bin 40 -> 0 bytes
 tests/data/acpi/q35/WAET.mmio64.dsl                |   31 -
 tests/data/acpi/q35/WAET.numamem                   |  Bin 40 -> 0 bytes
 tests/data/acpi/q35/WAET.numamem.dsl               |   31 -
 tests/data/acpi/q35/WAET.tis                       |  Bin 40 -> 0 bytes
 tests/data/acpi/q35/WAET.tis.dsl                   |   31 -
 tests/data/acpi/virt/APIC.dsl                      |   78 -
 tests/data/acpi/virt/APIC.memhp.dsl                |   78 -
 tests/data/acpi/virt/APIC.numamem.dsl              |   78 -
 tests/data/acpi/virt/DSDT.dsl                      | 1906 -----------
 tests/data/acpi/virt/DSDT.memhp.dsl                | 2215 ------------
 tests/data/acpi/virt/DSDT.numamem.dsl              | 1906 -----------
 tests/data/acpi/virt/FACP.dsl                      |  196 --
 tests/data/acpi/virt/FACP.memhp.dsl                |  196 --
 tests/data/acpi/virt/FACP.numamem.dsl              |  196 --
 tests/data/acpi/virt/GTDT.dsl                      |   61 -
 tests/data/acpi/virt/GTDT.memhp.dsl                |   61 -
 tests/data/acpi/virt/GTDT.numamem.dsl              |   61 -
 tests/data/acpi/virt/MCFG.dsl                      |   36 -
 tests/data/acpi/virt/MCFG.memhp.dsl                |   36 -
 tests/data/acpi/virt/MCFG.numamem.dsl              |   36 -
 tests/data/acpi/virt/NFIT.dsl                      |  103 -
 tests/data/acpi/virt/NFIT.memhp.dsl                |  103 -
 tests/data/acpi/virt/SLIT.dsl                      |   31 -
 tests/data/acpi/virt/SLIT.memhp.dsl                |   31 -
 tests/data/acpi/virt/SPCR.dsl                      |   57 -
 tests/data/acpi/virt/SPCR.memhp.dsl                |   57 -
 tests/data/acpi/virt/SPCR.numamem.dsl              |   57 -
 tests/data/acpi/virt/SRAT.dsl                      |   57 -
 tests/data/acpi/virt/SRAT.memhp.dsl                |  107 -
 tests/data/acpi/virt/SRAT.numamem.dsl              |   57 -
 tests/data/acpi/virt/SSDT.dsl                      |  205 --
 .../bios-tables-test.x86_64.iso.raw                |  Bin 425984 -> 0 bytes
 tests/libqtest.c.orig                              | 1106 ------
 tests/qemu-iotests/core.12067                      |  Bin 22716416 -> 0 bytes
 tests/qtest/bios-tables-test-allowed-diff.h.orig   |   18 -
 tests/qtest/bios-tables-test-allowed-diff.h.rej    |    9 -
 tests/qtest/bios-tables-test.c.orig                | 1200 -------
 tests/qtest/bios-tables-test.c.rej                 |   22 -
 tests/vhost-user-bridge                            |  Bin 83120 -> 0 bytes
 tests/vhost-user-bridge.c.orig                     | 1432 --------
 tests/vhost-user-test.c.orig                       |  364 --
 290 files changed, 71489 deletions(-)
 delete mode 100644 tests/test-qapi-event.c
 delete mode 100644 tests/test-qmp-introspect.c
 delete mode 100644 tests/test-qmp-marshal.c
 delete mode 100644 tests/.vhost-user-test.c.swo
 delete mode 100644 tests/Makefile.include.orig
 delete mode 100644 tests/Makefile.orig
 delete mode 100644 tests/bios-tables-test.c.orig
 delete mode 100644 tests/data/acpi/diff-aml.sh
 delete mode 100644 tests/data/acpi/disassemle-aml.py
 delete mode 100644 tests/data/acpi/microvm/APIC.dsl
 delete mode 100644 tests/data/acpi/microvm/DSDT.dsl
 delete mode 100644 tests/data/acpi/microvm/FACP.dsl
 delete mode 100644 tests/data/acpi/pc/APIC.acpihmat.dsl
 delete mode 100644 tests/data/acpi/pc/APIC.bridge
 delete mode 100644 tests/data/acpi/pc/APIC.bridge.dsl
 delete mode 100644 tests/data/acpi/pc/APIC.cphp.dsl
 delete mode 100644 tests/data/acpi/pc/APIC.dimmpxm.dsl
 delete mode 100644 tests/data/acpi/pc/APIC.dsl
 delete mode 100644 tests/data/acpi/pc/APIC.hpbridge
 delete mode 100644 tests/data/acpi/pc/APIC.ipmikcs
 delete mode 100644 tests/data/acpi/pc/APIC.ipmikcs.dsl
 delete mode 100644 tests/data/acpi/pc/APIC.memhp
 delete mode 100644 tests/data/acpi/pc/APIC.memhp.dsl
 delete mode 100644 tests/data/acpi/pc/APIC.numamem
 delete mode 100644 tests/data/acpi/pc/APIC.numamem.dsl
 delete mode 100644 tests/data/acpi/pc/APIC.roothp
 delete mode 100644 tests/data/acpi/pc/DSDT.acpihmat.dsl
 delete mode 100644 tests/data/acpi/pc/DSDT.bridge.dsl
 delete mode 100644 tests/data/acpi/pc/DSDT.cphp.dsl
 delete mode 100644 tests/data/acpi/pc/DSDT.dimmpxm.dsl
 delete mode 100644 tests/data/acpi/pc/DSDT.dsl
 delete mode 100644 tests/data/acpi/pc/DSDT.ipmikcs.dsl
 delete mode 100644 tests/data/acpi/pc/DSDT.memhp.dsl
 delete mode 100644 tests/data/acpi/pc/DSDT.numamem.dsl
 delete mode 100644 tests/data/acpi/pc/FACP.acpihmat
 delete mode 100644 tests/data/acpi/pc/FACP.acpihmat.dsl
 delete mode 100644 tests/data/acpi/pc/FACP.bridge
 delete mode 100644 tests/data/acpi/pc/FACP.bridge.dsl
 delete mode 100644 tests/data/acpi/pc/FACP.cphp
 delete mode 100644 tests/data/acpi/pc/FACP.cphp.dsl
 delete mode 100644 tests/data/acpi/pc/FACP.dimmpxm
 delete mode 100644 tests/data/acpi/pc/FACP.dimmpxm.dsl
 delete mode 100644 tests/data/acpi/pc/FACP.dsl
 delete mode 100644 tests/data/acpi/pc/FACP.hpbridge
 delete mode 100644 tests/data/acpi/pc/FACP.ipmikcs
 delete mode 100644 tests/data/acpi/pc/FACP.ipmikcs.dsl
 delete mode 100644 tests/data/acpi/pc/FACP.memhp
 delete mode 100644 tests/data/acpi/pc/FACP.memhp.dsl
 delete mode 100644 tests/data/acpi/pc/FACP.numamem
 delete mode 100644 tests/data/acpi/pc/FACP.numamem.dsl
 delete mode 100644 tests/data/acpi/pc/FACP.roothp
 delete mode 100644 tests/data/acpi/pc/FACS.acpihmat
 delete mode 100644 tests/data/acpi/pc/FACS.acpihmat.dsl
 delete mode 100644 tests/data/acpi/pc/FACS.bridge
 delete mode 100644 tests/data/acpi/pc/FACS.bridge.dsl
 delete mode 100644 tests/data/acpi/pc/FACS.cphp
 delete mode 100644 tests/data/acpi/pc/FACS.cphp.dsl
 delete mode 100644 tests/data/acpi/pc/FACS.dimmpxm
 delete mode 100644 tests/data/acpi/pc/FACS.dimmpxm.dsl
 delete mode 100644 tests/data/acpi/pc/FACS.dsl
 delete mode 100644 tests/data/acpi/pc/FACS.hpbridge
 delete mode 100644 tests/data/acpi/pc/FACS.ipmikcs
 delete mode 100644 tests/data/acpi/pc/FACS.ipmikcs.dsl
 delete mode 100644 tests/data/acpi/pc/FACS.memhp
 delete mode 100644 tests/data/acpi/pc/FACS.memhp.dsl
 delete mode 100644 tests/data/acpi/pc/FACS.numamem
 delete mode 100644 tests/data/acpi/pc/FACS.numamem.dsl
 delete mode 100644 tests/data/acpi/pc/FACS.roothp
 delete mode 100644 tests/data/acpi/pc/HMAT.acpihmat.dsl
 delete mode 100644 tests/data/acpi/pc/HMAT.dsl
 delete mode 100644 tests/data/acpi/pc/HPET.acpihmat
 delete mode 100644 tests/data/acpi/pc/HPET.acpihmat.dsl
 delete mode 100644 tests/data/acpi/pc/HPET.bridge
 delete mode 100644 tests/data/acpi/pc/HPET.bridge.dsl
 delete mode 100644 tests/data/acpi/pc/HPET.cphp
 delete mode 100644 tests/data/acpi/pc/HPET.cphp.dsl
 delete mode 100644 tests/data/acpi/pc/HPET.dimmpxm
 delete mode 100644 tests/data/acpi/pc/HPET.dimmpxm.dsl
 delete mode 100644 tests/data/acpi/pc/HPET.dsl
 delete mode 100644 tests/data/acpi/pc/HPET.hpbridge
 delete mode 100644 tests/data/acpi/pc/HPET.ipmikcs
 delete mode 100644 tests/data/acpi/pc/HPET.ipmikcs.dsl
 delete mode 100644 tests/data/acpi/pc/HPET.memhp
 delete mode 100644 tests/data/acpi/pc/HPET.memhp.dsl
 delete mode 100644 tests/data/acpi/pc/HPET.numamem
 delete mode 100644 tests/data/acpi/pc/HPET.numamem.dsl
 delete mode 100644 tests/data/acpi/pc/HPET.roothp
 delete mode 100644 tests/data/acpi/pc/NFIT.dimmpxm.dsl
 delete mode 100644 tests/data/acpi/pc/NFIT.dsl
 delete mode 100644 tests/data/acpi/pc/SLIT.cphp.dsl
 delete mode 100644 tests/data/acpi/pc/SLIT.dsl
 delete mode 100644 tests/data/acpi/pc/SLIT.memhp.dsl
 delete mode 100644 tests/data/acpi/pc/SRAT.acpihmat.dsl
 delete mode 100644 tests/data/acpi/pc/SRAT.cphp.dsl
 delete mode 100644 tests/data/acpi/pc/SRAT.dimmpxm.dsl
 delete mode 100644 tests/data/acpi/pc/SRAT.dsl
 delete mode 100644 tests/data/acpi/pc/SRAT.memhp.dsl
 delete mode 100644 tests/data/acpi/pc/SRAT.numamem.dsl
 delete mode 100644 tests/data/acpi/pc/SSDT.dsl
 delete mode 100644 tests/data/acpi/pc/WAET.acpihmat
 delete mode 100644 tests/data/acpi/pc/WAET.acpihmat.dsl
 delete mode 100644 tests/data/acpi/pc/WAET.bridge
 delete mode 100644 tests/data/acpi/pc/WAET.bridge.dsl
 delete mode 100644 tests/data/acpi/pc/WAET.cphp
 delete mode 100644 tests/data/acpi/pc/WAET.cphp.dsl
 delete mode 100644 tests/data/acpi/pc/WAET.dimmpxm
 delete mode 100644 tests/data/acpi/pc/WAET.dimmpxm.dsl
 delete mode 100644 tests/data/acpi/pc/WAET.dsl
 delete mode 100644 tests/data/acpi/pc/WAET.hpbridge
 delete mode 100644 tests/data/acpi/pc/WAET.ipmikcs
 delete mode 100644 tests/data/acpi/pc/WAET.ipmikcs.dsl
 delete mode 100644 tests/data/acpi/pc/WAET.memhp
 delete mode 100644 tests/data/acpi/pc/WAET.memhp.dsl
 delete mode 100644 tests/data/acpi/pc/WAET.numamem
 delete mode 100644 tests/data/acpi/pc/WAET.numamem.dsl
 delete mode 100644 tests/data/acpi/pc/WAET.roothp
 delete mode 100644 tests/data/acpi/q35/APIC.acpihmat.dsl
 delete mode 100644 tests/data/acpi/q35/APIC.bridge
 delete mode 100644 tests/data/acpi/q35/APIC.bridge.dsl
 delete mode 100644 tests/data/acpi/q35/APIC.cphp.dsl
 delete mode 100644 tests/data/acpi/q35/APIC.dimmpxm.dsl
 delete mode 100644 tests/data/acpi/q35/APIC.dsl
 delete mode 100644 tests/data/acpi/q35/APIC.ipmibt
 delete mode 100644 tests/data/acpi/q35/APIC.ipmibt.dsl
 delete mode 100644 tests/data/acpi/q35/APIC.memhp
 delete mode 100644 tests/data/acpi/q35/APIC.memhp.dsl
 delete mode 100644 tests/data/acpi/q35/APIC.mmio64
 delete mode 100644 tests/data/acpi/q35/APIC.mmio64.dsl
 delete mode 100644 tests/data/acpi/q35/APIC.numamem
 delete mode 100644 tests/data/acpi/q35/APIC.numamem.dsl
 delete mode 100644 tests/data/acpi/q35/APIC.tis
 delete mode 100644 tests/data/acpi/q35/APIC.tis.dsl
 delete mode 100644 tests/data/acpi/q35/DSDT.acpihmat.dsl
 delete mode 100644 tests/data/acpi/q35/DSDT.bridge.dsl
 delete mode 100644 tests/data/acpi/q35/DSDT.cphp.dsl
 delete mode 100644 tests/data/acpi/q35/DSDT.dimmpxm.dsl
 delete mode 100644 tests/data/acpi/q35/DSDT.dsl
 delete mode 100644 tests/data/acpi/q35/DSDT.ipmibt.dsl
 delete mode 100644 tests/data/acpi/q35/DSDT.memhp.dsl
 delete mode 100644 tests/data/acpi/q35/DSDT.mmio64.dsl
 delete mode 100644 tests/data/acpi/q35/DSDT.numamem.dsl
 delete mode 100644 tests/data/acpi/q35/DSDT.tis.dsl
 delete mode 100644 tests/data/acpi/q35/FACP.acpihmat
 delete mode 100644 tests/data/acpi/q35/FACP.acpihmat.dsl
 delete mode 100644 tests/data/acpi/q35/FACP.bridge
 delete mode 100644 tests/data/acpi/q35/FACP.bridge.dsl
 delete mode 100644 tests/data/acpi/q35/FACP.cphp
 delete mode 100644 tests/data/acpi/q35/FACP.cphp.dsl
 delete mode 100644 tests/data/acpi/q35/FACP.dimmpxm
 delete mode 100644 tests/data/acpi/q35/FACP.dimmpxm.dsl
 delete mode 100644 tests/data/acpi/q35/FACP.dsl
 delete mode 100644 tests/data/acpi/q35/FACP.ipmibt
 delete mode 100644 tests/data/acpi/q35/FACP.ipmibt.dsl
 delete mode 100644 tests/data/acpi/q35/FACP.memhp
 delete mode 100644 tests/data/acpi/q35/FACP.memhp.dsl
 delete mode 100644 tests/data/acpi/q35/FACP.mmio64
 delete mode 100644 tests/data/acpi/q35/FACP.mmio64.dsl
 delete mode 100644 tests/data/acpi/q35/FACP.numamem
 delete mode 100644 tests/data/acpi/q35/FACP.numamem.dsl
 delete mode 100644 tests/data/acpi/q35/FACP.tis
 delete mode 100644 tests/data/acpi/q35/FACP.tis.dsl
 delete mode 100644 tests/data/acpi/q35/FACS.acpihmat
 delete mode 100644 tests/data/acpi/q35/FACS.acpihmat.dsl
 delete mode 100644 tests/data/acpi/q35/FACS.bridge
 delete mode 100644 tests/data/acpi/q35/FACS.bridge.dsl
 delete mode 100644 tests/data/acpi/q35/FACS.cphp
 delete mode 100644 tests/data/acpi/q35/FACS.cphp.dsl
 delete mode 100644 tests/data/acpi/q35/FACS.dimmpxm
 delete mode 100644 tests/data/acpi/q35/FACS.dimmpxm.dsl
 delete mode 100644 tests/data/acpi/q35/FACS.dsl
 delete mode 100644 tests/data/acpi/q35/FACS.ipmibt
 delete mode 100644 tests/data/acpi/q35/FACS.ipmibt.dsl
 delete mode 100644 tests/data/acpi/q35/FACS.memhp
 delete mode 100644 tests/data/acpi/q35/FACS.memhp.dsl
 delete mode 100644 tests/data/acpi/q35/FACS.mmio64
 delete mode 100644 tests/data/acpi/q35/FACS.mmio64.dsl
 delete mode 100644 tests/data/acpi/q35/FACS.numamem
 delete mode 100644 tests/data/acpi/q35/FACS.numamem.dsl
 delete mode 100644 tests/data/acpi/q35/FACS.tis
 delete mode 100644 tests/data/acpi/q35/FACS.tis.dsl
 delete mode 100644 tests/data/acpi/q35/HMAT.acpihmat.dsl
 delete mode 100644 tests/data/acpi/q35/HMAT.dsl
 delete mode 100644 tests/data/acpi/q35/HPET.acpihmat
 delete mode 100644 tests/data/acpi/q35/HPET.acpihmat.dsl
 delete mode 100644 tests/data/acpi/q35/HPET.bridge
 delete mode 100644 tests/data/acpi/q35/HPET.bridge.dsl
 delete mode 100644 tests/data/acpi/q35/HPET.cphp
 delete mode 100644 tests/data/acpi/q35/HPET.cphp.dsl
 delete mode 100644 tests/data/acpi/q35/HPET.dimmpxm
 delete mode 100644 tests/data/acpi/q35/HPET.dimmpxm.dsl
 delete mode 100644 tests/data/acpi/q35/HPET.dsl
 delete mode 100644 tests/data/acpi/q35/HPET.ipmibt
 delete mode 100644 tests/data/acpi/q35/HPET.ipmibt.dsl
 delete mode 100644 tests/data/acpi/q35/HPET.memhp
 delete mode 100644 tests/data/acpi/q35/HPET.memhp.dsl
 delete mode 100644 tests/data/acpi/q35/HPET.mmio64
 delete mode 100644 tests/data/acpi/q35/HPET.mmio64.dsl
 delete mode 100644 tests/data/acpi/q35/HPET.numamem
 delete mode 100644 tests/data/acpi/q35/HPET.numamem.dsl
 delete mode 100644 tests/data/acpi/q35/HPET.tis
 delete mode 100644 tests/data/acpi/q35/HPET.tis.dsl
 delete mode 100644 tests/data/acpi/q35/MCFG.acpihmat
 delete mode 100644 tests/data/acpi/q35/MCFG.acpihmat.dsl
 delete mode 100644 tests/data/acpi/q35/MCFG.bridge
 delete mode 100644 tests/data/acpi/q35/MCFG.bridge.dsl
 delete mode 100644 tests/data/acpi/q35/MCFG.cphp
 delete mode 100644 tests/data/acpi/q35/MCFG.cphp.dsl
 delete mode 100644 tests/data/acpi/q35/MCFG.dimmpxm
 delete mode 100644 tests/data/acpi/q35/MCFG.dimmpxm.dsl
 delete mode 100644 tests/data/acpi/q35/MCFG.dsl
 delete mode 100644 tests/data/acpi/q35/MCFG.ipmibt
 delete mode 100644 tests/data/acpi/q35/MCFG.ipmibt.dsl
 delete mode 100644 tests/data/acpi/q35/MCFG.memhp
 delete mode 100644 tests/data/acpi/q35/MCFG.memhp.dsl
 delete mode 100644 tests/data/acpi/q35/MCFG.mmio64
 delete mode 100644 tests/data/acpi/q35/MCFG.mmio64.dsl
 delete mode 100644 tests/data/acpi/q35/MCFG.numamem
 delete mode 100644 tests/data/acpi/q35/MCFG.numamem.dsl
 delete mode 100644 tests/data/acpi/q35/MCFG.tis
 delete mode 100644 tests/data/acpi/q35/MCFG.tis.dsl
 delete mode 100644 tests/data/acpi/q35/NFIT.dimmpxm.dsl
 delete mode 100644 tests/data/acpi/q35/NFIT.dsl
 delete mode 100644 tests/data/acpi/q35/SLIT.cphp.dsl
 delete mode 100644 tests/data/acpi/q35/SLIT.dsl
 delete mode 100644 tests/data/acpi/q35/SLIT.memhp.dsl
 delete mode 100644 tests/data/acpi/q35/SRAT.acpihmat.dsl
 delete mode 100644 tests/data/acpi/q35/SRAT.cphp.dsl
 delete mode 100644 tests/data/acpi/q35/SRAT.dimmpxm.dsl
 delete mode 100644 tests/data/acpi/q35/SRAT.dsl
 delete mode 100644 tests/data/acpi/q35/SRAT.memhp.dsl
 delete mode 100644 tests/data/acpi/q35/SRAT.mmio64.dsl
 delete mode 100644 tests/data/acpi/q35/SRAT.numamem.dsl
 delete mode 100644 tests/data/acpi/q35/SSDT.dsl
 delete mode 100644 tests/data/acpi/q35/TPM2.dsl
 delete mode 100644 tests/data/acpi/q35/TPM2.tis.dsl
 delete mode 100644 tests/data/acpi/q35/WAET.acpihmat
 delete mode 100644 tests/data/acpi/q35/WAET.acpihmat.dsl
 delete mode 100644 tests/data/acpi/q35/WAET.bridge
 delete mode 100644 tests/data/acpi/q35/WAET.bridge.dsl
 delete mode 100644 tests/data/acpi/q35/WAET.cphp
 delete mode 100644 tests/data/acpi/q35/WAET.cphp.dsl
 delete mode 100644 tests/data/acpi/q35/WAET.dimmpxm
 delete mode 100644 tests/data/acpi/q35/WAET.dimmpxm.dsl
 delete mode 100644 tests/data/acpi/q35/WAET.dsl
 delete mode 100644 tests/data/acpi/q35/WAET.ipmibt
 delete mode 100644 tests/data/acpi/q35/WAET.ipmibt.dsl
 delete mode 100644 tests/data/acpi/q35/WAET.memhp
 delete mode 100644 tests/data/acpi/q35/WAET.memhp.dsl
 delete mode 100644 tests/data/acpi/q35/WAET.mmio64
 delete mode 100644 tests/data/acpi/q35/WAET.mmio64.dsl
 delete mode 100644 tests/data/acpi/q35/WAET.numamem
 delete mode 100644 tests/data/acpi/q35/WAET.numamem.dsl
 delete mode 100644 tests/data/acpi/q35/WAET.tis
 delete mode 100644 tests/data/acpi/q35/WAET.tis.dsl
 delete mode 100644 tests/data/acpi/virt/APIC.dsl
 delete mode 100644 tests/data/acpi/virt/APIC.memhp.dsl
 delete mode 100644 tests/data/acpi/virt/APIC.numamem.dsl
 delete mode 100644 tests/data/acpi/virt/DSDT.dsl
 delete mode 100644 tests/data/acpi/virt/DSDT.memhp.dsl
 delete mode 100644 tests/data/acpi/virt/DSDT.numamem.dsl
 delete mode 100644 tests/data/acpi/virt/FACP.dsl
 delete mode 100644 tests/data/acpi/virt/FACP.memhp.dsl
 delete mode 100644 tests/data/acpi/virt/FACP.numamem.dsl
 delete mode 100644 tests/data/acpi/virt/GTDT.dsl
 delete mode 100644 tests/data/acpi/virt/GTDT.memhp.dsl
 delete mode 100644 tests/data/acpi/virt/GTDT.numamem.dsl
 delete mode 100644 tests/data/acpi/virt/MCFG.dsl
 delete mode 100644 tests/data/acpi/virt/MCFG.memhp.dsl
 delete mode 100644 tests/data/acpi/virt/MCFG.numamem.dsl
 delete mode 100644 tests/data/acpi/virt/NFIT.dsl
 delete mode 100644 tests/data/acpi/virt/NFIT.memhp.dsl
 delete mode 100644 tests/data/acpi/virt/SLIT.dsl
 delete mode 100644 tests/data/acpi/virt/SLIT.memhp.dsl
 delete mode 100644 tests/data/acpi/virt/SPCR.dsl
 delete mode 100644 tests/data/acpi/virt/SPCR.memhp.dsl
 delete mode 100644 tests/data/acpi/virt/SPCR.numamem.dsl
 delete mode 100644 tests/data/acpi/virt/SRAT.dsl
 delete mode 100644 tests/data/acpi/virt/SRAT.memhp.dsl
 delete mode 100644 tests/data/acpi/virt/SRAT.numamem.dsl
 delete mode 100644 tests/data/acpi/virt/SSDT.dsl
 delete mode 100644 tests/data/uefi-boot-images/bios-tables-test.x86_64.iso.raw
 delete mode 100644 tests/libqtest.c.orig
 delete mode 100644 tests/qemu-iotests/core.12067
 delete mode 100644 tests/qtest/bios-tables-test-allowed-diff.h.orig
 delete mode 100644 tests/qtest/bios-tables-test-allowed-diff.h.rej
 delete mode 100644 tests/qtest/bios-tables-test.c.orig
 delete mode 100644 tests/qtest/bios-tables-test.c.rej
 delete mode 100755 tests/vhost-user-bridge
 delete mode 100644 tests/vhost-user-bridge.c.orig
 delete mode 100644 tests/vhost-user-test.c.orig


