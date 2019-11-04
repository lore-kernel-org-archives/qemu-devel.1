Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 605C6CA9ED3
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 02:05:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A621214E0
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 02:05:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sandia.gov header.i=@sandia.gov header.b="mgSREy6T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A621214E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRoDv-00082h-88
	for qemu-devel@archiver.kernel.org; Mon, 04 Nov 2019 21:05:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37220)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <shanson@sandia.gov>) id 1iRm71-00019R-Kl
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 18:50:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shanson@sandia.gov>) id 1iRm70-0001TN-9d
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 18:50:19 -0500
Received: from smtp01asnl.sandia.gov ([198.102.153.114]:13310)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <shanson@sandia.gov>) id 1iRm6z-0001RN-Rx
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 18:50:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=sandia.gov; i=@sandia.gov; q=dns/txt; s=snl;
 t=1572911417; x=1604447417;
 h=from:to:subject:date:message-id:mime-version;
 bh=wDBanqPeBrnmV5yq+5kCT6YM5V8dJrACe8yFy5sq6tg=;
 b=mgSREy6T+9Tn9qhUzTVshbdsoqEKSgpEadL7Z5tQXqsWOoMY6gdM6cg0
 0gXeRSm6LOHHDtP2RjZoFWALdP7u6MQrrCCSdVzSdU8BbV0naFgij8Ljs
 7pmvIJ7Xgmo0I/v9dPdq45VWHL/b+mdcxNLMNcBTJbEHdN1nJlVq9qH+1
 94V4j9l7P8ASzRi+bud35SWjYWF8XscD5G+rWZtoCwMKqSr35JA30fqKa
 8hm+d7IS7y1HV4ll5Is1tFwi+D1g0hNkC9lkVs6RXOrX6bQMo1D1PAZW5
 VLz7F9ICkgSh9h43h1aD4xn1GPKM3ssGeOMdbKuxt1h6Ofl3JUbRnuqOH w==;
IronPort-SDR: +ZY1CEn1vXvWrgvCHqY2Tfzmaq7m6srmgVSXgxGUKUvh25jmFHjhZ8FrBxZLYEErYdSIrfQ3b5
 8dmIEQ5GF3LQ==
X-IronPort-MID: 203127593
X-IronPort-AV: E=McAfee;i="6000,8403,9431"; a="203127593"
X-IronPort-AV: E=Sophos;i="5.68,268,1569304800"; 
 d="scan'208,217";a="203127593"
Received: from dp11snllx.sandia.gov (HELO Sandia_DLP) ([134.253.181.223])
 by smtp01asnl.sandia.gov with ESMTP; 04 Nov 2019 16:50:14 -0700
Received: from dp11snllx.sandia.gov (dp11snllx.sandia.gov [127.0.0.1])
 by dp11snllx.sandia.gov (Service) with ESMTP id 189BE57543
 for <qemu-devel@nongnu.org>; Mon,  4 Nov 2019 16:50:14 -0700 (MST)
Received: from mail.sandia.gov (unknown [134.253.103.166])
 by dp11snllx.sandia.gov (Service) with ESMTPS id 0447A57542
 for <qemu-devel@nongnu.org>; Mon,  4 Nov 2019 16:50:14 -0700 (MST)
X-CrossPremisesHeadersFilteredBySendConnector: ES03AMSNLNT.srn.sandia.gov
Received: from ES05AMSNLNT.srn.sandia.gov (134.253.103.165) by
 ES03AMSNLNT.srn.sandia.gov (134.253.103.163) with Microsoft SMTP Server (TLS)
 id 15.0.1473.3; Mon, 4 Nov 2019 16:50:12 -0700
Received: from ES05AMSNLNT.srn.sandia.gov ([134.253.103.181]) by
 ES05AMSNLNT.srn.sandia.gov ([134.253.103.181]) with mapi id 15.00.1473.003;
 Mon, 4 Nov 2019 16:50:12 -0700
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Adding New, Unsupported ISA to Qemu
Thread-Topic: Adding New, Unsupported ISA to Qemu
Thread-Index: AQHVk2i3OPPbMPM+DECJVEyRS/Wa9g==
Date: Mon, 4 Nov 2019 23:50:11 +0000
Message-ID: <1572911399018.17766@sandia.gov>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [134.253.113.252]
Content-Type: multipart/alternative;
 boundary="_000_157291139901817766sandiagov_"
MIME-Version: 1.0
X-OrganizationHeadersPreserved: ES03AMSNLNT.srn.sandia.gov
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 198.102.153.114
X-Mailman-Approved-At: Mon, 04 Nov 2019 21:04:35 -0500
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
Reply-to: "Hanson, Seth" <shanson@sandia.gov>
From: "Hanson, Seth" via <qemu-devel@nongnu.org>

--_000_157291139901817766sandiagov_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Hello,


I'm looking for in-depth documentation pertaining to how an unsupported 16 =
bit RISC ISA can be emulated in Qemu.


I've referenced this:


https://wiki.qemu.org/Documentation/TCG


and have been hoping there's additional, related documentation that I've ov=
erlooked.


Please advise.



Respectfully,

Seth

--_000_157291139901817766sandiagov_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none"><!--P{margin-top:0;margin-b=
ottom:0;} p=0A=
	{margin-top:0;=0A=
	margin-bottom:0}--></style>
</head>
<body dir=3D"ltr" style=3D"font-size:12pt;color:#000000;background-color:#F=
FFFFF;font-family:Calibri,Arial,Helvetica,sans-serif;">
<p><br>
</p>
<p>Hello,</p>
<p><br>
</p>
<p>I'm looking for in-depth documentation pertaining to how an unsupported =
16 bit RISC ISA can be&nbsp;emulated in Qemu.</p>
<p><br>
</p>
<p>I've referenced this: </p>
<p><br>
</p>
<p><a href=3D"https://wiki.qemu.org/Documentation/TCG">https://wiki.qemu.or=
g/Documentation/TCG</a></p>
<p><br>
</p>
<p>and have been hoping there's additional, related documentation that I've=
 overlooked.</p>
<p><br>
</p>
<p>Please advise.</p>
<p><br>
</p>
<p><br>
</p>
<p>Respectfully,</p>
<p>Seth<br>
</p>
</body>
</html>

--_000_157291139901817766sandiagov_--

