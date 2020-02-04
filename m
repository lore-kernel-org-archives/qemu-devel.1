Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FBD0C3524B
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 07:17:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09B9921582
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 07:17:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09B9921582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iysSu-00024O-8l
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 02:17:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42388)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iysRi-0001Pm-Bd
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 02:16:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iysRe-0002nN-8u
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 02:16:27 -0500
Received: from 9.mo68.mail-out.ovh.net ([46.105.78.111]:43258)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iysRd-0002WZ-Q7
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 02:16:25 -0500
Received: from player692.ha.ovh.net (unknown [10.110.208.245])
 by mo68.mail-out.ovh.net (Postfix) with ESMTP id E76D2158542
 for <qemu-devel@nongnu.org>; Tue,  4 Feb 2020 08:16:21 +0100 (CET)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player692.ha.ovh.net (Postfix) with ESMTPSA id 96631ED3F18A;
 Tue,  4 Feb 2020 07:16:10 +0000 (UTC)
Subject: Re: [PATCH 1/3] m25p80: Convert to support tracing
To: Guenter Roeck <linux@roeck-us.net>,
 Alistair Francis <alistair@alistair23.me>
References: <20200203180904.2727-1-linux@roeck-us.net>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <2dfe10d0-2e67-b83c-92a6-b503ed55ebd7@kaod.org>
Date: Tue, 4 Feb 2020 08:16:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200203180904.2727-1-linux@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 1892919220812090336
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrgeekgddutdeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpkedvrdeigedrvdehtddrudejtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrheiledvrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.78.111
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, Andrew Jeffery <andrew@aj.id.au>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/3/20 7:09 PM, Guenter Roeck wrote:
> While at it, add some trace messages to help debug problems
> seen when running the latest Linux kernel.
>=20
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>


Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

We have been chasing a bug for years on the witherspoon-bmc machine=20
using UBIfs. It will be useful.=20

What kind of issue are you looking at ?=20

Thanks,

C.=20

> ---
>  hw/block/m25p80.c     | 48 ++++++++++++++++++++-----------------------
>  hw/block/trace-events | 16 +++++++++++++++
>  2 files changed, 38 insertions(+), 26 deletions(-)
>=20
> diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
> index 11ff5b9ad7..63e050d7d3 100644
> --- a/hw/block/m25p80.c
> +++ b/hw/block/m25p80.c
> @@ -32,17 +32,7 @@
>  #include "qemu/module.h"
>  #include "qemu/error-report.h"
>  #include "qapi/error.h"
> -
> -#ifndef M25P80_ERR_DEBUG
> -#define M25P80_ERR_DEBUG 0
> -#endif
> -
> -#define DB_PRINT_L(level, ...) do { \
> -    if (M25P80_ERR_DEBUG > (level)) { \
> -        fprintf(stderr,  ": %s: ", __func__); \
> -        fprintf(stderr, ## __VA_ARGS__); \
> -    } \
> -} while (0)
> +#include "trace.h"
> =20
>  /* Fields for FlashPartInfo->flags */
> =20
> @@ -574,7 +564,8 @@ static void flash_erase(Flash *s, int offset, Flash=
CMD cmd)
>          abort();
>      }
> =20
> -    DB_PRINT_L(0, "offset =3D %#x, len =3D %d\n", offset, len);
> +    trace_m25p80_flash_erase(offset, len);
> +
>      if ((s->pi->flags & capa_to_assert) !=3D capa_to_assert) {
>          qemu_log_mask(LOG_GUEST_ERROR, "M25P80: %d erase size not supp=
orted by"
>                        " device\n", len);
> @@ -607,8 +598,7 @@ void flash_write8(Flash *s, uint32_t addr, uint8_t =
data)
>      }
> =20
>      if ((prev ^ data) & data) {
> -        DB_PRINT_L(1, "programming zero to one! addr=3D%" PRIx32 "  %"=
 PRIx8
> -                   " -> %" PRIx8 "\n", addr, prev, data);
> +        trace_m25p80_programming_zero_to_one(addr, prev, data);
>      }
> =20
>      if (s->pi->flags & EEPROM) {
> @@ -662,6 +652,9 @@ static void complete_collecting_data(Flash *s)
> =20
>      s->state =3D STATE_IDLE;
> =20
> +    trace_m25p80_complete_collecting(s->cmd_in_progress, n, s->ear,
> +                                     s->cur_addr);
> +
>      switch (s->cmd_in_progress) {
>      case DPP:
>      case QPP:
> @@ -825,7 +818,7 @@ static void reset_memory(Flash *s)
>          break;
>      }
> =20
> -    DB_PRINT_L(0, "Reset done.\n");
> +    trace_m25p80_reset_done();
>  }
> =20
>  static void decode_fast_read_cmd(Flash *s)
> @@ -941,9 +934,10 @@ static void decode_qio_read_cmd(Flash *s)
> =20
>  static void decode_new_cmd(Flash *s, uint32_t value)
>  {
> -    s->cmd_in_progress =3D value;
>      int i;
> -    DB_PRINT_L(0, "decoded new command:%x\n", value);
> +
> +    s->cmd_in_progress =3D value;
> +    trace_m25p80_command_decoded(value);
> =20
>      if (value !=3D RESET_MEMORY) {
>          s->reset_enable =3D false;
> @@ -1042,7 +1036,7 @@ static void decode_new_cmd(Flash *s, uint32_t val=
ue)
>          break;
> =20
>      case JEDEC_READ:
> -        DB_PRINT_L(0, "populated jedec code\n");
> +        trace_m25p80_populated_jedec();
>          for (i =3D 0; i < s->pi->id_len; i++) {
>              s->data[i] =3D s->pi->id[i];
>          }
> @@ -1063,7 +1057,7 @@ static void decode_new_cmd(Flash *s, uint32_t val=
ue)
>      case BULK_ERASE_60:
>      case BULK_ERASE:
>          if (s->write_enable) {
> -            DB_PRINT_L(0, "chip erase\n");
> +            trace_m25p80_chip_erase();
>              flash_erase(s, 0, BULK_ERASE);
>          } else {
>              qemu_log_mask(LOG_GUEST_ERROR, "M25P80: chip erase with wr=
ite "
> @@ -1184,7 +1178,7 @@ static int m25p80_cs(SSISlave *ss, bool select)
>          s->data_read_loop =3D false;
>      }
> =20
> -    DB_PRINT_L(0, "%sselect\n", select ? "de" : "");
> +    trace_m25p80_select(select ? "de" : "");
> =20
>      return 0;
>  }
> @@ -1194,19 +1188,20 @@ static uint32_t m25p80_transfer8(SSISlave *ss, =
uint32_t tx)
>      Flash *s =3D M25P80(ss);
>      uint32_t r =3D 0;
> =20
> +    trace_m25p80_transfer(s->state, s->len, s->needed_bytes, s->pos,
> +                          s->cur_addr, (uint8_t)tx);
> +
>      switch (s->state) {
> =20
>      case STATE_PAGE_PROGRAM:
> -        DB_PRINT_L(1, "page program cur_addr=3D%#" PRIx32 " data=3D%" =
PRIx8 "\n",
> -                   s->cur_addr, (uint8_t)tx);
> +        trace_m25p80_page_program(s->cur_addr, (uint8_t)tx);
>          flash_write8(s, s->cur_addr, (uint8_t)tx);
>          s->cur_addr =3D (s->cur_addr + 1) & (s->size - 1);
>          break;
> =20
>      case STATE_READ:
>          r =3D s->storage[s->cur_addr];
> -        DB_PRINT_L(1, "READ 0x%" PRIx32 "=3D%" PRIx8 "\n", s->cur_addr=
,
> -                   (uint8_t)r);
> +        trace_m25p80_read_byte(s->cur_addr, (uint8_t)r);
>          s->cur_addr =3D (s->cur_addr + 1) & (s->size - 1);
>          break;
> =20
> @@ -1244,6 +1239,7 @@ static uint32_t m25p80_transfer8(SSISlave *ss, ui=
nt32_t tx)
>          }
> =20
>          r =3D s->data[s->pos];
> +        trace_m25p80_read_data(s->pos, (uint8_t)r);
>          s->pos++;
>          if (s->pos =3D=3D s->len) {
>              s->pos =3D 0;
> @@ -1281,7 +1277,7 @@ static void m25p80_realize(SSISlave *ss, Error **=
errp)
>              return;
>          }
> =20
> -        DB_PRINT_L(0, "Binding to IF_MTD drive\n");
> +        trace_m25p80_binding();
>          s->storage =3D blk_blockalign(s->blk, s->size);
> =20
>          if (blk_pread(s->blk, 0, s->storage, s->size) !=3D s->size) {
> @@ -1289,7 +1285,7 @@ static void m25p80_realize(SSISlave *ss, Error **=
errp)
>              return;
>          }
>      } else {
> -        DB_PRINT_L(0, "No BDRV - binding to RAM\n");
> +        trace_m25p80_binding_no_bdrv();
>          s->storage =3D blk_blockalign(NULL, s->size);
>          memset(s->storage, 0xFF, s->size);
>      }
> diff --git a/hw/block/trace-events b/hw/block/trace-events
> index c03e80c2c9..d052f7578c 100644
> --- a/hw/block/trace-events
> +++ b/hw/block/trace-events
> @@ -134,3 +134,19 @@ xen_block_blockdev_add(char *str) "%s"
>  xen_block_blockdev_del(const char *node_name) "%s"
>  xen_block_device_create(unsigned int number) "%u"
>  xen_block_device_destroy(unsigned int number) "%u"
> +
> +# m25p80.c
> +m25p80_flash_erase(int offset, uint32_t len) "offset =3D 0x%"PRIx32", =
len =3D %u"
> +m25p80_programming_zero_to_one(uint32_t addr, uint8_t prev, uint8_t da=
ta) "programming zero to one! addr=3D0x%"PRIx32"  0x%"PRIx8" -> 0x%"PRIx8
> +m25p80_reset_done(void) "Reset done."
> +m25p80_command_decoded(uint32_t cmd) "new command:0x%"PRIx32
> +m25p80_complete_collecting(uint32_t cmd, int n, uint8_t ear, uint32_t =
cur_addr) "decode cmd: 0x%"PRIx32" len %d ear 0x%"PRIx8" addr 0x%"PRIx32
> +m25p80_populated_jedec(void) "populated jedec code"
> +m25p80_chip_erase(void) "chip erase"
> +m25p80_select(const char *what) "%sselect"
> +m25p80_page_program(uint32_t addr, uint8_t tx) "page program cur_addr=3D=
0x%"PRIx32" data=3D0x%"PRIx8
> +m25p80_transfer(uint8_t state, uint32_t len, uint8_t needed, uint32_t =
pos, uint32_t cur_addr, uint8_t t) "Transfer state 0x%"PRIx8" len 0x%"PRI=
x32" needed 0x%"PRIx8" pos 0x%"PRIx32" addr 0x%"PRIx32" tx 0x%"PRIx8
> +m25p80_read_byte(uint32_t addr, uint8_t v) "Read byte 0x%"PRIx32"=3D0x=
%"PRIx8
> +m25p80_read_data(uint32_t pos, uint8_t v) "Read data 0x%"PRIx32"=3D0x%=
"PRIx8
> +m25p80_binding(void) "Binding to IF_MTD drive"
> +m25p80_binding_no_bdrv(void) "No BDRV - binding to RAM"
>=20


