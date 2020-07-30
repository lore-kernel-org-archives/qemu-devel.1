Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D48C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 12:59:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DDA920842
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 12:59:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="hr0ljGLz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DDA920842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k189D-0006rt-Tj
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 08:58:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47478)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yajunw@mellanox.com>)
 id 1k13V9-0006Zf-Ue
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 04:01:20 -0400
Received: from mail-eopbgr10068.outbound.protection.outlook.com
 ([40.107.1.68]:29779 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yajunw@mellanox.com>)
 id 1k13V7-0002hO-8y
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 04:01:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UT9jvf5TY2at2vWpwPPv/y0AXhMNOW9tAk3Qr3AtSVTX8A4vlAvCB+Aa7VZNc6sK0BK0wRccNjvIvExDCQD+WaIGi07TAWro0gOnrkE2HuQKgbZ36VKPfOh4Rs+JW3KkXAoz6KHOPOd5IWZ4/sBkcmfapzRScZLqPOjI+NTYnkIZpZVS5xMhYfODpXQT81zaU+ShCXRfaQZz4i0ZPCEC31lu+MwQ7DkqYxGaRqvayEd5LJ2BNzaKClFIySPy3cCb8T2IZSfzc6E8qkyXSm9LhbVON9lFlWmJtqBMHsUZfbUIYQ1FUBvpa0o/zcuY3X42nHB4EXABCbJMMJUzpktOfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RAGzxxNykyGSWuHRyG8fOWldTzxxgomTA7wl14DtZwI=;
 b=P9hRkzRwj2KCCejxT46bGeyBGua/HgY1R7NprLgFByWPcCbyAGRzGCL0vYPmS1y25lMqb2OhgfpZ9KgvY06LNihaO9Bc2ctHoUWsCMUDTbDEMwNfqvLwvc+wakPu9byNWmfyEbuXue582VqDd9lN18jd061KR/aK602+63CtPn4FmcI5csJLren9XE6aTtBGstmEF5OPw7g9YZSfiMk34RsNt/1vQ0mjr26MeOFJ7Or8e4Qz3aHqBE2L+eWnZR6KLIi97twoPtRFw8IbEEMTuxTjzLt97cq7TsawbVkiuXRG+pDZe6VNT7OIuR9OilQmxn9LpH8cLFqXEfZCFL901w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RAGzxxNykyGSWuHRyG8fOWldTzxxgomTA7wl14DtZwI=;
 b=hr0ljGLzXDJI4fD0a5aWjdqe1igfjcyGpdc8OpzlV0JFEbIGuiPmd5QmJVH+ibb4LiWTZKU/wg3Wen09A+VhSl4wbnWm8S+A2OFQ9/pF6uBi5VnePbN1kLjHOkjX8G91qu9MtRSA//8qc4vbJS6v3fmWwaYuLgAEqDzMTyDHCL8=
Received: from AM7PR05MB6695.eurprd05.prod.outlook.com (2603:10a6:20b:142::22)
 by AM6PR05MB4968.eurprd05.prod.outlook.com (2603:10a6:20b:4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16; Thu, 30 Jul
 2020 07:46:10 +0000
Received: from AM7PR05MB6695.eurprd05.prod.outlook.com
 ([fe80::8574:63a5:ef7b:bd]) by AM7PR05MB6695.eurprd05.prod.outlook.com
 ([fe80::8574:63a5:ef7b:bd%3]) with mapi id 15.20.3239.017; Thu, 30 Jul 2020
 07:46:09 +0000
From: Yajun Wu <yajunw@mellanox.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Any reason VIRTQUEUE_MAX_SIZE is 1024? Can we increase this limit?
Thread-Topic: Any reason VIRTQUEUE_MAX_SIZE is 1024? Can we increase this
 limit?
Thread-Index: AdZmRKXyRhpGB73vSMi6kUjXqcq6sw==
Date: Thu, 30 Jul 2020 07:46:09 +0000
Message-ID: <AM7PR05MB6695D4FF6766BF2942C345D6BB710@AM7PR05MB6695.eurprd05.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=mellanox.com;
x-originating-ip: [101.80.66.147]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fa8b9c4c-a2bd-4164-f45e-08d8345ca000
x-ms-traffictypediagnostic: AM6PR05MB4968:
x-microsoft-antispam-prvs: <AM6PR05MB4968BDB6122BC6454049F85EBB710@AM6PR05MB4968.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GSQ33o1PoF+FW8PIKG22MtP19r3IJ0CDgffIiUc/2/I4PVtIFWea9bIPpkz2j/0fQT78OiAzeobTEjruyGq4/GGhyuEY7hVnj+I8qHV8LDxt4D5p+sV4oeNPmLY8+oc1vEVTFGtX2InltwR/4UxfrST+G8+TU5uphuHO55BKz1jl/s0lH8dAOF3RTbn6kbTdFPgwY667B6fz++EZ/XO6p/E/SgIP0kvLEdgvTk6nmgL9OaJ3j9t4C40dTCWOwOXUcdOCIcEhTvmrZoWrMabEjFM/5B8lk7v3K+cbnRtR2UeEu7TXGyLvs069kPTD4snECcN739WyYVQqwQXQHnygEg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR05MB6695.eurprd05.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(376002)(366004)(346002)(396003)(39860400002)(7696005)(52536014)(86362001)(6506007)(5660300002)(71200400001)(33656002)(478600001)(8676002)(66476007)(66946007)(6916009)(66556008)(64756008)(26005)(55016002)(83380400001)(9686003)(2906002)(186003)(8936002)(4744005)(316002)(76116006)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: ThBU01aDYCUXC/2ZGEhP0NiH+3ZMeFx5oNFrzVMyagpG7zewZnNyVdytg5rleWLF2V+gfQ8osq2bkp/LRrvutfrBRc2V3EoU5/DOzlGsbNOAki3I43UbMd+3ktoJHL4cKA+wNkHV/t8ggKjz13A7fjFHSBP+KauIUuIW8sX9KYGczztMk2m8fQsx1l0W1ttrJjF7EORAd9aVSRGTehUpRWyTrvFyZbKTNUOm24tYM9PdoxIzYgJnUp504A44KKkU/XnXBWZeg8icpdEBuMtSqKSxEczL4EQ29nnRcEkKJouE4dI6GP6kYNy3FSOnXZseW7b/LqHn6YHH1ch3CNPxD51Qv8yeVI6bSl/eJIUbMy/ENTGZFSoZQAd1RSOA8C775awuUJeGfiQ6KkiFey5HTpVnrD2XEJ2xcuDBOhQOnh5dCBXESFFl0/rei1BB+EV5R5KJOHgFgDZspMmh5yPXYemD+4RMbhznkLpyw8s2GBc7z+hNd82GTpxmyi4IWLW7/L+rrN9eGBN3TR1tukNamUsZUUUxnFbQ5blTZhWqg+N7UhnVCUC8+8YSBnEe8ywmKxHEiODvO0PzUwfEazG8L184PzWCWrNezLSMRvSYXNsltu8YGpHqBpc5J7oj1SkTEAyIi78LvxpSiR074iUp9w==
x-ms-exchange-transport-forked: True
Content-Type: multipart/alternative;
 boundary="_000_AM7PR05MB6695D4FF6766BF2942C345D6BB710AM7PR05MB6695eurp_"
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR05MB6695.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa8b9c4c-a2bd-4164-f45e-08d8345ca000
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2020 07:46:09.7484 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pNZnqR3DFPVw4dLHW61+1zH3Wk4lIoywVTl9HacnwX3WqzZiUh5fXOq0VCDhuptBq6a2F1Pns6Jawq5AEYpVOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB4968
Received-SPF: pass client-ip=40.107.1.68; envelope-from=yajunw@mellanox.com;
 helo=EUR02-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/30 04:01:14
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 30 Jul 2020 08:58:06 -0400
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

--_000_AM7PR05MB6695D4FF6766BF2942C345D6BB710AM7PR05MB6695eurp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi all,

I'm doing iperf test on VIRTIO net through vhost-user(HW VDPA).
Find maximal acceptable tx_queue_size/rx_queue_size is 1024.
Basically increase queue size can get better RX rate for my case.

Can we increase the limit(VIRTQUEUE_MAX_SIZE) to 8192 to possibly gain bett=
er performance?

Thanks,
Yajun



--_000_AM7PR05MB6695D4FF6766BF2942C345D6BB710AM7PR05MB6695eurp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hi all,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I&#8217;m doing iperf test on VIRTIO net through vho=
st-user(HW VDPA).<o:p></o:p></p>
<p class=3D"MsoNormal">Find maximal acceptable tx_queue_size/rx_queue_size =
is 1024.
<o:p></o:p></p>
<p class=3D"MsoNormal">Basically increase queue size can get better RX rate=
 for my case.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Can we increase the limit(VIRTQUEUE_MAX_SIZE) to 819=
2 to possibly gain better performance?<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks,<o:p></o:p></p>
<p class=3D"MsoNormal">Yajun<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_AM7PR05MB6695D4FF6766BF2942C345D6BB710AM7PR05MB6695eurp_--

