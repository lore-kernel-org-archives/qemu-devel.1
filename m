Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F429C43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 23:30:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40F8B2087B
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 23:30:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qqzhfUap";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="aPG3FC0I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40F8B2087B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55037 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLcCq-00049V-62
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 19:30:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34325)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=01690f4a8=Alistair.Francis@wdc.com>)
	id 1hLcAx-0002jy-7w
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 19:28:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=01690f4a8=Alistair.Francis@wdc.com>)
	id 1hLcAr-0005yR-V1
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 19:28:34 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:26534)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=01690f4a8=Alistair.Francis@wdc.com>)
	id 1hLcAq-0005xT-OI; Tue, 30 Apr 2019 19:28:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
	t=1556666913; x=1588202913;
	h=from:to:cc:subject:date:message-id:content-id:
	content-transfer-encoding:mime-version;
	bh=T/xKn24vyC5Aela/AlZ64lI9aov5QIYgrPEQ2JKy+s8=;
	b=qqzhfUapR8sZCgrUXtACYAoE3I4C5DGf38WZlc7h2pIda7dzNQLFJl6v
	D2NGobUpsD7hZNy7WubdBDd2UDYyirK/g1EiVKDk+JjiE58m/Qzgy4AsA
	mG0miZ/RabGuMescGpomRYILpWNFMwbceWULDm6U2grlrt7R0NZgY0Khq
	KGG2X5vfqQVbXz3hjtl/mNPRiyzPkvBTwOqNxmHFBQivuYJs6cqc0yQOJ
	wOFdxVcvhpYjo/LWnIyT3KmLSNJp42802ckbjvPN5pQ5TaR3bsfECmcRs
	Muv4gDcvQ4YVrzFnyY0cuxO4C5H8G4W+9PAwUC4/Z6Zj9dNfMMfKEXknL Q==;
X-IronPort-AV: E=Sophos;i="5.60,415,1549900800"; d="scan'208";a="108938896"
Received: from mail-bn3nam01lp2056.outbound.protection.outlook.com (HELO
	NAM01-BN3-obe.outbound.protection.outlook.com) ([104.47.33.56])
	by ob1.hgst.iphmx.com with ESMTP; 01 May 2019 07:28:14 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=T/xKn24vyC5Aela/AlZ64lI9aov5QIYgrPEQ2JKy+s8=;
	b=aPG3FC0IT6nZCyBsSQe55+pZc+k/yEJJeZ3K2w01BG1UFYx21P0Soc6fySiQtAsfO2spRLhcWDkinPbiYD0eGgJfGswcNWF2VkYasJforHCIFEfEgyLprWePBTAjQ9o5chOT2+e/JE5Bm5EbJoXEjwg5PIiA3veXiNT5FgUM5hc=
Received: from DM6PR04MB4908.namprd04.prod.outlook.com (20.176.109.81) by
	DM6PR04MB6217.namprd04.prod.outlook.com (20.178.224.88) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1856.10; Tue, 30 Apr 2019 23:28:12 +0000
Received: from DM6PR04MB4908.namprd04.prod.outlook.com
	([fe80::9ba:6028:ae27:7d2]) by DM6PR04MB4908.namprd04.prod.outlook.com
	([fe80::9ba:6028:ae27:7d2%2]) with mapi id 15.20.1835.015;
	Tue, 30 Apr 2019 23:28:12 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH v2 0/5]  Fix some GCC 9 build warnings
Thread-Index: AQHU/6xgW3B+r1/gpUmA4yLC4ecMXg==
Date: Tue, 30 Apr 2019 23:28:11 +0000
Message-ID: <cover.1556666645.git.alistair.francis@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.21.0
x-clientproxiedby: BYAPR01CA0038.prod.exchangelabs.com (2603:10b6:a03:94::15)
	To DM6PR04MB4908.namprd04.prod.outlook.com
	(2603:10b6:5:19::17)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=Alistair.Francis@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b66b7234-f4da-4da7-f59f-08d6cdc382b9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);
	SRVR:DM6PR04MB6217; 
x-ms-traffictypediagnostic: DM6PR04MB6217:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <DM6PR04MB6217A3D95CBBB74168BB9416903A0@DM6PR04MB6217.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 00235A1EEF
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(366004)(39860400002)(136003)(346002)(376002)(396003)(199004)(189003)(5640700003)(8936002)(6436002)(53936002)(73956011)(316002)(4744005)(54906003)(14454004)(81156014)(6486002)(6916009)(81166006)(68736007)(8676002)(186003)(26005)(3846002)(66446008)(6116002)(66476007)(64756008)(7736002)(6512007)(66946007)(305945005)(102836004)(2906002)(66556008)(5660300002)(386003)(6506007)(66066001)(44832011)(2501003)(2351001)(50226002)(478600001)(36756003)(486006)(476003)(2616005)(4326008)(52116002)(14444005)(99286004)(71190400001)(71200400001)(256004)(72206003)(86362001)(25786009);
	DIR:OUT; SFP:1102; SCL:1; SRVR:DM6PR04MB6217;
	H:DM6PR04MB4908.namprd04.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: DIoeynHlIB4AAznrcIY+kDHrbgEYbDJ2pU0jj/9sA5IEOoZwqC2Y46ueKr/18FQIzvBsK/+v/sXaMM74e2T0Fu63Y4wf5HI4kfgAIHY7tzz/IzQr+VsbnvD+jXLN8FotSdoVw8ipmJ1VZc7DartBUDE1Io6hGowj9CPdESd50EEs9OvUwxWbL7x953E+VQqebkdhaj0ma1k7fBUusvRpE/xxjRNW4q3n1cpDQiQflFTx35aEo2JeLtawKGWygxCQgzxI3L9t7snSDOvt1w9fYEjLdji5MZFIU8QoJKQ48ieV8vKH4XMFKR7w+LuT6NodIR1xTIfx88a6+be14KFSGBXQuaA9dCclRh0g5vQRo+l2z86trDd3fjvAnLRLhUzHzERspIg3aWVOMmdr0xA4jcGpd2stfQk5tk5E00ZSBNE=
Content-Type: text/plain; charset="UTF-8"
Content-ID: <65FD29ACA569E7458772696939AF5CB4@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b66b7234-f4da-4da7-f59f-08d6cdc382b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2019 23:28:11.8908 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6217
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 216.71.154.45
Subject: [Qemu-devel] [PATCH v2 0/5]  Fix some GCC 9 build warnings
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
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
	"riku.voipio@iki.fi" <riku.voipio@iki.fi>,
	"laurent@vivier.eu" <laurent@vivier.eu>,
	Alistair Francis <Alistair.Francis@wdc.com>,
	"kraxel@redhat.com" <kraxel@redhat.com>,
	"alistair23@gmail.com" <alistair23@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430232811.0exZdXsLuEUD7m8Lf9muF72lqjkpl4hkkdM91jtelfw@z>

djI6DQogLSBSZXdyaXRlIG1vc3QgcGF0Y2hlcyBiYXNlZCBvbiB0aGUgZmVlZGJhY2sgZnJvbSB2
MQ0KDQpBbGlzdGFpciBGcmFuY2lzICg1KToNCiAgdXRpbC9xZW11LXNvY2tldHM6IEZpeCBHQ0Mg
OSBidWlsZCB3YXJuaW5ncw0KICBody91c2IvaGNkLXhoY2k6IEZpeCBHQ0MgOSBidWlsZCB3YXJu
aW5nDQogIGh3L3VzYi9kZXYtbXRwOiBGaXggR0NDIDkgYnVpbGQgd2FybmluZw0KICBsaW51eC11
c2VyL3VuYW1lOiBGaXggR0NDIDkgYnVpbGQgd2FybmluZ3MNCiAgbGludXgtdXNlci9lbGZsb2Fk
OiBGaXggR0NDIDkgYnVpbGQgd2FybmluZ3MNCg0KIGh3L3VzYi9kZXYtbXRwLmMgICAgIHwgMTMg
KysrKysrKysrKysrKw0KIGh3L3VzYi9oY2QteGhjaS5jICAgIHwgIDEgKw0KIGxpbnV4LXVzZXIv
ZWxmbG9hZC5jIHwgIDIgKy0NCiBsaW51eC11c2VyL3VuYW1lLmMgICB8ICAyICstDQogdXRpbC9x
ZW11LXNvY2tldHMuYyAgfCAgNCArKy0tDQogNSBmaWxlcyBjaGFuZ2VkLCAxOCBpbnNlcnRpb25z
KCspLCA0IGRlbGV0aW9ucygtKQ0KDQotLSANCjIuMjEuMA0KDQo=

