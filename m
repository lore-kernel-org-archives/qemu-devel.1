Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 989E6C3A5A1
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 03:44:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CE9623406
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 03:44:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synology.com header.i=@synology.com header.b="HOHZBm47"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CE9623406
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i10V4-0003LL-JQ
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 23:44:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35691)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuchenlin@synology.com>) id 1i10UP-0002q7-5w
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 23:43:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuchenlin@synology.com>) id 1i10UN-0002bU-V0
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 23:43:49 -0400
Received: from mail.synology.com ([211.23.38.101]:35879 helo=synology.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yuchenlin@synology.com>)
 id 1i10UJ-0002Y9-PK; Thu, 22 Aug 2019 23:43:44 -0400
Received: from Mail (localhost [127.0.0.1])
 by synology.com (Postfix) with ESMTPA id A331472E4A36;
 Fri, 23 Aug 2019 11:43:31 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
 t=1566531811; bh=MQREdVyWBMLsT1Mk7JjuJvq9wH71GScBSXEWnzP2bJQ=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject;
 b=HOHZBm47hdcY08ZyJ9f8ARiV6NMIu2ArxptlbvpxkN1EAgBPRpJPat2NzeKo/Nn5R
 r80qxM4Ub4V73OfqIywF0JNFL9NlQQOxrgzTqNFbd7LzgWkaLUOwT77+bjELYMr+yC
 99i1CcPIHxIrqdKOuYUCnbTN52svxm1GV+W+qOfs=
Date: Fri, 23 Aug 2019 11:43:31 +0800
To: "Raphael Norwitz" <raphael.norwitz@nutanix.com>
Message-ID: <cf03a11f-777f-42ce-8776-1bcb4e6ae8e2@Mail>
In-Reply-To: <1566498865-55506-1-git-send-email-raphael.norwitz@nutanix.com>
References: <1566498865-55506-1-git-send-email-raphael.norwitz@nutanix.com>
MIME-Version: 1.0
X-Synology-MCP-Status: no
X-Synology-Spam-Flag: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Virus-Status: no
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 211.23.38.101
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 1/2] vhost-user-blk: prevent
 using uninitialized vqs
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
From: yuchenlin via Qemu-devel <qemu-devel@nongnu.org>
Reply-To: yuchenlin <yuchenlin@synology.com>
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?utf-8?Q?open_list=3ABlock_layer_core?= <qemu-block@nongnu.org>,
 =?utf-8?Q?Michael_S=2E_Tsirkin?= <mst@redhat.com>, qemu-devel@nongnu.org,
 Raphael Norwitz <raphael.norwitz@nutanix.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Raphael Norwitz <raphael.norwitz=40nutanix.com> =E6=96=BC 2019-08-23 04:1=
6 =E5=AF=AB=E9=81=93=EF=BC=9A > > Same rational as: e6cc11d64fc998c11a4df=
cde8fda3fc33a74d844 > > Of the 3 virtqueues, seabios only sets cmd, leavi=
ng ctrl > and event without a physical address. This can cause > vhost=5F=
verify=5Fring=5Fpart=5Fmapping to return ENOMEM, causing > the following =
logs: > > qemu-system-x86=5F64: Unable to map available ring for ring 0 >=
 qemu-system-x86=5F64: Verify ring failure on region 0 > > This has alrea=
dy been fixed for vhost scsi devices and was > recently vhost-user scsi d=
evices. This commit fixes it for > vhost-user-blk devices. > > Suggested-=
by: Phillippe Mathieu-Daude <philmd=40redhat.com> > Signed-off-by: Raphae=
l Norwitz <raphael.norwitz=40nutanix.com> Reviewed-by: yuchenlin <yuchenl=
in=40synology.com> Thanks. > > > --- > hw/block/vhost-user-blk.c =7C 2 +-=
 > 1 file changed, 1 insertion(+), 1 deletion(-) > > diff --git a/hw/bloc=
k/vhost-user-blk.c b/hw/block/vhost-user-blk.c > index 0b8c5df..63da9bb 1=
00644 > --- a/hw/block/vhost-user-blk.c > +++ b/hw/block/vhost-user-blk.c=
 > =40=40 -421,7 +421,7 =40=40 static void vhost=5Fuser=5Fblk=5Fdevice=5F=
realize(DeviceState *dev, Error **errp) > =7D > > s->inflight =3D g=5Fnew=
0(struct vhost=5Finflight, 1); > - s->vqs =3D g=5Fnew(struct vhost=5Fvirt=
queue, s->num=5Fqueues); > + s->vqs =3D g=5Fnew0(struct vhost=5Fvirtqueue=
, s->num=5Fqueues); > s->watch =3D 0; > s->connected =3D false; > > -- > =
1.9.4 > >
