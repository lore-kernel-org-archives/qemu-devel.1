Received: from eggs.gnu.org ([2001:4830:134:3::10]:60298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fWQWk-0001sK-FG
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 14:11:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fWQWg-0000hT-B1
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 14:11:18 -0400
Date: Fri, 22 Jun 2018 15:11:09 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180622181108.GY7451@localhost.localdomain>
References: <1528866321-23886-1-git-send-email-thuth@redhat.com>
	<1528866321-23886-5-git-send-email-thuth@redhat.com>
	<20180613133840.GK24528@stefanha-x1.localdomain>
	<20180613134452.GU19901@redhat.com>
	<b0ebd968-797f-48e0-32c1-869c452feca9@redhat.com>
	<20180613151942.GC19901@redhat.com>
	<87k1r24quk.fsf@dusky.pond.sub.org>
	<20180619171539.0adc90d6.cohuck@redhat.com>
	<d4e02083-c372-3ce5-d4a2-4809579fc8f2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4e02083-c372-3ce5-d4a2-4809579fc8f2@redhat.com>
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
Cc: Cornelia Huck <cohuck@redhat.com>, Markus Armbruster <armbru@redhat.com>, Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>, zhang.zhanghailiang@huawei.com, Ben Warren <ben@skyportsystems.com>, qemu-trivial@nongnu.org, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

On Tue, Jun 19, 2018 at 06:16:33PM +0200, Paolo Bonzini wrote:
> On 19/06/2018 17:15, Cornelia Huck wrote:
> >> Why does a user have to know how to enable KVM?  Oh, because our default
> >> is "run this guest much slower than necessary".  Great!
> > Should we try again to default to a better accelerator, if possible? I
> > don't quite recall why we didn't do so the last time that came up...
> > was it tests?
> 
> My plan was to create qemu-{kvm,hax,hvf,whpx} binaries that default to a
> better accelerator, and leave qemu-system-* as defaulting to TCG.  This
> matches what distributions already do.

Why is this better than using KVM by default if it's available?

-- 
Eduardo
