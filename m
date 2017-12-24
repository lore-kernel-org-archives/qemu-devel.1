Received: from eggs.gnu.org ([2001:4830:134:3::10]:41363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eT4IK-0002uf-OH
	for qemu-devel@nongnu.org; Sun, 24 Dec 2017 06:18:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eT4IF-0004uJ-LD
	for qemu-devel@nongnu.org; Sun, 24 Dec 2017 06:18:14 -0500
Received: from mail-wm0-f50.google.com ([74.125.82.50]:44438)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eT4IF-0004re-Dl
	for qemu-devel@nongnu.org; Sun, 24 Dec 2017 06:18:11 -0500
Received: by mail-wm0-f50.google.com with SMTP id t8so28639316wmc.3
	for <qemu-devel@nongnu.org>; Sun, 24 Dec 2017 03:18:10 -0800 (PST)
References: <mailman.14303.1514042036.27991.qemu-devel@nongnu.org>
	<D2037710-4C0C-4641-BECF-A405520843F0@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bd2a9904-c9c5-2819-b1f8-ac71fce8cca1@redhat.com>
Date: Sun, 24 Dec 2017 12:18:06 +0100
MIME-Version: 1.0
In-Reply-To: <D2037710-4C0C-4641-BECF-A405520843F0@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL v4 00/19] Initial support for
 Hypervisor.framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Programmingkid <programmingkidx@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 23/12/2017 17:02, Programmingkid wrote:
>> for you to fetch changes up to
>> 895f9fdf3ac5481ca5ad5763bf667cbf82aa52c4:
>> 
>> i386: hvf: cleanup x86_gen.h (2017-12-22 15:02:07 +0100)
>> 
>> ---------------------------------------------------------------- 
>> Initial support for the HVF accelerator
> 
> I was able to build and use this patch set. The one issue I noticed
> was the high CPU usage on the guest. Watching the same youtube video
> using VirtualBox sees significantly less CPU usage. This issue could
> probably be fixed in a future patch. Other than that I think these
> patches are ready.

Great, thanks.  It is indeed a bit experimental, consider that VBox has
much more code running in the hypervisor.  Hypervisor.framework is
somewhat comparable to KVM with "-machine kernel_irqchip=off".

Paolo
