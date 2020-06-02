Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B86AC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 07:47:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFC38206C3
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 07:47:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFC38206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jg1e7-0001oE-3f
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 03:47:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55352)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <LMa@suse.com>) id 1jg1dW-0001KE-Nj
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 03:47:02 -0400
Received: from m9a0014g.houston.softwaregrp.com ([15.124.64.90]:42851)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <LMa@suse.com>) id 1jg1dT-0001E4-GO
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 03:47:00 -0400
Received: FROM m9a0014g.houston.softwaregrp.com (15.121.0.190) BY
 m9a0014g.houston.softwaregrp.com WITH ESMTP; 
 Tue,  2 Jun 2020 07:46:06 +0000
Received: from M9W0068.microfocus.com (2002:f79:bf::f79:bf) by
 M9W0067.microfocus.com (2002:f79:be::f79:be) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Tue, 2 Jun 2020 07:45:37 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (15.124.72.11) by
 M9W0068.microfocus.com (15.121.0.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Tue, 2 Jun 2020 07:45:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gNnn0Vid4ykQ7ePWzoiN6iE66H3pHFvb/XXyR5bEli2z35MJR76NCjylxIHyxVsxYlL74RtBhiEFbumO9tWuatj4OHWJM3QTniKSZ0J5mVPROY72+d/PiGJRMGrtzryxzVo8KrTXHb3qKm6IkubQP9YP+p9ZHhNjZJQ/LYLqZZrKmeGzF8yxi1+kkAdmO8xZoqOn0OKG9qyGCuAUE9k1Bt6jyra2HNASzKBsrFDqJRc5J8Yx+yukQqi5mXHeN7ormYIU80ZqMejdFaAQ3mmuTbEX0erdec9OiEKhdq4UU98qmGsFwOd30epPWBNERiBIYHRWH5U71T3J+OsukPpovw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Nm9fBDIbOJga4b2PAjpiAv4Uy4w3Q/cbuuvbzoxXBU=;
 b=K+1jozkOa79OVsGwrFO/canQSkRV+a6wNfRSMRVqe0oOYwIFX1P1YZl7x0GjmTMWhwsNjLUqJjhWZZGLWoepRsZ4NzYrT5jT3J2i1q2SyYV3KXgYGIF4i4GUqwPD2dm7Q9vXf06DYLO4cjdISrr233uXIh4R2sPP//1jAHqYUSExxbsIkAe3uazuQO/X2RDe2FqJ/Gb2aQFbk2P0RxWz7tj58uLo4wzgqFXW/hPItixIBVAqFLPyjTYlWQnhkNmBrBCawPgQOiQW5ZaQG0D8Iw0UClxTPuqRDoIWpjUxYQ9o9w35Nxc/SFkXzsuK6OY5fcVbb6pncHoxjlHPkwTLGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Received: from BY5PR18MB3313.namprd18.prod.outlook.com (2603:10b6:a03:1a9::28)
 by BY5PR18MB3185.namprd18.prod.outlook.com (2603:10b6:a03:1a8::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Tue, 2 Jun
 2020 07:45:36 +0000
Received: from BY5PR18MB3313.namprd18.prod.outlook.com
 ([fe80::e4f5:6729:fa11:1240]) by BY5PR18MB3313.namprd18.prod.outlook.com
 ([fe80::e4f5:6729:fa11:1240%7]) with mapi id 15.20.3045.024; Tue, 2 Jun 2020
 07:45:36 +0000
From: Lin Ma <LMa@suse.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [question] Partial sector issue while discard in qcow2 image
Thread-Topic: [question] Partial sector issue while discard in qcow2 image
Thread-Index: AQHWOK7m5N2XkTj0GUW+Cz5gfuCM5A==
Date: Tue, 2 Jun 2020 07:45:36 +0000
Message-ID: <BY5PR18MB331316E948CB9AFDA33A6F6DC58B0@BY5PR18MB3313.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=suse.com;
x-originating-ip: [60.251.47.115]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dda22395-01ab-4622-1564-08d806c8f014
x-ms-traffictypediagnostic: BY5PR18MB3185:
x-microsoft-antispam-prvs: <BY5PR18MB3185B56ECAB78521C4EB0ED8C58B0@BY5PR18MB3185.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:651;
x-forefront-prvs: 0422860ED4
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JOK/DAOiRryglt8YXeK6/IRSGJffZHEYd38l9V9ll5gsV2yxEYZxjZet10iLyMEBnDXBU/Hp/4LkPv2n4krwrQALfZ7BXm3EvMADSxSA/MgTswKLKmAYV3X0Hn6bQ1zLECNHVrdDE/KTfUYZDStfQIoim014hY5B6DvyL5vpzULJoilbt9rNxtYTeICZ/IIGj2wLPKfxkyfPoQFUvbUCYSqMdwt0pvgAVDfsCSyntfTFbFRJ9Ls/EnbRLFyceNcshHLsVtgIoUx84+BfkwzH+UG9hn6qMUiAwwD2aBdpeG8XWqIMYOiCgJMVRvQQWL+n
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR18MB3313.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(376002)(396003)(346002)(366004)(136003)(2906002)(86362001)(83380400001)(19627405001)(5660300002)(9686003)(33656002)(71200400001)(8676002)(52536014)(6916009)(64756008)(66476007)(66556008)(66946007)(4326008)(6506007)(76116006)(91956017)(66446008)(316002)(54906003)(8936002)(55016002)(7696005)(186003)(55236004)(478600001)(26005)(4744005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: ekPDmur1dVVKNXxyMJf4GvfSf+RZuNFPedCOOLahI+SsWjXNkUfuSsPMr7DoD420bm04Z8Q4JNmtef7zD6iBBYblYWvaPHmqk564aXm1WZaVphRWPFgvYR9YcFna2kyd9s8prEfn/xYV0abbQn4LVK4qVWyc0IcJqPIUCASRD7qafCE/6GinRUJRDsSw5PN502P+KXSHmLp075mTIYPdycfR/TDnQXseAeAuubmjY0o3Vt9yeWWkKJ9/DH9AYAw6DLpZOTK5a+Q3l7wdeVirOQpyTtLMkJ1adIQC8w28D+em99+SLdc0EA1MMnEY9H+rx/aD9bzJF8SEPyXeTmE+5TJV2rlPDnalvPR8Qf+niBW53YYm2oAQ35+iQoPMspEcTcdMhyM94rTm6/KiGCyCt/ANHu1epDnzhACb/lrvgSJKFGXhw/vlme+C20zCUhJNLOstRa/noRig89rwgbFcGGOuWfBJOsI8cYhlQ8vDw0U=
x-ms-exchange-transport-forked: True
Content-Type: multipart/alternative;
 boundary="_000_BY5PR18MB331316E948CB9AFDA33A6F6DC58B0BY5PR18MB3313namp_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: dda22395-01ab-4622-1564-08d806c8f014
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2020 07:45:36.2709 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tGEfWYCdf0sIrflauBMR/HJTxkEcaVMXyevGHAb61sOqwHY06OoFIYlb0UjhsVEO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR18MB3185
X-OriginatorOrg: suse.com
Received-SPF: pass client-ip=15.124.64.90; envelope-from=LMa@suse.com;
 helo=m9a0014g.houston.softwaregrp.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/02 03:46:52
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, HTML_MESSAGE=0.001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--_000_BY5PR18MB331316E948CB9AFDA33A6F6DC58B0BY5PR18MB3313namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi all,

During  woring to add GET LBA STATUS support in qemu scsi emulation layer, =
I encountered
an unmap issue with qcow2 image, It's likely about how to unmap partial clu=
sters. e.g.:

With these default values:
* the default value of s->qdev.blocksize: 512
* the default value of s->cluster_size of qcow2 image: 65536

Running 'sg_unmap -l 1024 -n 32 /dev/sda' hits the condition
'if (!QEMU_IS_ALIGNED(offset | bytes, s->cluster_size))' in the function qc=
ow2_co_pdiscard,
Then it won't perform qcow2_cluster_discard(), So the corresponding cluster=
s won't be discard
in this situation, Correct?

Of cause, with the default blocksize and cluster_size, The below examples w=
on't hit the condition 'if (!QEMU_IS_ALIGNED...'.
sg_unmap -l 1024 -n 128 /dev/sda
or
sg_unmap -l 256 -n 128 /dev/sda

Thanks,
Lin

--_000_BY5PR18MB331316E948CB9AFDA33A6F6DC58B0BY5PR18MB3313namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span>Hi all,<br>
</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span><br>
</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span></span>During&nbsp; woring to add GET LBA STATUS support in qemu scsi=
 emulation layer, I encountered
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
an unmap issue with qcow2 image, It's likely about how to unmap partial clu=
sters. e.g.:</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
With these default values:<br>
<div>* the default value of s-&gt;qdev.blocksize: 512<br>
</div>
<div>* the default value of s-&gt;cluster_size of qcow2 image: 65536</div>
<div><br>
</div>
<div>Running 'sg_unmap -l 1024 -n 32 /dev/sda' hits the condition</div>
<div>'if (!QEMU_IS_ALIGNED(offset | bytes, s-&gt;cluster_size))' in the fun=
ction qcow2_co_pdiscard,<br>
</div>
<div>Then it won't perform qcow2_cluster_discard(), So the corresponding cl=
usters won't be discard</div>
<div>in this situation, Correct?<br>
</div>
<div><br>
</div>
<div>Of cause, with the default blocksize and cluster_size, The below examp=
les won't hit the condition 'if (!QEMU_IS_ALIGNED...'.<br>
</div>
<div>sg_unmap -l 1024 -n 128 /dev/sda<br>
</div>
<div>or<br>
</div>
<div>sg_unmap -l 256 -n 128 /dev/sda<br>
</div>
<div><br>
</div>
<div>Thanks,<br>
</div>
<span>Lin</span><br>
</div>
</body>
</html>

--_000_BY5PR18MB331316E948CB9AFDA33A6F6DC58B0BY5PR18MB3313namp_--

