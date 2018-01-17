Received: from eggs.gnu.org ([2001:4830:134:3::10]:35307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ebpEg-0001Vy-Pq
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 10:02:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ebpEe-0000gC-7h
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 10:02:42 -0500
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:42900)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ebpEe-0000dj-1m
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 10:02:40 -0500
Received: by mail-qt0-x242.google.com with SMTP id c2so22856176qtn.9
	for <qemu-devel@nongnu.org>; Wed, 17 Jan 2018 07:02:39 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180117131821.18700-1-f4bug@amsat.org>
	<20180117131821.18700-2-f4bug@amsat.org>
	<20180117133201.GN19227@redhat.com>
	<a38e57e4-b291-e7a1-3086-c2a1714f1b7f@amsat.org>
	<20180117143911.GQ19227@redhat.com>
	<4b70d091-4131-e502-e808-2415c27b4b7b@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <b61a6744-079f-d7a3-f2e3-30eef6de0167@amsat.org>
Date: Wed, 17 Jan 2018 12:02:32 -0300
MIME-Version: 1.0
In-Reply-To: <4b70d091-4131-e502-e808-2415c27b4b7b@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="jZV16HsvXGGjH3lv510k4HegH0c7ghwl4"
Subject: Re: [Qemu-devel] [RFC PATCH 1/3] compiler: add
 QEMU_WARN_NONNULL_ARGS()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Stefan Weil <sw@weilnetz.de>, Luiz Capitulino <lcapitulino@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jZV16HsvXGGjH3lv510k4HegH0c7ghwl4
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Eric Blake <eblake@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Stefan Weil <sw@weilnetz.de>, Luiz Capitulino <lcapitulino@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b61a6744-079f-d7a3-f2e3-30eef6de0167@amsat.org>
Subject: Re: [Qemu-devel] [RFC PATCH 1/3] compiler: add
 QEMU_WARN_NONNULL_ARGS()
References: <20180117131821.18700-1-f4bug@amsat.org>
 <20180117131821.18700-2-f4bug@amsat.org> <20180117133201.GN19227@redhat.com>
 <a38e57e4-b291-e7a1-3086-c2a1714f1b7f@amsat.org>
 <20180117143911.GQ19227@redhat.com>
 <4b70d091-4131-e502-e808-2415c27b4b7b@redhat.com>
In-Reply-To: <4b70d091-4131-e502-e808-2415c27b4b7b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/17/2018 11:56 AM, Eric Blake wrote:
> On 01/17/2018 08:39 AM, Daniel P. Berrange wrote:
>=20
>>>>
>>>> GCC may or may not warn you about passing NULL for the 'bar'
>>>> parameter, but it will none the less assume nothing passes
>>>> NULL, and thus remove the 'if (!bar)' conditional during
>>>> optimization. IOW, adding nonnull annotations can actually
>>>> make your code less robust :-(
>=20
> The gcc bug mentioned in the libvirt code says that newer gcc may be
> smarter than when we added the libvirt workaround:
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D17308
>=20
> But I haven't played with it in a long time (the sour experience with
> misoptimized code with no warning has made me wary of re-trying).

I have been there...

>>>
>>> Why do you use __attribute__(()) ? Isn't this enough:
>>
>> No idea offhand - Eric wrote this so perhaps he had a reason for that
>> else branch style.
>>
>>>
>>> #if defined __clang_analyzer__ || defined __COVERITY__
>>> #define QEMU_STATIC_ANALYSIS 1
>>> +#define QEMU_WARN_NONNULL_ARGS(args...) __attribute__((nonnull(args)=
))
>>> +#else
>>> +#define QEMU_WARN_NONNULL_ARGS(args...)
>>> #endif
>=20
> My reasoning for using the empty attribute was to at least ensure that
> the gcc compilation agrees that the annotation is syntactically valid
> (nothing worse than sticking an __attribute__ code in a place that gcc
> doesn't like, but only for static checker builds, so you don't learn
> about it right away).  Defining the macro to nothing, rather than an
> empty attribute, makes it harder for the common-case compilation to
> detect placement problems.

I wouldn't have thought of that, thanks!

Phil.


--jZV16HsvXGGjH3lv510k4HegH0c7ghwl4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+qvnXhKRciHc/Wuy4+MsLN6twN4FAlpfZYoACgkQ4+MsLN6t
wN43dhAAveTa/QnvkFdJF/1IbJ9cK//5bm1veS9zNkwOpecXo/ZHikXx9VdiJZPv
Bt97nmHYnPYoFRQEjLJkM4fVhzb2bi0K9t5WjkFPSQzux7H91lpDg7oHMN6sWZ+I
rsfofW0ZpRiVbpO8PnWl878h55OKJX4EWg25RSGJKJNxdZEhIo1XwvBzwBEoOOzj
+V9kUxr3bDz4VUodQgejUm0Orgx5oV0rFuHJMy+xKSj8hcebP/SQEBnn9eMI38Wh
DissgG8g1HUefHDIanhGNMUG06AJax6WIGQySaYoI8ObKIsc0thXPb2muACo5Adh
PwKOvZi4PN1hpzfl5sWVgoDo9BuUm9yAKYAVSvmSQctB29ssd9zudZ9atxm6pB4X
hjFbjAwJU0awkkJ+4eXjn6SvhFGWSFfMtn5CAcoDnV1C0GnKBu3AtXtr8wpFlsnq
StCNPKc6NcrQq9hi90QIV15fGgPISqL566V/qUqLkabvts6EPzRZ798Wt+cNMqL2
fnVGCkmUH8c+Ifns+/AJXHWClSqgmXtL2AdaUyq5UCVshoPDC7d8FxQavpeXpdl8
v+IQ0lSXmANhDS8Dtc297X2Dwh4uPCG1H8g+iLAXGZSzYcUpY7qKM1FfnNXieNFr
/srEtfXt3ru2yN/kgFKMnAxlBa+RIB53oPMZoT8JpRHz0HCQAVs=
=HiUE
-----END PGP SIGNATURE-----

--jZV16HsvXGGjH3lv510k4HegH0c7ghwl4--
