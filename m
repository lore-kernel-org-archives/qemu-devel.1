Received: from eggs.gnu.org ([2001:4830:134:3::10]:50633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cK7Na-00074z-27
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 12:42:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cK7NW-00035q-Ut
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 12:42:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57028)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cK7NW-000354-Oy
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 12:42:06 -0500
Date: Thu, 22 Dec 2016 15:42:02 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20161222174202.GM3808@thinpad.lan.raisama.net>
References: <20161222155915.7232-1-pbonzini@redhat.com>
	<CAFEAcA_gQ4pMcfVevAEiY6LfoW_HzR8DARHb2QpGFEA2hTAMHw@mail.gmail.com>
	<cfe1e535-a28c-ebfa-b60f-f411a5e6cdd0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cfe1e535-a28c-ebfa-b60f-f411a5e6cdd0@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 00/11] Stubs cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On Thu, Dec 22, 2016 at 06:32:24PM +0100, Paolo Bonzini wrote:
> 
> 
> On 22/12/2016 18:30, Peter Maydell wrote:
> > On 22 December 2016 at 15:59, Paolo Bonzini <pbonzini@redhat.com> wrote:
> >> This moves out of libqemustub.a those functions which can be handled
> >> simply by $(call lnot), like we already do for pci-stub.c or kvm-stub.c.
> >> libqemustub.a keep the more complex cases where a small part of the
> >> executables we build needs an implementation of a small subset of an API.
> > 
> > So why is doing it this way round better? (I don't have a strong
> > opinion here, but you don't really give a rationale for this change.)
> 
> I don't really have a strong opinion here either, hence the RFC.
> However, one advantage is that it keeps things visible to the right
> maintainer.

Can't we just move the files to subdirectories where they are
visible to the maintainers, but keep using stub-obj-y/libqemustub
to build/link them?

I find libqemustub/stub-obj-y much easier to use than manually
setting obj-$(call lnot ...).

-- 
Eduardo
