Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 149DDC0650F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 14:25:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D499F205C9
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 14:25:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=live.com header.i=@live.com header.b="oXpRwVtT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D499F205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=live.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsT45-0000pA-3v
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 10:25:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34882)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <n.b@live.com>) id 1hsRBG-0004y1-2r
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 08:24:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <n.b@live.com>) id 1hsRBE-0001Xi-Lt
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 08:24:38 -0400
Received: from mail-oln040092255035.outbound.protection.outlook.com
 ([40.92.255.35]:39760 helo=APC01-HK2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <n.b@live.com>) id 1hsRBC-0001Vy-KM
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 08:24:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PNCaUW9cjqXeg8pc5Dth8MIRJKyWvByL/N8K3WxI8JeP3a5mw+BHYwCF65LpD6tcreTN/Is/FQxrc+2IGkZiHmA3meFST9YmVRrCTsAqpRiWEFurahQz+6CH6RB6NfedYPZg8vmQmsqrn5oWnZf8DL8flU9NGL8+bjzrNI97xUoQo1vZimLCyO9Spx7uENTMebG93gycq1Qgt98DEmcpVZZMnNJKpGEyXX1SloYe9CohxGaFGW78jeJb2cQKwzedlaZTvdZfSjRUEKUrwJ41rl1jHZI/FpXiv9fma6fTqeK5+ve+F0O+1sQCd14rwww1fZ9RffdOvLysE38y4o82XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iShaAA3YrnlJdh2VyCNuOsHB07aX8uvYhw7FBw4PnEQ=;
 b=HPRBFb4wUE4qtkztJSAeTupCloZcpEL7y+2X2eHNFoPFiBMVos+G4HFaA/Vp2DdzN0sWrMtTp9jqqCioEanMgIFXkddFHsZ7DMjmcT+sD/Y4cyaVQe0H37KFjUKphVWn888ejNIq/x+n+7VnHKxmqsjXwCmft4QWQCx8JUwmUu3pfm8mv1KaiPzNtfRN6HCEKuLDD6XPo6bdUBs4uCb24Cli166fwHUUJ2sNfv7xg3C20YlBls9NhJIylhhgWRXjdaWQzWsxX9fgEsy0l5O5cVEI+f7u16yPCC0LiUClBU7vU3O4/l4rmMqp+u1UE9BTCMq0t7zGF6zRL1ZlbcsPWw==
ARC-Authentication-Results: i=1; mx.microsoft.com
 1;spf=none;dmarc=none;dkim=none;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iShaAA3YrnlJdh2VyCNuOsHB07aX8uvYhw7FBw4PnEQ=;
 b=oXpRwVtTF8JGPuPXfk1MNB6ZFBXcwutdkl9j48WyNi2JwLqOJxQ+BDNTAYwjX2cF9aE8hxHKVx6OXIs/UIRdEDJx0fqna0UGkc0xw0IrXUQ4VfR+CkkSu9rXo5E+uMLIfvnFm1883Fg6fLhvoPV/Jpt5wbft07E0JuGI38ZkOjk2yNj3yyrw3wi3ZGhYjE0CKh51BSbGgAqDUBL16Q6hCW0BHV3Q4jxMlKeWcdSUMNRH3xDLCQscKPH/nLTJqGozwc8f6r2g9mmAmlYWbMaeDfm+ZhQRhEo1eAzf+YTIlEWmM1dZ5ATTEEs5MrxNbZXRuclR7REsuyRyLG3EUBNwxQ==
Received: from PU1APC01FT034.eop-APC01.prod.protection.outlook.com
 (10.152.252.57) by PU1APC01HT240.eop-APC01.prod.protection.outlook.com
 (10.152.252.254) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2115.10; Tue, 30 Jul
 2019 12:24:28 +0000
Received: from HK2PR04MB3859.apcprd04.prod.outlook.com (10.152.252.52) by
 PU1APC01FT034.mail.protection.outlook.com (10.152.252.218) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.10 via Frontend Transport; Tue, 30 Jul 2019 12:24:28 +0000
Received: from HK2PR04MB3859.apcprd04.prod.outlook.com
 ([fe80::b166:438b:3d6e:85e2]) by HK2PR04MB3859.apcprd04.prod.outlook.com
 ([fe80::b166:438b:3d6e:85e2%3]) with mapi id 15.20.2115.005; Tue, 30 Jul 2019
 12:24:28 +0000
From: "N. B." <n.b@live.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "eblake@redhat.com"
 <eblake@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>
Thread-Topic: [PATCH] vhost-vsock: report QMP event when set running
Thread-Index: AQHVRtG7Y9n+2snBfUCgQknIGxrcZw==
Date: Tue, 30 Jul 2019 12:24:27 +0000
Message-ID: <HK2PR04MB38595779EA521C94675599F981DC0@HK2PR04MB3859.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK2PR02CA0202.apcprd02.prod.outlook.com
 (2603:1096:201:20::14) To HK2PR04MB3859.apcprd04.prod.outlook.com
 (2603:1096:202:3a::16)
x-incomingtopheadermarker: OriginalChecksum:EDE0E77CC00E5B19A40A4DF39D5DE4F831C519E75CC856AB5D1DD3F85CB98DD6;
 UpperCasedChecksum:49A4D318796BF5531B1D1ED0962576BFD9D9EA151813B72828B42D95936528BF;
 SizeAsReceived:7422; Count:48
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-tmn: [sGJBzJ7ifeciIMEvrYnwYM3sFATIjs4s]
x-microsoft-original-message-id: <20190730122420.16402-1-n.b@live.com>
x-ms-publictraffictype: Email
x-incomingheadercount: 48
x-eopattributedmessage: 0
x-ms-exchange-slblob-mailprops: V5pmAly6juh8YHF2oByQz217JhIMmjFrB907NPBF3dccJnokBnnY3AAUodmP5hB0xCdtXs9fkrypgtMNfzcmHWnRy3wB+6Hlkh5CbtujlVHYPCwlszHP8a0MXjRcelsALV8PreNci9INzzBw0x3xRKPZeNGWpmnmnImskpfBvUfNVJeXJYk5anurwGYYgSWo2IqI4e0FYFHHHP56tMDj0flNaPqKdbh7e1+YVQIFlNsACmSGk5msvwMjt5h7IfVMr5ZkUXX6g6ivu3ew4KzTmHqUCRbA1+/z6w+oC4n/RxwFZakHsy/sVDay4c5YjpDVhZlZXDGQ4JCnKwWbfHD+nCfy3jv3rUjARqmtHOxbKOjtf6x3dQ0+djywNskdZo3zekyxrGd37Kclaqdh8sl09WUaP8W5N9+GihSf9nb3l8oPzCbNeV0FhSqXsI+goBNpPCuUbbWBZlMNcSkD0TdsjDE3+7RlzK8A7ZLP/9UGoIA5e/eb47h0FyqwfuRXNNnEEckFZCCt9XfMKGBG7yQMjMin1lReN++jIF3FI/OPd+ISLLJX5a00tdzOqljH1kjc4/fe5AmN+8nrr1Vn2xU6hMwInUX50UqyIpF013CAFwYcXbKCbBl46DeIJaYuNchO/xgMVvxMCj7UmwmvnmteFvI9xvf+52RnLz5XxDzXa+oGlJkzBDI925TW9XIxV9RfjCdNhKQupp84/4Cl7aQycpqxEQvt/O776KCAsS00Qz2j1JucDxgYktp0GdEPsEBSoP7X0Q2hhmSDdeLMke3G6nV2NkvqaDvLGb5vlxIvoss=
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(5050001)(7020095)(20181119110)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(201702181274)(2017031323274)(2017031324274)(2017031322404)(1601125500)(1603101475)(1701031045);
 SRVR:PU1APC01HT240; 
x-ms-traffictypediagnostic: PU1APC01HT240:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-message-info: 2YLDphSTHH1V40pFM1EwMMKYFjCtoIVYhggu9746kBQfH0m3xLT4EHqsA346u3ZfFz/5VzFCrgjklQMRZUGTjeqJJ366ZBDXlq1GSQAIt2/jli+RvzSnj+ORfZiMBkU7TCzgN/qGRZVnKLIOS6MP4yzo41/c7FD1juBWPbZjsLDa6pWguU9ZbMLuxl4DbWBc
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: live.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 27535aa5-db22-4763-b1e9-08d714e8dd7c
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2019 12:24:27.9827 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1APC01HT240
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.92.255.35
X-Mailman-Approved-At: Tue, 30 Jul 2019 10:24:25 -0400
Subject: [Qemu-devel] [PATCH] vhost-vsock: report QMP event when set running
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
Cc: "N. B." <n.b@live.com>, Ning Bo <ning.bo9@zte.com.cn>,
 "mst@redhat.com" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Ning Bo <n.b@live.com>

Report vsock running event so that the upper application can
control boot sequence.
see https://github.com/kata-containers/runtime/pull/1918

Signed-off-by: Ning Bo <ning.bo9@zte.com.cn>
---
 hw/virtio/vhost-vsock.c |  3 +++
 qapi/char.json          | 22 ++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
index 0371493..a5920fd 100644
--- a/hw/virtio/vhost-vsock.c
+++ b/hw/virtio/vhost-vsock.c
@@ -22,6 +22,7 @@
 #include "qemu/iov.h"
 #include "qemu/module.h"
 #include "monitor/monitor.h"
+#include "qapi/qapi-events-char.h"
=20
 enum {
     VHOST_VSOCK_SAVEVM_VERSION =3D 0,
@@ -68,6 +69,8 @@ static int vhost_vsock_set_running(VHostVSock *vsock, int=
 start)
     if (ret < 0) {
         return -errno;
     }
+    qapi_event_send_vsock_running(vsock->conf.guest_cid, start !=3D 0);
+
     return 0;
 }
=20
diff --git a/qapi/char.json b/qapi/char.json
index a6e81ac..0958dd1 100644
--- a/qapi/char.json
+++ b/qapi/char.json
@@ -570,3 +570,25 @@
 { 'event': 'VSERPORT_CHANGE',
   'data': { 'id': 'str',
             'open': 'bool' } }
+
+##
+# @VSOCK_RUNNING:
+#
+# Emitted when the guest be set running.
+#
+# @cid: guest context ID
+#
+# @running: true if the vsock be set running
+#
+# Since: v4.1.0
+#
+# Example:
+#
+# <- { "event": "VSOCK_RUNNING",
+#      "data": { "cid": "123456", "running": true },
+#      "timestamp": { "seconds": 1401385907, "microseconds": 422329 } }
+#
+##
+{ 'event': 'VSOCK_RUNNING',
+  'data': { 'cid': 'uint64',
+            'running': 'bool' } }
--=20
2.9.5


