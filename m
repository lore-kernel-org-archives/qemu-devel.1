Return-Path: <SRS0=OEAU=5Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5891DC2D0F4
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 20:29:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 009CA20768
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 20:29:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=apple.com header.i=@apple.com header.b="Pu19ql4f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 009CA20768
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMHKM-0005Lm-4a
	for qemu-devel@archiver.kernel.org; Wed, 08 Apr 2020 16:29:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40476)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty@apple.com>) id 1jMHJc-0004vL-22
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 16:28:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty@apple.com>) id 1jMHJb-0005Ip-3F
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 16:28:51 -0400
Received: from ma1-aaemail-dr-lapp03.apple.com ([17.171.2.72]:57068)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dirty@apple.com>)
 id 1jMHJa-0005If-UM; Wed, 08 Apr 2020 16:28:51 -0400
Received: from pps.filterd (ma1-aaemail-dr-lapp03.apple.com [127.0.0.1])
 by ma1-aaemail-dr-lapp03.apple.com (8.16.0.27/8.16.0.27) with SMTP id
 038KD6xr052043; Wed, 8 Apr 2020 13:28:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com;
 h=sender : content-type
 : mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=20180706;
 bh=Ie7f0W5UnrOCYcmQfudL2hXPzb95QuypmEfO/gtO4ak=;
 b=Pu19ql4fyxgvOMANqB7uWTDDbwlz1Z4ePFSVBeisCKkL232/toG7Yl8Mqw+aMq0sxXGS
 hwgs6kC6VZXEHOFCkI3WjiKJwRJXVGsnTAIC8DsIa+3WYann2CkebmtOXwmvJISGCP+k
 QJOim3KFBwoBPYYOurshAtrzqfq5JmA4Ya3nOO1s9Z+l1SkYs6smEYXH4rfj0LRTI+gR
 KK4sJSC3PRR38BmyqFxY2Js+rycI+yQqaNvLpn4XLlVN/IQyfaICtnKXV2jqwQOSTXuB
 h3O+IWOrET6ndAQoLb2oDnmoNu1AlrNspE0Qr2mgWdzQLpLfyW+ZP58OlmOUJ7zHUn5d NQ== 
Received: from rn-mailsvcp-mta-lapp04.rno.apple.com
 (rn-mailsvcp-mta-lapp04.rno.apple.com [10.225.203.152])
 by ma1-aaemail-dr-lapp03.apple.com with ESMTP id 3091j7u9jg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Wed, 08 Apr 2020 13:28:49 -0700
Received: from rn-mailsvcp-mmp-lapp01.rno.apple.com
 (rn-mailsvcp-mmp-lapp01.rno.apple.com [17.179.253.14])
 by rn-mailsvcp-mta-lapp04.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.5.20200312 64bit (built Mar 12
 2020)) with ESMTPS id <0Q8H0030TKW0UQE0@rn-mailsvcp-mta-lapp04.rno.apple.com>; 
 Wed, 08 Apr 2020 13:28:48 -0700 (PDT)
Received: from process_milters-daemon.rn-mailsvcp-mmp-lapp01.rno.apple.com by
 rn-mailsvcp-mmp-lapp01.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.5.20200312 64bit (built Mar 12
 2020)) id <0Q8H01100J0DA800@rn-mailsvcp-mmp-lapp01.rno.apple.com>; Wed,
 08 Apr 2020 13:28:48 -0700 (PDT)
X-Va-A: 
X-Va-T-CD: 46931e9116192002279dfee8d345dfa3
X-Va-E-CD: 3fbbade6f446385870d932a4ea9cc984
X-Va-R-CD: 7926c7cb8e1d44f0f3cf5ca0d0e7a1b3
X-Va-CD: 0
X-Va-ID: e72099b4-d86d-4816-8bc6-7de531feb77f
X-V-A: 
X-V-T-CD: 46931e9116192002279dfee8d345dfa3
X-V-E-CD: 3fbbade6f446385870d932a4ea9cc984
X-V-R-CD: 7926c7cb8e1d44f0f3cf5ca0d0e7a1b3
X-V-CD: 0
X-V-ID: 5710cdff-fed7-4541-9022-8e366d7f7139
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.676
 definitions=2020-04-08_07:2020-04-07,
 2020-04-08 signatures=0
Received: from [17.234.59.170] (unknown [17.234.59.170])
 by rn-mailsvcp-mmp-lapp01.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.5.20200312 64bit (built Mar 12
 2020))
 with ESMTPSA id <0Q8H002XXKVZ1900@rn-mailsvcp-mmp-lapp01.rno.apple.com>; Wed,
 08 Apr 2020 13:28:48 -0700 (PDT)
Content-type: text/plain; charset=us-ascii
MIME-version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v2 07/12] acpi: move aml builder code for rtc device
In-reply-to: <20200408125928.scuf2eh34553q3ao@sirius.home.kraxel.org>
Date: Wed, 08 Apr 2020 13:28:47 -0700
Cc: Igor Mammedov <imammedo@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>
Content-transfer-encoding: quoted-printable
Message-id: <757DADFA-0EC0-4BB3-8D10-AD09E05B5438@apple.com>
References: <20200403080502.8154-1-kraxel@redhat.com>
 <20200403080502.8154-8-kraxel@redhat.com> <20200403120921.258db9a5@redhat.com>
 <20200406082517.uyz7zv4jiqqjbcli@sirius.home.kraxel.org>
 <20200406141705.77d90b68@redhat.com>
 <20200407102658.x5tb4txcpvmtxfj7@sirius.home.kraxel.org>
 <20200408132727.374c470d@redhat.com>
 <20200408125928.scuf2eh34553q3ao@sirius.home.kraxel.org>
To: Gerd Hoffmann <kraxel@redhat.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.676
 definitions=2020-04-08_08:2020-04-07,
 2020-04-08 signatures=0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 17.171.2.72
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
Reply-to: Cameron Esfahani <dirty@apple.com>
From: Cameron Esfahani via <qemu-devel@nongnu.org>

I'm curious why there's two ranges as well.

In our branch of QEMU, I've had to modify this RTC creation code to have =
only one range instead of two ranges.

Traditionally Macs have had one range for RTC and we have =
incompatibility with a two ranges.

If you could change it to one range without losing any compatibility, =
you'd get my thumbs up.

Cameron Esfahani
dirty@apple.com

"The cake is a lie."

Common wisdom



> On Apr 8, 2020, at 5:59 AM, Gerd Hoffmann <kraxel@redhat.com> wrote:
>=20
>  Hi,
>=20
>>>>>>> +    crs =3D aml_resource_template();
>>>>>>> +    aml_append(crs, aml_io(AML_DECODE16, 0x0070, 0x0070, 0x10, =
0x02));
>> maybe replace magic 0x0070 with macro
>>  RTC_BASE_ADDR
>=20
> Yes, that sounds better.
>=20
>>>>>>> +    aml_append(crs, aml_irq_no_flags(8));
>>>>>>> +    aml_append(crs, aml_io(AML_DECODE16, 0x0072, 0x0072, 0x02, =
0x06));
>>=20
>> one more comment, is this last io record correct?
>> (looking at realize it maps only 2 bytes at 0x70)
>=20
> No idea, I've just moved around the code.
>=20
> Good question though.  Also why this splitted in two ranges the first
> place.  Looking at physical hardware (my workstation) I see this:
>=20
>        Device (RTC)
>        {
>            Name (_HID, EisaId ("PNP0B00") /* AT Real-Time Clock */)  =
// _HID: Hardware ID
>            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource =
Settings
>            {
>                IO (Decode16,
>                    0x0070,             // Range Minimum
>                    0x0070,             // Range Maximum
>                    0x01,               // Alignment
>                    0x08,               // Length
>                    )
>                IRQNoFlags ()
>                    {8}
>            })
>        }
>=20
> Clues anyone?
>=20
> thanks,
>  Gerd
>=20
>=20


