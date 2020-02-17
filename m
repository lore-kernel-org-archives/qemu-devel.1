Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 592D8C3B1BF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 01:20:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 025AB206E2
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 01:20:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YiLXoIQ+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 025AB206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3V5T-0001EC-4h
	for qemu-devel@archiver.kernel.org; Sun, 16 Feb 2020 20:20:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36243)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <programmingkidx@gmail.com>) id 1j3V4c-0000Ld-Oc
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 20:19:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <programmingkidx@gmail.com>) id 1j3V4Y-0004Gb-Sj
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 20:19:46 -0500
Received: from mail-yb1-xb43.google.com ([2607:f8b0:4864:20::b43]:45847)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
 id 1j3V4Y-0004Fj-J7; Sun, 16 Feb 2020 20:19:42 -0500
Received: by mail-yb1-xb43.google.com with SMTP id j78so4501092ybg.12;
 Sun, 16 Feb 2020 17:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=WJZJmHZ7O/kck/iM3KJyScLck5/NbsywhOmGCub63P0=;
 b=YiLXoIQ+gEwU/ce4AIrXHg+fiFugHGmj89wabipICNBeJ+PRitV2H4MNd1Vc0j3BIo
 jhGW22AAc/qXQBY8F47o5B4dJXNsCC9C1OcI3ZFNC3rxqeUNjR9tssne1fi0kCAfGWkX
 chh4CFMnPBm5ivpnSRQ3EXYSAQujMEf1SZS+d2WjUvfFYtg01kJmQzeNUzBrraxFqWPT
 q/c4fBTzZCInXaN+staimcidq8uLnagdZlX9XqFdeamBGUZra59tcOSqhcnSCrZB1CKw
 d+Dv9FZ1FlY2ToIJVZuY88TNq3cEHreqITJbh31o25xOapLu5hhn/44MPJsKhGsyo60l
 jkqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=WJZJmHZ7O/kck/iM3KJyScLck5/NbsywhOmGCub63P0=;
 b=o2FFKizyNsfJaz5LsFj2QZbEqKJB74MBSawxPfIL6c3glOxfzkergfGS9+aXkBoxHq
 315ZhzU//HYn/Xm49nScXGt095hKSLb7DdhdHAnKhClFPc9THtp4CVPBCoeVO9JgQ0Oe
 n8yyMC8KQ9O0HMOK7jubSxrgTc51IJhQB3d2VHgrPd7IoW8LpBkNufxFr3oyGJlPijtU
 Vz8FAhK49+TGFEc2QCUSiecirdAEfQNS17uCHCTbx4iIgS4yjvqr1cMSIn74cCBdqkfe
 MwlcNetIQPO5pKe5Acel5WNGdW2UR8rrbmsvwl9N9mnlJJftrvaL0N/+R/j2PK6g0vXK
 v2AQ==
X-Gm-Message-State: APjAAAVJl3oZl6P2tqE9r9XvjZl2SJG0sRhTAIQZpSImpzjGB/lSdtSS
 lhvN4MuEWAoYRgxc82jJ99ryjuZ6
X-Google-Smtp-Source: APXvYqy7HPyGxt06ClF0L8UF+WY0Fw39Yw/ppsAvrRKux30rly/XWPw5U5iBmt4YyZeY3UbWOXBYIg==
X-Received: by 2002:a25:d348:: with SMTP id e69mr12696594ybf.203.1581902381432; 
 Sun, 16 Feb 2020 17:19:41 -0800 (PST)
Received: from [192.168.0.5] (d149-67-30-58.try.wideopenwest.com.
 [67.149.58.30])
 by smtp.gmail.com with ESMTPSA id y17sm5708497ywd.23.2020.02.16.17.19.40
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 16 Feb 2020 17:19:40 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v3] Implement the Screamer sound chip for the mac99
 machine type
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <CABLmASF=9Qj0_Hh2SWO6K=Sou3mVeyLL+XXTn9WGc670KRn2AA@mail.gmail.com>
Date: Sun, 16 Feb 2020 20:19:38 -0500
Content-Transfer-Encoding: quoted-printable
Message-Id: <2AF97D91-F58C-455D-9E05-F5766A6A4C9B@gmail.com>
References: <20200216163216.10745-1-programmingkidx@gmail.com>
 <CABLmASF=9Qj0_Hh2SWO6K=Sou3mVeyLL+XXTn9WGc670KRn2AA@mail.gmail.com>
To: Howard Spoelstra <hsp.cat7@gmail.com>
X-Mailer: Apple Mail (2.3273)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b43
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
Cc: qemu-ppc <qemu-ppc@nongnu.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Gerd Hoffmann <kraxel@redhat.com>,
 qemu-devel qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


> On Feb 16, 2020, at 2:57 PM, Howard Spoelstra <hsp.cat7@gmail.com> =
wrote:
>=20
>=20
>=20
>=20
> On Sun, Feb 16, 2020 at 5:32 PM John Arbuckle =
<programmingkidx@gmail.com> wrote:
> Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
> ---
> v3 changes:
> - Updated the location of patched code in hw/ppc/kconfig.
> - Removed setting the props variable in screamer.c.
> - Removed the screamer_properties variable in screamer.c.
>=20
> v2 changes:
> - Fixed a bug that prevented the sampling rate from being changed.
>=20
>  hw/audio/Kconfig              |   3 +
>  hw/audio/Makefile.objs        |   2 +
>  hw/audio/screamer.c           | 983 =
++++++++++++++++++++++++++++++++++++++++++
>  hw/misc/macio/macio.c         |  35 +-
>  hw/ppc/Kconfig                |   1 +
>  hw/ppc/mac.h                  |   5 +
>  include/hw/audio/screamer.h   |  42 ++
>  include/hw/misc/macio/macio.h |   2 +
>  8 files changed, 1072 insertions(+), 1 deletion(-)
>  create mode 100644 hw/audio/screamer.c
>  create mode 100644 include/hw/audio/screamer.h
>=20
> diff --git a/hw/audio/Kconfig b/hw/audio/Kconfig
> index e9c6fed826..196da6c3fe 100644
> --- a/hw/audio/Kconfig
> +++ b/hw/audio/Kconfig
> @@ -50,3 +50,6 @@ config CS4231
>=20
>  config MARVELL_88W8618
>      bool
> +
> +config SCREAMER
> +    bool
> diff --git a/hw/audio/Makefile.objs b/hw/audio/Makefile.objs
> index 63db383709..55906886bc 100644
> --- a/hw/audio/Makefile.objs
> +++ b/hw/audio/Makefile.objs
> @@ -15,4 +15,6 @@ common-obj-$(CONFIG_CS4231) +=3D cs4231.o
>  common-obj-$(CONFIG_MARVELL_88W8618) +=3D marvell_88w8618.o
>  common-obj-$(CONFIG_MILKYMIST) +=3D milkymist-ac97.o
>=20
> +common-obj-$(CONFIG_SCREAMER) +=3D screamer.o
> +
>  common-obj-y +=3D soundhw.o
> diff --git a/hw/audio/screamer.c b/hw/audio/screamer.c
> new file mode 100644
> index 0000000000..ad4aba12eb
> --- /dev/null
> +++ b/hw/audio/screamer.c
> @@ -0,0 +1,983 @@
> +/*
> + * File: Screamer.c
> + * Description: Implement the Screamer sound chip used in Apple =
Macintoshes.
> + * It works by filling a buffer, then playing the buffer.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "audio/audio.h"
> +#include "hw/hw.h"
> +#include "hw/irq.h"
> +#include <inttypes.h>
> +#include "hw/ppc/mac.h"
> +#include "hw/qdev-properties.h"
> +#include "migration/vmstate.h"
> +#include "include/hw/audio/screamer.h"
> +
> +#define DEBUG_SCREAMER 0
> +#define DPRINTF(fmt, ...) \
> +do { if (DEBUG_SCREAMER) { printf(fmt , ## __VA_ARGS__); } } while =
(0)
> +
> +#define SOUND_CONTROL_REG  0
> +#define CODEC_CONTROL_REG  1
> +#define CODEC_STATUS_REG   2
> +#define CLIP_COUNT_REG     3
> +#define BYTE_SWAP_REG      4
> +#define FRAME_COUNT_REG    5
> +
> +#define AWACS_BUSY         0x01000000
> +
> +/* Used with AWACS register 1 */
> +#define RECALIBRATE         0x004
> +#define LOOPTHRU            0x040
> +#define SPEAKER_MUTE        0x080
> +#define HEADPHONE_MUTE      0x200
> +#define OUTPUT_ZERO         0x400
> +#define OUTPUT_ONE          0x800
> +#define PARALLEL_OUTPUT     0xc00
> +
> +/* Function prototypes */
> +static uint32_t set_busy_bit(uint32_t value, int bit);
> +static uint32_t set_part_ready_bit(uint32_t value, int bit_value);
> +static uint32_t set_revision(uint32_t input_value);
> +static uint32_t set_manufacturer(uint32_t input_value);
> +static int get_sampling_rate(ScreamerState *s);
> +static uint32_t get_frame_count_reg(ScreamerState *s);
> +static void add_to_speaker_buffer(DBDMA_io *io);
> +static void dma_request(DBDMA_io *io);
> +
> +
> +/**************************** Getters *************************/
> +
> +/* Returns the codec control register's encoded AWACS address */
> +static uint8_t get_codec_control_address(uint32_t value)
> +{
> +    uint8_t return_value;
> +    return_value =3D (value >> 12) & 0x00000fff;
> +    return return_value;
> +}
> +
> +
> +static uint32_t get_sound_control_reg(ScreamerState *s)
> +{
> +    DPRINTF("%s() called - returned 0x%x\n", __func__, =
s->sound_control);
> +    return s->sound_control;
> +}
> +
> +/* The AWACS registers are accessed thru this register */
> +static uint32_t get_codec_control_reg(ScreamerState *s)
> +{
> +    int awacs_register =3D =
get_codec_control_address(s->codec_control);
> +    uint32_t return_value =3D s->awacs[awacs_register];
> +    return_value =3D set_busy_bit(return_value, 0); /* Tell CPU we =
are ready */
> +    DPRINTF("%s() called - returned 0x%x\tAWACS register: %d\n", =
__func__,
> +            return_value, awacs_register);
> +    return return_value;
> +}
> +
> +/*
> + * Determines if the readback bit is set.
> + * It is used by the Codec Control register.
> + */
> +static bool readback_enabled(ScreamerState *s)
> +{
> +/* Note: bit zero is the readback enabled bit */
> +    if (s->awacs[7] & 1) {
> +        return true;
> +    } else {
> +        return false;
> +    }
> +}
> +
> +static uint32_t get_codec_status_reg(ScreamerState *s)
> +{
> +    uint32_t return_value;
> +
> +    /* if in readback mode - return AWACS register value */
> +    if (readback_enabled(s)) {
> +        int awacs_register =3D (s->awacs[7] & 0xe) >> 1;
> +        s->awacs[7] =3D s->awacs[7] & 0xfffffffe; /* turn off =
readback mode */
> +        return_value =3D s->awacs[awacs_register] << 4;
> +        DPRINTF("readback enable bit is set, returning AWACS register =
%d\t"
> +                "value:0x%x\n", awacs_register, return_value);
> +
> +        return return_value;
> +    }
> +
> +    /* Tell CPU we are ready */
> +    return_value =3D set_part_ready_bit(s->codec_status, 1);
> +
> +    /* Set Revision to Screamer */
> +    return_value =3D set_revision(return_value);
> +
> +    /* Set the Manufacturer to Crystal */
> +    return_value =3D set_manufacturer(return_value);
> +    DPRINTF("%s() called - returned 0x%x\n", __func__, return_value);
> +
> +    return return_value;
> +}
> +
> +static uint32_t get_clip_count_reg(ScreamerState *s)
> +{
> +    DPRINTF("%s() called - returned 0x%x\n", __func__, =
s->clip_count);
> +    uint32_t return_value;
> +    return_value =3D s->clip_count;
> +    /* This is reset everytime it is read */
> +    s->clip_count =3D 0;
> +    return return_value;
> +}
> +
> +static uint32_t get_byte_swap_reg(ScreamerState *s)
> +{
> +    DPRINTF("%s() called - returned 0x%x\n", __func__, s->byte_swap);
> +    /*
> +     * If all you hear is noise, it could be this register reporting =
the
> +     * wrong value.
> +     */
> +    return s->byte_swap ? 0 : 1;
> +}
> +
> +/*
> + * Returns the frame (sample) count
> + */
> +static uint32_t get_frame_count_reg(ScreamerState *s)
> +{
> +    DPRINTF("%s() called - returned 0x%x\n", __func__, =
s->frame_count);
> +    return s->frame_count;
> +}
> +
> +static uint8_t get_left_vol(uint32_t value)
> +{
> +    return value & 0xf;
> +}
> +
> +static uint8_t get_right_vol(uint32_t value)
> +{
> +    return value & 0x3c0 >> 6;
> +}
> +
> +/*
> + * Returns the sampling rate.
> + * If the audio is playing back too fast or too slow, this function =
may be the
> + * cause.
> + */
> +static int get_sampling_rate(ScreamerState *s)
> +{
> +    uint32_t screamer_rate =3D s->sound_control & 0x700;
> +    int return_value;
> +
> +    /* All return values are in Hertz */
> +    switch (screamer_rate) {
> +    case 0x0:
> +        return_value =3D 44100;
> +        break;
> +    case 0x100:
> +        return_value =3D 29400;
> +        break;
> +    case 0x200:
> +        return_value =3D 22050;
> +        break;
> +    case 0x300:
> +        return_value =3D 17640;
> +        break;
> +    case 0x400:
> +        return_value =3D 14700;
> +        break;
> +    case 0x500:
> +        return_value =3D 11025;
> +        break;
> +    case 0x600:
> +        return_value =3D 8820;
> +        break;
> +    case 0x700:
> +        return_value =3D 7350;
> +        break;
> +    default:
> +        DPRINTF("get_sampling_rate() unknown value: 0x%x\nDefaulting =
to"
> +                " 44100 Hz.\n", screamer_rate);
> +        return 44100;
> +}
> +    DPRINTF("%s() called - returning %dHz\n", __func__, =
return_value);
> +    return return_value;
> +}
> +
> +/**************************** End of getters =
*************************/
> +
> +/***************************** Speaker call back =
*************************/
> +
> +/* resets the play and buffer position markers */
> +static void reset_markers(ScreamerState *s)
> +{
> +    s->spk_play_position =3D 0;
> +    s->spk_buffer_position =3D 0;
> +}
> +
> +
> +/* Sends the samples to the host for playing */
> +static void send_samples_to_host(ScreamerState *s, int max_samples)
> +{
> +    int write_length, requested_length;
> +    requested_length =3D MIN(max_samples, (s->spk_buffer_position -
> +                                         s->spk_play_position));
> +    write_length =3D AUD_write(s->speaker_voice,
> +                             &s->spk_buffer[s->spk_play_position],
> +                             requested_length);
> +    DPRINTF("requested length: %d\twrite length: %d\t",
> +            requested_length, write_length);
> +    s->spk_play_position +=3D write_length;
> +    DPRINTF("AUD_write %d/%d\n", s->spk_play_position, =
s->spk_buffer_position);
> +    s->frame_count +=3D write_length;
> +}
> +
> +
> +/*
> + * Called by QEMU's audio system to tell the output backend to send =
samples
> + * from the buffer to the host sound system.
> + * opaque: a pointer to the ScreamerState instance.
> + * max_samples: the number of samples that can be sent to the =
hardware buffer.
> + */
> +static void speaker_callback(void *opaque, int max_samples)
> +{
> +    ScreamerState *s =3D (ScreamerState *) opaque;
> +
> +    /* if we have more samples to play */
> +    if (s->spk_buffer_position > 0) {
> +        if (s->spk_buffer_position > s->spk_play_position) {
> +            DPRINTF("%s() called - max_samples: %d\n", __func__, =
max_samples);
> +            send_samples_to_host(s, max_samples);
> +        }
> +        if (s->spk_play_position >=3D s->spk_buffer_position) {
> +            DPRINTF("done playing buffer\n");
> +            DPRINTF("pp: %d\tbp: %d\n", s->spk_play_position,
> +                    s->spk_buffer_position);
> +            if (s->spk_play_position > s->spk_buffer_position) {
> +                DPRINTF("Error detected! - pp > bp\n\a");
> +            }
> +            reset_markers(s);
> +            /* play postponed samples */
> +            if (s->dma_io.len > 0) {
> +                DPRINTF("playing postponed samples\n");
> +                add_to_speaker_buffer(&s->dma_io);
> +                return;
> +            }
> +        }
> +    }
> +}
> +
> +/************************* End of speaker call back =
*************************/
> +
> +
> +/* Opens the speaker's voice */
> +static void open_speaker_voice(ScreamerState *s)
> +{
> +    DPRINTF("%s() called\n", __func__);
> +
> +    /* if voice is already open return from function */
> +    if (s->speaker_voice !=3D NULL) {
> +        DPRINTF("closing speaker voice\n");
> +        AUD_close_out(&s->card, s->speaker_voice);
> +        s->speaker_voice =3D NULL;
> +    }
> +    struct audsettings audio_settings;
> +    audio_settings.freq =3D get_sampling_rate(s);  /* in hertz */
> +    audio_settings.nchannels =3D 2;                /* stereo output =
*/
> +    audio_settings.fmt =3D AUDIO_FORMAT_S16;       /* signed 16 bit =
*/
> +    audio_settings.endianness =3D get_byte_swap_reg(s); /* endianness =
*/
> +    s->speaker_voice =3D AUD_open_out(&s->card, s->speaker_voice, =
SOUND_CHIP_NAME
> +                                    " speaker", s, speaker_callback,
> +                                    &audio_settings);
> +    if (!s->speaker_voice) {
> +        AUD_log(SOUND_CHIP_NAME, "Out voice could not be opened\n");
> +    } else {
> +        AUD_set_active_out(s->speaker_voice, true);
> +    }
> +}
> +
> +
> +/******************************* Setters =
*************************************/
> +
> +
> +/* Updates QEMU's audio backend settings */
> +static void set_QEMU_audio_settings(ScreamerState *s)
> +{
> +    DPRINTF("%s() called\n", __func__);
> +    open_speaker_voice(s);
> +}
> +
> +
> +/* Return value: 1 =3D muted  0 =3D not muted */
> +static int is_muted(ScreamerState *s)
> +{
> +    int mute_state =3D s->awacs[1] & SPEAKER_MUTE ? 1 : 0;
> +    if (s->awacs[1] & SPEAKER_MUTE) {
> +        DPRINTF("speaker is muted\n");
> +    } else {
> +        DPRINTF("speaker is unmuted\n");
> +    }
> +
> +    if (s->awacs[1] & HEADPHONE_MUTE) {
> +        DPRINTF("headphone is muted\n");
> +    } else {
> +        DPRINTF("headphone is unmuted\n");
> +    }
> +    return mute_state;
> +}
> +
> +
> +/* Converts Screamer's volume system to QEMU's system */
> +static int screamer_to_qemu_volume(int x)
> +{
> +    return -16 * x + 240;
> +}
> +
> +
> +/* Sets QEMU's volume. */
> +static void set_volume(ScreamerState *s)
> +{
> +    int should_mute =3D is_muted(s);
> +
> +    /* Get Screamer volume values */
> +    uint8_t left_vol =3D get_left_vol(s->awacs[4]);
> +    uint8_t right_vol =3D get_right_vol(s->awacs[4]);
> +    DPRINTF("set_volume() called - M:%d\tL:%d\tR:%d\n", should_mute, =
left_vol,
> +            right_vol);
> +
> +    /* Convert Screamer to QEMU volume values */
> +    left_vol =3D screamer_to_qemu_volume(left_vol);
> +    right_vol =3D screamer_to_qemu_volume(right_vol);
> +    DPRINTF("QEMU volume: L:%d\tR:%d\n", left_vol, right_vol);
> +    AUD_set_volume_out(s->speaker_voice, should_mute, left_vol, =
right_vol);
> +}
> +
> +
> +/* Sets the sound control register */
> +static void set_sound_control_reg(ScreamerState *s, uint32_t value)
> +{
> +    DPRINTF("set_sound_control_reg() called - value: 0x%x\n", value);
> +    s->sound_control =3D value;
> +    set_QEMU_audio_settings(s);
> +}
> +
> +
> +/* Used for input gain only - can be ignored for now. */
> +static void set_awacs_0_reg(ScreamerState *s, uint32_t new_value)
> +{
> +    DPRINTF("Settings AWACS register 0 to 0x%x\n", s->awacs[0]);
> +    s->awacs[0] =3D new_value;
> +}
> +
> +
> +static void set_awacs_1_reg(ScreamerState *s, uint32_t new_value)
> +{
> +    DPRINTF("Settings AWACS register 1 to 0x%x\n", new_value);
> +
> +    s->awacs[1] =3D new_value;
> +
> +    /* If recalibration requested */
> +    if (new_value & RECALIBRATE) {
> +        DPRINTF("Recalibration requested - unimplemented\n");
> +        new_value =3D new_value ^ RECALIBRATE; /* Turn off =
recalibrate bit */
> +    }
> +
> +    /* If loop thru set - what does this mean? */
> +    if (new_value & LOOPTHRU) {
> +        DPRINTF("Loopthru enabled - doing nothing\n");
> +    }
> +
> +    /* Set headphone jack mute state */
> +    if (new_value & HEADPHONE_MUTE) {
> +        DPRINTF("Headphone muted\n");
> +    }
> +
> +    else {
> +        DPRINTF("Headphone unmuted\n");
> +    }
> +
> +    if (new_value & SPEAKER_MUTE) {
> +        DPRINTF("Speaker muted\n");
> +    }
> +
> +    else {
> +        DPRINTF("Speaker unmuted\n");
> +    }
> +
> +    if (new_value & OUTPUT_ZERO) {
> +        DPRINTF("output zero set - not sure what this means\n");
> +    }
> +
> +    if (new_value & OUTPUT_ONE) {
> +        DPRINTF("output one set - not sure what this means\n");
> +    }
> +
> +    if (new_value & PARALLEL_OUTPUT) {
> +        DPRINTF("parallel port enabled - but no parallel port =
here\n");
> +    }
> +
> +    set_volume(s);
> +}
> +
> +
> +/* This is used for headphone volume - not needed */
> +static void set_awacs_2_reg(ScreamerState *s, uint32_t new_value)
> +{
> +    DPRINTF("Settings AWACS register 2 to 0x%x\n"
> +            "Ignoring change in headphone volume.\n", s->awacs[2]);
> +    s->awacs[2] =3D new_value;
> +}
> +
> +
> +/* Unknown register purpose */
> +static void set_awacs_3_reg(ScreamerState *s, uint32_t new_value)
> +{
> +    DPRINTF("Settings AWACS register 3 to 0x%x\n"
> +            "This register has an unknown purpose and does not do =
anything\n",
> +            s->awacs[3]);
> +    s->awacs[3] =3D new_value;
> +}
> +
> +
> +/* Mostly deals with speaker volume */
> +static void set_awacs_4_reg(ScreamerState *s, uint32_t new_value)
> +{
> +    DPRINTF("AWACS register 4 write: 0x%x\n", new_value);
> +    s->awacs[4] =3D new_value;
> +    set_volume(s);
> +}
> +
> +
> +/* This register is about loop thru stuff I don't understand */
> +static void set_awacs_5_reg(ScreamerState *s, uint32_t new_value)
> +{
> +    DPRINTF("Settings AWACS register 5 to 0x%x\n"
> +            "Loop thru update ignored.\n", s->awacs[5]);
> +    s->awacs[5] =3D new_value;
> +}
> +
> +
> +/* Prints the states of the AWACS power register */
> +static void print_power_reg_values(uint32_t value)
> +{
> +    if ((value & 0x3) =3D=3D 0) {
> +        printf("Screamer run state set\n");
> +    }
> +    if ((value & 0x3) =3D=3D 1) {
> +        printf("Screamer doze state set\n");
> +    }
> +    if ((value & 0x3) =3D=3D 2) {
> +        printf("Screamer idle state set\n");
> +    }
> +}
> +
> +
> +/* Power Magement register */
> +static void set_awacs_6_reg(ScreamerState *s, uint32_t new_value)
> +{
> +    DPRINTF("Settings AWACS register 6 to 0x%x\n"
> +            "Power management update ignored.\n", s->awacs[6]);
> +    if (DEBUG_SCREAMER) {
> +        print_power_reg_values(new_value);
> +    }
> +    s->awacs[6] =3D new_value;
> +}
> +
> +
> +/* Read Back - repeating something that was sent to this chip? */
> +static void set_awacs_7_reg(ScreamerState *s, uint32_t new_value)
> +{
> +    DPRINTF("Settings AWACS register 7 to 0x%x\n", new_value);
> +    s->awacs[7] =3D new_value;
> +}
> +
> +
> +/* Sets the AWACs registers - a.k.a. shadow registers */
> +static void set_awacs_register(ScreamerState *s, uint32_t value)
> +{
> +    int the_register =3D get_codec_control_address(value);
> +
> +    switch (the_register) {
> +    case 0:
> +        set_awacs_0_reg(s, value);
> +        break;
> +    case 1:
> +        set_awacs_1_reg(s, value);
> +        break;
> +    case 2:
> +        set_awacs_2_reg(s, value);
> +        break;
> +    case 3:
> +        set_awacs_3_reg(s, value);
> +        break;
> +    case 4:
> +        set_awacs_4_reg(s, value);
> +        break;
> +    case 5:
> +        set_awacs_5_reg(s, value);
> +        break;
> +    case 6:
> +        set_awacs_6_reg(s, value);
> +        break;
> +    case 7:
> +        set_awacs_7_reg(s, value);
> +        break;
> +    default:
> +        DPRINTF("Unhandled awacs registers %d\n", the_register);
> +    }
> +}
> +
> +
> +/* Used to set the AWACS registers */
> +static void set_codec_control_reg(ScreamerState *s, uint32_t value)
> +{
> +    DPRINTF("set_codec_control_reg() called - value: 0x%x\n", value);
> +    s->codec_control =3D value;
> +    set_awacs_register(s, value);
> +}
> +
> +static void set_codec_status_reg(ScreamerState *s, uint32_t value)
> +{
> +    DPRINTF("set_codec_status_reg() called - value: 0x%x\n", value);
> +    s->codec_status =3D value;
> +}
> +
> +static void set_clip_count_reg(ScreamerState *s, uint32_t new_value)
> +{
> +    DPRINTF("set_clip_count_reg() called - value: 0x%x\n", =
new_value);
> +    s->clip_count =3D new_value;
> +}
> +
> +static void set_byte_swap_reg(ScreamerState *s, uint32_t value)
> +{
> +    DPRINTF("set_byte_swap_reg() called - value: 0x%x\n", value);
> +    s->byte_swap =3D value;
> +}
> +
> +static void set_frame_count_reg(ScreamerState *s, uint32_t new_value)
> +{
> +    DPRINTF("%s() called - value: 0x%x\n", __func__, new_value);
> +    s->frame_count =3D new_value;
> +}
> +
> +/*
> + * Sets the busy bit of codec control register.
> + * It is used to tell the CPU to wait.
> + * value: the codec control register's value
> + * bit_value: used to set or disable the busy bit
> + */
> +static uint32_t set_busy_bit(uint32_t value, int bit_value)
> +{
> +    const int busy_bit =3D 0x01000000;
> +    uint32_t return_value;
> +    if (bit_value =3D=3D 1)  /* Set this bit */
> +        return_value =3D (value | busy_bit);
> +    else /* bit_value =3D=3D 0  Disable this bit */
> +        return_value =3D (value & ~busy_bit);
> +    return return_value;
> +}
> +
> +
> +/*
> + * Sets the part ready bit of the codec status register
> + * value: the codec status register's value
> + * bit_value: used to set or disable the part ready bit
> + */
> +static uint32_t set_part_ready_bit(uint32_t value, int bit_value)
> +{
> +    const int part_ready_bit =3D 0x00400000;
> +    uint32_t return_value;
> +    if (bit_value =3D=3D 1)  /* Set this bit */
> +        return_value =3D (value | part_ready_bit);
> +    else /* bit_value =3D=3D 0  Disable this bit */
> +        return_value =3D (value & ~part_ready_bit);
> +    return return_value;
> +}
> +
> +/* Sets bits 12 and 13 to 1 to indicate the Screamer revision */
> +static uint32_t set_revision(uint32_t input_value)
> +{
> +    uint32_t return_value;
> +    return_value =3D input_value | 0x3000;
> +    return return_value;
> +}
> +
> +/* Sets bit 8 to indicate Crystal as the manufacturer */
> +static uint32_t set_manufacturer(uint32_t input_value)
> +{
> +    uint32_t return_value;
> +    return_value =3D input_value | 0x100;
> +    return return_value;
> +}
> +
> +
> +/************************** End of Setters =
*********************************/
> +
> +
> +/*************************** DMA functions =
*********************************/
> +
> +/*
> + * Sends audio samples from a microphone or line-in to memory.
> + * Used for sound input.
> + * Currently only prevents a deadlock condition with Mac OS 9.
> + */
> +static void screamer_to_dma(DBDMA_io *io)
> +{
> +    DPRINTF("%s() called\n", __func__);
> +    ScreamerState *s =3D (ScreamerState *)io->opaque;
> +    DBDMAState *dbs =3D s->dbdma;
> +    DBDMA_channel *ch =3D &dbs->channels[0x12];
> +    ch->regs[DBDMA_STATUS] |=3D DEAD;
> +    ch->regs[DBDMA_STATUS] &=3D ~ACTIVE;
> +    io->dma_end(io);
> +    return;
> +}
> +
> +
> +static void print_dma_info(DBDMA_io *io)
> +{
> +    #define RUN        0x8000
> +    #define PAUSE      0x4000
> +    #define FLUSH      0x2000
> +    #define WAKE       0x1000
> +    #define DEAD       0x0800
> +    #define ACTIVE     0x0400
> +    #define BT         0x0100
> +    #define DEVSTAT    0x00ff
> +
> +    /*
> +     * RUN and PAUSE are bits under software control only.
> +     * FLUSH and WAKE are set by SW and cleared by hardware.
> +     * DEAD, ACTIVE and BT are only under hardware control.
> +     */
> +
> +    DBDMA_channel *ch =3D io->channel;
> +    printf("DMA FLAGS: ");
> +
> +    if (ch->regs[DBDMA_STATUS] & RUN) {
> +        printf("RUN ");
> +    }
> +
> +    if (ch->regs[DBDMA_STATUS] & ACTIVE) {
> +        printf("ACTIVE ");
> +    }
> +
> +    if (ch->regs[DBDMA_STATUS] & PAUSE) {
> +        printf("PAUSE ");
> +    }
> +
> +    if (ch->regs[DBDMA_STATUS] & DEAD) {
> +        printf("DEAD ");
> +    }
> +
> +    if (ch->regs[DBDMA_STATUS] & WAKE) {
> +        printf("WAKE ");
> +    }
> +
> +    if (ch->regs[DBDMA_STATUS] & BT) {
> +        printf("BT ");
> +    }
> +
> +    if (ch->regs[DBDMA_STATUS] & DEVSTAT) {
> +        printf("DEVSTAT ");
> +    }
> +
> +    if (ch->regs[DBDMA_STATUS] & FLUSH) {
> +        printf("FLUSH ");
> +    }
> +
> +    if (ch->io.processing =3D=3D true) {
> +        printf("processing  ");
> +    }
> +
> +    printf("\n");
> +}
> +
> +/* Tell the DMA controller we request more samples */
> +static void dma_request(DBDMA_io *io)
> +{
> +    DPRINTF("%s() called\n", __func__);
> +    if (DEBUG_SCREAMER) {
> +        print_dma_info(io);
> +    }
> +    io->len =3D 0;
> +    io->dma_end(io);
> +}
> +
> +
> +/* Adds sample data to the buffer */
> +static void add_to_speaker_buffer(DBDMA_io *io)
> +{
> +    ScreamerState *s =3D (ScreamerState *) io->opaque;
> +
> +    if (s->spk_buffer_position + io->len > MAX_BUFFER_SIZE) {
> +        /* postpone calling these samples until the buffer has been =
emptied */
> +        memcpy(&s->dma_io, io, sizeof(DBDMA_io));
> +        return;
> +    }
> +    dma_memory_read(&address_space_memory, io->addr,
> +                    &s->spk_buffer[s->spk_buffer_position], io->len);
> +    s->spk_buffer_position +=3D io->len;
> +    DPRINTF("%s() called - len: %d pos: %d/%d\n", __func__, io->len,
> +            s->spk_buffer_position, MAX_BUFFER_SIZE);
> +
> +    dma_request(io);
> +}
> +
> +/*
> + * Called by the DMA chip to transfer samples from memory to the
> + * Screamer chip.
> + * Used for sound output.
> + */
> +static void dma_to_screamer(DBDMA_io *io)
> +{
> +    add_to_speaker_buffer(io);
> +}
> +
> +
> +/*
> + * This will flush the audio buffer of previous audio - eliminating =
previous
> + * audio playback.
> + */
> +static void send_silence_to_speaker(ScreamerState *s)
> +{
> +    DPRINTF("Silencing audio buffer...\n");
> +    int length =3D MAX_BUFFER_SIZE;
> +    s->spk_buffer_position =3D length;
> +    s->spk_play_position =3D 0;
> +    memset(s->spk_buffer, 0, length);
> +    s->dma_io.len =3D 0; /* stop any postponed samples from playing =
*/
> +}
> +
> +
> +/* This is called after audio stops playing */
> +static void dma_send_flush(DBDMA_io *io)
> +{
> +    DPRINTF("dma_send_flush() called\n");
> +    if (DEBUG_SCREAMER) {
> +        print_dma_info(io);
> +    }
> +    ScreamerState *s =3D (ScreamerState *)io->opaque;
> +    reset_markers(s);
> +    send_silence_to_speaker(s);
> +    if (io->len > 0) {
> +        dma_request(io);
> +    }
> +}
> +
> +
> +static void dma_receive_flush(DBDMA_io *io)
> +{
> +    DPRINTF("dma_receive_flush() called\n");
> +}
> +
> +
> +/* Set the functions the DMA system will call */
> +void screamer_register_dma_functions(ScreamerState *s, void *dbdma,
> +                                   int send_channel, int =
receive_channel)
> +{
> +    DPRINTF("%s() called\n", __func__);
> +    DPRINTF("send channel: %d\treceive channel: %d\n", send_channel,
> +           receive_channel);
> +    s->dbdma =3D dbdma;
> +
> +    /* Setup the DMA send system */
> +    DBDMA_register_channel(s->dbdma, send_channel, s->dma_send_irq,
> +                           dma_to_screamer, dma_send_flush, s);
> +
> +    /* Setup the DMA receive system */
> +    DBDMA_register_channel(s->dbdma, receive_channel, =
s->dma_receive_irq,
> +                           screamer_to_dma, dma_receive_flush, s);
> +}
> +
> +/************************* End of DMA functions =
**************************/
> +
> +/* Resets this sound chip */
> +static void screamer_reset(DeviceState *d)
> +{
> +    DPRINTF("screamer_reset() called\n");
> +    ScreamerState *s =3D SCREAMER(d);
> +    set_sound_control_reg(s, 0);
> +    set_codec_control_reg(s, 0);
> +    set_codec_status_reg(s, 0);
> +    set_clip_count_reg(s, 0);
> +    set_byte_swap_reg(s, 0);
> +    set_frame_count_reg(s, 0);
> +    int i, num_awacs_regs =3D 8;
> +    for (i =3D 0; i < num_awacs_regs; i++) {
> +        s->awacs[i] =3D 0;
> +    }
> +    set_QEMU_audio_settings(s);
> +    reset_markers(s);
> +    s->dma_io.len =3D 0;
> +}
> +
> +/* Called when the CPU reads the memory addresses assigned to =
Screamer */
> +static uint64_t screamer_mmio_read(void *opaque, hwaddr addr, =
unsigned size)
> +{
> +    ScreamerState *state =3D opaque;
> +    uint32_t return_value;
> +
> +    addr =3D addr >> 4;
> +    switch (addr) {
> +    case SOUND_CONTROL_REG:
> +        return_value =3D get_sound_control_reg(state);
> +        break;
> +    case CODEC_CONTROL_REG:
> +        return_value =3D get_codec_control_reg(state);
> +        break;
> +    case CODEC_STATUS_REG:
> +        return_value =3D get_codec_status_reg(state);
> +        break;
> +    case CLIP_COUNT_REG:
> +        return_value =3D get_clip_count_reg(state);
> +        break;
> +    case BYTE_SWAP_REG:
> +        return_value =3D get_byte_swap_reg(state);
> +        break;
> +    case FRAME_COUNT_REG:
> +        return_value =3D get_frame_count_reg(state);
> +        break;
> +    default:
> +        DPRINTF("Unknown register read - addr:%llu\tsize:%d\n", addr, =
size);
> +        return_value =3D 12021981; /* Value used for debugging =
purposes */
> +    }
> +    DPRINTF("screamer_mmio_read() called addr: %llu  size: %d", addr =
>> 4,
> +            size);
> +    DPRINTF("  returning 0x%x\n", return_value);
> +    return return_value;
> +}
> +
> +
> +/* Called when the CPU writes to the memory addresses assigned to =
Screamer */
> +static void screamer_mmio_write(void *opaque, hwaddr addr, uint64_t =
raw_value,
> +                                unsigned size)
> +{
> +    DPRINTF("screamer_mmio_write() called - size: %d\n", size);
> +    ScreamerState *state =3D opaque;
> +    uint32_t value =3D raw_value & 0xffffffff;
> +    addr =3D addr >> 4;
> +
> +    switch (addr) {
> +    case SOUND_CONTROL_REG:
> +        set_sound_control_reg(state, value);
> +        break;
> +    case CODEC_CONTROL_REG:
> +        set_codec_control_reg(state, value);
> +        break;
> +    case CODEC_STATUS_REG:
> +        set_codec_status_reg(state, value);
> +        break;
> +    case CLIP_COUNT_REG:
> +        set_clip_count_reg(state, value);
> +        break;
> +    case BYTE_SWAP_REG:
> +        set_byte_swap_reg(state, value);
> +        break;
> +    case FRAME_COUNT_REG:
> +        set_frame_count_reg(state, value);
> +        break;
> +    default:
> +        DPRINTF("Unknown register write - addr:%llu\tvalue:%d\n", =
addr, value);
> +    }
> +}
> +
> +/* Used for memory_region_init_io() for memory mapped I/O */
> +static const MemoryRegionOps screamer_ops =3D {
> +    .read =3D screamer_mmio_read,
> +    .write =3D screamer_mmio_write,
> +    .endianness =3D DEVICE_LITTLE_ENDIAN,
> +    .valid =3D {
> +        .min_access_size =3D 4,
> +        .max_access_size =3D 4
> +    }
> +};
> +
> +/* Called when the device has become active */
> +static void screamer_realize(DeviceState *dev, Error **errp)
> +{
> +    DPRINTF("screamer_realize() called\n");
> +    screamer_reset(dev);
> +}
> +
> +
> +/*
> + * Called when an instance of the Screamer device is created.
> + * Also called when this HMP command is called: device_add screamer
> + */
> +static void screamer_init(Object *obj)
> +{
> +    DPRINTF("screamer_init() called\n");
> +
> +    ScreamerState *s =3D (ScreamerState *)obj;
> +    SysBusDevice *d =3D SYS_BUS_DEVICE(obj);
> +    const int region_size =3D 5 * 32;
> +
> +    /* Makes the read and write ops work */
> +    memory_region_init_io(&s->io_memory_region, OBJECT(s),
> +                          &screamer_ops, s, SOUND_CHIP_NAME, =
region_size);
> +
> +    /* Sets the SysBusDevice's memory property */
> +    sysbus_init_mmio(d, &s->io_memory_region);
> +
> +    /* Setup all the interrupt requests */
> +    sysbus_init_irq(d, &s->irq);
> +    sysbus_init_irq(d, &s->dma_send_irq);
> +    sysbus_init_irq(d, &s->dma_receive_irq);
> +
> +    /* Registers Screamer with QEMU's audio system */
> +    AUD_register_card(SOUND_CHIP_NAME, &s->card);
> +}
> +
> +
> +/*
> + * When saving and restoring the state of the VM, this is used to =
save and
> + * restore the registers.
> + */
> +static const VMStateDescription vmstate_screamer =3D {
> +    .name =3D "Screamer",
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_UINT16_ARRAY(awacs, ScreamerState, 8), /* 8 AWACS =
registers */
> +        VMSTATE_UINT32(sound_control, ScreamerState),
> +        VMSTATE_UINT32(codec_control, ScreamerState),
> +        VMSTATE_UINT32(codec_status, ScreamerState),
> +        VMSTATE_UINT32(clip_count, ScreamerState),
> +        VMSTATE_UINT32(byte_swap, ScreamerState),
> +        VMSTATE_UINT32(frame_count, ScreamerState),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +
> +/*
> + * Sets the class data. It is like polymorphism and inheritance in =
object
> + * oriented languages.
> + */
> +static void screamer_class_init(ObjectClass *class, void *data)
> +{
> +    DPRINTF("screamer_class_init() called\n");
> +    DeviceClass *dc =3D DEVICE_CLASS(class);
> +    dc->realize =3D screamer_realize;
> +    dc->reset =3D screamer_reset;
> +    dc->desc =3D "Apple Screamer";
> +    dc->vmsd =3D &vmstate_screamer;
> +    dc->hotpluggable =3D false;
> +}
> +
> +/* Used for QOM function registration */
> +static const TypeInfo screamer_info =3D {
> +    .name          =3D "screamer",
> +    .parent        =3D TYPE_SYS_BUS_DEVICE,
> +    .instance_size =3D sizeof(ScreamerState),
> +    .instance_init =3D screamer_init,
> +    .class_init    =3D screamer_class_init,
> +};
> +
> +/* QOM registration of above functions for calling */
> +static void screamer_register_types(void)
> +{
> +    DPRINTF("screamer_register_types() called\n");
> +    type_register_static(&screamer_info);
> +}
> +
> +/* QEMU Object Model (QOM) stuff */
> +type_init(screamer_register_types)
> diff --git a/hw/misc/macio/macio.c b/hw/misc/macio/macio.c
> index 79222192e8..3307fa3818 100644
> --- a/hw/misc/macio/macio.c
> +++ b/hw/misc/macio/macio.c
> @@ -37,6 +37,7 @@
>  #include "hw/intc/heathrow_pic.h"
>  #include "sysemu/sysemu.h"
>  #include "trace.h"
> +#include "include/hw/audio/screamer.h"
>=20
>  /* Note: this code is strongly inspirated from the corresponding code
>   * in PearPC */
> @@ -109,7 +110,10 @@ static void macio_common_realize(PCIDevice *d, =
Error **errp)
>      SysBusDevice *sysbus_dev;
>      Error *err =3D NULL;
>=20
> -    object_property_set_bool(OBJECT(&s->dbdma), true, "realized", =
&err);
> +    const char *realized_property =3D "realized";
> +    bool new_value =3D true;
> +    object_property_set_bool(OBJECT(&s->dbdma), new_value, =
realized_property,
> +                             &err);
>      if (err) {
>          error_propagate(errp, err);
>          return;
> @@ -117,6 +121,19 @@ static void macio_common_realize(PCIDevice *d, =
Error **errp)
>      sysbus_dev =3D SYS_BUS_DEVICE(&s->dbdma);
>      memory_region_add_subregion(&s->bar, 0x08000,
>                                  sysbus_mmio_get_region(sysbus_dev, =
0));
> +    object_property_set_bool(OBJECT(&s->screamer), true, "realized", =
&err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
> +
> +    /* Add the screamer sound chip */
> +    sysbus_dev =3D SYS_BUS_DEVICE(&s->screamer);
> +    const int offset =3D 0x14000; /* Offset from base address =
register (bar) */
> +    const int region_number =3D 0; /* which memory region to use */
> +    memory_region_add_subregion(&s->bar, offset,
> +                                sysbus_mmio_get_region(sysbus_dev,
> +                                                       =
region_number));
>=20
>      qdev_prop_set_uint32(DEVICE(&s->escc), "disabled", 0);
>      qdev_prop_set_uint32(DEVICE(&s->escc), "frequency", ESCC_CLOCK);
> @@ -386,6 +403,19 @@ static void macio_newworld_realize(PCIDevice *d, =
Error **errp)
>          memory_region_add_subregion(&s->bar, 0x16000,
>                                      =
sysbus_mmio_get_region(sysbus_dev, 0));
>      }
> +
> +    /* Screamer Sound Chip */
> +    const int gpio_0 =3D 0;
> +    const int gpio_1 =3D 1;
> +    const int transmit_channel =3D 0x10;
> +    const int receive_channel =3D 0x12;
> +    sysbus_dev =3D SYS_BUS_DEVICE(&s->screamer);
> +    sysbus_connect_irq(sysbus_dev, gpio_0, qdev_get_gpio_in(pic_dev,
> +                                           NEWWORLD_SCREAMER_IRQ));
> +    sysbus_connect_irq(sysbus_dev, gpio_1, qdev_get_gpio_in(pic_dev,
> +                                           =
NEWWORLD_SCREAMER_DMA_IRQ));
> +    screamer_register_dma_functions(SCREAMER(sysbus_dev), &s->dbdma,
> +                                    transmit_channel, =
receive_channel);
>  }
>=20
>  static void macio_newworld_init(Object *obj)
> @@ -420,6 +450,9 @@ static void macio_instance_init(Object *obj)
>                           TYPE_MAC_DBDMA);
>=20
>      macio_init_child_obj(s, "escc", &s->escc, sizeof(s->escc), =
TYPE_ESCC);
> +
> +    macio_init_child_obj(s, SOUND_CHIP_NAME, &s->screamer, =
sizeof(s->screamer),
> +                         TYPE_SCREAMER);
>  }
>=20
>  static const VMStateDescription vmstate_macio_oldworld =3D {
> diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
> index 354828bf13..4ffc3a1c16 100644
> --- a/hw/ppc/Kconfig
> +++ b/hw/ppc/Kconfig
> @@ -104,6 +104,7 @@ config MAC_NEWWORLD
>      select MAC_PMU
>      select UNIN_PCI
>      select FW_CFG_PPC
> +    select SCREAMER
>=20
>  config E500
>      bool
> diff --git a/hw/ppc/mac.h b/hw/ppc/mac.h
> index 6af87d1fa0..c65f2fd15f 100644
> --- a/hw/ppc/mac.h
> +++ b/hw/ppc/mac.h
> @@ -34,6 +34,8 @@
>  #include "hw/misc/mos6522.h"
>  #include "hw/pci/pci_host.h"
>  #include "hw/pci-host/uninorth.h"
> +#include "hw/ppc/mac_dbdma.h"
> +#include "audio/audio.h"
>=20
>  /* SMP is not enabled, for now */
>  #define MAX_CPUS 1
> @@ -68,6 +70,9 @@
>  #define NEWWORLD_IDE1_DMA_IRQ  0x3
>  #define NEWWORLD_EXTING_GPIO1  0x2f
>  #define NEWWORLD_EXTING_GPIO9  0x37
> +#define NEWWORLD_SCREAMER_IRQ  0x18
> +#define NEWWORLD_SCREAMER_DMA_IRQ 0x9
> +#define NEWWORLD_SCREAMER_RX_IRQ 0xa
>=20
>  /* Core99 machine */
>  #define TYPE_CORE99_MACHINE MACHINE_TYPE_NAME("mac99")
> diff --git a/include/hw/audio/screamer.h b/include/hw/audio/screamer.h
> new file mode 100644
> index 0000000000..7155541688
> --- /dev/null
> +++ b/include/hw/audio/screamer.h
> @@ -0,0 +1,42 @@
> +/*
> + * File: screamer.h
> + * Description: header file to the hw/audio/screamer.c file
> + */
> +
> +#ifndef screamer_h
> +#define screamer_h
> +
> +#include <inttypes.h>
> +#include "audio/audio.h"
> +#include "hw/ppc/mac_dbdma.h"
> +
> +#define TYPE_SCREAMER "screamer"
> +#define SCREAMER(obj) OBJECT_CHECK(ScreamerState, (obj), =
TYPE_SCREAMER)
> +#define SOUND_CHIP_NAME "Screamer Sound Chip"
> +#define MAX_BUFFER_SIZE (128 * 64)
> +
> +typedef struct ScreamerState {
> +    SysBusDevice parent_obj;
> +    uint16_t awacs[8]; /* Shadow/awacs registers */
> +    uint32_t sound_control;
> +    uint32_t codec_control;
> +    uint32_t codec_status;
> +    uint32_t clip_count;
> +    uint32_t byte_swap;
> +    uint32_t frame_count;
> +    SWVoiceOut *speaker_voice;
> +    DBDMAState *dbdma;
> +    qemu_irq dma_send_irq;
> +    qemu_irq dma_receive_irq;
> +    qemu_irq irq;
> +    QEMUSoundCard card;
> +    MemoryRegion io_memory_region;
> +    uint8_t spk_buffer[MAX_BUFFER_SIZE];
> +    uint16_t spk_buffer_position, spk_play_position;
> +    DBDMA_io dma_io;
> +} ScreamerState;
> +
> +void screamer_register_dma_functions(ScreamerState *s, void *dbdma,
> +                                     int send_channel, int =
receive_channel);
> +
> +#endif /* screamer_h */
> diff --git a/include/hw/misc/macio/macio.h =
b/include/hw/misc/macio/macio.h
> index 070a694eb5..81ad552d61 100644
> --- a/include/hw/misc/macio/macio.h
> +++ b/include/hw/misc/macio/macio.h
> @@ -35,6 +35,7 @@
>  #include "hw/ppc/mac.h"
>  #include "hw/ppc/mac_dbdma.h"
>  #include "hw/ppc/openpic.h"
> +#include "hw/audio/screamer.h"
>=20
>  /* MacIO virtual bus */
>  #define TYPE_MACIO_BUS "macio-bus"
> @@ -86,6 +87,7 @@ typedef struct MacIOState {
>      PMUState pmu;
>      DBDMAState dbdma;
>      ESCCState escc;
> +    ScreamerState screamer;
>      uint64_t frequency;
>  } MacIOState;
>=20
> --=20
> 2.14.3 (Apple Git-98)
>=20
> Hi,=20
>=20
> This patch will not compile without errors. Host is Fedora 31.
> The compiler suggests changing lines 839, 842 and 878 in screamer.c so =
the DPRINTF arguments use %lu instead of %llu.
> With that fixed, compiling completes succesfully.=20
>=20
> Best,
> Howard

Hi Howard, could you test out this patch for me on Fedora 31? It is to =
be applied over the v3 patch.

Thank you.

---
 hw/audio/screamer.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/hw/audio/screamer.c b/hw/audio/screamer.c
index ad4aba12eb..7de17fe8a6 100644
--- a/hw/audio/screamer.c
+++ b/hw/audio/screamer.c
@@ -14,7 +14,7 @@
 #include "migration/vmstate.h"
 #include "include/hw/audio/screamer.h"
=20
-#define DEBUG_SCREAMER 0
+#define DEBUG_SCREAMER 1
 #define DPRINTF(fmt, ...) \
 do { if (DEBUG_SCREAMER) { printf(fmt , ## __VA_ARGS__); } } while (0)
=20
@@ -836,11 +836,12 @@ static uint64_t screamer_mmio_read(void *opaque, =
hwaddr addr, unsigned size)
         return_value =3D get_frame_count_reg(state);
         break;
     default:
-        DPRINTF("Unknown register read - addr:%llu\tsize:%d\n", addr, =
size);
+        DPRINTF("Unknown register read - addr:%" HWADDR_PRIx =
"\tsize:%d\n",
+                addr, size);
         return_value =3D 12021981; /* Value used for debugging purposes =
*/
     }
-    DPRINTF("screamer_mmio_read() called addr: %llu  size: %d", addr >> =
4,
-            size);
+    DPRINTF("screamer_mmio_read() called addr: %" HWADDR_PRIx "  size: =
%d",
+            addr >> 4, size);
     DPRINTF("  returning 0x%x\n", return_value);
     return return_value;
 }
@@ -875,7 +876,8 @@ static void screamer_mmio_write(void *opaque, hwaddr =
addr, uint64_t raw_value,
         set_frame_count_reg(state, value);
         break;
     default:
-        DPRINTF("Unknown register write - addr:%llu\tvalue:%d\n", addr, =
value);
+        DPRINTF("Unknown register write - addr:%" HWADDR_PRIx =
"\tvalue:%d\n",
+                addr, value);
     }
 }
=20
--=20
2.14.3 (Apple Git-98)





