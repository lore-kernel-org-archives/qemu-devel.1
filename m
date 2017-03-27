Received: from eggs.gnu.org ([2001:4830:134:3::10]:52451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1csUCD-0002wQ-Lb
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 08:56:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1csUC9-0002nV-Dj
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 08:56:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34992)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1csUC9-0002nF-4s
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 08:56:25 -0400
References: <3d1c16a1-ec05-0367-e569-64a63b34f2e3@redhat.com>
	<4a56f716-3528-ddd4-f8c4-f3f6b23c469a@redhat.com>
	<bbc2671a-42dd-aa2a-0f03-6a4a487cb8f5@redhat.com>
	<20170327120148.GC26900@stefanha-x1.localdomain>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <c58c7688-7ffa-6043-0919-0842931ddc9b@redhat.com>
Date: Mon, 27 Mar 2017 14:56:14 +0200
MIME-Version: 1.0
In-Reply-To: <20170327120148.GC26900@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="1FkbCGGrai5Q6x9WjXLQwPmAarurNWcSp"
Subject: Re: [Qemu-devel] Deprecating the -net option (was: What's the next
 QEMU version after 2.9 ? (or: when is a good point in time to get rid of
 old interfaces))
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: jasowang@redhat.com, John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1FkbCGGrai5Q6x9WjXLQwPmAarurNWcSp
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 27.03.2017 14:01, Stefan Hajnoczi wrote:
> On Mon, Mar 27, 2017 at 10:06:09AM +0200, Thomas Huth wrote:
>> On 24.03.2017 23:10, John Snow wrote:
>>>
>>>
>>> On 03/08/2017 03:26 AM, Thomas Huth wrote:
>>>>
>>>>  Hi everybody,
>>>>
>>>> what will be the next version of QEMU after 2.9? Will we go for a 2.=
10
>>>> (as I've seen it mentioned a couple of times on the mailing list
>>>> already), or do we dare to switch to 3.0 instead?
>>>>
>>>> I personally dislike two-digit minor version numbers like 2.10 since=
 the
>>>> non-experienced users sometimes mix it up with 2.1 ... and there hav=
e
>>>> been a couple of new cool features in the past releases that would
>>>> justify a 3.0 now, too, I think.
>>>>
>>>> But anyway, the more important thing that keeps me concerned is: Som=
eone
>>>>  once told me that we should get rid of old parameters and interface=
s
>>>> (like HMP commands) primarily only when we're changing to a new majo=
r
>>>> version number. As you all know, QEMU has a lot of legacy options, w=
hich
>>>> are likely rather confusing than helpful for the new users nowadays,=

>>>> e.g. things like the "-net channel" option (which is fortunately eve=
n
>>>> hardly documented), but maybe also even the whole vlan/hub concept i=
n
>>>> the net code, or legacy parameters like "-usbdevice". If we switch t=
o
>>>> version 3.0, could we agree to remove at least some of them?
>>>>
>>>>  Thomas
>>>>
>>>
>>> As others have stated, we need a few releases to deprecate things fir=
st.
>>>
>>> Maybe we should develop a serious plan to develop some of our legacy
>>> interfaces first.
>>>
>>> Maybe 2.10 can introduce a list of things we want to deprecate,
>>> 2.11 can be the transition release,
>>> and then 3.0 can cut the cord and free of us our terrible burden?
>>>
>>> I have a list of things I want to axe...
>>
>> I've started a Wiki page with such a list here:
>>
>> http://wiki.qemu-project.org/Features/LegacyRemoval
>=20
> It would be nice to get rid of the legacy -net option in 3.0.0.  I have=

> added it and included pointers to loose ends.  I think this is doable
> but will require some time to achieve.

Not sure whether we really can get rid of the -net option completely,
since AFAIK it is the only way to configure on-board NICs at the moment,
and Paolo complains if he needs to type longer command lines
(https://lists.gnu.org/archive/html/qemu-devel/2015-12/msg02448.html).

But maybe we could get rid of the VLANs here at least, e.g. by matching
"-net nic" and a following "-net user|bridge|tap|..." with an internal
netdev ID instead of creating a "VLAN" hub?

Or we could even turn the -net option into a full "convenience" option
instead (similar to "-hda" and friends), so that you even do not have to
specify "-net nic" anymore but create both, network source and sink with
one "-net" statement, e.g.:

 qemu-system-xxx -net user,model=3De1000,hostfwd=3D...

Just my 0.02 =E2=82=AC

 Thomas



--1FkbCGGrai5Q6x9WjXLQwPmAarurNWcSp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJY2QvzAAoJEC7Z13T+cC21js4P/3pazhtHG5MJnlehRzoOgYgw
bHAQ83fEfnhFLqOMNECKPREX4oKWcglxXLlYykucVky+gPVs0IYmx6EzJzupR59c
a8Q/LtblKqc/t3tvyhRxg7OBsxbEd3ImjYTARdzkNjDpoPnBgPwD42xTVpPPjB+1
wh61x0zb6XZM3x0CL9y6qTU8jvb4v5a1P8jB94ylXyCbhMw81npXe3TTDbafwjOX
flYaQRFSdUxMYc0W7ce+jaU72Q6oBTPeyESdKeyDmS4Ak8hBtGw1o561K8uoZtrp
0DXzcCKUEOEs5OVS2R9x/jpz3ZHyZckn8dJn8rHTuMUPfz6JvtjVwE4j2lZoiCnr
RZosEV7KvcxTE9LmAc3LwUv3lefb2z+Gac/ewrDo4aD4LHp53FBXW12leN0hQQRi
0NcC+6X6vCG9IgqZNbdAFZVY5zxZH2KX9TvzH9W9CEycRO9uAlnNGzod5mtKpqSH
v4IdF+m1GYt1T34UIXgoiu5j9Vm5Q4spJhGYgxigLxCJPLgQ1+/7VH2akPPwDFQk
3q6vloRPMNVNnXQLqbfw/B+Dk2pYfNvKfA+N9KQ6T2F7inUmjngSmJqWcsxvnCrw
YrPXs1grrda0X8nlv9njcxmVxpOMJzHlK+C5V1SiWMR1AS7YgxFpvIW8W//5NakF
bRw1D8uUm0n87iWC4YjX
=DJm0
-----END PGP SIGNATURE-----

--1FkbCGGrai5Q6x9WjXLQwPmAarurNWcSp--
