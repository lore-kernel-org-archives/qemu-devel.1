Return-Path: <SRS0=8V6M=V6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E17C32750
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 18:41:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 397F8205F4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 18:41:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="PXy1fP6M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 397F8205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htcUV-0006IR-BD
	for qemu-devel@archiver.kernel.org; Fri, 02 Aug 2019 14:41:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34276)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aaron@os.amperecomputing.com>) id 1htcFT-0007Cv-UI
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 14:25:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aaron@os.amperecomputing.com>) id 1htcFR-000320-Qi
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 14:25:51 -0400
Received: from mail-eopbgr740107.outbound.protection.outlook.com
 ([40.107.74.107]:54400 helo=NAM01-BN3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aaron@os.amperecomputing.com>)
 id 1htcFQ-0002wO-30
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 14:25:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mfGZ8SeOeIhonzIqTVSkzjJI6J3VfEMFQmGBUkJf06/RTIUOL8t/NV6Q1yDW76iVDISSlHT/Rnyn3cSlEp9/CXc4Bq+S2jKZX1tkQlQScvkZJf/yaS07a+4ssHMWA7dhtlPGVNzRqjm6tHOtS3m2pq8XrU5OsX7aWFcsX1sGGVuVCA0lT1r/L+sTiTSTGyhVQC0uhuWsgLlyBg0JWcOvPBH46/hHatqhtVHDDTXF/bV5ef/PrQb67W1gJaqEV8IWS9dBmTffHmW9pKyzPLfd3zx9+qUAZpGQZ808+gGCkngAGm56/q4TC5vM7bCvIcg6BK81xZPl6NCD+dltboP9xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Q3dfl9e/SDOx3B6sdeQeQtxodoJQYlV9j50V3OeWl8=;
 b=j0PnxobYv0e9JbVzc61iLXggeXvG77Zb5pxMO/nDgwm3d5zCL+zn2+mZ9DJO4NS/5ELmR7jyN6ghtLowO2YuGIOiQsW49ZF0t7kEMTx6cwphm2iVrs1Uid2FOEJerCV4nr0FURxpiA9M94+kDIlS3AU2hYrYVOCRKb7DyKhXfRyQZHyDcVAoSl+OR0NQNIXgr+ok93j/k5sW+2F9EMKPf+Wwl/hipcPGBMQin2MEroGiYcfAdwnZQ5qpTOJq9aLU3MUi/2ANOZX+3jv5ExfEEZ9rpMNep7kiKto8nAu2PUiPSNgnEmsYJ8LXwN70UDhdome5E2vllf/2PfClzqD9tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=os.amperecomputing.com;dmarc=pass action=none
 header.from=os.amperecomputing.com;dkim=pass
 header.d=os.amperecomputing.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Q3dfl9e/SDOx3B6sdeQeQtxodoJQYlV9j50V3OeWl8=;
 b=PXy1fP6MBp3Dleu8oyc92kTdcHZMSbWtkhIDRH8IYayv0NUJbwLAV5LCpNhCyOF6B+uyRx2tKTgfFS9YrxBMI1MQ+Lh3XWIQdPIRGUxLrwaVz3Q3iadsfFIUBQQORHeyOrmxrGvn4pS4MNk+/CqMyb4pu2VcQUEXJnie8zdJGXs=
Received: from DM6PR01MB4825.prod.exchangelabs.com (20.177.218.222) by
 DM6PR01MB5036.prod.exchangelabs.com (20.176.120.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.16; Fri, 2 Aug 2019 18:25:41 +0000
Received: from DM6PR01MB4825.prod.exchangelabs.com
 ([fe80::4943:2b46:af24:e807]) by DM6PR01MB4825.prod.exchangelabs.com
 ([fe80::4943:2b46:af24:e807%7]) with mapi id 15.20.2136.010; Fri, 2 Aug 2019
 18:25:41 +0000
To: =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>
Thread-Topic: [PATCH  v4 13/54] plugin: add user-facing API
Thread-Index: AQHVR7oQlC96UxQrXEO0dtdjAs8AT6boL+yA
Date: Fri, 2 Aug 2019 18:25:41 +0000
Message-ID: <20190802182541.GO5034@quinoa.localdomain>
References: <20190731160719.11396-1-alex.bennee@linaro.org>
 <20190731160719.11396-14-alex.bennee@linaro.org>
In-Reply-To: <20190731160719.11396-14-alex.bennee@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CY4PR14CA0038.namprd14.prod.outlook.com
 (2603:10b6:903:101::24) To DM6PR01MB4825.prod.exchangelabs.com
 (2603:10b6:5:6b::30)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aaron@os.amperecomputing.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [108.169.132.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e4b8e1fa-3ba6-46dc-4d4d-08d71776d2fd
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DM6PR01MB5036; 
x-ms-traffictypediagnostic: DM6PR01MB5036:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DM6PR01MB5036EE7A6654C9B2B0E535F38AD90@DM6PR01MB5036.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 011787B9DD
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(346002)(136003)(39840400004)(366004)(376002)(396003)(199004)(189003)(6506007)(68736007)(386003)(4326008)(76176011)(966005)(102836004)(6246003)(6486002)(6436002)(66446008)(66556008)(64756008)(66476007)(71190400001)(1076003)(4744005)(71200400001)(14454004)(66946007)(33656002)(53936002)(52116002)(486006)(11346002)(14444005)(446003)(478600001)(256004)(9686003)(6512007)(86362001)(5660300002)(476003)(99286004)(6306002)(25786009)(66066001)(7736002)(316002)(305945005)(3846002)(6116002)(186003)(26005)(6916009)(2906002)(229853002)(81166006)(8676002)(81156014)(8936002)(54906003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM6PR01MB5036;
 H:DM6PR01MB4825.prod.exchangelabs.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:0; MX:1; 
received-spf: None (protection.outlook.com: os.amperecomputing.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: nqijlDvPHZrFeWnMvH44Z+sAFQoWQfJLnqVx2u4N3ySJU9u7faxhkRkgHGA+UuxBy+FXvOi2dnMWPYT3WQM5yPhE9kQfOCgSDcBTt1on37xj0zINhn/VBEZXIBIAS2aUVirxxNhRLOBVyzU6k7PD6wm5GVcKTGstzVf60HLZi2djsarwLxw4JDEL2Obc6EIKEW5ndI8Up18FMfieAPLIWo5F9EijlTgLS/oELin7HDuIrgb6myoBoP3I+yrVJpe7qX4sGEtvmKYiVx52IAkenovJFKpPAT0kQTV5rd4Zs+Wr1PnSMxg2fSlNZQrDXXOvF71xjtFxh2ROQWNJAcfuxzo5Xi0l58dyq6UbBaTDTlzdvDKgyEYtt8w0BbhLjj3nbqPwH3c2KAkTHwCkEcr23qaYa+vQg2cc+XPHyBYHdVk=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <74403153738D2D4A85D9A2CE57135AEF@prod.exchangelabs.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4b8e1fa-3ba6-46dc-4d4d-08d71776d2fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2019 18:25:41.1229 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Aaron@os.amperecomputing.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR01MB5036
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.74.107
Subject: Re: [Qemu-devel] [PATCH  v4 13/54] plugin: add user-facing API
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
From: Aaron Lindsay OS via Qemu-devel <qemu-devel@nongnu.org>
Reply-To: Aaron Lindsay OS <aaron@os.amperecomputing.com>
Cc: "bobby.prani@gmail.com" <bobby.prani@gmail.com>,
 "cota@braap.org" <cota@braap.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

One thing I would find useful is the ability to access register values
during an execution-time callback. I think the easiest way to do that
generically would be to expose them via the gdb functionality (like
Pavel's earlier patchset did [1]), though that (currently) limits you to
the general-purpose registers. Ideally it would be nice be able to
access other registers (i.e. floating-point, or maybe even system
registers), though those are more difficult to do generically.

Perhaps if we added some sort of architectural-support checking for
individual plugins like I mentioned in another response to this
patchset, we could allow some limited architecture-specific
functionality in this vein? I confess I haven't thought through all the
ramifications of that yet, though.=20

-Aaron

[1] - See qemulib_read_register() at
      https://patchwork.ozlabs.org/patch/925393/

