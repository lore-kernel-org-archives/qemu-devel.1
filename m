Return-Path: <SRS0=vrBk=VF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35FF8C606D1
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 22:54:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B9A0216FD
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 22:54:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B9A0216FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=oakgatetech.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkcX4-0005i9-4M
	for qemu-devel@archiver.kernel.org; Mon, 08 Jul 2019 18:54:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55955)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <matt.fitzpatrick@oakgatetech.com>)
 id 1hkcVP-00051d-SH
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 18:53:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <matt.fitzpatrick@oakgatetech.com>)
 id 1hkcVO-0001u4-Jj
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 18:53:07 -0400
Received: from p3plmtsmtp01.prod.phx3.secureserver.net ([184.168.131.12]:57454)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <matt.fitzpatrick@oakgatetech.com>)
 id 1hkcVO-0001tN-E1
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 18:53:06 -0400
Received: from n06.mail01.mtsvc.net ([216.70.64.26]) by :MT-SMTP: with ESMTP
 id kcUqhYyqPywc7kcUqhGq55; Mon, 08 Jul 2019 15:52:32 -0700
X-SID: kcUqhYyqPywc7
Received: from 76-14-151-140.rk.wavecable.com ([76.14.151.140]:17548
 helo=[10.10.0.64])
 by n06.mail01.mtsvc.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
 (Exim 4.92) (envelope-from <matt.fitzpatrick@oakgatetech.com>)
 id 1hkcUp-00085F-W5; Mon, 08 Jul 2019 18:52:32 -0400
To: keith.busch@intel.com, kwolf@redhat.com, mreitz@redhat.com,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
References: <8115eb18-38c0-2bd9-b7d7-2d0c96a106e7@oakgatetech.com>
 <20190705075000.GA17345@bogfinke>
From: Matt Fitzpatrick <matt.fitzpatrick@oakgatetech.com>
Message-ID: <3157dd16-4caa-2242-c568-c9a267f274ac@oakgatetech.com>
Date: Mon, 8 Jul 2019 15:52:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190705075000.GA17345@bogfinke>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Authenticated-User: 1274755 matt.fitzpatrick@oakgatetech.com
X-MT-ID: 4030CEC58F673A93EB94C0FECA0E49165788AD9E
X-CMAE-Envelope: MS4wfDRKJMo61FbGVfchejef+q6WMBPm2EHiwivdvAZn0lI5dbpBUWza5lMsEzfTVwyFpwWb0r3c51P38XtBOViofSrbynicc91TKAs3F9AFVXGSnzZT4fbg
 gMG62quIyEitp1j/V1LgqkLoTFVXeulOxMQaWbB+ofgRLGH6yVmNVY/Qjxlce9B2JiXP/HNEV2J21UXaqdjTHD64E3V3Ss6TQyT2DeqDqAAwpOX2Gf7shBqa
 P7bjx46giyDX6p1pvTLkoO/w1Ng0sbnFLK9SDG7NcT2ucdaftThuHddt366hfW6eH+KbqM7iSDqCJOYxXtNygg==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 184.168.131.12
Subject: Re: [Qemu-devel] [Qemu-block] [RFC, v1] Namespace Management Support
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

Hey Klaus,

Sorry for the late reply!  I finally found this message amid the pile of 
emails Qemu dumped on me.

I don't know what the right answer is here... NVMe is designed in a way 
where you *do* "carve up" the flash into logical groupings and the nvme 
firmware decides on how that's done. Those logical groupings can be 
attached to different controllers(which we don't have here yet?) after 
init, but that's a problem for future us I guess?But that's all stuff 
you already know.

The "nvme-nvm" solution might be the right approach, but I'm a bit 
hesitant on the idea of growing tnvmcap...

I can't think of any way to create namespaces on the fly and not have it 
use some single existing block backend, unless we defined a range of 
block images on qemu start and namespace create/attach only uses one 
image up to and including it's max size per namespace? That might work, 
and I think that's what you suggested (or at least is similar to), 
though it could be pretty wasteful. It wouldn't offer a "true" namespace 
management support, but could be close enough.

I'm in the middle of going through the patch you posted. Nice job!  I'm 
glad to see more people adding enhancements. It was pretty stale for years.

-Matt
On 7/5/19 12:50 AM, Klaus Birkelund wrote:
> On Tue, Jul 02, 2019 at 10:39:36AM -0700, Matt Fitzpatrick wrote:
>> Adding namespace management support to the nvme device. Namespace creation
>> requires contiguous block space for a simple method of allocation.
>>
>> I wrote this a few years ago based on Keith's fork and nvmeqemu fork and
>> have recently re-synced with the latest trunk.  Some data structures in
>> nvme.h are a bit more filled out that strictly necessary as this is also the
>> base for sr-iov and IOD patched to be submitted later.
>>
> Hi Matt,
>
> Nice! I'm always happy when new features for the nvme device is posted!
>
> I'll be happy to review it, but I won't start going through it in
> details because I believe the approach to supporting multiple namespaces
> is flawed. We had a recent discussion on this and I also got some
> unrelated patches rejected due to implementing it similarly by carving
> up the image.
>
> I have posted a long series that includes a patch for multiple
> namespaces. It is implemented by introducing a fresh `nvme-ns` device
> model that represents a namespace and attaches to a bus created by the
> parent `nvme` controller device.
>
> The core issue is that a qemu image /should/ be attachable to other
> devices (say ide) and not strictly tied to the one device model. Thus,
> we cannot just shove a bunch of namespaces into a single image.
>
> But, in light of your patch, I'm not convinced that my implementation is
> the correct solution. Maybe the abstraction should not be an `nvme-ns`
> device, but a `nvme-nvm` device that when attached changes TNVMCAP and
> UNVMCAP? Maybe you have some input for this? Or we could have both and
> dynamically create the nvme-ns devices on top of nvme-nvm devices. I
> think it would still require a 1-to-1 mapping, but it could be a way to
> support the namespace management capability.
>
>
> Cheers,
> Klaus
>

