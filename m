Received: from eggs.gnu.org ([2001:4830:134:3::10]:45973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1cgT3A-0002XL-Vt
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 04:17:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1cgT36-0003SL-0R
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 04:17:28 -0500
Received: from mail-db5eur01on0139.outbound.protection.outlook.com
	([104.47.2.139]:56987
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anton.nefedov@virtuozzo.com>)
	id 1cgT35-0003SD-C1
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 04:17:23 -0500
References: <20170221104256.5153-1-pbonzini@redhat.com>
	<20170221104256.5153-4-pbonzini@redhat.com>
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Message-ID: <8cc7ed25-a9f4-0b7f-c9b7-b8dc1ea92374@virtuozzo.com>
Date: Wed, 22 Feb 2017 12:17:16 +0300
MIME-Version: 1.0
In-Reply-To: <20170221104256.5153-4-pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/3] vl: pass CPUState to
 qemu_system_guest_panicked
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: eblake@redhat.com, den@openvz.org

hi,

On 02/21/2017 01:42 PM, Paolo Bonzini wrote:
> qemu_system_guest_panicked was already using current_cpu implicitly,
> so it makes sense for it to receive a CPUState.  This lets the
> function call cpu_get_crash_info and free the result.
>

my motivation against this was that as qemu_system_guest_panicked() is 
also used by pvpanic device, if it's ever going to pass any information, 
GuestPanicInformation struct could be reused.
Though I guess it doesnt matter much now

/Anton
