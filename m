Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 557DFC433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 17:35:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFB6020855
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 17:35:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gdHojVdl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFB6020855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGmxp-0002lV-Me
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 13:35:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46220)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kGmwq-0001Jg-9Q
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 13:34:56 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:31649
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kGmwo-0001ZU-NB
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 13:34:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599845693;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=VSi2TCcUNRp5WOgeOwLmjhFiTzANEkK76Lea6vRoncU=;
 b=gdHojVdlafeaymot4KXp1egFx9tmSy3quKZhaNX/6hoEo/VZnxKM9t66VsdbcssVLbAj9A
 QbdfRE1+vMHutlVchQaj001h2Urov4DURm9uhXZISCuUCkXzl2mfhk+6R57ET9hcCMR+1U
 pMgkTQ5QqURVerltRZjWV6b0Bmfofek=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-349-ikWuUcYPNJi6tDUV-lgnTA-1; Fri, 11 Sep 2020 13:34:50 -0400
X-MC-Unique: ikWuUcYPNJi6tDUV-lgnTA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 852E21007475;
 Fri, 11 Sep 2020 17:34:48 +0000 (UTC)
Received: from localhost (ovpn-66-226.rdu2.redhat.com [10.10.66.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 059407B7A1;
 Fri, 11 Sep 2020 17:34:47 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 0/2] riscv: Rename memmap enum constants
Date: Fri, 11 Sep 2020 13:34:45 -0400
Message-Id: <20200911173447.165713-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/11 00:33:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>, qemu-riscv@nongnu.org,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Resending the enum constant rename patches from a previous QOM=0D
cleanup series[1] separately, because of conflicts with other=0D
sifive patches.=0D
=0D
Series based on tags/pull-riscv-to-apply-20200910 [2]=0D
=0D
[1] [PATCH v3 00/74] qom: Automated conversion of type checking boilerplate=
=0D
    https://lore.kernel.org/qemu-devel/20200825192110.3528606-1-ehabkost@re=
dhat.com/=0D
[2] [PULL 00/30] riscv-to-apply queue=0D
    git@github.com:alistair23/qemu.git tags/pull-riscv-to-apply-20200910=0D
    https://lore.kernel.org/qemu-devel/20200910180938.584205-1-alistair.fra=
ncis@wdc.com=0D
=0D
Based-on: 20200910180938.584205-1-alistair.francis@wdc.com=0D
=0D
Eduardo Habkost (2):=0D
  sifive_e: Rename memmap enum constants=0D
  sifive_u: Rename memmap enum constants=0D
=0D
 include/hw/riscv/sifive_e.h |  38 ++++-----=0D
 include/hw/riscv/sifive_u.h |  34 ++++----=0D
 hw/riscv/sifive_e.c         |  82 +++++++++----------=0D
 hw/riscv/sifive_u.c         | 156 ++++++++++++++++++------------------=0D
 4 files changed, 155 insertions(+), 155 deletions(-)=0D
=0D
=0D
base-commit: 9435a8b3dd35f1f926f1b9127e8a906217a5518a=0D
prerequisite-patch-id: 8e8c13fd7650f4455348e2e12064ec3ad71833c9=0D
prerequisite-patch-id: 2df90a089a8f5af984270b7feb259d18eb64b69e=0D
prerequisite-patch-id: c7cbdd9cd6cc5b9f8aa9df0a7ac0c8c8693bc780=0D
prerequisite-patch-id: 22a9a9f874d70099c7bf11e627daf5f73c8f3df9=0D
prerequisite-patch-id: 30e7cd7cea97875ad2fbaf24e3d522243293839d=0D
prerequisite-patch-id: a8d6dbaaaf8d35270de9c7ba6f2e8ff9d9db7a40=0D
prerequisite-patch-id: 626a1da60314d6b18d83f64c6162890d9b287c38=0D
prerequisite-patch-id: e478dab67068db8a25317cef162ae9531e93f8c0=0D
prerequisite-patch-id: 0d79d052dcbcbf1b8fc115ff8ae7f9200bd16618=0D
prerequisite-patch-id: 06d93dde5aa72136224e8812db276512184ad048=0D
prerequisite-patch-id: d59378c76baa7765bb17aca826d14a8c69452bdf=0D
prerequisite-patch-id: 187121ba7231bc823e4acc5941a5c9fd897f26fd=0D
prerequisite-patch-id: df311e9276e03d8bb96144a87349ec23a6ba5b6c=0D
prerequisite-patch-id: e706cd915562ec18efba170c769047ebe2dde54e=0D
prerequisite-patch-id: 32a079f8fda7af4ee016e54c0a95d790cb7b9916=0D
prerequisite-patch-id: 7b413a0fc07d717c4e5fe441e2c7b60192b4b31e=0D
prerequisite-patch-id: 6f233317f711cbb5acae045996d12260e27ab10c=0D
prerequisite-patch-id: 35c979882cd2400363fce562d1e028c4f2e7f934=0D
prerequisite-patch-id: d137705ec1707ef7066908e502fcef537c59383e=0D
prerequisite-patch-id: 13c3906d42c185c7d11e2533b8f9273e10798afa=0D
prerequisite-patch-id: d30d7757543c9f52c54ef12d9e1a1d76edd070d2=0D
prerequisite-patch-id: 3b22c421eaad038b2d17cfb4cc7907590080ebe1=0D
prerequisite-patch-id: 1e6b61970a34225d00ee3e5f57630f6d3cfdbee4=0D
prerequisite-patch-id: 1c36c766b6154fe30e076845608e6be230228c1e=0D
prerequisite-patch-id: ccaa15790633f16dfd69aaf4885f0b3f2398658c=0D
prerequisite-patch-id: 594fe48326a7dea997a4f4e85eb72b3549d1c8e5=0D
prerequisite-patch-id: 2db557a303b7b99a8f8d979bf5281887f3a8162c=0D
prerequisite-patch-id: e58aa7d72a085408bccf3ba08774eda34804548c=0D
prerequisite-patch-id: ed0319b770df843515910350348269d6eeb4c89c=0D
prerequisite-patch-id: 89dfbe30d51576960af2b726523d75fe9130f6c6=0D
--=20=0D
2.26.2=0D
=0D


