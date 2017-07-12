Received: from eggs.gnu.org ([2001:4830:134:3::10]:33614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dVK4g-0002wb-PT
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 12:01:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dVK4c-0006S4-Tm
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 12:01:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33422)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dVK4c-0006Qx-O7
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 12:01:10 -0400
References: <1499847753-8513-1-git-send-email-thuth@redhat.com>
	<20170712150400.GH5237@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <9d51d348-7ad6-a98d-3f6d-89e8af5e3a16@redhat.com>
Date: Wed, 12 Jul 2017 18:00:46 +0200
MIME-Version: 1.0
In-Reply-To: <20170712150400.GH5237@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3] hw/i386: Deprecate the machines pc-0.10
 to pc-1.2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Richard Henderson <rth@twiddle.net>

On 12.07.2017 17:04, Daniel P. Berrange wrote:
> On Wed, Jul 12, 2017 at 10:22:33AM +0200, Thomas Huth wrote:
>> We don't want to carry along old machine types forever. If we are able=
 to
>> remove the pc machines up to 0.13 one day for example, this would allo=
w
>> us to eventually kill the code for rombar=3D0 (i.e. where QEMU copies =
ROM
>> BARs directly to low memory). Everything up to pc-1.2 is also known to
>> have issues with migration.  So let's start with a deprecation message
>> for the old machine types so that the (hopefully) few users of these o=
ld
>> systems start switching over to newer machine types instead.
>=20
> I think we must document & agree on our support policy for machine
> types, before we start marking them as deprecated. eg please consider
> the following document before accepting this deprecation patch:
>=20
>  https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg00652.html
>=20
> Note in that proposal there, I say we do *not* go through trouble of
> explicitly marking machines as deprecated. We just document upfront
> the intended lifecycle and then delete them when it is done.
>=20
> Just use deprecation warnings for things where there is no predictable
> lifecycle upfront.

I'm still not 100% sure whether that auto-deprecation of machine types
is such a good idea ... since we might need to maintain machines in
downstream a little bit longer than specified there, it might be better
to rather deprecate them manually from time to time.

Anyway, concerning my patch - I'll stop here and won't send another
version. There is too much bikeshed painting going on in this area for
my taste, and since I'm rather a powerpc / s390x guy, I'm also fine if
the pc-0.x machines stay around forever. If somebody else wants to push
this topic instead, feel free to do so.

 Thomas
