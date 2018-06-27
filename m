Received: from eggs.gnu.org ([2001:4830:134:3::10]:39831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fYB57-0006Xs-9j
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 10:06:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fYB51-0006K8-O7
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 10:06:01 -0400
Date: Wed, 27 Jun 2018 11:05:42 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180627140542.GC7451@localhost.localdomain>
References: <87lgb3xsv8.fsf@dusky.pond.sub.org>
	<4292432f-5f26-6925-4c14-ad1370e36e5b@redhat.com>
	<20180625173056.GM7451@localhost.localdomain>
	<97504b42-9ebe-45c5-6ff3-b43102c8374a@redhat.com>
	<20180625195126.GN7451@localhost.localdomain>
	<a931e759-879b-6f6b-3524-4b5a78fed323@redhat.com>
	<20180626122908.GQ7451@localhost.localdomain>
	<577768c0-5205-2fb4-209f-845332fe158d@redhat.com>
	<20180626160623.GT7451@localhost.localdomain>
	<a0457847-d775-9bc9-32ea-b7337504eabd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0457847-d775-9bc9-32ea-b7337504eabd@redhat.com>
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

On Wed, Jun 27, 2018 at 10:39:29AM +0200, Paolo Bonzini wrote:
> On 26/06/2018 18:06, Eduardo Habkost wrote:
> >> On the other hand I see no benefit in changing a default that people are
> >> obviously not using (since most people use KVM, not TCG).  Distros will
> >> keep shipping, and people will keep using qemu-kvm even if we change the
> >> default.
> >
> > Not changing the default is different from promising we will keep
> > ABI compatibility if the accelerator is omitted.  I just want to
> > get rid of the latter.
> 
> I understand; what I don't understand is why do the latter unless you
> plan to change the default.

Why should we make a compatibility promise if we don't have to?
Making and keeping promises have a cost, and I'd like us to spend
our energy elsewhere.

-- 
Eduardo
