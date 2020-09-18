Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0906BC43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 13:31:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49F49206DB
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 13:31:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fbw9PILW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49F49206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJGTi-0000M1-6m
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 09:31:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46306)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kJGRy-0007Vj-7v
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 09:29:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52843)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kJGRw-0002T3-0d
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 09:29:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600435754;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5oY1TSqrhj+xNpCsSQCX2lw9c3fJEw8Euk2PUnluTqM=;
 b=fbw9PILWEs7N/fQhkQzPpKQuJLJYWYfz2S9/tSOpzeiSbox+TCO+ribTwQxR/VkA77Bu13
 9X1IorZbtwqFSoGABLaHFkaKd5InT3t80/uvc2lA8uUeNy1RhBPGZDdGwrKNeQxB7cUt53
 DIGCv4VJs8VR9uT3RT+zbGK0Z0XYp/U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-173-SRxV9SD2OOCbbnPaJym3bQ-1; Fri, 18 Sep 2020 09:29:10 -0400
X-MC-Unique: SRxV9SD2OOCbbnPaJym3bQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7488D1966324;
 Fri, 18 Sep 2020 13:29:09 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-114-199.ams2.redhat.com
 [10.36.114.199])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A667878806;
 Fri, 18 Sep 2020 13:29:04 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/3] gitlab: add jobs for checking paches
Date: Fri, 18 Sep 2020 14:29:00 +0100
Message-Id: <20200918132903.1848939-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=216.205.24.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 01:32:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This introduces two new jobs to GitLab. The first runs "checkpatch.pl"=0D
across all patches, while the second is a dedicated DCO signoff check.=0D
=0D
While checkpatch.pl does validate DCO signoff, it is sub-optimal as we=0D
need to allow the checkpatch.pl job to fail as there are always patches=0D
which intentionally violate some rules, and we've no mechanism for marking=
=0D
permitted exceptions in code. Thus the checkpatch.pl jobs needs to be=0D
non-fatal allowing failure.=0D
=0D
By having a separate DCO job, we can make that particular job mandatory.=0D
=0D
Checking patches themselves in GitLab CI is a little difficult, as the=0D
CI job receives no indication of what the base ancestor was for the=0D
branch being tested. To work around this, we add the master QEMU git=0D
repo as a new remote and ask git to find the common ancestor vs the=0D
branch being tested.=0D
=0D
An example pipeline showing failure of these two jobs is here:=0D
=0D
  https://gitlab.com/berrange/qemu/-/pipelines/191219666=0D
=0D
The checkpatch.pl job failure output:=0D
=0D
  https://gitlab.com/berrange/qemu/-/jobs/743439455=0D
=0D
And the DCO signoff job failure output:=0D
=0D
  https://gitlab.com/berrange/qemu/-/jobs/743439456=0D
=0D
I think the latter shows the benefit of having a dedicated DCO signoff=0D
job checker, as the info presented to the user is much clearer about=0D
what they did wrong and how & why they must address it.=0D
=0D
_+#          base:  master=0D
=0D
Daniel P. Berrang=C3=A9 (3):=0D
  gitlab: add a CI job for running checkpatch.pl=0D
  gitlab: add a CI job to validate the DCO sign off=0D
  gitlab: assign python helper files to GitLab maintainers section=0D
=0D
 .gitlab-ci.d/check-dco.py   | 94 +++++++++++++++++++++++++++++++++++++=0D
 .gitlab-ci.d/check-patch.py | 48 +++++++++++++++++++=0D
 .gitlab-ci.yml              | 22 +++++++++=0D
 MAINTAINERS                 |  1 +=0D
 4 files changed, 165 insertions(+)=0D
 create mode 100755 .gitlab-ci.d/check-dco.py=0D
 create mode 100755 .gitlab-ci.d/check-patch.py=0D
=0D
--=20=0D
2.26.2=0D
=0D


