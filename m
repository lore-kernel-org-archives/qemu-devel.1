Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 310EAC4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 20:01:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7178720679
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 20:00:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="bkteEjqF";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="gqfMDhP6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7178720679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNLo2-00036i-28
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 16:00:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53682)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=534de8db0=Dmitry.Fomichev@wdc.com>)
 id 1kNLgh-0003Xs-4s; Tue, 29 Sep 2020 15:53:24 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:4351)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=534de8db0=Dmitry.Fomichev@wdc.com>)
 id 1kNLgc-0008Jh-F5; Tue, 29 Sep 2020 15:53:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1601409198; x=1632945198;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=FLKDMbpOMhtmQ0Vz5mAPYcEqoxsCEqbZEf35qi5A4pc=;
 b=bkteEjqFfI3mC+4bmo8YWbt8kwcN7OAzNjL3wi9c28R4adi9WHeBL1ib
 7fFyaHNRdd4mEeEnWi6tAYmM6ZhSlRbj3hRZ5jN+6dQ9hRHGqmjjtTsl3
 8spKSDA//AQEndcOdFYUlYcMcFrU3iriejYgz7MNZcFQpAVUvmgP4KNFb
 V9WcSpXWWG0DW7xQDmloQcnX0qqdn0VSl9Lb2T09HTSFcQ2OdjU86S5eJ
 sUPlVlXoNLcNCC663vL+k4dhhKh0K7rqd+tkCWRbOY5HhpKzlEO3IxBUc
 wG4uQZzaTlfDlhBnPyDZ5W10zySNRuaL+MCO/eKWpWkPTRG9Xw4lmGJ76 w==;
IronPort-SDR: YFPiOJ7hMjkWs3Jo7H20yNx9hKdDD8IZSy2RkMG9kSG9z4n2uaZJBtWTUaDRxSCFLPjHZ8c7dg
 C+KL53hIqvmtvg6EUfEIqANYnYaeoGs5rFp01dskCqQQPhviIKa/x0moib6wbs7LhOapAH4DDR
 kqQKaSddaa1nVo0AgTi45Hy/E5rIrm1z89Mocf1xfJnI3E+UkvIWvocoEL/8ETZpxwCJ0sS/3Y
 9IHUBbCmK1bNqS5L/Wg6NDcUQO2VC6ad/f2uN+UFSJHm1VkSOQQbTPeMvUrWIiUjN8C7oplU3Y
 ADs=
X-IronPort-AV: E=Sophos;i="5.77,319,1596470400"; d="scan'208";a="148615384"
Received: from mail-bn8nam11lp2172.outbound.protection.outlook.com (HELO
 NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.172])
 by ob1.hgst.iphmx.com with ESMTP; 30 Sep 2020 03:53:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y71QEkw9Fo8uJhlP0vgtssLFxaGqdwEVTL66GVpBQZLdQbsTGhBpENtT+v60CG3zjEdlYeho8h6a749xROpupyGGB5Y1y3ugEdRZP9TE3ZwC+SXLFjyS9v4py6H51tCzZvQP1iqxGI6j+iXLyECBe7oxsXfHbU2wWB2eHia77UksMKbv1dbmPfbwwn1QYiwa7M24C9MR3RExm7bLVzXwIA6r6gbRwWnnNwMinI5VFG761sOy37SXvLQ/SVGeJ7TqfN55MTfglnUYnH/obg5a0wMvG/j+wUwB2R1EsHps6KB5gWsxs8QGtUvevj2C02OHuvR2ChaBO+J6JrgYVewlIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FLKDMbpOMhtmQ0Vz5mAPYcEqoxsCEqbZEf35qi5A4pc=;
 b=Wqa54YecOAoOgHuawbvXCCYYSWPuSRWRAMbJUkLnVB7spoipB3QGegjOzY2fJu9LnUIwKuYVXpXgu1tJx5Vob8TsYwFJXeF0rJF9JRw9zkSClmU78PUmfRYcPVMgpCJ0SHi1FksqpKjYOaK+b9VcTKIh0fuGKKEOBid+3paWNiQ8r0317cTbdZC8Wqdzivu3/dPewdvnfUxtdKR2SucZu3L3PU/G9Tz58EdnvVeR+9IFEtb+FA+v4UADD/BJQ//r0tEYpfXqHNG6Y6ld1hby0soZk6mXFI5cl81sTBKMQeTEgVej4MipLtDQFjAVL06kjWZDW9lxt91Uq7SRzJN+MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FLKDMbpOMhtmQ0Vz5mAPYcEqoxsCEqbZEf35qi5A4pc=;
 b=gqfMDhP65E2w7SfgYNBhX3FCRvKnq+V036p0T1v5ryKWCbmwa0JjestfN3xZOhIihVr4lwclNqIXztNDKzX/kDk56NlWumtNGFbBVw8V00w8IPqSS8hnCYJ/fzmcJKKBmT036NdGp8Sq1upvL8N/DHzwWfSp5uYN5KLCFSPqZuo=
Received: from MN2PR04MB5951.namprd04.prod.outlook.com (2603:10b6:208:3f::13)
 by MN2PR04MB5743.namprd04.prod.outlook.com (2603:10b6:208:38::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Tue, 29 Sep
 2020 19:53:13 +0000
Received: from MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::44d8:522e:db29:bb94]) by MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::44d8:522e:db29:bb94%6]) with mapi id 15.20.3412.029; Tue, 29 Sep 2020
 19:53:13 +0000
From: Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
To: Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>
Subject: RE: [PATCH v4 00/14] hw/block/nvme: Support Namespace Types and Zoned
 Namespace Command Set
Thread-Topic: [PATCH v4 00/14] hw/block/nvme: Support Namespace Types and
 Zoned Namespace Command Set
Thread-Index: AQHWkdZJY2r+3+EgB0+n1uDhiCCmB6l4SdmAgAEvKJCABCbNAIACED4ggABL7ICAAAv4gIAAAKQg
Date: Tue, 29 Sep 2020 19:53:13 +0000
Message-ID: <MN2PR04MB5951C92C070E2A0B96316E05E1320@MN2PR04MB5951.namprd04.prod.outlook.com>
References: <20200923182021.3724-1-dmitry.fomichev@wdc.com>
 <20200924210751.GD1738917@apples.localdomain>
 <MN2PR04MB59515B1EA1238861DFF3236AE1350@MN2PR04MB5951.namprd04.prod.outlook.com>
 <20200928063648.GA1967@apples.localdomain>
 <MN2PR04MB5951A1DAC6A607732A35B968E1320@MN2PR04MB5951.namprd04.prod.outlook.com>
 <20200929183911.GF286786@apples.localdomain>
 <20200929192201.GE477114@dhcp-10-100-145-180.wdl.wdc.com>
In-Reply-To: <20200929192201.GE477114@dhcp-10-100-145-180.wdl.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f3520375-9639-43a5-9d5d-08d864b14d00
x-ms-traffictypediagnostic: MN2PR04MB5743:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB5743F1426385334979C225BCE1320@MN2PR04MB5743.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XH7qy3WjX4jC0CZF+L0fXuGsJqZAJmQnXe3+1Gm4xgwxC6dc5QUqZkDSWdRoAuz0LoTK5vbuW3t0QxvLGcPTbxZOI5XARnhTs+J4lsMB/kvEDXip5BlcS1j0M+I8zVKdgwx6VO6QCKLI6snA4GVvh5m54fc6s4ILw80WzFzUibvQwGUhQIus4CSC2aI/Q0HzbfBnTj+giw0vafukSP9e9Bgu2gxHyMPfeXm0a46TU50um2z9qYuSNd7cAluUjC9pcDlix+G0TRnvLkom5FTojb1Su39Kufc3Qci2jmatU0F0jd5ECcJd6VdJUiOTDCSxUxUPXHzVVDW4CXb9Oa0xYIURM7ewUazb2pKTRAidPlg3Ta1Ll0Ne0YhUlr0iDpKw
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB5951.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39840400004)(396003)(346002)(136003)(376002)(110136005)(8676002)(316002)(4326008)(186003)(83380400001)(478600001)(33656002)(8936002)(7696005)(71200400001)(6506007)(66556008)(52536014)(76116006)(9686003)(66446008)(5660300002)(86362001)(55016002)(2906002)(66476007)(64756008)(54906003)(66946007)(26005)(53546011);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: AkCl7s5N27cS4rcoubqRD1lRvp3HLhCsddIkMzl3Idi7YP19NR0pXi3rLSzM2JSFVm/ZKpXO87jyXEZKJ3COHgwyqFODAhIurNtJLms+o3KuTAgqtC5bTtc817ozN4ziYmppbdeH08pFnAMD2+zuOIuBRkh4fYFt9dMJhD5SrLcUEFQPrmSkhhcJ/KvF5c+0edA3aYgsQuKw80afFtM3fdU3zy2STWrnRjjnvBSfNI+qrDUvxeUX/yt1q3RloQ/9aImA54TXkSOrHxEanjIGgMVf4qXMRKpZi6mVZa5FZ4qd/xjoFmxuDMtetfYhOpe14Mz+P0UHqOYAjg+TZymvJ1QdiJRsgdCe9bqzRl4EfLj2pVoZ8UAqp67ePL7PVCOsdhWufjMwa/aQ/9WqjRnd5R6IgvlPDMw/cOhxLt+AMWHbQLG0IbPGlw9qX0db0OSj4rpvwtYmzCoDrcNQoV2Pj2GSRbeIm85GB0aNK2SqP+c+Px99BvTk0zNuMx40zE0zrxDpUJpkdeGLPWSPy+0GKiEuYTHiJnl+5scSu41S3H/NP05WZP8y9bL3ydcPrGwAi+2U153WmA6VzgB8ljIIRi5+6TYy/ISKWJWYTPM8D0Hg0wIqtX/LbkgTgGqqJmlG3j5CkByvPSIBnydRur2ZVw==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB5951.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3520375-9639-43a5-9d5d-08d864b14d00
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2020 19:53:13.5490 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZW2DnGmQrNpFScUAGZCtFyI9RifSbqRev67NoRB326KS2ejxovWtLRAm0Wr0lZEylQQ1s0GI7HyubQALWxSiTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5743
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=534de8db0=Dmitry.Fomichev@wdc.com; helo=esa5.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 15:42:54
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Damien Le Moal <Damien.LeMoal@wdc.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Niklas Cassel <Niklas.Cassel@wdc.com>, Klaus Jensen <k.jensen@samsung.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>,
 Matias Bjorling <Matias.Bjorling@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> -----Original Message-----
> From: Keith Busch <kbusch@kernel.org>
> Sent: Tuesday, September 29, 2020 3:22 PM
> To: Klaus Jensen <its@irrelevant.dk>
> Cc: Dmitry Fomichev <Dmitry.Fomichev@wdc.com>; Kevin Wolf
> <kwolf@redhat.com>; Fam Zheng <fam@euphon.net>; Damien Le Moal
> <Damien.LeMoal@wdc.com>; qemu-block@nongnu.org; Niklas Cassel
> <Niklas.Cassel@wdc.com>; Klaus Jensen <k.jensen@samsung.com>; qemu-
> devel@nongnu.org; Alistair Francis <Alistair.Francis@wdc.com>; Philippe
> Mathieu-Daud=E9 <philmd@redhat.com>; Matias Bjorling
> <Matias.Bjorling@wdc.com>
> Subject: Re: [PATCH v4 00/14] hw/block/nvme: Support Namespace Types
> and Zoned Namespace Command Set
>=20
> All,
>=20
> Let's de-escalate this, please. There's no reason to doubt Klaus wants
> to see this to work well, just as everyone else does. We unfortunately
> have conflicting proposals posted, and everyone is passionate enough
> about their work, but please simmer down.
>=20
> As I mentioned earlier, I'd like to refocus on the basic implementation
> and save the persistent state discussion once the core is solid. After
> going through it all, I feel there's enough to discuss there to keep us
> busy for little while longer. Additional comments on the code will be
> coming from me later today.

OK, I agree with this and I will not be replying to the email prior to this
one it the thread. Let's calm down so we will be able to have a beer at a
conference one day :)

The only one thing that I would like to cover is lack of response to Klaus'
ZNS patchset. Klaus, you are right to complain about it. Since discovering
about the large backlog of NVMe patches that you had pending
(something that we were not aware at the time of publishing our patches),
we made the decision to rebase our series on top of the patches that you
had posted before the publication time of WDC ZNS patchset. Since then,
I got caught in the constant cycle of rebasing our patches on top of your
series and that prevented me from doing much in terms of reviewing of
your commits. Now, once we seem to catch up with the current head of
development, I should be able to do more of this. There is absolutely no
ill will involved :)

Dmitry

