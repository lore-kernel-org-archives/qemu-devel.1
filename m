Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B57C10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 17:41:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE9EB2084D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 17:41:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="pihZOPQA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE9EB2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52765 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEdhb-0005oV-4a
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 13:41:31 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jgg@mellanox.com>) id 1hEdgg-0005V0-01
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 13:40:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jgg@mellanox.com>) id 1hEdge-00046w-3I
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 13:40:33 -0400
Received: from mail-eopbgr50071.outbound.protection.outlook.com
	([40.107.5.71]:28435
	helo=EUR03-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jgg@mellanox.com>) id 1hEdgc-00044b-9F
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 13:40:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=cuz4jiABzAnoIVFPNtox2B44nsjSEC3YK4M3JUt7JSk=;
	b=pihZOPQAjnTi4HNclUIdbys0XcfUXrjEcjEu1oerAzFHrOmmhPAzWqXANmKH23IzXyY9KWGPC0ziZ6KhOcQHaDCup8RNCO/dd68T4sVRvflB9h/QjP62lhDx2tROix6Sg5RUFHf92OoN1IILkq7TVP4b+N7HWxhqb87ADF4FWEU=
Received: from AM6PR05MB4439.eurprd05.prod.outlook.com (52.135.162.148) by
	AM6PR05MB4966.eurprd05.prod.outlook.com (20.177.36.15) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1771.21; Thu, 11 Apr 2019 17:40:27 +0000
Received: from AM6PR05MB4439.eurprd05.prod.outlook.com
	([fe80::24cd:a3f1:870b:bd92]) by
	AM6PR05MB4439.eurprd05.prod.outlook.com
	([fe80::24cd:a3f1:870b:bd92%5]) with mapi id 15.20.1792.009;
	Thu, 11 Apr 2019 17:40:26 +0000
From: Jason Gunthorpe <jgg@mellanox.com>
To: Yuval Shaia <yuval.shaia@oracle.com>
Thread-Topic: [RFC 0/3] VirtIO RDMA
Thread-Index: AQHU8FYDv72twQKPxUOduVqaSCXjp6Y3L/SAgAAGFgCAAALgAIAAAbAA
Date: Thu, 11 Apr 2019 17:40:26 +0000
Message-ID: <20190411174022.GA26227@mellanox.com>
References: <20190411110157.14252-1-yuval.shaia@oracle.com>
	<20190411190215.2163572e.cohuck@redhat.com>
	<20190411172402.GA14509@mellanox.com> <20190411173419.GB6259@lap1>
In-Reply-To: <20190411173419.GB6259@lap1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YQXPR0101CA0032.CANPRD01.PROD.OUTLOOK.COM
	(2603:10b6:c00:15::45) To AM6PR05MB4439.eurprd05.prod.outlook.com
	(2603:10a6:209:43::20)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.49.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a5bcb945-895f-49c6-7033-08d6bea4c83a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);
	SRVR:AM6PR05MB4966; 
x-ms-traffictypediagnostic: AM6PR05MB4966:
x-microsoft-antispam-prvs: <AM6PR05MB4966D0161CC33A34AFB635E2CF2F0@AM6PR05MB4966.eurprd05.prod.outlook.com>
x-forefront-prvs: 00046D390F
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(396003)(39860400002)(346002)(136003)(376002)(366004)(52314003)(189003)(199004)(6246003)(86362001)(76176011)(25786009)(54906003)(71190400001)(105586002)(71200400001)(1076003)(106356001)(6116002)(33656002)(36756003)(4326008)(3846002)(6436002)(186003)(26005)(52116002)(6506007)(316002)(102836004)(386003)(6486002)(305945005)(256004)(99286004)(8676002)(6512007)(2906002)(81156014)(229853002)(5660300002)(14444005)(7736002)(81166006)(93886005)(476003)(2616005)(11346002)(446003)(53936002)(6916009)(486006)(8936002)(97736004)(68736007)(66066001)(14454004)(478600001);
	DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR05MB4966;
	H:AM6PR05MB4439.eurprd05.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: mellanox.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: UEOrv6MGrZ/TGfhG5t5WtgLRX+YMYRvrBolpmdER8YeWUuYRjNxdWLROdHV7q/GOX5wdR5PdKSs0OMeo/0GFsSXy4g576269d2pyATjvNMyILS9sGk4rMKGNyc3ZgyeAUGfvaEnNJoMmoJPH+qUVrYGoI/C97Qm46HqPLUoSP1cjJP/0Dm5evX5I6QtN7SWN1rie2o9m5iVpkeni+eNhMD6Ap7bE2upUxR6Xi28rteS4aXsVHb4Zq27/BHbbq7qlBiSDFG5uVhbDJoEQ3KxBIrAmItW/b5Xlgxb9ImXd10TV+ugAtnnCI4ahHnOWnE6R5Y1Bt63KapWtymQQKK28b3RV6UJjgVUjAWq1VTxqGO+IOngwY5ovlPrYJrpmfiztW5Fzf70JpX4JPZ8KrGfwnL3E+m8s3+8k1oAULodQQb4=
Content-Type: text/plain; charset="UTF-8"
Content-ID: <6242C05B658BD24198CF603E9E63C344@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5bcb945-895f-49c6-7033-08d6bea4c83a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2019 17:40:26.8124 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB4966
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.5.71
Subject: Re: [Qemu-devel] [RFC 0/3] VirtIO RDMA
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
Cc: "mst@redhat.com" <mst@redhat.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	Cornelia Huck <cohuck@redhat.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"virtualization@lists.linux-foundation.org"
	<virtualization@lists.linux-foundation.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190411174026.z2v9Uih1tQVAKnkF9PH5hiNiQJ_2Ilf7IY_Wo9-3YUc@z>

On Thu, Apr 11, 2019 at 08:34:20PM +0300, Yuval Shaia wrote:
> On Thu, Apr 11, 2019 at 05:24:08PM +0000, Jason Gunthorpe wrote:
> > On Thu, Apr 11, 2019 at 07:02:15PM +0200, Cornelia Huck wrote:
> > > On Thu, 11 Apr 2019 14:01:54 +0300
> > > Yuval Shaia <yuval.shaia@oracle.com> wrote:
> > >=20
> > > > Data center backends use more and more RDMA or RoCE devices and mor=
e and
> > > > more software runs in virtualized environment.
> > > > There is a need for a standard to enable RDMA/RoCE on Virtual Machi=
nes.
> > > >=20
> > > > Virtio is the optimal solution since is the de-facto para-virtualiz=
aton
> > > > technology and also because the Virtio specification
> > > > allows Hardware Vendors to support Virtio protocol natively in orde=
r to
> > > > achieve bare metal performance.
> > > >=20
> > > > This RFC is an effort to addresses challenges in defining the RDMA/=
RoCE
> > > > Virtio Specification and a look forward on possible implementation
> > > > techniques.
> > > >=20
> > > > Open issues/Todo list:
> > > > List is huge, this is only start point of the project.
> > > > Anyway, here is one example of item in the list:
> > > > - Multi VirtQ: Every QP has two rings and every CQ has one. This me=
ans that
> > > >   in order to support for example 32K QPs we will need 64K VirtQ. N=
ot sure
> > > >   that this is reasonable so one option is to have one for all and
> > > >   multiplex the traffic on it. This is not good approach as by desi=
gn it
> > > >   introducing an optional starvation. Another approach would be mul=
ti
> > > >   queues and round-robin (for example) between them.
> > > >=20
> > > > Expectations from this posting:
> > > > In general, any comment is welcome, starting from hey, drop this as=
 it is a
> > > > very bad idea, to yeah, go ahead, we really want it.
> > > > Idea here is that since it is not a minor effort i first want to kn=
ow if
> > > > there is some sort interest in the community for such device.
> > >=20
> > > My first reaction is: Sounds sensible, but it would be good to have a
> > > spec for this :)
> >=20
> > I'm unclear why you'd want to have a virtio queue for anything other
> > that some kind of command channel.
> >=20
> > I'm not sure a QP or CQ benefits from this??
>=20
> Virtqueue is a standard mechanism to pass data from guest to host. By
> saying that - it really sounds like QP send and recv rings. So my thought
> is to use a standard way for rings. As i've learned this is how it is use=
d
> by other virtio devices ex virtio-net.

I doubt you can use virtio queues from userspace securely? Usually
needs a dedicated page for each user space process

Jason

