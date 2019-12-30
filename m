Return-Path: <SRS0=s40H=2U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EAECC2D0C3
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2019 22:03:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F935206DB
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2019 22:03:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F935206DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mentor.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1im38O-0007Sf-Sc
	for qemu-devel@archiver.kernel.org; Mon, 30 Dec 2019 17:03:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33542)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Mahmoud_Eltahawy@mentor.com>) id 1ilzfe-0004To-AG
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 13:21:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Mahmoud_Eltahawy@mentor.com>) id 1ilzfc-0004Ax-Bm
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 13:21:37 -0500
Received: from esa3.mentor.iphmx.com ([68.232.137.180]:61599)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Mahmoud_Eltahawy@mentor.com>)
 id 1ilzfc-0004A0-2Y
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 13:21:36 -0500
IronPort-SDR: A/H9mOnSqvLKVeNMWckTniI//ao0ULvf87od/XzrfT5HTEo5VwfXn/H+JCq7H8AF4ByBulvOBb
 cLRC6S09QRhqBlwKRo1ivfSBVvyYo0SCLV8f+mcXTqlceUXswBabWtbSNZuiC88S+2upZoFmjy
 Go2y/LYCZ4BBCSfjWuctt3UOHNcX239SZ2PMAuSSS/C25sBqDfJjxB3xZkVHDq7cQa8h1cS6RF
 05LeWsaOla3Zs2gQYLrKcejl0WIOzNI/L/YOlBKDopUuBcXMyuJlFBvJzwg6RvXoK2LHtRV1HJ
 seI=
X-IronPort-AV: E=Sophos;i="5.69,376,1571731200"; d="scan'208,217";a="44470658"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
 by esa3.mentor.iphmx.com with ESMTP; 30 Dec 2019 10:21:32 -0800
IronPort-SDR: aH6KAjNd0mtoPf/JmGf4gxJ4fyNHuxQjiX/sSpX9KAg+u/nMndI9Tcsg0OwUQalxnVPSCDyCXS
 YVDJWL8f//dtNQKpujlrOuSNEEKK9zifwYHrIdJ0ErMmQd0ZF2yOVk6+whm29PbYEORDPGEKdR
 IMoZ5Na7RFdB5W5J8SvjpBkotiubQJFlw0PWNFFpBAU0bGPLqKDYFGi5sze5gyjBEulovgV3Hh
 hC8kXYbGCKlEvqdBlRMEKuQE8oD9GQpHKifJKSkzR+zpVG/DwysvM1AKL9zgemNcbphkA7eRna
 kWQ=
From: "Eltahawy, Mahmoud" <Mahmoud_Eltahawy@mentor.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: qemu_set_fd_handler callback is delayed
Thread-Topic: qemu_set_fd_handler callback is delayed
Thread-Index: AdW/O7ZAD9WLlnZCThGjbc0jYrLHkg==
Date: Mon, 30 Dec 2019 18:21:27 +0000
Message-ID: <55e69ff3c25f4e3ab4bfc8007498fcde@svr-ies-mbx-01.mgc.mentorg.com>
Accept-Language: en-US, en-IE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [137.202.0.90]
Content-Type: multipart/alternative;
 boundary="_000_55e69ff3c25f4e3ab4bfc8007498fcdesvriesmbx01mgcmentorgco_"
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 68.232.137.180
X-Mailman-Approved-At: Mon, 30 Dec 2019 17:01:55 -0500
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

--_000_55e69ff3c25f4e3ab4bfc8007498fcdesvriesmbx01mgcmentorgco_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

I am new to QEMU and I am using qemu-3.0.1, I noticed a strange behavior fo=
r qemu_set_fd_handler that the callback for reading from a file descriptor =
is delayed then expected while the file descriptor(socket) has a data to re=
ad.

I register a callback for reading from a socket using qemu_set_fd_handler a=
nd during runtime, this callback is not invoked for about 14msec, however t=
he socket has a data available for read. I tested this behavior by just cre=
ating a pthread which periodically checks the socket for any data using ioc=
tl(socket_fd, FIONREAD, &count), and for a period of 14ms, I found that the=
 pthread indicates there is a data in the socket while the qemu_set_fd_hand=
ler didn't trigger the read callback.

Any advice?


Thanks
Mahmoud



--_000_55e69ff3c25f4e3ab4bfc8007498fcdesvriesmbx01mgcmentorgco_
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
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
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
<p class=3D"MsoNormal">Hi,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I am new to QEMU and I am using qemu-3.0.1, I notice=
d a strange behavior for qemu_set_fd_handler that the callback for reading =
from a file descriptor is delayed then expected while the file descriptor(s=
ocket) has a data to read.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I register a callback for reading from a socket usin=
g qemu_set_fd_handler and during runtime, this callback is not invoked for =
about 14msec, however the socket has a data available for read. I tested th=
is behavior by just creating a pthread
 which periodically checks the socket for any data using ioctl(socket_fd, F=
IONREAD, &amp;count), and for a period of 14ms, I found that the pthread in=
dicates there is a data in the socket while the qemu_set_fd_handler didn&#8=
217;t trigger the read callback.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Any advice?<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks<o:p></o:p></p>
<p class=3D"MsoNormal">Mahmoud<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_55e69ff3c25f4e3ab4bfc8007498fcdesvriesmbx01mgcmentorgco_--

