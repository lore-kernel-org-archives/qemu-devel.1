Received: from eggs.gnu.org ([2001:4830:134:3::10]:55656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cRdPl-0005cz-B8
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 06:19:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cRdPg-0003ix-PP
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 06:19:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44194)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cRdPg-0003iZ-Iy
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 06:19:24 -0500
References: <1482307137-5106-1-git-send-email-peterx@redhat.com>
	<1482307137-5106-2-git-send-email-peterx@redhat.com>
	<f6e71117-81ce-db81-d469-d0b48b7cc794@redhat.com>
	<20170112055027.GK4450@pxdev.xzpeter.org>
	<37865480-14d1-3a13-c083-013e834de1fc@redhat.com>
	<20170112094606.GO4450@pxdev.xzpeter.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9b2f5d9e-34f1-043b-346c-cab477376163@redhat.com>
Date: Thu, 12 Jan 2017 12:19:21 +0100
MIME-Version: 1.0
In-Reply-To: <20170112094606.GO4450@pxdev.xzpeter.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/2] memory: provide common macros for
 mtree_print_mr()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: marcandre.lureau@gmail.com, qemu-devel@nongnu.org



On 12/01/2017 10:46, Peter Xu wrote:
> Yes, above suggestion makes sense to me, since after all the RW
> permissions are derived from the type of memory regions, and the type
> itself tells more things than the RW bits. So I totally agree we can
> replace the "RW" chars with its type directly (if no one else
> disagree, of course).
> 
> While for below patch, do you want me to include it as well as a
> standalone patch, for the purpose of refactoring
> memory_access_is_direct()? Since IMHO it's tiny clearer and more
> readable than before.

It is more readable, but my plan was to turn these fields into a single
field (with bits) to speed up memory_access_is_direct.  For that we'd
need to undo your change.  So I'm undecided.

Paolo
