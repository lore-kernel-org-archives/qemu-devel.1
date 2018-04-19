Received: from eggs.gnu.org ([2001:4830:134:3::10]:55765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1f93rD-0008Iw-B1
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 03:19:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1f93r8-0000QH-Bl
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 03:19:51 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180418123838.3511-1-olaf@aepfle.de>
	<20180418144538.4aa2f492.cohuck@redhat.com>
	<20180418125545.GN27579@redhat.com>
Date: Thu, 19 Apr 2018 09:19:28 +0200
In-Reply-To: <20180418125545.GN27579@redhat.com> ("Daniel P. =?utf-8?Q?Ber?=
	=?utf-8?Q?rang=C3=A9=22's?=
	message of "Wed, 18 Apr 2018 13:55:45 +0100")
Message-ID: <87sh7rvf27.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1] configure: require glib-2.24
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Olaf Hering <olaf@aepfle.de>, Fam Zheng <famz@redhat.com>, qemu-trivial@nongnu.org, Philippe =?utf-8?Q?Mathieu-?= =?utf-8?Q?Daud=C3=A9?= <f4bug@amsat.org>, "open list:All patches CC here" <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Wed, Apr 18, 2018 at 02:45:38PM +0200, Cornelia Huck wrote:
>
>> Are we ready to give up support for whatever distro is still on 2.22?
>> (If yes, can we bump to an even newer glib version?) Or should we
>> rather solve this by adding a g_realloc_n implementation for that case?
>
> Version 2.22 was released in Sep 2009, so coming up for 9 years old now.
>
> At some point we should to declare that platforms shipping >=3D NNN year
> old versions of software are not a desirable target for QEMU. What is
> our desired NNN value - 9 years feels awfully long to me.
>
> For libvirt we recently decided to become more aggressive[1] in culling o=
ld
> distros as supportable targets, declaring we'll only support non-EOL
> distros (for short life distros), or for long life distros (RHEL, LTS, et=
c)
> the most recent version, and the recent minus-1 for 2 years overlap.
>
> Should we formalize similar guidelines for QEMU to give developers a
> guide for when it is reasonable to increase the min required version of
> any 3rd party library ?  glib is a mandatory dep, but we've countless
> other optional libraries we might wish to increase min versions for too,
> and no guide on when it is reasonable todo so.

Yes, please.

>
> Regards,
> Daniel
>
> [1]   https://libvirt.org/platforms.html

This policy looks sensible to me
