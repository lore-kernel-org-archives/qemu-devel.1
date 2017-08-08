Received: from eggs.gnu.org ([2001:4830:134:3::10]:39607)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1df3tj-0003zH-6m
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 08:46:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1df3tf-0002UW-AE
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 08:46:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38778)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1df3tf-0002UD-3g
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 08:46:07 -0400
References: <20170803090746.30532-1-marcandre.lureau@redhat.com>
	<1eca7ede-f103-ee90-1f9a-0fc44ef2b708@redhat.com>
	<cbf91ed4-a61a-78d7-e179-5826a335e4a9@redhat.com>
	<CAJ+F1CJ23X1eHqWQDkY=3vNv4A+CXCSavxeA3bcdnbnTSQ8-GA@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <27f7b529-8c8e-2b2d-933f-e97b116a8fca@redhat.com>
Date: Tue, 8 Aug 2017 14:46:00 +0200
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CJ23X1eHqWQDkY=3vNv4A+CXCSavxeA3bcdnbnTSQ8-GA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3] build-sys: add --disable-vhost-user
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, cohuck@redhat.com, philippe.mathieu.daude@gmail.com, Alexander Graf <agraf@suse.de>, mst@redhat.com

On 08.08.2017 14:37, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Sun, Aug 6, 2017 at 11:19 PM Paolo Bonzini <pbonzini@redhat.com
> <mailto:pbonzini@redhat.com>> wrote:
>=20
>     On 05/08/2017 09:39, Thomas Huth wrote:
>     >> +CONFIG_VHOST_USER_SCSI=3D$(and $(CONFIG_VHOST_USER),$(CONFIG_LI=
NUX))
>     > I have to say that I don't really like using $(and ...) in our
>     makefiles
>     > like this. You rely on the fact that the config variables are
>     either set
>     > to "y" or not set at all ... but if somebody ever tries to set
>     > CONFIG_VHOST_USER=3Dn and CONFIG_LINUX=3Dy for example (which sou=
nds
>     valid,
>     > too), this will break. Isn't there a better way of checking that =
both
>     > variables are set to "y" ?
>=20
>     $(call land, ...) does exactly this.
>=20
> =20
> The patch is now merged. Thomas, Paolo, do you want to send a follow-up
> patch? If not, I can.

There are also a bunch of other spots in our Makefiles that use $(and
...) and shoult be converted to $(call land) instead. I already put a
TODO item on my list, so I'll eventually send a patch for this. But if
you're faster, feel free to post it first (just put me on CC: so that I
am aware of it).

 Thomas
