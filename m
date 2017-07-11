Received: from eggs.gnu.org ([2001:4830:134:3::10]:58534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dUsPB-0005fk-7w
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 06:28:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dUsPA-0004lL-CI
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 06:28:33 -0400
References: <20170705133635.11850-1-famz@redhat.com>
	<20170705133635.11850-4-famz@redhat.com>
	<20170710150707.GK14195@stefanha-x1.localdomain>
	<61a85481-9194-d68e-2544-d80365fca83e@redhat.com>
	<20170711100535.GM17792@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3b602080-ef8f-6642-04cb-be5c098dd9f5@redhat.com>
Date: Tue, 11 Jul 2017 12:28:14 +0200
MIME-Version: 1.0
In-Reply-To: <20170711100535.GM17792@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="XcTv1xBAllD3v6PDn7A5g7DP7GQsrOU8b"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v3 3/6] block: Introduce
 bdrv_dma_map and bdrv_dma_unmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Keith Busch <keith.busch@intel.com>, Karl Rister <krister@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XcTv1xBAllD3v6PDn7A5g7DP7GQsrOU8b
From: Paolo Bonzini <pbonzini@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Keith Busch <keith.busch@intel.com>,
 Karl Rister <krister@redhat.com>
Message-ID: <3b602080-ef8f-6642-04cb-be5c098dd9f5@redhat.com>
Subject: Re: [Qemu-block] [PATCH v3 3/6] block: Introduce bdrv_dma_map and
 bdrv_dma_unmap
References: <20170705133635.11850-1-famz@redhat.com>
 <20170705133635.11850-4-famz@redhat.com>
 <20170710150707.GK14195@stefanha-x1.localdomain>
 <61a85481-9194-d68e-2544-d80365fca83e@redhat.com>
 <20170711100535.GM17792@stefanha-x1.localdomain>
In-Reply-To: <20170711100535.GM17792@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 11/07/2017 12:05, Stefan Hajnoczi wrote:
> On Mon, Jul 10, 2017 at 05:08:56PM +0200, Paolo Bonzini wrote:
>> On 10/07/2017 17:07, Stefan Hajnoczi wrote:
>>> On Wed, Jul 05, 2017 at 09:36:32PM +0800, Fam Zheng wrote:
>>>> Allow block driver to map and unmap a buffer for later I/O, as a per=
formance
>>>> hint.
>>> The name blk_dma_map() is confusing since other "dma" APIs like
>>> dma_addr_t and dma_blk_io() deal with guest physical addresses instea=
d
>>> of host addresses.  They are about DMA to/from guest RAM.
>>>
>>> Have you considered hiding this cached mapping in block/nvme.c so tha=
t
>>> it isn't exposed?  block/nvme.c could keep the last buffer mapped and=

>>> callers would get the performance benefit without a new blk_dma_map()=

>>> API.
>>
>> One buffer is enough for qemu-img bench, but not for more complex case=
s
>> (e.g. fio).
>=20
> I don't see any other blk_dma_map() callers.

Indeed, the fio plugin is not part of this series, but it also used
blk_dma_map.  Without it, performance is awful.

Paolo


--XcTv1xBAllD3v6PDn7A5g7DP7GQsrOU8b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAllkqD4ACgkQv/vSX3jH
roO/4Af9GVj1B5u5EPqpfzX/nZvRZe0Gxq2c2HkUOvc4Nhk37SESxNYDAHE8ZB6Q
CTU0CD8Asm0CZslSzUIDKh80TV5oDo6NS9YtpxmqsZD285wjPiCI11OSB/yloNZ/
y9yxUXQVGvh436C2aHvCdButtjeP/l+sZXwrTgjQmRA8Cml6I5ll83ANE7GEkw8m
5nxzUx/F8UIjk93xIQxKg2tufBxJrGy1hhtUhKDWYVYS5EgC/mgdF65SfuZbpUuM
QWoYDM9wXEuA9b8cqNZwCTb3OqL4iu4/tIi9GUN0Gs3IQ5GHKzlKVeuYygJWIZ5T
29YE5ZTIzNv6j+smhBmi3M37s1B4Uw==
=VjfG
-----END PGP SIGNATURE-----

--XcTv1xBAllD3v6PDn7A5g7DP7GQsrOU8b--
