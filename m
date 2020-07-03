Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DAE9C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 09:31:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FB90206A1
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 09:31:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FB90206A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrI2m-00072M-71
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 05:31:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33932)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1jrHmC-000402-4S
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 05:14:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:48350)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1jrHmA-0006YA-3I
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 05:14:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 71954AD2C;
 Fri,  3 Jul 2020 09:14:28 +0000 (UTC)
Subject: Re: [PULL 00/10] Modules 20200702 patches
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20200702122048.27798-1-kraxel@redhat.com>
From: Claudio Fontana <cfontana@suse.de>
Message-ID: <81e43374-25c7-5361-0ca3-04b26c0f4826@suse.de>
Date: Fri, 3 Jul 2020 11:14:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200702122048.27798-1-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=195.135.220.15; envelope-from=cfontana@suse.de;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 23:00:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello Gerd,

I think in general the idea to make it easier to modularize things is great,
is this thought for devices only, or could I rework my changes to support modularizing per-target AccelClass types and all the related code on top of your design?

Thanks,

Claudio

On 7/2/20 2:20 PM, Gerd Hoffmann wrote:
> The following changes since commit fc1bff958998910ec8d25db86cd2f53ff125f7ab:
> 
>   hw/misc/pca9552: Add missing TypeInfo::class_size field (2020-06-29 21:16:10 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kraxel.org/qemu tags/modules-20200702-pull-request
> 
> for you to fetch changes up to 474a5d66036d18ee5ccaa88364660d05bf32127b:
> 
>   chardev: enable modules, use for braille (2020-07-01 21:08:11 +0200)
> 
> ----------------------------------------------------------------
> qom: add support for qom objects in modules.
> build some devices (qxl, virtio-gpu, ccid, usb-redir) as modules.
> build braille chardev as module.
> 
> note: qemu doesn't rebuild objects on cflags changes (specifically
>       -fPIC being added when code is switched from builtin to module).
>       Workaround for resulting build errors: "make clean", rebuild.
> 
> ----------------------------------------------------------------
> 
> Gerd Hoffmann (10):
>   module: qom module support
>   object: qom module support
>   qdev: device module support
>   build: fix device module builds
>   ccid: build smartcard as module
>   usb: build usb-redir as module
>   vga: build qxl as module
>   vga: build virtio-gpu only once
>   vga: build virtio-gpu as module
>   chardev: enable modules, use for braille
> 
>  Makefile.objs            |  2 ++
>  Makefile.target          |  7 +++++
>  include/qemu/module.h    |  2 ++
>  include/qom/object.h     | 12 +++++++
>  chardev/char.c           |  2 +-
>  hw/core/qdev.c           |  6 ++--
>  qdev-monitor.c           |  5 +--
>  qom/object.c             | 14 +++++++++
>  qom/qom-qmp-cmds.c       |  3 +-
>  softmmu/vl.c             |  4 +--
>  util/module.c            | 67 ++++++++++++++++++++++++++++++++++++++++
>  chardev/Makefile.objs    |  5 ++-
>  hw/Makefile.objs         |  2 ++
>  hw/display/Makefile.objs | 28 ++++++++++-------
>  hw/usb/Makefile.objs     | 13 +++++---
>  15 files changed, 148 insertions(+), 24 deletions(-)
> 


