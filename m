Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 965FBC76191
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 03:38:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EEC12080A
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 03:38:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="GOJJLM/z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EEC12080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnEIS-0006pN-Na
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 23:38:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53554)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alxndr@bu.edu>) id 1hnEI9-0005kR-Qa
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 23:38:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1hnEI8-00066Q-M7
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 23:38:13 -0400
Received: from mail-eopbgr710128.outbound.protection.outlook.com
 ([40.107.71.128]:26160 helo=NAM05-BY2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1hnEI8-000656-FZ
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 23:38:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dD5ZhE35OxaaAU2zeErGwpLrWHpi1ZZz0Y4/asmMIXT0HLBBN24ZXQF/jjDX2BYk3sQ353RaP8dnMOV3igysXVYx3J+HjQpWGb/EX+eB7RbsvRrBtar26Mfr79Amu1Qf/UdLhTEBD3+P7mywlMzcu1QAPHmVtJBJkyCqLF4I2YG/Tv39RSq9p2itiUEHtqpe/AzBzlKhCW0FgWxmQV4zbV2A6uxFvTDdfUrqZmImOXbfjJJOUHBwlVfnByVKU/EQIe9/g016OeaaS3tedFv+q0zqYu8A/DhyYARt6NX1+d5YIe1zdpr00FtLVdn6jC2M6hAUX0m7n8GX9BRiYcFs7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V05TLyfvESaYPBK5GrkJ49y59OK0ZNLtq+mwYBL6oi4=;
 b=TcJHEt6Wr3uH19GiQEUgzUCw4enGnTPKXh156+vsC/aIWaWllM6eE6xiQR/yV5cwIQX/O6Qz09j648MemU+whureqa6ax9Y4zpjOalAkeZrA8oEzOR0As6IZQgGmFOxOE4BMhc81HN4fDfO/5Jdi6dxeCJ9tVslDpBcPxv25CdtM0BvhVq7Z82hBJu9xOmZbMMTU1HehZFNPusLbIDrFo1UfbxqPHx5jWVlEyV64+BFBwPNxx4IgIGjRSFOfPg5X/BGgaH7MJMATOmCO/AQlgtGmkVUSGKFEHjll5mkSyr4ELxZauRSFPa3utQdWp5sNShtcymmhQn4Yilwmj19WqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=bu.edu;dmarc=pass action=none header.from=bu.edu;dkim=pass
 header.d=bu.edu;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector1-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V05TLyfvESaYPBK5GrkJ49y59OK0ZNLtq+mwYBL6oi4=;
 b=GOJJLM/zYwlSP68So0k9XxrmJrtZ6DsvIhnsdqWLUrLl3p0mmemlp5A2/amJBF3fIAu6+Wkc+JdPrh7Dwa7v+U0ufqIbINLNTahSjeDFS1Z6VdSZaKmmS7XuW2FfXbikGkXQ8lXo0cx3gGX7E9PrLGy39pHaUTbzYtBnpHYV5V0=
Received: from CY4PR03MB2872.namprd03.prod.outlook.com (10.175.118.17) by
 CY4PR03MB2775.namprd03.prod.outlook.com (10.173.39.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.14; Tue, 16 Jul 2019 03:38:10 +0000
Received: from CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::25e1:d1e3:2ad8:e6b5]) by CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::25e1:d1e3:2ad8:e6b5%5]) with mapi id 15.20.2073.012; Tue, 16 Jul 2019
 03:38:10 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH 1/1] virtio-net: check guest header length is valid
Thread-Index: AQHVO4fjNKKNMvAfK0qcvG3HVUxegw==
Date: Tue, 16 Jul 2019 03:38:09 +0000
Message-ID: <20190716033719.2866-2-alxndr@bu.edu>
References: <20190716033719.2866-1-alxndr@bu.edu>
In-Reply-To: <20190716033719.2866-1-alxndr@bu.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.20.1
x-originating-ip: [128.197.127.33]
x-clientproxiedby: BL0PR02CA0144.namprd02.prod.outlook.com
 (2603:10b6:208:35::49) To CY4PR03MB2872.namprd03.prod.outlook.com
 (2603:10b6:903:134::17)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3a1b046d-1f84-458c-83ec-08d7099f05c5
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:CY4PR03MB2775; 
x-ms-traffictypediagnostic: CY4PR03MB2775:
x-microsoft-antispam-prvs: <CY4PR03MB27753255B20D11140938D35FBACE0@CY4PR03MB2775.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 0100732B76
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(366004)(346002)(39860400002)(136003)(376002)(396003)(199004)(189003)(71200400001)(71190400001)(2906002)(88552002)(50226002)(14454004)(36756003)(52116002)(66556008)(68736007)(25786009)(66476007)(6506007)(66446008)(64756008)(8936002)(6916009)(81156014)(81166006)(478600001)(99286004)(53936002)(75432002)(1076003)(6486002)(305945005)(66066001)(5660300002)(54906003)(316002)(26005)(5640700003)(486006)(6512007)(7736002)(386003)(3846002)(86362001)(786003)(6116002)(2501003)(8676002)(66946007)(256004)(6436002)(4326008)(14444005)(102836004)(76176011)(186003)(2351001)(11346002)(476003)(446003)(2616005)(42522002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CY4PR03MB2775;
 H:CY4PR03MB2872.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: N94Ay6h636yLmnuga8ynmzqtzOxb2b6LXwszNzJ74VceGF7M048vPZS6QvbusZ/ck13X7DVdzM9jNMDSpXlbKqXoTntV5Xc7Kq3F2bffoVX5kVYbsTmUxmZU7AYbOkvbmkUYoS2j8Gs+PZIs2p0bwHNsw0ZPTcMzXxh7m6Pz/rbr+JYSKvBCPkQ/P70yWVsQarWDPM7AgFXOATdM/qXFvndwXbPwcBA2jS3HX957PKx6vItse3ZqDQzuPoeEw52P31Zu/HumfhYI8+D6lF59aO0HdkGluMtcYC5el7jsLR5gh793euS/ZMzX1bLTcSXIsVUg2/yIeSzZW6LZZPUUCyCZZmfOd/ZZPlVDlszVDsxLisx6PZwOQshQzrZdIeDo1Lw4+tOci7p2IXGLtEFY+RX2sP9UxqKiixGLTGAxXtg=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a1b046d-1f84-458c-83ec-08d7099f05c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2019 03:38:10.0373 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: alxndr@bu.edu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2775
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.71.128
Subject: [Qemu-devel] [PATCH 1/1] virtio-net: check guest header length is
 valid
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
Cc: "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "Oleinik,
 Alexander" <alxndr@bu.edu>, "bsd@redhat.com" <bsd@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

virtio-net checks that the "out" sg is longer than the guest header, but
this check can be skipped if has_net_hdr is 0. Also perform this check
if host_hdr_len !=3D guest_hdr_len

Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
---
 hw/net/virtio-net.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index b9e1cd71cf..46d715b4f5 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -2064,7 +2064,18 @@ static int32_t virtio_net_flush_tx(VirtIONetQueue *q=
)
          */
         assert(n->host_hdr_len <=3D n->guest_hdr_len);
         if (n->host_hdr_len !=3D n->guest_hdr_len) {
-            unsigned sg_num =3D iov_copy(sg, ARRAY_SIZE(sg),
+            unsigned sg_num;
+
+            if (!n->has_vnet_hdr) {
+                if (iov_to_buf(out_sg, out_num, 0, &mhdr, n->guest_hdr_len=
) <
+                    n->guest_hdr_len) {
+                    virtio_error(vdev, "virtio-net header incorrect");
+                    virtqueue_detach_element(q->tx_vq, elem, 0);
+                    g_free(elem);
+                    return -EINVAL;
+                }
+            }
+            sg_num =3D iov_copy(sg, ARRAY_SIZE(sg),
                                        out_sg, out_num,
                                        0, n->host_hdr_len);
             sg_num +=3D iov_copy(sg + sg_num, ARRAY_SIZE(sg) - sg_num,
--=20
2.20.1


