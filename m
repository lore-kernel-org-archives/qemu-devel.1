Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1345C4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 12:13:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F31B020719
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 12:13:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N/LmUxSD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F31B020719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOJwg-0005lh-Qd
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 08:13:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56694)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kOJux-0003wY-2I
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 08:12:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24055)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kOJud-0003Na-8i
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 08:12:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601640687;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=+KgTu15Y9T7kXvhKgXl/Ed+W0i4C3t4vSKU5ZWXqR9A=;
 b=N/LmUxSDdk64ggbH1uSEP3eOffAMx6fQlg54bhvEeENP4//eR0VJUwXh9+yqoH2pfoDmPt
 AbMVKgvazd55GKSpjPtoJMyczsNdvKGwuucBW8Ek/JRAXqO+x0MW2WmlV/k63hVvnKmItQ
 nHPBOb/U6HLOohbXP7GrFrjHjZ3HdWk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-84-jTtZQ-qXP2GjTT39w9IAXw-1; Fri, 02 Oct 2020 08:11:23 -0400
X-MC-Unique: jTtZQ-qXP2GjTT39w9IAXw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 83BCA801AC2;
 Fri,  2 Oct 2020 12:11:22 +0000 (UTC)
Received: from localhost (ovpn-112-216.ams2.redhat.com [10.36.112.216])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2959E5C1D0;
 Fri,  2 Oct 2020 12:11:21 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 00/19] s390x changes
Date: Fri,  2 Oct 2020 14:10:59 +0200
Message-Id: <20201002121118.180315-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 23:37:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit b5ce42f5d138d7546f9faa2decbd6ee8702243a3:

  Merge remote-tracking branch 'remotes/jsnow-gitlab/tags/ide-pull-request' into staging (2020-10-01 19:55:10 +0100)

are available in the Git repository at:

  https://github.com/cohuck/qemu tags/s390x-20201002

for you to fetch changes up to be2b567018d987591647935a7c9648e9c45e05e8:

  s390x/tcg: Implement CIPHER MESSAGE WITH AUTHENTICATION (KMA) (2020-10-02 13:52:49 +0200)

----------------------------------------------------------------
s390x update
- support extended sccb and diagnose 0x318
- implement additional instructions in tcg
- bug fixes

----------------------------------------------------------------

Collin L. Walling (7):
  s390/sclp: get machine once during read scp/cpu info
  s390/sclp: rework sclp boundary checks
  s390/sclp: read sccb from mem based on provided length
  s390/sclp: check sccb len before filling in data
  s390/sclp: use cpu offset to locate cpu entries
  s390/sclp: add extended-length sccb support for kvm guest
  s390: guest support for diagnose 0x318

Cornelia Huck (1):
  vfio-ccw: plug memory leak while getting region info

David Hildenbrand (10):
  s390x/tcg: Implement MONITOR CALL
  s390x/cpumodel: S390_FEAT_MISC_INSTRUCTION_EXT ->
    S390_FEAT_MISC_INSTRUCTION_EXT2
  s390x/tcg: Implement ADD HALFWORD (AGH)
  s390x/tcg: Implement SUBTRACT HALFWORD (SGH)
  s390x/tcg: Implement MULTIPLY (MG, MGRK)
  s390x/tcg: Implement MULTIPLY HALFWORD (MGH)
  s390x/tcg: Implement BRANCH INDIRECT ON CONDITION (BIC)
  s390x/tcg: Implement MULTIPLY SINGLE (MSC, MSGC, MSGRKC, MSRKC)
  s390x/tcg: We support Miscellaneous-Instruction-Extensions Facility 2
  s390x/tcg: Implement CIPHER MESSAGE WITH AUTHENTICATION (KMA)

Philippe Mathieu-Daudé (1):
  hw/s390x/css: Remove double initialization

 hw/s390x/css.c                      |   1 -
 hw/s390x/event-facility.c           |   2 +-
 hw/s390x/sclp.c                     | 142 ++++++++++++++++++++--------
 hw/vfio/ccw.c                       |   5 +-
 include/hw/s390x/sclp.h             |  11 ++-
 target/s390x/cc_helper.c            |  32 +++++++
 target/s390x/cpu.h                  |   2 +
 target/s390x/cpu_features.h         |   1 +
 target/s390x/cpu_features_def.h.inc |   6 +-
 target/s390x/cpu_models.c           |   1 +
 target/s390x/excp_helper.c          |  23 +++++
 target/s390x/gen-features.c         |   6 +-
 target/s390x/helper.c               |   2 +
 target/s390x/helper.h               |   1 +
 target/s390x/insn-data.def          |  15 +++
 target/s390x/internal.h             |   2 +
 target/s390x/kvm.c                  |  47 +++++++++
 target/s390x/machine.c              |  17 ++++
 target/s390x/translate.c            |  69 ++++++++++++++
 19 files changed, 340 insertions(+), 45 deletions(-)

-- 
2.25.4


