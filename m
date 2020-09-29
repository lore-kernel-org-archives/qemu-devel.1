Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 000DAC4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 14:11:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07A12206C1
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 14:11:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="dvTmGLXK";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ZStsSkqi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07A12206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNGLL-00087d-JE
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 10:10:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59754)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=534d22b8c=Damien.LeMoal@wdc.com>)
 id 1kNDa7-0000nv-HN; Tue, 29 Sep 2020 07:14:03 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:64456)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=534d22b8c=Damien.LeMoal@wdc.com>)
 id 1kNDa4-0004K0-EV; Tue, 29 Sep 2020 07:14:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1601378040; x=1632914040;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=JsDn3JRJrQAOmklgzB8kpMt7IIGnVETskF8fm314smA=;
 b=dvTmGLXKNjp5GAlZAOZro45FZPDF1fCQma2COZf7ziHSGgY1r8ZkS+va
 g7c8fPKWsuEKPm+BQjV6uzoAttvYyUqaIpn1BFl/sH9+IExhCwx4mGGoM
 dKVZQRoQTpsgLpOMemeRjndO+IAJG57QP6U8Duss3HVjyOvrZDM+DyUeG
 cZr0E+kWW6recxgE/V/s/pVU1MN+ok02jyCOUPBjXe2UthR3JQO5hwm2r
 sTjCmWbHw5DpotDxypSrQXaCsLaqcHm5rqW2M/OUN/BUQXx2F5YweWW17
 NTVdf5FHiw789KJiUR86nSS3tj6fETwe3Ljjx+ygEyUUXYAv8T4LwEXTb A==;
IronPort-SDR: W4joGJLI7F7tGupj+b6c6Scw7032dk3E4CiFympcIpVGqZhYkYqqCV4W1L0ZPwzm2ZIEi1s3ML
 3G+8UGcnpLfQnSItIJbaXWj/tsC2j45ijVDIscUm2jYtBP28KrjgtHsnksfIt9lqUBkhUKzEK1
 PulHaOjTe1rZsnVRsGwKY5FVk0hMJyHaJQasiHGbT1nEj220LvnyZYBYTwwAVuLbCkGcYiIiW/
 s8/MhCJRSusi6TlP8U+FL0nnTf6SqM9ABvnCveyq3thXZFLr0cgUJADDr79WfUB/x+XHl711tX
 u4s=
X-IronPort-AV: E=Sophos;i="5.77,318,1596470400"; d="scan'208";a="258277006"
Received: from mail-bn7nam10lp2101.outbound.protection.outlook.com (HELO
 NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.101])
 by ob1.hgst.iphmx.com with ESMTP; 29 Sep 2020 19:13:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QTbf97d/bw2BAuDi03dn+NaHDI7xA08JGsJf0XScFOFe9iOIz+65uD/ZTvOOC1VFemcvEknjbFZfNupzHJuMKG9MGAhApT6+s0DjMLLO79OG5ycoRbd6u/lZnoOr1fEmwFWKJFKsMqQyqdanAqDFmwPxazw4OD5SnPjmELRPejo6LMf/yf6qZLXwN3FAEGGq1bl/8I7bM04XhCgIkxQwPnA4jWaeYnylfnK9QueljMcpUgUquaHYYZ+Gnuzre/7XlhZmdUbuKvDMrzccpC5VcXAjZckaFbPnf9bMM6ydmra2p5ZUqla9PtMqhxMIK3FbmgaksD64+CrRbGfEAVJlNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QYIZvWZ5vGmveVEMA79QkaUAJPHC3qzOCvXEZsx7IQM=;
 b=M603PsnuhJ90qlwUBsD3kjsm9FCddstL+I4Qvn4zM1/OVviqDupKphKLmhT99MRwbgFWqfvfENfaQymV4gu7x1XAjHpyVs3gAeWOXFdpzReTCnT9w0CQhZb3Ig8UEjP+39qDA+0KbT+nI91uLREkZxHG6Snh4k0nHXZ0WRwLzYzecnnLrU9lubY5EQIUxq5q7CvZHNZ/9L+niTURMKLFOoPF1MNt6aAWOy4UNN4QmokPWz43AgWJSAvebrkDALYkAeBM7ITibtInqWWxhvHtII090WNvgb75lyyTBAYskNBgn5BwLcEnFbGJSJeM737JpBiwffp8TROZgpntgzfyfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QYIZvWZ5vGmveVEMA79QkaUAJPHC3qzOCvXEZsx7IQM=;
 b=ZStsSkqiKsre0c1IOsStUHqKFDmpalnDc0F9d7gNxHavGCCZ7LgrOuVdJM9Wh0v3LczKILq7VLO2DLHAO1OKl0z1aZyb9RgGOjN77U2+WlomTTu5sfNBFM2IfRvgBZ+TQiNURsf0lZrpv0Wsqy5wyVx56nIuJL/ArCISx5obWPo=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB0726.namprd04.prod.outlook.com (2603:10b6:903:e3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.25; Tue, 29 Sep
 2020 11:13:52 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7%12]) with mapi id 15.20.3412.029; Tue, 29 Sep 2020
 11:13:51 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Klaus Jensen <its@irrelevant.dk>
Subject: Re: [PATCH v4 00/14] hw/block/nvme: Support Namespace Types and Zoned
 Namespace Command Set
Thread-Topic: [PATCH v4 00/14] hw/block/nvme: Support Namespace Types and
 Zoned Namespace Command Set
Thread-Index: AQHWkdZJ45Zpdtg6HEGtgy8M47fl9g==
Date: Tue, 29 Sep 2020 11:13:51 +0000
Message-ID: <CY4PR04MB37513C512B186B8AB521C690E7320@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200923182021.3724-1-dmitry.fomichev@wdc.com>
 <20200924210751.GD1738917@apples.localdomain>
 <MN2PR04MB59515B1EA1238861DFF3236AE1350@MN2PR04MB5951.namprd04.prod.outlook.com>
 <20200928063648.GA1967@apples.localdomain>
 <20200928212541.GC227320@dhcp-10-100-145-180.wdl.wdc.com>
 <CY4PR04MB3751997C2ED1D5EFB69E32ACE7350@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200929104633.GA179147@apples.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: irrelevant.dk; dkim=none (message not signed)
 header.d=none;irrelevant.dk; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:6569:68aa:23ff:5875]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 524cb31e-b8b8-4747-71f6-08d86468becd
x-ms-traffictypediagnostic: CY4PR04MB0726:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR04MB0726A9BC8EBB0B73A4DDB805E7320@CY4PR04MB0726.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ic4RohZRwSFEbzRxFsUFDdimKgamgPAFTC559tBFdNrXwpwL0EFznmz7BAMe5MhHUVT0/uOWu3tsl76VXG2eY4eiXmZ2m6NK725fzjN49FVIhohhxo/5y3m/5zGGRjmISqnoQEgDrmxiuX66cMR1AM8WeSo3BHtldjAywpg/nYWBEuW7twWYpQ21nuuEPGvSO+Iqmw08NZFCYGMhttEjT/usIG5V/ViG/rkZwn7RRp3u1v/f4+6HYKouCCRESYWn6Yu5dYPObXOCpSbQCjtgifOlFZT3zejAV7SfwUWoV8YttoIhV0TtvX64BdQq5XSrDXZBiVIUmWFNbr/geUPzZ+y5Qo/ctO8EpXSiio7pg47v+t8923+bRHCqCLd/YOr7
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR04MB3751.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(136003)(366004)(376002)(396003)(8936002)(4326008)(83380400001)(8676002)(6916009)(55016002)(9686003)(7696005)(53546011)(6506007)(186003)(316002)(478600001)(54906003)(33656002)(71200400001)(66556008)(64756008)(91956017)(86362001)(5660300002)(66476007)(66446008)(52536014)(66946007)(76116006)(2906002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 6fJLG75vv5n2BIzmhMCoksvLZxo10b8v8t3HRBLZXJCteuCBUFkRJUR9eWLek5r4G1e7jFokM+bgucfnsez2Bf1qF5UBgseb5TJClr/KXCzhTWaTg/NiI0jBYYHEyY7YWHndWzCIFDI05FSf5PnO9WsdNfZIsGkDMI9PTG5Ee9/Eom/OxdP7igLdNlDQOuyVAWTdV52QyF3lHo1rRoDPUa/wplLh9LBP1T6XabavaQC7OL06Uutike/c4mmimT0AMxALKekkpKRjdPAbuOZahdsajaQu4CUAioKCsmlGz797dwjOToMicqySPN+EwfNFX1y+BxfQbZHMlCoifVL9+dqaqseTCCJXqxChJIrORCPRSg8nNWNreG9sV/PZQxUJbCqiNnId5y+yS/JWQg7+blxtCSh2F/MmVc9KuILQskPPe4ID/0KwKL0SKt9d9EUAefZRhEbMTZZ6D74H3TXkZsDu0fcIPGd11ymh+yYDijf5Au2FJ/KY5AXzzOZ2PmHjJaUB4xqwSKg17LI7UgsXhAmgwetgnwXln5zOIE++Jgej4zlzMv5ZfP4WnhuD29w7QimJcTkAlhwUYDmp3OJEowUQg21Ps9EWIqTzWwvP1mSpEFWi0mZqeq2d84FD+sH4ibxyALLXN5hUtWc5HA9Bqx/9S1spDCrLH+E8DtiCmWZxDOc46r7TRfcdJAnNKiZWkFHXP0pcTyVhhc3GfhrHwQ==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 524cb31e-b8b8-4747-71f6-08d86468becd
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2020 11:13:51.1877 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iUzy+mqi5GIH4/sQlu36+n6pcYbkxm3mtx4ELR60Oh3Oli9oJ9Z7YF54Frni/DTrmjrhr1JukUjHByGsiObt8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0726
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=534d22b8c=Damien.LeMoal@wdc.com; helo=esa1.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 07:13:56
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 29 Sep 2020 10:08:35 -0400
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Niklas Cassel <Niklas.Cassel@wdc.com>, Klaus Jensen <k.jensen@samsung.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>, Keith Busch <kbusch@kernel.org>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>,
 Matias Bjorling <Matias.Bjorling@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2020/09/29 19:46, Klaus Jensen wrote:=0A=
> On Sep 28 22:54, Damien Le Moal wrote:=0A=
>> On 2020/09/29 6:25, Keith Busch wrote:=0A=
>>> On Mon, Sep 28, 2020 at 08:36:48AM +0200, Klaus Jensen wrote:=0A=
>>>> On Sep 28 02:33, Dmitry Fomichev wrote:=0A=
>>>>> You are making it sound like the entire WDC series relies on this app=
roach.=0A=
>>>>> Actually, the persistency is introduced in the second to last patch i=
n the=0A=
>>>>> series and it only adds a couple of lines of code in the i/o path to =
mark=0A=
>>>>> zones dirty. This is possible because of using mmap() and I find the =
way=0A=
>>>>> it is done to be quite elegant, not ugly :)=0A=
>>>>>=0A=
>>>>=0A=
>>>> No, I understand that your implementation works fine without=0A=
>>>> persistance, but persistance is key. That is why my series adds it in=
=0A=
>>>> the first patch. Without persistence it is just a toy. And the QEMU=0A=
>>>> device is not just an "NVMe-version" of null_blk.=0A=
>>>=0A=
>>> I really think we should be a bit more cautious of commiting to an=0A=
>>> on-disk format for the persistent state. Both this and Klaus' persisten=
t=0A=
>>> state feels a bit ad-hoc, and with all the other knobs provided, it=0A=
>>> looks too easy to have out-of-sync states, or just not being able to=0A=
>>> boot at all if a qemu versions have different on-disk formats.=0A=
>>>=0A=
>>> Is anyone really considering zone emulation for production level stuff=
=0A=
>>> anyway? I can't imagine a real scenario where you'd want put yourself=
=0A=
>>> through that: you are just giving yourself all the downsides of a zoned=
=0A=
>>> block device and none of the benefits. AFAIK, this is provided as a=0A=
>>> development vehicle, closer to a "toy".=0A=
>>>=0A=
>>> I think we should consider trimming this down to a more minimal set tha=
t=0A=
>>> we *do* agree on and commit for inclusion ASAP. We can iterate all the=
=0A=
>>> bells & whistles and flush out the meta data's data marshalling scheme=
=0A=
>>> for persistence later.=0A=
>>=0A=
>> +1 on this. Removing the persistence also removes the debate on endianes=
s. With=0A=
>> that out of the way, it should be straightforward to get agreement on a =
series=0A=
>> that can be merged quickly to get developers started with testing ZNS so=
ftware=0A=
>> with QEMU. That is the most important goal here. 5.9 is around the corne=
r, we=0A=
>> need something for people to get started with ZNS quickly.=0A=
>>=0A=
> =0A=
> Wait. What. No. Stop!=0A=
> =0A=
> It is unmistakably clear that you are invalidating my arguments about=0A=
> portability and endianness issues by suggesting that we just remove=0A=
> persistent state and deal with it later, but persistence is the killer=0A=
> feature that sets the QEMU emulated device apart from other emulation=0A=
> options. It is not about using emulation in production (because yeah,=0A=
> why would you?), but persistence is what makes it possible to develop=0A=
> and test "zoned FTLs" or something that requires recovery at power up.=0A=
> This is what allows testing of how your host software deals with opened=
=0A=
> zones being transitioned to FULL on power up and the persistent tracking=
=0A=
> of LBA allocation (in my series) can be used to properly test error=0A=
> recovery if you lost state in the app.=0A=
=0A=
I am not invalidating anything. I am in violent agreement with you about th=
e=0A=
usefulness of persistence. My point was that I agree with Keith: let's firs=
t get=0A=
the base emulation in and improve on top of it. And the base emulation does=
 not=0A=
need to include persistence and endianess of the saved zone meta for now. T=
he=0A=
result of this would still be super useful to have in stable.=0A=
=0A=
Then let's add persistence and others bells and whistles on top (see below)=
.=0A=
=0A=
> Please, work with me on this instead of just removing such an essential=
=0A=
> feature. Since persistence seems to be the only thing we are really=0A=
> discussing, we should have plenty of time until the soft-freeze to come=
=0A=
> up with a proper solution on that.=0A=
> =0A=
> I agree that my version had a format that was pretty ad-hoc and that=0A=
> won't fly - it needs magic and version capabilities like in Dmitry's=0A=
> series, which incidentially looks a lot like what we did in the=0A=
> OpenChannel implementation, so I agree with the strategy.=0A=
> =0A=
> ZNS-wise, the only thing my implementation stores is the zone=0A=
> descriptors (in spec-native little-endian format) and the zone=0A=
> descriptor extensions. So there are no endian issues with those. The=0A=
> allocation tracking bitmap is always stored in little endian, but=0A=
> converted to big-endian if running on a big-endian host.=0A=
> =0A=
> Let me just conjure something up.=0A=
> =0A=
>     #define NVME_PSTATE_MAGIC ...=0A=
>     #define NVME_PSTATE_V1    1=0A=
> =0A=
>     typedef struct NvmePstateHeader {=0A=
>         uint32_t magic;=0A=
>         uint32_t version;=0A=
> =0A=
>         uint64_t blk_len;=0A=
> =0A=
>         uint8_t  lbads;=0A=
>         uint8_t  iocs;=0A=
> =0A=
>         uint8_t  rsvd18[3054];=0A=
> =0A=
>         struct {=0A=
>             uint64_t zsze;=0A=
>             uint8_t  zdes;=0A=
>         } QEMU_PACKED zns;=0A=
> =0A=
>         uint8_t  rsvd3089[1007];=0A=
>     } QEMU_PACKED NvmePstateHeader;=0A=
> =0A=
> With such a header we have all we need. We can bail out if any=0A=
> parameters do not match and similar to nvme data structures it contains=
=0A=
> reserved areas for future use. I'll be posting a v2 with this. If this=0A=
> still feels too ad-hoc, we can be inspired by QCOW2 and the "extension"=
=0A=
> feature.=0A=
> =0A=
> I can agree that we drop other optional features like zone excursions=0A=
> and the reset/finish recommended limit simulation, but PLEASE DO NOT=0A=
> remove persistence and upstream a half-baked version when we are so=0A=
> close and have time to get it right.=0A=
=0A=
OK. Then let's move the persistence implementation as the last patch in the=
=0A=
series. This way, if it is still controversial, it will not block the rest.=
=0A=
=0A=
Here is what I propose:=0A=
Dmitry: remove persistence stuff from your patches, address comments and re=
send.=0A=
Klaus: Rebase your persistence patch(es) with reworked format on top of Dmi=
try=0A=
series and send.=0A=
=0A=
That creates a pipeline for reviews and persistence is not a blocker. And I=
=0A=
agree that other ZNS feature can come after we get all of that done first.=
=0A=
=0A=
Thoughts ? Keith ? Would that work for you ?=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=

