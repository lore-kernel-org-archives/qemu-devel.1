Received: from eggs.gnu.org ([2001:4830:134:3::10]:53905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frankja@linux.vnet.ibm.com>) id 1dpsqE-0005Su-I1
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 05:11:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frankja@linux.vnet.ibm.com>) id 1dpsq9-0003T4-Hb
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 05:11:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41611)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frankja@linux.vnet.ibm.com>)
	id 1dpsq9-0003Sa-0h
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 05:11:13 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v879AXHv078553
	for <qemu-devel@nongnu.org>; Thu, 7 Sep 2017 05:11:11 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cu1kucbcv-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 07 Sep 2017 05:11:06 -0400
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <frankja@linux.vnet.ibm.com>;
	Thu, 7 Sep 2017 10:10:27 +0100
References: <20170905111645.18068-1-pasic@linux.vnet.ibm.com>
	<20170905111645.18068-6-pasic@linux.vnet.ibm.com>
	<20170906151821.1a77afe5.cohuck@redhat.com>
	<abc65014-f9fa-4cea-7f49-3e97e3845a3c@linux.vnet.ibm.com>
	<20170906172023.19a283a0.cohuck@redhat.com>
	<cafc4452-bdc5-546f-2ed0-4f1cb230f474@linux.vnet.ibm.com>
	<20170907100640.60de537a.cohuck@redhat.com>
From: Janosch Frank <frankja@linux.vnet.ibm.com>
Date: Thu, 7 Sep 2017 11:10:17 +0200
MIME-Version: 1.0
In-Reply-To: <20170907100640.60de537a.cohuck@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="SAKUsxpDXnHB25KNiDahcFnaQODHeAI3k"
Message-Id: <b0629ddd-ebea-b6b2-36b0-09715aae3aee@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 5/5] s390x/ccs: add ccw-tester emulated
 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Thomas Huth <thuth@redhat.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SAKUsxpDXnHB25KNiDahcFnaQODHeAI3k
From: Janosch Frank <frankja@linux.vnet.ibm.com>
To: Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Thomas Huth <thuth@redhat.com>, Dong Jia Shi
 <bjsdjshi@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>,
 qemu-devel@nongnu.org
Message-ID: <b0629ddd-ebea-b6b2-36b0-09715aae3aee@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 5/5] s390x/ccs: add ccw-tester emulated
 device
References: <20170905111645.18068-1-pasic@linux.vnet.ibm.com>
 <20170905111645.18068-6-pasic@linux.vnet.ibm.com>
 <20170906151821.1a77afe5.cohuck@redhat.com>
 <abc65014-f9fa-4cea-7f49-3e97e3845a3c@linux.vnet.ibm.com>
 <20170906172023.19a283a0.cohuck@redhat.com>
 <cafc4452-bdc5-546f-2ed0-4f1cb230f474@linux.vnet.ibm.com>
 <20170907100640.60de537a.cohuck@redhat.com>
In-Reply-To: <20170907100640.60de537a.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

[...]
>>>>> The main problem here is that you want to exercise a middle layer (=
the
>>>>> css code) and need to write boilerplate code on both host and guest=

>>>>> side in order to be able to do so.
>>>>>    =20
>>>>
>>>> Nod.
>>>> =20
>>>>> In general, a device that accepts arbitrary channel programs looks
>>>>> useful for testing purposes. I would split out processing of expect=
ed
>>>>> responses out, though, so that it can be more easily reused for
>>>>> different use cases.
>>>>>    =20
>>>>
>>>> I'm not sure what do you mean here. Could you clarify please? =20
>>>
>>> Maybe doing things like logging received ccws and responses etc. and
>>> and then comparing against an expected outcome. You should be able to=

>>> write test cases for different sets of things to be tested. I know th=
is
>>> is awfully vague :) =20
>>
>> Yes it does sound awfully vague :). In my case different tests are
>> actually done in the kernel module implementing a driver for this
>> device. I compare the expected outcome and the actual outcome there.
>> This device is just a back-end lending itself to experimentation.
>=20
> I think we want both guest-side and host-side checking. I think we
> should aim for a guest-side checker that does not require a kernel
> module (a simple guest makes it easier to run as an automated test.)

Sure, that would be great.

The thing is that I want to test the subchannel and not the device and
therefore I really do not want to have to issue control commands to a
device in order to get data. Having a device that reads and writes
without a lot of overhead (like this) is therefore my main target.

Where this device lives doesn't concern me and as I'm new to this
wonderful IO system take my statements with some salt. :)


>>>>> For the guest tester: Can that be done via the qtest infrastructure=

>>>>> somehow?
>>>>>    =20
>>>>
>>>> Well, for now I have the out-of-tree Linux kernel module provided in=
 the
>>>> cover letter of the series (you did not comment on that one yet). =20
>>>
>>> Yes, I saw that, but have not yet looked at it. If there is a way to =
do
>>> it without too many extra parts, I'd prefer that.
>>>  =20
>>
>> Well, I think the module is almost as economical with extra parts as i=
t
>> can get: it uses the kernel infrastructure and does not do a whole lot=

>> of things on top.
>=20
> And that's also the problem: You drag the whole kernel infrastructure
> along with i
>=20
>>
>> I think it's worth a look.
>=20
> It certainly is, but you know how it is with resources...

Yes it is and we certainly want to be integrated in as much external
testing as possible. It seems like a few people began to run into the
same direction but chose different approaches. My zonk test intentions
are mainly to get a understanding how this all works without having to
use the Linux devices but getting my hands dirty with the instructions
and structures.

I see your arguments and we'll look into it and discuss consolidating
our efforts.



--SAKUsxpDXnHB25KNiDahcFnaQODHeAI3k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZsQ0AAAoJEBcO/8Q8ZEV5e6gP/iGM1gKeWVRhFHCGnP+1MeLY
2xhALm7EDxrg1+ihIPGMwze1EeAgGeWVY53npD6Mqd01ZInXegjm2zdL4ISRafyg
Nx1i7bc6hUJ2XkWHxeQwlJyv9IYwTPNAmxcy7gI2gsQIrOOG68FuI4mVqt0cxZ0B
xAicMwjJbE8HbiDbpqXKx7eZGWTntDlLuq9iEW1ouvb6OxO2cuxzA7iVtXvTDA6q
z7nQiAeoeM6JLDagJkGJGm1hLLb3Z9gCzIiIU1KXUbYTmEPL+jzg2xBK+B7Gubwi
Kfpf1uUkrTtvPD/sgHc1OLQsJUKOtFn5oTAg/8ClU8GYXhOFa8t/NsNc73qmoDiI
FsfIKjdGUEkrNuPoZrPpqrCs16+gevalNGR54vTUA1zj9ms+Gtjnsd+eM4iZWAAP
XP2py5wW17geK54LalEUn+sJ5D7vxJ2a3iwHbQ5S8/s8HLW/UnsCBRkdiTeuc38v
v+wdVC1AN+kOkbn8aG/nkNCm6I3yvBpbGrpsFe2eyZ9kQsedpZtYgY3L17RM/u3+
tJCInXGJUnSb+Tb3cE5pSvPy+KaJ0+1fjvhKwCf1ZKyNBBgQ/+4w9swt6mjlhwdL
GOrs8eB+d07Q8uQ80iAyVTzqjTYovvR81UwgkKBEBDT5rRoKzLamiE20nfbjOX05
GUrBjQ1jRtfkYxrifQGW
=1qBN
-----END PGP SIGNATURE-----

--SAKUsxpDXnHB25KNiDahcFnaQODHeAI3k--
