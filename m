Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9BF4C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 01:02:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D5E2208B3
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 01:02:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D5E2208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ekarma.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSVBK-0005pH-1Y
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 21:02:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60650)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <grqp@ekarma.org>) id 1kSStw-0001f4-M7
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 18:36:12 -0400
Received: from p3plsmtpa07-02.prod.phx3.secureserver.net
 ([173.201.192.231]:48355)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <grqp@ekarma.org>) id 1kSStu-0000XP-GP
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 18:36:12 -0400
Received: from BY5PR20MB3025.namprd20.prod.outlook.com ([52.96.65.181])
 by :SMTPAUTH: with ESMTPSA
 id SStqkP6ii51hoSStqkeEpR; Tue, 13 Oct 2020 15:36:06 -0700
X-CMAE-Analysis: v=2.3 cv=YNfhNiOx c=1 sm=1 tr=0
 a=47z1aYw9UwQLATil3DZc6A==:117 a=47z1aYw9UwQLATil3DZc6A==:17 a=t-IPkPogAAAA:8
 a=5Ed3cbfSEtYHKJpSJzYA:9 a=wPNLvfGTeEIA:10 a=xToySzCs-o1jkM1MAgsA:9
 a=v5ZtGH-Qpt6i3g0-:21 a=frz4AuCg-hUA:10 a=_W_S_7VecoQA:10
X-SECURESERVER-ACCT: admin@ekarma.org
From: "grqp@ekarma.org" <grqp@ekarma.org>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: MacOS network bridging using vmnet framework
Thread-Topic: MacOS network bridging using vmnet framework
Thread-Index: AQHWoa2OC1xeyfVht0esEuHfRrej4w==
X-MS-Exchange-MessageSentRepresentingType: 1
Date: Tue, 13 Oct 2020 22:36:06 +0000
Message-ID: <BY5PR20MB3025896C69F500CE7BAF3DBAC7040@BY5PR20MB3025.namprd20.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-Exchange-Organization-SCL: -1
X-MS-TNEF-Correlator: 
X-MS-Exchange-Organization-RecordReviewCfmType: 0
Content-Type: multipart/alternative;
 boundary="_000_BY5PR20MB3025896C69F500CE7BAF3DBAC7040BY5PR20MB3025namp_"
MIME-Version: 1.0
X-CMAE-Envelope: MS4wfHU/NHrYJHee731ydwz7zPBEgjiuo5RKmjrb6bQOiJXGdVGNG3MsjvpAlBKX0lEk+8SBNlB8SRANjzJvdXD6Nq996eIpb0Hlu/IarNLwr7WkP7wspDXs
 pT63ro+Jx7tUhe1HEubtbg/Z3n204VprK4zmbvVlxDYhkvQDUaUBgwVSWA2Hy0yHkcQ4yijUhlpH2OtGCLu0SV5F6HgaFzsLgiI=
Received-SPF: none client-ip=173.201.192.231; envelope-from=grqp@ekarma.org;
 helo=p3plsmtpa07-02.prod.phx3.secureserver.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 18:36:07
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 13 Oct 2020 21:00:51 -0400
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

--_000_BY5PR20MB3025896C69F500CE7BAF3DBAC7040BY5PR20MB3025namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi all -

I've been playing around with qemu-system-arm on a MacOS 10.15 box.  I'm tr=
ying to bridge the guest but I haven't had any luck.  It looks like the pro=
per way to do this is with a TAP device.  AFAIK, this was done in the past =
by installing a TUN/TAP kernel extension (kext), which Apple has since clam=
ped down upon.   I haven't pursued this since it's looks like a dead-end.  =
 I did notice that Apple has a framework called vmnet (https://developer.ap=
ple.com/documentation/vmnet) which offers VM network bridging.  I didn't se=
e any references to vmnet in master,  Is vmnet a good fit in this case as a=
 new TAP implementation, like tap-macos-vmnet.c.  Or am I going off into th=
e weeds and there is something obvious I'm missing.

G.


--_000_BY5PR20MB3025896C69F500CE7BAF3DBAC7040BY5PR20MB3025namp_
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
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
Hi all -</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
<br>
</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
I've been playing around with qemu-system-arm on a MacOS 10.15 box. &nbsp;I=
'm trying to bridge the guest but I haven't had any luck. &nbsp;It looks li=
ke the proper way to do this is with a TAP device. &nbsp;AFAIK, this was do=
ne in the past by installing a TUN/TAP kernel extension
 (kext), which Apple has since clamped down upon. &nbsp; I haven't pursued =
this since it's looks like a dead-end. &nbsp; I did notice that Apple has a=
 framework called
<i>vmnet</i> (<a href=3D"https://developer.apple.com/documentation/vmnet" i=
d=3D"LPlnk">https://developer.apple.com/documentation/vmnet</a>)&nbsp;which=
 offers VM network bridging. &nbsp;I didn't see any references to vmnet in =
master, &nbsp;Is vmnet a good fit in this case as a
 new TAP implementation, like tap-macos-vmnet.c. &nbsp;Or am I going off in=
to the weeds and there is something obvious I'm missing.</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
<br>
</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
G.</div>
<div class=3D"_Entity _EType_OWALinkPreview _EId_OWALinkPreview _EReadonly_=
1"></div>
<br>
</body>
</html>

--_000_BY5PR20MB3025896C69F500CE7BAF3DBAC7040BY5PR20MB3025namp_--

