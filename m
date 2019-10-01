Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B43D1C388F3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 11:47:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8896521906
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 11:47:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8896521906
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFGcN-0002mU-VF
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 07:47:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34729)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pkrempa@redhat.com>) id 1iFGay-0001rg-D4
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 07:45:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pkrempa@redhat.com>) id 1iFGax-0006CJ-4Y
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 07:45:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42628)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pkrempa@redhat.com>)
 id 1iFGau-00060G-4h; Tue, 01 Oct 2019 07:45:28 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C3FC2356CE;
 Tue,  1 Oct 2019 11:45:20 +0000 (UTC)
Received: from angien.pipo.sk (unknown [10.43.2.229])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B88C96012D;
 Tue,  1 Oct 2019 11:45:16 +0000 (UTC)
Date: Tue, 1 Oct 2019 13:45:14 +0200
From: Peter Krempa <pkrempa@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: bitmap migration bug with -drive while block mirror runs
Message-ID: <20191001114514.GA9210@angien.pipo.sk>
References: <315cff78-dcdb-a3ce-2742-da3cc9f0ca97@redhat.com>
 <f84745dc-68df-c10a-a91b-a28498e54870@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <f84745dc-68df-c10a-a91b-a28498e54870@virtuozzo.com>
X-PGP-Key-ID: 0xD018682B
X-PGP-Key-Fingerprint: D294 FF38 A6A2 BF40 6C75  5DEF 36EC 16AC D018 682B
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Tue, 01 Oct 2019 11:45:20 +0000 (UTC)
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
Cc: John Snow <jsnow@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 01, 2019 at 08:57:37 +0000, Vladimir Sementsov-Ogievskiy wrote:
> 01.10.2019 3:09, John Snow wrote:
> > Hi folks, I identified a problem with the migration code that Red Hat QE
> > found and thought you'd like to see it:
> >=20
> > https://bugzilla.redhat.com/show_bug.cgi?id=3D1652424#c20
> >=20
> > Very, very briefly: drive-mirror inserts a filter node that changes what
> > bdrv_get_device_or_node_name() returns, which causes a migration proble=
m.
> >=20
> >=20
> > Ignorant question #1: Can we multi-parent the filter node and
> > source-node? It looks like at the moment both consider their only parent
> > to be the block-job and don't have a link back to their parents otherwi=
se.
> >=20
> >=20
> > Otherwise: I have a lot of cloudy ideas on how to solve this, but
> > ultimately what we want is to be able to find the "addressable" name for
> > the node the bitmap is attached to, which would be the name of the first
> > ancestor node that isn't a filter. (OR, the name of the block-backend
> > above that node.)
>=20
>=20
> Better would be to migrate by node-name only.. But am I right that node-n=
ames
> are different on source and destination? Or this situation changed?

They may be different. Some time ago when I asked I was told that node
names are not bound to any state in qemu and thus can be re-created on
destination. Otherwise they technically become guest ABI which would
require changes to libvirt's blockdev usage.

