Received: from eggs.gnu.org ([2001:4830:134:3::10]:43920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eKqyX-0002lh-Fv
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 14:27:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eKqyW-00007P-FZ
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 14:27:53 -0500
References: <20171129035502.GD8889@lemon>
	<20171129120018.GB2601@stefanha-x1.localdomain>
	<20171130094709.GA20286@lemon>
	<20171130141954.GC14748@stefanha-x1.localdomain>
	<20171201101644.GB11092@lemon>
	<20171201140833.GB12803@stefanha-x1.localdomain>
	<f67de9f9-dfe6-ae9a-d2ea-b4ae5e309757@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <48c19394-6a8d-e2c1-3380-7f27c2f63909@redhat.com>
Date: Fri, 1 Dec 2017 13:27:37 -0600
MIME-Version: 1.0
In-Reply-To: <f67de9f9-dfe6-ae9a-d2ea-b4ae5e309757@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Block layer complexity: what to do to keep it
 under control?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>
Cc: kwolf@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com

On 12/01/2017 11:03 AM, Paolo Bonzini wrote:
> Just my 2 cents on the language topic, as in general I agree completely
> with Stefan.
> 

> Luckily, several benefits don't require a full rewrite or language switch:
> 
> - readability from RAII-style code.  If this is important enough, we
> could actually use GCC __attribute__((cleanup)) or, heaven forbid,
> slowly introduce C++ in QEMU's code base.

This one is cool, and supported by both gcc and clang (and we really 
don't have any example of anyone clamoring for a different compiler). 
For example, here's what I recently added to nbdkit to make it MUCH 
easier to properly remember to unlock a mutex on all exit paths from a 
scope:

https://github.com/libguestfs/nbdkit/commit/0f24d66648
https://github.com/libguestfs/nbdkit/commit/b5ab4835e1

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
