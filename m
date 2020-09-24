Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F8AAC4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 19:50:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D5DE2220C
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 19:49:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="RWSu/Oj6";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="O/Uz8djy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D5DE2220C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLXFe-0000pP-It
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 15:49:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53274)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=5292f8049=Niklas.Cassel@wdc.com>)
 id 1kLX6u-0002qj-8y; Thu, 24 Sep 2020 15:40:56 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:63307)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=5292f8049=Niklas.Cassel@wdc.com>)
 id 1kLX6r-0008FR-6q; Thu, 24 Sep 2020 15:40:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1600976452; x=1632512452;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=yu6+K1g4UCu4UgY/5t30k77OIt92S2qS7CrJ1kVNJxA=;
 b=RWSu/Oj6Fgm6Puzua4eSHEMsoUETVP6rMtEcVmyldsYePwTw1NCVjt65
 h6/w9W+t2G70IJWo1T8HqwlOoK0ZZhGxuzNaaHHj+OSoSnxcdgG6lc7rt
 bIVWroBSOnSsYO1chD+pByo8MuVnuISqNvnqyVx78n6ebXSVgwYJK0KTT
 1MtBIHvAJ9eJCU0q7slR0vBPpUQIOJwiWbjjjtVrTr6z3TgCzjxJx29VC
 KmR6bCP+w6umYoC4A1IcsXWPehfO59XAOlnBph7rH1FwqDxH8Ikk6BBzl
 NA0fXeUDv+6otaXjnIPfXRFDWMKDmXaCYG5N8tbqWkp1/6OULt3G4Yozo Q==;
IronPort-SDR: /DCRFr14j5T9Zfb+ZDaAMVlzWZHalcgY9vmcLI7vBppc7JJ6jVWD9rVTUN1W71B8rdREyJwf9S
 t+e6kbRRFT3tLJs1xEx8Pk4PpbW7meyXoYBxCQFUlUtoelliJv893UQEIeYIIzBZl916ROTBEk
 oWoq+4kpOvvtdQDTa6TGJ0Vo1/0iS+0V5H99hGIbHLjV+5J04Z2NWAVqFozjf4Jdf7bDGQ8fa1
 1BSnRhdjv0y2sIdJFtufBjaEXHCho7+or0A8kUnxl7dhZXgqpNI9/+fq9piXUoQqviJmau7si9
 EeI=
X-IronPort-AV: E=Sophos;i="5.77,299,1596470400"; d="scan'208";a="257921598"
Received: from mail-cys01nam02lp2050.outbound.protection.outlook.com (HELO
 NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.50])
 by ob1.hgst.iphmx.com with ESMTP; 25 Sep 2020 03:40:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ec5B27zqzGK8BTyuI6diewNiH5E4ayqrwJm5ha12aFBkcYbkFHrtn3Mw4VSIT3eM1JhDxIOOMBHCKBpYzC5+tmkTvwvycJlioO2kbh1+DLWEIXTBUPsB3kW1ksANBSUU3n9ydeAgE5g66QBBZoMy/8K0PT/k1h/pKIsbHDAkaJorqxCM4Kqp+J0OK5AIW7C8+s0QL9BBUD8GYRWBkW5/W8MindyehYtP3cCreqd8lBZ0oRwpyS9TaDnTDpk4+Vmhun/o4oJ7Y25dyYecXsV+Ksw/uMcdxUMFNJngeMJcBcDdRcTDpmx0djT9ywvzB+Vhe2Y+jDWliA2USrxXpvTp3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yu6+K1g4UCu4UgY/5t30k77OIt92S2qS7CrJ1kVNJxA=;
 b=CUVE9IFNbK8sCHx1NqumvAVVDJLBwWJ34ec7+nLqWwTE4qfz5N6LOS3iLHbNzABrU0l1E1LqWhPhvxOxz+whvy5/TGGXwSdlo5CkHKd48B2KoBc/qFU3ao6jHtXHDQTaSBrV7unG3rVV03LPrLc/XKL/wdXGQ34uJWUYr0Y7ePNBp2htiDgDQa2wfIWJH1sArahg4X7mCuCImWGvAjVSgVAI0x67Nw6I0/1zfFdN6BssogbgnczRwwPV16mO6SHwGxU2ukzvkrbWd3QwnKPSadyC8UhxFOlIC+buZ86zUA12QazJtk8gKjfum8kwZJoNg6FZXu7HlLSB2muDTKi9Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yu6+K1g4UCu4UgY/5t30k77OIt92S2qS7CrJ1kVNJxA=;
 b=O/Uz8djyZWeh8qQChRdQ36rpIMy8peYoQETuX7kN5DzitJO2rRkZu6wqjVPRvWD8U9qnJmzH6PAE/RMIT9ZS8/YKVfXxE7/0W0rirEWG0XD4KokJGz/YbiIrw7dnh25cXaZdbBp+TCBPpxVcIyszqSSVULGOj1DRLLT31swFHBY=
Received: from BN6PR04MB0724.namprd04.prod.outlook.com (2603:10b6:404:ce::23)
 by BN7PR04MB3970.namprd04.prod.outlook.com (2603:10b6:406:c2::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Thu, 24 Sep
 2020 19:40:48 +0000
Received: from BN6PR04MB0724.namprd04.prod.outlook.com
 ([fe80::acb1:47a4:73ba:69a7]) by BN6PR04MB0724.namprd04.prod.outlook.com
 ([fe80::acb1:47a4:73ba:69a7%9]) with mapi id 15.20.3412.020; Thu, 24 Sep 2020
 19:40:48 +0000
From: Niklas Cassel <Niklas.Cassel@wdc.com>
To: Klaus Jensen <its@irrelevant.dk>
Subject: Re: [PATCH v4 06/14] hw/block/nvme: Add support for active/inactive
 namespaces
Thread-Topic: [PATCH v4 06/14] hw/block/nvme: Add support for active/inactive
 namespaces
Thread-Index: AQHWkdZQA+v6X0FIe0SRVZTk+KHqRKl3tCaAgABmEICAAAqiAIAADK0A
Date: Thu, 24 Sep 2020 19:40:48 +0000
Message-ID: <20200924194046.GA26391@localhost.localdomain>
References: <20200923182021.3724-1-dmitry.fomichev@wdc.com>
 <20200923182021.3724-7-dmitry.fomichev@wdc.com>
 <20200924121203.GA1738917@apples.localdomain>
 <20200924181721.GA5376@localhost.localdomain>
 <20200924185524.GC1738917@apples.localdomain>
In-Reply-To: <20200924185524.GC1738917@apples.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: irrelevant.dk; dkim=none (message not signed)
 header.d=none;irrelevant.dk; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [85.226.244.4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fe01f1c0-fad8-446f-04f5-08d860c1bc9c
x-ms-traffictypediagnostic: BN7PR04MB3970:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN7PR04MB39707B3C94D73058934D88DAF2390@BN7PR04MB3970.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2RnUFaduhamMgorB6S3P8mdVgJbD/IXfcpw3LmoKYndiGvc7Cs3OUZaUlvWtiFrmBytMQDs+FMGYPnex1xPKydOCX8svK2s/6Sz+diunBwGCav7hZE8qWAIUcor6Ms7WbUuTSSOXc4SokceZgOhfpYM7jOlszmuSPLo8zZE/+jmSAvoFJG9sCNgGKjxoxLm6DnfIP9W7ri/GCfG5WF0FFRghpUo/AyqezCVcSmPSYh2IxAxMPZ4oX9ibCIZ6cny5714d2sJfDFnZnHBWcgAbCnusJGKnUP6j18wOEqtE+69BaF7TBk+D8NfGUuVMkCQWEyjZxjZcrTmxkbrHLXSbdqLCE1Tkl81aLTDdQNtP8/Z0mWHaGmM7cDGSdoRRzt04
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR04MB0724.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(376002)(346002)(366004)(136003)(66946007)(186003)(1076003)(83380400001)(4326008)(66556008)(26005)(6486002)(71200400001)(66476007)(86362001)(8676002)(33656002)(478600001)(54906003)(2906002)(6916009)(66446008)(64756008)(9686003)(8936002)(5660300002)(91956017)(76116006)(6506007)(316002)(6512007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 9XU61RcBsqRuhRt+z6ldJ1ayzAI+XAVU3DRSEWzvjpP2MBqgWc+gjqsllrx/Jp4RVXT5jrf5K/J8r6NB5h4zEdHMEMx+IrXOw2tIR403jD6yb6mYpcONUCm7ys7SI8xFW0fUIAAppEQ186Th1x+t+y0r9w/cGjG0BclhPf3We2nZSlOIBhzG7dvWgevxRPneZDHQG4shlXG7FdJZwp6W9DuT6niU3RIHLxUM2JI5O1D2ZllQMDFRLG9PZjFJtKChCC6S1Ne577VoizQDmNEJGOhpSanPDoEkoeZyljOa+v7q+NSuF41DpUGfsurvKKNKtk8gEwouIxg9uoBbIqaJhBE5kaot7V+q+mbmNd17jOMvGig1Q8Bhf2Cf8fQK1uEBwwiK4XTw79h+o0vqXLmKy+vV58vE3EkiaLnttYuwHnCiAyZppjBf5JX06149gUYy0Nqt56NoaQnfsxw/U6uDgtFHn3VscH/0ABI0E1hIOpXPIn51nyK/FUOv8sgMtSykfsTzDjZDoMg6Uq1702vZAkgiGpyAp5UFECcMPsAaLE4ezEpQZP66I8fiivwN/8ARDtbMqwdqzWex+H9VrmKnlCobqmUNqaPjitU2MJdoalz8BTI5ghW7HjQTdFlcUlKn67VLJpXZcKFFiMISIkqBbQ==
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <9B1957B0D852664B86F272960DDA537B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR04MB0724.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe01f1c0-fad8-446f-04f5-08d860c1bc9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2020 19:40:48.1081 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fXcmGM/YnKaABQENuX4H8RAqeFM3E4tYn2C3PO2bdbmb+Lca7x3TtX/qOgVV9ZAz34bI9MDv093shpk3FppWhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR04MB3970
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=5292f8049=Niklas.Cassel@wdc.com; helo=esa1.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 15:40:50
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
 Klaus Jensen <k.jensen@samsung.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>, Keith Busch <kbusch@kernel.org>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>,
 Matias Bjorling <Matias.Bjorling@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 24, 2020 at 08:55:24PM +0200, Klaus Jensen wrote:
> On Sep 24 18:17, Niklas Cassel wrote:
> > On Thu, Sep 24, 2020 at 02:12:03PM +0200, Klaus Jensen wrote:
> > > On Sep 24 03:20, Dmitry Fomichev wrote:
> > > > From: Niklas Cassel <niklas.cassel@wdc.com>
> > > >=20
> > > > E.g., if the user sets CC.CSS to Admin Only, NVM namespaces should =
be
> > > > marked as inactive.
> > > >=20
> > >=20
> > > Hmm. I'm not convinced that this is correct. Can you reference the sp=
ec?
> > >=20
> >=20
> > CC.CSS can only be changed when the controller is disabled.
>=20
> Right. I think I see you point. While the controller is disabled, the
> host obviously cannot even see what namespaces are available, so the
> controller is free to only expose (aka, attach) the namespaces that
> makes sense for the value of CC.CSS.
>=20
> OK then, the patch is good :)

That was my thought, that the controller internally would
detach unsupported namespaces (even if the controller didn't
expose namespace management capabilities to the user).

This was how I assumed that things worked, but if we should
follow the spec strictly, we should do like you suggested
and keep them attached, and return the proper error code,
on non-admin commands.

Thank you for improving my understanding.
Considering that CC.CSS can only be changed when the controller
is disabled, I still kind of wished that the spec said that
unsupported namespaces would be automatically detached.


Kind regards,
Niklas=

