Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13998C76188
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 05:20:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7FE02238E
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 05:20:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="kASVw9mo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7FE02238E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpnE2-0006il-Rf
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 01:20:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39686)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hpnCd-0000s4-Ny
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 01:19:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hpnCc-0003mX-8G
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 01:19:07 -0400
Received: from ozlabs.org ([203.11.71.1]:59119)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hpnCb-0003gI-7f; Tue, 23 Jul 2019 01:19:06 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45t6G83DD8z9sNT; Tue, 23 Jul 2019 15:18:56 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1563859136;
 bh=tfyq+j0/fRoJB2Cdzgd4s+TGPHpD2ApevN6sfMmA7Ac=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=kASVw9mozLpLsbYTVurY01h/Je+kk1/KIFw6B8Nsz/KegrX94+P84edpy1SeUYkfV
 M0sQmD7alWsoxdx4AgTqXe5q1AjFVnJCiBJDiu2nZSUdq5oFStgoqiIAtRGUJwpBj1
 2NOEEx8KBOKVtKdIAml2nNP8dqaxj1OcLRbxQ5vk=
Date: Tue, 23 Jul 2019 13:22:19 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: David Hildenbrand <david@redhat.com>
Message-ID: <20190723032219.GM25073@umbus.fritz.box>
References: <20190722134108.22151-1-david@redhat.com>
 <20190722134108.22151-7-david@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Aaj1jBvBEV7KRjLi"
Content-Disposition: inline
In-Reply-To: <20190722134108.22151-7-david@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH-for-4.1 v3 6/6] virtio-balloon: Use
 temporary PBP only
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-stable@nongnu.org,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--Aaj1jBvBEV7KRjLi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2019 at 03:41:08PM +0200, David Hildenbrand wrote:
> We still have multiple issues in the current code
> - The PBP is not freed during unrealize()
> - The PBP is not reset on device resets: After a reset, the PBP is stale.
> - We are not indicating VIRTIO_BALLOON_F_MUST_TELL_HOST, therefore
>   guests (esp. legacy guests) will reuse pages without deflating,
>   turning the PBP stale. Adding that would require compat handling.
>=20
> Instead, let's use the PBP only temporarily, when processing one bulk of
> inflation requests. This will keep guest_page_size > 4k working (with
> Linux guests). There is nothing to do for deflation requests anymore.
> The pbp is only used for a limited amount of time.
>=20
> Fixes: ed48c59875b6 ("virtio-balloon: Safely handle BALLOON_PAGE_SIZE <
>                      host page size")
> Cc: qemu-stable@nongnu.org #v4.0.0
> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Ah, nice idea. =20

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/virtio/virtio-balloon.c         | 21 +++++++++------------
>  include/hw/virtio/virtio-balloon.h |  3 ---
>  2 files changed, 9 insertions(+), 15 deletions(-)
>=20
> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> index 40d493a31a..a6282d58d4 100644
> --- a/hw/virtio/virtio-balloon.c
> +++ b/hw/virtio/virtio-balloon.c
> @@ -34,11 +34,11 @@
> =20
>  #define BALLOON_PAGE_SIZE  (1 << VIRTIO_BALLOON_PFN_SHIFT)
> =20
> -struct PartiallyBalloonedPage {
> +typedef struct PartiallyBalloonedPage {
>      ram_addr_t base_gpa;
>      long subpages;
>      unsigned long *bitmap;
> -};
> +} PartiallyBalloonedPage;
> =20
>  static void virtio_balloon_pbp_free(PartiallyBalloonedPage *pbp)
>  {
> @@ -68,11 +68,11 @@ static bool virtio_balloon_pbp_matches(PartiallyBallo=
onedPage *pbp,
>  }
> =20
>  static void balloon_inflate_page(VirtIOBalloon *balloon,
> -                                 MemoryRegion *mr, hwaddr mr_offset)
> +                                 MemoryRegion *mr, hwaddr mr_offset,
> +                                 PartiallyBalloonedPage **pbp)
>  {
>      void *addr =3D memory_region_get_ram_ptr(mr) + mr_offset;
>      ram_addr_t rb_offset, rb_aligned_offset, base_gpa;
> -    PartiallyBalloonedPage **pbp =3D &balloon->pbp;
>      RAMBlock *rb;
>      size_t rb_page_size;
>      int subpages;
> @@ -149,12 +149,6 @@ static void balloon_deflate_page(VirtIOBalloon *ball=
oon,
>      rb =3D qemu_ram_block_from_host(addr, false, &rb_offset);
>      rb_page_size =3D qemu_ram_pagesize(rb);
> =20
> -    if (balloon->pbp) {
> -        /* Let's play safe and always reset the pbp on deflation request=
s. */
> -        virtio_balloon_pbp_free(balloon->pbp);
> -        balloon->pbp =3D NULL;
> -    }
> -
>      host_addr =3D (void *)((uintptr_t)addr & ~(rb_page_size - 1));
> =20
>      /* When a page is deflated, we hint the whole host page it lives
> @@ -336,6 +330,7 @@ static void balloon_stats_set_poll_interval(Object *o=
bj, Visitor *v,
>  static void virtio_balloon_handle_output(VirtIODevice *vdev, VirtQueue *=
vq)
>  {
>      VirtIOBalloon *s =3D VIRTIO_BALLOON(vdev);
> +    PartiallyBalloonedPage *pbp =3D NULL;
>      VirtQueueElement *elem;
>      MemoryRegionSection section;
> =20
> @@ -344,7 +339,7 @@ static void virtio_balloon_handle_output(VirtIODevice=
 *vdev, VirtQueue *vq)
>          uint32_t pfn;
>          elem =3D virtqueue_pop(vq, sizeof(VirtQueueElement));
>          if (!elem) {
> -            return;
> +            break;
>          }
> =20
>          while (iov_to_buf(elem->out_sg, elem->out_num, offset, &pfn, 4) =
=3D=3D 4) {
> @@ -373,7 +368,7 @@ static void virtio_balloon_handle_output(VirtIODevice=
 *vdev, VirtQueue *vq)
>              if (!qemu_balloon_is_inhibited()) {
>                  if (vq =3D=3D s->ivq) {
>                      balloon_inflate_page(s, section.mr,
> -                                         section.offset_within_region);
> +                                         section.offset_within_region, &=
pbp);
>                  } else if (vq =3D=3D s->dvq) {
>                      balloon_deflate_page(s, section.mr, section.offset_w=
ithin_region);
>                  } else {
> @@ -387,6 +382,8 @@ static void virtio_balloon_handle_output(VirtIODevice=
 *vdev, VirtQueue *vq)
>          virtio_notify(vdev, vq);
>          g_free(elem);
>      }
> +
> +    virtio_balloon_pbp_free(pbp);
>  }
> =20
>  static void virtio_balloon_receive_stats(VirtIODevice *vdev, VirtQueue *=
vq)
> diff --git a/include/hw/virtio/virtio-balloon.h b/include/hw/virtio/virti=
o-balloon.h
> index 5a99293a45..d1c968d237 100644
> --- a/include/hw/virtio/virtio-balloon.h
> +++ b/include/hw/virtio/virtio-balloon.h
> @@ -33,8 +33,6 @@ typedef struct virtio_balloon_stat_modern {
>         uint64_t val;
>  } VirtIOBalloonStatModern;
> =20
> -typedef struct PartiallyBalloonedPage PartiallyBalloonedPage;
> -
>  enum virtio_balloon_free_page_report_status {
>      FREE_PAGE_REPORT_S_STOP =3D 0,
>      FREE_PAGE_REPORT_S_REQUESTED =3D 1,
> @@ -70,7 +68,6 @@ typedef struct VirtIOBalloon {
>      int64_t stats_last_update;
>      int64_t stats_poll_interval;
>      uint32_t host_features;
> -    PartiallyBalloonedPage *pbp;
> =20
>      bool qemu_4_0_config_size;
>  } VirtIOBalloon;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Aaj1jBvBEV7KRjLi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl02fWkACgkQbDjKyiDZ
s5Isqw//SgOwDi87kFhZrnMi/ZM+25Hl/cCsGjP9nP550+AqHoRvgf+OJviUz6cz
jph4Gpt73eVfXY1GFaPS+FxOsYHfhxdXG1xB/TaEqBI3fqRx4ObeXBTGqRrVOpsv
9Fzv/xeP7YwwDBIHW7RriCSCaDvVeuLkMvn9+6zVBls0Jf1DyeqhsiOBCGgNXbYO
jgUCH++oUk8fTd1B5tROirmNPO3N330RuRJx+NqPR4Lscl2Pt30jCTz1S88usinl
XmjDtqE/AXJ5eZX3C2/WyqBmkD7nl04uzq4rGWjsbyAlSSwW6Q5cKgoKyBaNQz15
qxLNmnETt9DL9WA7CqdCkc+hs3BsJprmgyaKpEP8ntmTdf+/y2XrPQrBLD2bLU+U
8zRM3Zh6p3D6W2Akqz/G9ZHg88W5UfLgeaKKrk9MdYy8Dt8Y0UDYDy8YgTuN6sKa
oR1ENDvpsTVAJQBLZMiCYTAhJ3oopLSjavDp5LQ4vVY/iqCBjFoYHuvDgoh9usKz
1f8Y9tdxkDgFyZA65qJs69VIaqlCGiIpnW6FaRPIymqWzok6ui90QE6s9lJqPFuL
GDWSyDlU4AkOSoRyBwkwjB+9nuqG1YeIgsp8sOU3yX8UK5Q4v5dPfR1nNiemH+nu
5wLH6RbXj4SHpAJIkcAQUMMK8ZMvVOokWeugNkxRYN3ytXDOeL4=
=NwQL
-----END PGP SIGNATURE-----

--Aaj1jBvBEV7KRjLi--

