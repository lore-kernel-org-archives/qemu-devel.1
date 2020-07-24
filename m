Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94204C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 13:17:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64EFF2065F
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 13:17:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64EFF2065F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyxaA-0002qr-ML
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 09:17:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41410)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <a.lauterer@proxmox.com>)
 id 1jyxZe-0002S6-DX
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 09:17:18 -0400
Received: from proxmox-new.maurer-it.com ([212.186.127.180]:13848)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <a.lauterer@proxmox.com>)
 id 1jyxZb-00084o-DO
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 09:17:18 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 3DA0F432DC;
 Fri, 24 Jul 2020 15:17:11 +0200 (CEST)
Subject: Re: Possible regression with VGA and resolutions in Windows 10?
To: Gerd Hoffmann <kraxel@redhat.com>
References: <24909a16-be74-7516-b5c5-08bdc743a553@proxmox.com>
 <20200724094120.dptmucij4phzd3od@sirius.home.kraxel.org>
From: Aaron Lauterer <a.lauterer@proxmox.com>
Message-ID: <1ee13b41-3ed7-8dd4-99b7-e325e95878d5@proxmox.com>
Date: Fri, 24 Jul 2020 15:17:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.0.1
MIME-Version: 1.0
In-Reply-To: <20200724094120.dptmucij4phzd3od@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=212.186.127.180;
 envelope-from=a.lauterer@proxmox.com; helo=proxmox-new.maurer-it.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 09:17:12
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 7/24/20 11:41 AM, Gerd Hoffmann wrote:
> On Thu, Jul 23, 2020 at 04:24:06PM +0200, Aaron Lauterer wrote:
>> Hi all,
>>
>> I think we have a regression introduced in commit 0221d73ce6.
>>
>> Once I start a Windows 10 VM (build 18363) with `-device VGA` I have only the following resolutions to choose from instead of the much longer list:
>>
>> 1920x1080
>> 1024x768
>> 800x600
> 
> That is probably vgabios gaining edid support.
> 
> The list should be longer though, the qemu edid block has more
> resolutions included.  The qemu-edid tool is a command line
> interface to the edid generator, for testing purposes.
> 
> Try "qemu-edid | edid-decode" to see the decoded edid data.
> 
> Linux guests have the raw edid block in sysfs, see
> /sys/class/drm/card0/card0-Virtual-1/edid.
> 
>>    -device 'VGA,id=vga,vgamem_mb=32,bus=pci.0,addr=0x2' \
> 
> Try adding "xres=<width>,yres=<height>" of you want a specific
> display resolution.
> 
> Try adding "edid=off" to return to previous behavior.

I did try that initially but it seemingly was ignored by Windows.

But I took another look at it and I was able to observe the following behavior with Win10:

Boot it first with edid enabled (by default) and I see only the short list of possible resolutions (I forgot 640x480, which is only shown in the Display Adapter Properties -> List all modes).

Boot it with edid=off and nothing changes, still the short list.
Uninstall the `Microsoft Basic Display Adapter` in Device Manager and reboot the VM. Now it recognizes all resolutions again.

The behavior is similar when setting a custom resolution with the xres and yres parameters. Setting it the first time works fine and it is shown along with the short list. Setting it to something different on the next boot will not be recognized unless the display adapter is uninstalled and the VM rebooted.

The same applies when changing from edid=off to edid=on. Only after uninstalling the display driver and a reboot will it change from showing the long list of resolution to the mentioned short one.


Knowing that uninstalling the display driver after setting edid=off will help is good enough for now.

Thanks for pointing that out again and nudging me in the right direction.

All the best,
Aaron


> 
> HTH & take care,
>    Gerd
> 
> 
> 


