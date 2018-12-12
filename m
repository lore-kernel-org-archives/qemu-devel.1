Received: from eggs.gnu.org ([2001:4830:134:3::10]:56957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gX0Sh-0005E3-Bm
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 04:05:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gX0Sb-000674-1P
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 04:05:47 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46491)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1gX0Sa-00066P-Ru
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 04:05:40 -0500
Received: by mail-qt1-f196.google.com with SMTP id y20so19611691qtm.13
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 01:05:39 -0800 (PST)
MIME-Version: 1.0
References: <20181208111606.8505-1-marcandre.lureau@redhat.com>
	<20181208111606.8505-3-marcandre.lureau@redhat.com>
	<87woofjfei.fsf@dusky.pond.sub.org>
In-Reply-To: <87woofjfei.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 12 Dec 2018 13:05:26 +0400
Message-ID: <CAMxuvawL4Li09bB-KyZJM=Cr=tR83JXfEo8NYp-zMQtwqPEN2g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-4.0 v7 02/27] qapi: do not define
 enumeration value explicitly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Armbruster, Markus" <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>

Hi

On Wed, Dec 12, 2018 at 12:52 PM Markus Armbruster <armbru@redhat.com> wrot=
e:
>
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
> > The C standard has the initial value at 0 and the subsequent values
> > incremented by 1. No need to set this explicitely.
> >
> > This will prevent from artificial "gaps" when compiling out some enum
> > values and having unnecessarily large MAX values & enums arrays, or
> > simplifying iterating over valid enum values.
>
> Should mention that compiling out will only become possible later in
> this series.
>
> > Whenever config-host.h is changed, all the enum/types are recompiled.
>
> This soundness argument is incomplete.  Yes, our coding conventions
> ensure everything gets recompiled when config-host.h changes.  But
> nothing stops people from using 'if' conditions that depend on more than
> just config-host.h.
>
> What about this:
>
>   qapi: Do not define enumeration value explicitly
>
>   The generated C enumeration types explicitly set the enumeration
>   constants to 0, 1, 2, ...  That's exactly what you get when you don't
>   supply values.
>
>   Drop the explicit values.  No change now, but it will avoid gaps in
>   the values when we later add support for 'if' conditions.  Avoiding
>   such gaps will save us the trouble of changing the ENUM_lookup[]
>   tables to work without a sentinel.
>
>   We'll have to take care to ensure the headers required by the 'if'
>   conditions get always included before the generated QAPI code.
>   Fortunately, our convention to include "qemu/osdep.h" first in any .c
>   ensures that's the case for our CONFIG_FOO macros.
>
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> With an improved commit message:
> Reviewed-by: Markus Armbruster <armbru@redhat.com>

ack, thanks!
