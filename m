Received: from eggs.gnu.org ([2001:4830:134:3::10]:55366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fXXWY-0007Zz-66
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 15:51:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fXXWT-0000uf-B2
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 15:51:42 -0400
Date: Mon, 25 Jun 2018 16:51:26 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180625195126.GN7451@localhost.localdomain>
References: <20180619171539.0adc90d6.cohuck@redhat.com>
	<d4e02083-c372-3ce5-d4a2-4809579fc8f2@redhat.com>
	<20180622181108.GY7451@localhost.localdomain>
	<c10c2ffa-7ee2-5106-07d1-528df939d6ad@redhat.com>
	<20180622193522.GI7451@localhost.localdomain>
	<743d495e-51cd-8c8e-293e-026b8dece74a@redhat.com>
	<87lgb3xsv8.fsf@dusky.pond.sub.org>
	<4292432f-5f26-6925-4c14-ad1370e36e5b@redhat.com>
	<20180625173056.GM7451@localhost.localdomain>
	<97504b42-9ebe-45c5-6ff3-b43102c8374a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97504b42-9ebe-45c5-6ff3-b43102c8374a@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 4/4] qemu-options: Do not show
 -enable-kvm and -enable-hax in the docs anymore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, zhang.zhanghailiang@huawei.com, Ben Warren <ben@skyportsystems.com>, qemu-trivial@nongnu.org, Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

On Mon, Jun 25, 2018 at 08:26:28PM +0200, Paolo Bonzini wrote:
> On 25/06/2018 19:30, Eduardo Habkost wrote:
> >>> Attentive distros could even replace the wrapper script by a link.
> >> If they are okay with replacing the "KVM only" semantics with "KVM or
> >> TCG", which I think is generally worse.
> >
> > If we can't get agreement on what's the right default for each
> > QEMU binary, I think that's yet another reason to document that
> > upstream QEMU won't guarantee ABI compatibility if -accel is
> > omitted.
> 
> Before that we should ask what the benefit is in changing the default
> for qemu-system-*.  Nobody is using it in practice to start QEMU with
> KVM enabled...

How can you be sure?  If qemu-system-* is installed with KVM
compiled in, libvirt will probe it using
"-machine none,accel=kvm:tcg" and run the VM using
"-machine $MACHINE,accel=kvm".

In either case, I'm not arguing (yet) for changing the default
upstream.  I'm just arguing for upstream QEMU to not make any
promises about the default.

-- 
Eduardo
