Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90BADC43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 16:21:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5401E20651
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 16:21:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5401E20651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43285 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMaw4-0003eU-H6
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 12:21:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44736)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hMatk-0002II-BF
	for qemu-devel@nongnu.org; Fri, 03 May 2019 12:18:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hMati-0002ls-V5
	for qemu-devel@nongnu.org; Fri, 03 May 2019 12:18:56 -0400
Received: from mail-wm1-f50.google.com ([209.85.128.50]:39739)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hMati-0002kn-Ob
	for qemu-devel@nongnu.org; Fri, 03 May 2019 12:18:54 -0400
Received: by mail-wm1-f50.google.com with SMTP id n25so7364068wmk.4
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 09:18:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=bgTsB/c6JGm6i14qJ7qpAxzcx6gZZqLpITWSGLkf6CY=;
	b=kRSUgKeKvQIRzVczdyzJSFs6HAiE+RaVg2bwr7Xj9lwKnQXhJn+O7srH7VhdI9GhGa
	yjsprsFVkFR1LP+7C+57H/W8kfi//hCfJV8/isfSyMvS16DQQXcsfl7Vxd+1fJixpMXq
	qftN19At2zx+sEyyfMmTcV1HKtUQVRicYr4gs5209sgAdKTsyjBuK2WDdSlX/gcoUFGf
	Q2I7ZKT6k2TRep2O0/u7uMZXuBHAtMhnFwiJKsGpbTH+JkQ62HsGb1iq/4ayGRbLyDM3
	GRP4xRAiGTTzV6V4RkJAgd3g1jeHdewxMBuf7r0eRgLhLt07T/y6nFGoFUa2XdQflBYa
	8kDw==
X-Gm-Message-State: APjAAAWb12f5syjfbIcljob73Z4tFtzXAYIV5vn+1n5Pg7qsSFA9OeKk
	BhfBjo1Lc32eEt4EmI3501oSmw==
X-Google-Smtp-Source: APXvYqwWmXNjKOuO+aOIPeb4JbhoHRlZ3Ook5E+0Wv4/1+WjKaJxMwXnQlIyykhPP2cTiB0Nz1tquA==
X-Received: by 2002:a1c:c7c8:: with SMTP id x191mr6838230wmf.146.1556900332844;
	Fri, 03 May 2019 09:18:52 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	w15sm4050102wrg.43.2019.05.03.09.18.52
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Fri, 03 May 2019 09:18:52 -0700 (PDT)
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
	qemu-devel@nongnu.org
References: <20190408201203.28924-1-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <79e7fd04-8cd5-0a67-c1d0-17d50423c69e@redhat.com>
Date: Fri, 3 May 2019 18:18:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190408201203.28924-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.50
Subject: Re: [Qemu-devel] [PATCH] qxl: fix -Waddress-of-packed-member
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
Cc: kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190503161851.PqblrwtaOKG5BSZQ79j6FPS7YoCVLAXbFjc9O37PnDc@z>

On 4/8/19 10:12 PM, Marc-André Lureau wrote:
> The GCC9 compiler complains about QXL code that takes the address of
> members of the 'struct QXLReleaseRing' which is marked packed:
> 
>   CC      hw/display/qxl.o
> /home/elmarco/src/qemu/hw/display/qxl.c: In function ‘init_qxl_ram’:
> /home/elmarco/src/qemu/hw/display/qxl.c:50:19: warning: taking address of packed member of ‘struct QXLReleaseRing_ring_el’ may result in an unaligned pointer value [-Waddress-of-packed-member]
>    50 |             ret = &(r)->items[prod].el;                                 \
>       |                   ^~~~~~~~~~~~~~~~~~~~
> /home/elmarco/src/qemu/hw/display/qxl.c:429:5: note: in expansion of macro ‘SPICE_RING_PROD_ITEM’
>   429 |     SPICE_RING_PROD_ITEM(d, &d->ram->release_ring, item);
>       |     ^~~~~~~~~~~~~~~~~~~~
> /home/elmarco/src/qemu/hw/display/qxl.c: In function ‘qxl_push_free_res’:
> /home/elmarco/src/qemu/hw/display/qxl.c:50:19: warning: taking address of packed member of ‘struct QXLReleaseRing_ring_el’ may result in an unaligned pointer value [-Waddress-of-packed-member]
>    50 |             ret = &(r)->items[prod].el;                                 \
>       |                   ^~~~~~~~~~~~~~~~~~~~
> /home/elmarco/src/qemu/hw/display/qxl.c:762:5: note: in expansion of macro ‘SPICE_RING_PROD_ITEM’
>   762 |     SPICE_RING_PROD_ITEM(d, ring, item);
>       |     ^~~~~~~~~~~~~~~~~~~~
> /home/elmarco/src/qemu/hw/display/qxl.c: In function ‘interface_release_resource’:
> /home/elmarco/src/qemu/hw/display/qxl.c:50:19: warning: taking address of packed member of ‘struct QXLReleaseRing_ring_el’ may result in an unaligned pointer value [-Waddress-of-packed-member]
>    50 |             ret = &(r)->items[prod].el;                                 \
>       |                   ^~~~~~~~~~~~~~~~~~~~
> /home/elmarco/src/qemu/hw/display/qxl.c:795:5: note: in expansion of macro ‘SPICE_RING_PROD_ITEM’
>   795 |     SPICE_RING_PROD_ITEM(qxl, ring, item);
>       |     ^~~~~~~~~~~~~~~~~~~~
> 
> Replace pointer usage by direct structure/array access instead.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  hw/display/qxl.c | 83 +++++++++++++++++++++++++++++-------------------
>  1 file changed, 50 insertions(+), 33 deletions(-)
> 
> diff --git a/hw/display/qxl.c b/hw/display/qxl.c
> index c8ce5781e0..12d83dd6f1 100644
> --- a/hw/display/qxl.c
> +++ b/hw/display/qxl.c
> @@ -39,29 +39,49 @@
>   * abort we just qxl_set_guest_bug and set the return to NULL. Still
>   * it may happen as a result of emulator bug as well.
>   */
> -#undef SPICE_RING_PROD_ITEM
> -#define SPICE_RING_PROD_ITEM(qxl, r, ret) {                             \
> -        uint32_t prod = (r)->prod & SPICE_RING_INDEX_MASK(r);           \
> -        if (prod >= ARRAY_SIZE((r)->items)) {                           \
> -            qxl_set_guest_bug(qxl, "SPICE_RING_PROD_ITEM indices mismatch " \
> -                          "%u >= %zu", prod, ARRAY_SIZE((r)->items));   \
> -            ret = NULL;                                                 \
> -        } else {                                                        \
> -            ret = &(r)->items[prod].el;                                 \
> -        }                                                               \
> +#define SPICE_RING_GET_CHECK(qxl, r, field) ({                          \
> +    field = (r)->field & SPICE_RING_INDEX_MASK(r);                      \
> +    bool mismatch = field >= ARRAY_SIZE((r)->items);                    \
> +    if (mismatch) {                                                     \
> +        qxl_set_guest_bug(qxl, "SPICE_RING_GET %s indices mismatch "    \
> +                          "%u >= %zu", stringify(field), field,         \
> +                          ARRAY_SIZE((r)->items));                      \
> +    }                                                                   \
> +    !mismatch;                                                          \
> +})
> +
> +static inline uint64_t
> +qxl_release_ring_get_prod(PCIQXLDevice *qxl)
> +{
> +    struct QXLReleaseRing *ring = &qxl->ram->release_ring;
> +    uint32_t prod;
> +    bool ok = SPICE_RING_GET_CHECK(qxl, ring, prod);
> +    assert(ok);
> +
> +    return ring->items[prod].el;
> +}
> +
> +static inline bool
> +qxl_release_ring_set_prod(PCIQXLDevice *qxl, uint64_t val)
> +{
> +    struct QXLReleaseRing *ring = &qxl->ram->release_ring;
> +    uint32_t prod;
> +    bool ok = SPICE_RING_GET_CHECK(qxl, ring, prod);
> +    if (ok) {
> +        ring->items[prod].el = val;
>      }
> +    return ok;
> +}
>  
>  #undef SPICE_RING_CONS_ITEM
> -#define SPICE_RING_CONS_ITEM(qxl, r, ret) {                             \
> -        uint32_t cons = (r)->cons & SPICE_RING_INDEX_MASK(r);           \
> -        if (cons >= ARRAY_SIZE((r)->items)) {                           \
> -            qxl_set_guest_bug(qxl, "SPICE_RING_CONS_ITEM indices mismatch " \
> -                          "%u >= %zu", cons, ARRAY_SIZE((r)->items));   \
> -            ret = NULL;                                                 \
> -        } else {                                                        \
> -            ret = &(r)->items[cons].el;                                 \
> -        }                                                               \
> -    }
> +#define SPICE_RING_CONS_ITEM(qxl, r, ret) {     \
> +    uint32_t cons;                              \
> +    if (!SPICE_RING_GET_CHECK(qxl, r, cons)) {  \
> +        ret = NULL;                             \
> +    } else {                                    \
> +        ret = &(r)->items[cons].el;             \
> +    }                                           \
> +}
>  
>  #undef ALIGN
>  #define ALIGN(a, b) (((a) + ((b) - 1)) & ~((b) - 1))
> @@ -414,7 +434,6 @@ static void init_qxl_rom(PCIQXLDevice *d)
>  static void init_qxl_ram(PCIQXLDevice *d)
>  {
>      uint8_t *buf;
> -    uint64_t *item;
>  
>      buf = d->vga.vram_ptr;
>      d->ram = (QXLRam *)(buf + le32_to_cpu(d->shadow_rom.ram_header_offset));
> @@ -426,9 +445,9 @@ static void init_qxl_ram(PCIQXLDevice *d)
>      SPICE_RING_INIT(&d->ram->cmd_ring);
>      SPICE_RING_INIT(&d->ram->cursor_ring);
>      SPICE_RING_INIT(&d->ram->release_ring);
> -    SPICE_RING_PROD_ITEM(d, &d->ram->release_ring, item);
> -    assert(item);
> -    *item = 0;
> +    if (!qxl_release_ring_set_prod(d, 0)) {
> +        g_assert_not_reached();
> +    }
>      qxl_ring_set_dirty(d);
>  }
>  
> @@ -732,7 +751,6 @@ static int interface_req_cmd_notification(QXLInstance *sin)
>  static inline void qxl_push_free_res(PCIQXLDevice *d, int flush)
>  {
>      QXLReleaseRing *ring = &d->ram->release_ring;
> -    uint64_t *item;
>      int notify;
>  
>  #define QXL_FREE_BUNCH_SIZE 32
> @@ -759,11 +777,9 @@ static inline void qxl_push_free_res(PCIQXLDevice *d, int flush)
>      if (notify) {
>          qxl_send_events(d, QXL_INTERRUPT_DISPLAY);
>      }
> -    SPICE_RING_PROD_ITEM(d, ring, item);
> -    if (!item) {
> +    if (!qxl_release_ring_set_prod(d, 0)) {
>          return;
>      }
> -    *item = 0;
>      d->num_free_res = 0;
>      d->last_release = NULL;
>      qxl_ring_set_dirty(d);
> @@ -775,7 +791,8 @@ static void interface_release_resource(QXLInstance *sin,
>  {
>      PCIQXLDevice *qxl = container_of(sin, PCIQXLDevice, ssd.qxl);
>      QXLReleaseRing *ring;
> -    uint64_t *item, id;
> +    uint32_t prod;
> +    uint64_t id;
>  
>      if (ext.group_id == MEMSLOT_GROUP_HOST) {
>          /* host group -> vga mode update request */
> @@ -792,16 +809,16 @@ static void interface_release_resource(QXLInstance *sin,
>       * pci bar 0, $command.release_info
>       */
>      ring = &qxl->ram->release_ring;
> -    SPICE_RING_PROD_ITEM(qxl, ring, item);
> -    if (!item) {
> +
> +    if (!SPICE_RING_GET_CHECK(qxl, ring, prod)) {
>          return;
>      }
> -    if (*item == 0) {
> +    if (qxl_release_ring_get_prod(qxl) == 0) {
>          /* stick head into the ring */
>          id = ext.info->id;
>          ext.info->next = 0;
>          qxl_ram_set_dirty(qxl, &ext.info->next);
> -        *item = id;
> +        qxl_release_ring_set_prod(qxl, id);
>          qxl_ring_set_dirty(qxl);
>      } else {
>          /* append item to the list */
> 

