Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E1D9C47404
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 11:55:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 675A020862
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 11:55:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 675A020862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGMBV-0002GQ-AJ
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 07:55:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55539)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sgarzare@redhat.com>) id 1iGM6D-0004q5-Qs
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 07:50:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1iGM6B-0001rc-1V
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 07:50:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53762)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1iGM6A-0001qd-Re
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 07:50:14 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1E7CE69080
 for <qemu-devel@nongnu.org>; Fri,  4 Oct 2019 11:50:13 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id f63so1512090wma.7
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2019 04:50:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=IeQDfqEDiaOIX9D/Z7G68K2MD86xoGirbsLN/kUjxvk=;
 b=X47DrNknS1hSANY3yGO1IizWGe9dtwOWXhaEHJs/OU9JvvQGaIVoVd5LA01sl9HMiU
 P4a4b+EdGtzH/wrZ+VutoOHYtPT1OzaJF2i881S4rFSlPoia1UtnvJAcwTszjaQ57SZY
 vK5ELdokfqWT0nvl2H9E2r+Kj25RPyYJUu7X+Tio8HM2Ezw1x9TpuX6izfqikexqxzcR
 rSG5da1HgaA2EdzPcWx/JV9q831EXVAWFpFNPPFtKhL07LujvzSnG2E54T12IQiIMCfo
 mU7fZ4zXkUzI7DLAIjR5sSDOXYVF6HKtl+AAboz9Fwhy/erpIGHCecBpr4wrnHdjWsxi
 z0LQ==
X-Gm-Message-State: APjAAAUabvpdPQWnO7Vj+A1/K2fDd/bCKAJmR0083T3R1Ig8sCneW6ng
 3jUnb7J9v5QZTTHCbwAP+3ez2BNlelF4EvOxVkx4KxeEGyiwDQfWa25CjX8xFyEYFugpEeS+9JB
 1eXdA9nnstU5ox5A=
X-Received: by 2002:adf:b3d2:: with SMTP id x18mr11863321wrd.264.1570189811739; 
 Fri, 04 Oct 2019 04:50:11 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxHfJCTmDaBu3UkVfAVzZwF6fMiDDxwAgYxiQ0l9prsSauK+UucboFWLxbGePv+RQpALLkXBw==
X-Received: by 2002:adf:b3d2:: with SMTP id x18mr11863298wrd.264.1570189811510; 
 Fri, 04 Oct 2019 04:50:11 -0700 (PDT)
Received: from steredhat (host174-200-dynamic.52-79-r.retail.telecomitalia.it.
 [79.52.200.174])
 by smtp.gmail.com with ESMTPSA id s10sm8925374wmf.48.2019.10.04.04.50.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Oct 2019 04:50:11 -0700 (PDT)
Date: Fri, 4 Oct 2019 13:50:08 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Sergio Lopez <slp@redhat.com>
Subject: Re: [PATCH v6 08/10] roms: add microvm-bios (qboot) as binary and
 git submodule
Message-ID: <20191004115008.rx2ory7yixbc4nny@steredhat>
References: <20191004093752.16564-1-slp@redhat.com>
 <20191004093752.16564-9-slp@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191004093752.16564-9-slp@redhat.com>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: ehabkost@redhat.com, mst@redhat.com, lersek@redhat.com,
 qemu-devel@nongnu.org, kraxel@redhat.com, pbonzini@redhat.com,
 imammedo@redhat.com, philmd@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 04, 2019 at 11:37:50AM +0200, Sergio Lopez wrote:
> qboot is a minimalist x86 firmware for booting Linux kernels. It does
> the mininum amount of work required for the task, and it's able to
> boot both PVH images and bzImages without relying on option roms.
> 
> This characteristics make it an ideal companion for the microvm
> machine type.
> 
> Signed-off-by: Sergio Lopez <slp@redhat.com>
> ---
>  .gitmodules              |   3 +++
>  pc-bios/bios-microvm.bin | Bin 0 -> 65536 bytes
>  roms/Makefile            |   6 ++++++
>  roms/qboot               |   1 +
>  4 files changed, 10 insertions(+)
>  create mode 100755 pc-bios/bios-microvm.bin
>  create mode 160000 roms/qboot
> 
> diff --git a/.gitmodules b/.gitmodules
> index c5c474169d..19792c9a11 100644
> --- a/.gitmodules
> +++ b/.gitmodules
> @@ -58,3 +58,6 @@
>  [submodule "roms/opensbi"]
>  	path = roms/opensbi
>  	url = 	https://git.qemu.org/git/opensbi.git
> +[submodule "roms/qboot"]
> +	path = roms/qboot
> +	url = https://github.com/bonzini/qboot
> diff --git a/pc-bios/bios-microvm.bin b/pc-bios/bios-microvm.bin
> new file mode 100755

Others rom have 644 permissions, should we be aligned or doesn't matter?

Anyway this patch LGTM:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

