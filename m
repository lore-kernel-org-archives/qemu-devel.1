Return-Path: <SRS0=5JRQ=YY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B78CA9EC3
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 09:43:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E43162083E
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 09:43:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fujitsu.onmicrosoft.com header.i=@fujitsu.onmicrosoft.com header.b="P/S9F0jA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E43162083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQ6zG-00082I-VX
	for qemu-devel@archiver.kernel.org; Thu, 31 Oct 2019 05:43:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35498)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <misono.tomohiro@fujitsu.com>) id 1iQ6wa-0004t6-Ov
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 05:40:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <misono.tomohiro@fujitsu.com>) id 1iQ6wX-00069S-R1
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 05:40:40 -0400
Received: from esa5.fujitsucc.c3s2.iphmx.com ([68.232.159.76]:52311)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <misono.tomohiro@fujitsu.com>)
 id 1iQ6wX-00065j-Bw
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 05:40:37 -0400
IronPort-SDR: rAV0WpHHpidB44nodBabQl2mNPuCOXVzQ0crxhyUvK8zy8ZSLCroaVhGzDg1sUwfuol0+pqxQb
 aENJv8TkMZQa+R/rGfeA/f9Tji8t1SzMpxNhjzmxRyDSNT/dhUvVj+nf89BRLeMaojcwBjWqeh
 SZOeW9RFEawYV5/qT56xP7oNEVvKuxB0UtP86C22rHBGiGvjHD9TzeBfztPkdjOEPmeqc5obga
 4s0rmn2wnyE9sxrN4HZMf4mN7rP2ra3HvQlU4ypz6DSaqJmPcMLuypZzFPIPa5tLV9biL/jn77
 xAA=
X-IronPort-AV: E=McAfee;i="6000,8403,9426"; a="7358356"
X-IronPort-AV: E=Sophos;i="5.68,250,1569250800"; 
   d="scan'208";a="7358356"
Received: from mail-ty1jpn01lp2057.outbound.protection.outlook.com (HELO
 JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.57])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA384;
 31 Oct 2019 18:40:30 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KTdloBvI9uNN7N5aq1RBlbTHQtLW1QpX3RVw8iynfCZSWcklm2NSVRZDDYeMq3Zi5S7t1cETF0NTxIqRYIKcDHKH1FXoi6iZeTKACCEOA2DXON1XG2n3L8CbRR5br5VcVy6avogetdYr5SGzPyuGFKSz7bDAylFeWe031bvQdVCD1SX0afelSABp61TCNVP3B3bCL2EdLi1Mr5I0iXzgkn6TqvOsgnpMnelGdTMYapRPYCcs8gnt0zJCwIuSw4Pf785aFF61aNcvC3i229FrRhDTs1Dk3KqRCI8O5VfLiH5yWclOwSk6L4Wikozl3o2lwN9OHzmKfoO1jejQqjV0Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rcVRXAcFrnCuqHU04xI3xLY+QoninWBY9E19K2Hm/s8=;
 b=BCjvBUVhlNFWf80es7pcVT6heSMiphSQKDoBDJXAcoWple2sLWoegOESEY7LTbb/UOo/HLIxm2+0LsVFlsWkXNqPVQ9cd9Brd7g1iq74GjxKUqHx2SIr/92S46AH9BN2azSW/WIJ6AA+QHkW9NQxPbXRNhMgRTAlAuRs9+C7JeGTIvx7aXZaciNE5BlnUHiYBIvXCveNWDn0n8gO7JIC2y1SD+uwhmrpTx9s8cFpkxNh5yVlGPvyiOByhDaZH+k7Y1luDmYnKFYW6MXH+VTjaVMkCa7owuxu4kqD0/Fr6PqX9z16leWeELtryck5RYhNRF4ANwOf/MSY+puKURGASw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rcVRXAcFrnCuqHU04xI3xLY+QoninWBY9E19K2Hm/s8=;
 b=P/S9F0jAi3i0HLjoPTq4jM2zw/HfAv3q0pUyRqrupwDngK7r1Z1w6lkzajlrGZ2Zm2Z+qk+i+PzX/zyHyRQxvxzV2MFEIJi/t+H9qbCXznzoCgSJMd9znGZ48HFobR9vSNfQGn6GuPbWw5n7JaveSeA9dn2MJi3sRYJVScf8L5E=
Received: from OSBPR01MB3783.jpnprd01.prod.outlook.com (20.178.96.203) by
 OSBPR01MB2822.jpnprd01.prod.outlook.com (52.134.251.202) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.18; Thu, 31 Oct 2019 09:40:26 +0000
Received: from OSBPR01MB3783.jpnprd01.prod.outlook.com
 ([fe80::4cef:c2a5:21f3:9f3c]) by OSBPR01MB3783.jpnprd01.prod.outlook.com
 ([fe80::4cef:c2a5:21f3:9f3c%5]) with mapi id 15.20.2387.028; Thu, 31 Oct 2019
 09:40:26 +0000
From: "misono.tomohiro@fujitsu.com" <misono.tomohiro@fujitsu.com>
To: 'Vivek Goyal' <vgoyal@redhat.com>
Subject: RE: [Virtio-fs] [PATCH] virtiofsd: Fix data corruption with O_APPEND
 wirte in writeback mode
Thread-Topic: [Virtio-fs] [PATCH] virtiofsd: Fix data corruption with O_APPEND
 wirte in writeback mode
Thread-Index: AQHViZvpLbfW+G+A2EG+Hrhspumg2Kdop+EAgAE8/oCAAT3lEIAGLehAgAMsGQA=
Date: Thu, 31 Oct 2019 09:39:23 +0000
Deferred-Delivery: Thu, 31 Oct 2019 09:39:43 +0000
Message-ID: <OSBPR01MB3783739E4F9545DABEF3E230E5630@OSBPR01MB3783.jpnprd01.prod.outlook.com>
References: <20191023122523.1816-1-misono.tomohiro@jp.fujitsu.com>
 <20191023200752.GB6942@redhat.com> <20191024150225.GB6903@redhat.com>
 <OSBPR01MB3783EBE1BB481BD1B14B8D45E5650@OSBPR01MB3783.jpnprd01.prod.outlook.com>
 <OSBPR01MB37833C9325AD3D9190108FAEE5610@OSBPR01MB3783.jpnprd01.prod.outlook.com>
In-Reply-To: <OSBPR01MB37833C9325AD3D9190108FAEE5610@OSBPR01MB3783.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-shieldmailcheckerpolicyversion: FJ-ISEC-20181130-VDI-enc
x-shieldmailcheckermailid: 2678e39904bd40e182cf7dc61d55328c
x-securitypolicycheck: OK by SHieldMailChecker v2.6.2
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=misono.tomohiro@fujitsu.com; 
x-originating-ip: [210.162.184.109]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bcabf7a8-5934-4876-ed30-08d75de65c41
x-ms-traffictypediagnostic: OSBPR01MB2822:
x-microsoft-antispam-prvs: <OSBPR01MB2822F5A26CB6AD3878DECCBEE5630@OSBPR01MB2822.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 02070414A1
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(136003)(366004)(376002)(346002)(52314003)(199004)(189003)(13464003)(6916009)(66446008)(52536014)(64756008)(76176011)(55016002)(54906003)(316002)(76116006)(66476007)(66556008)(66946007)(5660300002)(9686003)(7696005)(26005)(186003)(6436002)(8936002)(8676002)(66066001)(81156014)(99286004)(81166006)(6246003)(229853002)(6506007)(53546011)(102836004)(256004)(74316002)(6666004)(2906002)(86362001)(14444005)(3846002)(6116002)(25786009)(71190400001)(478600001)(11346002)(4326008)(476003)(33656002)(446003)(486006)(7736002)(71200400001)(305945005)(14454004)(85182001)(777600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:OSBPR01MB2822;
 H:OSBPR01MB3783.jpnprd01.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dX6MqfAa/8xcZY6SHBbhUM4B45+GSK83ghfGJrV0wnd6uGygs/Xka4CUMSYQwsWI/bfC/HHi5qzhEmVUiOVGVnHXviLSiIibQCeKWlDLRv+y+aCb8FVeeN8bV6kLbmw4oU3C0cKsmTC+IB/kjzNgsaWSPLE4bcK7KpYJ/XTe/4VkaBOhjg5X+NVZeYPUK5+J6itN1ZZX4uPKGf4DeRWLlNascs8r0FlEjFQFYoqMGvlE4ejq4HTjhnbMtvFsxTvRkbq+mvBRLTGvHJyOlzWd00LP3zznI3oVfO6I+kAm3TwSoUbjZfwPWWGkXr98763rodYWfwaPsxEfsiTTAUBTOuFgcU+aH+4n6MvMM9HaMuxsLQqFUFMpTJ/lN1H7bkzvH1PVsMv1aPNlOMO0OOJTdV6HhUJmRYJGnEc9Mx7gD+i0g3f4Ie+yOYzqbD1EETlI
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcabf7a8-5934-4876-ed30-08d75de65c41
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2019 09:40:26.7260 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: srQAfzShwjqfvOO9MkZUrS8hekkxqcWjRKS81J6L61ePvH8xcQHHrvYk8wwyQOcMHSTn5rpMtpPAjR/uLNsr9afaCVRayOJZDQNBFfs/vkQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2822
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 68.232.159.76
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
Cc: "'virtio-fs@redhat.com'" <virtio-fs@redhat.com>,
 "'qemu-devel@nongnu.org'" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> > -----Original Message-----
> > From: virtio-fs-bounces@redhat.com
> > [mailto:virtio-fs-bounces@redhat.com] On Behalf Of
> > misono.tomohiro@fujitsu.com
> > Sent: Friday, October 25, 2019 7:02 PM
> > To: 'Vivek Goyal' <vgoyal@redhat.com>
> > Cc: virtio-fs@redhat.com; qemu-devel@nongnu.org
> > Subject: Re: [Virtio-fs] [PATCH] virtiofsd: Fix data corruption with
> > O_APPEND wirte in writeback mode
> >
> > > On Wed, Oct 23, 2019 at 04:07:52PM -0400, Vivek Goyal wrote:
> > > > On Wed, Oct 23, 2019 at 09:25:23PM +0900, Misono Tomohiro wrote:
> > > > > When writeback mode is enabled (-o writeback), O_APPEND handling
> > > > > is done in kernel. Therefore virtiofsd clears O_APPEND flag when =
open.
> > > > > Otherwise O_APPEND flag takes precedence over pwrite() and write
> > > > > data may corrupt.
> > > > >
> > > > > Currently clearing O_APPEND flag is done in lo_open(), but we
> > > > > also need the same operation in lo_create().
> > > >
> > > > > So, factor out the flag
> > > > > update operation in lo_open() to update_open_flags() and call it
> > > > > in both lo_open() and lo_create().
> > > > >
> > > > > This fixes the failure of xfstest generic/069 in writeback mode
> > > > > (which tests O_APPEND write data integrity).
> > > > >
> > >
> > > Hi Misono,
> > >
> > > Have you tried running pjdfstests. Looks like with the patch applied
> > > I see following tests failing which were passing without the patch.
> > > Can you please have a look. I ran daemon with options "-o
> > cache=3Dalways -o writeback"
>=20
> I see these errors in both with and without this patch but not always.
> Do you always see the failure?
>=20
> I use:
>   Kernel: Fuse's for-next branch
>   Qemu: virtio-fs-dev branch
>   backend: XFS (relatime)
>=20
> These tests fail because a/c/m time is not updated as expected.
> So it seems this is related to the failure of xfstest generic/003.
> I will look into the problem more.
>=20

Hi,

So I fugured out the problem.=20
The failure occurs when guest clock is earlier than host clock in writeback=
 mode.

The failure case checks:
 1. get current c/time of file
 2. sleep 1 second
 3. modify file's metadata/data
 4. check if c/mtime is updated

And the tests fail because:
 1. when file is opened, guest inode's time is initialized by host's inode =
information
 2. In writeback mode, guest clock is used for c/mtime update
 3. if guest clock is earlier than host clock, c/mtime could be updated
    earlier than current inode time.=20

I can reproduce the problem reliably by deliberately setting guest clock ea=
rlier
than host clock. I'm not sure if virtiofs is to be blmaed in this case, but=
 should
we not update c/mtime in guest if it is earlier then current c/mtime?

Anyway, I believe this O_APPEND fix patch is irrelevant to the problem,
could you please check it again?

Thanks,
Misono

