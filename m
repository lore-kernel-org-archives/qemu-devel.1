Return-Path: <SRS0=mi2X=WI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E93C433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 14:47:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A0FD206A2
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 14:47:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="sdYqZtE+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A0FD206A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxBbj-0006hj-IR
	for qemu-devel@archiver.kernel.org; Mon, 12 Aug 2019 10:47:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36828)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aaron@os.amperecomputing.com>) id 1hxBam-00069y-C3
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 10:46:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aaron@os.amperecomputing.com>) id 1hxBal-0005UD-He
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 10:46:36 -0400
Received: from mail-eopbgr720101.outbound.protection.outlook.com
 ([40.107.72.101]:31302 helo=NAM05-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aaron@os.amperecomputing.com>)
 id 1hxBai-0005SV-Ds; Mon, 12 Aug 2019 10:46:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LCJ+DEGL5wG7qoyHTFqqDLr2h4Ll5yxtwMxLpNin5oQEeW3diyJjRUMVXosPFdg5iwnmDOTNCyvgIjAMX6SvDn8BjIk0RBeWAiqGPfvYnMB+HaONdu9afPTbTVTI9dQhHxoWV24+eUbzDwKj+SdMVZwKWw1zJuUs2be7s03G7WmvaIrDUIHgjxtPsSYOZ1daDYxoCQL+OKOLPDH0gU6ZHBGLPewgQ3CBgG4kAJE9cW8+ME2FMZQnXwoEIxrbND/Zf9/Ddpdpn3YM5p9GFAweRGFgIYXR5W37Qvae89OKokufnzNmaXNnagZde6/NbmdK4cF4bzD9yCb1jkacOch2Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IfI+c2yoHWTzULGfcjcaKFZTGtqofoJyun34NgOH2y0=;
 b=BqBFxd4uASzjK7rUSb70sRlK7DuI4XVCs0NJFIHfa4WITp+G5DPCi/qZzbKukC7RsJoeNzrxAiHssdWm62n+lPg9Y4MAgDx19JG0zlgBMXCuHaRFmqXtHEx4olU1oDtixEuZmM/30av2xrBPD2KdH1y1gCT2HrJvsD6R8TVf+IW8e77O+9xVZMcLdDqMhNAAz7/fcaiESoHV2YTczQf1Az39PfJbAa/x+OqCOxyDi2SvI19bm8BXTA+GCfyfnqh9xS2iij1cuIsHPpNmZ3eNL8VkdWnAVKMx4tksnqxgfeCJkgCFbmI3xgMYz1pwyzQ5xXjTdgLAKDeepj3h9k8paQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IfI+c2yoHWTzULGfcjcaKFZTGtqofoJyun34NgOH2y0=;
 b=sdYqZtE+OArks1LmNUkE90ijraBpJWi0VGZE3mZopZ01PKYnO+Ums2DE0iYjVdsuqoTSFDFDbB91yqOnDUM7wLO25aZRs2zeAT9LepX9YhCPkr8zKNhLFdHEFz8R+JVLus1o6CtxA7Ls1KpAe+juIC9/NBpS6USpeGejUy+go10=
Received: from DM6PR01MB4825.prod.exchangelabs.com (20.177.218.222) by
 DM6PR01MB3945.prod.exchangelabs.com (20.176.66.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.20; Mon, 12 Aug 2019 14:46:27 +0000
Received: from DM6PR01MB4825.prod.exchangelabs.com
 ([fe80::4943:2b46:af24:e807]) by DM6PR01MB4825.prod.exchangelabs.com
 ([fe80::4943:2b46:af24:e807%7]) with mapi id 15.20.2157.020; Mon, 12 Aug 2019
 14:46:27 +0000
To: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
Thread-Topic: [PATCH] elf: Allow loading AArch64 ELF files
Thread-Index: AQHVURy4yDbUMFtoS0GmsVnUb69OAg==
Date: Mon, 12 Aug 2019 14:46:26 +0000
Message-ID: <20190812144442.30027-1-aaron@os.amperecomputing.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CY4PR14CA0035.namprd14.prod.outlook.com
 (2603:10b6:903:101::21) To DM6PR01MB4825.prod.exchangelabs.com
 (2603:10b6:5:6b::30)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aaron@os.amperecomputing.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.22.0
x-originating-ip: [108.169.132.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cbadcf1b-682a-4463-27e0-08d71f33daa0
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DM6PR01MB3945; 
x-ms-traffictypediagnostic: DM6PR01MB3945:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR01MB394542832EC6119988848EB88AD30@DM6PR01MB3945.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:983;
x-forefront-prvs: 012792EC17
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(39830400003)(396003)(136003)(376002)(366004)(346002)(199004)(189003)(6916009)(8936002)(6512007)(107886003)(2351001)(6436002)(186003)(386003)(52116002)(4326008)(6506007)(54906003)(6486002)(5640700003)(316002)(102836004)(25786009)(14454004)(53936002)(50226002)(478600001)(26005)(2906002)(1076003)(256004)(6116002)(8676002)(81156014)(66066001)(81166006)(4744005)(66446008)(66946007)(66476007)(64756008)(305945005)(66556008)(5660300002)(3846002)(7736002)(99286004)(2616005)(71190400001)(71200400001)(2501003)(86362001)(486006)(476003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM6PR01MB3945;
 H:DM6PR01MB4825.prod.exchangelabs.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:0; MX:1; 
received-spf: None (protection.outlook.com: os.amperecomputing.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: yoTweD1lsfyQYQ4mwZ7CFyTPUYOP4MaogWXfh9A1jG/onqmTHnJCoHEQUFX7y8N/P9XL8Gbv/C4vmkf67lU0AmmR67GEs23Gk3I2CByUPScxULbpACXWHAoiqpno6YvCj1yght2yv9pHHMdbYu2+Z236PhJt1joh0+CFWW8uOrQ0ny5oe1GFQByXJrUwRu9EqpOo3+u2KmCJv3nMOlpvx06XVgjDxWcA9RP7kPTETqI9dlq6SvZWhstxXqkg6VFRgwkoJwkPNqzuqE40onXkOQlXiJ35pVGFCTN+WR7q+rXmuma7SVLTS/PhofytoW3isMFKF8d1L2b04DT9QyPPfKd2UCZiLFaaScVeXNL73JY97XZzLYxvUMDeFztvPVi+3KS3pMbhmucBi2UsDN3IY5ZrfCqwn9fXQqtDpteygdE=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbadcf1b-682a-4463-27e0-08d71f33daa0
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2019 14:46:27.1155 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gJfeHgrUmQnJYtGepDpW/huIUyFuP0O+DkS/XJqZcqoQTgaXOYqyHA/jUNWnDl349nlZO+v7w6rZ7f6EjHMwtiIREphhwaO3vYQ1FB22id0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR01MB3945
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.72.101
Subject: [Qemu-devel] [PATCH] elf: Allow loading AArch64 ELF files
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
Cc: Aaron Lindsay OS <aaron@os.amperecomputing.com>,
 Peter Crosthwaite <crosthwaitepeter@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Alistair Francis <alistair.francis@xilinx.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Treat EM_AARCH64 as a valid value when checking the ELF's machine-type
header.

Signed-off-by: Aaron Lindsay <aaron@os.amperecomputing.com>
---
 include/hw/elf_ops.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/hw/elf_ops.h b/include/hw/elf_ops.h
index 690f9238c8..f12faa90a1 100644
--- a/include/hw/elf_ops.h
+++ b/include/hw/elf_ops.h
@@ -381,6 +381,12 @@ static int glue(load_elf, SZ)(const char *name, int fd=
,
                 goto fail;
             }
             break;
+        case EM_AARCH64:
+            if (ehdr.e_machine !=3D EM_AARCH64) {
+                ret =3D ELF_LOAD_WRONG_ARCH;
+                goto fail;
+            }
+            break;
         default:
             if (elf_machine !=3D ehdr.e_machine) {
                 ret =3D ELF_LOAD_WRONG_ARCH;
--=20
2.17.1


