Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD9AC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 02:02:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC077222C3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 02:02:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ll1nurFl";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ZCLfSVQp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC077222C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUKVf-0002VT-R7
	for qemu-devel@archiver.kernel.org; Sun, 18 Oct 2020 22:02:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53288)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=5541069a6=Dmitry.Fomichev@wdc.com>)
 id 1kUKUk-0001uH-1N; Sun, 18 Oct 2020 22:01:54 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:22487)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=5541069a6=Dmitry.Fomichev@wdc.com>)
 id 1kUKUg-0002ZM-Ie; Sun, 18 Oct 2020 22:01:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1603072910; x=1634608910;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=BO7VKWL4WjliHvBhUND4nddrYMVoeDA+/Y5eHhQGfyg=;
 b=ll1nurFl6hVf2oDs3efIWIxhPkLjd4+JeX/xNXgPjxTPp/c2I+buTDSI
 WNAIP0u+J6TeNS4KA3zilweFzVSPh7QWQTR1x3vWeCEokuE+xH6ZsL0ce
 Duxclr9dPEXGeEiRC8oD5EuBr5SYIkagV4XPo/LUUepde6LPoioRfN1yw
 eOdegq086tskZCL2sBzBWrsxs8oJwTUpWXuryH4Jc9PZkPb1pnDZmKOul
 rfI69oOeimkrXJVocnoh3EPnjtAK2/1AMAxnD3QYk1BPZUJPywgNY6Ueh
 7y0WeXKB3s58HzNm2VRvLjh3REUisUqUmHywrc2qKaQAj8lPow7g3p6YO g==;
IronPort-SDR: w3pLayJFSmFRU3LTU9cFnyMUUF5Xvv6vJAcSfknGVzBaPEk6Czu1ko0HbYbFmIP1f5wOjhLxsl
 HK8Ux9M6k5H1E6OoT1vXn/czDUMQ0Ic1tPrnR1TCS+7TOYVK5rZiPV1QZNr4vVw+qts7w1U0lV
 bWD6bEC6idJUdEEvSiStvDOXkIEGW1GMBePL8r2/gF5hL7dxWaiuzNmTjlq/ayEYkgLM2aegSv
 gP84GQzD8UCcw3Zrw6XGzj/7ftull0BlS4D/VhnHFxdCOpkAPc58HLP0bQ1s4bKyd8j2+Rb+uq
 F24=
X-IronPort-AV: E=Sophos;i="5.77,393,1596470400"; d="scan'208";a="260159948"
Received: from mail-dm6nam08lp2049.outbound.protection.outlook.com (HELO
 NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.49])
 by ob1.hgst.iphmx.com with ESMTP; 19 Oct 2020 10:01:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OtzA9JEvy8sGKhKlZ5AhbEWV/K4BGvTDKqsULD3Bmtl9W4aXPmSsNcapYPdZnBA0WA7+CHnDj9JHLgZPbITH6uBJ3kF/YFWkALkcgDt8xr8nThViqil8fbs5GAzFg8ykeHKGg8IPB5bB+lwgAdOykDTTfuBnBIVxs/6xUOiazbGZLHk/CTl35nsYl3kfLmrgfqNECyBljibTdU1bYJcEZ2Uu3+xOpk/rLslgpswUz8RGxgkqmVf73Os+GJYmK4pWacv6d7w6YAt4hi7xll8MJtyDuh8jOtAY4QELlYlqYtKmTEfqHEuos2sZa7vPZzQDwKH4apmGWw+hVoO+KTkt+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/bfAIpc0rHyUThMHOElbdzqLjrklTwRfUBmoTWLC8d0=;
 b=IEgAiqEVRGcDXMo8Ke71jz1uuP0pxDeq6UGr9r+fvww7k/+a9jGPLBQX/PQpHMcybxXlUvrDjcy3jjT7Yz9KyExppRzZ+BFU9aTVFTNgtqIpLp4+dff4PIA8tvya05BMfzLBP9Wqoc/xVez2W0QxHf1R7E+99Jqd6tMe/T3MOW5Wcwbp55ZGvsAaN/MMWSk9jenXvr0hNTfbSLz7/lS3jKHSB4vnvSJUpX/wGggoESik3s9KZ3LRVoCsb4GMuTm++5j0iBumP/HtSRFcpUSGQi53VmB6TGtsn/13NOhNkY+e3HSnUMbKmbq/6kwjDe6jdkdhnKv3Ncb6IaH6tIvssQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/bfAIpc0rHyUThMHOElbdzqLjrklTwRfUBmoTWLC8d0=;
 b=ZCLfSVQpBKfnwEssDHGBWzZDCe84vBpio4psqAAhxhwa2me1DPON1ReWScaYMjhK4WzdN/tmH7FA+K9Qf5JKuKefOZB3K8dF1/wzLRmWeoeRZO7ewO3+Rk9qBHBoSvRque+vDUbMSkrFeMgv+3fv6Uwc5C/4ClpFKSBnvl73GdU=
Received: from MN2PR04MB5951.namprd04.prod.outlook.com (2603:10b6:208:3f::13)
 by MN2PR04MB5919.namprd04.prod.outlook.com (2603:10b6:208:a2::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.27; Mon, 19 Oct
 2020 02:01:41 +0000
Received: from MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::44c9:85df:4910:44d8]) by MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::44c9:85df:4910:44d8%4]) with mapi id 15.20.3477.028; Mon, 19 Oct 2020
 02:01:41 +0000
From: Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
To: Keith Busch <kbusch@kernel.org>
Subject: RE: [PATCH v6 01/11] hw/block/nvme: Add Commands Supported and
 Effects log
Thread-Topic: [PATCH v6 01/11] hw/block/nvme: Add Commands Supported and
 Effects log
Thread-Index: AQHWoam+uzZ+AZLyZkKR7VjGxDv1BamWRLgAgAfP+JA=
Date: Mon, 19 Oct 2020 02:01:41 +0000
Message-ID: <MN2PR04MB5951305CFC9F506122013E06E11E0@MN2PR04MB5951.namprd04.prod.outlook.com>
References: <20201013214212.2152-1-dmitry.fomichev@wdc.com>
 <20201013214212.2152-2-dmitry.fomichev@wdc.com>
 <20201014005034.GA1264232@dhcp-10-100-145-180.wdl.wdc.com>
In-Reply-To: <20201014005034.GA1264232@dhcp-10-100-145-180.wdl.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7a79f308-16cc-4734-8d01-08d873d2ec5f
x-ms-traffictypediagnostic: MN2PR04MB5919:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB591978619AF4F6A90CAF817CE11E0@MN2PR04MB5919.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:510;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XXbny5bPGeLBt45mcj0bClGBK+mWr6ctLaU6SelleIzs03b4iO99JXISBxbmwBCbgbFJ+tyO5MA9PBcYOxdRXhqie+NExFsqlhooUn5rc0JSlMlEKnQ3OCOL0rBkq3eUJxFdXSdfvQCBJHwFQjz9V3s3Hi8kGhvWZDLvMxcuVrpv1k9dZOF9FOFYG6icm210OWaC8gQk9oeKdX3iRCbTMv9nCQUEcLOpqhJ+Tub8gMVqC5EzxTiSeng0uGbUpAXwiMhwjQYavMpcLpbRwoa3/fkfoI6h+F4gATGk4iwv/hcM5eAB0F4zFwXSmPIfOzEHMLolV31F0Nm3QLZejXeHjw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB5951.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(366004)(396003)(376002)(346002)(76116006)(66476007)(66446008)(66946007)(64756008)(66556008)(26005)(4326008)(186003)(7696005)(6506007)(53546011)(8676002)(8936002)(52536014)(9686003)(5660300002)(55016002)(54906003)(6916009)(71200400001)(33656002)(478600001)(86362001)(2906002)(83380400001)(316002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: RzF/mIgBnXns+h5W/3B2dlXsPolm3csQuMtOCpgdsp1oRq3miyGl3+IGmTMcLjX22Bo/IsZoqLpzdeCYguQKrsXketiIzbkpesnj3UMqnnVCXnx5+MEawFaFvk7zuA424hanb30dVXrPeIZaG3hg+Wb4tfhWE51IQ0dbrnyi7tFyHNOR7BdnO7+VPGCaCgMLnXZMF7jFoUJAyJLq6OELEMooP/H61bPaL3mygy3G5wf4Poh/IN5bnXraHZObElsT2cPPOjbu917RSnoVWX5+yX3k2SOBWcvfsdt4lRvk+OH1pgutMyQyXo800CuePNDQ+dMhS79XycvN7blc0b9VRA2F8WUlY5ZZzOVIEBFr7mnJclCUxaaG6WoWvgOFETzj0x9dJZFkPIPS7EpAh06D2pTLFaA+2DpWspM51FMFKGP3n4feFVSVm20xuCf2ulEufhycNBGnV7kTMrcb8icute+eK2/WeUQQthtgJzjhdriqI+O6iWigHI6+PcXnUye7/wM/Vpfkmhju2pKc0JTxeq9WAMuXNca/kjJPhrbUFHWFUINi5HXeN2SbE81AE+PDF35kHm7MAFR6sX+Y6s97B++I73clbFK3LBDzDRjzIJgSMgA0g3VE5q3y/cLeZ3tLhzap3fgjyqJJ1TNdcdsk7Q==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB5951.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a79f308-16cc-4734-8d01-08d873d2ec5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2020 02:01:41.6817 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bxPqMC3m3j+71uZPvffEv5HZzBE+D7D0gCCgNIzOKpUQVupufksvmEXG9w8wiYr8Yo6RWC4bVuKTxTSMXwOw2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5919
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=5541069a6=Dmitry.Fomichev@wdc.com; helo=esa1.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/18 22:01:45
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
 Maxim Levitsky <mlevitsk@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>,
 Matias Bjorling <Matias.Bjorling@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> -----Original Message-----
> From: Keith Busch <kbusch@kernel.org>
> Sent: Tuesday, October 13, 2020 8:51 PM
> To: Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
> Cc: Klaus Jensen <k.jensen@samsung.com>; Kevin Wolf
> <kwolf@redhat.com>; Philippe Mathieu-Daud=E9 <philmd@redhat.com>;
> Maxim Levitsky <mlevitsk@redhat.com>; Fam Zheng <fam@euphon.net>;
> Alistair Francis <Alistair.Francis@wdc.com>; Matias Bjorling
> <Matias.Bjorling@wdc.com>; Niklas Cassel <Niklas.Cassel@wdc.com>;
> Damien Le Moal <Damien.LeMoal@wdc.com>; qemu-block@nongnu.org;
> qemu-devel@nongnu.org
> Subject: Re: [PATCH v6 01/11] hw/block/nvme: Add Commands Supported
> and Effects log
>=20
> On Wed, Oct 14, 2020 at 06:42:02AM +0900, Dmitry Fomichev wrote:
> > +{
> > +    NvmeEffectsLog log =3D {};
> > +    uint32_t *dst_acs =3D log.acs, *dst_iocs =3D log.iocs;
> > +    uint32_t trans_len;
> > +    int i;
> > +
> > +    trace_pci_nvme_cmd_supp_and_effects_log_read();
> > +
> > +    if (off >=3D sizeof(log)) {
> > +        trace_pci_nvme_err_invalid_effects_log_offset(off);
> > +        return NVME_INVALID_FIELD | NVME_DNR;
> > +    }
> > +
> > +    for (i =3D 0; i < 256; i++) {
> > +        dst_acs[i] =3D nvme_cse_acs[i];
> > +    }
> > +
> > +    for (i =3D 0; i < 256; i++) {
> > +        dst_iocs[i] =3D nvme_cse_iocs_nvm[i];
> > +    }
>=20
> You're just copying the array, so let's do it like this:
>=20
>     memcpy(log.acs, nvme_cse_acs, sizeof(nvme_cse_acs));
>     memcpy(log.iocs, nvme_cse_iocs_nvm, sizeof(nvme_cse_iocs_nvm));
>=20

Sure, this is a lot cleaner.

> I think you also need to check
>=20
>     if (NVME_CC_CSS(n->bar.cc) !=3D NVME_CC_CSS_ADMIN_ONLY)
>=20
> before copying iocs.

Yes, thanks.


