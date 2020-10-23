Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D8BDC4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:12:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 821C5208B3
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:12:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gWj/uQ8w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 821C5208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVzgC-0005b0-BM
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 12:12:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32822)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kVz1I-0007en-96
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:30:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23035)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kVz1C-0001nP-2C
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:30:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603467013;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=vx5Uvd1Hygxjtmt0D3r2fl2Rr7vwdt1SAjrRWrX76nQ=;
 b=gWj/uQ8wmtNeiOUnH0AUr+7BZuybe1ByB5BQBI2B1fB2aTa5PuQt5v8md7aRpebn4dhDVo
 hZuZ9/fTMRCd+FE1tqts7R+DvKLvGajRhjhq3mT2Jk9AqnaUMGMbFez/A4RQMiEeQSv/P8
 bALr30OiHcHVPQh1/9VvhiW7B3akpes=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-10-GyY9Knf8Mi6SJ4U_Ib10Jw-1; Fri, 23 Oct 2020 11:30:09 -0400
X-MC-Unique: GyY9Knf8Mi6SJ4U_Ib10Jw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1F27EEC50B
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2020 15:30:00 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-113-189.ams2.redhat.com
 [10.36.113.189])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D880A5B4B3;
 Fri, 23 Oct 2020 15:29:58 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [qemu-web PATCH 0/7] Tweaks to page footer and add "edit page" links
Date: Fri, 23 Oct 2020 16:29:50 +0100
Message-Id: <20201023152957.488974-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=63.128.21.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 02:46:25
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series started off as a desire to add an "Edit page" link to every=0D
page on the site. In doing this I felt that the footer would benefit=0D
from simplication so that it was not a massive wall of links,=0D
duplicating links elsewhere in the navigation or content pages.=0D
=0D
I also add gitlab CI jobs so that users can push a branch to gitlab and=0D
then browse the rendered result.=0D
=0D
eg see this pipeline:=0D
=0D
  https://gitlab.com/berrange/qemu-web/-/pipelines/206891542=0D
=0D
and the rendered result:=0D
=0D
  https://berrange.gitlab.io/qemu-web/=0D
=0D
Or browsable at=0D
=0D
  https://gitlab.com/berrange/qemu-web/-/jobs/809000762/artifacts/browse/pu=
bl=3D=0D
ic/=0D
=0D
Or download ZIP at=0D
=0D
  https://gitlab.com/berrange/qemu-web/-/jobs/809000762/artifacts/download=
=0D
=0D
notice how the resulting content needs to cope with being used from a=0D
variety of different paths. IOW, we cannot use absolute hyperlinks that=0D
assume the root is "/".  Jekyll doesn't make this easy, so we use a hack=0D
with a custom template that sets a variable we can then reference.=0D
=0D
The logical next step for this would be to accept merge requests, so=0D
that once the user saves their edits in gitlab, they can directly submit=0D
a MR, instead of sending via email.  I noticed we don't currently have a=0D
CONTRIBUTING.md file in qemu-web.git telling people how to submit. So=0D
this series includes such a file directing people to send patches via=0D
email for now.=0D
=0D
Daniel P. Berrang=3DC3=3DA9 (7):=0D
  Convert files to UNIX line endings=0D
  gitlab: introduce a CI job to publish the site content=0D
  make all links be relative to the root=0D
  Make page header nav narrower=0D
  Simplify and restructure the page footer=0D
  Add link to "edit this page" for all pages=0D
  Add a CONTRIBUTING.md file as guidance for contributors=0D
=0D
 .gitlab-ci.yml               |   16 +=0D
 CONTRIBUTING.md              |   32 +=0D
 _config.yml                  |    1 +=0D
 _includes/assets.html        |   28 +-=0D
 _includes/copyright.html     |    8 -=0D
 _includes/footer.html        |   33 +-=0D
 _includes/nav.html           |   13 +-=0D
 _includes/relative_root.html |   12 +=0D
 _includes/sidebar.html       |    6 +-=0D
 _layouts/archive.html        |    4 +-=0D
 _layouts/blog.html           |    4 +-=0D
 _layouts/home.html           |    2 +-=0D
 _layouts/page.html           |    2 +-=0D
 assets/css/style-desktop.css |  575 ++++++++--------=0D
 assets/css/style-mobile.css  |  739 +++++++++++----------=0D
 assets/css/style.css         | 1200 +++++++++++++++++-----------------=0D
 blog/index.html              |    4 +-=0D
 index.html                   |  178 ++---=0D
 18 files changed, 1448 insertions(+), 1409 deletions(-)=0D
 create mode 100644 .gitlab-ci.yml=0D
 create mode 100644 CONTRIBUTING.md=0D
 delete mode 100644 _includes/copyright.html=0D
 create mode 100644 _includes/relative_root.html=0D
=0D
--=3D20=0D
2.26.2=0D
=0D


