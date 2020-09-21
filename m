Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C97AC43463
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 11:12:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F05E620874
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 11:12:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dwGaE0ZZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F05E620874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKJk5-0003Gb-0p
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 07:12:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37512)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kKJhZ-00013G-4x
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 07:09:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36573
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kKJhU-0006SM-SK
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 07:09:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600686578;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5wd8WNnpfJf9iOm8rs3WN1lw4U99ZWxrdas1R804ckE=;
 b=dwGaE0ZZLzPQBn4MxliXD6BtVM17rwCXtyS1RbApKkTUtpkp/Mwq8bfOs3TP19Wu93qsvk
 olJPhhwN9XhijkmR9heUmGIPEQjTSfAGuvZOnLWCZyWXYwwC9a6FTda+wsepnccxo2QPOz
 CtXEtRNmSLKJ9/aKoGwuB3K161/jnv8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-WTFLyxwRO_-1bDRkoEvw-A-1; Mon, 21 Sep 2020 07:09:34 -0400
X-MC-Unique: WTFLyxwRO_-1bDRkoEvw-A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ABF6418B9F83;
 Mon, 21 Sep 2020 11:09:33 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-85.ams2.redhat.com
 [10.36.112.85])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4626755773;
 Mon, 21 Sep 2020 11:09:30 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 2C44F16E0A; Mon, 21 Sep 2020 13:09:29 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/1] Input 20200921 patches
Date: Mon, 21 Sep 2020 13:09:28 +0200
Message-Id: <20200921110929.7410-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 04:38:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.501,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 053a4177817db307ec854356e95b5b350800a216=
:=0D
=0D
  Merge remote-tracking branch 'remotes/philmd-gitlab/tags/fw_cfg-20200918'=
 i=3D=0D
nto staging (2020-09-18 16:34:26 +0100)=0D
=0D
are available in the Git repository at:=0D
=0D
  git://git.kraxel.org/qemu tags/input-20200921-pull-request=0D
=0D
for you to fetch changes up to 38b01a997e6678b4ba86ab12a78a39b7d94ee7d0:=0D
=0D
  hw/input/tsc2xxx: Reduce MouseTransformInfo structure exposure (2020-09-2=
1 =3D=0D
11:22:34 +0200)=0D
=0D
----------------------------------------------------------------=0D
input: tsc2xxx fix.=0D
=0D
----------------------------------------------------------------=0D
=0D
Philippe Mathieu-Daud=3DC3=3DA9 (1):=0D
  hw/input/tsc2xxx: Reduce MouseTransformInfo structure exposure=0D
=0D
 include/hw/input/tsc2xxx.h | 8 +++++++-=0D
 include/ui/console.h       | 8 --------=0D
 2 files changed, 7 insertions(+), 9 deletions(-)=0D
=0D
--=3D20=0D
2.27.0=0D
=0D


