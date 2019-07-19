Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C2F2C7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 19:41:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF5162085A
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 19:41:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="s5xs9+jb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF5162085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoYl0-0002sg-V4
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 15:41:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43783)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alxndr@bu.edu>) id 1hoYkj-0001wB-8n
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 15:41:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1hoYkh-0002Ft-Ln
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 15:41:12 -0400
Received: from mail-eopbgr780138.outbound.protection.outlook.com
 ([40.107.78.138]:48124 helo=NAM03-BY2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1hoYkh-0001wF-3C
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 15:41:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mNZJc20oYN9eGCOncLaoqZuaskKzaF++k8NRzSaq8YytSQcylIhBo3SKac+jT1n8gyLX/wGRxCJl/qQgs53cJBW2daH7U2q56doFq9Ou89scxuHa69j1QGSqYur8wVSM9JaYHNCDSzD5cO4/GNuDOhzt/ZhfWMsoeU6BM9TacwGBGc/K//ZixvRT522FKWKtAom7VJDdHLTuFp7pqJuBPluHN9pzCLwJ+HBiIlbeC07dLrWTvGLfQjmclh4iNbZyQUMWBL9jjir2atxMweHT4+YjWhf/EF1/JnlgAm5EYvxNDss+1Sw/sfhmKgTK8GFF1XPEJxYUzXurCHrR4/Zeyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rk4exrzpUoE+6Dj576KcLtsYcVYMAsYXYGRd4mb7aOM=;
 b=KqzpOomi+7bAiUvUFnjNLrliCFPgUu69VkRH0R2eWKo+AHMTvy5x6amAgVeDAA92Wqcu8sW2A+rHlvOAjH2qrJehPc4NTnpB6rHf4v2x3pslhmww1ghL9Xr7NzMKuaaXKqpDPypRvgIOtlvwL59OQaeDjnPWgxUausYcEesN/3ZC8hJv9IMPFNnQPmxkViOpr6CNo2H+NhxDXWBq4ihLbMpKgGiOaenqZ096AEGBNcerhWxof4eqZenfpmjhkpLBxtXS5WqGtzkhPNQQBjOpfKziGIQ0Rp84Kk09JbTuolka/MGEfPfm0KtwQIM2l0hJ1lORPDQjuCIoV3lv0O47vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=bu.edu;dmarc=pass action=none header.from=bu.edu;dkim=pass
 header.d=bu.edu;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rk4exrzpUoE+6Dj576KcLtsYcVYMAsYXYGRd4mb7aOM=;
 b=s5xs9+jbioYeJlUiY44q1ivoyL6JxO73MsvsigSKJ0vs1mCUQcyP1x5HcVss3rYd2o+HqWODCRrrIsYzZDh0trA8J62+xklfwFVBKWrbU/gyl+6DxezK6sPPVQ8/vwJgrTjXvbhtHClbUcEw1LcPzwmmec219NS7cE84d/dLsLg=
Received: from CY4PR03MB2872.namprd03.prod.outlook.com (10.175.118.17) by
 CY4PR03MB2743.namprd03.prod.outlook.com (10.173.38.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.14; Fri, 19 Jul 2019 18:52:16 +0000
Received: from CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::25e1:d1e3:2ad8:e6b5]) by CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::25e1:d1e3:2ad8:e6b5%5]) with mapi id 15.20.2073.012; Fri, 19 Jul 2019
 18:52:16 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH 0/2] Avoid sending zero-size packets
Thread-Index: AQHVPmMVUQvoRvjqGkGWcL5/T8/Mmg==
Date: Fri, 19 Jul 2019 18:52:15 +0000
Message-ID: <20190719185158.20316-1-alxndr@bu.edu>
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
x-ms-office365-filtering-correlation-id: 4cd421bd-9119-4d99-9a09-08d70c7a37cd
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:CY4PR03MB2743; 
x-ms-traffictypediagnostic: CY4PR03MB2743:
x-microsoft-antispam-prvs: <CY4PR03MB27430E577BED8264995B65ADBACB0@CY4PR03MB2743.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 01039C93E4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(39860400002)(396003)(376002)(346002)(366004)(136003)(199004)(189003)(8676002)(88552002)(2906002)(102836004)(99286004)(305945005)(6506007)(7736002)(8936002)(6512007)(386003)(66556008)(81166006)(6486002)(4744005)(75432002)(5660300002)(2501003)(52116002)(71200400001)(478600001)(71190400001)(5640700003)(81156014)(66066001)(53936002)(6916009)(1076003)(25786009)(2616005)(36756003)(486006)(64756008)(6116002)(66946007)(26005)(66446008)(86362001)(3846002)(68736007)(66476007)(2351001)(6436002)(316002)(50226002)(476003)(54906003)(4326008)(186003)(786003)(14444005)(256004)(14454004)(42522002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CY4PR03MB2743;
 H:CY4PR03MB2872.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: TZpV4JbK2zdYRF3yzZWEF41ryZXE0dTL7Vb1C9G07NVyZWugS6l30309XbLgWD5QjLjjkYkYnPpaqkeWc2aKWPOpdwCvgvHl/e1zTu2ZmcijS2GRDVkoUnddaAkVBT58XKLDN+f1CZD5H4YqzkCxQJQL9MObko+bH46AS1iQ0chdX2OJj6AOWi/yTmWyFEiXg1nLR6d2pvfE9W8DK+MoB/w9+DeSpcaN2jBlF1Bc9Sjx/sIHUlbWxOmtM992C9ogu2GLtiRz7fCholJcywzo5qaPUc+7URhdTLuRYQWQ0vcXtrc5qG1iagqIJssO2o2mahGMrtldBtXQnL4DvsOzO1zsW4IPIK1D1PwZxDeCwgoHt96cvw6yOHpcCcpK2mCEi5eKvhETPzVtIhwkzSdJ8N/Ci4sv7qxKsjUCLTwuxfA=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cd421bd-9119-4d99-9a09-08d70c7a37cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2019 18:52:16.0288 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: alxndr@bu.edu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2743
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.78.138
Subject: [Qemu-devel] [PATCH 0/2] Avoid sending zero-size packets
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "bsd@redhat.com" <bsd@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>,
 "Oleinik, Alexander" <alxndr@bu.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

While fuzzing virtio-net I found that attempting to send
a zero-size packet leads to an assertion failure, when resetting the
device. These patches add an assertion to net/net.c to ensure that
virtual devices do not try to send zero-size packets and change
virtio-net to check that packets have non-zero size, prior to sending.

Alexander Oleinik (2):
  net: assert that tx packets have nonzero size
  virtio-net: check that tx packet has positive size

 hw/net/virtio-net.c | 15 +++++++++------
 net/net.c           |  3 +++
 2 files changed, 12 insertions(+), 6 deletions(-)

--=20
2.20.1


