Received: from eggs.gnu.org ([2001:4830:134:3::10]:39892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dW0vv-00050L-8r
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 09:47:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dW0vu-0006rh-AI
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 09:47:03 -0400
References: <20170705133635.11850-1-famz@redhat.com>
	<20170705133635.11850-4-famz@redhat.com>
	<20170710150707.GK14195@stefanha-x1.localdomain>
	<61a85481-9194-d68e-2544-d80365fca83e@redhat.com>
	<20170711100535.GM17792@stefanha-x1.localdomain>
	<3b602080-ef8f-6642-04cb-be5c098dd9f5@redhat.com>
	<20170712010757.GB7449@lemon>
	<404be6bd-6596-bca9-2836-da0c6a93c322@redhat.com>
	<20170714133746.GC17616@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <cbf99de0-1461-aaf3-822a-e8f0c08450aa@redhat.com>
Date: Fri, 14 Jul 2017 15:46:37 +0200
MIME-Version: 1.0
In-Reply-To: <20170714133746.GC17616@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="j6GCFbGcvQ2Lk4tDm0FouqfnCU7Kkk1VT"
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
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Keith Busch <keith.busch@intel.com>, Karl Rister <krister@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--j6GCFbGcvQ2Lk4tDm0FouqfnCU7Kkk1VT
From: Paolo Bonzini <pbonzini@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Keith Busch <keith.busch@intel.com>,
 Karl Rister <krister@redhat.com>
Message-ID: <cbf99de0-1461-aaf3-822a-e8f0c08450aa@redhat.com>
Subject: Re: [Qemu-block] [PATCH v3 3/6] block: Introduce bdrv_dma_map and
 bdrv_dma_unmap
References: <20170705133635.11850-1-famz@redhat.com>
 <20170705133635.11850-4-famz@redhat.com>
 <20170710150707.GK14195@stefanha-x1.localdomain>
 <61a85481-9194-d68e-2544-d80365fca83e@redhat.com>
 <20170711100535.GM17792@stefanha-x1.localdomain>
 <3b602080-ef8f-6642-04cb-be5c098dd9f5@redhat.com>
 <20170712010757.GB7449@lemon>
 <404be6bd-6596-bca9-2836-da0c6a93c322@redhat.com>
 <20170714133746.GC17616@stefanha-x1.localdomain>
In-Reply-To: <20170714133746.GC17616@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 14/07/2017 15:37, Stefan Hajnoczi wrote:
> On Wed, Jul 12, 2017 at 04:03:57PM +0200, Paolo Bonzini wrote:
>> On 12/07/2017 03:07, Fam Zheng wrote:
>>> On Tue, 07/11 12:28, Paolo Bonzini wrote:
>>>> On 11/07/2017 12:05, Stefan Hajnoczi wrote:
>>>>> On Mon, Jul 10, 2017 at 05:08:56PM +0200, Paolo Bonzini wrote:
>>>>>> On 10/07/2017 17:07, Stefan Hajnoczi wrote:
>>>>>>> On Wed, Jul 05, 2017 at 09:36:32PM +0800, Fam Zheng wrote:
>>>>>>>> Allow block driver to map and unmap a buffer for later I/O, as a=
 performance
>>>>>>>> hint.
>>>>>>> The name blk_dma_map() is confusing since other "dma" APIs like
>>>>>>> dma_addr_t and dma_blk_io() deal with guest physical addresses in=
stead
>>>>>>> of host addresses.  They are about DMA to/from guest RAM.
>>>>>>>
>>>>>>> Have you considered hiding this cached mapping in block/nvme.c so=
 that
>>>>>>> it isn't exposed?  block/nvme.c could keep the last buffer mapped=
 and
>>>>>>> callers would get the performance benefit without a new blk_dma_m=
ap()
>>>>>>> API.
>>>>>>
>>>>>> One buffer is enough for qemu-img bench, but not for more complex =
cases
>>>>>> (e.g. fio).
>>>>>
>>>>> I don't see any other blk_dma_map() callers.
>>>>
>>>> Indeed, the fio plugin is not part of this series, but it also used
>>>> blk_dma_map.  Without it, performance is awful.
>>>
>>> How many buffers does fio use, typically? If it's not too many, block=
/nvme.c can
>>> cache the last N buffers. I'm with Stefan that hiding the mapping log=
ic from
>>> block layer callers makes a nicer API, especially such that qemu-img =
is much
>>> easier to maintain good performance across subcommmands.
>>
>> It depends on the queue depth.
>>
>> I think the API addition is necessary, otherwise we wouldn't have adde=
d
>> the RAMBlockNotifier which is a layering violation that does the same
>> thing (create permanent HVA->IOVA mappings).  In fact, the
>> RAMBlockNotifier could be moved out of nvme.c and made to use
>> blk_dma_map/unmap, though I'm not proposing to do it now.
>>
>> I don't think qemu-img convert and dd are impacted by IOMMU map/unmap =
as
>> heavily as bench, because they operate with queue depth 1.  But adding=

>> map/unmap there would not be hard.
>=20
> I'm not against an API existing for this.  I would just ask:
>=20
> 1. It's documented so the purpose and semantics are clear.
> 2. The name cannot be confused with dma-helpers.c APIs.

Yes, I agree completely.

> Maybe blk_register_buf() or blk_add_buf_hint()?

blk_(un)register_buf, or perhaps iobuf or io_buffer, sounds good to me.

Paolo


--j6GCFbGcvQ2Lk4tDm0FouqfnCU7Kkk1VT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAlloy0IACgkQv/vSX3jH
roOHagf7B/E0Me6QnxiGZLisKYqlvSxktR6IweU89sdsLVYpjHSzmNnc9gnJq5hR
n7KPF+IJngpx3B0wb4HuyejTDFS+/OtYG9YRC6MtPdw3KEGDSVEZcgEEbU+iEgP8
mFpVLJaDYKVe4Y8kz093BFGnrHccYO8QMG0xOkSO1AY70RuHWVMSpPuX9MrfZgPp
wKRsTefSfXM9Rzj8IZp5Fsypv+6vkT50ZkOVp6KtenghstY6ZILE9DCrd/2lkH2D
f9YcqWq/XrgN7aVsVKtTgGGKUpyROQy1lrqpqrweinJ6HxYMEWxyhCeVeZITeW2i
ZOqvw6S7Jbu+RBnx4n11X5lpnKaImQ==
=jCCU
-----END PGP SIGNATURE-----

--j6GCFbGcvQ2Lk4tDm0FouqfnCU7Kkk1VT--
