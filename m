Received: from eggs.gnu.org ([209.51.188.92]:44986)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1h1ycm-00008W-4I
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 14:24:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1h1ycl-0005Jf-4S
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 14:24:12 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:57509)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1h1yck-0005Gj-OC
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 14:24:11 -0500
Date: Thu, 7 Mar 2019 20:23:55 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <CAFEAcA_hqpHfJkXa1SkyOaxdEYPYOOyOX0urRh6X2zYadPprXw@mail.gmail.com>
Message-ID: <alpine.BSF.2.21.9999.1903072016360.61349@zero.eik.bme.hu>
References: <3246431b-8d6e-f2bc-e0f0-99d80384d97b@redhat.com>
	<87r2bigarf.fsf@zen.linaroharston>
	<a6d25edf-1386-655e-6fd8-3b121838b00b@redhat.com>
	<CAFEAcA_ybrfeVdGrr=fWRg8xR1Yj33xySjX14-JmPvBySqKF8w@mail.gmail.com>
	<62408d6c-5a61-ffb2-f810-6ef36703b277@redhat.com>
	<CAMxuvaxeAdZKk_CQOyqCJdd_1kVZEBPCm0LRoP2u9aijOtbDxg@mail.gmail.com>
	<CAFEAcA_hqpHfJkXa1SkyOaxdEYPYOOyOX0urRh6X2zYadPprXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] converting build system to Meson?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>

On Thu, 7 Mar 2019, Peter Maydell wrote:
> On Thu, 7 Mar 2019 at 18:17, Marc-Andr=C3=A9 Lureau
> <marcandre.lureau@redhat.com> wrote:
>> As someone who has also been annoyed having to support in-tree and
>> out-of-tree, I support that move. I used to be a pretty happy use of
>> in-tree builds, but out-of-tree his generally equally convenient.
>>
>> Who is volunteering to do patches to deprecate the support? warning in
>> 4.0, and error in 4.1?
>
> Do we need to bother to deprecate it? It doesn't affect end-users,
> only those who build QEMU, and the change is easy...

If you do this without warning and time for getting used to it, it would=20
be nice to add some convenience functionality if possible to not upset=20
people used to in-tree builds too much. That is if someone runs make in=20
the top src dir it should create a build subdir and run make -C in there=20
instead of just returning an error so people can still just run make as=20
now instead of get frustrated every time until get used to use build dir.=
=20
(I sometimes use build dir, sometimes in-tree build and the latter is=20
often more convenient if I don't need multiple separate builds only one.)

Regards,
BALATON Zoltan
