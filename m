Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D17E7C2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 15:49:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E2182223E
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 15:49:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZF29dAzN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E2182223E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL71e-0001q6-Df
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 11:49:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41682)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kL707-0001Ll-DQ
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 11:48:11 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:30389
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kL704-00012l-On
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 11:48:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600876087;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E9bl8ebtuTnrH81wEbQgixWP+tS22orJjpPaugkX/Ds=;
 b=ZF29dAzNXKBt6mSX28AmzB1ZIqmM0pXKYXpIPz8HFGMgTXPBGy1afI3sJTn4YEbJelqzVK
 yQQl7HXzQmBuQxCrKZkFcy/RwENOwl3L75x313G9piHHflbZ0+mBg/roKkD2ziCNnlA82B
 R2dkVFD+NbRlSIJmOSLnVd4EZKIOp4E=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-561-FAv1CDfKP_Kd8UE82fV-fA-1; Wed, 23 Sep 2020 11:47:58 -0400
X-MC-Unique: FAv1CDfKP_Kd8UE82fV-fA-1
Received: by mail-wr1-f71.google.com with SMTP id a2so8961371wrp.8
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2020 08:47:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=E9bl8ebtuTnrH81wEbQgixWP+tS22orJjpPaugkX/Ds=;
 b=jPRWtm2rs9hGsJzGm9Oeb38k2zEVhKzdGsLpBNL2zdeokeHAU2HMSWwNCNuM0AAwd5
 9QQetJC0jxROveTbvotLedr9zyyOI9xWS7WSnoTLOohB+znbQjB4+ZeawjBL177UnY5N
 YYfmWPvo9VzVzwXcmATgWT3IV5sFqu6A5cnDa88XM8zweXwAaJO0kh1cw8NhNYii+fYG
 MeMYp7sO8MAZg6WmP+RUR5A0ntBSGpur35g9P3HILgTBf+ANfLFynXyyM4/0+ZDE1evb
 QRjbrq0y5F/8BnwBTtb8vKjUaDRsCL6DBXmWW6F7c24f/GCT/9tY5OXXVu0hNt4+hZyq
 YQGw==
X-Gm-Message-State: AOAM532xiLYdN3O+aP+VocJogApFOYqgvW6W5DCQ2GtZDP7ZlcplTtAB
 I7Ne5AGQ93+TnBkHqgUiQxAGFeWLzgTpbpmfvbbhcgf8x4ql5xHutfZ0xnfBEXC4io5ep2zn+u2
 JkSzAJN49ZxNpcYE=
X-Received: by 2002:a5d:4247:: with SMTP id s7mr270864wrr.167.1600876076783;
 Wed, 23 Sep 2020 08:47:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz3rrC+IdPzTs0iYFvS0QHCNVAuCWZFWq//pPVbkxoHEPfTao//c4+tVdM3fz/F8E9F7PBezA==
X-Received: by 2002:a5d:4247:: with SMTP id s7mr270822wrr.167.1600876076525;
 Wed, 23 Sep 2020 08:47:56 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id q12sm207952wrs.48.2020.09.23.08.47.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2020 08:47:55 -0700 (PDT)
Date: Wed, 23 Sep 2020 11:47:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: elena.ufimtseva@oracle.com
Subject: Re: [PATCH v9 00/20] Initial support for multi-process Qemu
Message-ID: <20200923114652-mutt-send-email-mst@kernel.org>
References: <20200827181231.22778-1-elena.ufimtseva@oracle.com>
MIME-Version: 1.0
In-Reply-To: <20200827181231.22778-1-elena.ufimtseva@oracle.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 08:52:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: fam@euphon.net, john.g.johnson@oracle.com, swapnil.ingle@nutanix.com,
 qemu-devel@nongnu.org, kraxel@redhat.com, jag.raman@oracle.com,
 quintela@redhat.com, armbru@redhat.com, kanth.ghatraju@oracle.com,
 felipe@nutanix.com, thuth@redhat.com, ehabkost@redhat.com,
 konrad.wilk@oracle.com, dgilbert@redhat.com, stefanha@redhat.com,
 thanos.makatos@nutanix.com, rth@twiddle.net, kwolf@redhat.com,
 berrange@redhat.com, mreitz@redhat.com, ross.lagerwall@citrix.com,
 marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 27, 2020 at 11:12:11AM -0700, elena.ufimtseva@oracle.com wrote:
> From: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> 
> Hello
> 
> This is the v9 of the patchset. Thank you very much for the
> detailed feedback for v8. We appreciate your time. We believe
> we have address all the comments for v8 in the current series.
> Special thanks to Stefan Hajnoczi.

I think overall it's in a good shape.
IIUC migration isn't supported yet so needs to be blocked.
But otherwise I don't see why we won't merge this and
interate on features upstream.

> The v9 has the following changes:
> - Communication channel. Qemu side uses blocking call to send
>   and receive the message from the remote and cannot progress
>   further until the remote side replies. Enhanced the
>   communication channel by dropping iothread lock before blocking
>   on Qemu end. Use the co-routines on the remote end to avoid
>   blocking QMP monitor;
> - removed the heartbeat functionality, it will be added later
>   in a full extent;
> - fixed leaked errors and similar fixes;
> - eliminated bytestream passing over the channel;
> - The build system had to be changed in order to accomodate the
>   latest changes in Qemu to use Kconfig/mason.
> 
> To touch upon the history of this project, we posted the
> Proof Of Concept patches before the BoF session in 2018.
> Subsequently, we posted 8 versions on the qemu-devel mailist.
> You can find them by following the links below ([1] - [8]).
> 
> Following people contributed to the design and
> implementation of this project:
> Jagannathan Raman <jag.raman@oracle.com>
> Elena Ufimtseva <elena.ufimtseva@oracle.com>
> John G Johnson <john.g.johnson@oracle.com>
> Stefan Hajnoczi <stefanha@redhat.com>
> Konrad Wilk <konrad.wilk@oracle.com>
> Kanth Ghatraju <kanth.ghatraju@oracle.com>
> 
> We would like to thank QEMU community for your feedback in the
> design and implementation of this project.
> 
> Qemu wiki page:
> https://wiki.qemu.org/Features/MultiProcessQEMU
> 
> For the full concept writeup about QEMU multi-process, please refer to
> docs/devel/qemu-multiprocess.rst. Also see docs/qemu-multiprocess.txt for
> usage information.
> 
> We welcome all your ideas, concerns, and questions for this patchset.
> 
> [POC]: https://www.mail-archive.com/qemu-devel@nongnu.org/msg566538.html
> [1]: https://www.mail-archive.com/qemu-devel@nongnu.org/msg602285.html
> [2]: https://www.mail-archive.com/qemu-devel@nongnu.org/msg624877.html
> [3]: https://www.mail-archive.com/qemu-devel@nongnu.org/msg642000.html
> [4]: https://www.mail-archive.com/qemu-devel@nongnu.org/msg655118.html
> [5]: https://www.mail-archive.com/qemu-devel@nongnu.org/msg682429.html
> [6]: https://www.mail-archive.com/qemu-devel@nongnu.org/msg697484.html
> [7]: https://patchew.org/QEMU/cover.1593273671.git.elena.ufimtseva@oracle.com/
> [8]: https://www.mail-archive.com/qemu-devel@nongnu.org/msg727007.html
> 
> Elena Ufimtseva (8):
>   multi-process: add qio channel function to transmit
>   multi-process: define MPQemuMsg format and transmission functions
>   multi-process: define transmission functions in remote
>   multi-process: introduce proxy object
>   multi-process: add proxy communication functions
>   multi-process: Forward PCI config space acceses to the remote process
>   multi-process: perform device reset in the remote process
>   multi-process: add configure and usage information
> 
> Jagannathan Raman (11):
>   memory: alloc RAM from file at offset
>   multi-process: Add config option for multi-process QEMU
>   multi-process: setup PCI host bridge for remote device
>   multi-process: setup a machine object for remote device process
>   multi-process: Initialize message handler in remote device
>   multi-process: Associate fd of a PCIDevice with its object
>   multi-process: setup memory manager for remote device
>   multi-process: PCI BAR read/write handling for proxy & remote
>     endpoints
>   multi-process: Synchronize remote memory
>   multi-process: create IOHUB object to handle irq
>   multi-process: Retrieve PCI info from remote process
> 
> John G Johnson (1):
>   multi-process: add the concept description to
>     docs/devel/qemu-multiprocess
> 
>  MAINTAINERS                     |  26 +
>  backends/hostmem-memfd.c        |   2 +-
>  configure                       |  10 +
>  docs/devel/index.rst            |   1 +
>  docs/devel/multi-process.rst    | 966 ++++++++++++++++++++++++++++++++
>  docs/multi-process.rst          |  67 +++
>  exec.c                          |  11 +-
>  hw/i386/meson.build             |   5 +
>  hw/i386/remote-iohub.c          | 123 ++++
>  hw/i386/remote-memory.c         |  58 ++
>  hw/i386/remote-msg.c            | 263 +++++++++
>  hw/i386/remote-obj.c            | 140 +++++
>  hw/i386/remote.c                |  79 +++
>  hw/misc/ivshmem.c               |   3 +-
>  hw/pci-host/meson.build         |   1 +
>  hw/pci-host/remote.c            |  75 +++
>  hw/pci/memory-sync.c            | 210 +++++++
>  hw/pci/meson.build              |   3 +
>  hw/pci/proxy.c                  | 363 ++++++++++++
>  include/exec/memory.h           |   2 +
>  include/exec/ram_addr.h         |   2 +-
>  include/hw/i386/remote-iohub.h  |  42 ++
>  include/hw/i386/remote-memory.h |  19 +
>  include/hw/i386/remote-obj.h    |  42 ++
>  include/hw/i386/remote.h        |  35 ++
>  include/hw/pci-host/remote.h    |  31 +
>  include/hw/pci/memory-sync.h    |  27 +
>  include/hw/pci/pci_ids.h        |   3 +
>  include/hw/pci/proxy.h          |  54 ++
>  include/io/channel.h            |  24 +
>  include/io/mpqemu-link.h        | 110 ++++
>  include/qemu/mmap-alloc.h       |   3 +-
>  io/channel.c                    |  45 ++
>  io/meson.build                  |   2 +
>  io/mpqemu-link.c                | 347 ++++++++++++
>  meson.build                     |   1 +
>  scripts/mpqemu-launcher.py      |  49 ++
>  softmmu/memory.c                |   3 +-
>  util/mmap-alloc.c               |   7 +-
>  util/oslib-posix.c              |   2 +-
>  40 files changed, 3243 insertions(+), 13 deletions(-)
>  create mode 100644 docs/devel/multi-process.rst
>  create mode 100644 docs/multi-process.rst
>  create mode 100644 hw/i386/remote-iohub.c
>  create mode 100644 hw/i386/remote-memory.c
>  create mode 100644 hw/i386/remote-msg.c
>  create mode 100644 hw/i386/remote-obj.c
>  create mode 100644 hw/i386/remote.c
>  create mode 100644 hw/pci-host/remote.c
>  create mode 100644 hw/pci/memory-sync.c
>  create mode 100644 hw/pci/proxy.c
>  create mode 100644 include/hw/i386/remote-iohub.h
>  create mode 100644 include/hw/i386/remote-memory.h
>  create mode 100644 include/hw/i386/remote-obj.h
>  create mode 100644 include/hw/i386/remote.h
>  create mode 100644 include/hw/pci-host/remote.h
>  create mode 100644 include/hw/pci/memory-sync.h
>  create mode 100644 include/hw/pci/proxy.h
>  create mode 100644 include/io/mpqemu-link.h
>  create mode 100644 io/mpqemu-link.c
>  create mode 100755 scripts/mpqemu-launcher.py
> 
> -- 
> 2.25.GIT


