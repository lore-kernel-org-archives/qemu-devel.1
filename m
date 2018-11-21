Received: from eggs.gnu.org ([2001:4830:134:3::10]:55398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gPVlf-00089X-Mt
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 11:54:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gPVlb-0002cj-05
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 11:54:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56770)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gPVla-0002bi-Qh
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 11:54:18 -0500
References: <20181102002818.8568-1-viktor.prutyanov@phystech.edu>
	<20181102002818.8568-3-viktor.prutyanov@phystech.edu>
	<20181121102530.GB870@rkaganb.sw.ru>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e070434f-939b-fe09-603c-4884ddb849b0@redhat.com>
Date: Wed, 21 Nov 2018 10:54:15 -0600
MIME-Version: 1.0
In-Reply-To: <20181121102530.GB870@rkaganb.sw.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] contrib/elf2dmp: elf2dmp for Windows
 hosts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Kagan <rkagan@virtuozzo.com>, Viktor Prutyanov <viktor.prutyanov@phystech.edu>, pbonzini@redhat.com, qemu-devel@nongnu.org

On 11/21/18 4:25 AM, Roman Kagan wrote:
> On Fri, Nov 02, 2018 at 03:28:18AM +0300, Viktor Prutyanov wrote:
>> After this patch elf2dmp can be built by mingw64 for Windows hosts.
> 
> What prevents building it with mingw32?  (I realize that since the tool
> uses mmaped access to the dump data it's limited to dumps under a couple
> of gigs but it's still not totally useless).

Careful. The original (32-bit) mingw project is obsolete, and its 
replacement, the mingw64 project, provides both 32- and 64-bit 
environments.  Even more confusingly, Fedora ships the mingw64 
cross-compilers under the names i686-w64-mingw32-gcc (build for a 32-bit 
environment) and x86_64-w64-mingw32-gcc (build for a 64-bit 
environment).  Historical naming causes confusion.

So your question may not be relevant, especially given that 
tests/docker/test-mingw builds both 32- and 64-bit mingw builds.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
