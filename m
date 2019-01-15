Received: from eggs.gnu.org ([209.51.188.92]:55660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gjKUz-0003ET-UP
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 03:55:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gjKUx-00046n-SS
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 03:55:05 -0500
Date: Tue, 15 Jan 2019 09:54:57 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190115095457.02ea9189.cohuck@redhat.com>
In-Reply-To: <81fc43ea-f141-1c76-d217-6c1880ece901@linux.ibm.com>
References: <1544623878-11248-1-git-send-email-jjherne@linux.ibm.com>
	<1544623878-11248-11-git-send-email-jjherne@linux.ibm.com>
	<20181213182100.6da37a95.cohuck@redhat.com>
	<bfde1bd3-0725-1085-8a98-eeaf2b0694ed@linux.ibm.com>
	<81fc43ea-f141-1c76-d217-6c1880ece901@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH 10/15] s390-bios: Support for
 running format-0/1 channel programs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Jason J. Herne" <jjherne@linux.ibm.com>
Cc: pasic@linux.ibm.com, borntraeger@de.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org

On Mon, 14 Jan 2019 13:44:12 -0500
"Jason J. Herne" <jjherne@linux.ibm.com> wrote:

> On 1/7/19 2:02 PM, Jason J. Herne wrote:
> >>> @@=C2=A0-190,6=C2=A0+247,9=C2=A0@@=C2=A0struct=C2=A0ciw=C2=A0{
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0__u16=C2=A0count;
> >>> =C2=A0=C2=A0};
> >>> +#define=C2=A0CU_TYPE_VIRTIO=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A00x3832
> >>> +#define=C2=A0CU_TYPE_DASD=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00x3990 =20
> >>
> >> No=C2=A0other=C2=A0dasd=C2=A0types=C2=A0we=C2=A0want=C2=A0to=C2=A0supp=
ort? :)=C2=A0(Not=C2=A0sure=C2=A0if=C2=A0others=C2=A0are=C2=A0out
> >> in=C2=A0the=C2=A0wild.=C2=A0Maybe=C2=A0FBA?)
> >> =20
> >=20
> > I have no idea. I assumed 3390 was the only thing we supported. Perhaps=
 3380? I'd need to=20
> > find=C2=A0a=C2=A0test=C2=A0device,=C2=A0which=C2=A0I=C2=A0could=C2=A0pr=
obably=C2=A0do=C2=A0...=C2=A0I'll=C2=A0look=C2=A0more=C2=A0into=C2=A0this. =
=20
>=20
> After a few discussions with folks in the lab we've decided that we don't=
 see a ton of=20
> value in supporting anything other than 3990 at the moment. Anything else=
 would be older=20
> (3380) and/or rare to see in the wild (and very difficult to test). As fo=
r emulated setups=20
> like z/VM, a user can just use 3390 instead of FBA. So I recommend we mov=
e forward with=20
> 3390/3990 support for now. We can always add in others types if/when we n=
eed them.

Sounds reasonable.

What about calling the #define above CU_TYPE_DASD_3990 instead? Just to
make clear that there are other dasd types out there, but we only
support that particular one (at least at the moment).
