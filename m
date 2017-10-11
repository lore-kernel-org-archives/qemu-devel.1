Received: from eggs.gnu.org ([2001:4830:134:3::10]:40306)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <carenas@gmail.com>) id 1e2B9c-0003lf-PV
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 03:10:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <carenas@gmail.com>) id 1e2B9b-0007LM-S1
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 03:10:08 -0400
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:49551)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <carenas@gmail.com>) id 1e2B9b-0007Kq-MJ
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 03:10:07 -0400
Received: by mail-wm0-x236.google.com with SMTP id b189so2409829wmd.4
	for <qemu-devel@nongnu.org>; Wed, 11 Oct 2017 00:10:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170925231924.31303-1-carenas@gmail.com>
References: <20170925231924.31303-1-carenas@gmail.com>
From: Carlo Arenas <carenas@gmail.com>
Date: Wed, 11 Oct 2017 00:10:04 -0700
Message-ID: <CAPUEspg5AO_XzLa1n3cCTrz+22WYk5BZrE28ufDjPP7Y3KN2+Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] linux-user: refactor socket.h into architecture
 specific sockbits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, riku.voipio@iki.fi

ping

some of the patches already have a Reviewed-by as shown by :

  http://patchwork.ozlabs.org/patch/818378/

On Mon, Sep 25, 2017 at 4:19 PM, Carlo Marcelo Arenas Bel=C3=B3n
<carenas@gmail.com> wrote:
> the definitions in socket.h are meant to reflect the ones in linux for ea=
ch
> respective target, but are sometimes difficult to maintain.
>
> hppa (AKA parisc) was initially merged with an independent file that mirr=
ors
> more closely the corresponding one in linux but hasn't been updated since=
.
>
> this series updates hppa with the latest bits from linux 4.14 and makes s=
ure
> all relevant architectures had a sockbits file that would be easy to main=
tain
> going forward.
>
> most of the changes are pretty mechanical and I had made (thanks to Laure=
nt's
> tough review) every effort to ensure no value gets changed accidentaly an=
d
> all changes (even the ones where the value remains but is now in a differ=
ent
> base to better match what was used in the linux headers) are documented, =
so
> it should be fairly safe and will fix bugs (mostly for sparc).
>
