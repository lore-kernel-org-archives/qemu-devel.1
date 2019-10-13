Return-Path: <SRS0=Jehb=YG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A7CC4360C
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2019 06:39:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8C84206B7
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2019 06:39:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8C84206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJXXD-0006vU-R8
	for qemu-devel@archiver.kernel.org; Sun, 13 Oct 2019 02:39:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42174)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iJXUP-0004Yn-39
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 02:36:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iJXUN-0003fr-V2
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 02:36:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33134)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iJXUI-0003dW-Ry
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 02:36:22 -0400
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id F3CDC5859E
 for <qemu-devel@nongnu.org>; Sun, 13 Oct 2019 06:36:16 +0000 (UTC)
Received: by mail-qk1-f199.google.com with SMTP id q80so13545056qke.22
 for <qemu-devel@nongnu.org>; Sat, 12 Oct 2019 23:36:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=7vODCfllsU4kKshm203lCMks0cTEj6jk4N9B4vR8nAA=;
 b=c48xvt8b9dsqM8GL6b2oL3TqQtkLvw3+MGK6FLFKliPR07EyNtt+hoMZCayCAlY8cT
 sOqwgqJ2jUAtpMawSPE2kGRK2+Lm+aTo+WDqKM7yLyy3H0aYY+CT/gina3mfBHiKWC4B
 tMOzdvODQZ20NsYSocBmQC3cL4swuRQqUnHV5YGnVOl6dx5EvPcB3v+JaLABkRviIG1N
 N3HOmNurE/a3vLm0bUNAFq7arGO53TD2F70W5f9/0f0zobl9yBKmzLMed6GPa1wUXj87
 gpsbwhUb3PIFhRasrzdgnGJjAMz0JvalNGIL7HCA2aiAm9obfLZL/LjjPWDALcLbq8Qc
 IuPg==
X-Gm-Message-State: APjAAAUu+MP9Vh1dU3L5q45i+X/M7bcTPeMUzE+hM54y0E8FDgq3YUJl
 9Ylh4xI6TQFEoBDQgRGROVp+5bXhfDGX0ADN+dR1XydNUHI8NADWelD/R6hySh4Ve3rF3bttkx6
 F/DolVcO3OuJIh+4=
X-Received: by 2002:ad4:4431:: with SMTP id e17mr24737278qvt.78.1570948576308; 
 Sat, 12 Oct 2019 23:36:16 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwcBtT+RUGwGYjUvYKvb5zIBQ2Ebg6+/apl3OauwLXjAvP0f0yFlmQLcsEVxu4HoFiVCN8qbw==
X-Received: by 2002:ad4:4431:: with SMTP id e17mr24737257qvt.78.1570948576066; 
 Sat, 12 Oct 2019 23:36:16 -0700 (PDT)
Received: from redhat.com (bzq-79-176-10-77.red.bezeqint.net. [79.176.10.77])
 by smtp.gmail.com with ESMTPSA id
 b22sm6589031qkc.58.2019.10.12.23.36.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Oct 2019 23:36:15 -0700 (PDT)
Date: Sun, 13 Oct 2019 02:36:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Wei Yang <richardw.yang@linux.intel.com>
Subject: Re: [PATCH 0/2] cleanup on page size
Message-ID: <20191013023555-mutt-send-email-mst@kernel.org>
References: <20191013021145.16011-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191013021145.16011-1-richardw.yang@linux.intel.com>
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
Cc: fam@euphon.net, mark.cave-ayland@ilande.co.uk, qemu-devel@nongnu.org,
 kraxel@redhat.com, den@openvz.org, qemu-block@nongnu.org, quintela@redhat.com,
 armbru@redhat.com, pasic@linux.ibm.com, borntraeger@de.ibm.com,
 marcandre.lureau@redhat.com, rth@twiddle.net, ehabkost@redhat.com,
 sw@weilnetz.de, dgilbert@redhat.com, yuval.shaia@oracle.com,
 alex.williamson@redhat.com, stefanha@redhat.com, pbonzini@redhat.com,
 david@gibson.dropbear.id.au, kwolf@redhat.com, cohuck@redhat.com,
 qemu-s390x@nongnu.org, mreitz@redhat.com, qemu-ppc@nongnu.org,
 imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Oct 13, 2019 at 10:11:43AM +0800, Wei Yang wrote:
> Patch 1 simplify the definition of xxx_PAGE_ALIGN.
> Patch 2 replaces getpagesize() with qemu_real_host_page_size. This one touch a
> volume of code. If some point is not correct, I'd appreciate your
> notification.


Pls queue at the trivial branch.

> Wei Yang (2):
>   cpu: use ROUND_UP() to define xxx_PAGE_ALIGN
>   core: replace getpagesize() with qemu_real_host_page_size
> 
>  accel/kvm/kvm-all.c            |  6 +++---
>  backends/hostmem.c             |  2 +-
>  block.c                        |  4 ++--
>  block/file-posix.c             |  9 +++++----
>  block/io.c                     |  2 +-
>  block/parallels.c              |  2 +-
>  block/qcow2-cache.c            |  2 +-
>  contrib/vhost-user-gpu/vugbm.c |  2 +-
>  exec.c                         |  6 +++---
>  hw/intc/s390_flic_kvm.c        |  2 +-
>  hw/ppc/mac_newworld.c          |  2 +-
>  hw/ppc/spapr_pci.c             |  2 +-
>  hw/rdma/vmw/pvrdma_main.c      |  2 +-
>  hw/vfio/spapr.c                |  7 ++++---
>  include/exec/cpu-all.h         |  7 +++----
>  include/exec/ram_addr.h        |  2 +-
>  include/qemu/osdep.h           |  4 ++--
>  migration/migration.c          |  2 +-
>  migration/postcopy-ram.c       |  4 ++--
>  monitor/misc.c                 |  2 +-
>  target/ppc/kvm.c               |  2 +-
>  tests/vhost-user-bridge.c      |  8 ++++----
>  util/mmap-alloc.c              | 10 +++++-----
>  util/oslib-posix.c             |  4 ++--
>  util/oslib-win32.c             |  2 +-
>  util/vfio-helpers.c            | 12 ++++++------
>  26 files changed, 55 insertions(+), 54 deletions(-)
> 
> -- 
> 2.17.1

