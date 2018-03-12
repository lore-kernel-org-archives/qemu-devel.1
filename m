Received: from eggs.gnu.org ([2001:4830:134:3::10]:33135)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1evO51-0004yN-Kj
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 10:05:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1evO4x-0005Zh-Iy
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 10:05:35 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:50941)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1evO4x-0005V8-Ce
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 10:05:31 -0400
Received: by mail-wm0-x243.google.com with SMTP id w128so16883821wmw.0
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 07:05:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180308195811.24894-14-dgilbert@redhat.com>
References: <20180308195811.24894-1-dgilbert@redhat.com>
	<20180308195811.24894-14-dgilbert@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 12 Mar 2018 15:05:29 +0100
Message-ID: <CAJ+F1CKcFRMZApE8zqCK_RRERRd37oN1L2ipqbstfFWsCDVgPg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 13/29] migration/ram:
 ramblock_recv_bitmap_test_byte_offset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, Peter Xu <peterx@redhat.com>, Juan Quintela <quintela@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>

On Thu, Mar 8, 2018 at 8:57 PM, Dr. David Alan Gilbert (git)
<dgilbert@redhat.com> wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> Utility for testing the map when you already know the offset
> in the RAMBlock.
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Reviewed-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  migration/ram.c | 5 +++++
>  migration/ram.h | 1 +
>  2 files changed, 6 insertions(+)
>
> diff --git a/migration/ram.c b/migration/ram.c
> index 3b6c077964..3d754422e8 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -169,6 +169,11 @@ int ramblock_recv_bitmap_test(RAMBlock *rb, void *ho=
st_addr)
>                      rb->receivedmap);
>  }
>
> +bool ramblock_recv_bitmap_test_byte_offset(RAMBlock *rb, uint64_t byte_o=
ffset)
> +{
> +    return test_bit(byte_offset >> TARGET_PAGE_BITS, rb->receivedmap);
> +}
> +
>  void ramblock_recv_bitmap_set(RAMBlock *rb, void *host_addr)
>  {
>      set_bit_atomic(ramblock_recv_bitmap_offset(host_addr, rb), rb->recei=
vedmap);
> diff --git a/migration/ram.h b/migration/ram.h
> index 53f0021c51..5030be110a 100644
> --- a/migration/ram.h
> +++ b/migration/ram.h
> @@ -60,6 +60,7 @@ int ram_postcopy_incoming_init(MigrationIncomingState *=
mis);
>  void ram_handle_compressed(void *host, uint8_t ch, uint64_t size);
>
>  int ramblock_recv_bitmap_test(RAMBlock *rb, void *host_addr);
> +bool ramblock_recv_bitmap_test_byte_offset(RAMBlock *rb, uint64_t byte_o=
ffset);
>  void ramblock_recv_bitmap_set(RAMBlock *rb, void *host_addr);
>  void ramblock_recv_bitmap_set_range(RAMBlock *rb, void *host_addr, size_=
t nr);
>
> --
> 2.14.3
>
>



--=20
Marc-Andr=C3=A9 Lureau
