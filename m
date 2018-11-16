Received: from eggs.gnu.org ([2001:4830:134:3::10]:34586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gNdd6-0000eX-Ta
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 07:53:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gNdd3-0003Id-Pv
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 07:53:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35750)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gNdd3-0003Hu-I6
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 07:53:45 -0500
References: <20181114130428.32326-1-asanchez@kryptoslogic.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1782562d-41c7-0cc7-94f3-fb7ff4b7bd40@redhat.com>
Date: Fri, 16 Nov 2018 13:52:45 +0100
MIME-Version: 1.0
In-Reply-To: <20181114130428.32326-1-asanchez@kryptoslogic.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hax: Support for Linux hosts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexandro Sanchez Bach <asanchez@kryptoslogic.com>, qemu-devel@nongnu.org
Cc: yu.ning@intel.com, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

On 14/11/18 14:04, Alexandro Sanchez Bach wrote:
> Intel HAXM supports now 32-bit and 64-bit Linux hosts. This patch includes
> the corresponding userland changes.
> 
> Since the Darwin userland backend is POSIX-compliant, the hax-darwin.{c,h}
> files have been renamed to hax-posix.{c,h}. This prefix is consistent with
> the naming used in the rest of QEMU.

What's the advantage of HAXM when Linux hosts can just run KVM?  I guess
avoiding bitrot?

Paolo
