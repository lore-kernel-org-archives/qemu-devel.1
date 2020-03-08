Return-Path: <SRS0=qQQb=4Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CAC0C10DCE
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2020 19:10:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF726206D5
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2020 19:10:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="OItPfyrW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF726206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jB1Jw-0004iI-Vf
	for qemu-devel@archiver.kernel.org; Sun, 08 Mar 2020 15:10:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34078)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <qemu_oss@crudebyte.com>) id 1jB1J8-0004EJ-K3
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 15:09:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <qemu_oss@crudebyte.com>) id 1jB1J7-000686-OQ
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 15:09:50 -0400
Received: from kylie.crudebyte.com ([5.189.157.229]:36813)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <qemu_oss@crudebyte.com>)
 id 1jB1J7-00067k-Hs; Sun, 08 Mar 2020 15:09:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=birF46cwsW7C6DhQDRE9C+H8AQVRyDMCb4zehSH4F/s=; b=OItPfyrWlkKge220ZyC5tY92fJ
 alkWr36lOR3DVJq/+AXYApAyPYL9p2p8M4JC87AsINnxoCCKzYNLAXw+PiY3MVHTyc976beNkYDZN
 dQ2qB8Trd0R3ni5YW1iE8Yb1+uh3VBxBhn1e9jzojPHlrmviMOtTriqCzMntPmz+FG3fiyRT629W7
 1dFcYkmg+05uBq0nqpxbrpdn/t3LwQcB8MayaECXCseVijFYDeEKV7SM/K+JBzovia6WxWFJguA17
 cXHKvmd9rAp7/tlUgz5gG4QXqrQSade8ZrUaE5RmgeAssPW3LVxViIS6BM6S0XYOTzdvYR+5Q9hqD
 +iBaDXddyuJJ7vb7VWxIcMa+RtOANGcb1VqcP3cMySoTzri0gAy2DBWBrttebQ3JPI600YWEQdyZA
 fqIzoWbrudapC/Gz3V4Y0lx+EBZoZP5IP067sIt4y8XGRYowsOwdTSLp9FqqanbzNoOqeKx6rQqzT
 RTs6dqyFysf3DqOaJK81hJ5jcD1NHCmNWle2hUITLFq+Es44DpwCtPch5R9iXSm/4ERC3zBz56KnQ
 ufnA2wgAwbB3JD6D/5bgAwkwh0ppa8QczIoBbm5R7FaZP1yaNvAGEbPGUwRi1l2dkkvrpKcnYLQ1A
 QPSqT/H05L9QC/bqfBGrt6B4UfYgKNnF3vofEfbIs=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Kevin Wolf <kwolf@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 qemu-block@nongnu.org, Paul Durrant <paul@xen.org>,
 Philippe =?ISO-8859-1?Q?Mathieu=2DDaud=E9?= <philmd@redhat.com>,
 Greg Kurz <groug@kaod.org>, armbru@redhat.com,
 Stefano Stabellini <sstabellini@kernel.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Max Reitz <mreitz@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v8 02/10] scripts: add coccinelle script to use auto
 propagated errp
Date: Sun, 08 Mar 2020 20:09:45 +0100
Message-ID: <2464375.yLZ1CyT5Wr@silver>
In-Reply-To: <20200306051536.27803-3-vsementsov@virtuozzo.com>
References: <20200306051536.27803-1-vsementsov@virtuozzo.com>
 <20200306051536.27803-3-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.189.157.229
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Freitag, 6. M=E4rz 2020 06:15:28 CET Vladimir Sementsov-Ogievskiy wrote:
> diff --git a/scripts/coccinelle/auto-propagated-errp.cocci
> b/scripts/coccinelle/auto-propagated-errp.cocci new file mode 100644
> index 0000000000..bff274bd6d
> --- /dev/null
> +++ b/scripts/coccinelle/auto-propagated-errp.cocci
> @@ -0,0 +1,231 @@
> +// Use ERRP_AUTO_PROPAGATE (see include/qapi/error.h)
> +//
> +// Copyright (c) 2020 Virtuozzo International GmbH.

Just in case:

WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?

Best regards,
Christian Schoenebeck



