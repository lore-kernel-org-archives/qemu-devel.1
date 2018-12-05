Received: from eggs.gnu.org ([2001:4830:134:3::10]:36395)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <boris.ostrovsky@oracle.com>) id 1gUY2D-0008GM-27
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 09:20:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <boris.ostrovsky@oracle.com>) id 1gUY21-0003y3-Kx
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 09:20:16 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:55444)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <boris.ostrovsky@oracle.com>)
	id 1gUY21-0003qS-A9
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 09:20:05 -0500
References: <CAGxU2F7+NZUS-BQ1hCnKynVxfsVUYTHRCWQvJwBA12bYmg0ZJA@mail.gmail.com>
	<938a2f54426dc059428fcfe1882bbb3b2d5cbc99.camel@intel.com>
	<CAGxU2F50U=NH8fGDXygcYycjoveNpdbKnnG3H0soCvub_Ea5cw@mail.gmail.com>
	<CAGxU2F7SA-kc0gsLNaUzbiinytJ2DF_r5UpB1JzRy-Su1_WOLw@mail.gmail.com>
	<a1ca57134a970fb3282afb36c0e3b5647b104ff8.camel@intel.com>
	<CAGxU2F7Sg0JaxyPQw_FhSc6MzYu+YzZpv9=VHp8qvwfTWpf_MQ@mail.gmail.com>
	<59cc9e47-3c2a-2417-9e89-e7ade92fdf2d@oracle.com>
	<20181205132041.GB24623@stefanha-x1.localdomain>
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Message-ID: <808ece43-1c59-53a1-60e0-0270d0cbd8f2@oracle.com>
Date: Wed, 5 Dec 2018 09:19:55 -0500
MIME-Version: 1.0
In-Reply-To: <20181205132041.GB24623@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="PQOB1ht9hnzb3vQIq1Q5LdbFS0Jn4u5Za"
Subject: Re: [Qemu-devel] QEMU/NEMU boot time with several x86 firmwares
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, Maran Wilson <maran.wilson@oracle.com>
Cc: qemu-devel@nongnu.org, Samuel Ortiz <sameo@linux.intel.com>, Rob Bradford <robert.bradford@intel.com>, Stefano Garzarella <sgarzare@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PQOB1ht9hnzb3vQIq1Q5LdbFS0Jn4u5Za
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
To: Stefan Hajnoczi <stefanha@redhat.com>,
 Maran Wilson <maran.wilson@oracle.com>
Cc: qemu-devel@nongnu.org, Samuel Ortiz <sameo@linux.intel.com>,
 Rob Bradford <robert.bradford@intel.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Message-ID: <808ece43-1c59-53a1-60e0-0270d0cbd8f2@oracle.com>
Subject: Re: [Qemu-devel] QEMU/NEMU boot time with several x86 firmwares
References: <CAGxU2F7+NZUS-BQ1hCnKynVxfsVUYTHRCWQvJwBA12bYmg0ZJA@mail.gmail.com>
 <938a2f54426dc059428fcfe1882bbb3b2d5cbc99.camel@intel.com>
 <CAGxU2F50U=NH8fGDXygcYycjoveNpdbKnnG3H0soCvub_Ea5cw@mail.gmail.com>
 <CAGxU2F7SA-kc0gsLNaUzbiinytJ2DF_r5UpB1JzRy-Su1_WOLw@mail.gmail.com>
 <a1ca57134a970fb3282afb36c0e3b5647b104ff8.camel@intel.com>
 <CAGxU2F7Sg0JaxyPQw_FhSc6MzYu+YzZpv9=VHp8qvwfTWpf_MQ@mail.gmail.com>
 <59cc9e47-3c2a-2417-9e89-e7ade92fdf2d@oracle.com>
 <20181205132041.GB24623@stefanha-x1.localdomain>
In-Reply-To: <20181205132041.GB24623@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 12/5/18 8:20 AM, Stefan Hajnoczi wrote:
> On Tue, Dec 04, 2018 at 02:44:33PM -0800, Maran Wilson wrote:
>>
>> Since then, we have put together an alternative solution that would al=
low
>> Qemu to boot an uncompressed Linux binary via the x86/HVM direct boot =
ABI
>> (https://xenbits.xen.org/docs/unstable/misc/pvh.html). The solution in=
volves
>> first making changes to both the ABI as well as Linux, and then updati=
ng
>> Qemu to take advantage of the updated ABI which is already supported b=
y both
>> Linux and Free BSD for booting VMs. As such, Qemu can remain OS agnost=
ic,
>> and just be programmed to the published ABI.
>>
>> The canonical definition for the HVM direct boot ABI is in the Xen tre=
e and
>> we needed to make some minor changes to the ABI definition to allow KV=
M
>> guests to also use the same structure and entry point. Those changes w=
ere
>> accepted to the Xen tree already:
>> https://lists.xenproject.org/archives/html/xen-devel/2018-04/msg00057.=
html
>>
>> The corresponding Linux changes that would allow KVM guests to be boot=
ed via
>> this PVH entry point have already been posted and reviewed:
>> https://lkml.org/lkml/2018/4/16/1002
>>
>> The final part is the set of Qemu changes to take advantage of the abo=
ve and
>> boot a KVM guest via an uncompressed kernel binary using the entry poi=
nt
>> defined by the ABI. Liam Merwick will be posting some RFC patches very=
 soon
>> to allow this.
> Cool, thanks for doing this work!
>
> How do the boot times compare to qemu-lite and Firecracker's
> (https://github.com/firecracker-microvm/firecracker/) direct vmlinux EL=
F
> boot?
>
> I'm asking because there are several custom approaches to fast kernel
> boot and we should make sure that whatever Linux and QEMU end up
> natively supporting is likely to work for all projects (NEMU, qemu-lite=
,
> Firecracker) and operating systems (Linux distros, other OSes).


I should also add that effort is under way to add support for booting
PVH guests from grub. This is currently Xen guests only (obviously) but
since it's based on the ABI that Maran mentioned above I don't see why a
non-Xen guest can't be supported as well.

v6 is here:
https://lists.xenproject.org/archives/html/xen-devel/2018-11/msg03174.htm=
l


-boris



--PQOB1ht9hnzb3vQIq1Q5LdbFS0Jn4u5Za
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEExAVKDNg/TOdD61Yyit52kIbKwbIFAlwH3osACgkQit52kIbK
wbLSyg/7BUTHYaTjPWNDK0vVaUJ1Docdf2l9M/ZJ82jCduL9xMYEf/bAT9GomKQ4
pJF8su1B24ISCgdOmaosqeu+gRI14GIZZh2Jm2RGYq8ApCfcjU2bGobcwxfaVU/0
/bkSD6W8EfIhh0pqCgex/cuI4tp1ZFDzsZu4kGm5nNzY5JHF0+DS7bf0WM6nw020
bT/ddmWAMGZ6IW49hU9ccM1h/98tRVv0023QPa1jn1DAErJkZ5qzxJZVsJ+afttT
JC2tyig4rU4Ub/AmaROnxiagDC9Qw5njzREyhsYuwQK7sB2743KovvavfjVt3jz5
8v7spjNqqGh5J/Yco5GbYoCzP6NA+Ih0GGEY0DKOl257oIw7jYFVt+WDjcSp3gAc
kmT04jYK+PE1NcPMD2RdlJJad1rvb9RRUMXCBSb6ThB+SW7WX0QPclB2xYlndK0+
nppYeO0jp2vePOyCaUxDCQ20ILZDOI2mqddyFgkjDiURjP7jDYdbhMr7qXPASo4O
biNdjcLyZMD18UL2AS0niSDqZJYzh6OemCI+Kb9d6nfD9ST9u8RkQdjyenNnfq/9
y4bQCCWfQEljx46LaQUSYpA7kGfvatgyN+tvgFqaaf1iu9uD3jWjcXzvp0HLN4Cv
Sq4BSHQyWuWehiAnoWvimELcSr8MrhsHA4cnoaHje6CYS9aNNHA=
=cnlO
-----END PGP SIGNATURE-----

--PQOB1ht9hnzb3vQIq1Q5LdbFS0Jn4u5Za--
