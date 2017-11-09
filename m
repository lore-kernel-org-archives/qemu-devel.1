Received: from eggs.gnu.org ([2001:4830:134:3::10]:46011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eClFO-0002Bh-Tu
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 06:43:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eClFL-0004xx-0b
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 06:43:50 -0500
References: <68B56AECEFB25A418ADB9417F6178A531091A91B@dggemi507-mbs.china.huawei.com>
	<20171103102626.GH5078@stefanha-x1.localdomain>
	<20171106161159.GC5116@localhost.localdomain>
	<22b48478-8c86-f378-f770-095e3c297725@redhat.com>
	<20171107015930.GA16355@lemon>
	<1a034ca3-4d6d-3c44-106c-be80402c71e4@redhat.com>
	<20171109113301.GE17101@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2e3e1e07-bca7-bad2-4f4b-b8d02a4fab53@redhat.com>
Date: Thu, 9 Nov 2017 12:43:23 +0100
MIME-Version: 1.0
In-Reply-To: <20171109113301.GE17101@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="b0iTUNOmkWDRC7od7T9wdUGDG4KDdWuhg"
Subject: Re: [Qemu-devel]
 =?utf-8?q?=5BQemu-block=5D_question=EF=BC=9A_I_foun?=
 =?utf-8?q?d_a_qemu_crash_when_attach_virtio-scsi_disk?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, lizhengui <lizhengui@huawei.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "Fangyi (C)" <eric.fangyi@huawei.com>, "jcody@redhat.com" <jcody@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "mreitz@redhat.com" <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--b0iTUNOmkWDRC7od7T9wdUGDG4KDdWuhg
From: Paolo Bonzini <pbonzini@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 lizhengui <lizhengui@huawei.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "Fangyi (C)" <eric.fangyi@huawei.com>, "jcody@redhat.com"
 <jcody@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Message-ID: <2e3e1e07-bca7-bad2-4f4b-b8d02a4fab53@redhat.com>
Subject: =?UTF-8?Q?Re:_[Qemu-devel]_[Qemu-block]_question=ef=bc=9a_I_found_a?=
 =?UTF-8?Q?_qemu_crash_when_attach_virtio-scsi_disk?=
References: <68B56AECEFB25A418ADB9417F6178A531091A91B@dggemi507-mbs.china.huawei.com>
 <20171103102626.GH5078@stefanha-x1.localdomain>
 <20171106161159.GC5116@localhost.localdomain>
 <22b48478-8c86-f378-f770-095e3c297725@redhat.com>
 <20171107015930.GA16355@lemon>
 <1a034ca3-4d6d-3c44-106c-be80402c71e4@redhat.com>
 <20171109113301.GE17101@stefanha-x1.localdomain>
In-Reply-To: <20171109113301.GE17101@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 09/11/2017 12:33, Stefan Hajnoczi wrote:
>>> Can main thread somehow call aio_context_acquire(vs->ctx) (and releas=
e) around
>>> qdev_set_parent_bus()? virtio_scsi_device_find() takes the lock.
>> No, the context is not set yet.  But the locking is easy to add,
>> separately from the bug that Zhengui is reporting.
> Do you want to submit a patch for this instead of the
> aio_disable_external() approach I posted?  I think your idea is cleaner=

> than modifying the geometry probing function.

Yes, I will.  Both the locking and the "online" status.

Paolo


--b0iTUNOmkWDRC7od7T9wdUGDG4KDdWuhg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAloEP1sACgkQv/vSX3jH
roMXpAf+Iwte5YLD31An0pWSclj7HEgrfhddKoZ2OXs0WIvb1BiCOibpH38Mgz0T
2XtfEZ6fzOpbnn/cAVuKiaYfRkbgveGtRzd2Ysr1sEqLsbjIZ7lymvmYP8MKskNN
pyPYpEus+jF5+m1ZcaB1hNPaMouEaxvm44tOFt7Yj5cXyL5rPgT++XHgP8YWpYmp
D/tJuBW2UIR9YxddV82QtDl8lIctPbPwwvdpKPugzeGgefFnM5pgUh55fCYieI17
ST2BotZEisjpvuGDNTnYxIxzOGnMK0BdexZoGSgisYW+A8gnOg+3h31iwwAB8jPW
FllgNG0GwRs3YTO1fA8JP36JQPLhcA==
=0szQ
-----END PGP SIGNATURE-----

--b0iTUNOmkWDRC7od7T9wdUGDG4KDdWuhg--
