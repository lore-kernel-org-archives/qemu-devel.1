Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D9D1C0650F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 11:37:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41A8A206E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 11:37:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41A8A206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59937 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsQRF-0008F2-GL
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 07:37:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54295)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kraxel@redhat.com>) id 1hsQPu-0006qs-OV
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 07:35:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1hsQPt-0004IG-H7
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 07:35:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47152)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>)
 id 1hsQPp-0004FZ-CM; Tue, 30 Jul 2019 07:35:37 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6C35630C1342;
 Tue, 30 Jul 2019 11:35:36 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-54.ams2.redhat.com
 [10.36.116.54])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5116E5D96F;
 Tue, 30 Jul 2019 11:35:29 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id B593E16E1A; Tue, 30 Jul 2019 13:35:27 +0200 (CEST)
Date: Tue, 30 Jul 2019 13:35:27 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: John Snow <jsnow@redhat.com>
Message-ID: <20190730113527.4f4ypo66wv4xktoq@sirius.home.kraxel.org>
References: <20190626123948.10199-1-shmuel.eiderman@oracle.com>
 <20190701074117.pkmzhon6v7nafq2p@sirius.home.kraxel.org>
 <424BE97C-7EAF-4B28-B580-AC2B5261197C@oracle.com>
 <EB5E5E3C-CCA1-4138-9623-89ECA7335F88@oracle.com>
 <20190717194623.GF6471@localhost.localdomain>
 <65B72D23-26BE-4C3B-B298-A6231D08BF6C@oracle.com>
 <63344112-c84b-f239-3c34-ad3a613910f7@redhat.com>
 <3ecc13e7-097f-7e8c-347d-443020c944d2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ecc13e7-097f-7e8c-347d-443020c944d2@redhat.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Tue, 30 Jul 2019 11:35:36 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Qemu-block] [QEMU] [PATCH v5 0/8] Add Qemu to
 SeaBIOS LCHS interface
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Arbel Moshe <arbel.moshe@oracle.com>, philmd@redhat.com, seabios@seabios.org,
 QEMU <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Kevin O'Connor <kevin@koconnor.net>, Sam Eiderman <shmuel.eiderman@oracle.com>,
 Liran Alon <liran.alon@oracle.com>, Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  Hi,

[ just back from summer vacation, wading through my backlog ... ]

> > I feel like it would be up to Gerd as the general SeaBIOS point of contact?
> > 
> 
> ...ah, who is offline for vacation.
> 
> We're in freeze right now anyway, so I would think that Gerd and/or
> Kevin can work out who ought to stage this for a PR when the tree opens
> again.

As this touches alot of block code I've expected it to go via block
tree, therefore I've added my reviewed-by to indicate the fw_cfg /
seabios side of things is fine from my point of view.  seabios patches
are reviewed and ready.

Merging via Phil's fw_cfg tree would make sense too, but Phil probably
wants an ack from the block layer guys in that case.

cheers,
  Gerd


