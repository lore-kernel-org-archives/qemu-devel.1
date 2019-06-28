Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E324C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 17:20:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4573C2083B
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 17:20:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4573C2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hguYK-0005aw-Au
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 13:20:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34852)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <lvivier@redhat.com>) id 1hgtMX-0002mo-6V
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 12:04:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lvivier@redhat.com>) id 1hgtMU-0000qf-Vk
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 12:04:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53286)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1hgtMU-0000mU-KT
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 12:04:30 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 191D1C18B2CC;
 Fri, 28 Jun 2019 16:04:19 +0000 (UTC)
Received: from [10.36.117.11] (ovpn-117-11.ams2.redhat.com [10.36.117.11])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3F39F5DD73;
 Fri, 28 Jun 2019 16:04:17 +0000 (UTC)
To: Bug 1834613 <1834613@bugs.launchpad.net>, qemu-devel@nongnu.org
References: <156171334969.18290.6262209650807716029.malonedeb@gac.canonical.com>
From: Laurent Vivier <lvivier@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=lvivier@redhat.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <036e831a-814c-6ad2-30c4-332849dbde38@redhat.com>
Date: Fri, 28 Jun 2019 18:04:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <156171334969.18290.6262209650807716029.malonedeb@gac.canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Fri, 28 Jun 2019 16:04:24 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Bug 1834613] [NEW] Crypto related operations
 failing on Alpine Linux on QEMU 4.0
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

On 28/06/2019 11:15, DDoSolitary wrote:
> Public bug reported:
> 
> I'm unable to boot the netboot image of Alpine Linux using QEMU 4.0.
> 
> Steps to reproduce:
> 
> curl -O http://dl-cdn.alpinelinux.org/alpine/v3.10/releases/ppc64le/netboot/vmlinuz-vanilla
> curl -O http://dl-cdn.alpinelinux.org/alpine/v3.10/releases/ppc64le/netboot/initramfs-vanilla
> qemu-system-ppc64 -kernel vmlinuz-vanilla -initrd initramfs-vanilla -nographic -append "console=hvc0 ip=dhcp alpine_repo=http://dl-cdn.alpinelinux.org/alpine/v3.10/main"
> 
> The init script will automatically download and install an in-memory
> Alpine Linux environment. However, with QEMU 4.0, the installation
> process will fail with "BAD signature" errors:
> 
> (1/20) Installing musl (1.1.22-r2)
> ERROR: musl-1.1.22-r2: BAD signature
> (2/20) Installing busybox (1.30.1-r2)
> ERROR: busybox-1.30.1-r2: BAD signature
> (3/20) Installing alpine-baselayout (3.1.2-r0)
> Executing alpine-baselayout-3.1.2-r0.pre-install
> ERROR: alpine-baselayout-3.1.2-r0.pre-install: script exited with error 127
> ERROR: alpine-baselayout-3.1.2-r0: BAD signature
> (4/20) Installing openrc (0.41.2-r1)
> ERROR: openrc-0.41.2-r1: BAD signature
> (5/20) Installing alpine-conf (3.8.3-r0)
> ERROR: alpine-conf-3.8.3-r0: BAD signature
> (6/20) Installing libcrypto1.1 (1.1.1c-r0)
> ERROR: libcrypto1.1-1.1.1c-r0: BAD signature
> (7/20) Installing libssl1.1 (1.1.1c-r0)
> ERROR: libssl1.1-1.1.1c-r0: BAD signature
> (8/20) Installing ca-certificates-cacert (20190108-r0)
> ERROR: ca-certificates-cacert-20190108-r0: BAD signature
> (9/20) Installing libtls-standalone (2.9.1-r0)
> ERROR: libtls-standalone-2.9.1-r0: BAD signature
> (10/20) Installing ssl_client (1.30.1-r2)
> ERROR: ssl_client-1.30.1-r2: BAD signature
> (11/20) Installing zlib (1.2.11-r1)
> ERROR: zlib-1.2.11-r1: BAD signature
> (12/20) Installing apk-tools (2.10.4-r1)
> ERROR: apk-tools-2.10.4-r1: BAD signature
> (13/20) Installing busybox-suid (1.30.1-r2)
> ERROR: busybox-suid-1.30.1-r2: BAD signature
> (14/20) Installing busybox-initscripts (3.1-r7)
> ERROR: busybox-initscripts-3.1-r7: BAD signature
> (15/20) Installing scanelf (1.2.3-r0)
> ERROR: scanelf-1.2.3-r0: BAD signature
> (16/20) Installing musl-utils (1.1.22-r2)
> ERROR: musl-utils-1.1.22-r2: BAD signature
> (17/20) Installing libc-utils (0.7.1-r0)
> ERROR: libc-utils-0.7.1-r0: BAD signature
> (18/20) Installing alpine-keys (2.1-r2)
> ERROR: alpine-keys-2.1-r2: BAD signature
> (19/20) Installing alpine-base (3.10.0-r0)
> ERROR: alpine-base-3.10.0-r0: BAD signature
> (20/20) Installing openssl (1.1.1c-r0)
> ERROR: openssl-1.1.1c-r0: BAD signature
> 20 errors; 0 MiB in 0 packages
> ok.
> grep: /sysroot/etc/inittab: No such file or directory
> /sbin/init not found in new root. Launching emergency recovery shell
> Type exit to continue boot.
> sh: can't access tty; job control turned off
> / #
> 

Fix for that is already included in git master:

2a1224359008 target/ppc: Fix lxvw4x, lxvh8x and lxvb16x

More fix for
8b3b2d75c7c0 ("introduce get_cpu_vsr{l,h}() and set_cpu_vsr{l,h}() helpers for VSR register access") 
are availabe:

77bd8937c03d target/ppc: Fix xvabs[sd]p, xvnabs[sd]p, xvneg[sd]p, xvcpsgn[sd]p
d47a751adab7 target/ppc: Fix xxbrq, xxbrw

And you can also need:

899f08ad1d12 tcg: Fix typos in helper_gvec_sar{8,32,64}v

depending on you host CPU

Thanks,
Laurent

