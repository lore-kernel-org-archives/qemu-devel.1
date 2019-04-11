Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24560C10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 17:37:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D66BA2084D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 17:37:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="E2Q/Jrir"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D66BA2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52700 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEddy-0004EX-TV
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 13:37:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49631)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jgg@mellanox.com>) id 1hEdQs-0003bl-Be
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 13:24:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jgg@mellanox.com>) id 1hEdQr-0002LF-Bs
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 13:24:14 -0400
Received: from mail-eopbgr10057.outbound.protection.outlook.com
	([40.107.1.57]:23806
	helo=EUR02-HE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jgg@mellanox.com>) id 1hEdQq-0002Kf-SA
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 13:24:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=k3n6yH9+ZsgelX5Kdpaq1ablKEQSCnQBt+g6UdZE1BA=;
	b=E2Q/JrirycL1Wm7Q5Y5OblcjR+hgPAvs065CIn233OERK6TrV1AgM2vdAPs7PIPmGJBxiVRCV9ADQHG6I7IuTmwBvimR6IlPs2qluDCaMIX6ZkZoP7zYjD+v6d1aH45uaOQU+GfsyflGucDcgvoIV+3szqiN3G/WyocRQFwMHtQ=
Received: from AM6PR05MB4439.eurprd05.prod.outlook.com (52.135.162.148) by
	AM6PR05MB5911.eurprd05.prod.outlook.com (20.179.0.156) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1771.13; Thu, 11 Apr 2019 17:24:09 +0000
Received: from AM6PR05MB4439.eurprd05.prod.outlook.com
	([fe80::24cd:a3f1:870b:bd92]) by
	AM6PR05MB4439.eurprd05.prod.outlook.com
	([fe80::24cd:a3f1:870b:bd92%5]) with mapi id 15.20.1792.009;
	Thu, 11 Apr 2019 17:24:09 +0000
From: Jason Gunthorpe <jgg@mellanox.com>
To: Cornelia Huck <cohuck@redhat.com>
Thread-Topic: [RFC 0/3] VirtIO RDMA
Thread-Index: AQHU8FYDv72twQKPxUOduVqaSCXjp6Y3L/SAgAAGFgA=
Date: Thu, 11 Apr 2019 17:24:08 +0000
Message-ID: <20190411172402.GA14509@mellanox.com>
References: <20190411110157.14252-1-yuval.shaia@oracle.com>
	<20190411190215.2163572e.cohuck@redhat.com>
In-Reply-To: <20190411190215.2163572e.cohuck@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YQBPR0101CA0009.CANPRD01.PROD.OUTLOOK.COM
	(2603:10b6:c00::22) To AM6PR05MB4439.eurprd05.prod.outlook.com
	(2603:10a6:209:43::20)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.49.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bd962399-c358-4183-837a-08d6bea2818f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);
	SRVR:AM6PR05MB5911; 
x-ms-traffictypediagnostic: AM6PR05MB5911:
x-microsoft-antispam-prvs: <AM6PR05MB59116274BF5712FFF6CA30ACCF2F0@AM6PR05MB5911.eurprd05.prod.outlook.com>
x-forefront-prvs: 00046D390F
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(136003)(366004)(376002)(39860400002)(346002)(396003)(52314003)(189003)(199004)(486006)(229853002)(76176011)(5660300002)(68736007)(386003)(54906003)(8936002)(106356001)(6506007)(102836004)(105586002)(81166006)(86362001)(81156014)(2906002)(256004)(36756003)(97736004)(52116002)(99286004)(33656002)(14444005)(1076003)(3846002)(14454004)(316002)(446003)(66066001)(2616005)(25786009)(71200400001)(53936002)(478600001)(6116002)(6436002)(71190400001)(186003)(8676002)(476003)(305945005)(6246003)(26005)(4326008)(7736002)(6916009)(6512007)(6486002)(11346002);
	DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR05MB5911;
	H:AM6PR05MB4439.eurprd05.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: mellanox.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pL6gSCAN0agSSnte138JAdsdYswKIUN4dDErcVY8gRzInji4bEbAfeIBkAzz7PEWrS5AdCgBgXfZnQjw7Y93ZuvLyuKe/bWaLatPwUamzXpX7FjPLhTqApSvDCF+o5OXhrdqlaY1y6FVq1K2VNK7i6IedVBIQrkivOEGQcjQC0Yg88hGgxaPHgLmLL/Uk8iBqMscd8E6NCGwQhpS6WRsH28SK4Q+gfN7va3r9048GG92R7nfi17C4gfpVfeAuLNSW7Dbj70qIcnJZ42MZHv1QC6jG2TpgnDuli6PxtZPGR+BnCNx9XKoihMyffZ1r4fd8zWPEC8nUUmHHjH2I//j7KRqkJLzv7//F3MKUhKJ8cbwGJVg2CPXs+SHP0HAXJ+WtVZVXvcHPHj6MxreFqsPIlkLhqCqix4yTWWBNZBRDdE=
Content-Type: text/plain; charset="UTF-8"
Content-ID: <D48BEB556881BA44BDF61657FE88A114@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd962399-c358-4183-837a-08d6bea2818f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2019 17:24:08.9841 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB5911
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.1.57
X-Mailman-Approved-At: Thu, 11 Apr 2019 13:36:10 -0400
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
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	Yuval Shaia <yuval.shaia@oracle.com>,
	"virtualization@lists.linux-foundation.org"
	<virtualization@lists.linux-foundation.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190411172408.k9a_zMoC1d1B75YEFdO9pw5YEuOqPxqmdAU647jvBSM@z>

On Thu, Apr 11, 2019 at 07:02:15PM +0200, Cornelia Huck wrote:
> On Thu, 11 Apr 2019 14:01:54 +0300
> Yuval Shaia <yuval.shaia@oracle.com> wrote:
>=20
> > Data center backends use more and more RDMA or RoCE devices and more an=
d
> > more software runs in virtualized environment.
> > There is a need for a standard to enable RDMA/RoCE on Virtual Machines.
> >=20
> > Virtio is the optimal solution since is the de-facto para-virtualizaton
> > technology and also because the Virtio specification
> > allows Hardware Vendors to support Virtio protocol natively in order to
> > achieve bare metal performance.
> >=20
> > This RFC is an effort to addresses challenges in defining the RDMA/RoCE
> > Virtio Specification and a look forward on possible implementation
> > techniques.
> >=20
> > Open issues/Todo list:
> > List is huge, this is only start point of the project.
> > Anyway, here is one example of item in the list:
> > - Multi VirtQ: Every QP has two rings and every CQ has one. This means =
that
> >   in order to support for example 32K QPs we will need 64K VirtQ. Not s=
ure
> >   that this is reasonable so one option is to have one for all and
> >   multiplex the traffic on it. This is not good approach as by design i=
t
> >   introducing an optional starvation. Another approach would be multi
> >   queues and round-robin (for example) between them.
> >=20
> > Expectations from this posting:
> > In general, any comment is welcome, starting from hey, drop this as it =
is a
> > very bad idea, to yeah, go ahead, we really want it.
> > Idea here is that since it is not a minor effort i first want to know i=
f
> > there is some sort interest in the community for such device.
>=20
> My first reaction is: Sounds sensible, but it would be good to have a
> spec for this :)

I'm unclear why you'd want to have a virtio queue for anything other
that some kind of command channel.

I'm not sure a QP or CQ benefits from this??

Jason

