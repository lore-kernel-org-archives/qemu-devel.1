Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E5AFC10F0E
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 02:52:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE9BD2075B
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 02:52:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE9BD2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58392 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGEDF-0003Vi-2c
	for qemu-devel@archiver.kernel.org; Mon, 15 Apr 2019 22:52:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1hGECS-0003En-6Y
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 22:51:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1hGECR-0003S8-71
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 22:51:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49604)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1hGECQ-0003Qz-VN
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 22:51:55 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3D5863092645;
	Tue, 16 Apr 2019 02:51:52 +0000 (UTC)
Received: from xz-x1 (dhcp-14-116.nay.redhat.com [10.66.14.116])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 8095019C6A;
	Tue, 16 Apr 2019 02:51:49 +0000 (UTC)
Date: Tue, 16 Apr 2019 10:51:47 +0800
From: Peter Xu <peterx@redhat.com>
To: Catherine Ho <catherine.hecx@gmail.com>
Message-ID: <20190416025147.GA20550@xz-x1>
References: <1554688616-18583-1-git-send-email-catherine.hecx@gmail.com>
	<1554712933-18682-1-git-send-email-catherine.hecx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <1554712933-18682-1-git-send-email-catherine.hecx@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.43]);
	Tue, 16 Apr 2019 02:51:52 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4] migration: do not rom_reset() during
 incoming migration
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
Cc: Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>,
	qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190416025147.G0zZQcpqbvfyNF-_Er-21tLAKz6exz0C6eTicCVU52Q@z>

On Mon, Apr 08, 2019 at 04:42:13AM -0400, Catherine Ho wrote:
> Commit 18269069c310 ("migration: Introduce ignore-shared capability")
> addes ignore-shared capability to bypass the shared ramblock (e,g,
> membackend + numa node). It does good to live migration.
> 
> As told by Yury,this commit expectes that QEMU doesn't write to guest RAM
> until VM starts, but it does on aarch64 qemu:
> Backtrace:
> 1  0x000055f4a296dd84 in address_space_write_rom_internal () at
> exec.c:3458
> 2  0x000055f4a296de3a in address_space_write_rom () at exec.c:3479
> 3  0x000055f4a2d519ff in rom_reset () at hw/core/loader.c:1101
> 4  0x000055f4a2d475ec in qemu_devices_reset () at hw/core/reset.c:69
> 5  0x000055f4a2c90a28 in qemu_system_reset () at vl.c:1675
> 6  0x000055f4a2c9851d in main () at vl.c:4552
> 
> Actually, on arm64 virt marchine, ramblock "dtb" will be filled into ram
> druing rom_reset. In ignore-shared incoming case, this rom filling
> is not required since all the data has been stored in memory backend
> file.
> 
> Further more, as suggested by Peter Xu, if we do rom_reset() now with
> these ROMs then the RAM data should be re-filled again too with the
> migration stream coming in.
> 
> Fixes: commit 18269069c310 ("migration: Introduce ignore-shared
> capability")
> Suggested-by: Yury Kotov <yury-kotov@yandex-team.ru>
> Suggested-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Catherine Ho <catherine.hecx@gmail.com>

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

