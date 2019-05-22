Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29AD1C072A4
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 08:32:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00F92204EC
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 08:32:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00F92204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38416 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTMfT-0003hv-3g
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 04:32:11 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hTMbR-0000fj-JF
	for qemu-devel@nongnu.org; Wed, 22 May 2019 04:28:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hTMat-00058x-Bb
	for qemu-devel@nongnu.org; Wed, 22 May 2019 04:28:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57120)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hTMat-000583-47
	for qemu-devel@nongnu.org; Wed, 22 May 2019 04:27:27 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7FE093082211
	for <qemu-devel@nongnu.org>; Wed, 22 May 2019 08:27:25 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-74.ams2.redhat.com
	[10.36.117.74])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7FC1E648B5;
	Wed, 22 May 2019 08:27:19 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id 2152AA1E7; Wed, 22 May 2019 10:27:17 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 22 May 2019 10:27:14 +0200
Message-Id: <20190522082717.9354-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.47]);
	Wed, 22 May 2019 08:27:25 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 0/3] Input 20190522 patches
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit a4f667b6714916683408b983cfe0a615a72577=
5f:

  Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20190521-3' int=
o staging (2019-05-21 16:30:13 +0100)

are available in the Git repository at:

  git://git.kraxel.org/qemu tags/input-20190522-pull-request

for you to fetch changes up to 06914c97d3ade856371c9a59cbe6a9b13422471f:

  contrib: add vhost-user-input (2019-05-22 07:16:58 +0200)

----------------------------------------------------------------
input: add vhost-user-input to contrib.

----------------------------------------------------------------

Marc-Andr=C3=A9 Lureau (3):
  libvhost-user: fix cast warnings on 32 bits
  libvhost-user: fix -Werror=3Dformat=3D on ppc64
  contrib: add vhost-user-input

 Makefile                               |  11 +
 Makefile.objs                          |   1 +
 contrib/libvhost-user/libvhost-user.c  |  12 +-
 contrib/vhost-user-input/main.c        | 393 +++++++++++++++++++++++++
 MAINTAINERS                            |   1 +
 contrib/vhost-user-input/Makefile.objs |   1 +
 6 files changed, 414 insertions(+), 5 deletions(-)
 create mode 100644 contrib/vhost-user-input/main.c
 create mode 100644 contrib/vhost-user-input/Makefile.objs

--=20
2.18.1


