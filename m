Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	URI_NOVOWEL,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5AA8C48BD3
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 17:24:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DA8F2080C
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 17:24:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DA8F2080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgBeY-0003RY-FF
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 13:24:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50422)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <anthony.perard@citrix.com>) id 1hgBab-0001jC-R6
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 13:20:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <anthony.perard@citrix.com>) id 1hgBaZ-0001Eh-Kh
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 13:20:09 -0400
Received: from esa3.hc3370-68.iphmx.com ([216.71.145.155]:45957)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <anthony.perard@citrix.com>)
 id 1hgBaT-0000yP-Ly; Wed, 26 Jun 2019 13:20:03 -0400
Authentication-Results: esa3.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none;
 spf=None smtp.pra=anthony.perard@citrix.com;
 spf=Pass smtp.mailfrom=anthony.perard@citrix.com;
 spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa3.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 anthony.perard@citrix.com) identity=pra;
 client-ip=162.221.158.21; receiver=esa3.hc3370-68.iphmx.com;
 envelope-from="anthony.perard@citrix.com";
 x-sender="anthony.perard@citrix.com";
 x-conformance=sidf_compatible
Received-SPF: Pass (esa3.hc3370-68.iphmx.com: domain of
 anthony.perard@citrix.com designates 162.221.158.21 as
 permitted sender) identity=mailfrom;
 client-ip=162.221.158.21; receiver=esa3.hc3370-68.iphmx.com;
 envelope-from="anthony.perard@citrix.com";
 x-sender="anthony.perard@citrix.com";
 x-conformance=sidf_compatible; x-record-type="v=spf1";
 x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
 ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
 ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
 ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83 ~all"
Received-SPF: None (esa3.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 postmaster@mail.citrix.com) identity=helo;
 client-ip=162.221.158.21; receiver=esa3.hc3370-68.iphmx.com;
 envelope-from="anthony.perard@citrix.com";
 x-sender="postmaster@mail.citrix.com";
 x-conformance=sidf_compatible
IronPort-SDR: L0a8Eq1E9Z6Kn5YfX7ryOUqreKhYQ54MK6EpijmH7Albeh+N03zoiBkbN8+BVO/PeyOzqpbNPP
 b5VZhR9vdH8Dbd/LPgg+aRycCNBI9OGPkMys0iZyOMKerzihERWLTMBnEDtgV2KfrIuLt701+o
 LoPtm6uYbLJa0m5PIGoAAk0a71pyFwbiusMTj0kCyUqSNG6o/l1BSE3kfo6c5Bkei+hy8SL0ab
 aDmG4f6My6ha8y3vKduzMvqTQpmTV7xht88B03CxTFsTABv4qyHPs5YsJbo/VfIKptWJ9YhgK0
 bpY=
X-SBRS: 2.7
X-MesageID: 2275185
X-Ironport-Server: esa3.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.63,420,1557201600"; 
   d="scan'208";a="2275185"
Date: Wed, 26 Jun 2019 18:19:47 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
To: Max Reitz <mreitz@redhat.com>
Message-ID: <20190626171947.GF13449@perard.uk.xensource.com>
References: <20190409164038.25484-1-paul.durrant@citrix.com>
 <c9c1360d-cebc-5c2a-a019-eca2f8f7f461@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c9c1360d-cebc-5c2a-a019-eca2f8f7f461@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.145.155
Subject: Re: [Qemu-devel] [PATCH] xen-block: support
 feature-large-sector-size
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Paul Durrant <paul.durrant@citrix.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 xen-devel@lists.xenproject.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 26, 2019 at 06:48:50PM +0200, Max Reitz wrote:
> On 09.04.19 18:40, Paul Durrant wrote:
> > A recent Xen commit [1] clarified the semantics of sector based quantities
> > used in the blkif protocol such that it is now safe to create a xen-block
> > device with a logical_block_size != 512, as long as the device only
> > connects to a frontend advertizing 'feature-large-block-size'.
> > 
> > This patch modifies xen-block accordingly. It also uses a stack variable
> > for the BlockBackend in xen_block_realize() to avoid repeated dereferencing
> > of the BlockConf pointer, and changes the parameters of
> > xen_block_dataplane_create() so that the BlockBackend pointer and sector
> > size are passed expicitly rather than implicitly via the BlockConf.
> > 
> > These modifications have been tested against a recent Windows PV XENVBD
> > driver [2] using a xen-disk device with a 4kB logical block size.
> > 
> > [1] http://xenbits.xen.org/gitweb/?p=xen.git;a=commit;h=67e1c050e36b2c9900cca83618e56189effbad98
> > [2] https://winpvdrvbuild.xenproject.org:8080/job/XENVBD-master/126
> > 
> > Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
> > ---
> > Cc: Stefano Stabellini <sstabellini@kernel.org>
> > Cc: Anthony Perard <anthony.perard@citrix.com>
> > Cc: Stefan Hajnoczi <stefanha@redhat.com>
> > Cc: Kevin Wolf <kwolf@redhat.com>
> > Cc: Max Reitz <mreitz@redhat.com>
> > ---
> >  hw/block/dataplane/xen-block.c | 25 ++++++++++++----------
> >  hw/block/dataplane/xen-block.h |  3 ++-
> >  hw/block/xen-block.c           | 38 +++++++++++++++++++++-------------
> >  3 files changed, 40 insertions(+), 26 deletions(-)
> 
> Thanks, added “by frontend” to the error message and applied to my block
> branch:
> 
> https://git.xanclic.moe/XanClic/qemu/commits/branch/block

:(, I've just sent a pull request with that patch:
https://patchew.org/QEMU/20190624153257.20163-1-anthony.perard@citrix.com/20190624153257.20163-2-anthony.perard@citrix.com/

I guess I need to start sending an email every time I've added a patch
to my queue.

Cheers,

-- 
Anthony PERARD

