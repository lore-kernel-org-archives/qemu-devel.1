Return-Path: <SRS0=LSdK=2Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F061DC2D0DA
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Dec 2019 14:59:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA490206A4
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Dec 2019 14:59:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA490206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=parsons.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ikUcG-0006CL-Sw
	for qemu-devel@archiver.kernel.org; Thu, 26 Dec 2019 09:59:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41034)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=7263172803=alexander.bensch@parsons.com>)
 id 1ikUbc-0005mi-NA
 for qemu-devel@nongnu.org; Thu, 26 Dec 2019 09:59:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=7263172803=alexander.bensch@parsons.com>)
 id 1ikUbb-0008Dh-17
 for qemu-devel@nongnu.org; Thu, 26 Dec 2019 09:59:16 -0500
Received: from txdal11mx02.parsons.com ([206.219.199.110]:47604)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71)
 (envelope-from <prvs=7263172803=alexander.bensch@parsons.com>)
 id 1ikUbZ-0008DG-GK
 for qemu-devel@nongnu.org; Thu, 26 Dec 2019 09:59:14 -0500
Received: from pps.filterd (txdal11mx02.parsons.com [127.0.0.1])
 by txdal11mx02.parsons.com (8.16.0.27/8.16.0.27) with SMTP id xBQEdGip007209; 
 Thu, 26 Dec 2019 08:59:10 -0600
Received: from txdal11exch01.parsons.com (txdal11exch01.parsons.com
 [172.21.212.127])
 by txdal11mx02.parsons.com with ESMTP id 2x4t838uhj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Thu, 26 Dec 2019 08:59:10 -0600
Received: from ALHUN12EXCH01.Parsons.com (10.62.8.71) by
 TXDAL11EXCH01.Parsons.com (172.21.212.127) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 26 Dec 2019 08:59:09 -0600
Received: from ALHUN12EXCH01.Parsons.com (10.62.8.71) by
 ALHUN12EXCH01.Parsons.com (10.62.8.71) with Microsoft SMTP Server (TLS) id
 15.0.1473.3; Thu, 26 Dec 2019 08:59:05 -0600
Received: from ALHUN12EXCH01.Parsons.com ([10.62.8.71]) by
 ALHUN12EXCH01.Parsons.com ([10.62.8.71]) with mapi id 15.00.1473.003; Thu, 26
 Dec 2019 08:59:05 -0600
From: "Bensch, Alexander" <Alexander.Bensch@parsons.com>
To: =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [EXTERNAL]  Re: MIPS cache bypass on custom board
Thread-Topic: [EXTERNAL]  Re: MIPS cache bypass on custom board
Thread-Index: AQHVsh9IRY4kHqmWt0C3EdH2GZKphqe+WPSw
Date: Thu, 26 Dec 2019 14:59:05 +0000
Message-ID: <8ff9d62ec2fd43b4b9364fb0debae811@ALHUN12EXCH01.Parsons.com>
References: <e3c2df7ae90747729a47d5f854e450e5@ALHUN12EXCH02.Parsons.com>
 <9ba23651-746a-5085-eff8-a048385e29ed@redhat.com>
In-Reply-To: <9ba23651-746a-5085-eff8-a048385e29ed@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0008d3e4-f847-4182-a1fb-fb9d345a0f05_Enabled=True;
 MSIP_Label_0008d3e4-f847-4182-a1fb-fb9d345a0f05_SiteId=8d088ff8-7e52-4d0f-8187-dcd9ca37815a;
 MSIP_Label_0008d3e4-f847-4182-a1fb-fb9d345a0f05_Owner=Alexander.Bensch@parsons.com;
 MSIP_Label_0008d3e4-f847-4182-a1fb-fb9d345a0f05_SetDate=2019-12-26T14:59:03.8468447Z;
 MSIP_Label_0008d3e4-f847-4182-a1fb-fb9d345a0f05_Name=General Business;
 MSIP_Label_0008d3e4-f847-4182-a1fb-fb9d345a0f05_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_0008d3e4-f847-4182-a1fb-fb9d345a0f05_ActionId=5b431e79-e506-4be1-b15f-ba5df1682e96;
 MSIP_Label_0008d3e4-f847-4182-a1fb-fb9d345a0f05_Extended_MSFT_Method=Manual
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.21.212.10]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-12-26_04:, , signatures=0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 206.219.199.110
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Are there any hooks that would allow me to manipulate the MIPS TLB so that =
I can just split the mappings within the board file? I'm trying to avoid mo=
difying the CPU source if possible. This type of solution sounds like it wo=
uld be similar to the last one Peter described in the linked post (which de=
scribes exactly my problem. Thank you for finding that!)

-----Original Message-----
From: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
Sent: Friday, December 13, 2019 8:39 PM
To: Bensch, Alexander <Alexander.Bensch@parsons.com>; qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>; Richard Henderson <richard.he=
nderson@linaro.org>
Subject: [EXTERNAL] Re: MIPS cache bypass on custom board

Hi Alexander,

On 12/13/19 7:59 PM, Bensch, Alexander wrote:
> Hi all,
>
> Currently stuck on a problem in QEMU 4.0.0. I'm trying to implement a
> custom device using a MIPS 24Kc CPU. The device boots from an SPI
> flash device that is mapped to 0x9F000000 (physical address
> 0x1F000000). I got the initial load and execute working by direct
> loading a flash dump to a MemoryRegion based at 0x1F000000, which
> worked great until the ROM needed to access the SPI registers that are
> addressed to 0xBF000000 (/also /physical address 0x1F000000). QEMU
> cannot differentiate reads and writes to 0xBF000000 from reads and writes=
 to 0x9F000000.
>
> Initially I assumed this was a caching problem, as I know that the SPI
> registers are located in the KSEG1 memory segment which uses uncached
> writes, while the flash mapping is in KSEG0 with cached writes. I also
> can see that QEMU has logic to handle caching in a few source files
> within /targets/mips//. However, when I read from addresses in the
> KSEG1 region, I still see contents from the KSEG0 region.
>
> My question is whether there is any way to configure a MIPS board such
> that I can correctly bypass the cache for KSEG1 as expressed by the
> MIPS documentation?

Unfortunately QEMU doesn't model microarchitecture, thus no cache is modell=
ed, meaning KSEG1 is the same as KSEG0.

Peter Maydell had the similar problem you describe last year:
https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__www.mail-2Darchive.c=
om_qemu-2Ddevel-40nongnu.org_msg556999.html&d=3DDwIF-g&c=3DNwf-pp4xtYRe0sCR=
VM8_LWH54joYF7EKmrYIdfxIq10&r=3Dyw4RN9kr09cGsX2B3Tk1ruaD40EXodGkK9URECIP2Nw=
&m=3DKF9PMaUnfud9owwwQTKNbzm_MKzEW6eviCXwNADBn9Y&s=3DVlE9yaBuPXyQ0cPdBcLwFJ=
x2Wl6TrEpI12p3b3BcuDU&e=3D

>
> Apologies if details are lacking. Please request more info if needed.
>
> Thank you,
>
> *Alex Bensch*


NOTICE: This email message and all attachments transmitted with it may cont=
ain privileged and confidential information, and information that is protec=
ted by, and proprietary to, Parsons Corporation, and is intended solely for=
 the use of the addressee for the specific purpose set forth in this commun=
ication. If the reader of this message is not the intended recipient, you a=
re hereby notified that any reading, dissemination, distribution, copying, =
or other use of this message or its attachments is strictly prohibited, and=
 you should delete this message and all copies and backups thereof. The rec=
ipient may not further distribute or use any of the information contained h=
erein without the express written authorization of the sender. If you have =
received this message in error, or if you have any questions regarding the =
use of the proprietary information contained therein, please contact the se=
nder of this message immediately, and the sender will provide you with furt=
her instructions.

