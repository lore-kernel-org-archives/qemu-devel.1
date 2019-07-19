Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C91C7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 19:41:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4104A2085A
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 19:41:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="eGsFZzUc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4104A2085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoYki-0001eE-W1
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 15:41:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43629)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alxndr@bu.edu>) id 1hoYkQ-0000XT-2M
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 15:40:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1hoYkO-00021p-Gv
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 15:40:53 -0400
Received: from mail-eopbgr790101.outbound.protection.outlook.com
 ([40.107.79.101]:1152 helo=NAM03-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1hoYkN-0001aE-Q0
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 15:40:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X3HrNqB7U4xBG9QDOg3kYiE/z/1Sj5QRDZTMQWW9AM7T34fsz9Kt0WvyiClWUUmwpY7IJSraHuuSnqWzjm6JjQwaKupL3sQknShyaKhOGPDCoypautSXV/eGWsveihyfTtlTLeHzbBnq4TKyK8aIaFkdmlrRf1x/agIVguf+qiUei0gwuv654ds2hRgrWmB5FnE3v+DPiM6Ta2259AikNHPiwtFTEAyUx5Ba/cXmb5wL670HHYhwO9dqVbOKz6vlTePKT3wRjbH1S51aCbHB9X+Ug1E7bocVGn6sDnEjAP5Ig8YLlzaYbTHJG1fnHrOtNa8v8IN5Ag7dWlokuz8QdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ok+eCycc9CSSwvwyMltlEx3Nn6KUMUUqeqv64dBoap0=;
 b=Xzis7XKbf/jf3leQEZNIWajn0caEHx1s0IM31cH734lBEow1t8J5QplnkOBYDO1dorVmpnwImWlhVoIqnvop9axx/Fbh9ru0u1hG24JjmjPRozEDMPwljFhc3orVZTBWghP3zMxydkWq1XrQu1f4/VyGvhsczh9q6WR9Kkcqd6qgRyhtjZy2+JOX5QIqgTGfwFnY743cpfwlROH5moq4SkaQiPKI1VgAKQOZilY9RrwU77dVdeMjxQLLioWjhJCTgrLuWZAQfN36bGcpW+2qCDhEJ54LXOE0g3VzRj1Tfc+cQ2gh/oPGe+g28bcKQlOBHgDg4E4L1b7bKHHiAULTCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=bu.edu;dmarc=pass action=none header.from=bu.edu;dkim=pass
 header.d=bu.edu;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ok+eCycc9CSSwvwyMltlEx3Nn6KUMUUqeqv64dBoap0=;
 b=eGsFZzUcJIc00U2BskceGwR9XFUyciKHVuIDXpYdRQ+ogug32SY3/Pw41Yof6Bk3aJLLaDuu6RND9l32gT6pmfm3qzHgAbrafFdiUT9EPfXG3nqjd9iQbUe2F/w+STyhH5QDv1n2U4NfkchZx494ezUoF0hwCC5tjqt6Zmgx9yQ=
Received: from CY4PR03MB2872.namprd03.prod.outlook.com (10.175.118.17) by
 CY4PR03MB2743.namprd03.prod.outlook.com (10.173.38.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.14; Fri, 19 Jul 2019 18:52:30 +0000
Received: from CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::25e1:d1e3:2ad8:e6b5]) by CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::25e1:d1e3:2ad8:e6b5%5]) with mapi id 15.20.2073.012; Fri, 19 Jul 2019
 18:52:30 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH 2/2] virtio-net: check that tx packet has positive size
Thread-Index: AQHVPmMeO1Tw3DLTS0qwu0faMxYPBQ==
Date: Fri, 19 Jul 2019 18:52:30 +0000
Message-ID: <20190719185158.20316-3-alxndr@bu.edu>
References: <20190719185158.20316-1-alxndr@bu.edu>
In-Reply-To: <20190719185158.20316-1-alxndr@bu.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.20.1
x-originating-ip: [128.197.127.33]
x-clientproxiedby: MN2PR20CA0006.namprd20.prod.outlook.com
 (2603:10b6:208:e8::19) To CY4PR03MB2872.namprd03.prod.outlook.com
 (2603:10b6:903:134::17)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2fe2fa7f-2b12-49d8-4e90-08d70c7a408a
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:CY4PR03MB2743; 
x-ms-traffictypediagnostic: CY4PR03MB2743:
x-microsoft-antispam-prvs: <CY4PR03MB27436FFFB4886A3FB575527BBACB0@CY4PR03MB2743.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 01039C93E4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(39860400002)(396003)(376002)(346002)(366004)(136003)(199004)(189003)(8676002)(88552002)(2906002)(102836004)(99286004)(305945005)(76176011)(6506007)(7736002)(8936002)(6512007)(386003)(66556008)(81166006)(6486002)(75432002)(5660300002)(2501003)(52116002)(71200400001)(478600001)(71190400001)(5640700003)(81156014)(66066001)(53936002)(6916009)(1076003)(25786009)(2616005)(36756003)(486006)(64756008)(6116002)(66946007)(26005)(66446008)(86362001)(3846002)(68736007)(66476007)(2351001)(6436002)(316002)(50226002)(476003)(446003)(54906003)(4326008)(186003)(786003)(11346002)(14444005)(256004)(14454004)(42522002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CY4PR03MB2743;
 H:CY4PR03MB2872.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: l8WS4rQ5/wkPoFP1oOWCbcE6yUYRqZuWD2BC9q4MxcGWVJk7cUgKaHSYj3VOnOEW1QY308DyliAflK9gek8GHVt7rsPhlQgj1cmSSMwv5L/dgPg28tOU+ASYLgRdff0cNgWOjmWAUEKZ0EnAPBErFojMQTOBTC7T4+a297tIgSm3UXd8qeqe7Y9bMzgCmHghna/k+mQoW2G3jl7bHTcb4gApXegqU/YvOW1AuS9VNssH94Pecn33WcVd1vs4w9F7omw5e0BOx/VeYZ3OR+XSBcoTBj2VZL9euVfnXzxjyws33/BwcgIbFCC4ZtUxYpVN4CtSIZd6TGulUCx0rQKHH2UmizxvQTxc1mt1jtF1fpC5E9XLZIgmYDayDryBaZMkk7Y5UnhJlsjQcL1eq0jJX3bJSHD6cVacsauRss1ja4A=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fe2fa7f-2b12-49d8-4e90-08d70c7a408a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2019 18:52:30.5913 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: alxndr@bu.edu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2743
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.79.101
Subject: [Qemu-devel] [PATCH 2/2] virtio-net: check that tx packet has
 positive size
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Oleinik, Alexander" <alxndr@bu.edu>, "bsd@redhat.com" <bsd@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

virtio_net_flush_tx does not check that the packet size is nonzero,
which causes q->aysnc_tx.elem to be set. Then, when the device is reset, th=
ere
is an assertion failure since q->aysnc_tx.elem must be flushed/cleared.
Zero-sized packets are unsupported - check packet size, prior to
sending.

Found while fuzzing virtio-net. The relevant stack-trace:
 #8 in __assert_fail (libc.so.6+0x30101)
 #9 in virtio_net_reset virtio-net.c:520:13
 #10 in virtio_reset virtio.c:1214:9
 #11 in virtio_pci_reset virtio-pci.c:1810:5
 #12 in qdev_reset_one qdev.c:259:5
 #13 in qdev_walk_children qdev.c:575:15
 #14 in qbus_walk_children bus.c:52:15
 #15 in qdev_walk_children qdev.c:567:15
 #16 in qbus_walk_children bus.c:52:15
 #17 in qemu_devices_reset reset.c:69:9
 #18 in pc_machine_reset pc.c:2628:5
 #19 in qemu_system_reset vl.c:1621:9
 #20 in LLVMFuzzerTestOneInput fuzz.c:184:4

Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
---
 hw/net/virtio-net.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index b9e1cd71cf..743f1c827c 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -2074,12 +2074,15 @@ static int32_t virtio_net_flush_tx(VirtIONetQueue *=
q)
             out_sg =3D sg;
         }
=20
-        ret =3D qemu_sendv_packet_async(qemu_get_subqueue(n->nic, queue_in=
dex),
-                                      out_sg, out_num, virtio_net_tx_compl=
ete);
-        if (ret =3D=3D 0) {
-            virtio_queue_set_notification(q->tx_vq, 0);
-            q->async_tx.elem =3D elem;
-            return -EBUSY;
+        /* Do not try to send 0-sized packets */
+        if (iov_size(out_sg, out_num)) {
+            ret =3D qemu_sendv_packet_async(qemu_get_subqueue(n->nic,
+                        queue_index), out_sg, out_num, virtio_net_tx_compl=
ete);
+            if (ret =3D=3D 0) {
+                virtio_queue_set_notification(q->tx_vq, 0);
+                q->async_tx.elem =3D elem;
+                return -EBUSY;
+            }
         }
=20
 drop:
--=20
2.20.1


