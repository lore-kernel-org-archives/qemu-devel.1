Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E90C8C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 16:31:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE6AD2075C
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 16:31:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE6AD2075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ia0E5-0006mq-1g
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 11:31:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58812)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1ia0As-0004ng-1w
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 11:28:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1ia00W-0003em-Ik
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 11:17:37 -0500
Received: from zero.eik.bme.hu ([152.66.115.2]:28642)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1ia00U-0003Zf-R5
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 11:17:36 -0500
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 704087456F8;
 Wed, 27 Nov 2019 17:17:32 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 453807456CD; Wed, 27 Nov 2019 17:17:32 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 43B7574568D;
 Wed, 27 Nov 2019 17:17:32 +0100 (CET)
Date: Wed, 27 Nov 2019 17:17:32 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [RFC 00/10] R300 QEMU device V2
In-Reply-To: <20191127150520.GG2131806@redhat.com>
Message-ID: <alpine.BSF.2.21.99999.352.1911271708130.13941@zero.eik.bme.hu>
References: <20191126124433.860-1-aaron.zakhrov@gmail.com>
 <20191126141924.GQ556568@redhat.com>
 <09273ecd-be76-ab61-304f-7ea0f1f0b107@redhat.com>
 <20191127150520.GG2131806@redhat.com>
User-Agent: Alpine 2.21.99999 (BSF 352 2019-06-22)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-656289630-1574871452=:13941"
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 152.66.115.2
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
Cc: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Aaron Dominick <aaron.zakhrov@gmail.com>,
 kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-656289630-1574871452=:13941
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On Wed, 27 Nov 2019, Daniel P. Berrang=C3=A9 wrote:
> On Wed, Nov 27, 2019 at 04:00:01PM +0100, Philippe Mathieu-Daud=C3=A9 w=
rote:
>> Hi Daniel, Aaron.
>>
>> On 11/26/19 3:19 PM, Daniel P. Berrang=C3=A9 wrote:
>>> On Tue, Nov 26, 2019 at 06:14:27PM +0530, aaron.zakhrov@gmail.com wro=
te:
>>>> From: Aaron Dominick <aaron.zakhrov@gmail.com>
>>>>
>>>> I have removed the botched patches and have got the code working upt=
o the GART initialization.
>>>> I am not sure how to implement the GART. I am guessing it should be =
an IOMMU device but I think that is a bit much for an emulated card.
>>>> The earlier problem of display probing seems to be resolved by using=
 an R300 bios I got from TechPowerUP's GPU database:
>>>>
>>>> 	https://www.techpowerup.com/vgabios/14509/14509
>>>> I am NOT sure if we can distribute it in the QEMU source tree. If it
>>>> does cause problems I can send a patch to remove it.
>>>
>>> That site seems to be a repository of BIOS uploaded by arbitrary user=
s,
>>> with no information on what license terms might apply to the uploads.
>>>
>>> We have to therefore assume the worst and treat the BIOS images on th=
at
>>> site as proprietary and not re-distributable, despite the fact that t=
he
>>> site itself is acting as a 3rd party distributor.
>>
>> We can not redistribute this BIOS.
>>
>>> IOW, we can't have this in QEMU git I'm afraid, unless someone can fi=
nd
>>> a trustworthy vendor source for the original image with accompanying
>>> license information.
>>
>> Daniel, I think there is no problem if Aaron contributes a model of th=
e R300
>> device to QEMU, right? This doesn't involve redistributing any BIOS.
>
> Having just the device impl doesn't cause any legal problems.
>
> It does become a slight usability issue, as any users need to go and fi=
nd
> the suitable BIOS in order to use the device. No downstream OS vendors =
are
> going to be able to distribute this BIOS either

We may be able to avoid this problem if we identify what the driver needs=
=20
from the BIOS and implement that in our vgabios. Gerd has already added=20
some tables that some drivers need in the latest vgabios version that's=20
currently in git master (but those were for Rage128 and RV100 that ati-vg=
a=20
currently implements). Aaron, did you try with latest git master and does=
=20
that still need a BIOS from a real card or if so do you happen to know=20
what the driver needs from the BIOS? (It may be some tables/structure or=20
BIOS calls that the QEMU vgabios-ati does not implement yet.) If that's=20
not too difficult to add it may be implemented in QEMU's vgabios to avoid=
=20
needing proprietary blobs. It could also be EDID access that may use=20
different registers on R300 but I think that may be simple to fix if more=
=20
details are known.

> I don't know if we have hit this problem before & if we have any
> general policies about it ?

I don't know but this may be similar to boards needing firmware ROMs or=20
the firmware blobs needed by some Linux kernel drivers. How are those
handled? Distros usually put them in a non-free repo I think.

Regrads,
BALATON Zoltan
--3866299591-656289630-1574871452=:13941--

