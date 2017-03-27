Received: from eggs.gnu.org ([2001:4830:134:3::10]:56065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1csUOz-0005a8-Tt
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 09:09:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1csUOv-0007cp-Tf
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 09:09:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38736)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1csUOv-0007at-KQ
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 09:09:37 -0400
References: <3d1c16a1-ec05-0367-e569-64a63b34f2e3@redhat.com>
	<4a56f716-3528-ddd4-f8c4-f3f6b23c469a@redhat.com>
	<bbc2671a-42dd-aa2a-0f03-6a4a487cb8f5@redhat.com>
	<20170327120148.GC26900@stefanha-x1.localdomain>
	<c58c7688-7ffa-6043-0919-0842931ddc9b@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <b82cff1f-173f-147f-4359-fc8266605f9f@redhat.com>
Date: Mon, 27 Mar 2017 15:09:27 +0200
MIME-Version: 1.0
In-Reply-To: <c58c7688-7ffa-6043-0919-0842931ddc9b@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="vFUjMa5g23QviOQ22Bh9oMrP4rSKph0VF"
Subject: Re: [Qemu-devel] Deprecating the -net option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, jasowang@redhat.com, John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vFUjMa5g23QviOQ22Bh9oMrP4rSKph0VF
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 27.03.2017 14:56, Thomas Huth wrote:
> On 27.03.2017 14:01, Stefan Hajnoczi wrote:
>> On Mon, Mar 27, 2017 at 10:06:09AM +0200, Thomas Huth wrote:
>>> On 24.03.2017 23:10, John Snow wrote:
>>>>
>>>>
>>>> On 03/08/2017 03:26 AM, Thomas Huth wrote:
>>>>>
>>>>>  Hi everybody,
>>>>>
>>>>> what will be the next version of QEMU after 2.9? Will we go for a 2=
=2E10
>>>>> (as I've seen it mentioned a couple of times on the mailing list
>>>>> already), or do we dare to switch to 3.0 instead?
>>>>>
>>>>> I personally dislike two-digit minor version numbers like 2.10 sinc=
e the
>>>>> non-experienced users sometimes mix it up with 2.1 ... and there ha=
ve
>>>>> been a couple of new cool features in the past releases that would
>>>>> justify a 3.0 now, too, I think.
>>>>>
>>>>> But anyway, the more important thing that keeps me concerned is: So=
meone
>>>>>  once told me that we should get rid of old parameters and interfac=
es
>>>>> (like HMP commands) primarily only when we're changing to a new maj=
or
>>>>> version number. As you all know, QEMU has a lot of legacy options, =
which
>>>>> are likely rather confusing than helpful for the new users nowadays=
,
>>>>> e.g. things like the "-net channel" option (which is fortunately ev=
en
>>>>> hardly documented), but maybe also even the whole vlan/hub concept =
in
>>>>> the net code, or legacy parameters like "-usbdevice". If we switch =
to
>>>>> version 3.0, could we agree to remove at least some of them?
>>>>>
>>>>>  Thomas
>>>>>
>>>>
>>>> As others have stated, we need a few releases to deprecate things fi=
rst.
>>>>
>>>> Maybe we should develop a serious plan to develop some of our legacy=

>>>> interfaces first.
>>>>
>>>> Maybe 2.10 can introduce a list of things we want to deprecate,
>>>> 2.11 can be the transition release,
>>>> and then 3.0 can cut the cord and free of us our terrible burden?
>>>>
>>>> I have a list of things I want to axe...
>>>
>>> I've started a Wiki page with such a list here:
>>>
>>> http://wiki.qemu-project.org/Features/LegacyRemoval
>>
>> It would be nice to get rid of the legacy -net option in 3.0.0.  I hav=
e
>> added it and included pointers to loose ends.  I think this is doable
>> but will require some time to achieve.
>=20
> Not sure whether we really can get rid of the -net option completely,
> since AFAIK it is the only way to configure on-board NICs at the moment=
,
> and Paolo complains if he needs to type longer command lines
> (https://lists.gnu.org/archive/html/qemu-devel/2015-12/msg02448.html).
>=20
> But maybe we could get rid of the VLANs here at least, e.g. by matching=

> "-net nic" and a following "-net user|bridge|tap|..." with an internal
> netdev ID instead of creating a "VLAN" hub?
>=20
> Or we could even turn the -net option into a full "convenience" option
> instead (similar to "-hda" and friends), so that you even do not have t=
o
> specify "-net nic" anymore but create both, network source and sink wit=
h
> one "-net" statement, e.g.:
>=20
>  qemu-system-xxx -net user,model=3De1000,hostfwd=3D...
>=20
> Just my 0.02 =E2=82=AC

=2E.. and I forgot to mention: We should at least try to get rid of the
options first that only work with -net (or rather the VLAN concept),
like "-net dump", "-net channel", "-tftp", "-smb", "-bootp" and
"-redir", since these will hinder us from doing further reworks /
clean-ups in this area. I think I've mentioned them all on the Wiki page
now, if somebody is aware of another legacy option here that does not
work with "-netdev" yet (apart from -net nic itself), please let me know.=


 Thomas



--vFUjMa5g23QviOQ22Bh9oMrP4rSKph0VF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJY2Q8MAAoJEC7Z13T+cC21McoP/iTpnFXm1oObM0P5G/v69d8h
zE7tLX7zxYW5jsLuodZyRzi0uokg6XibjJxI7liKbYZpE/QbH2puazjmNJPaUPng
/5b6NnuDIqpEMGsGjqXBzAilQr/HGsf48JacjWEF9q6xiJz/MeJEC7uUyfthIZr5
T/bJk3yMSf8fLscLjxlRUu98RWvO68D1aUqu09xwI2cC0/0Sr8Q/sLemAjgumkrq
wpY3udAge5IptUr0Fi6Ynq1qAnzs22t23AtTaqGi9YEiRSf/wh2CkD9a3SbogD+K
BJ4lPZ7fzR1YOoDV+/9AVlXvaeSYOWb5C9E7xpNbMBx7eqoLfCd0Wx/q63k0rhQy
vBHxRv8ZgoGMS0kuDr0CQOIGV8gNOObb/Y+veM2T2WDfhtJCiJvhTrntn5M/JtBt
pw7oyVet2xXo9dqXpN3Cljg7lKYAXuRj7yBP2Fyj9RXZ9jkbeHCqmpejPs829vtD
sYiWu6jf3xxpOyifo7EVjAlfxR8qK/e+eVFBfXkUUZtYp3WbemodlGxcKQ7TfA0T
PuC4nGn7oPEtyQwSEvNDf1awaQwl+eGxIAQM1UsCGdmLVwVOLn9n54dyPoYFI2EZ
7s633jLJQ/ScTSd6VT/GPChb7Jg50chJaTUGfMyzc9cc2PklVe9WwJxrRHLQhUKg
v6NDvAC7eZv4QuYfIby9
=VEKh
-----END PGP SIGNATURE-----

--vFUjMa5g23QviOQ22Bh9oMrP4rSKph0VF--
