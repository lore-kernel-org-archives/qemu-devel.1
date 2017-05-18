Received: from eggs.gnu.org ([2001:4830:134:3::10]:49035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dBKOo-0007zD-9a
	for qemu-devel@nongnu.org; Thu, 18 May 2017 08:19:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dBKOl-0007YH-5L
	for qemu-devel@nongnu.org; Thu, 18 May 2017 08:19:22 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <cf5d85d7-26cc-2457-06fc-ca827ca1eaff@redhat.com>
References: <20170511144208.24075-1-pbonzini@redhat.com>
	<20170511144208.24075-10-pbonzini@redhat.com>
	<w51efvmgyj6.fsf@maestria.local.igalia.com>
	<cf5d85d7-26cc-2457-06fc-ca827ca1eaff@redhat.com>
Date: Thu, 18 May 2017 14:19:17 +0200
Message-ID: <w5137c2gxx6.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 09/18] throttle-groups:
 protect throttled requests with a CoMutex
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: famz@redhat.com, qemu-block@nongnu.org, stefanha@redhat.com

On Thu 18 May 2017 02:08:32 PM CEST, Paolo Bonzini wrote:
>> Does io_limits_disabled need locking too?
>
> It uses atomic access since patch 3.

Ah, I overlooked that one, sorry!

Berto
