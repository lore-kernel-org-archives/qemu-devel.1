Received: from eggs.gnu.org ([209.51.188.92]:55668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ghCIQ-00020w-Ji
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 06:45:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ghCIO-0005uB-Cs
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 06:45:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44418)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ghCIO-0005tn-2W
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 06:45:16 -0500
Date: Wed, 9 Jan 2019 11:44:59 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190109114459.GK3998@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1546857926-5958-1-git-send-email-thuth@redhat.com>
	<20190109105818.GG3998@redhat.com>
	<ac1072de-07a9-3630-bf97-fd04c9f2de8a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ac1072de-07a9-3630-bf97-fd04c9f2de8a@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] configure: Force the C standard to gnu11
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, pbonzini@redhat.com, peter.maydell@linaro.org

On Wed, Jan 09, 2019 at 12:25:43PM +0100, Thomas Huth wrote:
> On 2019-01-09 11:58, Daniel P. Berrang=C3=A9 wrote:
> > On Mon, Jan 07, 2019 at 11:45:26AM +0100, Thomas Huth wrote:
> >> Different versions of GCC and Clang use different versions of the C =
standard.
> >> This repeatedly caused problems already, e.g. with duplicated typede=
fs:
> >>
> >>  https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg05829.html
> >>
> >> or with for-loop variable initializers:
> >>
> >>  https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg00237.html
> >>
> >> To avoid these problems, we should enforce the C language version to=
 the
> >> same level for all compilers. Since our minimum compiler versions ar=
e
> >> GCC v4.8 and Clang v3.4 now, and both basically support "gnu11" alre=
ady,
> >> this seems to be a good choice.
> >=20
> > In 4.x   gnu11 is marked as experimental. I'm not really comfortable
> > using experimental features - even if its warning free there's a risk
> > it would silently mis-compile something.
> >=20
> > gnu99 is ok with 4.x - it is merely "incomplete".
>=20
> gnu11 has the big advantage that it also fixes the problem with
> duplicated typedefs that are reported by older versions of Clang.
>=20
> Are you sure about the experimental character in 4.x? I just looked at
> https://gcc.gnu.org/onlinedocs/gcc-4.8.5/gcc/Standards.html and it says=
:
>=20
> "A fourth version of the C standard, known as C11, was published in 201=
1
> as ISO/IEC 9899:2011. GCC has limited incomplete support for parts of
> this standard, enabled with -std=3Dc11 or -std=3Diso9899:2011."
>=20
> It does not say anything about "experimental" there. The word
> "experimental" is only used for the C++ support, but we hardly have C++
> code in QEMU -- if you worry about that, I could simply drop the
> "-std=3Dgnu++11" part from my patch?

I was looking at the "info gcc" docs on RHEL7, gcc-4.8.5-16.el7_4.1.x86_6=
4:

  "3.4 Options Controlling C Dialect

   ....snip...

     'c11'
     'c1x'
     'iso9899:2011'
          ISO C11, the 2011 revision of the ISO C standard.  Support is
          incomplete and experimental.  The name 'c1x' is deprecated.

       ....snip...

     'gnu11'
     'gnu1x'
          GNU dialect of ISO C11.  Support is incomplete and
          experimental.  The name 'gnu1x' is deprecated."


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
