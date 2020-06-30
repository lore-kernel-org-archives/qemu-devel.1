Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1321C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 20:50:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FB7A20702
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 20:50:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FB7A20702
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqNCj-0003gI-Tm
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 16:50:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38328)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jqNBy-0003AR-9m; Tue, 30 Jun 2020 16:49:22 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:20104)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jqNBv-0003Xr-5e; Tue, 30 Jun 2020 16:49:21 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id E132F74633F;
 Tue, 30 Jun 2020 22:49:06 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id B627774633E; Tue, 30 Jun 2020 22:49:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id B4CC8746333;
 Tue, 30 Jun 2020 22:49:06 +0200 (CEST)
Date: Tue, 30 Jun 2020 22:49:06 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: Re: [PATCH v7 0/8] Mac Old World ROM experiment
In-Reply-To: <5057ce7a-8e34-5b07-e93b-9cf8976fa3b2@ilande.co.uk>
Message-ID: <alpine.BSF.2.22.395.2006302219090.46417@zero.eik.bme.hu>
References: <cover.1593456926.git.balaton@eik.bme.hu>
 <5057ce7a-8e34-5b07-e93b-9cf8976fa3b2@ilande.co.uk>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Howard Spoelstra <hsp.cat7@gmail.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 30 Jun 2020, Mark Cave-Ayland wrote:
> On 29/06/2020 19:55, BALATON Zoltan wrote:
>> This is now a minimal set of patches needed to make it possible to
>> experiment with a firmware ROM from real hardware. After finding out
>> that the board firmware does not probe PCI devices but expects them at
>> known fixed addresses we only need to change the address of the macio
>> device to get the firmware correctly map it. This allows dropping
>> workarounds in previous versions for this and now only the minimal set
>> of patches are included to get the firmware loaded and do something.
>> (Also excluded the grackle revision and machine ID pathes for now that
>> may be needed as the firmware accesses these but seems to go further
>> without them so until we hit a problem we can live without it,
>> although I wonder if this causes us unnecessary debugging later so
>> unless they cause regressions they could be merged).
>>
>> I still don't get video output but at least it talks to the GPU chip
>> now so it can be debugged and improved (this will either need
>> emulating the correct chip the firmware has a driver for or an OF
>> compliant ROM for the emulated card).
>>
>> As before the I2C part (patches 6-8) is RFC and unfinished but the
>> first 5 patches should be good enough now. I hope someone can take
>> care of I2C, I can look at the ati-vga side later.
>
> If you can sort out the issue with masking in patches 1 and 2 then I'd be happy to

Patch 2 does not have masking only patch 1, I'll try to have a look and 
reply to that message.

> take patches 1-5. Obviously there is still some discussion around the i2c part, so I
> can wait a few more days to see what the outcome is there: the patches generally seem

The fix to i2c API would be welcome (not sure it will be resolved in a few 
days but we'll see) but it's not the main problem that makes patch 7 RFC. 
Rather the hardcoded returning 5 bytes in cuda_cmd_combined_iic() which is 
probably not how CUDA should work (apart from that I'm also not sure 
cuda_cmd_get_set_iic() is correct) but

1. I don't know how CUDA works
2. Don't have time and interest in larger CUDA model refactoring

so I've only made the changes needed to be able to test the ROM and 
identify what needs to be fixed. This CUDA I2C is one thing that someone 
with more knowledge/interest may want to look at in more detail. If 
there's nobody to make a better patch now maybe we can test if this breaks 
anything and once the I2C API changes settle down I can rebase it as it 
is, maybe also removing i2c attempts from cuda_cmd_get_set_iic() only 
leaving a log there is better as that command only seems to be used to 
access not yet emulated devices and always returns error at the moment 
anyway not reaching any of the i2c calls in there (I think it may be the 
audio mixer device the ROM tries to poke with this command but I'm not 
sure, I've also seen another i2c address, could be some sensor?, maybe 
DingusPPC has some info on these i2c devices but haven't checked it). 
Anyway, this i2c part is not urgent and can come back to it later. If we 
get in the first 5 patches now that would clean my tree sufficiently to 
only leave patches I intend to change later and get rid of the finished 
ones so I have less patches piling up.

> okay, the one change I would like to see is to add a comment around the SPD parts
> mentioning that these are only used by the real G3 ROM and not OpenBIOS.

This patch also has a dependency on spd_data_generate() API that probably 
won't get fixed before the freeze unless I submit a patch but not sure 
I'll have time for that, also it's not useful without the previous I2C 
patch so again we can see where this goes and come back to it with the I2C 
part.

> My only concern is whether an incomplete i2c implementation could cause OSs that
> currently boot to hang, so it is important that you can test a variety of OS images
> from MacOS to Linux and BSD to ensure that it doesn't cause any regression.

I neither have these images nor time to test all of them so I hoped you 
could do this as part of your merge testing or someone else can help out 
here with testing.

Regards,
BALATON Zoltan

