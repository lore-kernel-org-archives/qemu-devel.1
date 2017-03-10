Received: from eggs.gnu.org ([2001:4830:134:3::10]:53148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cmJ6i-0000RH-UD
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 06:53:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cmJ6e-0000Ey-2s
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 06:53:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41942)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1cmJ6d-0000Ed-Sx
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 06:53:12 -0500
References: <3d1c16a1-ec05-0367-e569-64a63b34f2e3@redhat.com>
	<CAFEAcA9cM=LjBRzrZdfsOss2xm4bKC6QM7gyg3HD4z-yeumTyw@mail.gmail.com>
	<940ff281-82cd-18cf-160e-c5234f65db18@redhat.com>
	<9d6c61bc-4a95-ce72-3565-e498f9c2b351@redhat.com>
	<b815c2f9-1ce9-efed-4afa-c3553786dab1@redhat.com>
	<16223ebe-e08d-c686-7ff3-a58db88e3a01@redhat.com>
	<d897339f-9451-d350-6fd5-72c68a2da677@imgtec.com>
	<1aeb7375-d41f-1be4-cbb5-d7bd27801110@redhat.com>
	<CAFEAcA9x1c74MBetKxxwQSNWhC=C8JV80QCBiEuY3pLteY=UVA@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <24f60ae4-9a6b-eaa6-7300-1e908eff8a24@redhat.com>
Date: Fri, 10 Mar 2017 12:53:03 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9x1c74MBetKxxwQSNWhC=C8JV80QCBiEuY3pLteY=UVA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
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
To: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>
Cc: Yongbok Kim <yongbok.kim@imgtec.com>, Aurelien Jarno <aurelien@aurel32.net>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

On 10.03.2017 12:22, Peter Maydell wrote:
> On 10 March 2017 at 12:07, Jason Wang <jasowang@redhat.com> wrote:
>> On 2017=E5=B9=B403=E6=9C=8809=E6=97=A5 18:20, Yongbok Kim wrote:
>>> Indeed but we still use the platform to verify architectural
>>> compatibilities even for newer MIPS architectures.
>=20
>> I see, but I believe it may need some modifications in the code to sup=
port
>> newer architectures? If yes, plan to send them upstream? Since it has =
been
>> deprecated, if no new codes it makes sense to deprecate it in qemu too=
. You
>> can still use exist qemu versions to do the verification.
>=20
> Taking a step back, the reason for deprecating and deleting
> code is to avoid having unmaintained and unused code in QEMU.
> If Yongbok is maintaining the mipssim board and devices
> and is willing to keep them up to spec with current QOM
> and other best practices, and there are test images to
> check they still work, I think that's fine.

But the Mipssim machine is currently marked as "Orphan" in our
MAINTAINERS file ... Yongbok, if you're still using it, would you maybe
be interested in doing at least "Odd fixes" here?
BTW, I think "F: hw/net/mipsnet.c" should be added to the "Mipssim"
section, too.

 Thomas
