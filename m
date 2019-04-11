Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC3F2C10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 20:10:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39CFC20850
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 20:10:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="eNgtwyzO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39CFC20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wavecomp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54342 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEg1R-000298-AI
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 16:10:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1hEg0a-0001pj-9k
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 16:09:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1hEg0Y-00059d-NW
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 16:09:16 -0400
Received: from mail-eopbgr770103.outbound.protection.outlook.com
	([40.107.77.103]:61644
	helo=NAM02-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1hEg0Y-00058B-Ao
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 16:09:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=9A1+xpoIWxzBvXflTLnUOkI7l7dxJGgWRcQHoMlkib4=;
	b=eNgtwyzOm3EnZj0w1SD3XuwE8iPueNlkxeh3AZgURfi9embnkrCzKK/wlGiKwIlTbZwB9JaEtWpBpv0mp86nOCqOEQKlrXC7StgU7ourDPppZJ3XdHsHmTaaPqPvdzDSLKHmXLRXDrPT6JnOl6zKeUcKQkTBepFet0DxaZhvNfg=
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com (10.174.81.139) by
	BN6PR2201MB1699.namprd22.prod.outlook.com (10.161.156.21) with
	Microsoft SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1771.19; Thu, 11 Apr 2019 20:09:09 +0000
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com
	([fe80::3c70:1ca4:2aa:9e81]) by
	BN6PR2201MB1251.namprd22.prod.outlook.com
	([fe80::3c70:1ca4:2aa:9e81%2]) with mapi id 15.20.1792.009;
	Thu, 11 Apr 2019 20:09:09 +0000
From: Aleksandar Markovic <amarkovic@wavecomp.com>
To: Jules Irenge <jbi.octave@gmail.com>
Thread-Topic: [PATCH v3 2/4] target/mips: add or remove space to fix
	checkpatch errors
Thread-Index: AQHU68od18Qw0T5Oq0awmrPtostyFaY3bLDo
Date: Thu, 11 Apr 2019 20:09:09 +0000
Message-ID:
 <BN6PR2201MB125112CE3BBE8E7DCA624750C62F0@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <20190405160938.27494-1-jbi.octave@gmail.com>,
	<20190405160938.27494-3-jbi.octave@gmail.com>
In-Reply-To: <20190405160938.27494-3-jbi.octave@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=amarkovic@wavecomp.com; 
x-originating-ip: [82.117.201.26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 676bf13e-8502-457c-3054-08d6beb98ebe
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);
	SRVR:BN6PR2201MB1699; 
x-ms-traffictypediagnostic: BN6PR2201MB1699:
x-microsoft-antispam-prvs: <BN6PR2201MB1699BB16C19AAACF038118C0C62F0@BN6PR2201MB1699.namprd22.prod.outlook.com>
x-forefront-prvs: 00046D390F
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(396003)(376002)(39850400004)(136003)(366004)(346002)(189003)(199004)(81156014)(25786009)(81166006)(305945005)(6436002)(66066001)(6506007)(52536014)(74316002)(9686003)(26005)(2906002)(316002)(106356001)(478600001)(71200400001)(55016002)(33656002)(53936002)(55236004)(7736002)(102836004)(186003)(3846002)(14454004)(7696005)(97736004)(486006)(6116002)(446003)(8936002)(68736007)(4326008)(86362001)(5660300002)(6916009)(54906003)(99286004)(8676002)(229853002)(76176011)(256004)(105586002)(476003)(6246003)(4744005)(11346002)(71190400001);
	DIR:OUT; SFP:1102; SCL:1; SRVR:BN6PR2201MB1699;
	H:BN6PR2201MB1251.namprd22.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: wavecomp.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: LZLiev4ca1m59Hhhhs9j39InT9G8iNErWoFjdktbZll5XQsD5I8nP2qMCf90kMCNwAJBy55euOYmw9b1NBjvEPcio7kWsjMHQfO/uJox3wmKqsLbWSUgwQbnOYgDkmiZAjTqstP4vAAB8seJ0WVfzMX12wwP6ZWDRi4hn6DLYSFzXJQ42K1ZORtumkr5QgI9S6TR4ONy8K1u8ElkkI+cdZfW0yTcDDonUa9Y5A+KLwL6z/SAMbk3E5C8C83RrvsdvBTxeD8GoQF4LflySkg3I4CAKzqcLpOE3Ty2QJL2kVaLj4FYCEBY2trhaC8wDwam3mjr9oaaYL1MmRLLEIV+HLI9R8W8wzUCKgi26ggl6geICwG/3Z4KFaOZav3GkrVFifiWGJyB6ijgBe10ykyZbUISTqW4i/0boakgqHhYWUQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 676bf13e-8502-457c-3054-08d6beb98ebe
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2019 20:09:09.1178 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR2201MB1699
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.77.103
Subject: Re: [Qemu-devel] [PATCH v3 2/4] target/mips: add or remove space to
 fix checkpatch errors
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190411200909.tXoIXcve5k-FaEU1gmUz4aIxDdpeUNnx-UG1CXRznPw@z>

> From: Jules Irenge <jbi.octave@gmail.com>
> Subject: [PATCH v3 2/4] target/mips: add or remove space to fix checkpatc=
h errors
>
> Add or remove space to fix errors issued by checkpatch.pl tool
> "ERROR: spaces required around ..."
> "ERROR: space required after that"
> "ERROR: space required before the open parenthesis"
> "ERROR: space prohibited between function name and open parenthesis"
> within "target/mips/cpu.h" file.
>=20
> Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
> ---

Hi, Jules,

I think if you merge this patch (2/4) and the next one (3/4), your series w=
ould be good to go.

Sincerely,
Aleksandar


