Received: from eggs.gnu.org ([2001:4830:134:3::10]:37094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1d6CnG-0005iM-Bt
	for qemu-devel@nongnu.org; Thu, 04 May 2017 05:11:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1d6CnB-0007vQ-E5
	for qemu-devel@nongnu.org; Thu, 04 May 2017 05:11:26 -0400
Received: from mail-db5eur01on0137.outbound.protection.outlook.com
	([104.47.2.137]:23617
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1d6CnA-0007sp-OG
	for qemu-devel@nongnu.org; Thu, 04 May 2017 05:11:21 -0400
Date: Thu, 4 May 2017 11:55:47 +0300
From: Roman Kagan <rkagan@virtuozzo.com>
Message-ID: <20170504085546.GA14580@rkaganb.sw.ru>
References: <20170420120058.28404-1-pbonzini@redhat.com>
	<20170420120058.28404-10-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20170420120058.28404-10-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 09/17] util: add stats64 module
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org

On Thu, Apr 20, 2017 at 02:00:50PM +0200, Paolo Bonzini wrote:
> This module provides fast paths for 64-bit atomic operations on machines
> that only have 32-bit atomic access.

> --- /dev/null
> +++ b/include/qemu/stats64.h
[...]
> +#ifndef STAT64_NEED_SPINLOCK
[...]
> +static inline void stat64_min(Stat64 *s, uint32_t value)
                                                ^^
				       typo or intentional?

Roman.
