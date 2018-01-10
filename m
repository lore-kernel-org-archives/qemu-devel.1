Received: from eggs.gnu.org ([2001:4830:134:3::10]:40234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <patricktsen@gmail.com>) id 1eZJpa-00074i-Eg
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 12:06:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <patricktsen@gmail.com>) id 1eZJpY-0005om-VX
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 12:06:26 -0500
Received: from mail-oi0-x22f.google.com ([2607:f8b0:4003:c06::22f]:44205)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <patricktsen@gmail.com>)
	id 1eZJpY-0005o0-OD
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 12:06:24 -0500
Received: by mail-oi0-x22f.google.com with SMTP id g128so1502541oib.11
	for <qemu-devel@nongnu.org>; Wed, 10 Jan 2018 09:06:24 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180110163003.GO3205@redhat.com>
References: <20180107221455.25504-1-patricktsen@gmail.com>
	<20180110163003.GO3205@redhat.com>
From: Patrick Tseng <patricktsen@gmail.com>
Date: Wed, 10 Jan 2018 09:06:03 -0800
Message-ID: <CAG_FrSLEpZ8XugfbndEa2UO8yMGxetf2juS7ft-hUP2SRDF7qA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 0/1] input-linux: provide hotkeys for
 evdev toggle
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com

Hi Daniel, thanks for responding.

> This should really be part of the commit message for the patch itself, so
it
> gets recorded in git history.

Next patch version I'll separate this out to another commit.

> I wonder if it is reasonable for ui/input-linux.c to honour the same
> global '-ungrab' configuration option ?

I had it as a global config option at first, but realized all config options
related to input-linux appears to be contained in it's own object-based
args, especially since evdev is still quite niche/isolated in its own way.

But I rather not make the decisions for input-linux, I'll leave that up to
the maintainer.

> If not, we should  at least
> use the same syntax for describing the ungrab sequence. ie a list of
> key code names, rather than a hardcoded pair of numeric values.

This make sense, I agree it should at least be consistent.

- Patrick
(byxk)

On Wed, Jan 10, 2018 at 8:30 AM, Daniel P. Berrange <berrange@redhat.com>
wrote:

> On Sun, Jan 07, 2018 at 02:14:54PM -0800, byxk wrote:
> > Added some functionality to change the key combo for evdev toggle.
> > example:
> > -object input-linux,rhotkey=29,lhotkey=56,evdev=[etc...]
> >
> > Set the defaults to LCTRL and RCTRL if not provided.
>
> This should really be part of the commit message for the patch itself, so
> it
> gets recorded in git history.
>
> There is some overlap here with the grab sequence work John has just posted
> for cocoa frontend
>
>   https://lists.gnu.org/archive/html/qemu-devel/2017-12/msg05115.html
>
> I wonder if it is reasonable for ui/input-linux.c to honour the same
> global '-ungrab' configuration option ?  If not, we should  at least
> use the same syntax for describing the ungrab sequence. ie a list of
> key code names, rather than a hardcoded pair of numeric values.
>
>
> Regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/
> dberrange :|
> |: https://libvirt.org         -o-
> https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/
> dberrange :|
>
