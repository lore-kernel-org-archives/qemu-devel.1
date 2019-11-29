Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0162EC432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 18:06:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD8D221721
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 18:06:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD8D221721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iakfK-00045V-0M
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 13:06:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58674)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1iakbv-00022U-7U
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 13:03:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1iakbt-0006Z8-9m
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 13:03:18 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:20538)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1iakbs-0006BB-Do
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 13:03:17 -0500
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 49C1C7456ED;
 Fri, 29 Nov 2019 19:03:05 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 27A577456CD; Fri, 29 Nov 2019 19:03:05 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 23E9474568D;
 Fri, 29 Nov 2019 19:03:05 +0100 (CET)
Date: Fri, 29 Nov 2019 19:03:05 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Aaron Zakhrov <aaron.zakhrov@gmail.com>
Subject: Re: [RFC 00/10] R300 QEMU device V2
In-Reply-To: <CAApBzg9c9rwgAd1forny9QGgz8-fA60QBcRQbsMSmTwB_h12pQ@mail.gmail.com>
Message-ID: <alpine.BSF.2.21.99999.352.1911291837080.15049@zero.eik.bme.hu>
References: <20191126124433.860-1-aaron.zakhrov@gmail.com>
 <20191126141924.GQ556568@redhat.com>
 <09273ecd-be76-ab61-304f-7ea0f1f0b107@redhat.com>
 <20191127150520.GG2131806@redhat.com>
 <20191127161210.ractqwwymzkpbu6n@sirius.home.kraxel.org>
 <20191127163219.GI2131806@redhat.com>
 <CAApBzg9c9rwgAd1forny9QGgz8-fA60QBcRQbsMSmTwB_h12pQ@mail.gmail.com>
User-Agent: Alpine 2.21.99999 (BSF 352 2019-06-22)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2001:738:2001:2001::2001
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
 =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,

On Thu, 28 Nov 2019, Aaron Zakhrov wrote:
> I tested my code with the vgabios-ati.bin rom file and it seems to get
> passed the earlier issue I had.

Good, so then the BIOS problem seems to be sorted for now. (Maybe it 
needed the tables or EDID support that some drivers use from the VGA 
BIOS.)

> I have cleaned up my code and have sent a new patch series. The new one is

I still got pathces twice so rebase may not have worked completely and 
changes are still not separate patches but hopefully there are less 
unnecessary files in the last series. If you have problem with rebase and 
using git to rework patches you could also start from a clean git tree 
then apply patches with patch command and make new separate commits to 
clean them up. This may be easier to do until you get familiar with git's 
more obscure commands.

> pretty big but it contains only the necessary header files and it should be
> a little easier to review

I don't have time now to check all the added registers but is there a 
reason you're targetting r300 instead of trying to make rv100 working 
first? RV100 is a simpler chip with less features so you probably will 
have less to implement and it's also clearer what might be needed than 
having to implement a lot of new features the newer r300 may have. Once 
rv100 works it may be easier to update that to r300 than going for that 
right away, at least that's what I thought. If you think you can do all of 
r300 features or you need that for some reason I'm fine with trying to 
target r300 just saying that a more incremental approach may be easier to 
do.

I haven't checked this but I think what you get now is that the driver is 
trying to set up shared memory buffers via GART that it will use to send 
command packets to the GPU that the emulated chip will need to parse and 
convert to register access. This is the microengine/command 
processor/CCE/PM4 I've referred to before. Unless we implement this in 
some way it won't work as communication between the driver and card is 
done using this facility so this should be the next step before adding 
more registers and emulation. If you search for "ati microengine" it may 
turn up some documentation on this where the buffers and command packets 
are described but the actual microengine and it's microcode appears to be 
undocumented. I've also said before that Xenia emulator has some code to 
parse command packets of the XBox 360 GPU which is similar to some late 
r5xx GPUs so some of these might be useful for emulating previous Radeons 
as well.

Regards,
BALATON Zoltan

