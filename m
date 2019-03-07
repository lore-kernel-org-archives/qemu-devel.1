Received: from eggs.gnu.org ([209.51.188.92]:42336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1h1vOP-0005Hu-RH
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 10:57:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1h1vOP-00077S-4E
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 10:57:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37906)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1h1vON-00075S-2q
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 10:57:09 -0500
Date: Thu, 7 Mar 2019 16:56:43 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190307155643.cuypwvu7znhqng5y@sirius.home.kraxel.org>
References: <cover.1550698466.git.DirtY.iCE.hu@gmail.com>
	<cf14255c576fd361c6cdf941f8c637e613f6cb68.1550698466.git.DirtY.iCE.hu@gmail.com>
	<63250655-a4a3-ef36-5882-65188093ff57@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <63250655-a4a3-ef36-5882-65188093ff57@gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 04/14] audio: -audiodev command line
 option basic implementation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?= <dirty.ice.hu@gmail.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

On Tue, Feb 26, 2019 at 02:39:38AM +0100, Zolt=C3=A1n K=C5=91v=C3=A1g=C3=B3=
 wrote:
> On 2019-02-20 22:37, K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n wrote:
> [...]
> > diff --git a/audio/audio.c b/audio/audio.c
> > index ce8e6ea8c2..8ad8cbe559 100644
> > --- a/audio/audio.c
> > +++ b/audio/audio.c
> [...]
> > @@ -2129,3 +1866,170 @@ void AUD_set_volume_in (SWVoiceIn *sw, int mu=
te, uint8_t lvol, uint8_t rvol)
> >          }
> >      }
> >  }
> > +
> > +void audio_create_pdos(Audiodev *dev)
> > +{
> > +    switch (dev->driver) {
> > +#define CASE(DRIVER, driver, pdo_name)                              =
\
> > +    case AUDIODEV_DRIVER_##DRIVER:                                  =
\
> > +        dev->u.driver.in =3D g_malloc0(                             =
  \
> > +            sizeof(Audiodev##pdo_name##PerDirectionOptions));       =
\
> This should check has_in before overwriting. It'll work correctly when
> called from audio_legacy.c, but when using -audiodev it will overwrite
> the options passed by user (and leak memory) when called from
> audio_validate_opts. I'll fix it in the next update.

Ping.  4.0 freeze is next tuesday.  Any chance for a v6 early enough
that we have a chance to get the first chunk into 4.0?  Monday latest,
preferably earlier ...

thanks,
  Gerd
