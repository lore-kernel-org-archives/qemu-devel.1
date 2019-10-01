Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,WEIRD_QUOTING
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC3AC388F3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 04:29:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1976B20842
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 04:29:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1976B20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iF9nP-0001Yy-8j
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 00:29:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35706)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pkrempa@redhat.com>) id 1iF9mh-00011G-WF
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 00:29:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pkrempa@redhat.com>) id 1iF9mg-0001nQ-MH
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 00:29:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48940)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pkrempa@redhat.com>)
 id 1iF9mc-0001Xo-Mb; Tue, 01 Oct 2019 00:29:06 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 35E5E20EB;
 Tue,  1 Oct 2019 04:29:05 +0000 (UTC)
Received: from angien.pipo.sk (unknown [10.43.2.229])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C131360C5D;
 Tue,  1 Oct 2019 04:28:59 +0000 (UTC)
Date: Tue, 1 Oct 2019 06:28:57 +0200
From: Peter Krempa <pkrempa@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: bitmap migration bug with -drive while block mirror runs
Message-ID: <20191001042857.GY9210@angien.pipo.sk>
References: <315cff78-dcdb-a3ce-2742-da3cc9f0ca97@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <315cff78-dcdb-a3ce-2742-da3cc9f0ca97@redhat.com>
X-PGP-Key-ID: 0xD018682B
X-PGP-Key-Fingerprint: D294 FF38 A6A2 BF40 6C75  5DEF 36EC 16AC D018 682B
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.71]); Tue, 01 Oct 2019 04:29:05 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Sep 30, 2019 at 20:09:28 -0400, John Snow wrote:
> Hi folks, I identified a problem with the migration code that Red Hat QE
> found and thought you'd like to see it:
>=20
> https://bugzilla.redhat.com/show_bug.cgi?id=3D1652424#c20
>=20
> Very, very briefly: drive-mirror inserts a filter node that changes what
> bdrv_get_device_or_node_name() returns, which causes a migration problem.
>
> Ignorant question #1: Can we multi-parent the filter node and
> source-node? It looks like at the moment both consider their only parent
> to be the block-job and don't have a link back to their parents otherwise.
>=20
>=20
> Otherwise: I have a lot of cloudy ideas on how to solve this, but
> ultimately what we want is to be able to find the "addressable" name for
> the node the bitmap is attached to, which would be the name of the first
> ancestor node that isn't a filter. (OR, the name of the block-backend
> above that node.)

One possibility if there isn't an elegant qemu-based solution would be
to add a migration feature libvirt could enable which would simply stop
bitmaps from being copied and libvirt would do that in the synchronised
phase of the migration explicitly.

Libvirt might possibly need to do it anyways for inactive bitmaps if
the automatic bitmap copying includes only active bitmaps.

I'm not sure though how that would combine with post-copy migration or
what the impact on latency would be, but if you are migrating with
storage I think performance will not be stelar anyways.

> A simple way to do this might be a "child_unfiltered" BdrvChild role
> that simply bypasses the filter that was inserted and serves no real
> purpose other than to allow the child to have a parent link and find who
> it's """real""" parent is.
>=20
> Because of flushing, reopen, sync, drain &c &c &c I'm not sure how
> feasible this quick idea might be, though.
>=20
>=20
> - Corollary fix #1: call error_setg if the bitmap node name that's about
> to go over the wire is an autogenerated node: this is never correct!
>=20
> (Why not? because the target is incapable of matching the node-name
> because they are randomly generated AND you cannot specify node-names
> with # prefixes as they are especially reserved!
>=20
> (This raises a related problem: if you explicitly add bitmaps to nodes
> with autogenerated names, you will be unable to migrate them.))

I think this should be okay. In libvirt I opted to forbid checkpoints
which map to bitmap creation until blockdev will be supported where we
manage node names ourselves.

