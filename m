Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=BAD_ENC_HEADER,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A9EC433FF
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 12:48:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D94C2205C9
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 12:48:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="F1BQrmFx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D94C2205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hucQ4-0008Bt-TG
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 08:48:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48567)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <rkagan@virtuozzo.com>) id 1hucP7-00066H-R4
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 08:47:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rkagan@virtuozzo.com>) id 1hucP6-0004kd-I0
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 08:47:57 -0400
Received: from mail-db3eur04hn2101.outbound.protection.outlook.com
 ([52.101.138.101]:57518 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
 id 1hucP6-0004hw-CT
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 08:47:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aHXv4GsgV+yRPhdkq/x3xwGcJ5LR6KVl/Jk7hH0QBvHDSG/IAkNesapUL0Y1OlAAmAgzEZ+Dlw+e84Lhiuoix+F0OSzWp4hXZUL8/OrAw5Hl7FsKCbUOHFNCr8QYdwpPvO7DzNKa5NjLt58460/UqaSygpv05p/qJZ9N0uuVpnyakDeXjEPBRytwLHkkmNvU0V6GXwaHhj53DlKdFClC1A/F84nTV0VgCqmplQz4YgiIN0ymODg92FwvJSfYfniPGu/ShQhzyhsT51SoCZlaOqlNHYh54LVOgDS5jOvLPsdvdnMBck88FvD3nlj1u/TFktHHeS6Y6Kmvoax50HYKnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pEKS5s2qVWvX3aK0SnsZsDIfSuZEoARndXmMc0kTRho=;
 b=GRXV36qlK0dleZLi47fz+z4Iw8SGoafO/zvDpOvdig9e2OK5inrYy3H8ZGJEbcvCbBN4bUhk72ciPvkA2GNA3VE7bszO9IUHqybppUsEdEav9xponTe/DRZNER32lxkcpO2qjJ/aKMEmDTz5M+n46AiQuq2xMONxQx6sDm9IgmqT7GyT+oHS9Feu1OeG5tlF8bvkRynVFRfAShQKUL7ETBkUx5XALej3I9w+d0yNaQhk9kVbzXzWbpfUyZhvhycPOsvHVGNi6GPTz7oRQcBC1Uh2eka3ZLI3Mfz4NcUhvE1KSMR2DILejyMDeGCdm9/4uU5D7RiLu2NbmsyImjapxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=virtuozzo.com;dmarc=pass action=none
 header.from=virtuozzo.com;dkim=pass header.d=virtuozzo.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pEKS5s2qVWvX3aK0SnsZsDIfSuZEoARndXmMc0kTRho=;
 b=F1BQrmFxU5zxfeZF70FJPL8BNqjnuiO5IOcAIlE0Bz92WB1C0Ytcns4FYY5KuwWT6aH7fQCWCaQzj0qlqXPSNXTMHsxAAJrY9gQGsa4E3RByVQ6B++o0nMAtOZEcXKfB29ttyUkQCrGOfVktaPjTwnXvF5QePTjdKyoMs0R7Agc=
Received: from AM6PR08MB3160.eurprd08.prod.outlook.com (52.135.163.161) by
 AM6PR08MB3526.eurprd08.prod.outlook.com (20.177.115.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.16; Mon, 5 Aug 2019 12:47:46 +0000
Received: from AM6PR08MB3160.eurprd08.prod.outlook.com
 ([fe80::2c2c:c46e:bdfd:b872]) by AM6PR08MB3160.eurprd08.prod.outlook.com
 ([fe80::2c2c:c46e:bdfd:b872%6]) with mapi id 15.20.2136.018; Mon, 5 Aug 2019
 12:47:46 +0000
From: Roman Kagan <rkagan@virtuozzo.com>
To: =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>
Thread-Topic: [Qemu-devel] [RFC PATCH 0/2] establish nesting rule of BQL vs
 cpu-exclusive
Thread-Index: AQHVEVXwLFxTyUznOk6fV4juQbW3H6Z4k2UAgAZCJQCAD92SAIAXiaEAgEa4igA=
Date: Mon, 5 Aug 2019 12:47:46 +0000
Message-ID: <20190805124744.GC9653@rkaganb.sw.ru>
References: <20190523105440.27045-1-rkagan@virtuozzo.com>
 <87imu11k6z.fsf@zen.linaroharston> <20190527110534.GA13549@rkaganb.sw.ru>
 <20190606132230.GB32258@rkaganb.sw.ru> <20190621124904.GA24164@rkaganb.sw.ru>
In-Reply-To: <20190621124904.GA24164@rkaganb.sw.ru>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.12.1 (2019-06-15)
mail-followup-to: =?iso-8859-1?Q?Roman_Kagan_<rkagan@virtuozzo.com>,
 =09Alex_Benn=E9e_<alex.?=
 =?iso-8859-1?Q?bennee@linaro.org>,=09Paolo_Bonzini_<pbonzini@redhat.com>,?=
 =?iso-8859-1?Q?=09"cota@braap.org"_<cota@braap.org>,=09"richard.henderson?=
 =?iso-8859-1?Q?@linaro.org"_<richard.henderson@linaro.org>,=09"qemu-devel?=
 =?iso-8859-1?Q?@nongnu.org"_<qemu-devel@nongnu.org>?=
x-originating-ip: [185.231.240.5]
x-clientproxiedby: HE1PR05CA0384.eurprd05.prod.outlook.com
 (2603:10a6:7:94::43) To AM6PR08MB3160.eurprd08.prod.outlook.com
 (2603:10a6:209:45::33)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=rkagan@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cfb6baea-83d3-4946-347c-08d719a31d85
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:AM6PR08MB3526; 
x-ms-traffictypediagnostic: AM6PR08MB3526:|AM6PR08MB3526:
x-microsoft-antispam-prvs: <AM6PR08MB3526B30238C89D6AC3D3A810C9DA0@AM6PR08MB3526.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1148;
x-forefront-prvs: 01208B1E18
x-forefront-antispam-report: SFV:SPM;
 SFS:(10019020)(396003)(346002)(366004)(376002)(136003)(39840400004)(199004)(189003)(11346002)(186003)(6486002)(3846002)(36756003)(6116002)(229853002)(86362001)(446003)(256004)(66574012)(8676002)(68736007)(478600001)(1076003)(6916009)(9686003)(476003)(52116002)(6246003)(6512007)(81156014)(6436002)(99286004)(33656002)(14454004)(7736002)(8936002)(81166006)(76176011)(316002)(66946007)(71200400001)(71190400001)(58126008)(53936002)(486006)(66066001)(54906003)(26005)(66556008)(66476007)(5660300002)(305945005)(14444005)(2906002)(386003)(66446008)(102836004)(64756008)(4326008)(6506007)(25786009)(30126002);
 DIR:OUT; SFP:1501; SCL:5; SRVR:AM6PR08MB3526;
 H:AM6PR08MB3160.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: NXK8CoJHe/Kj7sbwa8YAby6TPICCY2cG632JNlI6MYoT6cew8ZPhFC2U9955s4pwg20JAAFUCqJwZeZvohUCzcE8/hKeNXIQjKMlATyYVrd/uTzhqp71EquIdxhB7yMavFvF24qNRZSIfUPkh9pYB2i654bN1oeynZ2Dkr26iYVbCDF6R/g8csU4tWuXTscthYLtceW4pFi7kBTpj8aLTjUTD/+xns5EtpVcicO3DXjLG2cw+I/PD3OF1ojC61Gx4oA41akuFxc6/CCXGrsJLpgCFmXUkxXETfGsFOsrdoXaHTb/Jz/b3Fi13bTh45MCfxcWMsI+6yhXY94vqnuUD1vKxrpUY95dJO1fdRC/ON1oofTaUgtpNfYOix6HC6LM1TRQD6cc1g1dB/mgwhxXjZC7kDBY9tTVRDJBPlX/c7V1Yog3+VS5LqZ6H6c9jAIUl8xZdf1Y2ay6f6g3M5SKa/uRuxhqusNF86/WRBFLcFB5mzF96iafHOB1jyY3e10a
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <8164257DC22A2A4FA2B35BA2A7DC0155@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfb6baea-83d3-4946-347c-08d719a31d85
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2019 12:47:46.4785 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rkagan@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3526
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 52.101.138.101
Subject: Re: [Qemu-devel] [RFC PATCH 0/2] establish nesting rule of BQL vs
 cpu-exclusive
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, "cota@braap.org" <cota@braap.org>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jun 21, 2019 at 12:49:07PM +0000, Roman Kagan wrote:
> On Thu, Jun 06, 2019 at 01:22:33PM +0000, Roman Kagan wrote:
> > On Mon, May 27, 2019 at 11:05:38AM +0000, Roman Kagan wrote:
> > > On Thu, May 23, 2019 at 12:31:16PM +0100, Alex Benn=E9e wrote:
> > > >=20
> > > > Roman Kagan <rkagan@virtuozzo.com> writes:
> > > >=20
> > > > > I came across the following AB-BA deadlock:
> > > > >
> > > > >     vCPU thread                             main thread
> > > > >     -----------                             -----------
> > > > > async_safe_run_on_cpu(self,
> > > > >                       async_synic_update)
> > > > > ...                                         [cpu hot-add]
> > > > > process_queued_cpu_work()
> > > > >   qemu_mutex_unlock_iothread()
> > > > >                                             [grab BQL]
> > > > >   start_exclusive()                         cpu_list_add()
> > > > >   async_synic_update()                        finish_safe_work()
> > > > >     qemu_mutex_lock_iothread()                  cpu_exec_start()
> > > > >
> > > > > ATM async_synic_update seems to be the only async safe work item =
that
> > > > > grabs BQL.  However it isn't quite obvious that it shouldn't; in =
the
> > > > > past there were more examples of this (e.g.
> > > > > memory_region_do_invalidate_mmio_ptr).
> > > > >
> > > > > It looks like the problem is generally in the lack of the nesting=
 rule
> > > > > for cpu-exclusive sections against BQL, so I thought I would try =
to
> > > > > address that.  This patchset is my feeble attempt at this; I'm no=
t sure
> > > > > I fully comprehend all the consequences (rather, I'm sure I don't=
) hence
> > > > > RFC.
> > > >=20
> > > > Hmm I think this is an area touched by:
> > > >=20
> > > >   Subject: [PATCH v7 00/73] per-CPU locks
> > > >   Date: Mon,  4 Mar 2019 13:17:00 -0500
> > > >   Message-Id: <20190304181813.8075-1-cota@braap.org>
> > > >=20
> > > > which has stalled on it's path into the tree. Last time I checked i=
t
> > > > explicitly handled the concept of work that needed the BQL and work=
 that
> > > > didn't.
> > >=20
> > > I'm still trying to get my head around that patchset, but it looks li=
ke
> > > it changes nothing in regards to cpu-exclusive sections and safe work=
,
> > > so it doesn't make the problem go.
> > >=20
> > > > How do you trigger your deadlock? Just hot-pluging CPUs?
> > >=20
> > > Yes.  The window is pretty narrow so I only saw it once although this
> > > test (where the vms are started and stopped and the cpus are plugged =
in
> > > and out) is in our test loop for quite a bit (probably 2+ years).
> > >=20
> > > Roman.
> >=20
> > ping?
>=20
> ping?

ping?

