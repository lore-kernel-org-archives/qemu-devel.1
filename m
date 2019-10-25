Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C73DCCA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 11:35:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D6062070B
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 11:35:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D6062070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNxsN-0005TN-Pn
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 07:35:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44347)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iNxrB-0001um-QD
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 07:34:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iNxr9-0003sz-FG
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 07:34:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34938 helo=mx1.redhat.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iNxr9-0003Vv-9y
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 07:34:11 -0400
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D2742402302B
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 11:33:09 +0000 (UTC)
Received: by mail-qt1-f199.google.com with SMTP id t16so1725800qtp.11
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 04:33:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=+/F/K8JLRV6dLWaEYkQEoPx3I7eYvjlywqgtMblyIxg=;
 b=EgDsjapNrPvGjvIQuITkJWDwo8nPDh/XIPRUPwIXd11NAUO8DZ3qnKDItJTeoVDcZf
 94laliFWMFaCpxNpUKEuv+xwnnJVR5E+sekcJFdm+pG+ILsAppWS2zYEM+5U5TB4YY1j
 fag98y3uc8S9/Dw7Eiv05m4vjT7aTaHnh4Q7JTmUU3S4tNrn8g1wRs+h7vI30Od/f4IJ
 N4ksU3J/XD0MIJjVypN1/dcIFDz+swWgMNX800Xm4u57p4vhx4iDhwdPcqoPL7ZsO5CW
 aARZoUBsiWe2StbzNWRQDh1c8Po7tFjC3Cw2/+GimX+EXB0jcO3guAPKoDeNAJ+ENVFy
 swqw==
X-Gm-Message-State: APjAAAXAaCY9caVXxiQehQk378Lmx2kxub0Kt07rqVromcBB5fsu/TJT
 aDWWjT0kTlBXuEPm5UFu/g2s+Y6WzmbVavEq5fdtD760p/qQwv3UBFEIqifYxUw2s8IGAOHkxOO
 BmBLqCzJpxMpg4pI=
X-Received: by 2002:ae9:c304:: with SMTP id n4mr2480494qkg.20.1572003129410;
 Fri, 25 Oct 2019 04:32:09 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzI7uHZvq6HrXMwPpCGGwUbngC8uhTRWTX9VUiggoOjoXXmPTNfzppc67rP7mIo6RK6lVux9w==
X-Received: by 2002:ae9:c304:: with SMTP id n4mr2480471qkg.20.1572003129134;
 Fri, 25 Oct 2019 04:32:09 -0700 (PDT)
Received: from redhat.com (bzq-79-176-10-77.red.bezeqint.net. [79.176.10.77])
 by smtp.gmail.com with ESMTPSA id
 n56sm1243994qtb.73.2019.10.25.04.32.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2019 04:32:08 -0700 (PDT)
Date: Fri, 25 Oct 2019 07:32:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v4 00/16] libqos: add VIRTIO PCI 1.0 support
Message-ID: <20191025073127-mutt-send-email-mst@kernel.org>
References: <20191023100425.12168-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023100425.12168-1-stefanha@redhat.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 66.187.233.73
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
Cc: Fam Zheng <fam@euphon.net>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org, slp@redhat.com,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 Christophe de Dinechin <dinechin@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Oct 23, 2019 at 11:04:09AM +0100, Stefan Hajnoczi wrote:
> v4:
>  * Introduce bool d->features_negotiated so that tests can negotiate a
>    0 feature bit set in Legacy mode [Thomas]
>  * Make the FEATURES_OK code change in qvirtio_set_driver_ok() clearer and
>    mention it in the commit description [Thomas]
>  * Fix indentation in qvring_init() [Thomas]
> v3:
>  * Now implements VIRTIO 1.0 fully (vring, device initialization).
>    This required several new patches to address the following issues:
>    1. Tests that do not negotiate features (non-compliant!)
>    2. Tests that access configuration space before feature negotiation
>       (non-compliant!)
>    3. Tests that set up virtqueues before feature negotiation (non-compliant!)
>    4. vring accesses require byte-swapping when VIRTIO 1.0 is used with a
>       big-endian guest because the qtest_readX/writeX() API automatically
>       converts to guest-endian
>    5. VIRTIO 1.0 has an additional FEATURES_OK step during Device
>       Initialization
>  * Change uint8_t bar_idx to int [Thomas]
>  * Document qpci_find_capability() [Thomas]
>  * Every commit tested with arm, ppc64, and x86_64 targets using:
>    git rebase -i origin/master -x 'make tests/qos-test &&
>    QTEST_QEMU_BINARY=ppc64-softmmu/qemu-system-ppc64 tests/qos-test &&
>    QTEST_QEMU_BINARY=x86_64-softmmu/qemu-system-x86_64 tests/qos-test'
>    QTEST_QEMU_BINARY=arm-softmmu/qemu-system-arm tests/qos-test'
> v2:
>  * Fix checkpatch.pl issues, except MAINTAINERS file warning.  libqos already
>    has maintainers and the new virtio-pci-modern.[ch] files don't need extra
>    entries since they are already covered by the existing libqos/ entry.
> 
> New VIRTIO devices are Non-Transitional.  This means they only expose the
> VIRTIO 1.0 interface, not the Legacy interface.
> 
> The libqos only supports Legacy and Transitional devices (in Legacy mode).
> This patch series adds VIRTIO 1.0 support so that tests can run against
> Non-Transitional devices too.

Very nice, thanks!
I'll queue this up in my tree.

> The virtio-fs device is Non-Transitional, so this is a prerequisite for
> virtio-fs qos tests.
> 
> Stefan Hajnoczi (16):
>   tests/virtio-blk-test: read config space after feature negotiation
>   libqos: read QVIRTIO_MMIO_VERSION register
>   libqos: extend feature bits to 64-bit
>   virtio-scsi-test: add missing feature negotiation
>   tests/virtio-blk-test: set up virtqueue after feature negotiation
>   libqos: add missing virtio-9p feature negotiation
>   libqos: enforce Device Initialization order
>   libqos: implement VIRTIO 1.0 FEATURES_OK step
>   libqos: access VIRTIO 1.0 vring in little-endian
>   libqos: add iteration support to qpci_find_capability()
>   libqos: pass full QVirtQueue to set_queue_address()
>   libqos: add MSI-X callbacks to QVirtioPCIDevice
>   libqos: expose common virtqueue setup/cleanup functions
>   libqos: make the virtio-pci BAR index configurable
>   libqos: extract Legacy virtio-pci.c code
>   libqos: add VIRTIO PCI 1.0 support
> 
>  tests/Makefile.include           |   1 +
>  tests/libqos/pci.h               |   2 +-
>  tests/libqos/virtio-mmio.h       |   1 +
>  tests/libqos/virtio-pci-modern.h |  17 ++
>  tests/libqos/virtio-pci.h        |  34 ++-
>  tests/libqos/virtio.h            |  19 +-
>  tests/libqos/pci.c               |  30 ++-
>  tests/libqos/virtio-9p.c         |   6 +
>  tests/libqos/virtio-mmio.c       |  38 ++-
>  tests/libqos/virtio-net.c        |   6 +-
>  tests/libqos/virtio-pci-modern.c | 443 +++++++++++++++++++++++++++++++
>  tests/libqos/virtio-pci.c        | 105 +++++---
>  tests/libqos/virtio.c            | 160 ++++++++---
>  tests/virtio-blk-test.c          |  66 +++--
>  tests/virtio-scsi-test.c         |   8 +
>  15 files changed, 802 insertions(+), 134 deletions(-)
>  create mode 100644 tests/libqos/virtio-pci-modern.h
>  create mode 100644 tests/libqos/virtio-pci-modern.c
> 
> -- 
> 2.21.0

