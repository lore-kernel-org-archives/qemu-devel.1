Received: from eggs.gnu.org ([2001:4830:134:3::10]:42015)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1gPkws-0004eI-2z
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 04:07:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1gPkv1-0000xq-3M
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 04:05:06 -0500
Received: from mail-bgr052101132081.outbound.protection.outlook.com
	([52.101.132.81]:6067
	helo=EUR02-HE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1gPkv0-0000wB-8w
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 04:05:03 -0500
From: Roman Kagan <rkagan@virtuozzo.com>
Date: Thu, 22 Nov 2018 09:04:49 +0000
Message-ID: <20181122090445.GA2357@rkaganb.sw.ru>
References: <20181102002818.8568-1-viktor.prutyanov@phystech.edu>
	<20181102002818.8568-3-viktor.prutyanov@phystech.edu>
	<20181121102530.GB870@rkaganb.sw.ru>
	<e070434f-939b-fe09-603c-4884ddb849b0@redhat.com>
In-Reply-To: <e070434f-939b-fe09-603c-4884ddb849b0@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5B473FC0E798364085BB9DD34FB56494@eurprd08.prod.outlook.com>
MIME-Version: 1.0
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
To: Eric Blake <eblake@redhat.com>
Cc: Viktor Prutyanov <viktor.prutyanov@phystech.edu>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On Wed, Nov 21, 2018 at 10:54:15AM -0600, Eric Blake wrote:
> On 11/21/18 4:25 AM, Roman Kagan wrote:
> > On Fri, Nov 02, 2018 at 03:28:18AM +0300, Viktor Prutyanov wrote:
> > > After this patch elf2dmp can be built by mingw64 for Windows hosts.
> > 
> > What prevents building it with mingw32?  (I realize that since the tool
> > uses mmaped access to the dump data it's limited to dumps under a couple
> > of gigs but it's still not totally useless).
> 
> Careful. The original (32-bit) mingw project is obsolete, and its
> replacement, the mingw64 project, provides both 32- and 64-bit environments.
> Even more confusingly, Fedora ships the mingw64 cross-compilers under the
> names i686-w64-mingw32-gcc (build for a 32-bit environment) and
> x86_64-w64-mingw32-gcc (build for a 64-bit environment).  Historical naming
> causes confusion.

Indeed.

> So your question may not be relevant, especially given that
> tests/docker/test-mingw builds both 32- and 64-bit mingw builds.

I think it still is :)

The patch protects certain parts with #ifdef _WIN64, so it looks like it
won't build against 32-bit mingw.  Hence my question.

Roman.
