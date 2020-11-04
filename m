Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D542C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 09:48:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9888720781
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 09:48:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fAGezYTP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9888720781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaFPL-0006bZ-HT
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 04:48:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59272)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kaFOV-0006CB-In
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 04:47:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34805)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kaFOT-0005XN-6P
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 04:47:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604483272;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lu52kPkLBvEklazMJJ0go4gRGcc0NL7MOIhKuTxg3GE=;
 b=fAGezYTPbM3P2JN4y7HTIFCFOLIvrmrfVmaax98u12Rhk1p06zbez9RQ9RaKQf3E8CRsrz
 X+gnHxUoklfEYqIoxi3kHA5Hi+ZOPQICtCAmsNhItvs917ynKLxMkb2JByT9UkE6sm0XaA
 OT5jLKDowwHiS5ENdZxJ21ZVLcKnVSE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-85-WlUp5MuXMpOwKaDwPrrmvA-1; Wed, 04 Nov 2020 04:47:48 -0500
X-MC-Unique: WlUp5MuXMpOwKaDwPrrmvA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 969EA80B702;
 Wed,  4 Nov 2020 09:47:47 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-151.ams2.redhat.com [10.36.112.151])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6ACFD81F41;
 Wed,  4 Nov 2020 09:47:43 +0000 (UTC)
Subject: Re: [qemu-web PATCH] Add virtio-fs in OSv overview blog post
To: Fotis Xenakis <foxen@windowslive.com>, qemu-devel@nongnu.org
References: <AM0PR03MB62920E8F53722876D6FD3D30A6EF0@AM0PR03MB6292.eurprd03.prod.outlook.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <d7f5f49c-0cf4-0116-91ac-50bad486e31f@redhat.com>
Date: Wed, 4 Nov 2020 10:47:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <AM0PR03MB62920E8F53722876D6FD3D30A6EF0@AM0PR03MB6292.eurprd03.prod.outlook.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: virtio-fs@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 04/11/2020 01.42, Fotis Xenakis wrote:
> This post briefly goes over the main points of virtio-fs and OSv, a
> unikernel running under QEMU/KVM and taking advantage of its virtio-fs
> implementation.
> 
> Feel free to review, I will be more than happy to address any comments.

Thanks, articles for the QEMU blog are always welcome! Some comments below...

> diff --git a/_posts/2020-11-04-osv-virtio-fs.md b/_posts/2020-11-04-osv-virtio-fs.md
> new file mode 100644
> index 0000000..af5bb0d
> --- /dev/null
> +++ b/_posts/2020-11-04-osv-virtio-fs.md
> @@ -0,0 +1,123 @@
> +---
> +layout: post
> +title:  "Using virtio-fs on a unikernel"
> +author: Fotis Xenakis
> +date:   2020-11-04 02:00:00 +0200
> +categories: [storage, virtio-fs, unikernel, OSv]
> +---
> +
> +This article provides an overview of virtio-fs, a novel way for sharing the host
> +file system with guests and OSv, a specialized, light-weight operating system
> +(unikernel) for the cloud, as well as how these two fit together.

I'd maybe add the links to the virtio-fs and OSv homepage in this paragraph
already, since they are mentioned here for the first time.
For links that you want to use multiple times, you can also declare them at
the end of the file, so that you only have to provide the URL one time. See
e.g. this article as an example:

https://gitlab.com/qemu-project/qemu-web/-/blob/master/_posts/2017-11-22-haxm-usage-windows.md#L101

> +## virtio-fs
> +
> +[Virtio-fs](https://virtio-fs.gitlab.io/) is a new host-guest shared filesystem,
> +purpose-built for local file system semantics and performance. To that end, it
> +takes full advantage of the host's and the guest's colocation on the same
> +physical machine, unlike network-based efforts, like virtio-9p.
> +
> +As the name suggests, virtio-fs builds on virtio for providing an efficient
> +transport: it is included in the (currently draft, to become v1.2) virtio
> +[specification](https://github.com/oasis-tcs/virtio-spec) as a new device. The
> +protocol used by the device is a slightly extended version of
> +[FUSE](https://github.com/libfuse/libfuse), providing a solid foundation for
> +all file system operations native on Linux. Implementation-wise, on the QEMU
> +side, it takes the approach of splitting between the guest interface (handled
> +by QEMU) and the host file system interface (the device "backend"). The latter
> +is handled by virtiofsd ("virtio-fs daemon"), running as a separate process,
> +utilizing the
> +[vhost-user](https://www.qemu.org/docs/master/interop/vhost-user.html) protocol
> +to communicate with QEMU.
> +
> +One prominent performance feature of virtio-fs is the DAX (Direct Access)
> +window. What is that? It's a shared memory window between the host and the

I'd rather simply say "This is a shared ..." and scratch the "What is that?"
question.

> +guest, exposed as device memory (a PCI BAR) to the second. How is it used? Upon

I'd rather drop the "How is it used?" question.

> +request, the host (QEMU) maps file contents to the window for the guest to
> +access directly. This bears performance gains due to taking VMEXITs out of the
> +read/write data path and bypassing the guest page cache on Linux, while not
> +counting against the VM's memory (since it's just device memory, managed on the
> +host).
> +
> +![virtio-fs DAX architecture](https://gitlab.com/virtio-fs/virtio-fs.gitlab.io/-/raw/master/architecture.svg)
> +
> +Virtio-fs is under active development, with its community focussing on a pair of
> +device implementation in QEMU and device driver in Linux. Both components are
> +already available upstream in their initial iterations, while upstreaming
> +continues further e.g. with DAX window support.
> +
> +## OSv
> +
> +[OSv](https://github.com/cloudius-systems/osv) is a
> +[unikernel](https://en.wikipedia.org/wiki/Unikernel) (framework). The two
> +defining characteristics of a unikernel are:
> +
> +- **Application-specialized**: a unikernel is an executable machine image,
> +  consisting of an application and supporting code (drivers, memory management,
> +  runtime etc.) linked together, running in a single address space (typically
> +  in guest "kernel mode").
> +- **Library OS**: each unikernel only contains the functionality mandated by its
> +  application in terms of non-application code, i.e. no unused drivers, or even
> +  whole subsystems (e.g. networking, if the application doesn't use the
> +  network).
> +
> +OSv in particular strives for binary compatibility with Linux. What this means

I'd rather say "This means that ..." instead.

> +is that applications built for Linux should run as OSv unikernels without
> +requiring modifications or even rebuilding, at least most of the time.

Sorry for asking ignorant questions: Does that mean that OSv has a dynamic
linker for Linux ELF binaries?

> Of
> +course, not the whole Linux ABI is supported, with system calls like `fork()`
> +and relatives missing by design in all unikernels, which lack the notion of a
> +process. Despite this limitation, OSv is quite full featured, with full SMP
> +support, virtual memory, a virtual file system (and many filesystem
> +implementations, including ZFS) as well as a mature networking stack, based of
> +off FreeBSD's.

maybe rather "based on the FreeBSD sources" or something similar?

> +At this point, one is sure to wonder "Why bother with unikernels?". The problem
> +they were originally
> +[introduced](http://unikernel.org/files/2013-asplos-mirage.pdf) to solve is
> +that of bloat in the modern cloud software stack.

I'm not a native speaker, but I'd maybe rather say something like:
.. to solve is the burden of the bloat of the modern cload software stack ?

> Running general-purpose
> +operating systems as guests, typically for a single application/service, on top
> +of a hypervisor which already takes care of isolation and provides a standard
> +device model means duplication, as well as loss of efficiency. This is were
> +unikernels come in, trying to be just enough to support a single application
> +and as light-weight as possible, based on the assumption that they are executing
> +inside a VM. Below is an illustration of the comparison between
> +general-purpose OS, unikernels and containers (as another approach to the same
> +problem, for completeness).
> +
> +![Unikernels vs GPOS vs containers](/screenshots/2020-11-04-unikernel-vs-gpos.svg)
> +
> +## OSv, meet virtio-fs
> +
> +As is apparent e.g. from the container world, it is very common for applications
> +running in isolated environments (such as containers, or unikernels even more
> +so) to require host file system access. Whereas containers sharing the host
> +kernel thus have an obvious, controlled path to the host file system, with
> +unikernels this has been more complex: all solutions were somewhat heavyweight,
> +requiring a network link or indirection through network protocols. Virtio-fs
> +then provided a significantly more attractive route: straight-forward mapping of
> +fs operations (via FUSE), reusing the existing virtio transport and decent
> +performance without high memory overhead.
> +
> +The OSv community quickly identified the opportunity and came up with a
> +read-only implementation on its side, when executing under QEMU. This emphasized
> +being lightweight complexity-wise, while catering to many of its applications'
> +requirements (they are stateless, think e.g. serverless). Notably, it includes
> +support for the DAX window (even before that's merged in upstream QEMU),
> +providing [excellent performance](https://github.com/foxeng/diploma), directly
> +rivalling that of its local (non-shared) counterparts such as ZFS and ROFS (an
> +OSv-specific read-only file system).
> +
> +One central point is OSv's support for booting from virtio-fs: this enables
> +deploying a modified version or a whole new application **without rebuilding**
> +the image, just by adjusting its root file system contents on the host. Last,
> +owing to the DAX window practically providing low-overhead access to the host's
> +page cache, scalability is also expected to excel, with it being a common
> +concern due to the potentially high density of unikernels per host.

After reading the initial paragraphs of this mail, I was somehow expecting
to see at least a short example / description of how to use virtio-fs with
OSv ... do you maybe at least want to provide a pointer to further
documentation here so that people know where to look next if they want to
try out virtio-fs with OSv?

> +## Conclusion
> +
> +OSv has gained a prominent new feature, powered by virtio-fs and its QEMU
> +implementation. This allows efficient, lightweight and performant access to the
> +host's file system, thanks to the native virtio transport, usage of the FUSE
> +protocol and the DAX window architecture. In turn, it enables use cases like
> +rapid unikernel reconfiguration.

 Thomas


