Received: from eggs.gnu.org ([2001:4830:134:3::10]:54180)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eIEbk-0001hC-5H
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 09:05:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eIEbg-0000Uv-FI
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 09:05:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46030)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eIEbg-0000UP-95
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 09:05:28 -0500
References: <20171124135729.60ceff1e@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <02ac211d-d78f-4639-a8a9-b9d0a6497f3d@redhat.com>
Date: Fri, 24 Nov 2017 15:05:24 +0100
MIME-Version: 1.0
In-Reply-To: <20171124135729.60ceff1e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Windows 10 guest hang during 'info mem'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>
Cc: kvm@vger.kernel.org, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>

On 24/11/2017 13:57, Igor Mammedov wrote:
> I've stumbled on WS2016 hang when trying to list memory map in QEMU.
> 
> Steps to reproduce:
>   qemu-system-x86_64 -monitor stdio -enable-kvm -m 1G ws2016x64.img
>  wait till guest boots and execute in monitor 
>   (qemu) info mem
> 
> qemu will hang while printing mappings, consuming 100% cpu and not
> responding to ^C.
> 
> I've also tried with old (2.8) and current qemu master and today's
> upstream kernel where it also doesn't work but WS2012R2x64 guest
> works just fine.
> 
> PS:
> CCing KVM list as the issue happens only when KVM is enabled.

"info mem" code sucks and is unreadable.  We really should rewrite the
MMU stuff in TCG. :(

But, what is the backtrace?

Paolo
