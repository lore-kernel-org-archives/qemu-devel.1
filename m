Received: from eggs.gnu.org ([2001:4830:134:3::10]:34973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d99FI-0002SU-Ei
	for qemu-devel@nongnu.org; Fri, 12 May 2017 08:00:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d99FF-0001o2-E7
	for qemu-devel@nongnu.org; Fri, 12 May 2017 08:00:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54424)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1d99FF-0001n8-7N
	for qemu-devel@nongnu.org; Fri, 12 May 2017 08:00:29 -0400
References: <CALUZMn0mRMY7mx5ysWdSamV+UGbjwuif8UxQ47gFDK3fx8Hw2w@mail.gmail.com>
	<6e9a0dff-949f-5ac9-2315-cbe0e4c99f58@redhat.com>
	<CALUZMn14qgNz8y+15bsKFwyB9Ganoh0wzu5tfokCDRSASnBeKA@mail.gmail.com>
	<0c725626-6485-c777-46e3-99423670df89@redhat.com>
	<CALUZMn3W06H83E7hr4cHQ2jACp7A2x8hNyU1YirJssd3S7ut2Q@mail.gmail.com>
	<c41daf1b-1ead-0809-57f8-2bfd168b36e6@redhat.com>
	<CALUZMn3xVkhXRw7M08OaFs_NSE5WVV4U+CqsG2bPqzLLRWORtA@mail.gmail.com>
	<CALUZMn1zCo2_hsY5nyZ-J=ofSCj=WoEhYB2sis_goS-KA7mfvA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7e48191b-d660-ded5-0382-5643b0c15ce4@redhat.com>
Date: Fri, 12 May 2017 14:00:24 +0200
MIME-Version: 1.0
In-Reply-To: <CALUZMn1zCo2_hsY5nyZ-J=ofSCj=WoEhYB2sis_goS-KA7mfvA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Guest SIGILL when different IO is implemented
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Miltiadis Hatzimihail <hatzimiltos@gmail.com>
Cc: qemu-devel@nongnu.org



On 12/05/2017 09:26, Miltiadis Hatzimihail wrote:
> I ve tried the same today using a 32-bit Guest OS and the illegal
> instruction this time is
>=20
> fstps %(ecx)
>=20
> Is it a similar case to the movss one? (the previous Guest I was using
> was 64 bit).

Yes, it is.

Paolo

> Also, I had to start QEMU using the following command line options:
>=20
> qemu -cpu host,-sse2=20
>=20
> because one my programs was giving me an illegal instruction based on
> the above and it worked by disabling it.
>=20
> =E2=80=8BRegards
> Milton
>=20
> On Thu, May 11, 2017 at 2:12 PM, Miltiadis Hatzimihail
> <hatzimiltos@gmail.com <mailto:hatzimiltos@gmail.com>> wrote:
>=20
>     Ok many thanks for your help.
>=20
>     =E2=80=8BMilton
>=20
>     On Thu, May 11, 2017 at 2:11 PM, Paolo Bonzini <pbonzini@redhat.com
>     <mailto:pbonzini@redhat.com>> wrote:
>=20
>=20
>=20
>         On 11/05/2017 14:47, Miltiadis Hatzimihail wrote:
>         > That's great thanks for the clarification.
>         >
>         > Is this patch going to make it to the mainline at some point?
>=20
>         Not exactly as is, because it has a small defect (it always rea=
ds 16
>         bytes from memory), but something like that will.
>=20
>         Paolo
>=20
>=20
>=20
