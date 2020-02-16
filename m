Return-Path: <SRS0=HvqS=4E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F64C3B1BF
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2020 19:58:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F6BF2084E
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2020 19:58:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qad7OITW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F6BF2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3Q3m-0003vr-Kx
	for qemu-devel@archiver.kernel.org; Sun, 16 Feb 2020 14:58:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36027)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <hsp.cat7@gmail.com>) id 1j3Q2v-0003Cg-Ji
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 14:57:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <hsp.cat7@gmail.com>) id 1j3Q2o-0000Lx-T8
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 14:57:41 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:38060)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <hsp.cat7@gmail.com>)
 id 1j3Q2o-0000KR-HO; Sun, 16 Feb 2020 14:57:34 -0500
Received: by mail-oi1-x243.google.com with SMTP id l9so14758123oii.5;
 Sun, 16 Feb 2020 11:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=L+9+x8nfq/bW2xfY8vhrqjGAC2nHvH3l74bQSE/UWic=;
 b=qad7OITW8DBwULNvY89jrN6CG3LbLn1+ifKQZsCy0wWt9f/nYJY8HwyMWx/jXdrD/s
 RtHq2ytJ2Nx8sKwX7lswBLkuEau1JILE4bbF1nG/bqX4SOy+iI1Sk3BqLYQ3SmyNSVLF
 S2p0FOf1mQBcqijuCEs/JZRjFfVo0YdyHGPKAi28/qA3zdUlbBpCbyjhzXXeE4XHs7yR
 MDhfX6UtQ/xR+xLbm3Sy3UuCrq//rteroZ8SMMiwsYtee139OZ3LyAlZlniOxTCrDJaX
 IkGr2Dph94CnsfIrymWPFEJ+og8pwj99Qo1XYlgt8P1h8Y6C1ddOCQJwMHgZwfe9sJRS
 4aKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=L+9+x8nfq/bW2xfY8vhrqjGAC2nHvH3l74bQSE/UWic=;
 b=emJYS3APdQHufE6rb/LGZ7SGgruqL7635uTBDqQdkJ2b+Et9mZ9QaTjSuEwxg9BWnR
 yyPxm+4PMCturea55NTfxmqnk+mlMJHNVkUcrW4bknnq5aXYzgaS1Dz4vzDWbPdSfUZ4
 b7to/Db6/K4RAqnX3yNP10ltqegVElfil/FC9txJE+3skYqOYhmtvl++KpEdExsrju2t
 2YVDC9ccxExohti2xBZAPHifx1h0Yyka9vLXSgjFF/4S08io3BaoTJJikwo31EG8tXxc
 7/9+QkfPAw8otqPyfltxIAGlevyGiQMrSJLRol9eg2gFjlLptgOpAUpcgitNzaaVPhK+
 Q4zg==
X-Gm-Message-State: APjAAAXvOUb4RGURNG+kAbe1iP1meorcwCites6T5UUyfJTrv1LX2Ol6
 c8Xu9uMrwYo/h2UZTlFwZKuBXJDSN2ZvOQM69jc=
X-Google-Smtp-Source: APXvYqw/P7vToc+PlxhgqaYjmdy77vuw0oOBM66C7zDbHm97emyGpwhsodOswsQTirrSfE+kyZPIFzGlXVD3cjm94/U=
X-Received: by 2002:a05:6808:3ba:: with SMTP id
 n26mr8187820oie.62.1581883053027; 
 Sun, 16 Feb 2020 11:57:33 -0800 (PST)
MIME-Version: 1.0
References: <20200216163216.10745-1-programmingkidx@gmail.com>
In-Reply-To: <20200216163216.10745-1-programmingkidx@gmail.com>
From: Howard Spoelstra <hsp.cat7@gmail.com>
Date: Sun, 16 Feb 2020 20:57:22 +0100
Message-ID: <CABLmASF=9Qj0_Hh2SWO6K=Sou3mVeyLL+XXTn9WGc670KRn2AA@mail.gmail.com>
Subject: Re: [PATCH v3] Implement the Screamer sound chip for the mac99
 machine type
To: John Arbuckle <programmingkidx@gmail.com>
Content-Type: multipart/alternative; boundary="00000000000073b667059eb6d963"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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

--00000000000073b667059eb6d963
Content-Type: text/plain; charset="UTF-8"

On Sun, Feb 16, 2020 at 5:32 PM John Arbuckle <programmingkidx@gmail.com>
wrote:

> Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
> ---
> v3 changes:
> - Updated the location of patched code in hw/ppc/kconfig.
> - Removed setting the props variable in screamer.c.
> - Removed the screamer_properties variable in screamer.c.
>
> v2 changes:
> - Fixed a bug that prevented the sampling rate from being changed.
>
>  hw/audio/Kconfig              |   3 +
>  hw/audio/Makefile.objs        |   2 +
>  hw/audio/screamer.c           | 983
> ++++++++++++++++++++++++++++++++++++++++++
>  hw/misc/macio/macio.c         |  35 +-
>  hw/ppc/Kconfig                |   1 +
>  hw/ppc/mac.h                  |   5 +
>  include/hw/audio/screamer.h   |  42 ++
>  include/hw/misc/macio/macio.h |   2 +
>  8 files changed, 1072 insertions(+), 1 deletion(-)
>  create mode 100644 hw/audio/screamer.c
>  create mode 100644 include/hw/audio/screamer.h
>
> diff --git a/hw/audio/Kconfig b/hw/audio/Kconfig
> index e9c6fed826..196da6c3fe 100644
> --- a/hw/audio/Kconfig
> +++ b/hw/audio/Kconfig
> @@ -50,3 +50,6 @@ config CS4231
>
>  config MARVELL_88W8618
>      bool
> +
> +config SCREAMER
> +    bool
> diff --git a/hw/audio/Makefile.objs b/hw/audio/Makefile.objs
> index 63db383709..55906886bc 100644
> --- a/hw/audio/Makefile.objs
> +++ b/hw/audio/Makefile.objs
> @@ -15,4 +15,6 @@ common-obj-$(CONFIG_CS4231) += cs4231.o
>  common-obj-$(CONFIG_MARVELL_88W8618) += marvell_88w8618.o
>  common-obj-$(CONFIG_MILKYMIST) += milkymist-ac97.o
>
> +common-obj-$(CONFIG_SCREAMER) += screamer.o
> +
>  common-obj-y += soundhw.o
> diff --git a/hw/audio/screamer.c b/hw/audio/screamer.c
> new file mode 100644
> index 0000000000..ad4aba12eb
> --- /dev/null
> +++ b/hw/audio/screamer.c
> @@ -0,0 +1,983 @@
> +/*
> + * File: Screamer.c
> + * Description: Implement the Screamer sound chip used in Apple
> Macintoshes.
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
> +do { if (DEBUG_SCREAMER) { printf(fmt , ## __VA_ARGS__); } } while (0)
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
> +    return_value = (value >> 12) & 0x00000fff;
> +    return return_value;
> +}
> +
> +
> +static uint32_t get_sound_control_reg(ScreamerState *s)
> +{
> +    DPRINTF("%s() called - returned 0x%x\n", __func__, s->sound_control);
> +    return s->sound_control;
> +}
> +
> +/* The AWACS registers are accessed thru this register */
> +static uint32_t get_codec_control_reg(ScreamerState *s)
> +{
> +    int awacs_register = get_codec_control_address(s->codec_control);
> +    uint32_t return_value = s->awacs[awacs_register];
> +    return_value = set_busy_bit(return_value, 0); /* Tell CPU we are
> ready */
> +    DPRINTF("%s() called - returned 0x%x\tAWACS register: %d\n", __func__,
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
> +        int awacs_register = (s->awacs[7] & 0xe) >> 1;
> +        s->awacs[7] = s->awacs[7] & 0xfffffffe; /* turn off readback mode
> */
> +        return_value = s->awacs[awacs_register] << 4;
> +        DPRINTF("readback enable bit is set, returning AWACS register
> %d\t"
> +                "value:0x%x\n", awacs_register, return_value);
> +
> +        return return_value;
> +    }
> +
> +    /* Tell CPU we are ready */
> +    return_value = set_part_ready_bit(s->codec_status, 1);
> +
> +    /* Set Revision to Screamer */
> +    return_value = set_revision(return_value);
> +
> +    /* Set the Manufacturer to Crystal */
> +    return_value = set_manufacturer(return_value);
> +    DPRINTF("%s() called - returned 0x%x\n", __func__, return_value);
> +
> +    return return_value;
> +}
> +
> +static uint32_t get_clip_count_reg(ScreamerState *s)
> +{
> +    DPRINTF("%s() called - returned 0x%x\n", __func__, s->clip_count);
> +    uint32_t return_value;
> +    return_value = s->clip_count;
> +    /* This is reset everytime it is read */
> +    s->clip_count = 0;
> +    return return_value;
> +}
> +
> +static uint32_t get_byte_swap_reg(ScreamerState *s)
> +{
> +    DPRINTF("%s() called - returned 0x%x\n", __func__, s->byte_swap);
> +    /*
> +     * If all you hear is noise, it could be this register reporting the
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
> +    DPRINTF("%s() called - returned 0x%x\n", __func__, s->frame_count);
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
> + * If the audio is playing back too fast or too slow, this function may
> be the
> + * cause.
> + */
> +static int get_sampling_rate(ScreamerState *s)
> +{
> +    uint32_t screamer_rate = s->sound_control & 0x700;
> +    int return_value;
> +
> +    /* All return values are in Hertz */
> +    switch (screamer_rate) {
> +    case 0x0:
> +        return_value = 44100;
> +        break;
> +    case 0x100:
> +        return_value = 29400;
> +        break;
> +    case 0x200:
> +        return_value = 22050;
> +        break;
> +    case 0x300:
> +        return_value = 17640;
> +        break;
> +    case 0x400:
> +        return_value = 14700;
> +        break;
> +    case 0x500:
> +        return_value = 11025;
> +        break;
> +    case 0x600:
> +        return_value = 8820;
> +        break;
> +    case 0x700:
> +        return_value = 7350;
> +        break;
> +    default:
> +        DPRINTF("get_sampling_rate() unknown value: 0x%x\nDefaulting to"
> +                " 44100 Hz.\n", screamer_rate);
> +        return 44100;
> +}
> +    DPRINTF("%s() called - returning %dHz\n", __func__, return_value);
> +    return return_value;
> +}
> +
> +/**************************** End of getters *************************/
> +
> +/***************************** Speaker call back
> *************************/
> +
> +/* resets the play and buffer position markers */
> +static void reset_markers(ScreamerState *s)
> +{
> +    s->spk_play_position = 0;
> +    s->spk_buffer_position = 0;
> +}
> +
> +
> +/* Sends the samples to the host for playing */
> +static void send_samples_to_host(ScreamerState *s, int max_samples)
> +{
> +    int write_length, requested_length;
> +    requested_length = MIN(max_samples, (s->spk_buffer_position -
> +                                         s->spk_play_position));
> +    write_length = AUD_write(s->speaker_voice,
> +                             &s->spk_buffer[s->spk_play_position],
> +                             requested_length);
> +    DPRINTF("requested length: %d\twrite length: %d\t",
> +            requested_length, write_length);
> +    s->spk_play_position += write_length;
> +    DPRINTF("AUD_write %d/%d\n", s->spk_play_position,
> s->spk_buffer_position);
> +    s->frame_count += write_length;
> +}
> +
> +
> +/*
> + * Called by QEMU's audio system to tell the output backend to send
> samples
> + * from the buffer to the host sound system.
> + * opaque: a pointer to the ScreamerState instance.
> + * max_samples: the number of samples that can be sent to the hardware
> buffer.
> + */
> +static void speaker_callback(void *opaque, int max_samples)
> +{
> +    ScreamerState *s = (ScreamerState *) opaque;
> +
> +    /* if we have more samples to play */
> +    if (s->spk_buffer_position > 0) {
> +        if (s->spk_buffer_position > s->spk_play_position) {
> +            DPRINTF("%s() called - max_samples: %d\n", __func__,
> max_samples);
> +            send_samples_to_host(s, max_samples);
> +        }
> +        if (s->spk_play_position >= s->spk_buffer_position) {
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
> +/************************* End of speaker call back
> *************************/
> +
> +
> +/* Opens the speaker's voice */
> +static void open_speaker_voice(ScreamerState *s)
> +{
> +    DPRINTF("%s() called\n", __func__);
> +
> +    /* if voice is already open return from function */
> +    if (s->speaker_voice != NULL) {
> +        DPRINTF("closing speaker voice\n");
> +        AUD_close_out(&s->card, s->speaker_voice);
> +        s->speaker_voice = NULL;
> +    }
> +    struct audsettings audio_settings;
> +    audio_settings.freq = get_sampling_rate(s);  /* in hertz */
> +    audio_settings.nchannels = 2;                /* stereo output */
> +    audio_settings.fmt = AUDIO_FORMAT_S16;       /* signed 16 bit */
> +    audio_settings.endianness = get_byte_swap_reg(s); /* endianness */
> +    s->speaker_voice = AUD_open_out(&s->card, s->speaker_voice,
> SOUND_CHIP_NAME
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
> +/******************************* Setters
> *************************************/
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
> +/* Return value: 1 = muted  0 = not muted */
> +static int is_muted(ScreamerState *s)
> +{
> +    int mute_state = s->awacs[1] & SPEAKER_MUTE ? 1 : 0;
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
> +    int should_mute = is_muted(s);
> +
> +    /* Get Screamer volume values */
> +    uint8_t left_vol = get_left_vol(s->awacs[4]);
> +    uint8_t right_vol = get_right_vol(s->awacs[4]);
> +    DPRINTF("set_volume() called - M:%d\tL:%d\tR:%d\n", should_mute,
> left_vol,
> +            right_vol);
> +
> +    /* Convert Screamer to QEMU volume values */
> +    left_vol = screamer_to_qemu_volume(left_vol);
> +    right_vol = screamer_to_qemu_volume(right_vol);
> +    DPRINTF("QEMU volume: L:%d\tR:%d\n", left_vol, right_vol);
> +    AUD_set_volume_out(s->speaker_voice, should_mute, left_vol,
> right_vol);
> +}
> +
> +
> +/* Sets the sound control register */
> +static void set_sound_control_reg(ScreamerState *s, uint32_t value)
> +{
> +    DPRINTF("set_sound_control_reg() called - value: 0x%x\n", value);
> +    s->sound_control = value;
> +    set_QEMU_audio_settings(s);
> +}
> +
> +
> +/* Used for input gain only - can be ignored for now. */
> +static void set_awacs_0_reg(ScreamerState *s, uint32_t new_value)
> +{
> +    DPRINTF("Settings AWACS register 0 to 0x%x\n", s->awacs[0]);
> +    s->awacs[0] = new_value;
> +}
> +
> +
> +static void set_awacs_1_reg(ScreamerState *s, uint32_t new_value)
> +{
> +    DPRINTF("Settings AWACS register 1 to 0x%x\n", new_value);
> +
> +    s->awacs[1] = new_value;
> +
> +    /* If recalibration requested */
> +    if (new_value & RECALIBRATE) {
> +        DPRINTF("Recalibration requested - unimplemented\n");
> +        new_value = new_value ^ RECALIBRATE; /* Turn off recalibrate bit
> */
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
> +        DPRINTF("parallel port enabled - but no parallel port here\n");
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
> +    s->awacs[2] = new_value;
> +}
> +
> +
> +/* Unknown register purpose */
> +static void set_awacs_3_reg(ScreamerState *s, uint32_t new_value)
> +{
> +    DPRINTF("Settings AWACS register 3 to 0x%x\n"
> +            "This register has an unknown purpose and does not do
> anything\n",
> +            s->awacs[3]);
> +    s->awacs[3] = new_value;
> +}
> +
> +
> +/* Mostly deals with speaker volume */
> +static void set_awacs_4_reg(ScreamerState *s, uint32_t new_value)
> +{
> +    DPRINTF("AWACS register 4 write: 0x%x\n", new_value);
> +    s->awacs[4] = new_value;
> +    set_volume(s);
> +}
> +
> +
> +/* This register is about loop thru stuff I don't understand */
> +static void set_awacs_5_reg(ScreamerState *s, uint32_t new_value)
> +{
> +    DPRINTF("Settings AWACS register 5 to 0x%x\n"
> +            "Loop thru update ignored.\n", s->awacs[5]);
> +    s->awacs[5] = new_value;
> +}
> +
> +
> +/* Prints the states of the AWACS power register */
> +static void print_power_reg_values(uint32_t value)
> +{
> +    if ((value & 0x3) == 0) {
> +        printf("Screamer run state set\n");
> +    }
> +    if ((value & 0x3) == 1) {
> +        printf("Screamer doze state set\n");
> +    }
> +    if ((value & 0x3) == 2) {
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
> +    s->awacs[6] = new_value;
> +}
> +
> +
> +/* Read Back - repeating something that was sent to this chip? */
> +static void set_awacs_7_reg(ScreamerState *s, uint32_t new_value)
> +{
> +    DPRINTF("Settings AWACS register 7 to 0x%x\n", new_value);
> +    s->awacs[7] = new_value;
> +}
> +
> +
> +/* Sets the AWACs registers - a.k.a. shadow registers */
> +static void set_awacs_register(ScreamerState *s, uint32_t value)
> +{
> +    int the_register = get_codec_control_address(value);
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
> +    s->codec_control = value;
> +    set_awacs_register(s, value);
> +}
> +
> +static void set_codec_status_reg(ScreamerState *s, uint32_t value)
> +{
> +    DPRINTF("set_codec_status_reg() called - value: 0x%x\n", value);
> +    s->codec_status = value;
> +}
> +
> +static void set_clip_count_reg(ScreamerState *s, uint32_t new_value)
> +{
> +    DPRINTF("set_clip_count_reg() called - value: 0x%x\n", new_value);
> +    s->clip_count = new_value;
> +}
> +
> +static void set_byte_swap_reg(ScreamerState *s, uint32_t value)
> +{
> +    DPRINTF("set_byte_swap_reg() called - value: 0x%x\n", value);
> +    s->byte_swap = value;
> +}
> +
> +static void set_frame_count_reg(ScreamerState *s, uint32_t new_value)
> +{
> +    DPRINTF("%s() called - value: 0x%x\n", __func__, new_value);
> +    s->frame_count = new_value;
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
> +    const int busy_bit = 0x01000000;
> +    uint32_t return_value;
> +    if (bit_value == 1)  /* Set this bit */
> +        return_value = (value | busy_bit);
> +    else /* bit_value == 0  Disable this bit */
> +        return_value = (value & ~busy_bit);
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
> +    const int part_ready_bit = 0x00400000;
> +    uint32_t return_value;
> +    if (bit_value == 1)  /* Set this bit */
> +        return_value = (value | part_ready_bit);
> +    else /* bit_value == 0  Disable this bit */
> +        return_value = (value & ~part_ready_bit);
> +    return return_value;
> +}
> +
> +/* Sets bits 12 and 13 to 1 to indicate the Screamer revision */
> +static uint32_t set_revision(uint32_t input_value)
> +{
> +    uint32_t return_value;
> +    return_value = input_value | 0x3000;
> +    return return_value;
> +}
> +
> +/* Sets bit 8 to indicate Crystal as the manufacturer */
> +static uint32_t set_manufacturer(uint32_t input_value)
> +{
> +    uint32_t return_value;
> +    return_value = input_value | 0x100;
> +    return return_value;
> +}
> +
> +
> +/************************** End of Setters
> *********************************/
> +
> +
> +/*************************** DMA functions
> *********************************/
> +
> +/*
> + * Sends audio samples from a microphone or line-in to memory.
> + * Used for sound input.
> + * Currently only prevents a deadlock condition with Mac OS 9.
> + */
> +static void screamer_to_dma(DBDMA_io *io)
> +{
> +    DPRINTF("%s() called\n", __func__);
> +    ScreamerState *s = (ScreamerState *)io->opaque;
> +    DBDMAState *dbs = s->dbdma;
> +    DBDMA_channel *ch = &dbs->channels[0x12];
> +    ch->regs[DBDMA_STATUS] |= DEAD;
> +    ch->regs[DBDMA_STATUS] &= ~ACTIVE;
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
> +    DBDMA_channel *ch = io->channel;
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
> +    if (ch->io.processing == true) {
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
> +    io->len = 0;
> +    io->dma_end(io);
> +}
> +
> +
> +/* Adds sample data to the buffer */
> +static void add_to_speaker_buffer(DBDMA_io *io)
> +{
> +    ScreamerState *s = (ScreamerState *) io->opaque;
> +
> +    if (s->spk_buffer_position + io->len > MAX_BUFFER_SIZE) {
> +        /* postpone calling these samples until the buffer has been
> emptied */
> +        memcpy(&s->dma_io, io, sizeof(DBDMA_io));
> +        return;
> +    }
> +    dma_memory_read(&address_space_memory, io->addr,
> +                    &s->spk_buffer[s->spk_buffer_position], io->len);
> +    s->spk_buffer_position += io->len;
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
> + * This will flush the audio buffer of previous audio - eliminating
> previous
> + * audio playback.
> + */
> +static void send_silence_to_speaker(ScreamerState *s)
> +{
> +    DPRINTF("Silencing audio buffer...\n");
> +    int length = MAX_BUFFER_SIZE;
> +    s->spk_buffer_position = length;
> +    s->spk_play_position = 0;
> +    memset(s->spk_buffer, 0, length);
> +    s->dma_io.len = 0; /* stop any postponed samples from playing */
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
> +    ScreamerState *s = (ScreamerState *)io->opaque;
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
> +                                   int send_channel, int receive_channel)
> +{
> +    DPRINTF("%s() called\n", __func__);
> +    DPRINTF("send channel: %d\treceive channel: %d\n", send_channel,
> +           receive_channel);
> +    s->dbdma = dbdma;
> +
> +    /* Setup the DMA send system */
> +    DBDMA_register_channel(s->dbdma, send_channel, s->dma_send_irq,
> +                           dma_to_screamer, dma_send_flush, s);
> +
> +    /* Setup the DMA receive system */
> +    DBDMA_register_channel(s->dbdma, receive_channel, s->dma_receive_irq,
> +                           screamer_to_dma, dma_receive_flush, s);
> +}
> +
> +/************************* End of DMA functions
> **************************/
> +
> +/* Resets this sound chip */
> +static void screamer_reset(DeviceState *d)
> +{
> +    DPRINTF("screamer_reset() called\n");
> +    ScreamerState *s = SCREAMER(d);
> +    set_sound_control_reg(s, 0);
> +    set_codec_control_reg(s, 0);
> +    set_codec_status_reg(s, 0);
> +    set_clip_count_reg(s, 0);
> +    set_byte_swap_reg(s, 0);
> +    set_frame_count_reg(s, 0);
> +    int i, num_awacs_regs = 8;
> +    for (i = 0; i < num_awacs_regs; i++) {
> +        s->awacs[i] = 0;
> +    }
> +    set_QEMU_audio_settings(s);
> +    reset_markers(s);
> +    s->dma_io.len = 0;
> +}
> +
> +/* Called when the CPU reads the memory addresses assigned to Screamer */
> +static uint64_t screamer_mmio_read(void *opaque, hwaddr addr, unsigned
> size)
> +{
> +    ScreamerState *state = opaque;
> +    uint32_t return_value;
> +
> +    addr = addr >> 4;
> +    switch (addr) {
> +    case SOUND_CONTROL_REG:
> +        return_value = get_sound_control_reg(state);
> +        break;
> +    case CODEC_CONTROL_REG:
> +        return_value = get_codec_control_reg(state);
> +        break;
> +    case CODEC_STATUS_REG:
> +        return_value = get_codec_status_reg(state);
> +        break;
> +    case CLIP_COUNT_REG:
> +        return_value = get_clip_count_reg(state);
> +        break;
> +    case BYTE_SWAP_REG:
> +        return_value = get_byte_swap_reg(state);
> +        break;
> +    case FRAME_COUNT_REG:
> +        return_value = get_frame_count_reg(state);
> +        break;
> +    default:
> +        DPRINTF("Unknown register read - addr:%llu\tsize:%d\n", addr,
> size);
> +        return_value = 12021981; /* Value used for debugging purposes */
> +    }
> +    DPRINTF("screamer_mmio_read() called addr: %llu  size: %d", addr >> 4,
> +            size);
> +    DPRINTF("  returning 0x%x\n", return_value);
> +    return return_value;
> +}
> +
> +
> +/* Called when the CPU writes to the memory addresses assigned to
> Screamer */
> +static void screamer_mmio_write(void *opaque, hwaddr addr, uint64_t
> raw_value,
> +                                unsigned size)
> +{
> +    DPRINTF("screamer_mmio_write() called - size: %d\n", size);
> +    ScreamerState *state = opaque;
> +    uint32_t value = raw_value & 0xffffffff;
> +    addr = addr >> 4;
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
> +        DPRINTF("Unknown register write - addr:%llu\tvalue:%d\n", addr,
> value);
> +    }
> +}
> +
> +/* Used for memory_region_init_io() for memory mapped I/O */
> +static const MemoryRegionOps screamer_ops = {
> +    .read = screamer_mmio_read,
> +    .write = screamer_mmio_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +    .valid = {
> +        .min_access_size = 4,
> +        .max_access_size = 4
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
> +    ScreamerState *s = (ScreamerState *)obj;
> +    SysBusDevice *d = SYS_BUS_DEVICE(obj);
> +    const int region_size = 5 * 32;
> +
> +    /* Makes the read and write ops work */
> +    memory_region_init_io(&s->io_memory_region, OBJECT(s),
> +                          &screamer_ops, s, SOUND_CHIP_NAME, region_size);
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
> + * When saving and restoring the state of the VM, this is used to save and
> + * restore the registers.
> + */
> +static const VMStateDescription vmstate_screamer = {
> +    .name = "Screamer",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_UINT16_ARRAY(awacs, ScreamerState, 8), /* 8 AWACS
> registers */
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
> + * Sets the class data. It is like polymorphism and inheritance in object
> + * oriented languages.
> + */
> +static void screamer_class_init(ObjectClass *class, void *data)
> +{
> +    DPRINTF("screamer_class_init() called\n");
> +    DeviceClass *dc = DEVICE_CLASS(class);
> +    dc->realize = screamer_realize;
> +    dc->reset = screamer_reset;
> +    dc->desc = "Apple Screamer";
> +    dc->vmsd = &vmstate_screamer;
> +    dc->hotpluggable = false;
> +}
> +
> +/* Used for QOM function registration */
> +static const TypeInfo screamer_info = {
> +    .name          = "screamer",
> +    .parent        = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(ScreamerState),
> +    .instance_init = screamer_init,
> +    .class_init    = screamer_class_init,
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
>
>  /* Note: this code is strongly inspirated from the corresponding code
>   * in PearPC */
> @@ -109,7 +110,10 @@ static void macio_common_realize(PCIDevice *d, Error
> **errp)
>      SysBusDevice *sysbus_dev;
>      Error *err = NULL;
>
> -    object_property_set_bool(OBJECT(&s->dbdma), true, "realized", &err);
> +    const char *realized_property = "realized";
> +    bool new_value = true;
> +    object_property_set_bool(OBJECT(&s->dbdma), new_value,
> realized_property,
> +                             &err);
>      if (err) {
>          error_propagate(errp, err);
>          return;
> @@ -117,6 +121,19 @@ static void macio_common_realize(PCIDevice *d, Error
> **errp)
>      sysbus_dev = SYS_BUS_DEVICE(&s->dbdma);
>      memory_region_add_subregion(&s->bar, 0x08000,
>                                  sysbus_mmio_get_region(sysbus_dev, 0));
> +    object_property_set_bool(OBJECT(&s->screamer), true, "realized",
> &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
> +
> +    /* Add the screamer sound chip */
> +    sysbus_dev = SYS_BUS_DEVICE(&s->screamer);
> +    const int offset = 0x14000; /* Offset from base address register
> (bar) */
> +    const int region_number = 0; /* which memory region to use */
> +    memory_region_add_subregion(&s->bar, offset,
> +                                sysbus_mmio_get_region(sysbus_dev,
> +                                                       region_number));
>
>      qdev_prop_set_uint32(DEVICE(&s->escc), "disabled", 0);
>      qdev_prop_set_uint32(DEVICE(&s->escc), "frequency", ESCC_CLOCK);
> @@ -386,6 +403,19 @@ static void macio_newworld_realize(PCIDevice *d,
> Error **errp)
>          memory_region_add_subregion(&s->bar, 0x16000,
>                                      sysbus_mmio_get_region(sysbus_dev,
> 0));
>      }
> +
> +    /* Screamer Sound Chip */
> +    const int gpio_0 = 0;
> +    const int gpio_1 = 1;
> +    const int transmit_channel = 0x10;
> +    const int receive_channel = 0x12;
> +    sysbus_dev = SYS_BUS_DEVICE(&s->screamer);
> +    sysbus_connect_irq(sysbus_dev, gpio_0, qdev_get_gpio_in(pic_dev,
> +                                           NEWWORLD_SCREAMER_IRQ));
> +    sysbus_connect_irq(sysbus_dev, gpio_1, qdev_get_gpio_in(pic_dev,
> +                                           NEWWORLD_SCREAMER_DMA_IRQ));
> +    screamer_register_dma_functions(SCREAMER(sysbus_dev), &s->dbdma,
> +                                    transmit_channel, receive_channel);
>  }
>
>  static void macio_newworld_init(Object *obj)
> @@ -420,6 +450,9 @@ static void macio_instance_init(Object *obj)
>                           TYPE_MAC_DBDMA);
>
>      macio_init_child_obj(s, "escc", &s->escc, sizeof(s->escc), TYPE_ESCC);
> +
> +    macio_init_child_obj(s, SOUND_CHIP_NAME, &s->screamer,
> sizeof(s->screamer),
> +                         TYPE_SCREAMER);
>  }
>
>  static const VMStateDescription vmstate_macio_oldworld = {
> diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
> index 354828bf13..4ffc3a1c16 100644
> --- a/hw/ppc/Kconfig
> +++ b/hw/ppc/Kconfig
> @@ -104,6 +104,7 @@ config MAC_NEWWORLD
>      select MAC_PMU
>      select UNIN_PCI
>      select FW_CFG_PPC
> +    select SCREAMER
>
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
>
>  /* SMP is not enabled, for now */
>  #define MAX_CPUS 1
> @@ -68,6 +70,9 @@
>  #define NEWWORLD_IDE1_DMA_IRQ  0x3
>  #define NEWWORLD_EXTING_GPIO1  0x2f
>  #define NEWWORLD_EXTING_GPIO9  0x37
> +#define NEWWORLD_SCREAMER_IRQ  0x18
> +#define NEWWORLD_SCREAMER_DMA_IRQ 0x9
> +#define NEWWORLD_SCREAMER_RX_IRQ 0xa
>
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
> +#define SCREAMER(obj) OBJECT_CHECK(ScreamerState, (obj), TYPE_SCREAMER)
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
> +                                     int send_channel, int
> receive_channel);
> +
> +#endif /* screamer_h */
> diff --git a/include/hw/misc/macio/macio.h b/include/hw/misc/macio/macio.h
> index 070a694eb5..81ad552d61 100644
> --- a/include/hw/misc/macio/macio.h
> +++ b/include/hw/misc/macio/macio.h
> @@ -35,6 +35,7 @@
>  #include "hw/ppc/mac.h"
>  #include "hw/ppc/mac_dbdma.h"
>  #include "hw/ppc/openpic.h"
> +#include "hw/audio/screamer.h"
>
>  /* MacIO virtual bus */
>  #define TYPE_MACIO_BUS "macio-bus"
> @@ -86,6 +87,7 @@ typedef struct MacIOState {
>      PMUState pmu;
>      DBDMAState dbdma;
>      ESCCState escc;
> +    ScreamerState screamer;
>      uint64_t frequency;
>  } MacIOState;
>
> --
> 2.14.3 (Apple Git-98)
>
> Hi,

This patch will not compile without errors. Host is Fedora 31.
The compiler suggests changing lines 839, 842 and 878 in screamer.c so the
DPRINTF arguments use %lu instead of %llu.
With that fixed, compiling completes succesfully.

Best,
Howard

--00000000000073b667059eb6d963
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><div dir=3D"ltr"><br></div><br>=
<div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Sun, Fe=
b 16, 2020 at 5:32 PM John Arbuckle &lt;<a href=3D"mailto:programmingkidx@g=
mail.com">programmingkidx@gmail.com</a>&gt; wrote:<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">Signed-off-by: John Arbuckle &lt;<a href=
=3D"mailto:programmingkidx@gmail.com" target=3D"_blank">programmingkidx@gma=
il.com</a>&gt;<br>
---<br>
v3 changes:<br>
- Updated the location of patched code in hw/ppc/kconfig.<br>
- Removed setting the props variable in screamer.c.<br>
- Removed the screamer_properties variable in screamer.c.<br>
<br>
v2 changes:<br>
- Fixed a bug that prevented the sampling rate from being changed.<br>
<br>
=C2=A0hw/audio/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 =C2=A03 +<br>
=C2=A0hw/audio/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +<b=
r>
=C2=A0hw/audio/screamer.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 983 +++=
+++++++++++++++++++++++++++++++++++++++<br>
=C2=A0hw/misc/macio/macio.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 35 +-<=
br>
=C2=A0hw/ppc/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 |=C2=A0 =C2=A01 +<br>
=C2=A0hw/ppc/mac.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 =C2=A05 +<br>
=C2=A0include/hw/audio/screamer.h=C2=A0 =C2=A0|=C2=A0 42 ++<br>
=C2=A0include/hw/misc/macio/macio.h |=C2=A0 =C2=A02 +<br>
=C2=A08 files changed, 1072 insertions(+), 1 deletion(-)<br>
=C2=A0create mode 100644 hw/audio/screamer.c<br>
=C2=A0create mode 100644 include/hw/audio/screamer.h<br>
<br>
diff --git a/hw/audio/Kconfig b/hw/audio/Kconfig<br>
index e9c6fed826..196da6c3fe 100644<br>
--- a/hw/audio/Kconfig<br>
+++ b/hw/audio/Kconfig<br>
@@ -50,3 +50,6 @@ config CS4231<br>
<br>
=C2=A0config MARVELL_88W8618<br>
=C2=A0 =C2=A0 =C2=A0bool<br>
+<br>
+config SCREAMER<br>
+=C2=A0 =C2=A0 bool<br>
diff --git a/hw/audio/Makefile.objs b/hw/audio/Makefile.objs<br>
index 63db383709..55906886bc 100644<br>
--- a/hw/audio/Makefile.objs<br>
+++ b/hw/audio/Makefile.objs<br>
@@ -15,4 +15,6 @@ common-obj-$(CONFIG_CS4231) +=3D cs4231.o<br>
=C2=A0common-obj-$(CONFIG_MARVELL_88W8618) +=3D marvell_88w8618.o<br>
=C2=A0common-obj-$(CONFIG_MILKYMIST) +=3D milkymist-ac97.o<br>
<br>
+common-obj-$(CONFIG_SCREAMER) +=3D screamer.o<br>
+<br>
=C2=A0common-obj-y +=3D soundhw.o<br>
diff --git a/hw/audio/screamer.c b/hw/audio/screamer.c<br>
new file mode 100644<br>
index 0000000000..ad4aba12eb<br>
--- /dev/null<br>
+++ b/hw/audio/screamer.c<br>
@@ -0,0 +1,983 @@<br>
+/*<br>
+ * File: Screamer.c<br>
+ * Description: Implement the Screamer sound chip used in Apple Macintoshe=
s.<br>
+ * It works by filling a buffer, then playing the buffer.<br>
+ */<br>
+<br>
+#include &quot;qemu/osdep.h&quot;<br>
+#include &quot;audio/audio.h&quot;<br>
+#include &quot;hw/hw.h&quot;<br>
+#include &quot;hw/irq.h&quot;<br>
+#include &lt;inttypes.h&gt;<br>
+#include &quot;hw/ppc/mac.h&quot;<br>
+#include &quot;hw/qdev-properties.h&quot;<br>
+#include &quot;migration/vmstate.h&quot;<br>
+#include &quot;include/hw/audio/screamer.h&quot;<br>
+<br>
+#define DEBUG_SCREAMER 0<br>
+#define DPRINTF(fmt, ...) \<br>
+do { if (DEBUG_SCREAMER) { printf(fmt , ## __VA_ARGS__); } } while (0)<br>
+<br>
+#define SOUND_CONTROL_REG=C2=A0 0<br>
+#define CODEC_CONTROL_REG=C2=A0 1<br>
+#define CODEC_STATUS_REG=C2=A0 =C2=A02<br>
+#define CLIP_COUNT_REG=C2=A0 =C2=A0 =C2=A03<br>
+#define BYTE_SWAP_REG=C2=A0 =C2=A0 =C2=A0 4<br>
+#define FRAME_COUNT_REG=C2=A0 =C2=A0 5<br>
+<br>
+#define AWACS_BUSY=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x01000000<br>
+<br>
+/* Used with AWACS register 1 */<br>
+#define RECALIBRATE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x004<br>
+#define LOOPTHRU=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x040<br>
+#define SPEAKER_MUTE=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x080<br>
+#define HEADPHONE_MUTE=C2=A0 =C2=A0 =C2=A0 0x200<br>
+#define OUTPUT_ZERO=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x400<br>
+#define OUTPUT_ONE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x800<br>
+#define PARALLEL_OUTPUT=C2=A0 =C2=A0 =C2=A00xc00<br>
+<br>
+/* Function prototypes */<br>
+static uint32_t set_busy_bit(uint32_t value, int bit);<br>
+static uint32_t set_part_ready_bit(uint32_t value, int bit_value);<br>
+static uint32_t set_revision(uint32_t input_value);<br>
+static uint32_t set_manufacturer(uint32_t input_value);<br>
+static int get_sampling_rate(ScreamerState *s);<br>
+static uint32_t get_frame_count_reg(ScreamerState *s);<br>
+static void add_to_speaker_buffer(DBDMA_io *io);<br>
+static void dma_request(DBDMA_io *io);<br>
+<br>
+<br>
+/**************************** Getters *************************/<br>
+<br>
+/* Returns the codec control register&#39;s encoded AWACS address */<br>
+static uint8_t get_codec_control_address(uint32_t value)<br>
+{<br>
+=C2=A0 =C2=A0 uint8_t return_value;<br>
+=C2=A0 =C2=A0 return_value =3D (value &gt;&gt; 12) &amp; 0x00000fff;<br>
+=C2=A0 =C2=A0 return return_value;<br>
+}<br>
+<br>
+<br>
+static uint32_t get_sound_control_reg(ScreamerState *s)<br>
+{<br>
+=C2=A0 =C2=A0 DPRINTF(&quot;%s() called - returned 0x%x\n&quot;, __func__,=
 s-&gt;sound_control);<br>
+=C2=A0 =C2=A0 return s-&gt;sound_control;<br>
+}<br>
+<br>
+/* The AWACS registers are accessed thru this register */<br>
+static uint32_t get_codec_control_reg(ScreamerState *s)<br>
+{<br>
+=C2=A0 =C2=A0 int awacs_register =3D get_codec_control_address(s-&gt;codec=
_control);<br>
+=C2=A0 =C2=A0 uint32_t return_value =3D s-&gt;awacs[awacs_register];<br>
+=C2=A0 =C2=A0 return_value =3D set_busy_bit(return_value, 0); /* Tell CPU =
we are ready */<br>
+=C2=A0 =C2=A0 DPRINTF(&quot;%s() called - returned 0x%x\tAWACS register: %=
d\n&quot;, __func__,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return_value, awacs_register);<b=
r>
+=C2=A0 =C2=A0 return return_value;<br>
+}<br>
+<br>
+/*<br>
+ * Determines if the readback bit is set.<br>
+ * It is used by the Codec Control register.<br>
+ */<br>
+static bool readback_enabled(ScreamerState *s)<br>
+{<br>
+/* Note: bit zero is the readback enabled bit */<br>
+=C2=A0 =C2=A0 if (s-&gt;awacs[7] &amp; 1) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
+=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+static uint32_t get_codec_status_reg(ScreamerState *s)<br>
+{<br>
+=C2=A0 =C2=A0 uint32_t return_value;<br>
+<br>
+=C2=A0 =C2=A0 /* if in readback mode - return AWACS register value */<br>
+=C2=A0 =C2=A0 if (readback_enabled(s)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 int awacs_register =3D (s-&gt;awacs[7] &amp; 0=
xe) &gt;&gt; 1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;awacs[7] =3D s-&gt;awacs[7] &amp; 0xffff=
fffe; /* turn off readback mode */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return_value =3D s-&gt;awacs[awacs_register] &=
lt;&lt; 4;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 DPRINTF(&quot;readback enable bit is set, retu=
rning AWACS register %d\t&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;value:0x%x\n=
&quot;, awacs_register, return_value);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return return_value;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /* Tell CPU we are ready */<br>
+=C2=A0 =C2=A0 return_value =3D set_part_ready_bit(s-&gt;codec_status, 1);<=
br>
+<br>
+=C2=A0 =C2=A0 /* Set Revision to Screamer */<br>
+=C2=A0 =C2=A0 return_value =3D set_revision(return_value);<br>
+<br>
+=C2=A0 =C2=A0 /* Set the Manufacturer to Crystal */<br>
+=C2=A0 =C2=A0 return_value =3D set_manufacturer(return_value);<br>
+=C2=A0 =C2=A0 DPRINTF(&quot;%s() called - returned 0x%x\n&quot;, __func__,=
 return_value);<br>
+<br>
+=C2=A0 =C2=A0 return return_value;<br>
+}<br>
+<br>
+static uint32_t get_clip_count_reg(ScreamerState *s)<br>
+{<br>
+=C2=A0 =C2=A0 DPRINTF(&quot;%s() called - returned 0x%x\n&quot;, __func__,=
 s-&gt;clip_count);<br>
+=C2=A0 =C2=A0 uint32_t return_value;<br>
+=C2=A0 =C2=A0 return_value =3D s-&gt;clip_count;<br>
+=C2=A0 =C2=A0 /* This is reset everytime it is read */<br>
+=C2=A0 =C2=A0 s-&gt;clip_count =3D 0;<br>
+=C2=A0 =C2=A0 return return_value;<br>
+}<br>
+<br>
+static uint32_t get_byte_swap_reg(ScreamerState *s)<br>
+{<br>
+=C2=A0 =C2=A0 DPRINTF(&quot;%s() called - returned 0x%x\n&quot;, __func__,=
 s-&gt;byte_swap);<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* If all you hear is noise, it could be this register =
reporting the<br>
+=C2=A0 =C2=A0 =C2=A0* wrong value.<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 return s-&gt;byte_swap ? 0 : 1;<br>
+}<br>
+<br>
+/*<br>
+ * Returns the frame (sample) count<br>
+ */<br>
+static uint32_t get_frame_count_reg(ScreamerState *s)<br>
+{<br>
+=C2=A0 =C2=A0 DPRINTF(&quot;%s() called - returned 0x%x\n&quot;, __func__,=
 s-&gt;frame_count);<br>
+=C2=A0 =C2=A0 return s-&gt;frame_count;<br>
+}<br>
+<br>
+static uint8_t get_left_vol(uint32_t value)<br>
+{<br>
+=C2=A0 =C2=A0 return value &amp; 0xf;<br>
+}<br>
+<br>
+static uint8_t get_right_vol(uint32_t value)<br>
+{<br>
+=C2=A0 =C2=A0 return value &amp; 0x3c0 &gt;&gt; 6;<br>
+}<br>
+<br>
+/*<br>
+ * Returns the sampling rate.<br>
+ * If the audio is playing back too fast or too slow, this function may be=
 the<br>
+ * cause.<br>
+ */<br>
+static int get_sampling_rate(ScreamerState *s)<br>
+{<br>
+=C2=A0 =C2=A0 uint32_t screamer_rate =3D s-&gt;sound_control &amp; 0x700;<=
br>
+=C2=A0 =C2=A0 int return_value;<br>
+<br>
+=C2=A0 =C2=A0 /* All return values are in Hertz */<br>
+=C2=A0 =C2=A0 switch (screamer_rate) {<br>
+=C2=A0 =C2=A0 case 0x0:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return_value =3D 44100;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case 0x100:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return_value =3D 29400;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case 0x200:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return_value =3D 22050;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case 0x300:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return_value =3D 17640;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case 0x400:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return_value =3D 14700;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case 0x500:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return_value =3D 11025;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case 0x600:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return_value =3D 8820;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case 0x700:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return_value =3D 7350;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 default:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 DPRINTF(&quot;get_sampling_rate() unknown valu=
e: 0x%x\nDefaulting to&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot; 44100 Hz.\n=
&quot;, screamer_rate);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 44100;<br>
+}<br>
+=C2=A0 =C2=A0 DPRINTF(&quot;%s() called - returning %dHz\n&quot;, __func__=
, return_value);<br>
+=C2=A0 =C2=A0 return return_value;<br>
+}<br>
+<br>
+/**************************** End of getters *************************/<br=
>
+<br>
+/***************************** Speaker call back *************************=
/<br>
+<br>
+/* resets the play and buffer position markers */<br>
+static void reset_markers(ScreamerState *s)<br>
+{<br>
+=C2=A0 =C2=A0 s-&gt;spk_play_position =3D 0;<br>
+=C2=A0 =C2=A0 s-&gt;spk_buffer_position =3D 0;<br>
+}<br>
+<br>
+<br>
+/* Sends the samples to the host for playing */<br>
+static void send_samples_to_host(ScreamerState *s, int max_samples)<br>
+{<br>
+=C2=A0 =C2=A0 int write_length, requested_length;<br>
+=C2=A0 =C2=A0 requested_length =3D MIN(max_samples, (s-&gt;spk_buffer_posi=
tion -<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-=
&gt;spk_play_position));<br>
+=C2=A0 =C2=A0 write_length =3D AUD_write(s-&gt;speaker_voice,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;s-&gt;spk_buffer[s-&gt;spk_play_positio=
n],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0requested_length);<br>
+=C2=A0 =C2=A0 DPRINTF(&quot;requested length: %d\twrite length: %d\t&quot;=
,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 requested_length, write_length);=
<br>
+=C2=A0 =C2=A0 s-&gt;spk_play_position +=3D write_length;<br>
+=C2=A0 =C2=A0 DPRINTF(&quot;AUD_write %d/%d\n&quot;, s-&gt;spk_play_positi=
on, s-&gt;spk_buffer_position);<br>
+=C2=A0 =C2=A0 s-&gt;frame_count +=3D write_length;<br>
+}<br>
+<br>
+<br>
+/*<br>
+ * Called by QEMU&#39;s audio system to tell the output backend to send sa=
mples<br>
+ * from the buffer to the host sound system.<br>
+ * opaque: a pointer to the ScreamerState instance.<br>
+ * max_samples: the number of samples that can be sent to the hardware buf=
fer.<br>
+ */<br>
+static void speaker_callback(void *opaque, int max_samples)<br>
+{<br>
+=C2=A0 =C2=A0 ScreamerState *s =3D (ScreamerState *) opaque;<br>
+<br>
+=C2=A0 =C2=A0 /* if we have more samples to play */<br>
+=C2=A0 =C2=A0 if (s-&gt;spk_buffer_position &gt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (s-&gt;spk_buffer_position &gt; s-&gt;spk_p=
lay_position) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DPRINTF(&quot;%s() called - max_=
samples: %d\n&quot;, __func__, max_samples);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 send_samples_to_host(s, max_samp=
les);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (s-&gt;spk_play_position &gt;=3D s-&gt;spk_=
buffer_position) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DPRINTF(&quot;done playing buffe=
r\n&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DPRINTF(&quot;pp: %d\tbp: %d\n&q=
uot;, s-&gt;spk_play_position,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&g=
t;spk_buffer_position);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (s-&gt;spk_play_position &gt;=
 s-&gt;spk_buffer_position) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DPRINTF(&quot;Erro=
r detected! - pp &gt; bp\n\a&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reset_markers(s);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* play postponed samples */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (s-&gt;dma_io.len &gt; 0) {<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DPRINTF(&quot;play=
ing postponed samples\n&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 add_to_speaker_buf=
fer(&amp;s-&gt;dma_io);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+/************************* End of speaker call back **********************=
***/<br>
+<br>
+<br>
+/* Opens the speaker&#39;s voice */<br>
+static void open_speaker_voice(ScreamerState *s)<br>
+{<br>
+=C2=A0 =C2=A0 DPRINTF(&quot;%s() called\n&quot;, __func__);<br>
+<br>
+=C2=A0 =C2=A0 /* if voice is already open return from function */<br>
+=C2=A0 =C2=A0 if (s-&gt;speaker_voice !=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 DPRINTF(&quot;closing speaker voice\n&quot;);<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 AUD_close_out(&amp;s-&gt;card, s-&gt;speaker_v=
oice);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;speaker_voice =3D NULL;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 struct audsettings audio_settings;<br>
+=C2=A0 =C2=A0 audio_settings.freq =3D get_sampling_rate(s);=C2=A0 /* in he=
rtz */<br>
+=C2=A0 =C2=A0 audio_settings.nchannels =3D 2;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* stereo output */<br>
+=C2=A0 =C2=A0 audio_settings.fmt =3D AUDIO_FORMAT_S16;=C2=A0 =C2=A0 =C2=A0=
 =C2=A0/* signed 16 bit */<br>
+=C2=A0 =C2=A0 audio_settings.endianness =3D get_byte_swap_reg(s); /* endia=
nness */<br>
+=C2=A0 =C2=A0 s-&gt;speaker_voice =3D AUD_open_out(&amp;s-&gt;card, s-&gt;=
speaker_voice, SOUND_CHIP_NAME<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot; speaker&quot;, =
s, speaker_callback,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;audio_settings);<=
br>
+=C2=A0 =C2=A0 if (!s-&gt;speaker_voice) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 AUD_log(SOUND_CHIP_NAME, &quot;Out voice could=
 not be opened\n&quot;);<br>
+=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 AUD_set_active_out(s-&gt;speaker_voice, true);=
<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+<br>
+/******************************* Setters *********************************=
****/<br>
+<br>
+<br>
+/* Updates QEMU&#39;s audio backend settings */<br>
+static void set_QEMU_audio_settings(ScreamerState *s)<br>
+{<br>
+=C2=A0 =C2=A0 DPRINTF(&quot;%s() called\n&quot;, __func__);<br>
+=C2=A0 =C2=A0 open_speaker_voice(s);<br>
+}<br>
+<br>
+<br>
+/* Return value: 1 =3D muted=C2=A0 0 =3D not muted */<br>
+static int is_muted(ScreamerState *s)<br>
+{<br>
+=C2=A0 =C2=A0 int mute_state =3D s-&gt;awacs[1] &amp; SPEAKER_MUTE ? 1 : 0=
;<br>
+=C2=A0 =C2=A0 if (s-&gt;awacs[1] &amp; SPEAKER_MUTE) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 DPRINTF(&quot;speaker is muted\n&quot;);<br>
+=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 DPRINTF(&quot;speaker is unmuted\n&quot;);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (s-&gt;awacs[1] &amp; HEADPHONE_MUTE) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 DPRINTF(&quot;headphone is muted\n&quot;);<br>
+=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 DPRINTF(&quot;headphone is unmuted\n&quot;);<b=
r>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 return mute_state;<br>
+}<br>
+<br>
+<br>
+/* Converts Screamer&#39;s volume system to QEMU&#39;s system */<br>
+static int screamer_to_qemu_volume(int x)<br>
+{<br>
+=C2=A0 =C2=A0 return -16 * x + 240;<br>
+}<br>
+<br>
+<br>
+/* Sets QEMU&#39;s volume. */<br>
+static void set_volume(ScreamerState *s)<br>
+{<br>
+=C2=A0 =C2=A0 int should_mute =3D is_muted(s);<br>
+<br>
+=C2=A0 =C2=A0 /* Get Screamer volume values */<br>
+=C2=A0 =C2=A0 uint8_t left_vol =3D get_left_vol(s-&gt;awacs[4]);<br>
+=C2=A0 =C2=A0 uint8_t right_vol =3D get_right_vol(s-&gt;awacs[4]);<br>
+=C2=A0 =C2=A0 DPRINTF(&quot;set_volume() called - M:%d\tL:%d\tR:%d\n&quot;=
, should_mute, left_vol,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 right_vol);<br>
+<br>
+=C2=A0 =C2=A0 /* Convert Screamer to QEMU volume values */<br>
+=C2=A0 =C2=A0 left_vol =3D screamer_to_qemu_volume(left_vol);<br>
+=C2=A0 =C2=A0 right_vol =3D screamer_to_qemu_volume(right_vol);<br>
+=C2=A0 =C2=A0 DPRINTF(&quot;QEMU volume: L:%d\tR:%d\n&quot;, left_vol, rig=
ht_vol);<br>
+=C2=A0 =C2=A0 AUD_set_volume_out(s-&gt;speaker_voice, should_mute, left_vo=
l, right_vol);<br>
+}<br>
+<br>
+<br>
+/* Sets the sound control register */<br>
+static void set_sound_control_reg(ScreamerState *s, uint32_t value)<br>
+{<br>
+=C2=A0 =C2=A0 DPRINTF(&quot;set_sound_control_reg() called - value: 0x%x\n=
&quot;, value);<br>
+=C2=A0 =C2=A0 s-&gt;sound_control =3D value;<br>
+=C2=A0 =C2=A0 set_QEMU_audio_settings(s);<br>
+}<br>
+<br>
+<br>
+/* Used for input gain only - can be ignored for now. */<br>
+static void set_awacs_0_reg(ScreamerState *s, uint32_t new_value)<br>
+{<br>
+=C2=A0 =C2=A0 DPRINTF(&quot;Settings AWACS register 0 to 0x%x\n&quot;, s-&=
gt;awacs[0]);<br>
+=C2=A0 =C2=A0 s-&gt;awacs[0] =3D new_value;<br>
+}<br>
+<br>
+<br>
+static void set_awacs_1_reg(ScreamerState *s, uint32_t new_value)<br>
+{<br>
+=C2=A0 =C2=A0 DPRINTF(&quot;Settings AWACS register 1 to 0x%x\n&quot;, new=
_value);<br>
+<br>
+=C2=A0 =C2=A0 s-&gt;awacs[1] =3D new_value;<br>
+<br>
+=C2=A0 =C2=A0 /* If recalibration requested */<br>
+=C2=A0 =C2=A0 if (new_value &amp; RECALIBRATE) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 DPRINTF(&quot;Recalibration requested - unimpl=
emented\n&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 new_value =3D new_value ^ RECALIBRATE; /* Turn=
 off recalibrate bit */<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /* If loop thru set - what does this mean? */<br>
+=C2=A0 =C2=A0 if (new_value &amp; LOOPTHRU) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 DPRINTF(&quot;Loopthru enabled - doing nothing=
\n&quot;);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /* Set headphone jack mute state */<br>
+=C2=A0 =C2=A0 if (new_value &amp; HEADPHONE_MUTE) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 DPRINTF(&quot;Headphone muted\n&quot;);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 DPRINTF(&quot;Headphone unmuted\n&quot;);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (new_value &amp; SPEAKER_MUTE) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 DPRINTF(&quot;Speaker muted\n&quot;);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 DPRINTF(&quot;Speaker unmuted\n&quot;);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (new_value &amp; OUTPUT_ZERO) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 DPRINTF(&quot;output zero set - not sure what =
this means\n&quot;);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (new_value &amp; OUTPUT_ONE) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 DPRINTF(&quot;output one set - not sure what t=
his means\n&quot;);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (new_value &amp; PARALLEL_OUTPUT) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 DPRINTF(&quot;parallel port enabled - but no p=
arallel port here\n&quot;);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 set_volume(s);<br>
+}<br>
+<br>
+<br>
+/* This is used for headphone volume - not needed */<br>
+static void set_awacs_2_reg(ScreamerState *s, uint32_t new_value)<br>
+{<br>
+=C2=A0 =C2=A0 DPRINTF(&quot;Settings AWACS register 2 to 0x%x\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;Ignoring change in headpho=
ne volume.\n&quot;, s-&gt;awacs[2]);<br>
+=C2=A0 =C2=A0 s-&gt;awacs[2] =3D new_value;<br>
+}<br>
+<br>
+<br>
+/* Unknown register purpose */<br>
+static void set_awacs_3_reg(ScreamerState *s, uint32_t new_value)<br>
+{<br>
+=C2=A0 =C2=A0 DPRINTF(&quot;Settings AWACS register 3 to 0x%x\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;This register has an unkno=
wn purpose and does not do anything\n&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;awacs[3]);<br>
+=C2=A0 =C2=A0 s-&gt;awacs[3] =3D new_value;<br>
+}<br>
+<br>
+<br>
+/* Mostly deals with speaker volume */<br>
+static void set_awacs_4_reg(ScreamerState *s, uint32_t new_value)<br>
+{<br>
+=C2=A0 =C2=A0 DPRINTF(&quot;AWACS register 4 write: 0x%x\n&quot;, new_valu=
e);<br>
+=C2=A0 =C2=A0 s-&gt;awacs[4] =3D new_value;<br>
+=C2=A0 =C2=A0 set_volume(s);<br>
+}<br>
+<br>
+<br>
+/* This register is about loop thru stuff I don&#39;t understand */<br>
+static void set_awacs_5_reg(ScreamerState *s, uint32_t new_value)<br>
+{<br>
+=C2=A0 =C2=A0 DPRINTF(&quot;Settings AWACS register 5 to 0x%x\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;Loop thru update ignored.\=
n&quot;, s-&gt;awacs[5]);<br>
+=C2=A0 =C2=A0 s-&gt;awacs[5] =3D new_value;<br>
+}<br>
+<br>
+<br>
+/* Prints the states of the AWACS power register */<br>
+static void print_power_reg_values(uint32_t value)<br>
+{<br>
+=C2=A0 =C2=A0 if ((value &amp; 0x3) =3D=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 printf(&quot;Screamer run state set\n&quot;);<=
br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 if ((value &amp; 0x3) =3D=3D 1) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 printf(&quot;Screamer doze state set\n&quot;);=
<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 if ((value &amp; 0x3) =3D=3D 2) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 printf(&quot;Screamer idle state set\n&quot;);=
<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+<br>
+/* Power Magement register */<br>
+static void set_awacs_6_reg(ScreamerState *s, uint32_t new_value)<br>
+{<br>
+=C2=A0 =C2=A0 DPRINTF(&quot;Settings AWACS register 6 to 0x%x\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;Power management update ig=
nored.\n&quot;, s-&gt;awacs[6]);<br>
+=C2=A0 =C2=A0 if (DEBUG_SCREAMER) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 print_power_reg_values(new_value);<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 s-&gt;awacs[6] =3D new_value;<br>
+}<br>
+<br>
+<br>
+/* Read Back - repeating something that was sent to this chip? */<br>
+static void set_awacs_7_reg(ScreamerState *s, uint32_t new_value)<br>
+{<br>
+=C2=A0 =C2=A0 DPRINTF(&quot;Settings AWACS register 7 to 0x%x\n&quot;, new=
_value);<br>
+=C2=A0 =C2=A0 s-&gt;awacs[7] =3D new_value;<br>
+}<br>
+<br>
+<br>
+/* Sets the AWACs registers - a.k.a. shadow registers */<br>
+static void set_awacs_register(ScreamerState *s, uint32_t value)<br>
+{<br>
+=C2=A0 =C2=A0 int the_register =3D get_codec_control_address(value);<br>
+<br>
+=C2=A0 =C2=A0 switch (the_register) {<br>
+=C2=A0 =C2=A0 case 0:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 set_awacs_0_reg(s, value);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case 1:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 set_awacs_1_reg(s, value);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case 2:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 set_awacs_2_reg(s, value);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case 3:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 set_awacs_3_reg(s, value);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case 4:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 set_awacs_4_reg(s, value);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case 5:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 set_awacs_5_reg(s, value);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case 6:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 set_awacs_6_reg(s, value);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case 7:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 set_awacs_7_reg(s, value);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 default:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 DPRINTF(&quot;Unhandled awacs registers %d\n&q=
uot;, the_register);<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+<br>
+/* Used to set the AWACS registers */<br>
+static void set_codec_control_reg(ScreamerState *s, uint32_t value)<br>
+{<br>
+=C2=A0 =C2=A0 DPRINTF(&quot;set_codec_control_reg() called - value: 0x%x\n=
&quot;, value);<br>
+=C2=A0 =C2=A0 s-&gt;codec_control =3D value;<br>
+=C2=A0 =C2=A0 set_awacs_register(s, value);<br>
+}<br>
+<br>
+static void set_codec_status_reg(ScreamerState *s, uint32_t value)<br>
+{<br>
+=C2=A0 =C2=A0 DPRINTF(&quot;set_codec_status_reg() called - value: 0x%x\n&=
quot;, value);<br>
+=C2=A0 =C2=A0 s-&gt;codec_status =3D value;<br>
+}<br>
+<br>
+static void set_clip_count_reg(ScreamerState *s, uint32_t new_value)<br>
+{<br>
+=C2=A0 =C2=A0 DPRINTF(&quot;set_clip_count_reg() called - value: 0x%x\n&qu=
ot;, new_value);<br>
+=C2=A0 =C2=A0 s-&gt;clip_count =3D new_value;<br>
+}<br>
+<br>
+static void set_byte_swap_reg(ScreamerState *s, uint32_t value)<br>
+{<br>
+=C2=A0 =C2=A0 DPRINTF(&quot;set_byte_swap_reg() called - value: 0x%x\n&quo=
t;, value);<br>
+=C2=A0 =C2=A0 s-&gt;byte_swap =3D value;<br>
+}<br>
+<br>
+static void set_frame_count_reg(ScreamerState *s, uint32_t new_value)<br>
+{<br>
+=C2=A0 =C2=A0 DPRINTF(&quot;%s() called - value: 0x%x\n&quot;, __func__, n=
ew_value);<br>
+=C2=A0 =C2=A0 s-&gt;frame_count =3D new_value;<br>
+}<br>
+<br>
+/*<br>
+ * Sets the busy bit of codec control register.<br>
+ * It is used to tell the CPU to wait.<br>
+ * value: the codec control register&#39;s value<br>
+ * bit_value: used to set or disable the busy bit<br>
+ */<br>
+static uint32_t set_busy_bit(uint32_t value, int bit_value)<br>
+{<br>
+=C2=A0 =C2=A0 const int busy_bit =3D 0x01000000;<br>
+=C2=A0 =C2=A0 uint32_t return_value;<br>
+=C2=A0 =C2=A0 if (bit_value =3D=3D 1)=C2=A0 /* Set this bit */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return_value =3D (value | busy_bit);<br>
+=C2=A0 =C2=A0 else /* bit_value =3D=3D 0=C2=A0 Disable this bit */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return_value =3D (value &amp; ~busy_bit);<br>
+=C2=A0 =C2=A0 return return_value;<br>
+}<br>
+<br>
+<br>
+/*<br>
+ * Sets the part ready bit of the codec status register<br>
+ * value: the codec status register&#39;s value<br>
+ * bit_value: used to set or disable the part ready bit<br>
+ */<br>
+static uint32_t set_part_ready_bit(uint32_t value, int bit_value)<br>
+{<br>
+=C2=A0 =C2=A0 const int part_ready_bit =3D 0x00400000;<br>
+=C2=A0 =C2=A0 uint32_t return_value;<br>
+=C2=A0 =C2=A0 if (bit_value =3D=3D 1)=C2=A0 /* Set this bit */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return_value =3D (value | part_ready_bit);<br>
+=C2=A0 =C2=A0 else /* bit_value =3D=3D 0=C2=A0 Disable this bit */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return_value =3D (value &amp; ~part_ready_bit)=
;<br>
+=C2=A0 =C2=A0 return return_value;<br>
+}<br>
+<br>
+/* Sets bits 12 and 13 to 1 to indicate the Screamer revision */<br>
+static uint32_t set_revision(uint32_t input_value)<br>
+{<br>
+=C2=A0 =C2=A0 uint32_t return_value;<br>
+=C2=A0 =C2=A0 return_value =3D input_value | 0x3000;<br>
+=C2=A0 =C2=A0 return return_value;<br>
+}<br>
+<br>
+/* Sets bit 8 to indicate Crystal as the manufacturer */<br>
+static uint32_t set_manufacturer(uint32_t input_value)<br>
+{<br>
+=C2=A0 =C2=A0 uint32_t return_value;<br>
+=C2=A0 =C2=A0 return_value =3D input_value | 0x100;<br>
+=C2=A0 =C2=A0 return return_value;<br>
+}<br>
+<br>
+<br>
+/************************** End of Setters *******************************=
**/<br>
+<br>
+<br>
+/*************************** DMA functions *******************************=
**/<br>
+<br>
+/*<br>
+ * Sends audio samples from a microphone or line-in to memory.<br>
+ * Used for sound input.<br>
+ * Currently only prevents a deadlock condition with Mac OS 9.<br>
+ */<br>
+static void screamer_to_dma(DBDMA_io *io)<br>
+{<br>
+=C2=A0 =C2=A0 DPRINTF(&quot;%s() called\n&quot;, __func__);<br>
+=C2=A0 =C2=A0 ScreamerState *s =3D (ScreamerState *)io-&gt;opaque;<br>
+=C2=A0 =C2=A0 DBDMAState *dbs =3D s-&gt;dbdma;<br>
+=C2=A0 =C2=A0 DBDMA_channel *ch =3D &amp;dbs-&gt;channels[0x12];<br>
+=C2=A0 =C2=A0 ch-&gt;regs[DBDMA_STATUS] |=3D DEAD;<br>
+=C2=A0 =C2=A0 ch-&gt;regs[DBDMA_STATUS] &amp;=3D ~ACTIVE;<br>
+=C2=A0 =C2=A0 io-&gt;dma_end(io);<br>
+=C2=A0 =C2=A0 return;<br>
+}<br>
+<br>
+<br>
+static void print_dma_info(DBDMA_io *io)<br>
+{<br>
+=C2=A0 =C2=A0 #define RUN=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x8000<br>
+=C2=A0 =C2=A0 #define PAUSE=C2=A0 =C2=A0 =C2=A0 0x4000<br>
+=C2=A0 =C2=A0 #define FLUSH=C2=A0 =C2=A0 =C2=A0 0x2000<br>
+=C2=A0 =C2=A0 #define WAKE=C2=A0 =C2=A0 =C2=A0 =C2=A00x1000<br>
+=C2=A0 =C2=A0 #define DEAD=C2=A0 =C2=A0 =C2=A0 =C2=A00x0800<br>
+=C2=A0 =C2=A0 #define ACTIVE=C2=A0 =C2=A0 =C2=A00x0400<br>
+=C2=A0 =C2=A0 #define BT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x0100<br>
+=C2=A0 =C2=A0 #define DEVSTAT=C2=A0 =C2=A0 0x00ff<br>
+<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* RUN and PAUSE are bits under software control only.<=
br>
+=C2=A0 =C2=A0 =C2=A0* FLUSH and WAKE are set by SW and cleared by hardware=
.<br>
+=C2=A0 =C2=A0 =C2=A0* DEAD, ACTIVE and BT are only under hardware control.=
<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+<br>
+=C2=A0 =C2=A0 DBDMA_channel *ch =3D io-&gt;channel;<br>
+=C2=A0 =C2=A0 printf(&quot;DMA FLAGS: &quot;);<br>
+<br>
+=C2=A0 =C2=A0 if (ch-&gt;regs[DBDMA_STATUS] &amp; RUN) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 printf(&quot;RUN &quot;);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (ch-&gt;regs[DBDMA_STATUS] &amp; ACTIVE) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 printf(&quot;ACTIVE &quot;);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (ch-&gt;regs[DBDMA_STATUS] &amp; PAUSE) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 printf(&quot;PAUSE &quot;);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (ch-&gt;regs[DBDMA_STATUS] &amp; DEAD) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 printf(&quot;DEAD &quot;);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (ch-&gt;regs[DBDMA_STATUS] &amp; WAKE) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 printf(&quot;WAKE &quot;);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (ch-&gt;regs[DBDMA_STATUS] &amp; BT) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 printf(&quot;BT &quot;);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (ch-&gt;regs[DBDMA_STATUS] &amp; DEVSTAT) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 printf(&quot;DEVSTAT &quot;);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (ch-&gt;regs[DBDMA_STATUS] &amp; FLUSH) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 printf(&quot;FLUSH &quot;);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (ch-&gt;io.processing =3D=3D true) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 printf(&quot;processing=C2=A0 &quot;);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 printf(&quot;\n&quot;);<br>
+}<br>
+<br>
+/* Tell the DMA controller we request more samples */<br>
+static void dma_request(DBDMA_io *io)<br>
+{<br>
+=C2=A0 =C2=A0 DPRINTF(&quot;%s() called\n&quot;, __func__);<br>
+=C2=A0 =C2=A0 if (DEBUG_SCREAMER) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 print_dma_info(io);<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 io-&gt;len =3D 0;<br>
+=C2=A0 =C2=A0 io-&gt;dma_end(io);<br>
+}<br>
+<br>
+<br>
+/* Adds sample data to the buffer */<br>
+static void add_to_speaker_buffer(DBDMA_io *io)<br>
+{<br>
+=C2=A0 =C2=A0 ScreamerState *s =3D (ScreamerState *) io-&gt;opaque;<br>
+<br>
+=C2=A0 =C2=A0 if (s-&gt;spk_buffer_position + io-&gt;len &gt; MAX_BUFFER_S=
IZE) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* postpone calling these samples until the bu=
ffer has been emptied */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 memcpy(&amp;s-&gt;dma_io, io, sizeof(DBDMA_io)=
);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 dma_memory_read(&amp;address_space_memory, io-&gt;addr,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp=
;s-&gt;spk_buffer[s-&gt;spk_buffer_position], io-&gt;len);<br>
+=C2=A0 =C2=A0 s-&gt;spk_buffer_position +=3D io-&gt;len;<br>
+=C2=A0 =C2=A0 DPRINTF(&quot;%s() called - len: %d pos: %d/%d\n&quot;, __fu=
nc__, io-&gt;len,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;spk_buffer_position, MAX_B=
UFFER_SIZE);<br>
+<br>
+=C2=A0 =C2=A0 dma_request(io);<br>
+}<br>
+<br>
+/*<br>
+ * Called by the DMA chip to transfer samples from memory to the<br>
+ * Screamer chip.<br>
+ * Used for sound output.<br>
+ */<br>
+static void dma_to_screamer(DBDMA_io *io)<br>
+{<br>
+=C2=A0 =C2=A0 add_to_speaker_buffer(io);<br>
+}<br>
+<br>
+<br>
+/*<br>
+ * This will flush the audio buffer of previous audio - eliminating previo=
us<br>
+ * audio playback.<br>
+ */<br>
+static void send_silence_to_speaker(ScreamerState *s)<br>
+{<br>
+=C2=A0 =C2=A0 DPRINTF(&quot;Silencing audio buffer...\n&quot;);<br>
+=C2=A0 =C2=A0 int length =3D MAX_BUFFER_SIZE;<br>
+=C2=A0 =C2=A0 s-&gt;spk_buffer_position =3D length;<br>
+=C2=A0 =C2=A0 s-&gt;spk_play_position =3D 0;<br>
+=C2=A0 =C2=A0 memset(s-&gt;spk_buffer, 0, length);<br>
+=C2=A0 =C2=A0 s-&gt;dma_io.len =3D 0; /* stop any postponed samples from p=
laying */<br>
+}<br>
+<br>
+<br>
+/* This is called after audio stops playing */<br>
+static void dma_send_flush(DBDMA_io *io)<br>
+{<br>
+=C2=A0 =C2=A0 DPRINTF(&quot;dma_send_flush() called\n&quot;);<br>
+=C2=A0 =C2=A0 if (DEBUG_SCREAMER) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 print_dma_info(io);<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 ScreamerState *s =3D (ScreamerState *)io-&gt;opaque;<br>
+=C2=A0 =C2=A0 reset_markers(s);<br>
+=C2=A0 =C2=A0 send_silence_to_speaker(s);<br>
+=C2=A0 =C2=A0 if (io-&gt;len &gt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 dma_request(io);<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+<br>
+static void dma_receive_flush(DBDMA_io *io)<br>
+{<br>
+=C2=A0 =C2=A0 DPRINTF(&quot;dma_receive_flush() called\n&quot;);<br>
+}<br>
+<br>
+<br>
+/* Set the functions the DMA system will call */<br>
+void screamer_register_dma_functions(ScreamerState *s, void *dbdma,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int send_channel, int r=
eceive_channel)<br>
+{<br>
+=C2=A0 =C2=A0 DPRINTF(&quot;%s() called\n&quot;, __func__);<br>
+=C2=A0 =C2=A0 DPRINTF(&quot;send channel: %d\treceive channel: %d\n&quot;,=
 send_channel,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0receive_channel);<br>
+=C2=A0 =C2=A0 s-&gt;dbdma =3D dbdma;<br>
+<br>
+=C2=A0 =C2=A0 /* Setup the DMA send system */<br>
+=C2=A0 =C2=A0 DBDMA_register_channel(s-&gt;dbdma, send_channel, s-&gt;dma_=
send_irq,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0dma_to_screamer, dma_send_flush, s);<br>
+<br>
+=C2=A0 =C2=A0 /* Setup the DMA receive system */<br>
+=C2=A0 =C2=A0 DBDMA_register_channel(s-&gt;dbdma, receive_channel, s-&gt;d=
ma_receive_irq,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0screamer_to_dma, dma_receive_flush, s);<br>
+}<br>
+<br>
+/************************* End of DMA functions **************************=
/<br>
+<br>
+/* Resets this sound chip */<br>
+static void screamer_reset(DeviceState *d)<br>
+{<br>
+=C2=A0 =C2=A0 DPRINTF(&quot;screamer_reset() called\n&quot;);<br>
+=C2=A0 =C2=A0 ScreamerState *s =3D SCREAMER(d);<br>
+=C2=A0 =C2=A0 set_sound_control_reg(s, 0);<br>
+=C2=A0 =C2=A0 set_codec_control_reg(s, 0);<br>
+=C2=A0 =C2=A0 set_codec_status_reg(s, 0);<br>
+=C2=A0 =C2=A0 set_clip_count_reg(s, 0);<br>
+=C2=A0 =C2=A0 set_byte_swap_reg(s, 0);<br>
+=C2=A0 =C2=A0 set_frame_count_reg(s, 0);<br>
+=C2=A0 =C2=A0 int i, num_awacs_regs =3D 8;<br>
+=C2=A0 =C2=A0 for (i =3D 0; i &lt; num_awacs_regs; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;awacs[i] =3D 0;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 set_QEMU_audio_settings(s);<br>
+=C2=A0 =C2=A0 reset_markers(s);<br>
+=C2=A0 =C2=A0 s-&gt;dma_io.len =3D 0;<br>
+}<br>
+<br>
+/* Called when the CPU reads the memory addresses assigned to Screamer */<=
br>
+static uint64_t screamer_mmio_read(void *opaque, hwaddr addr, unsigned siz=
e)<br>
+{<br>
+=C2=A0 =C2=A0 ScreamerState *state =3D opaque;<br>
+=C2=A0 =C2=A0 uint32_t return_value;<br>
+<br>
+=C2=A0 =C2=A0 addr =3D addr &gt;&gt; 4;<br>
+=C2=A0 =C2=A0 switch (addr) {<br>
+=C2=A0 =C2=A0 case SOUND_CONTROL_REG:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return_value =3D get_sound_control_reg(state);=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case CODEC_CONTROL_REG:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return_value =3D get_codec_control_reg(state);=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case CODEC_STATUS_REG:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return_value =3D get_codec_status_reg(state);<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case CLIP_COUNT_REG:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return_value =3D get_clip_count_reg(state);<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case BYTE_SWAP_REG:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return_value =3D get_byte_swap_reg(state);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case FRAME_COUNT_REG:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return_value =3D get_frame_count_reg(state);<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 default:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 DPRINTF(&quot;Unknown register read - addr:%ll=
u\tsize:%d\n&quot;, addr, size);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return_value =3D 12021981; /* Value used for d=
ebugging purposes */<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 DPRINTF(&quot;screamer_mmio_read() called addr: %llu=C2=A0 s=
ize: %d&quot;, addr &gt;&gt; 4,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 size);<br>
+=C2=A0 =C2=A0 DPRINTF(&quot;=C2=A0 returning 0x%x\n&quot;, return_value);<=
br>
+=C2=A0 =C2=A0 return return_value;<br>
+}<br>
+<br>
+<br>
+/* Called when the CPU writes to the memory addresses assigned to Screamer=
 */<br>
+static void screamer_mmio_write(void *opaque, hwaddr addr, uint64_t raw_va=
lue,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned size)<br>
+{<br>
+=C2=A0 =C2=A0 DPRINTF(&quot;screamer_mmio_write() called - size: %d\n&quot=
;, size);<br>
+=C2=A0 =C2=A0 ScreamerState *state =3D opaque;<br>
+=C2=A0 =C2=A0 uint32_t value =3D raw_value &amp; 0xffffffff;<br>
+=C2=A0 =C2=A0 addr =3D addr &gt;&gt; 4;<br>
+<br>
+=C2=A0 =C2=A0 switch (addr) {<br>
+=C2=A0 =C2=A0 case SOUND_CONTROL_REG:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 set_sound_control_reg(state, value);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case CODEC_CONTROL_REG:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 set_codec_control_reg(state, value);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case CODEC_STATUS_REG:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 set_codec_status_reg(state, value);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case CLIP_COUNT_REG:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 set_clip_count_reg(state, value);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case BYTE_SWAP_REG:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 set_byte_swap_reg(state, value);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case FRAME_COUNT_REG:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 set_frame_count_reg(state, value);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 default:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 DPRINTF(&quot;Unknown register write - addr:%l=
lu\tvalue:%d\n&quot;, addr, value);<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+/* Used for memory_region_init_io() for memory mapped I/O */<br>
+static const MemoryRegionOps screamer_ops =3D {<br>
+=C2=A0 =C2=A0 .read =3D screamer_mmio_read,<br>
+=C2=A0 =C2=A0 .write =3D screamer_mmio_write,<br>
+=C2=A0 =C2=A0 .endianness =3D DEVICE_LITTLE_ENDIAN,<br>
+=C2=A0 =C2=A0 .valid =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .min_access_size =3D 4,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .max_access_size =3D 4<br>
+=C2=A0 =C2=A0 }<br>
+};<br>
+<br>
+/* Called when the device has become active */<br>
+static void screamer_realize(DeviceState *dev, Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 DPRINTF(&quot;screamer_realize() called\n&quot;);<br>
+=C2=A0 =C2=A0 screamer_reset(dev);<br>
+}<br>
+<br>
+<br>
+/*<br>
+ * Called when an instance of the Screamer device is created.<br>
+ * Also called when this HMP command is called: device_add screamer<br>
+ */<br>
+static void screamer_init(Object *obj)<br>
+{<br>
+=C2=A0 =C2=A0 DPRINTF(&quot;screamer_init() called\n&quot;);<br>
+<br>
+=C2=A0 =C2=A0 ScreamerState *s =3D (ScreamerState *)obj;<br>
+=C2=A0 =C2=A0 SysBusDevice *d =3D SYS_BUS_DEVICE(obj);<br>
+=C2=A0 =C2=A0 const int region_size =3D 5 * 32;<br>
+<br>
+=C2=A0 =C2=A0 /* Makes the read and write ops work */<br>
+=C2=A0 =C2=A0 memory_region_init_io(&amp;s-&gt;io_memory_region, OBJECT(s)=
,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &amp;screamer_ops, s, SOUND_CHIP_NAME, region_size);<br>
+<br>
+=C2=A0 =C2=A0 /* Sets the SysBusDevice&#39;s memory property */<br>
+=C2=A0 =C2=A0 sysbus_init_mmio(d, &amp;s-&gt;io_memory_region);<br>
+<br>
+=C2=A0 =C2=A0 /* Setup all the interrupt requests */<br>
+=C2=A0 =C2=A0 sysbus_init_irq(d, &amp;s-&gt;irq);<br>
+=C2=A0 =C2=A0 sysbus_init_irq(d, &amp;s-&gt;dma_send_irq);<br>
+=C2=A0 =C2=A0 sysbus_init_irq(d, &amp;s-&gt;dma_receive_irq);<br>
+<br>
+=C2=A0 =C2=A0 /* Registers Screamer with QEMU&#39;s audio system */<br>
+=C2=A0 =C2=A0 AUD_register_card(SOUND_CHIP_NAME, &amp;s-&gt;card);<br>
+}<br>
+<br>
+<br>
+/*<br>
+ * When saving and restoring the state of the VM, this is used to save and=
<br>
+ * restore the registers.<br>
+ */<br>
+static const VMStateDescription vmstate_screamer =3D {<br>
+=C2=A0 =C2=A0 .name =3D &quot;Screamer&quot;,<br>
+=C2=A0 =C2=A0 .version_id =3D 1,<br>
+=C2=A0 =C2=A0 .minimum_version_id =3D 1,<br>
+=C2=A0 =C2=A0 .fields =3D (VMStateField[]) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT16_ARRAY(awacs, ScreamerState, 8),=
 /* 8 AWACS registers */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(sound_control, ScreamerState),<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(codec_control, ScreamerState),<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(codec_status, ScreamerState),<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(clip_count, ScreamerState),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(byte_swap, ScreamerState),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(frame_count, ScreamerState),<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_END_OF_LIST()<br>
+=C2=A0 =C2=A0 }<br>
+};<br>
+<br>
+<br>
+/*<br>
+ * Sets the class data. It is like polymorphism and inheritance in object<=
br>
+ * oriented languages.<br>
+ */<br>
+static void screamer_class_init(ObjectClass *class, void *data)<br>
+{<br>
+=C2=A0 =C2=A0 DPRINTF(&quot;screamer_class_init() called\n&quot;);<br>
+=C2=A0 =C2=A0 DeviceClass *dc =3D DEVICE_CLASS(class);<br>
+=C2=A0 =C2=A0 dc-&gt;realize =3D screamer_realize;<br>
+=C2=A0 =C2=A0 dc-&gt;reset =3D screamer_reset;<br>
+=C2=A0 =C2=A0 dc-&gt;desc =3D &quot;Apple Screamer&quot;;<br>
+=C2=A0 =C2=A0 dc-&gt;vmsd =3D &amp;vmstate_screamer;<br>
+=C2=A0 =C2=A0 dc-&gt;hotpluggable =3D false;<br>
+}<br>
+<br>
+/* Used for QOM function registration */<br>
+static const TypeInfo screamer_info =3D {<br>
+=C2=A0 =C2=A0 .name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D &quot;screamer&q=
uot;,<br>
+=C2=A0 =C2=A0 .parent=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_SYS_BUS_DEVICE,<=
br>
+=C2=A0 =C2=A0 .instance_size =3D sizeof(ScreamerState),<br>
+=C2=A0 =C2=A0 .instance_init =3D screamer_init,<br>
+=C2=A0 =C2=A0 .class_init=C2=A0 =C2=A0 =3D screamer_class_init,<br>
+};<br>
+<br>
+/* QOM registration of above functions for calling */<br>
+static void screamer_register_types(void)<br>
+{<br>
+=C2=A0 =C2=A0 DPRINTF(&quot;screamer_register_types() called\n&quot;);<br>
+=C2=A0 =C2=A0 type_register_static(&amp;screamer_info);<br>
+}<br>
+<br>
+/* QEMU Object Model (QOM) stuff */<br>
+type_init(screamer_register_types)<br>
diff --git a/hw/misc/macio/macio.c b/hw/misc/macio/macio.c<br>
index 79222192e8..3307fa3818 100644<br>
--- a/hw/misc/macio/macio.c<br>
+++ b/hw/misc/macio/macio.c<br>
@@ -37,6 +37,7 @@<br>
=C2=A0#include &quot;hw/intc/heathrow_pic.h&quot;<br>
=C2=A0#include &quot;sysemu/sysemu.h&quot;<br>
=C2=A0#include &quot;trace.h&quot;<br>
+#include &quot;include/hw/audio/screamer.h&quot;<br>
<br>
=C2=A0/* Note: this code is strongly inspirated from the corresponding code=
<br>
=C2=A0 * in PearPC */<br>
@@ -109,7 +110,10 @@ static void macio_common_realize(PCIDevice *d, Error *=
*errp)<br>
=C2=A0 =C2=A0 =C2=A0SysBusDevice *sysbus_dev;<br>
=C2=A0 =C2=A0 =C2=A0Error *err =3D NULL;<br>
<br>
-=C2=A0 =C2=A0 object_property_set_bool(OBJECT(&amp;s-&gt;dbdma), true, &qu=
ot;realized&quot;, &amp;err);<br>
+=C2=A0 =C2=A0 const char *realized_property =3D &quot;realized&quot;;<br>
+=C2=A0 =C2=A0 bool new_value =3D true;<br>
+=C2=A0 =C2=A0 object_property_set_bool(OBJECT(&amp;s-&gt;dbdma), new_value=
, realized_property,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;err);<br>
=C2=A0 =C2=A0 =C2=A0if (err) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_propagate(errp, err);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
@@ -117,6 +121,19 @@ static void macio_common_realize(PCIDevice *d, Error *=
*errp)<br>
=C2=A0 =C2=A0 =C2=A0sysbus_dev =3D SYS_BUS_DEVICE(&amp;s-&gt;dbdma);<br>
=C2=A0 =C2=A0 =C2=A0memory_region_add_subregion(&amp;s-&gt;bar, 0x08000,<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sysbus_mmio_get_region(sysbus_=
dev, 0));<br>
+=C2=A0 =C2=A0 object_property_set_bool(OBJECT(&amp;s-&gt;screamer), true, =
&quot;realized&quot;, &amp;err);<br>
+=C2=A0 =C2=A0 if (err) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_propagate(errp, err);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /* Add the screamer sound chip */<br>
+=C2=A0 =C2=A0 sysbus_dev =3D SYS_BUS_DEVICE(&amp;s-&gt;screamer);<br>
+=C2=A0 =C2=A0 const int offset =3D 0x14000; /* Offset from base address re=
gister (bar) */<br>
+=C2=A0 =C2=A0 const int region_number =3D 0; /* which memory region to use=
 */<br>
+=C2=A0 =C2=A0 memory_region_add_subregion(&amp;s-&gt;bar, offset,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sysbus_mmio_get_region(sysbus_dev,<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0region_number));<br>
<br>
=C2=A0 =C2=A0 =C2=A0qdev_prop_set_uint32(DEVICE(&amp;s-&gt;escc), &quot;dis=
abled&quot;, 0);<br>
=C2=A0 =C2=A0 =C2=A0qdev_prop_set_uint32(DEVICE(&amp;s-&gt;escc), &quot;fre=
quency&quot;, ESCC_CLOCK);<br>
@@ -386,6 +403,19 @@ static void macio_newworld_realize(PCIDevice *d, Error=
 **errp)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memory_region_add_subregion(&amp;s-&gt;ba=
r, 0x16000,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sysbus_mmio_get_=
region(sysbus_dev, 0));<br>
=C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 /* Screamer Sound Chip */<br>
+=C2=A0 =C2=A0 const int gpio_0 =3D 0;<br>
+=C2=A0 =C2=A0 const int gpio_1 =3D 1;<br>
+=C2=A0 =C2=A0 const int transmit_channel =3D 0x10;<br>
+=C2=A0 =C2=A0 const int receive_channel =3D 0x12;<br>
+=C2=A0 =C2=A0 sysbus_dev =3D SYS_BUS_DEVICE(&amp;s-&gt;screamer);<br>
+=C2=A0 =C2=A0 sysbus_connect_irq(sysbus_dev, gpio_0, qdev_get_gpio_in(pic_=
dev,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0NEWWORLD_SCREAMER_IRQ));<br>
+=C2=A0 =C2=A0 sysbus_connect_irq(sysbus_dev, gpio_1, qdev_get_gpio_in(pic_=
dev,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0NEWWORLD_SCREAMER_DMA_IRQ));<br>
+=C2=A0 =C2=A0 screamer_register_dma_functions(SCREAMER(sysbus_dev), &amp;s=
-&gt;dbdma,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 transmit_channel, rece=
ive_channel);<br>
=C2=A0}<br>
<br>
=C2=A0static void macio_newworld_init(Object *obj)<br>
@@ -420,6 +450,9 @@ static void macio_instance_init(Object *obj)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 TYPE_MAC_DBDMA);<br>
<br>
=C2=A0 =C2=A0 =C2=A0macio_init_child_obj(s, &quot;escc&quot;, &amp;s-&gt;es=
cc, sizeof(s-&gt;escc), TYPE_ESCC);<br>
+<br>
+=C2=A0 =C2=A0 macio_init_child_obj(s, SOUND_CHIP_NAME, &amp;s-&gt;screamer=
, sizeof(s-&gt;screamer),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0TYPE_SCREAMER);<br>
=C2=A0}<br>
<br>
=C2=A0static const VMStateDescription vmstate_macio_oldworld =3D {<br>
diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig<br>
index 354828bf13..4ffc3a1c16 100644<br>
--- a/hw/ppc/Kconfig<br>
+++ b/hw/ppc/Kconfig<br>
@@ -104,6 +104,7 @@ config MAC_NEWWORLD<br>
=C2=A0 =C2=A0 =C2=A0select MAC_PMU<br>
=C2=A0 =C2=A0 =C2=A0select UNIN_PCI<br>
=C2=A0 =C2=A0 =C2=A0select FW_CFG_PPC<br>
+=C2=A0 =C2=A0 select SCREAMER<br>
<br>
=C2=A0config E500<br>
=C2=A0 =C2=A0 =C2=A0bool<br>
diff --git a/hw/ppc/mac.h b/hw/ppc/mac.h<br>
index 6af87d1fa0..c65f2fd15f 100644<br>
--- a/hw/ppc/mac.h<br>
+++ b/hw/ppc/mac.h<br>
@@ -34,6 +34,8 @@<br>
=C2=A0#include &quot;hw/misc/mos6522.h&quot;<br>
=C2=A0#include &quot;hw/pci/pci_host.h&quot;<br>
=C2=A0#include &quot;hw/pci-host/uninorth.h&quot;<br>
+#include &quot;hw/ppc/mac_dbdma.h&quot;<br>
+#include &quot;audio/audio.h&quot;<br>
<br>
=C2=A0/* SMP is not enabled, for now */<br>
=C2=A0#define MAX_CPUS 1<br>
@@ -68,6 +70,9 @@<br>
=C2=A0#define NEWWORLD_IDE1_DMA_IRQ=C2=A0 0x3<br>
=C2=A0#define NEWWORLD_EXTING_GPIO1=C2=A0 0x2f<br>
=C2=A0#define NEWWORLD_EXTING_GPIO9=C2=A0 0x37<br>
+#define NEWWORLD_SCREAMER_IRQ=C2=A0 0x18<br>
+#define NEWWORLD_SCREAMER_DMA_IRQ 0x9<br>
+#define NEWWORLD_SCREAMER_RX_IRQ 0xa<br>
<br>
=C2=A0/* Core99 machine */<br>
=C2=A0#define TYPE_CORE99_MACHINE MACHINE_TYPE_NAME(&quot;mac99&quot;)<br>
diff --git a/include/hw/audio/screamer.h b/include/hw/audio/screamer.h<br>
new file mode 100644<br>
index 0000000000..7155541688<br>
--- /dev/null<br>
+++ b/include/hw/audio/screamer.h<br>
@@ -0,0 +1,42 @@<br>
+/*<br>
+ * File: screamer.h<br>
+ * Description: header file to the hw/audio/screamer.c file<br>
+ */<br>
+<br>
+#ifndef screamer_h<br>
+#define screamer_h<br>
+<br>
+#include &lt;inttypes.h&gt;<br>
+#include &quot;audio/audio.h&quot;<br>
+#include &quot;hw/ppc/mac_dbdma.h&quot;<br>
+<br>
+#define TYPE_SCREAMER &quot;screamer&quot;<br>
+#define SCREAMER(obj) OBJECT_CHECK(ScreamerState, (obj), TYPE_SCREAMER)<br=
>
+#define SOUND_CHIP_NAME &quot;Screamer Sound Chip&quot;<br>
+#define MAX_BUFFER_SIZE (128 * 64)<br>
+<br>
+typedef struct ScreamerState {<br>
+=C2=A0 =C2=A0 SysBusDevice parent_obj;<br>
+=C2=A0 =C2=A0 uint16_t awacs[8]; /* Shadow/awacs registers */<br>
+=C2=A0 =C2=A0 uint32_t sound_control;<br>
+=C2=A0 =C2=A0 uint32_t codec_control;<br>
+=C2=A0 =C2=A0 uint32_t codec_status;<br>
+=C2=A0 =C2=A0 uint32_t clip_count;<br>
+=C2=A0 =C2=A0 uint32_t byte_swap;<br>
+=C2=A0 =C2=A0 uint32_t frame_count;<br>
+=C2=A0 =C2=A0 SWVoiceOut *speaker_voice;<br>
+=C2=A0 =C2=A0 DBDMAState *dbdma;<br>
+=C2=A0 =C2=A0 qemu_irq dma_send_irq;<br>
+=C2=A0 =C2=A0 qemu_irq dma_receive_irq;<br>
+=C2=A0 =C2=A0 qemu_irq irq;<br>
+=C2=A0 =C2=A0 QEMUSoundCard card;<br>
+=C2=A0 =C2=A0 MemoryRegion io_memory_region;<br>
+=C2=A0 =C2=A0 uint8_t spk_buffer[MAX_BUFFER_SIZE];<br>
+=C2=A0 =C2=A0 uint16_t spk_buffer_position, spk_play_position;<br>
+=C2=A0 =C2=A0 DBDMA_io dma_io;<br>
+} ScreamerState;<br>
+<br>
+void screamer_register_dma_functions(ScreamerState *s, void *dbdma,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int send_channel=
, int receive_channel);<br>
+<br>
+#endif /* screamer_h */<br>
diff --git a/include/hw/misc/macio/macio.h b/include/hw/misc/macio/macio.h<=
br>
index 070a694eb5..81ad552d61 100644<br>
--- a/include/hw/misc/macio/macio.h<br>
+++ b/include/hw/misc/macio/macio.h<br>
@@ -35,6 +35,7 @@<br>
=C2=A0#include &quot;hw/ppc/mac.h&quot;<br>
=C2=A0#include &quot;hw/ppc/mac_dbdma.h&quot;<br>
=C2=A0#include &quot;hw/ppc/openpic.h&quot;<br>
+#include &quot;hw/audio/screamer.h&quot;<br>
<br>
=C2=A0/* MacIO virtual bus */<br>
=C2=A0#define TYPE_MACIO_BUS &quot;macio-bus&quot;<br>
@@ -86,6 +87,7 @@ typedef struct MacIOState {<br>
=C2=A0 =C2=A0 =C2=A0PMUState pmu;<br>
=C2=A0 =C2=A0 =C2=A0DBDMAState dbdma;<br>
=C2=A0 =C2=A0 =C2=A0ESCCState escc;<br>
+=C2=A0 =C2=A0 ScreamerState screamer;<br>
=C2=A0 =C2=A0 =C2=A0uint64_t frequency;<br>
=C2=A0} MacIOState;<br>
<br>
-- <br>
2.14.3 (Apple Git-98)<br>
<br></blockquote><div>Hi, <br></div><div><br></div><div>This patch will not=
 compile without errors. Host is Fedora 31.<br></div><div>The compiler sugg=
ests changing lines 839, 842 and 878 in screamer.c so the DPRINTF arguments=
 use %lu instead of %llu.</div><div>With that fixed, compiling completes su=
ccesfully. <br></div><div><br></div><div>Best,<br></div><div>Howard<br></di=
v></div></div>

--00000000000073b667059eb6d963--

