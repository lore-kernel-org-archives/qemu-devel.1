Received: from eggs.gnu.org ([2001:4830:134:3::10]:60175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d8XmU-0006hY-6b
	for qemu-devel@nongnu.org; Wed, 10 May 2017 16:00:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d8XmQ-0004xy-VK
	for qemu-devel@nongnu.org; Wed, 10 May 2017 16:00:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55316)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1d8XmQ-0004xd-Me
	for qemu-devel@nongnu.org; Wed, 10 May 2017 16:00:14 -0400
References: <1494405683-20877-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1494405683-20877-5-git-send-email-pradeep.jagadeesh@huawei.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6a035cd9-34f9-c1f5-e986-404daf941641@redhat.com>
Date: Wed, 10 May 2017 15:00:09 -0500
MIME-Version: 1.0
In-Reply-To: <1494405683-20877-5-git-send-email-pradeep.jagadeesh@huawei.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="lR9eAehOJeDXRCeAPeBo6QMFIHgV9vo0Q"
Subject: Re: [Qemu-devel] [PATCH v4 4/4] fsdev: QMP interface for throttling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, greg kurz <groug@kaod.org>
Cc: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>, alberto garcia <berto@igalia.com>, jani kokkonen <jani.kokkonen@huawei.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lR9eAehOJeDXRCeAPeBo6QMFIHgV9vo0Q
From: Eric Blake <eblake@redhat.com>
To: Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, greg kurz <groug@kaod.org>
Cc: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>,
 alberto garcia <berto@igalia.com>, jani kokkonen <jani.kokkonen@huawei.com>,
 qemu-devel@nongnu.org
Message-ID: <6a035cd9-34f9-c1f5-e986-404daf941641@redhat.com>
Subject: Re: [PATCH v4 4/4] fsdev: QMP interface for throttling
References: <1494405683-20877-1-git-send-email-pradeep.jagadeesh@huawei.com>
 <1494405683-20877-5-git-send-email-pradeep.jagadeesh@huawei.com>
In-Reply-To: <1494405683-20877-5-git-send-email-pradeep.jagadeesh@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/10/2017 03:41 AM, Pradeep Jagadeesh wrote:
> This patch enables qmp interfaces for the fsdev
> devices. This provides two interfaces one=20
> for querying info of all the fsdev devices. The second one
> to set the IO limits for the required fsdev device.
>=20
> Signed-off-by: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
> ---

> +++ b/qmp.c
> @@ -130,6 +130,21 @@ void qmp_cpu_add(int64_t id, Error **errp)
>      }
>  }
> =20
> +#ifdef _WIN64
> +
> +void qmp_fsdev_set_io_throttle(IOThrottle *arg, Error **errp)
> +{
> +  return;
> +}
> +
> +IOThrottleList *qmp_query_fsdev_io_throttle(Error **errp)
> +{
> +    abort();
> +}
> +
> +#endif

I think you're missing an addition to monitor.c
qmp_unregister_commands_hack() if you intend for this command to be
available only on non-windows platforms (and is your #ifdef the correct
name, or is this a Linux-only feature rather than a non-windows feature).=


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--lR9eAehOJeDXRCeAPeBo6QMFIHgV9vo0Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZE3FKAAoJEKeha0olJ0NquugIAIHymtDg5oi+N9WBXlvF5dID
9XQR0z7Lx+8pwGWNnpmeLBsJVc/HO6VJejW1mi0nZeWcbyfjkh5ULd376GXI/h6p
zDJUeTT7ErAiqu26T4LLQshumGuArCsAnf+HrHyG/8XE/HoxRUwMOVYph6cUyqQe
BJ+NJVYjPS213Wk+qfOX/5wlvbvaPjjiRJfXSswQYD8b0AxfZiDXCyJj7KXkdaLT
pl8g39ZKdcnw72whgIsQtkz4zhvluSPOJLZhkzmTj2x/PJFJBhWRj8og5i/EBdxX
HR9299nrNTaEV6xd2iEj+oZ3mthmFHXTLy0eobsJd+/5umfOqvS0s6t8ar7g7Fw=
=V7fS
-----END PGP SIGNATURE-----

--lR9eAehOJeDXRCeAPeBo6QMFIHgV9vo0Q--
