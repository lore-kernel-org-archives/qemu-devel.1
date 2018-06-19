Received: from eggs.gnu.org ([2001:4830:134:3::10]:55559)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fVIMx-00070X-2M
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 11:16:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fVIMs-0000VZ-T8
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 11:16:30 -0400
Date: Tue, 19 Jun 2018 17:15:39 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180619171539.0adc90d6.cohuck@redhat.com>
In-Reply-To: <87k1r24quk.fsf@dusky.pond.sub.org>
References: <1528866321-23886-1-git-send-email-thuth@redhat.com>
	<1528866321-23886-5-git-send-email-thuth@redhat.com>
	<20180613133840.GK24528@stefanha-x1.localdomain>
	<20180613134452.GU19901@redhat.com>
	<b0ebd968-797f-48e0-32c1-869c452feca9@redhat.com>
	<20180613151942.GC19901@redhat.com>
	<87k1r24quk.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
To: Markus Armbruster <armbru@redhat.com>
Cc: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>, zhang.zhanghailiang@huawei.com, Ben Warren <ben@skyportsystems.com>, qemu-trivial@nongnu.org, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

On Wed, 13 Jun 2018 18:02:27 +0200
Markus Armbruster <armbru@redhat.com> wrote:

> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> > If I'm a user looking for how to enable KVM, then -enable-kvm is the
> > one I'll pick because of the obvious name. =20
>=20
> Why does a user have to know how to enable KVM?  Oh, because our default
> is "run this guest much slower than necessary".  Great!

Should we try again to default to a better accelerator, if possible? I
don't quite recall why we didn't do so the last time that came up...
was it tests?
