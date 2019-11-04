Return-Path: <SRS0=KlJF=Y4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C55CA9EBB
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 02:36:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAD4E217F5
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 02:36:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KatdbKHZ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="Pk5aEs+I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAD4E217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRSET-0001Jt-3h
	for qemu-devel@archiver.kernel.org; Sun, 03 Nov 2019 21:36:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52683)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tsimpson@quicinc.com>) id 1iRSDC-0000ex-2Q
 for qemu-devel@nongnu.org; Sun, 03 Nov 2019 21:35:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tsimpson@quicinc.com>) id 1iRSDA-0005kr-ME
 for qemu-devel@nongnu.org; Sun, 03 Nov 2019 21:35:21 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:18238)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tsimpson@quicinc.com>)
 id 1iRSDA-0005jx-6y
 for qemu-devel@nongnu.org; Sun, 03 Nov 2019 21:35:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1572834920; x=1604370920;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=O346F64lE7+yb28eIq9dWsdn7DwEZ5vUZp/KIUwDJik=;
 b=KatdbKHZh0HIMr70pY0YnZo9Z78Lqn5DKQodgVDbaUhCf3yzlQAci7ap
 thF7eNhpP2+oSiN9HXEjEXO+QZYLbJAqaD4VMjx06m6aoUpuR/9VFTbk8
 zN49HJKENQ3mFP66Ew+IpMdO6lnUy9B+d45+t5IXB4Eb+wLkHoGTidJvg s=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 03 Nov 2019 18:35:18 -0800
IronPort-SDR: 2HF4SDhZNIiPWUPTExzed3yghY6fMg0ijCBocJGQym3JnK0v96b1mTeFuydivHqwYEqmpl0x2g
 BaiCabueCcgVMrejEmTi8bXN8g231eolZs7lZEJgszFduBNBphZ40wL1UvZP75wzG4Al1FmRWM
 fIq/TxzaAd/KscgwwV4/DLpjWhm5Y4OPra0pVWvq97kKY2gWHLmi20pnl7LzBeVsWRP7sjkT/C
 T/8ZkQqhFv2Fy8RsMNSzF+E6UFN2hm5q6VSkp3tSys1ex5S/O8DsRlDN0sMxCfllpW7XnuElC3
 RvXxeoZZ8qoyXFUCzUMZcYDH
Received: from nasanexm01e.na.qualcomm.com ([10.85.0.31])
 by ironmsg04-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 03 Nov 2019 18:35:17 -0800
Received: from APSANEXR01E.ap.qualcomm.com (10.85.0.38) by
 NASANEXM01E.na.qualcomm.com (10.85.0.31) with Microsoft SMTP Server (TLS) id
 15.0.1473.3; Sun, 3 Nov 2019 18:35:17 -0800
Received: from nasanexm03c.na.qualcomm.com (10.85.0.106) by
 APSANEXR01E.ap.qualcomm.com (10.85.0.38) with Microsoft SMTP Server (TLS) id
 15.0.1473.3; Sun, 3 Nov 2019 18:35:14 -0800
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03c.na.qualcomm.com (10.85.0.106) with Microsoft SMTP Server (TLS)
 id 15.0.1473.3 via Frontend Transport; Sun, 3 Nov 2019 18:35:13 -0800
Received: from BYAPR02MB4886.namprd02.prod.outlook.com (52.135.234.160) by
 BYAPR02MB5365.namprd02.prod.outlook.com (20.177.124.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Mon, 4 Nov 2019 02:35:11 +0000
Received: from BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::8cc2:1921:4cb1:6cc1]) by BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::8cc2:1921:4cb1:6cc1%7]) with mapi id 15.20.2408.024; Mon, 4 Nov 2019
 02:35:10 +0000
From: Taylor Simpson <tsimpson@quicinc.com>
To: =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: QEMU for Qualcomm Hexagon - KVM Forum talk and code available
Thread-Topic: QEMU for Qualcomm Hexagon - KVM Forum talk and code available
Thread-Index: AdWLUOkdof4fsTRrRvOiehGwyV6GSgFkXJqAAG5SBMA=
Date: Mon, 4 Nov 2019 02:35:10 +0000
Message-ID: <BYAPR02MB4886C84F08CF4877FA4C276DDE7F0@BYAPR02MB4886.namprd02.prod.outlook.com>
References: <BYAPR02MB48863165DEE32E5C563E93F4DE650@BYAPR02MB4886.namprd02.prod.outlook.com>
 <2ae98ce7-7eed-90c5-f29d-5474904ac40c@redhat.com>
In-Reply-To: <2ae98ce7-7eed-90c5-f29d-5474904ac40c@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tsimpson@quicinc.com; 
x-originating-ip: [70.115.140.19]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cabd9edd-3e34-4bf9-b124-08d760cf9d4b
x-ms-traffictypediagnostic: BYAPR02MB5365:
x-ms-exchange-purlcount: 3
x-microsoft-antispam-prvs: <BYAPR02MB5365C4F30D79E2F8FF2BF2BEDE7F0@BYAPR02MB5365.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0211965D06
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(346002)(136003)(396003)(376002)(39860400002)(13464003)(189003)(199004)(476003)(99286004)(7696005)(6506007)(102836004)(76176011)(53546011)(26005)(6116002)(3846002)(81156014)(8676002)(8936002)(2501003)(14444005)(66476007)(66556008)(256004)(6246003)(186003)(446003)(11346002)(486006)(229853002)(55016002)(9686003)(6306002)(4326008)(71190400001)(71200400001)(7736002)(966005)(5660300002)(6436002)(66446008)(64756008)(33656002)(76116006)(66946007)(14454004)(54906003)(110136005)(316002)(81166006)(86362001)(52536014)(66066001)(478600001)(305945005)(25786009)(74316002)(2906002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR02MB5365;
 H:BYAPR02MB4886.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dmzEre3DjPxs659mXLXf7l02gnQlozyXjL0gIwDhbUHDtopTcZZYrS9IMfql/h+b1vhJVgD40KyhnrxUVbjmR3jvsurEreDWJu0Y6tcmiX5zO8CDzZ+LpT8o+8GB/hKDmPnl5klF2PX8pq2TuWxAShbMAABSdM5Nw/SQPiesY75CtxeFmgh7xHhMi9upoZKe3rQhg6ypkj0NwK9GjcfHOBBUaTH9i8ObzMrxkXg+fdM5lqUfxdJA3/zhsPbNFxWIvdja9/Pc5XR+O8Ia84CnPb6Wpjg9GCBXXtuT7Htop7S72opASVNxMlcdMfl9OcWouSRZBHb2ZHL4PezdWkU2voz0DHb7kCfItlihhejPd75a7IwzksRRKWxv1P7iC7gWlDHw15JbuPe8kzq9ZVmXvdhL+oP1+gix/Urg2AzXCrToMgc6tmJsFpgWHPZtUvTSG9UJsCHGjU1Uep4VVwoJiuhy8IEchIkBAtW1uFNc2Gs=
x-ms-exchange-transport-forked: True
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IigB39vDxG59wq/CxRt0fsCcLdFileo44yya3Ss7FzoQeSuENBkaOTs0U9yIKeV7Ftcnl74tgCkSZmWCWOM2L36EEaCCRsnDbxk6pP6HhAkfAhe0djrPUwCrGU4N8pt856H7nQyWkOxGksua1CFxV+QrQIhJ2VYakbmR7Z+k/Tfx88g1a0Eb5nlygQ0x6u0YGsG1FyfXuWEcPK/KOTbbsmUZoSPXgKg2A8w08wdbMxbs1OFBrGHMrk+7vvO06X+nUR4IsnZJMr8bs1+fI0uevbnfSklql+IPx+cqYIawloZE7hSLKDkKuDjUJI1fcSP5I6HuhOGdLAb5SOzVLAeDuA==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bmjxflq7d8IKEvRbv7USH1v9URDhxGMm9z65WzBry3Y=;
 b=mhzzMGfJuP7KvyW8tiw608WOJUiYx9WjlaA2is5CGFlNqXsLPWxehvTgwd48H2PGCwqVC7cos6AMfPUB909mCt7PkMBIxvNnXnlHLtLrpmt1NG+IE+SWk/XrBCRsgBlQuYoywTUGrHwZ22sPNaBHU3U1JvsB8GIk1d105y/43irv2vEz2T09qxA4rvxTxIn3Cv5Cdhzh1jzuVtmyDG654UEZUTzCoNwODbg+HFVaTZ5lxesG1w1+7QU/QXjpwHubByxA7Nsh9uTl1V3cDINDkjkiiyjTm2JT5Uurvk3zBxQ40h8ZahzUTrQ13izIClrg8V/p6X2jYeQllNcTBwFi0A==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector2-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bmjxflq7d8IKEvRbv7USH1v9URDhxGMm9z65WzBry3Y=;
 b=Pk5aEs+IIsffnjazRczv8gTpOWkeS2rrDNmZh8qi+bjk6DCYQ76G7jhtKpXfZ79izOxuYgir4spy6GS449QXECYo53CbBSG0SMMl9LXwNoWuaUoOkQebLQ9JQc5aRwlTh03HR1jjBh9WD0JwfLoiFkoXAS+qyKLou5JYgrzwxqQ=
x-ms-exchange-crosstenant-network-message-id: cabd9edd-3e34-4bf9-b124-08d760cf9d4b
x-ms-exchange-crosstenant-originalarrivaltime: 04 Nov 2019 02:35:10.7508 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: 0c1RFY9mnl1Vyfwpg0EldK2VfpO+VuiuOizZ8CpJMI4cWTYyJ+vtXkdNxaRqTFQwBjesYAkZ0AobKGEzDu5WuQ==
x-ms-exchange-transport-crosstenantheadersstamped: BYAPR02MB5365
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 199.106.114.39
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
Cc: Alessandro Di Federico <ale@rev.ng>, "nizzo@rev.ng" <nizzo@rev.ng>,
 =?iso-8859-1?Q?Niccol=F2_Izzo?= <izzoniccolo@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

That is correct.

Once you register on developer.qualcomm.com, you can download the Hexagon S=
DK version 3.4.3.  Note that there are different downloads for Linux and Wi=
ndows hosts.

Once you have installed the SDK, look for the document bundle in the follow=
ing location
<INSTALL_DIR>/tools/HEXAGON_Tools/8.3.02/Documents/Hexagon_Document_Bundle.=
pdf
That PDF file is a container for a bunch of other documents.  If you want t=
o read more about the Hexagon architecture, look at the following
V67 Programmer's Reference Manual
V66 HVX Programmer's Reference Manual
The version on the quic github implements these.  Note that HVX stands for =
Hexagon Vector eXtensions.  It is an optional set of instructions that oper=
ate on 128-byte vectors.

IIRC, the revng github implements up to V62.  Alessandro or Niccolo can con=
firm.

Note that the toolchain in that installation generates code for the standal=
one runtime or the RTOS, not Linux that the quic qemu generates.  However, =
they should run on the revng version.  In the coming weeks, we'll work on s=
etting up a container to build the toolchain that will generate binaries th=
at will run on the quic version.

If anyone has any more questions, I'm happy to answer them.

Taylor


-----Original Message-----
From: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
Sent: Friday, November 1, 2019 1:30 PM
To: Taylor Simpson <tsimpson@quicinc.com>; qemu-devel@nongnu.org
Cc: Alessandro Di Federico <ale@rev.ng>; nizzo@rev.ng; Niccol=F2 Izzo <izzo=
niccolo@gmail.com>
Subject: Re: QEMU for Qualcomm Hexagon - KVM Forum talk and code available



Hi Taylor,

On 10/25/19 6:26 PM, Taylor Simpson wrote:
> We would like inform the you that we will be doing a talk at the KVM
> Forum next week on QEMU for Qualcomm Hexagon.  Alessandro Di Federico,
> Niccolo Izzo, and I have been working independently on implementations
> of the Hexagon target.  We plan to merge the implementations, have a
> community review, and ultimately have Hexagon be an official target in
> QEMU.  Our code is available at the links below.
>
> _https://github.com/revng/qemu-hexagon_
>
> _https://github.com/quic/qemu_
>
> If anyone has any feedback on the code as it stands today or guidance
> on how best to prepare it for review, please let us know.

Is your target the 'Hexagon Series 600', with documentation available here?
https://developer.qualcomm.com/software/hexagon-dsp-sdk/tools

Regards,

Phil.



