Received: from eggs.gnu.org ([2001:4830:134:3::10]:34205)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dQv7d-0002YS-IT
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 08:34:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dQv7a-0000Pb-EC
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 08:34:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36024)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1dQv7a-0000OF-5l
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 08:34:02 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1426AA4FB4
	for <qemu-devel@nongnu.org>; Fri, 30 Jun 2017 12:34:01 +0000 (UTC)
References: <1498536619-14548-1-git-send-email-peterx@redhat.com>
	<1498536619-14548-5-git-send-email-peterx@redhat.com>
	<139475df-a7d8-80c6-ce21-a9a896e642ff@redhat.com>
	<20170630030321.GA24859@pxdev.xzpeter.org>
	<20170630071123.GE24859@pxdev.xzpeter.org>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <c616d603-a744-dd6b-1f8b-91f0a7614436@redhat.com>
Date: Fri, 30 Jun 2017 14:33:50 +0200
MIME-Version: 1.0
In-Reply-To: <20170630071123.GE24859@pxdev.xzpeter.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="FXWamiapQmELaGiv9EvrdK43wiP4WPwDR"
Subject: Re: [Qemu-devel] [PATCH v6 04/10] migration: let MigrationState be
 a qdev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FXWamiapQmELaGiv9EvrdK43wiP4WPwDR
From: Max Reitz <mreitz@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Message-ID: <c616d603-a744-dd6b-1f8b-91f0a7614436@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 04/10] migration: let MigrationState be a
 qdev
References: <1498536619-14548-1-git-send-email-peterx@redhat.com>
 <1498536619-14548-5-git-send-email-peterx@redhat.com>
 <139475df-a7d8-80c6-ce21-a9a896e642ff@redhat.com>
 <20170630030321.GA24859@pxdev.xzpeter.org>
 <20170630071123.GE24859@pxdev.xzpeter.org>
In-Reply-To: <20170630071123.GE24859@pxdev.xzpeter.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-06-30 09:11, Peter Xu wrote:
> On Fri, Jun 30, 2017 at 11:03:21AM +0800, Peter Xu wrote:
>> On Fri, Jun 30, 2017 at 04:18:56AM +0200, Max Reitz wrote:
>>> On 2017-06-27 06:10, Peter Xu wrote:
>>>> Let the old man "MigrationState" join the object family. Direct bene=
fit
>>>> is that we can start to use all the property features derived from
>>>> current QDev, like: HW_COMPAT_* bits, command line setup for migrati=
on
>>>> parameters (so will never need to set them up each time using HMP/QM=
P,
>>>> this is really, really attractive for test writters), etc.
>>>>
>>>> I see no reason to disallow this happen yet. So let's start from thi=
s
>>>> one, to see whether it would be anything good.
>>>>
>>>> Now we init the MigrationState struct statically in main() to make s=
ure
>>>> it's initialized after global properties are applied, since we'll us=
e
>>>> them during creation of the object.
>>>>
>>>> No functional change at all.
>>>
>>> Evidently not quite right because this breaks iotest 055.
>>>
>>> Condensed test case:
>>>
>>> $ ./qemu-img create -f vmdk -o subformat=3DstreamOptimized foo.vmdk 6=
4M
>>> Formatting 'foo.vmdk', fmt=3Dvmdk size=3D67108864 compat6=3Doff
>>> hwversion=3Dundefined subformat=3DstreamOptimized
>>> $ x86_64-softmmu/qemu-system-x86_64 -drive if=3Dnone,file=3Dfoo.vmdk
>>> qemu-system-x86_64: ./migration/migration.c:114: migrate_get_current:=

>>> Assertion `current_migration' failed.
>>> [1]    15453 abort (core dumped)  x86_64-softmmu/qemu-system-x86_64
>>> -drive if=3Dnone,file=3Dfoo.vmdk
>>>
>>> (It just worked before this patch.)
>>
>> Sorry. Will have a look.
>=20
> Hello, Max,
>=20
> The assertion is caused by migrate_add_blocker() called before
> initialization of migration object. I'll fix it.

Thanks!

> But even with a fix (so I can pass 055 now), I still cannot pass some
> of the other tests. Errors I got:
>=20
>   https://pastebin.com/ACqbXAYd
>=20
> I am not familiar with iotests. Is above usual? Looks like it still
> includes 3 failures, and some output mismatch.

Well, not usual. But 068 just is broken on master currently (Stefan has
sent "virtio: use ioeventfd in TCG and qtest mode" to fix it, and it's
part of his latest pull request). The failure in test 087 is because you
don't have aio=3Dnative enabled in your build, as the message says. :-)

I'm not sure about 118. Maybe the os.chmod() doesn't work as intended on
your machine...? Because it tries to open a read-only image as
read/write and wants to see it fail (which it doesn't in your case).

Max


--FXWamiapQmELaGiv9EvrdK43wiP4WPwDR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZVkUuEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQOS7
CACFE+ELxekVftDbKcqiFW8SqUJAbu5ubJKAphUSAlVl8XfeAWemtEyqPWHqhEl4
RwnXL8ZakmthFc3T0XFLBfhkop+LqbRGCakSQNF7Iz3HgOJMZbRv7RzF/g6G1kjg
7W0B3WTyZU+qmiYzeWOBvfICbh8r1Gv9ZllkSSpDe+uTuyPrcMJqw7JmlaR2oo2c
R2IJ8xOuHf2y001G/hGM4wXjdNMaYDdlZQJ6CWmO4C3vObVgpOVU+IkfZszyZwde
pzNGZpLvfcnlX+LDQAN4N/2SiOFOLSSh7XoK102qs+i1r10eQUP6N2NrrOV3C7Cc
tVeEURypE0R6mmJK/wxesj0X
=kiTJ
-----END PGP SIGNATURE-----

--FXWamiapQmELaGiv9EvrdK43wiP4WPwDR--
