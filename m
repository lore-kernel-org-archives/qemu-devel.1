Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3038AC19759
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 14:32:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB00A206B8
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 14:32:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="sYo8S3xO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB00A206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htC89-0005xm-2a
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 10:32:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55160)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aaron@os.amperecomputing.com>) id 1htC7W-0005So-Ti
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 10:31:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aaron@os.amperecomputing.com>) id 1htC7V-0002gk-2x
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 10:31:54 -0400
Received: from mail-eopbgr800105.outbound.protection.outlook.com
 ([40.107.80.105]:10238 helo=NAM03-DM3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aaron@os.amperecomputing.com>)
 id 1htC7U-0002g2-Q2
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 10:31:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eb97x/1xEEIsaXZCZsSGbsVoZxQLQaKTannBNxZRVQRRuKtf2XUlGnAuEcZLQ4Xu5kGAKRZkhWqtE33nfi8Z4YIe2hkl+btC0Uc+9PlLkgJCIiuTcElCENIebjx0RgrkNTrQiZbsbRZtZ7iHrG8scENxSt3tIYCm7ERxRgylllHXK3Efbuxj7HK6JFCjCgPu6Ua7NeQeug5qj72R+Pw1Z/vWedWktvKG/HBN7h2h/xx1rF/qrB457yGH3EBbKj+R19cl5pHJXk80gt48J+xUnrzVWWekrt+tZVbxyNkKmWZ16Ynb1DSO+vpUSFPuU1ZJZ01MhF0ftKIoPftl6GoH0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tkoqA//D5J0XnhGsRutP0PG+PUwUx7qtp5vGs0QwIp0=;
 b=gIOHjnXp45P62N9OO6/yFaoelVStjOEHzxHZbLsjDOWXE3rK9JLiPtSQheoC+1NPQ5TpudAMsG7CGWc/afp4NaPwmpdI/9SIG2F6wdZU1k3zmCNuzuHO6ytDjrQkUj3aR8MYeVa3myq1zC/a5/fjGqbmU8mPhVoXyCwIZ6DIz1SzTeKfboA/osNlOxVSDliRpcRlu5QR9EyTs2Ic7u8HeuURnBJQ4dTytJmD1kVTTnoQksN8ymvh+hBHGYn66FSmqhy5pEJKQPgiZXxiK+NxF2YAheP5mQ4H95IFXf/5E3UHOpUGkAxA7tcJP6QnCxWnna1Sf/G/9jSXpDd5TxsuNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=os.amperecomputing.com;dmarc=pass action=none
 header.from=os.amperecomputing.com;dkim=pass
 header.d=os.amperecomputing.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tkoqA//D5J0XnhGsRutP0PG+PUwUx7qtp5vGs0QwIp0=;
 b=sYo8S3xOT2ReOGxZJSv7ad5ppRFPqa7f1OMrw6Mj+SEN5hqEBAPnvbvVOCD6gL9PlQETPXZENF7VXHxgfGs+WPU+3/sz+TeQzyRT2eumAC+0tR2yDv0Tt3m+MbSXlJgPRtN3BbU2SgKtiJeabKLW1JR9kzCvqGuz6qCgdtmwAew=
Received: from DM6PR01MB4825.prod.exchangelabs.com (20.177.218.222) by
 DM6PR01MB4379.prod.exchangelabs.com (20.177.221.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.12; Thu, 1 Aug 2019 14:31:49 +0000
Received: from DM6PR01MB4825.prod.exchangelabs.com
 ([fe80::4943:2b46:af24:e807]) by DM6PR01MB4825.prod.exchangelabs.com
 ([fe80::4943:2b46:af24:e807%7]) with mapi id 15.20.2136.010; Thu, 1 Aug 2019
 14:31:49 +0000
To: =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>
Thread-Topic: [PATCH  v4 50/54] tests/plugin: add instruction execution
 breakdown
Thread-Index: AQHVR7spdG+bjodIF0C41Y0Pkr2vhqbmXD6A
Date: Thu, 1 Aug 2019 14:31:48 +0000
Message-ID: <20190801143141.GL5034@quinoa.localdomain>
References: <20190731160719.11396-1-alex.bennee@linaro.org>
 <20190731160719.11396-51-alex.bennee@linaro.org>
In-Reply-To: <20190731160719.11396-51-alex.bennee@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CY4PR15CA0015.namprd15.prod.outlook.com
 (2603:10b6:910:14::25) To DM6PR01MB4825.prod.exchangelabs.com
 (2603:10b6:5:6b::30)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aaron@os.amperecomputing.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [108.169.132.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c52d77bd-373d-4d3d-4364-08d7168cfcc5
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DM6PR01MB4379; 
x-ms-traffictypediagnostic: DM6PR01MB4379:
x-microsoft-antispam-prvs: <DM6PR01MB4379D125381067F4FAB084418ADE0@DM6PR01MB4379.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01165471DB
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(39830400003)(396003)(376002)(366004)(136003)(346002)(199004)(189003)(6486002)(52116002)(476003)(478600001)(71200400001)(81166006)(446003)(6116002)(3846002)(53936002)(11346002)(305945005)(4326008)(26005)(6512007)(9686003)(6246003)(54906003)(33656002)(66446008)(186003)(4744005)(66946007)(81156014)(102836004)(68736007)(7736002)(8676002)(64756008)(66556008)(316002)(66476007)(6916009)(66066001)(99286004)(14454004)(1076003)(66574012)(386003)(25786009)(8936002)(6436002)(229853002)(6506007)(71190400001)(86362001)(486006)(256004)(76176011)(5660300002)(2906002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM6PR01MB4379;
 H:DM6PR01MB4825.prod.exchangelabs.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:0; MX:1; 
received-spf: None (protection.outlook.com: os.amperecomputing.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5x01AnsB+Kht3X9hlo6njDaez7GCA3IMl6uVeowaLZELwIzXCgymFpPwdUwsyeCDi9CUWjXA/2G854DcZ7d1hXEK7+A7giN7i39+S/YnpgBIWPoAwSe4xfjAFYrhOQj4myaovpxuDlXomr/6GCdydWbj0KFmziJHN6QoKwtS2n8G97qcz2v1mV9NDAhx5lT3EeWQimzmU4G8yJEFcJD/x9TtEFoKhoX0u/odxqHCyTlFIkyxSTXBHriJFkbRF6HTjnnZnfVebeaRNJfWzidG6ElVVD996pDaReAzUdk7Sfh8ETCitfGI1MRLL9sOl/secSimaZDOt3ntAcTmoC1vsuAKvsi6+8+76G7s2oXr1hgygvwY136Jit/u5lXrd4Vx4u+/UywlcbflM6rWzxWXZZQjs1tbtJkM7BM0HCgBPjs=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <6EF0A4C6DF3DB24EA2D3ACEA61C5D3B6@prod.exchangelabs.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c52d77bd-373d-4d3d-4364-08d7168cfcc5
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2019 14:31:48.9902 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Aaron@os.amperecomputing.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR01MB4379
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.80.105
Subject: Re: [Qemu-devel] [PATCH v4 50/54] tests/plugin: add instruction
 execution breakdown
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

On Jul 31 17:07, Alex Benn=E9e wrote:
> + * Attempt to measure the amount of vectorisation that has been done
> + * on some code by counting classes of instruction. This is very much
> + * ARM specific.

I suspect some of my plugins will also be architecture-specific. Does it
make sense to have a plugin specify to QEMU which architectures or
running modes (i.e. softmmu vs. linux user) it supports? Or
alternatively to have QEMU expose this information to the plugin so that
it can cleanly exit if its needs are not met?

-Aaron

