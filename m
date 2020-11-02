Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9348C00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 11:52:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A31222226
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 11:52:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="uCuYKSbX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A31222226
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZYO9-0001pE-2F
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 06:52:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50786)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thanos.makatos@nutanix.com>)
 id 1kZYNY-0001QQ-2E
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 06:52:04 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68]:13442)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thanos.makatos@nutanix.com>)
 id 1kZYNV-0001AI-9a
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 06:52:03 -0500
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 0A2BpnOU029104; Mon, 2 Nov 2020 03:51:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint20171006;
 bh=0D3dJ2nTjT9yhr4SapiKdKMkDDD4oCfVOTwupcU9OrM=;
 b=uCuYKSbXbrN+iio5Hkm62Z3bUqAG3OZnc1w7tWL9WTEv2OWEfeyhTfJOpfz7WI5nF/xb
 PukDFp9wczhteHKX8WDpDix6Anzub2xurFukrqZ0ewRmhzCZdQ+5Ry/fP8YvH+X9iOsa
 YwVPuBU/mfxtp20Nxm5Gm8zgO1CMquYflesfaeR4BSskCjx9RWni//KU+oS8iU1CfLRX
 uJ4bUI+rlxMvzkA1so/rkRSyXGmgw+bY9xBfkP0omN2J+/Ad7Ok1Pwmy+af2YjNT4Kvn
 6yT4K+0bFDo2oA4iuRXs9tEKQaaZ4eWK+YXRnXCeqyfPhSXC1hf7bjpK2YKy8K1CJ8XE Mg== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
 by mx0a-002c1b01.pphosted.com with ESMTP id 34h7fxk5w6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 02 Nov 2020 03:51:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ilbpTHVcAYmMGkV4qvc0w824TF8TTBRxn+7xnGDMTr+TbS9H5rVr99dVZHeTI/iukjq6yv+Y5gohl8i9n5lJ5IuLv6x+sstiEaZEdCLq94WCLmDq24osLRoza6RMurtf21im087GeNEEaYTGY9MGYHl3irldwnugqcLJGnhA7dcz4LZ8UFxL1Nh5cG9YbFTEH7SyrHWSjZwSp8+dKnctBJGRbSyK2tVI9D6K2MrdjkYs+x1NAZwujwqwYFRjJNM/eLHsx5zOrU0O5ES7eEg0misKLitbFwykKm2IEvH+D9xlwv9km7IONfVL0fWEzETrw2UBk2k/+hx+UDfsBUaB4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0D3dJ2nTjT9yhr4SapiKdKMkDDD4oCfVOTwupcU9OrM=;
 b=oKdGLnW34pVGuDLpnEZ8R4RJc5WCi/7JOOK90cDgyoWCb61de0rqbyCVIqt3fmt8mvEjYznuaWvXk0kIYoPmq6WeMKUI1r6dm/QMrEQu4ssbgNHeG0F8cDSOrNwGTMPENiQJ5Oj0bqyeiZY0h+Aes8E0Nk79/hoYfDrdvzJZcKdxZGXql9lsjy70jatt1UTA/0776qVZn85vOWG764PYR3uU2GP9tKcqMlmMjnoHsmRV9Rj7jwdy4LpSbshkttto4fv+lHfuuaZCmQnSZ5ZHoQGOKzNOYYNv341RPdRrg5ru0GZLk5PoEgZGhjVoEQNTwefMiJOHzBzdMX0isUrKIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from MW2PR02MB3723.namprd02.prod.outlook.com (2603:10b6:907:2::32)
 by MWHPR0201MB3401.namprd02.prod.outlook.com (2603:10b6:301:76::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.29; Mon, 2 Nov
 2020 11:51:48 +0000
Received: from MW2PR02MB3723.namprd02.prod.outlook.com
 ([fe80::81cb:c77a:ef0:84e0]) by MW2PR02MB3723.namprd02.prod.outlook.com
 ([fe80::81cb:c77a:ef0:84e0%5]) with mapi id 15.20.3499.030; Mon, 2 Nov 2020
 11:51:48 +0000
From: Thanos Makatos <thanos.makatos@nutanix.com>
To: John Levon <levon@movementarian.org>
Subject: RE: [PATCH v5] introduce vfio-user protocol specification
Thread-Topic: [PATCH v5] introduce vfio-user protocol specification
Thread-Index: AQHWrUTVjUvP5pU8VEG/kGG39PR4hqmtNlfQgAMsMQCABFmqAIAAA3UAgAABbyA=
Date: Mon, 2 Nov 2020 11:51:48 +0000
Message-ID: <MW2PR02MB3723F4DDEA3486981AAA9F088B100@MW2PR02MB3723.namprd02.prod.outlook.com>
References: <1594984851-59327-1-git-send-email-thanos.makatos@nutanix.com>
 <20201028161005.115810-1-thanos.makatos@nutanix.com>
 <SN1PR02MB3725C85DCD4BF652FF6FBB8D8B170@SN1PR02MB3725.namprd02.prod.outlook.com>
 <20201030170306.GA2544852@li1368-133.members.linode.com>
 <MW2PR02MB3723D387485067C65D31D2328B100@MW2PR02MB3723.namprd02.prod.outlook.com>
 <20201102114126.GA54031@li1368-133.members.linode.com>
In-Reply-To: <20201102114126.GA54031@li1368-133.members.linode.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: movementarian.org; dkim=none (message not signed)
 header.d=none;movementarian.org; dmarc=none action=none
 header.from=nutanix.com;
x-originating-ip: [78.149.9.252]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6b7442c1-9863-4692-0cea-08d87f25ae56
x-ms-traffictypediagnostic: MWHPR0201MB3401:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR0201MB34016F97E63F1F820A38C50E8B100@MWHPR0201MB3401.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KzrRbFBq0IhszUiAJlx6nIo4MuDnXpbhZmqPKeBk6/bHSkLKsHdp1sOcYFLKpOlU1ByBraLaizKrcEl4TuH8uJMMpiNu5euseeJq7vxifZEEvIzbRkZnK/4qjSYUCBZH8x78MUq5wtbaT67wMaPMpn0mpbttBK5jF/Z10cpdDbNCHuAoHX8+mQwaxZ8RLgbUjwO4R++7MAN7mxuWaWaUlffb+b2o4vj2514109XCHjFY5Ga1vD5QoGeDnt7BPqI95HhDWeiauEOlsC1UmJFsKCMSQH42FJUn2xfLt+vHAV2rxj+YiIKmHVSwjmiWtltcIeSqaWAYhBAbCerCeOKOlQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR02MB3723.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(396003)(346002)(376002)(39860400002)(136003)(66946007)(66556008)(66476007)(2906002)(44832011)(9686003)(54906003)(76116006)(66446008)(52536014)(316002)(64756008)(478600001)(55016002)(55236004)(8676002)(5660300002)(53546011)(26005)(6506007)(7696005)(6916009)(71200400001)(83380400001)(86362001)(8936002)(4326008)(33656002)(186003)(7416002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: /P5ZsWCmPO2EuPVFBF+EKThHNPwgq6tpGtOoPCbU36E+Ww/2F3/sxUD//NdTc+dwwU/yyTsrlifCY9B3BPcl2dDgTIzaTgePMHKBv9M5F+ZRKqf4XdmI/JzeO85ycsB6KYpjlX+T9vPGQ5lryTIc6NiKsn7MQ36VuvfELaJzMPCyd71Gp0TwTKtkf4LJWcQBEq6Y6Cklr6GdaR2FP4pJCzG6i+OHqcF7vv+R3wOW/dDHCYu9GkQ+zBakpA86U3yWuDHK+B4p3pvwqTb2sasViGuu9Vf3Kdc9DNeoaTGghKey2133bbeFYMa84MaSK2oi+mCGQbxAZ8Bej164szy0xcT655VhrKysn/KBEpx2dono8rJ+dGpF+WJ042Pg0QqFOnMHeCzugaOPbbbRTg25ZRkFsXfNIUlo4tal2gK9cYAPXSisCjUhk1guVYIDPbIv25TRYTZIgPyioTBEepPlcFuD4E9L6eVqcEnCH6mdY9QCfM2r/ft+Jwvg2A0lhc6c/EQzUxa7OO67TFyMerByr3g+b7hDwVwPcaKjXluYaqdWTh3HszhBmHdnI3GeYhK4Ci11G6DPMD7AxrLNzgnY4EP7vN6XYYJ7YhOMDMJ8oL15HsSNLClpZThOBHNsJALE0D60A9tPGOs9qWLkjW6uYg==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR02MB3723.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b7442c1-9863-4692-0cea-08d87f25ae56
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2020 11:51:48.6128 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: votGMtatJAUWmv3GWuHCdPFlhVcD+awCRg3N8hC2qXBiX4Lt/dUrOhGjhmutgo8bm0KRMFb+6lS9R6GnGA7+wsu8AThN6X3tnk/rZVlirgQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3401
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312, 18.0.737
 definitions=2020-11-02_07:2020-11-02,
 2020-11-02 signatures=0
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=thanos.makatos@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 06:51:59
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: "benjamin.walker@intel.com" <benjamin.walker@intel.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 "tomassetti.andrea@gmail.com" <tomassetti.andrea@gmail.com>,
 "jag.raman@oracle.com" <jag.raman@oracle.com>,
 "james.r.harris@intel.com" <james.r.harris@intel.com>,
 Swapnil Ingle <swapnil.ingle@nutanix.com>,
 "john.g.johnson@oracle.com" <john.g.johnson@oracle.com>,
 "yuvalkashtan@gmail.com" <yuvalkashtan@gmail.com>,
 "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
 "Kanth.Ghatraju@oracle.com" <Kanth.Ghatraju@oracle.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "tina.zhang@intel.com" <tina.zhang@intel.com>,
 "ismael@linux.com" <ismael@linux.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Felipe Franciosi <felipe@nutanix.com>,
 "xiuchun.lu@intel.com" <xiuchun.lu@intel.com>,
 =?iso-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 "changpeng.liu@intel.com" <changpeng.liu@intel.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> -----Original Message-----
> From: Qemu-devel <qemu-devel-
> bounces+thanos.makatos=3Dnutanix.com@nongnu.org> On Behalf Of John
> Levon
> Sent: 02 November 2020 11:41
> To: Thanos Makatos <thanos.makatos@nutanix.com>
> Cc: benjamin.walker@intel.com; Elena Ufimtseva
> <elena.ufimtseva@oracle.com>; jag.raman@oracle.com;
> james.r.harris@intel.com; Swapnil Ingle <swapnil.ingle@nutanix.com>;
> john.g.johnson@oracle.com; yuvalkashtan@gmail.com;
> konrad.wilk@oracle.com; tina.zhang@intel.com; qemu-devel@nongnu.org;
> dgilbert@redhat.com; Marc-Andr=E9 Lureau
> <marcandre.lureau@redhat.com>; ismael@linux.com;
> alex.williamson@redhat.com; Stefan Hajnoczi <stefanha@redhat.com>;
> Felipe Franciosi <felipe@nutanix.com>; xiuchun.lu@intel.com;
> tomassetti.andrea@gmail.com; changpeng.liu@intel.com; Raphael Norwitz
> <raphael.norwitz@nutanix.com>; Kanth.Ghatraju@oracle.com
> Subject: Re: [PATCH v5] introduce vfio-user protocol specification
>=20
> On Mon, Nov 02, 2020 at 11:29:23AM +0000, Thanos Makatos wrote:
>=20
> > >
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D+=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> > > > | version      | object | ``{"major": <number>, "minor": <number>}`=
`
> |
> > > > |              |        |                                          =
         |
> > > > |              |        | Version supported by the sender, e.g. "0.=
1".      |
> > >
> > > It seems quite unlikely but this should specify it's strings not floa=
ting point
> > > values maybe?
> > >
> > > Definitely applies to max_fds too.
> >
> > major and minor are JSON numbers and specifically integers.
>=20
> It is debatable as to whether there is such a thing as a JSON integer :)

AFAIK there isn't.

>=20
> > The rationale behind this is to simplify parsing. Is specifying that
> > major/minor/max_fds should be an interger sufficient to clear any
> vagueness
> > here?
>=20
> I suppose that's OK as long as we never want a 0.1.1 or whatever. I'm not
> sure
> it simplifies parsing, but maybe it does.

Now that you mention it, why preclude 0.1.1? IIUC the whole point of not
stating the version as a float is to simply have this flexibility in the fu=
ture.
You're right in your earlier suggestion to explicitly state major/minor as
strings.

>=20
> > > > Versioning and Feature Support
> > > > ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > > > Upon accepting a connection, the server must send a
> VFIO_USER_VERSION
> > > message
> > > > proposing a protocol version and a set of capabilities. The client
> compares
> > > > these with the versions and capabilities it supports and sends a
> > > > VFIO_USER_VERSION reply according to the following rules.
> > >
> > > I'm curious if there was a specific reason it's this way around, when=
 it
> seems
> > > more natural for the client to propose first, and the server to reply=
?
> >
> > I'm not aware of any specific reason.
>=20
> So can we switch it now so the initial setup is a send/recv too?

I'm fine with that but would first like to hear back from John in case he o=
bjects.

