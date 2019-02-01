Received: from eggs.gnu.org ([209.51.188.92]:38034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gpgRi-0000pb-Fu
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 16:33:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gpgIu-0005He-M5
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 16:24:54 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51911)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gpgIu-0005GL-Bu
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 16:24:52 -0500
Received: by mail-wm1-f66.google.com with SMTP id b11so7526113wmj.1
	for <qemu-devel@nongnu.org>; Fri, 01 Feb 2019 13:24:51 -0800 (PST)
References: <1548410831-19553-1-git-send-email-pbonzini@redhat.com>
	<1548410831-19553-34-git-send-email-pbonzini@redhat.com>
	<6e8609da-a198-4457-afc2-88f911261994@redhat.com>
	<b925a626-dee7-a95f-2721-a821c6edf209@redhat.com>
	<469a90b3-c032-1373-01b2-9f29e49414c1@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <cab649ec-82cc-2079-24b6-31b9f2b1f16a@redhat.com>
Date: Fri, 1 Feb 2019 22:24:50 +0100
MIME-Version: 1.0
In-Reply-To: <469a90b3-c032-1373-01b2-9f29e49414c1@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 33/52] build: switch to Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul.durrant@citrix.com>, thuth@redhat.com
Cc: yang.zhong@intel.com, qemu-devel@nongnu.org

On 01/02/19 15:56, Philippe Mathieu-Daudé wrote:
> Now when I disable Xen, exec.o isn't rebuilt, so I get link errors:
> 
> /usr/bin/ld: exec.o: in function `reclaim_ramblock':
> qemu/exec.c:2392: undefined reference to `xen_invalidate_map_cache_entry'
> /usr/bin/ld: exec.o: in function `qemu_ram_ptr_length':
> qemu/exec.c:2531: undefined reference to `xen_map_cache'
> /usr/bin/ld: exec.o: in function `qemu_map_ram_ptr':
> qemu/exec.c:2498: undefined reference to `xen_map_cache'
> /usr/bin/ld: exec.o: in function `qemu_ram_block_from_host':
> qemu/exec.c:2573: undefined reference to `xen_ram_addr_from_mapcache'
> /usr/bin/ld: exec.o: in function `address_space_unmap':
> qemu/exec.c:3699: undefined reference to `xen_invalidate_map_cache_entry'
> /usr/bin/ld: exec.o: in function `address_space_cache_destroy':
> qemu/exec.c:3791: undefined reference to `xen_invalidate_map_cache_entry'
> /usr/bin/ld: exec.o: in function `qemu_ram_ptr_length':
> qemu/exec.c:2528: undefined reference to `xen_map_cache'
> /usr/bin/ld: exec.o: in function `qemu_map_ram_ptr':
> qemu/exec.c:2495: undefined reference to `xen_map_cache'
> collect2: error: ld returned 1 exit status
> make[1]: *** [Makefile:204: qemu-system-i386] Error 1

It should be rebuilt because config-target.h changed?

Paolo
