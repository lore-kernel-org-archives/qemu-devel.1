Received: from eggs.gnu.org ([2001:4830:134:3::10]:59171)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cyId1-00054G-BK
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 09:48:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cyId0-0002z2-BK
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 09:48:11 -0400
Received: from mail-lf0-x22b.google.com ([2a00:1450:4010:c07::22b]:33816)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1cyId0-0002xH-0I
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 09:48:10 -0400
Received: by mail-lf0-x22b.google.com with SMTP id t144so14647596lff.1
	for <qemu-devel@nongnu.org>; Wed, 12 Apr 2017 06:48:08 -0700 (PDT)
MIME-Version: 1.0
References: <3d1c16a1-ec05-0367-e569-64a63b34f2e3@redhat.com>
	<20170308102009.GF7470@redhat.com>
	<1488971976.6514.54.camel@redhat.com>
In-Reply-To: <1488971976.6514.54.camel@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 12 Apr 2017 13:47:56 +0000
Message-ID: <CAJ+F1CLF1DLBD7HwegMzFPW13AkTUyt=g27hr_ObwLFaucM_iA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] What's the next QEMU version after 2.9 ? (or: when
 is a good point in time to get rid of old interfaces)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>

Hi

On Wed, Mar 8, 2017 at 12:20 PM Gerd Hoffmann <kraxel@redhat.com> wrote:

>   Hi,
>
> > libvirt suffered similar lack of clarity around when to bump major
> version
> > number as opposed to minor version. To address this we recently adopted
> the
> > rule[1] that major version number changes have no relation to features.
> The
> > major number is simply incremented at the start of each calendar year.
>
> I like the idea of time-based version numbering.  Changing the plan for
> 2.9 still is probably a bad idea given we have a 2.9 machine type
> already etc.
>
> But we can start changing things afterwards.  So we could start with 3.x
> after 2.9, and bump the major for the first release each year
> (libvirt-style).  Or we could use the year as major number and jump
> straight to 17.x (mesa-style).
>
> > From the POV of libvirt, I don't think saying that .0 releases have
> > incompatible changes is particularly useful in itself. What *is* useful
> > is to have a clear rule around a deprecation cycle. ie, a rule that say=
s
> > a feature will be marked deprecated for 3 releases or 12 months, before
> it
> > is permitted to be removed/changed. If that were followed, there is no
> > need to batch up such changes in a .0 release IMHO.
>
> Yes, it's probably a good idea to deprecate things first.  When going
> with the 12 months rule it could be useful to batch things and do a
> yearly "spring cleaning" when the major is bumped.
>
>
What about deprecating GTK 2.0 ? SDL (1.2 or all?)

I suspect there are also a number of arm boards that are not regularly
tested and could be drop, who could tell?

--=20
Marc-Andr=C3=A9 Lureau
