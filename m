Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E27C34047
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 20:39:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8E512173E
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 20:39:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="OAiOHA0f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8E512173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j49eZ-0008Pq-5T
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 15:39:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37444)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sunilmut@microsoft.com>) id 1j49di-0007qp-Kq
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 15:38:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sunilmut@microsoft.com>) id 1j49dg-00086Q-1m
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 15:38:41 -0500
Received: from mail-dm6nam12on2130.outbound.protection.outlook.com
 ([40.107.243.130]:52192 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sunilmut@microsoft.com>)
 id 1j49dc-00080h-04
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 15:38:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fQbwPZVNdB8jIS41CZfBwCQbp+NMXQNKzCu+VVmWkTXYuc27Ob3+O/xnokkwXuoMm6JiU0j6bWUX0L2dJW/u3b1qJttW3JIc3A/+DAkxAPbU0lO0DW5AKuPqbQcgbCyY0fU50Fg8xMXJtvV5N1+8wo78dqAFAA7RV+aXimtnqD4up03nM3S0JCRIFlKlgjNh5kdRm3jS4sXZo521BDuSUa29/9cNkLqy9sx5DzW47UGEKxLFiA/ppHPHHen2ifc+eZDC+qSW1lSPC2cTiScUIMRblmQQ9mJGzvUMHauGn2XloGaUk+uelzGFUlD1hWdePTzyYDGkqr07DrYkhJ6g0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XYAHfB2idGwCtyAFEOGIsSmTojx/57/Mv4GnJqGZzzs=;
 b=QNI7AIIlxtubtr6hvfM+CC5ehKbJ2F3kLouaBOlL6hzd03ia027x1/h94Cc/XHLP0jgPNeYHO1j2OhYmIpQCyB+H80MPB4EDIU+dBRG402Qg7yEVrmavm40WZAe8WdGp2ehxRFaEvVwiUXsh276zsdb1UDF4eq1HG9wQk2f5euEtSnfnyaMvHp5jj77mqUWcaJ6Ab+4MEv1eYWgaZUqezDMzM8BNEJLBNQyeJEI+RN7kc/zoo1tBvDQWoEAAQ+O4j5y8aQyuPdGvCmQR7Lpq9hFBoZ2ZztAQ74JwsDZuyrBdcr1/oYWHwxO9AGZ0hWM0SeLuzCXTbrHD9mfsHWjJyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XYAHfB2idGwCtyAFEOGIsSmTojx/57/Mv4GnJqGZzzs=;
 b=OAiOHA0f08QC3AwAfIPRpb2Jkjtn9mEs3LXEn+xFeIRJiM92lGe7O/ZS6nAkR+OoS6SVG0oXKTDRLJojrEvEtUrnRQl5QjY+nxsetRPPyFVbUBsO/AvqI1QkiDDr3nR6zMals49P1bO7WV5CI3Svwpwc9i4L7rSB3syxGg52xqc=
Received: from SN4PR2101MB0880.namprd21.prod.outlook.com (10.167.151.161) by
 SN4PR2101MB0734.namprd21.prod.outlook.com (10.167.151.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.3; Tue, 18 Feb 2020 20:38:32 +0000
Received: from SN4PR2101MB0880.namprd21.prod.outlook.com
 ([fe80::15c9:bf73:c204:7cb7]) by SN4PR2101MB0880.namprd21.prod.outlook.com
 ([fe80::15c9:bf73:c204:7cb7%9]) with mapi id 15.20.2750.000; Tue, 18 Feb 2020
 20:38:32 +0000
From: Sunil Muthuswamy <sunilmut@microsoft.com>
To: Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
CC: Stefan Weil <sw@weilnetz.de>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "Justin Terry (SF)" <juterry@microsoft.com>
Subject: [PATCH] WHPX: Assigning maintainer for Windows Hypervisor Platform
Thread-Topic: [PATCH] WHPX: Assigning maintainer for Windows Hypervisor
 Platform
Thread-Index: AdXmmxkvbI0n3XG6RKSCtw/4QRCyRQ==
Date: Tue, 18 Feb 2020 20:38:32 +0000
Message-ID: <SN4PR2101MB0880E245954826FD91C9D67DC0110@SN4PR2101MB0880.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sunilmut@microsoft.com; 
x-originating-ip: [2001:4898:80e8:2:7c34:6d8c:67e9:f949]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 260126d2-6b75-4d75-0ff3-08d7b4b28528
x-ms-traffictypediagnostic: SN4PR2101MB0734:|SN4PR2101MB0734:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN4PR2101MB0734D8BD6AE8A2C022CC2A37C0110@SN4PR2101MB0734.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:296;
x-forefront-prvs: 031763BCAF
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(396003)(366004)(376002)(39860400002)(136003)(346002)(189003)(199004)(2906002)(107886003)(81166006)(8936002)(5660300002)(9686003)(4326008)(55016002)(478600001)(8676002)(81156014)(316002)(8990500004)(54906003)(6506007)(66946007)(186003)(86362001)(10290500003)(33656002)(64756008)(71200400001)(4744005)(66446008)(66476007)(7696005)(66556008)(76116006)(52536014)(110136005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:SN4PR2101MB0734;
 H:SN4PR2101MB0880.namprd21.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VXeLlGZRby2U8dOV6ZIuvYfIWbma4DUSoTWcuZVUWldX4bsOB+cle6Du2JSIpFcIHBK05CJOLBHViz69yPlSdr6dT9W9JOxsvmP6GN9l9Vq0EKEEaFCcY1jygYdjbqVZTV1ARZURy9ffliUR7yz/6Ycr8qp3x+tUomeaasV8v3KFJUaRl0AC6+gKBrhnUisOGVGOj+h+10thcXvj5MnYptyAJhpKJ4KLn+XGhN034qOcEUo2M91GZrcx68IUlqKTNMJ/gT88VxosBYDjq32htLfpytsce/7luMsyTzIdULEvcXO0HTS5wSEkclWkklb1YmbKgAxoPeXYpvTNFcre1hoisoz81RoyBD6CwU8hrivAsoOxwM2xPsuNHmM7VA6haHGKqI5YG6vl4F/tNB3XbcF/9rUTAcycXj/gWErFPTcTdZrhc+i0WpxOfPHzGA0m
x-ms-exchange-antispam-messagedata: LHggxMVn35Ikz2ENz1MSf7pwoiUirkLQvIxz0MXPJ5KY6VAYx1VFpRYg6SHiQeFkQdbFx2VVmOT2eDigz8WzOF6Gd5n+74/5/bIGNbNY1Qa0PyWzKcGAs5yvHpXdO6u4x9pm8kYOP+6QEm3oxcEsN0i6/oy4uOedl4I7CrkTZn4B1vohRZlpibZhndQTM1WEMDYajMxHLe5G8w9vKLxvMA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 260126d2-6b75-4d75-0ff3-08d7b4b28528
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2020 20:38:32.6368 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GRenDl46slwhsbbB2QfIq9fwM6GZlLTd29HvwdgNX54o+VFMStS+Az1whkYh3FwISN06AW0TsdWCDG63+/l+tZ3A2AeXEtG4wgvpW6ZUsxo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR2101MB0734
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.243.130
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1740a4fddc..9b3ba4e1b5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -404,6 +404,14 @@ S: Supported
 F: target/i386/kvm.c
 F: scripts/kvm/vmxcap
=20
+WHPX CPUs
+M: Sunil Muthuswamy <sunilmut@microsoft.com>
+S: Supported
+F: target/i386/whpx-all.c
+F: target/i386/whp-dispatch.h
+F: accel/stubs/whpx-stub.c
+F: include/sysemu/whpx.h
+
 Guest CPU Cores (Xen)
 ---------------------
 X86 Xen CPUs
--=20
2.17.1

