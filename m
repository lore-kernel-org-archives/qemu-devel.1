Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E4EFC2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 11:58:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFC5720759
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 11:58:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FbaVs5gy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFC5720759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaHR8-0007we-JE
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 06:58:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58930)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kaHPh-0006PJ-Lq
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 06:57:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34374)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kaHPe-0005UQ-RQ
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 06:57:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604491032;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Z1U06kCSu+NB38K/u43bX4gtAsQ7VCFR+zIY0zpUJSY=;
 b=FbaVs5gy1JByudgwdvuw+A2Xo5IC87w/0arkjPBDjH18DjRZOkXRGfAR55Anf7h5qdNr3c
 q9q3AW1UAgT5gOdcNo6K/sOGTmv1pr32JZmu+QjbUXn3ewTL0pd876fHyJZGtsH2koe52n
 Y9fL2Dr4lv3VqpuUm0Cid8D38Iu984E=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-RBWZo7q0P0ybYt7LalzM_A-1; Wed, 04 Nov 2020 06:57:11 -0500
X-MC-Unique: RBWZo7q0P0ybYt7LalzM_A-1
Received: by mail-wr1-f71.google.com with SMTP id t11so9193043wrv.10
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2020 03:57:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=UC/33i8udnv6b9qeDreDw8q8YUYv0qZEs237yS/0QcY=;
 b=J4xz/SK6X8zsalS85zNnNbkt7avYPrpkPgc9lVMCaUJ5reAVMop1HX6ruRMfLezyiw
 A9gSg6v8fO//lu2tAc7hxhZpVhui1gsoNYEpXKcoEpMhs7hpy19TjWGNx3hjhX6PoNdu
 u3iXRTBs5a9znHknP0zGRrsQTdPdJbXTkw+1eWTa91FmTlrT2odIAfSjl7HfxNtgm/Vs
 ed9x2WtNiKKgdZbyCTkRGuEUs8gtS2f6OHScVbwmKc1UINVUsQyMOpKLIDk8xWlco5si
 5/XEpOnI4E9fssgU3LkQQJWpWCuoW2a6mg3iTIwVo5ZAQ8FinA9Hx8Pk3jRjNHKpIHDf
 HA+g==
X-Gm-Message-State: AOAM532j6v6etryPBgtc+CL2QRKA1qsuR4BGClQUWoyinFEUqjRMzsUM
 RhaljHZubEPWLLcc0BFBV2WiLd4gpfZwrhWydNC4VdX6yEEzb/PuaFQdxMeRQM9EHh2Bg+emkiF
 73SbtE80Sk24CYeM=
X-Received: by 2002:adf:f381:: with SMTP id m1mr34981052wro.347.1604491029007; 
 Wed, 04 Nov 2020 03:57:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwxvM5U8x6Tk2Uly487MFtS2pmyQGTYYs+QmFOwaq7ih9JEs/vm/G/t/7VokKQC2ziCIS3wCA==
X-Received: by 2002:adf:f381:: with SMTP id m1mr34981026wro.347.1604491028872; 
 Wed, 04 Nov 2020 03:57:08 -0800 (PST)
Received: from x1w.redhat.com (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id l124sm1886262wml.48.2020.11.04.03.57.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2020 03:57:08 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2 v3 0/4] ci: Move --without-default-devices job from
 Travis to GitLab
Date: Wed,  4 Nov 2020 12:57:02 +0100
Message-Id: <20201104115706.3101190-1-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We have a job covering the --without-default-devices configure=0D
option on Travis-CI, but recommend the community to use GitLab,=0D
so build failures are missed.=0D
=0D
We need help to move the jobs to GitLab (we will keep the s390x=0D
and ppc64 containerized jobs on Travis as there is no similar=0D
offer on GitLab). Start with this single job.=0D
=0D
Since v2:=0D
- Run m68k qtests (Thomas)=0D
- Reworded hw/9pfs description (Greg)=0D
- Added tags=0D
=0D
Since v1:=0D
- Fix Xen+9pfs config (Paolo)=0D
- Run AVR qtests (Thomas)=0D
=0D
Cornelia Huck (1):=0D
  s390x: fix build for --without-default-devices=0D
=0D
Philippe Mathieu-Daud=C3=A9 (3):=0D
  hw/9pfs: Fix Kconfig dependency problem between 9pfs and Xen=0D
  gitlab-ci: Add a job to cover the --without-default-devices config=0D
  travis-ci: Remove the --without-default-devices job=0D
=0D
 include/hw/s390x/s390-pci-vfio.h | 3 ++-=0D
 .gitlab-ci.yml                   | 7 +++++++=0D
 .travis.yml                      | 8 --------=0D
 hw/9pfs/Kconfig                  | 4 ----=0D
 hw/9pfs/meson.build              | 2 +-=0D
 hw/s390x/meson.build             | 2 +-=0D
 6 files changed, 11 insertions(+), 15 deletions(-)=0D
=0D
--=20=0D
2.26.2=0D
=0D


