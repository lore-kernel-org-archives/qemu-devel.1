Received: from eggs.gnu.org ([2001:4830:134:3::10]:42369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1db3sU-0001ya-QW
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 07:56:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1db3sR-0008SA-BB
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 07:56:22 -0400
Date: Fri, 28 Jul 2017 13:56:14 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170728135614.3f14e3ad@gondolin>
In-Reply-To: <c44770f5-df9d-2340-5dba-2f5db7acd046@redhat.com>
References: <20170728053610.15770-1-f4bug@amsat.org>
	<20170728053610.15770-6-f4bug@amsat.org>
	<a7fdc125-9a1b-bec3-915f-e8f764816b0d@redhat.com>
	<c44770f5-df9d-2340-5dba-2f5db7acd046@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 05/47] MAINTAINERS: add missing KVM entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVk?= =?UTF-8?B?w6k=?= <f4bug@amsat.org>, qemu-trivial@nongnu.org, qemu-devel@nongnu.org

On Fri, 28 Jul 2017 13:51:14 +0200
Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 28/07/2017 09:00, Thomas Huth wrote:
> > On 28.07.2017 07:35, Philippe Mathieu-Daud=C3=A9 wrote: =20
> >> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> >> ---
> >>  MAINTAINERS | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/MAINTAINERS b/MAINTAINERS
> >> index 3b472d7a09..ece02522be 100644
> >> --- a/MAINTAINERS
> >> +++ b/MAINTAINERS
> >> @@ -278,6 +278,7 @@ S: Supported
> >>  F: */kvm.*
> >>  F: accel/kvm/
> >>  F: include/sysemu/kvm*.h
> >> +F: linux-headers/asm-*/kvm*.h =20
> >=20
> > The linux-headers are not really maintained by the QEMU project - so I
> > guess we do not need an entry for these? =20
>=20
> Actually I agree with the patch.  I'd like to be CCed on
> update-linux-headers patches, and this achieves it. :)

But would it not a better idea to add an entry for all headers touched
by update-linux-headers, then?
