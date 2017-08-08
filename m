Received: from eggs.gnu.org ([2001:4830:134:3::10]:35955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1df3lK-0007f5-1U
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 08:37:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1df3lI-0005zM-Ss
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 08:37:30 -0400
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:35575)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1df3lI-0005yj-Kt
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 08:37:28 -0400
Received: by mail-lf0-x242.google.com with SMTP id w199so2308174lff.2
	for <qemu-devel@nongnu.org>; Tue, 08 Aug 2017 05:37:27 -0700 (PDT)
MIME-Version: 1.0
References: <20170803090746.30532-1-marcandre.lureau@redhat.com>
	<1eca7ede-f103-ee90-1f9a-0fc44ef2b708@redhat.com>
	<cbf91ed4-a61a-78d7-e179-5826a335e4a9@redhat.com>
In-Reply-To: <cbf91ed4-a61a-78d7-e179-5826a335e4a9@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 08 Aug 2017 12:37:16 +0000
Message-ID: <CAJ+F1CJ23X1eHqWQDkY=3vNv4A+CXCSavxeA3bcdnbnTSQ8-GA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, cohuck@redhat.com, philippe.mathieu.daude@gmail.com, Alexander Graf <agraf@suse.de>, mst@redhat.com

Hi

On Sun, Aug 6, 2017 at 11:19 PM Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 05/08/2017 09:39, Thomas Huth wrote:
> >> +CONFIG_VHOST_USER_SCSI=3D$(and $(CONFIG_VHOST_USER),$(CONFIG_LINUX))
> > I have to say that I don't really like using $(and ...) in our makefile=
s
> > like this. You rely on the fact that the config variables are either se=
t
> > to "y" or not set at all ... but if somebody ever tries to set
> > CONFIG_VHOST_USER=3Dn and CONFIG_LINUX=3Dy for example (which sounds va=
lid,
> > too), this will break. Isn't there a better way of checking that both
> > variables are set to "y" ?
>
> $(call land, ...) does exactly this.
>

The patch is now merged. Thomas, Paolo, do you want to send a follow-up
patch? If not, I can.

thanks
--=20
Marc-Andr=C3=A9 Lureau
