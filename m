Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A5F1C47404
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 11:55:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3086220862
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 11:55:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3086220862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGMBT-0002Gn-MO
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 07:55:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51092)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sgarzare@redhat.com>) id 1iGLhf-0002dg-4r
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 07:24:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1iGLhe-0006E6-5m
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 07:24:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32309)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1iGLhd-0006Dj-Vu
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 07:24:54 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0B694882FB
 for <qemu-devel@nongnu.org>; Fri,  4 Oct 2019 11:24:53 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id g67so1488254wmg.4
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2019 04:24:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=7axWxPgFmUQkvDkucr6NN6Yf+hW64mG6LzF9pveMlE0=;
 b=DXoF+92GeSF9mQzJ4LIkuXe+XMFw7JM86L804ZJLGHWMcnyXLMr+PYlKlnKLgwB4Q5
 y5JNwXbN9hpObz1sJYfEIevHMDx9/B7UHLZh0TiBLLh8AzmF1MTuz2Cd/2Dy0ZgAqRyI
 H6rd0l5XS2hQw1AMiZiq1lR9EEGcRblcVPYUnCBI4ulvOMPFp5a16j8eQZNP5XJyNxB9
 zzUb8U16E6GDa7dKW59Skh/8rNoWUddilZW6eM2F85jk9s/nE6pWNn6kyE5cA0/dPAbW
 j4Q8sM/UxeO5fVdsDrKjpBanNRrdKBeyUuxdd7uT4F5cxkDqR5ei9HFuh2Q1QVwBMS3k
 aEdw==
X-Gm-Message-State: APjAAAUtEC0rplYHtcHcn114Jtg/x8dGq08EmbGoGY/xc3gNbiOaeJx2
 6ol+Z1HmZx9f331NgOiVN+CIguk5AbFvevI/oTw4uOeWPDjCeZod7uW6RSemw6a+/JjHxdS7l9V
 40QDxOWh0mJ9FMac=
X-Received: by 2002:a05:6000:b:: with SMTP id
 h11mr11197413wrx.270.1570188291722; 
 Fri, 04 Oct 2019 04:24:51 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzw8GpdeeYDHyku3BdBuIYvxKRzOs3ZTjzeZdxjiwIo83WT8DLfE3KykXpDwRJKQXgbC38gbg==
X-Received: by 2002:a05:6000:b:: with SMTP id
 h11mr11197389wrx.270.1570188291509; 
 Fri, 04 Oct 2019 04:24:51 -0700 (PDT)
Received: from steredhat (host174-200-dynamic.52-79-r.retail.telecomitalia.it.
 [79.52.200.174])
 by smtp.gmail.com with ESMTPSA id h17sm9425337wme.6.2019.10.04.04.24.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Oct 2019 04:24:51 -0700 (PDT)
Date: Fri, 4 Oct 2019 13:24:48 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Sergio Lopez <slp@redhat.com>
Subject: Re: [PATCH v6 02/10] hw/i386/pc: rename functions shared with non-PC
 machines
Message-ID: <20191004112448.al4a43434lebab6w@steredhat>
References: <20191004093752.16564-1-slp@redhat.com>
 <20191004093752.16564-3-slp@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191004093752.16564-3-slp@redhat.com>
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

On Fri, Oct 04, 2019 at 11:37:44AM +0200, Sergio Lopez wrote:
> The following functions are named *pc* but are not PC-machine specific
> but generic to the X86 architecture, rename them:
> 
>   load_linux                 -> x86_load_linux
>   pc_new_cpu                 -> x86_new_cpu
>   pc_cpus_init               -> x86_cpus_init
>   pc_cpu_index_to_props      -> x86_cpu_index_to_props
>   pc_get_default_cpu_node_id -> x86_get_default_cpu_node_id
>   pc_possible_cpu_arch_ids   -> x86_possible_cpu_arch_ids
>   old_pc_system_rom_init     -> x86_system_rom_init
> 
> Signed-off-by: Sergio Lopez <slp@redhat.com>
> ---
>  include/hw/i386/pc.h |  2 +-
>  hw/i386/pc.c         | 28 ++++++++++++++--------------
>  hw/i386/pc_piix.c    |  2 +-
>  hw/i386/pc_q35.c     |  2 +-
>  hw/i386/pc_sysfw.c   |  6 +++---
>  5 files changed, 20 insertions(+), 20 deletions(-)
> 

LGTM!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano

