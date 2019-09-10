Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78A63C49ED9
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 16:25:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 455DB20872
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 16:25:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="Q3gz76DA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 455DB20872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7ixd-0004B3-EN
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 12:25:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45225)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aaron@os.amperecomputing.com>) id 1i7iwr-0003a8-OB
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 12:24:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aaron@os.amperecomputing.com>) id 1i7iwq-00029B-F0
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 12:24:57 -0400
Received: from mail-eopbgr800134.outbound.protection.outlook.com
 ([40.107.80.134]:44960 helo=NAM03-DM3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aaron@os.amperecomputing.com>)
 id 1i7iwq-00026f-B4
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 12:24:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oi5WercBXu2paBFdZcQokDa3Ji5VzjG0lroO/FMJJSLfRZ1bVaFMx596PX3+9LfbyRcZevhBYoZF26a8cXWbj2LN5eEBHpS7waoWmz27rm/GnwVG266tyLlznyGnDbK0A5QLJJ49+bGdfle4C+lD6FQJhZwGcwhwgTD4+18/OmXoEfjS9Cu1f9mhe3V1fSYIvaGr/Utf5rlGMacCOLB8urxTd5ek15fb6L2rxT0EBhUGJepJT9gczAAe63p0vMeCe3S1Znqj/SxcuPzG4G6ZZykWD1aoET+2Xk5JkFBAelYRtVmxEt6WdRAPerDIBIq5+3OSKisuqIfZn2ieRRDopA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r5VbA30jp3bMMAHF1zzNBwSCJLb7gOO7omQH3KhV6gI=;
 b=C/feLCbGwPo2YMlR+bkyMBghZ4fvYCaKIieyQ/tvHz3+LF5M5KCJjHQJ7tzhoYbh03iN8gY1PBGyNWbo090mAocxtK63jBzswhasswwmPrZ0sg9tJQLZm0C6JLz+sTeF6FD8bTdsyHDlMjUJtfOBwFjf44CkBS8GZhT1dDPxh/H4JJtwljqVNjK387wrmKpJ6s80iaVQ+q5AeNRXB/iXIUX0/BDiUFDNW/OoTAbG3VvHSpxhnVCNkgIn3FRdA2DtunJvqLHz7cR32tmt1DY9Q05CV5ioSOnVl5v5COIEYeSLz899RW8we010RtVu/U9dD1ubFMFRAjEu07GYrItqAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r5VbA30jp3bMMAHF1zzNBwSCJLb7gOO7omQH3KhV6gI=;
 b=Q3gz76DAwDwPjVDL04TLbPomvYUTeKVv+GFEKlIvusDINmMIvy4qbV9LontjUsSv0TaxmyE23m2QgGub+xSoRWcSEVJIi4KQvZ/vgHVQ7QRxo18TtUdCSA5rG1Ac3GBfSNaMGLh6WxS1y+Y1hmgPej91AksN9VCaiM86H5udOrE=
Received: from DM6PR01MB6027.prod.exchangelabs.com (52.132.249.89) by
 DM6PR01MB5146.prod.exchangelabs.com (20.176.121.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.13; Tue, 10 Sep 2019 16:24:51 +0000
Received: from DM6PR01MB6027.prod.exchangelabs.com
 ([fe80::e15d:8a0d:11cc:cb95]) by DM6PR01MB6027.prod.exchangelabs.com
 ([fe80::e15d:8a0d:11cc:cb95%7]) with mapi id 15.20.2241.018; Tue, 10 Sep 2019
 16:24:51 +0000
To: =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>
Thread-Topic: [PATCH  v4 13/54] plugin: add user-facing API
Thread-Index: AQHVR7oQlC96UxQrXEO0dtdjAs8AT6boL+yAgDcT5ICABhVHAA==
Date: Tue, 10 Sep 2019 16:24:51 +0000
Message-ID: <20190910162452.GB20976@quinoa.localdomain>
References: <20190731160719.11396-1-alex.bennee@linaro.org>
 <20190731160719.11396-14-alex.bennee@linaro.org>
 <20190802182541.GO5034@quinoa.localdomain> <877e6lz0g2.fsf@linaro.org>
In-Reply-To: <877e6lz0g2.fsf@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CY4PR06CA0068.namprd06.prod.outlook.com
 (2603:10b6:903:13d::30) To DM6PR01MB6027.prod.exchangelabs.com
 (2603:10b6:5:1da::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aaron@os.amperecomputing.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [65.190.6.212]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b52a0563-2ade-4cce-81bf-08d7360b67d3
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DM6PR01MB5146; 
x-ms-traffictypediagnostic: DM6PR01MB5146:
x-microsoft-antispam-prvs: <DM6PR01MB5146FAA44957A36165785A5E8AB60@DM6PR01MB5146.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 01565FED4C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(366004)(136003)(39840400004)(396003)(376002)(346002)(199004)(189003)(2906002)(66446008)(64756008)(256004)(305945005)(6436002)(1076003)(33656002)(66946007)(66556008)(7736002)(6512007)(9686003)(5660300002)(6116002)(66476007)(14444005)(66574012)(52116002)(8936002)(316002)(54906003)(99286004)(8676002)(81156014)(81166006)(26005)(66066001)(76176011)(86362001)(6506007)(11346002)(446003)(486006)(476003)(102836004)(386003)(53936002)(3846002)(25786009)(4326008)(186003)(6246003)(478600001)(71190400001)(71200400001)(6916009)(14454004)(229853002)(6486002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM6PR01MB5146;
 H:DM6PR01MB6027.prod.exchangelabs.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:0; MX:1; 
received-spf: None (protection.outlook.com: os.amperecomputing.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 11Wa1W4/DguhqHoLHJbgvXCufSbBzzqW5LMHaNoGTFqBpyQoOq3hty1sfl5dbYkLGKqLYnBKE7ypqePudBd1VxdVCWX5TlL0nBKdr7hsGZjBmvvzAjmjvrDPoer/6Rldm1cCk8gwg9KUHl2LzfGMrzF0bwqtbENfkyJlwWPjyOD69OQR+iY4REZ7zrbzA/EeUVtbc3TPS/0zI+8CWZyLR5s6B/YyoTYdeQGf0vXRJPxPykcPEXlsdLdwfEv5/3TLur342qgcz8S8aK7EFXlA6lMbMVkv4hfMzTaar11QYWa66mQ3GD12nDm1TVsY7GIG6o/n6LVbJUJcIzfFf5B+OgMfQMChA5xPfjoRikQr7fLbPcvYXKHGfl01d2MjP+Yy5r00Mr0vLuRHFxEq6sb8XvKMFj3r1Nnk8UQKOczXeOw=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <AF37C9D68C57634294EE741AB3134FC6@prod.exchangelabs.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b52a0563-2ade-4cce-81bf-08d7360b67d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2019 16:24:51.2098 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qMpQOySjN3XpH4J2U2NNY0uP+3ho99WGjIVc2u+iTdm2R5U+GMXqCeAsAJs/x81vmfYnRge5+GclimMKvX3l52YUEJIxR5wENn1Xc5K6Ads=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR01MB5146
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.80.134
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

On Sep 06 20:31, Alex Benn=E9e wrote:
> Aaron Lindsay OS <aaron@os.amperecomputing.com> writes:
>=20
> > One thing I would find useful is the ability to access register values
> > during an execution-time callback. I think the easiest way to do that
> > generically would be to expose them via the gdb functionality (like
> > Pavel's earlier patchset did [1]), though that (currently) limits you t=
o
> > the general-purpose registers. Ideally it would be nice be able to
> > access other registers (i.e. floating-point, or maybe even system
> > registers), though those are more difficult to do generically.
>=20
> ARM already has system register support via the gdbstub XML interface so
> it's certainly doable. The trick is how we do that in a probable way
> without leaking the gdb remote protocol into plugins (which is just very
> ugly).

What do you mean by "in a probable way"?

I agree that simply exposing the gdb interface does not seem like a
clean solution.

> > Perhaps if we added some sort of architectural-support checking for
> > individual plugins like I mentioned in another response to this
> > patchset, we could allow some limited architecture-specific
> > functionality in this vein? I confess I haven't thought through all the
> > ramifications of that yet, though.
>=20
> I was wondering if exposing the Elf Type would be enough? It's portable
> enough that plugins should be able to work with it without defining our
> own architecture enumeration.

I can't think of a reason that wouldn't work, assuming you're referring
to exposing a value corresponding to the `e_machine` ELF header.

-Aaron

