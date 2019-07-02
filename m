Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D0E7C06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 17:47:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52DA621721
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 17:47:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tmfnNeK5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52DA621721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiMsl-0001kk-PU
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 13:47:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44360)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair23@gmail.com>) id 1hiLH2-0002mb-PS
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 12:04:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hiLH1-0000dJ-DT
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 12:04:52 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:37965)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hiLH1-0000bL-3V; Tue, 02 Jul 2019 12:04:51 -0400
Received: by mail-lj1-x242.google.com with SMTP id r9so17464272ljg.5;
 Tue, 02 Jul 2019 09:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=nt7CX9pjD84jt91hcxilPIV++TwNUd58utlZEV+OKuw=;
 b=tmfnNeK5GBCB0Tt20RmxWfmzcOBGwixDWEycGp1xuGPOFSHV0UQPqn9uxLZft6RnRz
 oM39xNCaCOeVyw1i1oQvmIUBWviZ6eJFspkxH39zaIkkl9gH2qa+BAxVWPK5YIdzDJg3
 zof5vr5tlP2NxK3RcSlcnD86gn1GPZQdIDdS5h6NRHP/JiQZ0tGfNBcYAD/xc+UcJxZy
 b95+VhvXvI3skeN/KWh644HFu3/g3kjQnMOOCKMDeCTzAJMfqWncEFIMMMRr/WnPthuU
 Ka0AJ9ySeDPVbZf4JxZtfc8sMa0p9eXbC3gP3lBR9gRW+RFoaNR8pxj8sGLyXq7Txwvr
 D7VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=nt7CX9pjD84jt91hcxilPIV++TwNUd58utlZEV+OKuw=;
 b=jmqyZb0MMEuUL9J9vnmge1pvHaKmBcGt2T/CPwR0w5TkPjockAvO+k18zRX/1osXOL
 OTyK5QOsl/rFmHWirRqxZwFAMzYt6//vh6SMd9LcZI0mnDAOwRZ0e6Wt7SVtJL3L1k5S
 09uaWAjZGtk7y3K9EIrgwoU6W0fIS14VDwR7bJVCxWmBq6JQ83iPphZcRQ4XHvZDVyn1
 G83sMdOE970lmB/nOjfqtkSIf0Y1NgSoo67odN+r0Prx+3ZdB84i45dqIm/5Uzb9Yn6O
 bz1GsnUuPW+MQPZCLmkocvKw0LybCRm7osSqlJKqM5xOzqggAc01L/GTj0LtlXyCfTA1
 NEwg==
X-Gm-Message-State: APjAAAXvcBquZ6MCk7keLkwCsS6Z7DmZhAWAXBWrcW79/55MNHG4RTDK
 rbIofqnVR2BlY+LyzEYu88QjSksal6/20j2pZzc=
X-Google-Smtp-Source: APXvYqxbevUaFTQjL9mTx8kDt/bY7qoIiz0RW4+FCCktoc6YVsovIYsr6IkWMBn7PV9f+Pk/ozj108uD0zCMN4NDzrg=
X-Received: by 2002:a2e:9758:: with SMTP id f24mr1538480ljj.58.1562083487757; 
 Tue, 02 Jul 2019 09:04:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190702001301.4768-1-philmd@redhat.com>
 <20190702001301.4768-4-philmd@redhat.com>
In-Reply-To: <20190702001301.4768-4-philmd@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 2 Jul 2019 09:01:44 -0700
Message-ID: <CAKmqyKNF=EeuPLRb25sCQz69PQkFws2M=CQs-+sQus9XGdiNaQ@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::242
Subject: Re: [Qemu-devel] [PATCH v2 3/9] hw/block/pflash_cfi01: Extract
 pflash_mode_read_array()
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Max Filippov <jcmvbkbc@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Qemu-block <qemu-block@nongnu.org>, Aleksandar Rikalo <arikalo@wavecomp.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Kevin Wolf <kwolf@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Michael Walle <michael@walle.cc>,
 "open list:New World" <qemu-ppc@nongnu.org>,
 Wei Yang <richardw.yang@linux.intel.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 1, 2019 at 5:14 PM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.c=
om> wrote:
>
> The same pattern is used when setting the flash in READ_ARRAY mode:
> - Set the state machine command to READ_ARRAY
> - Reset the write_cycle counter
> - Reset the memory region in ROMD
>
> Refactor the current code by extracting this pattern.
> It is used twice:
> - On a write access (on command failure, error, or explicitly asked)
> - When the device is initialized. Here the ROMD mode is hidden
>   by the memory_region_init_rom_device() call.
>
> Rename the 'reset_flash' as 'mode_read_array' to make explicit we
> do not reset the device, we simply set its internal state machine
> in the READ_ARRAY mode. We do not reset the status register error
> bits, as a device reset would do.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/block/pflash_cfi01.c | 36 ++++++++++++++++++++----------------
>  hw/block/trace-events   |  1 +
>  2 files changed, 21 insertions(+), 16 deletions(-)
>
> diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
> index 743b5d5794..33c77f6569 100644
> --- a/hw/block/pflash_cfi01.c
> +++ b/hw/block/pflash_cfi01.c
> @@ -112,6 +112,14 @@ static const VMStateDescription vmstate_pflash =3D {
>      }
>  };
>
> +static void pflash_mode_read_array(PFlashCFI01 *pfl)
> +{
> +    trace_pflash_mode_read_array();
> +    pfl->cmd =3D 0xff; /* Read Array */
> +    pfl->wcycle =3D 0;
> +    memory_region_rom_device_set_romd(&pfl->mem, true);
> +}
> +
>  /* Perform a CFI query based on the bank width of the flash.
>   * If this code is called we know we have a device_width set for
>   * this flash.
> @@ -470,7 +478,7 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr off=
set,
>          case 0x50: /* Clear status bits */
>              DPRINTF("%s: Clear status bits\n", __func__);
>              pfl->status =3D 0x0;
> -            goto reset_flash;
> +            goto mode_read_array;
>          case 0x60: /* Block (un)lock */
>              DPRINTF("%s: Block unlock\n", __func__);
>              break;
> @@ -495,10 +503,10 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr o=
ffset,
>              break;
>          case 0xf0: /* Probe for AMD flash */
>              DPRINTF("%s: Probe for AMD flash\n", __func__);
> -            goto reset_flash;
> +            goto mode_read_array;
>          case 0xff: /* Read array mode */
>              DPRINTF("%s: Read array mode\n", __func__);
> -            goto reset_flash;
> +            goto mode_read_array;
>          default:
>              goto error_flash;
>          }
> @@ -525,7 +533,7 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr off=
set,
>                  pfl->wcycle =3D 0;
>                  pfl->status |=3D 0x80;
>              } else if (cmd =3D=3D 0xff) { /* Read Array */
> -                goto reset_flash;
> +                goto mode_read_array;
>              } else
>                  goto error_flash;
>
> @@ -552,15 +560,15 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr o=
ffset,
>                  pfl->wcycle =3D 0;
>                  pfl->status |=3D 0x80;
>              } else if (cmd =3D=3D 0xff) { /* read array mode */
> -                goto reset_flash;
> +                goto mode_read_array;
>              } else {
>                  DPRINTF("%s: Unknown (un)locking command\n", __func__);
> -                goto reset_flash;
> +                goto mode_read_array;
>              }
>              break;
>          case 0x98:
>              if (cmd =3D=3D 0xff) {
> -                goto reset_flash;
> +                goto mode_read_array;
>              } else {
>                  DPRINTF("%s: leaving query mode\n", __func__);
>              }
> @@ -620,7 +628,7 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr off=
set,
>                      " the data is already written to storage!\n"
>                      "Flash device reset into READ mode.\n",
>                      __func__);
> -                goto reset_flash;
> +                goto mode_read_array;
>              }
>              break;
>          default:
> @@ -630,7 +638,7 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr off=
set,
>      default:
>          /* Should never happen */
>          DPRINTF("%s: invalid write state\n",  __func__);
> -        goto reset_flash;
> +        goto mode_read_array;
>      }
>      return;
>
> @@ -639,11 +647,8 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr of=
fset,
>                    "(offset " TARGET_FMT_plx ", wcycle 0x%x cmd 0x%x valu=
e 0x%x)"
>                    "\n", __func__, offset, pfl->wcycle, pfl->cmd, value);
>
> - reset_flash:
> -    trace_pflash_reset();
> -    memory_region_rom_device_set_romd(&pfl->mem, true);
> -    pfl->wcycle =3D 0;
> -    pfl->cmd =3D 0xff;
> + mode_read_array:
> +    pflash_mode_read_array(pfl);
>  }
>
>
> @@ -758,8 +763,7 @@ static void pflash_cfi01_realize(DeviceState *dev, Er=
ror **errp)
>          pfl->max_device_width =3D pfl->device_width;
>      }
>
> -    pfl->wcycle =3D 0;
> -    pfl->cmd =3D 0xff;
> +    pflash_mode_read_array(pfl);
>      pfl->status =3D 0;
>      /* Hardcoded CFI table */
>      /* Standard "QRY" string */
> diff --git a/hw/block/trace-events b/hw/block/trace-events
> index 97a17838ed..d627cfc3f5 100644
> --- a/hw/block/trace-events
> +++ b/hw/block/trace-events
> @@ -7,6 +7,7 @@ fdc_ioport_write(uint8_t reg, uint8_t value) "write reg 0=
x%02x val 0x%02x"
>  # pflash_cfi02.c
>  # pflash_cfi01.c
>  pflash_reset(void) "reset"
> +pflash_mode_read_array(void) "mode: read array"
>  pflash_read(uint64_t offset, uint8_t cmd, int width, uint8_t wcycle) "of=
fset:0x%04"PRIx64" cmd:0x%02x width:%d wcycle:%u"
>  pflash_write(uint64_t offset, uint32_t value, int width, uint8_t wcycle)=
 "offset:0x%04"PRIx64" value:0x%03x width:%d wcycle:%u"
>  pflash_timer_expired(uint8_t cmd) "command 0x%02x done"
> --
> 2.20.1
>

