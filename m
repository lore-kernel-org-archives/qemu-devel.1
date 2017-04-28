Received: from eggs.gnu.org ([2001:4830:134:3::10]:50420)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d4AHG-0007oK-0f
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 14:05:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d4AHB-0003Fp-Vz
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 14:05:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50886)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1d4AHB-0003Ev-Kc
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 14:05:53 -0400
References: <20170428021317.24711-1-eblake@redhat.com>
	<20170428021317.24711-3-eblake@redhat.com>
	<20170428080821.GB2085@work-vm>
	<3a8d9f68-f30c-1191-ca80-a93f0050f011@redhat.com>
	<20170428152729.GI2085@work-vm>
	<550a4e37-c4b3-181d-876c-64d73e96e78c@redhat.com>
	<20170428160901.GK2085@work-vm>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2b7417be-559c-b1e5-eaf4-e195d611b4d6@redhat.com>
Date: Fri, 28 Apr 2017 13:05:43 -0500
MIME-Version: 1.0
In-Reply-To: <20170428160901.GK2085@work-vm>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="CvgU3k0SnljQChjEk84X6rK4WdmUC8FxU"
Subject: Re: [Qemu-devel] [PATCH v5 2/4] shutdown: Prepare for use of an
 enum in reset/shutdown_request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, berrange@redhat.com, alistair.francis@xilinx.com, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Juan Quintela <quintela@redhat.com>, "open list:X86" <xen-devel@lists.xenproject.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CvgU3k0SnljQChjEk84X6rK4WdmUC8FxU
From: Eric Blake <eblake@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, berrange@redhat.com,
 alistair.francis@xilinx.com, Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>,
 zhanghailiang <zhang.zhanghailiang@huawei.com>,
 Juan Quintela <quintela@redhat.com>,
 "open list:X86" <xen-devel@lists.xenproject.org>
Message-ID: <2b7417be-559c-b1e5-eaf4-e195d611b4d6@redhat.com>
Subject: Re: [PATCH v5 2/4] shutdown: Prepare for use of an enum in
 reset/shutdown_request
References: <20170428021317.24711-1-eblake@redhat.com>
 <20170428021317.24711-3-eblake@redhat.com> <20170428080821.GB2085@work-vm>
 <3a8d9f68-f30c-1191-ca80-a93f0050f011@redhat.com>
 <20170428152729.GI2085@work-vm>
 <550a4e37-c4b3-181d-876c-64d73e96e78c@redhat.com>
 <20170428160901.GK2085@work-vm>
In-Reply-To: <20170428160901.GK2085@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/28/2017 11:09 AM, Dr. David Alan Gilbert wrote:

>>> At a higher level, using your tags, I'm not sure where a reset trigge=
red
>>> by a fault detected by the hypervisor lives - e.g. an x86 triple faul=
t
>>> where the guest screws up so badly that it just gets reset.  Is
>>> that a guest-reset or a guest-panic or what - neither case
>>> was actually asked for by the guest itself.
>>
>> Wouldn't that be host-error (qemu detected an error that prevents
>> further execution of the guest without a reset - and a triple fault
>> seems to fall into the category of the guest getting itself wedged
>> rather than actually trying to reset)?  Except patch 3 only used
>> SHUTDOWN_TYPE_HOST_ERROR in the xen portion of the patch.
>>
>> So if any x86 expert has an opinion on where triple-fault handling is
>> emulated, and what category should be used there, I'm welcome to
>> tweaking this series.
>=20
> It's pretty much on the border anyway, I don't think it matters too
> much; it sounds perfectly reasonable.

Actually, reading
https://blogs.msdn.microsoft.com/larryosterman/2005/02/08/faster-syscall-=
trap-redux/
makes it sound like the triple-fault =3D reset is exploited by existing O=
S
(dating back to days of targetting 286 machines), so it is bare-metal
behavior that we have to faithfully emulate as a guest-triggered reset,
and not something where the guest has wedged itself to the point where
qemu can no longer execute the guest.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--CvgU3k0SnljQChjEk84X6rK4WdmUC8FxU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZA4R3AAoJEKeha0olJ0Nqm/sH/1XrnQIue9wTuZstiD/cf0nX
ufrJ6tySWwtNxx4r4nnjtHp0DXLkqyiNtsesnZtgJXkY6dYO/Awilz879zK+mdOI
85u4PNSgZ2dm0H1MGTurQSxkh56u2nWMrt1iX+pjtHLBItZ6Pn4WLTVsSxMeiXC6
6MLJgxfTrptujUzOy9IWvYluHy4HhHRgqD1Qny4jFQ6lnfqRjtFBhdEy3Y5/hyEt
p+lptuS+V5AnsXHvL+zbi5VUz4oyr5guooCM8IpE26X4vSg611NSPpIWy2wsssm8
NaE+yK5BK9PeY+JRodLu0zgI4/foLAZyXyzyThunv+ImpmRcuuXkqetohQ8c7MY=
=H5IP
-----END PGP SIGNATURE-----

--CvgU3k0SnljQChjEk84X6rK4WdmUC8FxU--
