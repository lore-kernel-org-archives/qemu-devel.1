Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1297C33C99
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 11:24:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A2B12077B
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 11:24:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=online.net header.i=@online.net header.b="hSGZveYy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A2B12077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=online.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iomyj-0008Iv-HU
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 06:24:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37070)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fflorensa@online.net>) id 1iomoC-0003OH-UO
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 06:14:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fflorensa@online.net>) id 1iomoA-0000K7-H7
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 06:13:59 -0500
Received: from mail.online.net ([62.210.16.11]:50096)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <fflorensa@online.net>)
 id 1iomoA-0000Dt-31
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 06:13:58 -0500
Received: from localhost (localhost [127.0.0.1])
 by mail.online.net (Postfix) with ESMTP id 45EB3F2B8AF8;
 Tue,  7 Jan 2020 12:13:49 +0100 (CET)
Received: from mail.online.net ([127.0.0.1])
 by localhost (mail.online.net [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id Nfa23F5c2zrU; Tue,  7 Jan 2020 12:13:49 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by mail.online.net (Postfix) with ESMTP id 23A90F2B95BC;
 Tue,  7 Jan 2020 12:13:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.online.net 23A90F2B95BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=online.net;
 s=4EC61654-9574-11E8-870F-3D38CA7095BF; t=1578395629;
 bh=mrvEcFu6bzwIW4aWzk6nOvE+B5lMZitJUq4D2t4rZts=;
 h=From:To:Date:Message-Id:MIME-Version;
 b=hSGZveYyqwD9IuXBW3LwO5JfoO3EUDB566dVFYBbTZU2XuBVAhdVifXB9bNjqRrTA
 MwQVx61f7QJnDCQbiDksvODaYaUJNVVdqlF+2vbKwSQ2a5LsLalU1aD4HG52R3cT1W
 tZydqJFrCVJO0+dMkVtYgIQqd9N3WIupUp/5q/3KEYpJS6d5zoLYR8uk90gq4RibbJ
 fMiP8rDkFMtgM2EI+hfGZXqVBr/JPNwh/dgzYFpZubwkH56BwHy5smMtUqY4xiTqca
 KskrPuOhlMEqQvGUoMEO3LhVDuPOI7Y6SHJtVIiWYWKcqhlA9uz+EGfEucU4HfdDeq
 AohvhD6n8Qjdg==
X-Virus-Scanned: amavisd-new at mail.online.net
Received: from mail.online.net ([127.0.0.1])
 by localhost (mail.online.net [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id gilNIuXAlawu; Tue,  7 Jan 2020 12:13:49 +0100 (CET)
Received: from flash.online.net (unknown [195.154.229.35])
 by mail.online.net (Postfix) with ESMTPSA id F016BF2B8AF8;
 Tue,  7 Jan 2020 12:13:48 +0100 (CET)
From: Florian Florensa <fflorensa@online.net>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/1] block/rbd: Add support for ceph namespaces
Date: Tue,  7 Jan 2020 12:13:39 +0100
Message-Id: <20200107111340.334965-1-fflorensa@online.net>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 62.210.16.11
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
Cc: kwolf@redhat.com, dillaman@redhat.com, armbru@redhat.com, mreitz@redhat.com,
 sgarzare@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Happy new year everyone, please find attached the v2 of the patch,
updated with the input from Stefano, Jason and Eric.

What has changed from v1 :

 - renamed the variables from nspace to namespace
 - made the argument in qapi optional
 - add the `(Since 5.0)` tag in qapi documentation

Florian Florensa (1):
  block/rbd: Add support for ceph namespaces

 block/rbd.c          | 45 ++++++++++++++++++++++++++++++--------------
 qapi/block-core.json |  4 ++++
 2 files changed, 35 insertions(+), 14 deletions(-)

--=20
2.24.1


