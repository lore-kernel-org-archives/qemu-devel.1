Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C634C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 12:01:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FFA320714
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 12:01:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FFA320714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k01p9-0000Bv-Ib
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 08:01:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59840)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <a.lauterer@proxmox.com>)
 id 1k01o7-0007oh-So
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 08:00:41 -0400
Received: from proxmox-new.maurer-it.com ([212.186.127.180]:41956)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <a.lauterer@proxmox.com>)
 id 1k01o4-0003Mx-SZ
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 08:00:38 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 18C9C4333D;
 Mon, 27 Jul 2020 14:00:24 +0200 (CEST)
Subject: Re: Possible regression with VGA and resolutions in Windows 10?
To: Gerd Hoffmann <kraxel@redhat.com>
References: <24909a16-be74-7516-b5c5-08bdc743a553@proxmox.com>
 <20200724094120.dptmucij4phzd3od@sirius.home.kraxel.org>
 <1ee13b41-3ed7-8dd4-99b7-e325e95878d5@proxmox.com>
 <20200724141032.jmub3zixekeyy3x3@sirius.home.kraxel.org>
From: Aaron Lauterer <a.lauterer@proxmox.com>
Message-ID: <b07c74a8-c6dc-7428-983f-707d55b09f71@proxmox.com>
Date: Mon, 27 Jul 2020 14:00:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.0.1
MIME-Version: 1.0
In-Reply-To: <20200724141032.jmub3zixekeyy3x3@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=212.186.127.180;
 envelope-from=a.lauterer@proxmox.com; helo=proxmox-new.maurer-it.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 08:00:24
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

Hey,

On 7/24/20 4:10 PM, Gerd Hoffmann wrote:
> That still leaves the question open why the list of resolutions is that
> short  It should be more like this:
> 
> # qemu-edid | edid-decode | grep @
>    640x480@60Hz
>    800x600@60Hz
>    1024x768@60Hz
>    2048x1152@60Hz
>    1920x1080@60Hz
>      VIC 101 4096x2160@50Hz
>      VIC  96 3840x2160@50Hz
>      VIC  89 2560x1080@50Hz
>      VIC  31 1920x1080@50Hz
> 
> Seems windows filters out a bunch for some reason ...

When checking the Advanced Display Settings on can click on the "Display adaptor properties for Display 1". In that window one can click on "List all modes". In this list the 640x480 mode does show up.

The 2048x1152 does not show up anywhere, with edid on as well as when edid is off. So my guess is that this resolution is just not supported by the Windows Basic Display Adapter?
The same applies to the resolutions in the lines starting with VIC, though I did not check if the 1920x1080 is 60 or 50 Hz.

If there is anything else that I can do, let me know.

All the best,
Aaron


