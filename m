Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1491AC10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 12:35:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF99A2082E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 12:35:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K37Io4ue"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF99A2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35730 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEvOm-00031i-TO
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 08:35:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hEvF2-0001Hr-KB
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:25:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hEvF1-00020g-86
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:25:12 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:40423)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1hEvF0-0001tR-2C; Fri, 12 Apr 2019 08:25:10 -0400
Received: by mail-wr1-x442.google.com with SMTP id h4so11684840wre.7;
	Fri, 12 Apr 2019 05:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=bn4+aQM7TXSrP/HAgarxNm9M52afjQ0tjIJZ65whlgE=;
	b=K37Io4ueJV3HIw9zN4qEg6fNMy4rX54vJeiPquotb6DRybAAPdmKYBKboFSSG8R3w3
	rCO33mziy1FAVavKIqaUfAAm+ByWjELQRRUccbvjqnQ6t7eiwKGO/m1kZ0RW6JbyaE9s
	68AsHnfn4D57zVu7wy+0fuVWjfReLwxnDb9or+QXmYvpvM41nC+2BLigZaC+K07vG+9j
	se/jav6IZhTWOUxr3KJippQQGIrwGYKpECMnAKL3Ag70s7loVzunn2kslOU7Ydm3Ak+S
	cFZ/LHkkBPUqgX1d6ZwultFxTwv9tKuNzs7/5LZk8jlSDyJQWFRKndOEWdGlLPoppZAJ
	Lbcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=bn4+aQM7TXSrP/HAgarxNm9M52afjQ0tjIJZ65whlgE=;
	b=QaKaelsqIgEOJm6tNjTt3javPIB0+xcrIvceiKiRLSUXLuHjKJpKR78cTKmqww/cQx
	+ZUzFNyVRcLhBkskVbA1eXgQCZvg8RXvZpOSI7j8k24NHUrB6/KMoosKKU+0jWMzXDQe
	KjvQzzApqQUtIquvGaAiFlC0C/xoaNzuk4bnTX2oi0N2VZKVBf6gOvEQk5g/hYhbxIBY
	+VPZeQh6OvXDRc8wi4dyi3MCceFhYdKHxtjCvxqi3gVsCFUHeRnd5F9h0UniWHfDviRI
	t4Eb17md4hj5dTENXSg/6HdiiIEpDwzXT9J8ivocyt8bZuIz/+RLwvmos+QNxSKSaVBD
	nVoQ==
X-Gm-Message-State: APjAAAXJbsFNrHJ+x6Y2vAjjf+bViiLsNOOZKbMOgvu3JiGlmgcMVgQu
	/kvjOVrkJuueZs+zIfcqLfy+qB785WgAWrYAD3c=
X-Google-Smtp-Source: APXvYqzcTT0lS3aMmTVwvKQQRzzURpWt4S418/vbUpBxNLFfIXljbC7ll3P1rlETC4rXsC2jWNqb1N0SiJInHi5uJVk=
X-Received: by 2002:a5d:6101:: with SMTP id v1mr14436890wrt.222.1555071906494; 
	Fri, 12 Apr 2019 05:25:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190329111104.17223-1-berrange@redhat.com>
	<20190329111104.17223-9-berrange@redhat.com>
In-Reply-To: <20190329111104.17223-9-berrange@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 12 Apr 2019 14:24:55 +0200
Message-ID:
 <CAJ+F1CKt2O22sG1rQO61CGVt0WGwvFZgfWLQT_AR+1eXHYjmOA@mail.gmail.com>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: Re: [Qemu-devel] [PATCH 08/14] qxl: avoid unaligned pointer
 reads/writes
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Eric Farman <farman@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>,
	David Hildenbrand <david@redhat.com>,
	Qemu-s390x list <qemu-s390x@nongnu.org>,
	Cornelia Huck <cohuck@redhat.com>, QEMU <qemu-devel@nongnu.org>,
	Laurent Vivier <laurent@vivier.eu>, Halil Pasic <pasic@linux.ibm.com>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Thomas Huth <thuth@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190412122455.G89-Uay5NQqXZ7aOuPopW9sua5c0B__sPJfO9lcfocI@z>

Hi

On Fri, Mar 29, 2019 at 12:20 PM Daniel P. Berrang=C3=A9 <berrange@redhat.c=
om> wrote:
>
> The SPICE_RING_PROD_ITEM() macro is initializing a local
> 'uint64_t *' variable to point to the 'el' field inside
> the QXLReleaseRing struct. This uint64_t field is not
> guaranteed aligned as the struct is packed.
>
> Code should not take the address of fields within a
> packed struct. Changing the SPICE_RING_PROD_ITEM()
> macro to avoid taking the address of the field is
> impractical. It is clearer to just remove the macro
> and inline its functionality in the three call sites
> that need it.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

I didn't notice your patch, I sent a different one which didn't inline
as much code:

https://patchew.org/QEMU/20190408201203.28924-1-marcandre.lureau@redhat.com=
/

> ---
>  hw/display/qxl.c | 55 +++++++++++++++++++++---------------------------
>  1 file changed, 24 insertions(+), 31 deletions(-)
>
> diff --git a/hw/display/qxl.c b/hw/display/qxl.c
> index c8ce5781e0..5c38e6e906 100644
> --- a/hw/display/qxl.c
> +++ b/hw/display/qxl.c
> @@ -33,24 +33,6 @@
>
>  #include "qxl.h"
>
> -/*
> - * NOTE: SPICE_RING_PROD_ITEM accesses memory on the pci bar and as
> - * such can be changed by the guest, so to avoid a guest trigerrable
> - * abort we just qxl_set_guest_bug and set the return to NULL. Still
> - * it may happen as a result of emulator bug as well.
> - */
> -#undef SPICE_RING_PROD_ITEM
> -#define SPICE_RING_PROD_ITEM(qxl, r, ret) {                             =
\
> -        uint32_t prod =3D (r)->prod & SPICE_RING_INDEX_MASK(r);         =
  \
> -        if (prod >=3D ARRAY_SIZE((r)->items)) {                         =
  \
> -            qxl_set_guest_bug(qxl, "SPICE_RING_PROD_ITEM indices mismatc=
h " \
> -                          "%u >=3D %zu", prod, ARRAY_SIZE((r)->items)); =
  \
> -            ret =3D NULL;                                               =
  \
> -        } else {                                                        =
\
> -            ret =3D &(r)->items[prod].el;                               =
  \
> -        }                                                               =
\
> -    }
> -
>  #undef SPICE_RING_CONS_ITEM
>  #define SPICE_RING_CONS_ITEM(qxl, r, ret) {                             =
\
>          uint32_t cons =3D (r)->cons & SPICE_RING_INDEX_MASK(r);         =
  \
> @@ -414,7 +396,8 @@ static void init_qxl_rom(PCIQXLDevice *d)
>  static void init_qxl_ram(PCIQXLDevice *d)
>  {
>      uint8_t *buf;
> -    uint64_t *item;
> +    uint32_t prod;
> +    QXLReleaseRing *ring;
>
>      buf =3D d->vga.vram_ptr;
>      d->ram =3D (QXLRam *)(buf + le32_to_cpu(d->shadow_rom.ram_header_off=
set));
> @@ -426,9 +409,12 @@ static void init_qxl_ram(PCIQXLDevice *d)
>      SPICE_RING_INIT(&d->ram->cmd_ring);
>      SPICE_RING_INIT(&d->ram->cursor_ring);
>      SPICE_RING_INIT(&d->ram->release_ring);
> -    SPICE_RING_PROD_ITEM(d, &d->ram->release_ring, item);
> -    assert(item);
> -    *item =3D 0;
> +
> +    ring =3D &d->ram->release_ring;
> +    prod =3D ring->prod & SPICE_RING_INDEX_MASK(ring);
> +    assert(prod < ARRAY_SIZE(ring->items));
> +    ring->items[prod].el =3D 0;
> +
>      qxl_ring_set_dirty(d);
>  }
>
> @@ -732,7 +718,7 @@ static int interface_req_cmd_notification(QXLInstance=
 *sin)
>  static inline void qxl_push_free_res(PCIQXLDevice *d, int flush)
>  {
>      QXLReleaseRing *ring =3D &d->ram->release_ring;
> -    uint64_t *item;
> +    uint32_t prod;
>      int notify;
>
>  #define QXL_FREE_BUNCH_SIZE 32
> @@ -759,11 +745,15 @@ static inline void qxl_push_free_res(PCIQXLDevice *=
d, int flush)
>      if (notify) {
>          qxl_send_events(d, QXL_INTERRUPT_DISPLAY);
>      }
> -    SPICE_RING_PROD_ITEM(d, ring, item);
> -    if (!item) {
> +
> +    ring =3D &d->ram->release_ring;
> +    prod =3D ring->prod & SPICE_RING_INDEX_MASK(ring);
> +    if (prod >=3D ARRAY_SIZE(ring->items)) {
> +        qxl_set_guest_bug(d, "SPICE_RING_PROD_ITEM indices mismatch "
> +                          "%u >=3D %zu", prod, ARRAY_SIZE(ring->items));
>          return;
>      }
> -    *item =3D 0;
> +    ring->items[prod].el =3D 0;
>      d->num_free_res =3D 0;
>      d->last_release =3D NULL;
>      qxl_ring_set_dirty(d);
> @@ -775,7 +765,8 @@ static void interface_release_resource(QXLInstance *s=
in,
>  {
>      PCIQXLDevice *qxl =3D container_of(sin, PCIQXLDevice, ssd.qxl);
>      QXLReleaseRing *ring;
> -    uint64_t *item, id;
> +    uint32_t prod;
> +    uint64_t id;
>
>      if (ext.group_id =3D=3D MEMSLOT_GROUP_HOST) {
>          /* host group -> vga mode update request */
> @@ -792,16 +783,18 @@ static void interface_release_resource(QXLInstance =
*sin,
>       * pci bar 0, $command.release_info
>       */
>      ring =3D &qxl->ram->release_ring;
> -    SPICE_RING_PROD_ITEM(qxl, ring, item);
> -    if (!item) {
> +    prod =3D ring->prod & SPICE_RING_INDEX_MASK(ring);
> +    if (prod >=3D ARRAY_SIZE(ring->items)) {
> +        qxl_set_guest_bug(qxl, "SPICE_RING_PROD_ITEM indices mismatch "
> +                          "%u >=3D %zu", prod, ARRAY_SIZE(ring->items));
>          return;
>      }
> -    if (*item =3D=3D 0) {
> +    if (ring->items[prod].el =3D=3D 0) {
>          /* stick head into the ring */
>          id =3D ext.info->id;
>          ext.info->next =3D 0;
>          qxl_ram_set_dirty(qxl, &ext.info->next);
> -        *item =3D id;
> +        ring->items[prod].el =3D id;
>          qxl_ring_set_dirty(qxl);
>      } else {
>          /* append item to the list */
> --
> 2.20.1
>
>


--=20
Marc-Andr=C3=A9 Lureau

