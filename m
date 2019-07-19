Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78471C7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 18:19:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 422D42186A
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 18:19:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Q0vgcY1R";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="wp6E7GmN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 422D42186A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoXTd-0004si-9r
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 14:19:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35450)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <prvs=09695b1d9=Dmitry.Fomichev@wdc.com>)
 id 1hoXTR-0004Rd-OL
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 14:19:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=09695b1d9=Dmitry.Fomichev@wdc.com>)
 id 1hoXTQ-0001TD-Br
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 14:19:17 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:5741)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=09695b1d9=Dmitry.Fomichev@wdc.com>)
 id 1hoXTP-0001Q2-Om
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 14:19:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1563560356; x=1595096356;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=lh4D6MuGSY2yO/yi696ohx+KAZVJF6eFYxTRshQYi4s=;
 b=Q0vgcY1RoUiEpmFepmPCv/EFcQnpGBonP8KiUaFi+lNZlsTO/IWQzix4
 jIx47RZl3k21igyMzyQ2E96k8hO+IMaG4BTqB8wQhgffSgD8KxlqeH3qD
 DtuYAx5kECGcTU0vEEdJNthACGAG3EiHfTyBamF8yiXE65C2g3q6DJMcG
 tnq778i4F+jEWFiPre0oCweEHqPWdH5gYOxttxShOjlZSiwqi6BeaswQS
 7/QRzhhJwCaJHJqV7AoDKssADqiqgl6EKS6mJ86W+Km9GcUlETL+KQmlD
 FknC6JLfuXj1idb0ovX3Y3g+S63CEuTBrlANJGewxF16MgqTq8+QMXzqe w==;
IronPort-SDR: 5IdELy3fZDEuGMnX2FdSzodKN6lt6uLFZgFL8/AkgZ5QsX806wY2Dt2csehUa38C+oiWitq5aq
 zRPmH5Nj3X46dO3bsv8UJvadQCGWT3znm1YT8mt3sr/LszrQrXHZKKexfL7zQsEXzaMnYMdm49
 qiCRlD+pYn9TyC9TA/pKBQBO/n2FfijLZ2FbUcgcn+KOXY3j01sjdfCfS/dzzoiTOuCHtJo3V7
 PSKNEQsDiuoe+s6gn7lFWhyQntMgFks8c+sYLKAnFEvEll2krnjJORzvM/bvDJydZ9KcH89oNK
 nOE=
X-IronPort-AV: E=Sophos;i="5.64,283,1559491200"; d="scan'208";a="118288552"
Received: from mail-co1nam05lp2053.outbound.protection.outlook.com (HELO
 NAM05-CO1-obe.outbound.protection.outlook.com) ([104.47.48.53])
 by ob1.hgst.iphmx.com with ESMTP; 20 Jul 2019 02:19:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GmWS/l7jjWkUMVlgLf9sq2mqjkYJgxHPln5ev5+HTwnjVa+nCdu7dZrJOnI21YLiOw4QR0TffpjKc/jSFRds+CsG5xptD+2+VNA2qMNps9WtoYsQgSfk/c+6PZvkwMSaNEz89rVotv68BGWkuqdSsmISAYj/PBZ1KIaKP1rwCfQymfUJqXHOs8SRVeE52wi6RdIz9Dq5V2Xdc0MwTdnDtju9DRbRxk6i5bmqfKtfwdKrADQZW2XQErltNxgFHBFPuVadnFT91otsedfqRNvR+htIWAvoJVELnb5u5Wy60d+2iAgqgioEZvvTNFwOqLx5nqwYdz0uKKckIlUxxmGJsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7jothu2p0kGYlAe/UHY0iGomUtTKMMCaWOI0lAXSeiQ=;
 b=GWD3F47jsoZWhS5fauBF9TSmNvAXhXYjyowEJ0aup6kOxG4h9joyytkkV/FzZ5gFAuqZNiEPaPun3cP5j6nt8Ru6/JAqyXNj38lHaxMH5AVTKTyFMAYKIWwxGcUw6q6D6TikX900QGdwAC9Au/kectNyMBvFrRKx+vDVBBF4SkZ2+CFCRIxxog5Fp4cpRiNeq0G2dfvjVvGXMGZ9cygnCukeE8CsGKkKS4PZcSMEePAelxhnLPQ6lkqZRQqxaM88N0qo2tg4WZlKyXnlBqVNX99pW45aAjB/KXTBUxpk4y1fcr6q68dGowOYHXMHSAqBplkPrNBfocEkfpSVVBTY3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=wdc.com;dmarc=pass action=none header.from=wdc.com;dkim=pass
 header.d=wdc.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7jothu2p0kGYlAe/UHY0iGomUtTKMMCaWOI0lAXSeiQ=;
 b=wp6E7GmN7cESqDtphE6trGvcG/IK9UZop0Q5/FcT1OcDlNdIyLp3VKKHygmmsoG98gXtX2FJ3tHTGMpVNAc9xVHAqwIWhCRpoGoHYxXgvHMK42F2SuIc48mSrBv8kZvbZPcFzNBdH1we6LvWe2meEgzAdhnwI75Ph0vyMhcKdbA=
Received: from CO2PR04MB2328.namprd04.prod.outlook.com (10.166.95.11) by
 CO2PR04MB2135.namprd04.prod.outlook.com (10.166.93.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.12; Fri, 19 Jul 2019 18:19:08 +0000
Received: from CO2PR04MB2328.namprd04.prod.outlook.com
 ([fe80::71b9:3203:b291:c971]) by CO2PR04MB2328.namprd04.prod.outlook.com
 ([fe80::71b9:3203:b291:c971%5]) with mapi id 15.20.2073.012; Fri, 19 Jul 2019
 18:19:08 +0000
From: Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Thread-Topic: [Qemu-devel] [PATCH] scsi-generic: Check sense key before
 request snooping and patching
Thread-Index: AQHVPgpSlUOkE37cUEqG4Uv96pacX6bSNgEg
Date: Fri, 19 Jul 2019 18:19:08 +0000
Message-ID: <CO2PR04MB2328B99442238BDC76D79FE6E1CB0@CO2PR04MB2328.namprd04.prod.outlook.com>
References: <20190719081632.12770-1-pbonzini@redhat.com>
In-Reply-To: <20190719081632.12770-1-pbonzini@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Dmitry.Fomichev@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 52c11743-968d-4a4d-ae74-08d70c75974f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:CO2PR04MB2135; 
x-ms-traffictypediagnostic: CO2PR04MB2135:
x-microsoft-antispam-prvs: <CO2PR04MB213553004F9CBEF8BD3DF3CDE1CB0@CO2PR04MB2135.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1107;
x-forefront-prvs: 01039C93E4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(396003)(346002)(376002)(136003)(366004)(39860400002)(13464003)(189003)(199004)(256004)(8936002)(7696005)(26005)(68736007)(8676002)(76116006)(102836004)(86362001)(186003)(76176011)(478600001)(14444005)(6506007)(25786009)(53546011)(33656002)(81156014)(7736002)(74316002)(476003)(81166006)(14454004)(99286004)(446003)(66066001)(305945005)(11346002)(52536014)(486006)(2906002)(4326008)(6916009)(316002)(9686003)(55016002)(53936002)(6246003)(6116002)(5660300002)(3846002)(54906003)(66476007)(66946007)(66556008)(64756008)(66446008)(71190400001)(71200400001)(229853002)(6436002)(41533002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CO2PR04MB2135;
 H:CO2PR04MB2328.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7Ej7Use+EfwFfzMhSUKN3DY7Zjbq4uJe9ju/EdxKk1rfEMXf1eFSI2iu5AQ6EFBKSV6Mq5LnPnacUKJix9qLKenXMjIBKPMONPXvHM45NNgg1O6HgKBNWRTqvzV2CjEuXzT9bYaNc7SNWuqfkorPpcKgoEh1BhAdP2ZkgDMcXFeeAiTEEDhshIXjlMO904ZCFGtPSVm5EUVwLOYgPSkV+1/h3A2lQVorJhJKY1nuwqejcWb2qeO8Zmls9W3cbyNLOxalZAV3MxZxRAaQ8Ic12LcHgh+r+eUflMPItQKRTiul6es0x3Y6DXMYoxUuKPlDB+WFtnYt0InwrNCRZlwvLOpTgLu4lQgnWmHkZ/GlvyRGY+GuY/tU/Z8HBb48x6CmEVmkNjcB3rRiVpsxXih1KzQ3xFjADKggWWC1QGYh/vg=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52c11743-968d-4a4d-ae74-08d70c75974f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2019 18:19:08.4333 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dmitry.Fomichev@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR04MB2135
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.153.141
Subject: Re: [Qemu-devel] [PATCH] scsi-generic: Check sense key before
 request snooping and patching
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
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo,

I've tested this version of the patch and it works fine.
Indeed, with this cleanup, the code is more straightforward and robust.

Dmitry

-----Original Message-----
From: Qemu-devel <qemu-devel-bounces+dmitry.fomichev=3Dwdc.com@nongnu.org> =
On Behalf Of Paolo Bonzini
Sent: Friday, July 19, 2019 4:17 AM
To: qemu-devel@nongnu.org
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [Qemu-devel] [PATCH] scsi-generic: Check sense key before request =
snooping and patching

From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

When READ CAPACITY command completes, scsi_read_complete() function
snoops the command result and updates SCSIDevice members blocksize and
max_lba . However, this update is executed even when READ CAPACITY
command indicates an error in sense data. This causes unexpected
blocksize update with zero value for SCSI devices without
READ CAPACITY(10) command support and eventually results in a divide
by zero. An emulated device by TCMU-runner is an example of a device
that doesn't support READ CAPACITY(10) command.

To avoid the unexpected update, add sense key check in
scsi_read_complete() function. The function already checks the sense key
for VPD Block Limits emulation. Do the scsi_parse_sense_buf() call for
all requests rather than just for VPD Block Limits emulation, so that
blocksize and max_lba are only updated if READ CAPACITY returns zero
sense key.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
[Extend the check to all requests, not just READ CAPACITY]
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/scsi-generic.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
index f07891b3f6..c11a0c9a84 100644
--- a/hw/scsi/scsi-generic.c
+++ b/hw/scsi/scsi-generic.c
@@ -254,24 +254,28 @@ static void scsi_read_complete(void * opaque, int ret=
)
=20
     r->len =3D -1;
=20
-    /*
-     * Check if this is a VPD Block Limits request that
-     * resulted in sense error but would need emulation.
-     * In this case, emulate a valid VPD response.
-     */
-    if (s->needs_vpd_bl_emulation && ret =3D=3D 0 &&
-        (r->io_header.driver_status & SG_ERR_DRIVER_SENSE) &&
-        r->req.cmd.buf[0] =3D=3D INQUIRY &&
-        (r->req.cmd.buf[1] & 0x01) &&
-        r->req.cmd.buf[2] =3D=3D 0xb0) {
+    if (r->io_header.driver_status & SG_ERR_DRIVER_SENSE) {
         SCSISense sense =3D
             scsi_parse_sense_buf(r->req.sense, r->io_header.sb_len_wr);
-        if (sense.key =3D=3D ILLEGAL_REQUEST) {
+
+        /*
+         * Check if this is a VPD Block Limits request that
+         * resulted in sense error but would need emulation.
+         * In this case, emulate a valid VPD response.
+         */
+        if (sense.key =3D=3D ILLEGAL_REQUEST &&
+            s->needs_vpd_bl_emulation &&
+            r->req.cmd.buf[0] =3D=3D INQUIRY &&
+            (r->req.cmd.buf[1] & 0x01) &&
+            r->req.cmd.buf[2] =3D=3D 0xb0) {
             len =3D scsi_generic_emulate_block_limits(r, s);
             /*
-             * No need to let scsi_read_complete go on and handle an
+             * It's okay to jup to req_complete: no need to
+             * let scsi_handle_inquiry_reply handle an
              * INQUIRY VPD BL request we created manually.
              */
+        }
+        if (sense.key) {
             goto req_complete;
         }
     }
--=20
2.21.0


