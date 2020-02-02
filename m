Return-Path: <SRS0=8j4I=3W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC946C35249
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Feb 2020 22:15:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E33020661
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Feb 2020 22:15:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zq7CvGpM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E33020661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyNWY-0003I4-HI
	for qemu-devel@archiver.kernel.org; Sun, 02 Feb 2020 17:15:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34479)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <hsp.cat7@gmail.com>) id 1iyNVW-0002os-HM
 for qemu-devel@nongnu.org; Sun, 02 Feb 2020 17:14:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <hsp.cat7@gmail.com>) id 1iyNVT-0005fK-06
 for qemu-devel@nongnu.org; Sun, 02 Feb 2020 17:14:22 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:44631)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <hsp.cat7@gmail.com>) id 1iyNVS-0005c2-ND
 for qemu-devel@nongnu.org; Sun, 02 Feb 2020 17:14:18 -0500
Received: by mail-oi1-x241.google.com with SMTP id d62so12898898oia.11
 for <qemu-devel@nongnu.org>; Sun, 02 Feb 2020 14:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2PorBm+g6i7zOkE4BiaipsweciwSawe3xOzmdrt3dAM=;
 b=Zq7CvGpM+GLvc43xXZC/uoPsjcHn6Tn7ct3KdmsyN/VArQVcK0Dk5p6V17NupDLAcU
 NdiMmJHMMlI84A2R3oFUWkmrAiT0aouch7PLEKPBC8H0T5sVipmbBVzzPSE0lLOfULPr
 TOs9t5BaUM7CnuKvjoSx1zTK4sB821gaV5p/AFMVwJ0oIctXJonIg/6HPbI7J1QsTyIy
 5c0Kg0DaHb9fNleaoQZwlPR+huITDnGJkUuDac1f8drcnpFfti1Dll1hoLi/ColzYZri
 ic0A6X3MHFTewTB2QZRMUsELCbHGoUz4zClAEe4arCWDWz+1KOR9j1rdhwDU8qzX/Mjo
 4Q5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2PorBm+g6i7zOkE4BiaipsweciwSawe3xOzmdrt3dAM=;
 b=rhsnyOIcE9OUl4brz8EXYGwaoDAzndt9rxdvYjmNuaAAWvzuXTj5p9PAAcPxAMoJXh
 86UBMA+hrw5eLhv6nYyPLzZveZonVlhYGsmRSVxy0TAFLBUq1HfeI5KCitNyJPjZYlGv
 jIYeQ6TWgoHPh11eHSt99UFNvQVnL+6mxYT3PV9Uk3PdEBA2p1fRm0oFJ6GvpRL36qOb
 b9p9b2s2gh4Y0Fj5r4+22T1YXCmdp7KZyW+gW2p5mSDnQwsdTdtE5bxs5aWria8nHroR
 WzFMR2eR+DYJoHJ/bT9QxfjX6bQR4g9kN52eUp9uBHw3t2MTWHc3cXaBCO80P7vOKccL
 YWqQ==
X-Gm-Message-State: APjAAAWKSRc2ldhLh98ObFmIzx+abRwznO2Q7gJAofsQ2NDGZJEahSaN
 MeejL9TIHgJsplTBhw0Az3U2hOcq+Gr0LgLE9iw=
X-Google-Smtp-Source: APXvYqz1xHDRhhGZ6BUl6LDdpd4QoTTvnpVD8j5S6tFoT7sHvVfD0VERPHuM85Yf7uRyjVoeII7aZ+EZ0fHNYi8ziC8=
X-Received: by 2002:a05:6808:3ba:: with SMTP id
 n26mr13242629oie.62.1580681657734; 
 Sun, 02 Feb 2020 14:14:17 -0800 (PST)
MIME-Version: 1.0
References: <8a8b0b5698401b78d3c4c8ec90aef83b95babb06.1580672076.git.DirtY.iCE.hu@gmail.com>
In-Reply-To: <8a8b0b5698401b78d3c4c8ec90aef83b95babb06.1580672076.git.DirtY.iCE.hu@gmail.com>
From: Howard Spoelstra <hsp.cat7@gmail.com>
Date: Sun, 2 Feb 2020 23:14:06 +0100
Message-ID: <CABLmASEHUkq7sCr8_Re68u-FOVPt+nym6vqP+8HYhjqTv20AhA@mail.gmail.com>
Subject: Re: [RFC PATCH] audio: proper support for float samples in mixeng
To: =?UTF-8?B?S8WRdsOhZ8OzLCBab2x0w6Fu?= <dirty.ice.hu@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000b658ca059d9f20be"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
Cc: Markus Armbruster <armbru@redhat.com>,
 qemu-devel qemu-devel <qemu-devel@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000b658ca059d9f20be
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 2, 2020 at 8:38 PM K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <dirty.ic=
e.hu@gmail.com>
wrote:

> This adds proper support for float samples in mixeng by adding a new
> audio format for it.
>
> Limitations: only native endianness is supported.
>
> Signed-off-by: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <DirtY.iCE.hu@gmail.com=
>
> ---
>
> This patch is meant to be applied on top of "[PATCH] coreaudio: fix
> coreaudio
> playback" by Volker R=C3=BCmelin, available at:
> https://lists.nongnu.org/archive/html/qemu-devel/2020-02/msg00114.html
>
> For more information, please refer to that thread.
>
> ---
>  qapi/audio.json        |  2 +-
>  audio/audio_int.h      |  3 +-
>  audio/audio_template.h | 41 ++++++++++++--------
>  audio/mixeng.h         |  8 ++--
>  audio/alsaaudio.c      | 17 ++++++++
>  audio/audio.c          | 56 ++++++++++++++++++---------
>  audio/coreaudio.c      |  7 +---
>  audio/mixeng.c         | 88 ++++++++++++++++++++++++++----------------
>  audio/paaudio.c        |  9 +++++
>  audio/sdlaudio.c       | 28 ++++++++++++++
>  10 files changed, 180 insertions(+), 79 deletions(-)
>
> diff --git a/qapi/audio.json b/qapi/audio.json
> index 83312b2339..d8c507cced 100644
> --- a/qapi/audio.json
> +++ b/qapi/audio.json
> @@ -276,7 +276,7 @@
>  # Since: 4.0
>  ##
>  { 'enum': 'AudioFormat',
> -  'data': [ 'u8', 's8', 'u16', 's16', 'u32', 's32' ] }
> +  'data': [ 'u8', 's8', 'u16', 's16', 'u32', 's32', 'f32' ] }
>
>  ##
>  # @AudiodevDriver:
> diff --git a/audio/audio_int.h b/audio/audio_int.h
> index 5ba2078346..cd92e48163 100644
> --- a/audio/audio_int.h
> +++ b/audio/audio_int.h
> @@ -40,7 +40,8 @@ struct audio_callback {
>
>  struct audio_pcm_info {
>      int bits;
> -    int sign;
> +    bool is_signed;
> +    bool is_float;
>      int freq;
>      int nchannels;
>      int bytes_per_frame;
> diff --git a/audio/audio_template.h b/audio/audio_template.h
> index 0336d2670c..7013d3041f 100644
> --- a/audio/audio_template.h
> +++ b/audio/audio_template.h
> @@ -153,15 +153,23 @@ static int glue (audio_pcm_sw_init_, TYPE) (
>      sw->ratio =3D ((int64_t) sw->info.freq << 32) / sw->hw->info.freq;
>  #endif
>
> +    if (sw->info.is_float) {
>  #ifdef DAC
> -    sw->conv =3D mixeng_conv
> +        sw->conv =3D mixeng_conv_float[sw->info.nchannels =3D=3D 2];
>  #else
> -    sw->clip =3D mixeng_clip
> +        sw->clip =3D mixeng_clip_float[sw->info.nchannels =3D=3D 2];
>  #endif
> -        [sw->info.nchannels =3D=3D 2]
> -        [sw->info.sign]
> -        [sw->info.swap_endianness]
> -        [audio_bits_to_index (sw->info.bits)];
> +    } else {
> +#ifdef DAC
> +        sw->conv =3D mixeng_conv
> +#else
> +        sw->clip =3D mixeng_clip
> +#endif
> +            [sw->info.nchannels =3D=3D 2]
> +            [sw->info.is_signed]
> +            [sw->info.swap_endianness]
> +            [audio_bits_to_index(sw->info.bits)];
> +    }
>
>      sw->name =3D g_strdup (name);
>      err =3D glue (audio_pcm_sw_alloc_resources_, TYPE) (sw);
> @@ -276,22 +284,23 @@ static HW *glue(audio_pcm_hw_add_new_,
> TYPE)(AudioState *s,
>          goto err1;
>      }
>
> -    if (s->dev->driver =3D=3D AUDIODEV_DRIVER_COREAUDIO) {
> +    if (hw->info.is_float) {
>  #ifdef DAC
> -        hw->clip =3D clip_natural_float_from_stereo;
> +        hw->clip =3D mixeng_clip_float[hw->info.nchannels =3D=3D 2];
>  #else
> -        hw->conv =3D conv_natural_float_to_stereo;
> +        hw->conv =3D mixeng_conv_float[hw->info.nchannels =3D=3D 2];
>  #endif
> -    } else
> +    } else {
>  #ifdef DAC
> -    hw->clip =3D mixeng_clip
> +        hw->clip =3D mixeng_clip
>  #else
> -    hw->conv =3D mixeng_conv
> +        hw->conv =3D mixeng_conv
>  #endif
> -        [hw->info.nchannels =3D=3D 2]
> -        [hw->info.sign]
> -        [hw->info.swap_endianness]
> -        [audio_bits_to_index (hw->info.bits)];
> +            [hw->info.nchannels =3D=3D 2]
> +            [hw->info.is_signed]
> +            [hw->info.swap_endianness]
> +            [audio_bits_to_index(hw->info.bits)];
> +    }
>
>      glue(audio_pcm_hw_alloc_resources_, TYPE)(hw);
>
> diff --git a/audio/mixeng.h b/audio/mixeng.h
> index 7ef61763e8..2dcd6df245 100644
> --- a/audio/mixeng.h
> +++ b/audio/mixeng.h
> @@ -38,13 +38,13 @@ typedef struct st_sample st_sample;
>  typedef void (t_sample) (struct st_sample *dst, const void *src, int
> samples);
>  typedef void (f_sample) (void *dst, const struct st_sample *src, int
> samples);
>
> +/* indices: [stereo][signed][swap endiannes][8, 16 or 32-bits] */
>  extern t_sample *mixeng_conv[2][2][2][3];
>  extern f_sample *mixeng_clip[2][2][2][3];
>
> -void conv_natural_float_to_stereo(struct st_sample *dst, const void *src=
,
> -                                  int samples);
> -void clip_natural_float_from_stereo(void *dst, const struct st_sample
> *src,
> -                                    int samples);
> +/* indices: [stereo] */
> +extern t_sample *mixeng_conv_float[2];
> +extern f_sample *mixeng_clip_float[2];
>
>  void *st_rate_start (int inrate, int outrate);
>  void st_rate_flow(void *opaque, st_sample *ibuf, st_sample *obuf,
> diff --git a/audio/alsaaudio.c b/audio/alsaaudio.c
> index f37ce1ce85..768b896a93 100644
> --- a/audio/alsaaudio.c
> +++ b/audio/alsaaudio.c
> @@ -307,6 +307,13 @@ static snd_pcm_format_t aud_to_alsafmt (AudioFormat
> fmt, int endianness)
>              return SND_PCM_FORMAT_U32_LE;
>          }
>
> +    case AUDIO_FORMAT_F32:
> +        if (endianness) {
> +            return SND_PCM_FORMAT_FLOAT_BE;
> +        } else {
> +            return SND_PCM_FORMAT_FLOAT_LE;
> +        }
> +
>      default:
>          dolog ("Internal logic error: Bad audio format %d\n", fmt);
>  #ifdef DEBUG_AUDIO
> @@ -370,6 +377,16 @@ static int alsa_to_audfmt (snd_pcm_format_t alsafmt,
> AudioFormat *fmt,
>          *fmt =3D AUDIO_FORMAT_U32;
>          break;
>
> +    case SND_PCM_FORMAT_FLOAT_LE:
> +        *endianness =3D 0;
> +        *fmt =3D AUDIO_FORMAT_F32;
> +        break;
> +
> +    case SND_PCM_FORMAT_FLOAT_BE:
> +        *endianness =3D 1;
> +        *fmt =3D AUDIO_FORMAT_F32;
> +        break;
> +
>      default:
>          dolog ("Unrecognized audio format %d\n", alsafmt);
>          return -1;
> diff --git a/audio/audio.c b/audio/audio.c
> index f63f39769a..53fdb42ec7 100644
> --- a/audio/audio.c
> +++ b/audio/audio.c
> @@ -218,6 +218,9 @@ static void audio_print_settings (struct audsettings
> *as)
>      case AUDIO_FORMAT_U32:
>          AUD_log (NULL, "U32");
>          break;
> +    case AUDIO_FORMAT_F32:
> +        AUD_log (NULL, "F32");
> +        break;
>      default:
>          AUD_log (NULL, "invalid(%d)", as->fmt);
>          break;
> @@ -252,6 +255,7 @@ static int audio_validate_settings (struct audsetting=
s
> *as)
>      case AUDIO_FORMAT_U16:
>      case AUDIO_FORMAT_S32:
>      case AUDIO_FORMAT_U32:
> +    case AUDIO_FORMAT_F32:
>          break;
>      default:
>          invalid =3D 1;
> @@ -264,24 +268,28 @@ static int audio_validate_settings (struct
> audsettings *as)
>
>  static int audio_pcm_info_eq (struct audio_pcm_info *info, struct
> audsettings *as)
>  {
> -    int bits =3D 8, sign =3D 0;
> +    int bits =3D 8;
> +    bool is_signed =3D false, is_float =3D false;
>
>      switch (as->fmt) {
>      case AUDIO_FORMAT_S8:
> -        sign =3D 1;
> +        is_signed =3D true;
>          /* fall through */
>      case AUDIO_FORMAT_U8:
>          break;
>
>      case AUDIO_FORMAT_S16:
> -        sign =3D 1;
> +        is_signed =3D true;
>          /* fall through */
>      case AUDIO_FORMAT_U16:
>          bits =3D 16;
>          break;
>
> +    case AUDIO_FORMAT_F32:
> +        is_float =3D true;
> +        /* fall through */
>      case AUDIO_FORMAT_S32:
> -        sign =3D 1;
> +        is_signed =3D true;
>          /* fall through */
>      case AUDIO_FORMAT_U32:
>          bits =3D 32;
> @@ -292,33 +300,38 @@ static int audio_pcm_info_eq (struct audio_pcm_info
> *info, struct audsettings *a
>      }
>      return info->freq =3D=3D as->freq
>          && info->nchannels =3D=3D as->nchannels
> -        && info->sign =3D=3D sign
> +        && info->is_signed =3D=3D is_signed
> +        && info->is_float =3D=3D is_float
>          && info->bits =3D=3D bits
>          && info->swap_endianness =3D=3D (as->endianness !=3D
> AUDIO_HOST_ENDIANNESS);
>  }
>
>  void audio_pcm_init_info (struct audio_pcm_info *info, struct audsetting=
s
> *as)
>  {
> -    int bits =3D 8, sign =3D 0, mul;
> +    int bits =3D 8, mul;
> +    bool is_signed =3D false, is_float =3D false;
>
>      switch (as->fmt) {
>      case AUDIO_FORMAT_S8:
> -        sign =3D 1;
> +        is_signed =3D true;
>          /* fall through */
>      case AUDIO_FORMAT_U8:
>          mul =3D 1;
>          break;
>
>      case AUDIO_FORMAT_S16:
> -        sign =3D 1;
> +        is_signed =3D true;
>          /* fall through */
>      case AUDIO_FORMAT_U16:
>          bits =3D 16;
>          mul =3D 2;
>          break;
>
> +    case AUDIO_FORMAT_F32:
> +        is_float =3D true;
> +        /* fall through */
>      case AUDIO_FORMAT_S32:
> -        sign =3D 1;
> +        is_signed =3D true;
>          /* fall through */
>      case AUDIO_FORMAT_U32:
>          bits =3D 32;
> @@ -331,7 +344,8 @@ void audio_pcm_init_info (struct audio_pcm_info *info=
,
> struct audsettings *as)
>
>      info->freq =3D as->freq;
>      info->bits =3D bits;
> -    info->sign =3D sign;
> +    info->is_signed =3D is_signed;
> +    info->is_float =3D is_float;
>      info->nchannels =3D as->nchannels;
>      info->bytes_per_frame =3D as->nchannels * mul;
>      info->bytes_per_second =3D info->freq * info->bytes_per_frame;
> @@ -344,7 +358,7 @@ void audio_pcm_info_clear_buf (struct audio_pcm_info
> *info, void *buf, int len)
>          return;
>      }
>
> -    if (info->sign) {
> +    if (info->is_signed || info->is_float) {
>          memset(buf, 0x00, len * info->bytes_per_frame);
>      }
>      else {
> @@ -770,8 +784,9 @@ static size_t audio_pcm_sw_write(SWVoiceOut *sw, void
> *buf, size_t size)
>  #ifdef DEBUG_AUDIO
>  static void audio_pcm_print_info (const char *cap, struct audio_pcm_info
> *info)
>  {
> -    dolog ("%s: bits %d, sign %d, freq %d, nchan %d\n",
> -           cap, info->bits, info->sign, info->freq, info->nchannels);
> +    dolog("%s: bits %d, sign %d, float %d, freq %d, nchan %d\n",
> +          cap, info->bits, info->is_signed, info->is_float, info->freq,
> +          info->nchannels);
>  }
>  #endif
>
> @@ -1837,11 +1852,15 @@ CaptureVoiceOut *AUD_add_capture(
>
>          cap->buf =3D g_malloc0_n(hw->mix_buf->size,
> hw->info.bytes_per_frame);
>
> -        hw->clip =3D mixeng_clip
> -            [hw->info.nchannels =3D=3D 2]
> -            [hw->info.sign]
> -            [hw->info.swap_endianness]
> -            [audio_bits_to_index (hw->info.bits)];
> +        if (hw->info.is_float) {
> +            hw->clip =3D mixeng_clip_float[hw->info.nchannels =3D=3D 2];
> +        } else {
> +            hw->clip =3D mixeng_clip
> +                [hw->info.nchannels =3D=3D 2]
> +                [hw->info.is_signed]
> +                [hw->info.swap_endianness]
> +                [audio_bits_to_index(hw->info.bits)];
> +        }
>
>          QLIST_INSERT_HEAD (&s->cap_head, cap, entries);
>          QLIST_INSERT_HEAD (&cap->cb_head, cb, entries);
> @@ -2080,6 +2099,7 @@ int audioformat_bytes_per_sample(AudioFormat fmt)
>
>      case AUDIO_FORMAT_U32:
>      case AUDIO_FORMAT_S32:
> +    case AUDIO_FORMAT_F32:
>          return 4;
>
>      case AUDIO_FORMAT__MAX:
> diff --git a/audio/coreaudio.c b/audio/coreaudio.c
> index 0049db97fa..f1a009610c 100644
> --- a/audio/coreaudio.c
> +++ b/audio/coreaudio.c
> @@ -491,14 +491,9 @@ static int coreaudio_init_out(HWVoiceOut *hw, struct
> audsettings *as,
>          return -1;
>      }
>
> -    /*
> -     * The canonical audio format for CoreAudio on macOS is float.
> Currently
> -     * there is no generic code for AUDIO_FORMAT_F32 in qemu. Here we
> select
> -     * AUDIO_FORMAT_S32 instead because only the sample size has to matc=
h.
> -     */
>      fake_as =3D *as;
>      as =3D &fake_as;
> -    as->fmt =3D AUDIO_FORMAT_S32;
> +    as->fmt =3D AUDIO_FORMAT_F32;
>      audio_pcm_init_info (&hw->info, as);
>
>      status =3D coreaudio_get_voice(&core->outputDeviceID);
> diff --git a/audio/mixeng.c b/audio/mixeng.c
> index 16b646d48c..c14b0d874c 100644
> --- a/audio/mixeng.c
> +++ b/audio/mixeng.c
> @@ -267,55 +267,77 @@ f_sample *mixeng_clip[2][2][2][3] =3D {
>      }
>  };
>
> -void conv_natural_float_to_stereo(struct st_sample *dst, const void *src=
,
> -                                  int samples)
> +#ifdef FLOAT_MIXENG
> +#define FLOAT_CONV_TO(x) (x)
> +#define FLOAT_CONV_FROM(x) (x)
> +#else
> +static const float float_scale =3D UINT_MAX;
> +#define FLOAT_CONV_TO(x) ((x) * float_scale)
> +
> +#ifdef RECIPROCAL
> +static const float float_scale_reciprocal =3D 1.f / UINT_MAX;
> +#define FLOAT_CONV_FROM(x) ((x) * float_scale_reciprocal)
> +#else
> +#define FLOAT_CONV_FROM(x) ((x) / float_scale)
> +#endif
> +#endif
> +
> +static void conv_natural_float_to_mono(struct st_sample *dst, const void
> *src,
> +                                       int samples)
>  {
>      float *in =3D (float *)src;
> -#ifndef FLOAT_MIXENG
> -    const float scale =3D UINT_MAX;
> -#endif
>
>      while (samples--) {
> -#ifdef FLOAT_MIXENG
> -        dst->l =3D *in++;
> -        dst->r =3D *in++;
> -#else
> -        dst->l =3D *in++ * scale;
> -        dst->r =3D *in++ * scale;
> -#endif
> +        dst->r =3D dst->l =3D FLOAT_CONV_TO(*in++);
> +        dst++;
> +    }
> +}
> +
> +static void conv_natural_float_to_stereo(struct st_sample *dst, const
> void *src,
> +                                         int samples)
> +{
> +    float *in =3D (float *)src;
> +
> +    while (samples--) {
> +        dst->l =3D FLOAT_CONV_TO(*in++);
> +        dst->r =3D FLOAT_CONV_TO(*in++);
>          dst++;
>      }
>  }
>
> -void clip_natural_float_from_stereo(void *dst, const struct st_sample
> *src,
> -                                    int samples)
> +t_sample *mixeng_conv_float[2] =3D {
> +    conv_natural_float_to_mono,
> +    conv_natural_float_to_stereo,
> +};
> +
> +static void clip_natural_float_from_mono(void *dst, const struct
> st_sample *src,
> +                                         int samples)
>  {
>      float *out =3D (float *)dst;
> -#ifndef FLOAT_MIXENG
> -#ifdef RECIPROCAL
> -    const float scale =3D 1.f / UINT_MAX;
> -#else
> -    const float scale =3D UINT_MAX;
> -#endif
> -#endif
>
>      while (samples--) {
> -#ifdef FLOAT_MIXENG
> -        *out++ =3D src->l;
> -        *out++ =3D src->r;
> -#else
> -#ifdef RECIPROCAL
> -        *out++ =3D src->l * scale;
> -        *out++ =3D src->r * scale;
> -#else
> -        *out++ =3D src->l / scale;
> -        *out++ =3D src->r / scale;
> -#endif
> -#endif
> +        *out++ =3D FLOAT_CONV_FROM(src->l) + FLOAT_CONV_FROM(src->r);
> +        src++;
> +    }
> +}
> +
> +static void clip_natural_float_from_stereo(
> +    void *dst, const struct st_sample *src, int samples)
> +{
> +    float *out =3D (float *)dst;
> +
> +    while (samples--) {
> +        *out++ =3D FLOAT_CONV_FROM(src->l);
> +        *out++ =3D FLOAT_CONV_FROM(src->r);
>          src++;
>      }
>  }
>
> +f_sample *mixeng_clip_float[2] =3D {
> +    clip_natural_float_from_mono,
> +    clip_natural_float_from_stereo,
> +};
> +
>  void audio_sample_to_uint64(void *samples, int pos,
>                              uint64_t *left, uint64_t *right)
>  {
> diff --git a/audio/paaudio.c b/audio/paaudio.c
> index dbfe48c03a..1278c5a775 100644
> --- a/audio/paaudio.c
> +++ b/audio/paaudio.c
> @@ -279,6 +279,9 @@ static pa_sample_format_t audfmt_to_pa (AudioFormat
> afmt, int endianness)
>      case AUDIO_FORMAT_U32:
>          format =3D endianness ? PA_SAMPLE_S32BE : PA_SAMPLE_S32LE;
>          break;
> +    case AUDIO_FORMAT_F32:
> +        format =3D endianness ? PA_SAMPLE_FLOAT32BE : PA_SAMPLE_FLOAT32L=
E;
> +        break;
>      default:
>          dolog ("Internal logic error: Bad audio format %d\n", afmt);
>          format =3D PA_SAMPLE_U8;
> @@ -304,6 +307,12 @@ static AudioFormat pa_to_audfmt (pa_sample_format_t
> fmt, int *endianness)
>      case PA_SAMPLE_S32LE:
>          *endianness =3D 0;
>          return AUDIO_FORMAT_S32;
> +    case PA_SAMPLE_FLOAT32BE:
> +        *endianness =3D 1;
> +        return AUDIO_FORMAT_F32;
> +    case PA_SAMPLE_FLOAT32LE:
> +        *endianness =3D 0;
> +        return AUDIO_FORMAT_F32;
>      default:
>          dolog ("Internal logic error: Bad pa_sample_format %d\n", fmt);
>          return AUDIO_FORMAT_U8;
> diff --git a/audio/sdlaudio.c b/audio/sdlaudio.c
> index 5c6bcfcb3e..6af1911db9 100644
> --- a/audio/sdlaudio.c
> +++ b/audio/sdlaudio.c
> @@ -77,6 +77,14 @@ static int aud_to_sdlfmt (AudioFormat fmt)
>      case AUDIO_FORMAT_U16:
>          return AUDIO_U16LSB;
>
> +    case AUDIO_FORMAT_S32:
> +        return AUDIO_S32LSB;
> +
> +    /* no unsigned 32-bit support in SDL */
> +
> +    case AUDIO_FORMAT_F32:
> +        return AUDIO_F32LSB;
> +
>      default:
>          dolog ("Internal logic error: Bad audio format %d\n", fmt);
>  #ifdef DEBUG_AUDIO
> @@ -119,6 +127,26 @@ static int sdl_to_audfmt(int sdlfmt, AudioFormat
> *fmt, int *endianness)
>          *fmt =3D AUDIO_FORMAT_U16;
>          break;
>
> +    case AUDIO_S32LSB:
> +        *endianness =3D 0;
> +        *fmt =3D AUDIO_FORMAT_S32;
> +        break;
> +
> +    case AUDIO_S32MSB:
> +        *endianness =3D 1;
> +        *fmt =3D AUDIO_FORMAT_S32;
> +        break;
> +
> +    case AUDIO_F32LSB:
> +        *endianness =3D 0;
> +        *fmt =3D AUDIO_FORMAT_F32;
> +        break;
> +
> +    case AUDIO_F32MSB:
> +        *endianness =3D 1;
> +        *fmt =3D AUDIO_FORMAT_F32;
> +        break;
> +
>      default:
>          dolog ("Unrecognized SDL audio format %d\n", sdlfmt);
>          return -1;
> --
> 2.25.0
>
>
> Hi,

I applied the 2 patches to https://github.com/mcayland/qemu/tree/screamer
to test audio support in qemu-system-ppc running Mac OS 9.2 and OSX 10.5.
Host is OSX Sierra. Coreaudio seems happy with them.

Best,
Howard

--000000000000b658ca059d9f20be
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Sun, Feb 2, 2020 at 8:38 PM K=C5=
=91v=C3=A1g=C3=B3, Zolt=C3=A1n &lt;<a href=3D"mailto:dirty.ice.hu@gmail.com=
" target=3D"_blank">dirty.ice.hu@gmail.com</a>&gt; wrote:<br></div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex">This adds proper support for floa=
t samples in mixeng by adding a new<br>
audio format for it.<br>
<br>
Limitations: only native endianness is supported.<br>
<br>
Signed-off-by: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n &lt;<a href=3D"mailto:Dir=
tY.iCE.hu@gmail.com" target=3D"_blank">DirtY.iCE.hu@gmail.com</a>&gt;<br>
---<br>
<br>
This patch is meant to be applied on top of &quot;[PATCH] coreaudio: fix co=
reaudio<br>
playback&quot; by Volker R=C3=BCmelin, available at:<br>
<a href=3D"https://lists.nongnu.org/archive/html/qemu-devel/2020-02/msg0011=
4.html" rel=3D"noreferrer" target=3D"_blank">https://lists.nongnu.org/archi=
ve/html/qemu-devel/2020-02/msg00114.html</a><br>
<br>
For more information, please refer to that thread.<br>
<br>
---<br>
=C2=A0qapi/audio.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 +-<br>
=C2=A0audio/audio_int.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 3 +-<br>
=C2=A0audio/audio_template.h | 41 ++++++++++++--------<br>
=C2=A0audio/mixeng.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 8 ++--<br>
=C2=A0audio/alsaaudio.c=C2=A0 =C2=A0 =C2=A0 | 17 ++++++++<br>
=C2=A0audio/audio.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 56 ++++++++++++++++=
++---------<br>
=C2=A0audio/coreaudio.c=C2=A0 =C2=A0 =C2=A0 |=C2=A0 7 +---<br>
=C2=A0audio/mixeng.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 88 ++++++++++++++++=
++++++++++----------------<br>
=C2=A0audio/paaudio.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 9 +++++<br>
=C2=A0audio/sdlaudio.c=C2=A0 =C2=A0 =C2=A0 =C2=A0| 28 ++++++++++++++<br>
=C2=A010 files changed, 180 insertions(+), 79 deletions(-)<br>
<br>
diff --git a/qapi/audio.json b/qapi/audio.json<br>
index 83312b2339..d8c507cced 100644<br>
--- a/qapi/audio.json<br>
+++ b/qapi/audio.json<br>
@@ -276,7 +276,7 @@<br>
=C2=A0# Since: 4.0<br>
=C2=A0##<br>
=C2=A0{ &#39;enum&#39;: &#39;AudioFormat&#39;,<br>
-=C2=A0 &#39;data&#39;: [ &#39;u8&#39;, &#39;s8&#39;, &#39;u16&#39;, &#39;s=
16&#39;, &#39;u32&#39;, &#39;s32&#39; ] }<br>
+=C2=A0 &#39;data&#39;: [ &#39;u8&#39;, &#39;s8&#39;, &#39;u16&#39;, &#39;s=
16&#39;, &#39;u32&#39;, &#39;s32&#39;, &#39;f32&#39; ] }<br>
<br>
=C2=A0##<br>
=C2=A0# @AudiodevDriver:<br>
diff --git a/audio/audio_int.h b/audio/audio_int.h<br>
index 5ba2078346..cd92e48163 100644<br>
--- a/audio/audio_int.h<br>
+++ b/audio/audio_int.h<br>
@@ -40,7 +40,8 @@ struct audio_callback {<br>
<br>
=C2=A0struct audio_pcm_info {<br>
=C2=A0 =C2=A0 =C2=A0int bits;<br>
-=C2=A0 =C2=A0 int sign;<br>
+=C2=A0 =C2=A0 bool is_signed;<br>
+=C2=A0 =C2=A0 bool is_float;<br>
=C2=A0 =C2=A0 =C2=A0int freq;<br>
=C2=A0 =C2=A0 =C2=A0int nchannels;<br>
=C2=A0 =C2=A0 =C2=A0int bytes_per_frame;<br>
diff --git a/audio/audio_template.h b/audio/audio_template.h<br>
index 0336d2670c..7013d3041f 100644<br>
--- a/audio/audio_template.h<br>
+++ b/audio/audio_template.h<br>
@@ -153,15 +153,23 @@ static int glue (audio_pcm_sw_init_, TYPE) (<br>
=C2=A0 =C2=A0 =C2=A0sw-&gt;ratio =3D ((int64_t) sw-&gt;info.freq &lt;&lt; 3=
2) / sw-&gt;hw-&gt;info.freq;<br>
=C2=A0#endif<br>
<br>
+=C2=A0 =C2=A0 if (sw-&gt;info.is_float) {<br>
=C2=A0#ifdef DAC<br>
-=C2=A0 =C2=A0 sw-&gt;conv =3D mixeng_conv<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sw-&gt;conv =3D mixeng_conv_float[sw-&gt;info.=
nchannels =3D=3D 2];<br>
=C2=A0#else<br>
-=C2=A0 =C2=A0 sw-&gt;clip =3D mixeng_clip<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sw-&gt;clip =3D mixeng_clip_float[sw-&gt;info.=
nchannels =3D=3D 2];<br>
=C2=A0#endif<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 [sw-&gt;info.nchannels =3D=3D 2]<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 [sw-&gt;info.sign]<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 [sw-&gt;info.swap_endianness]<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 [audio_bits_to_index (sw-&gt;info.bits)];<br>
+=C2=A0 =C2=A0 } else {<br>
+#ifdef DAC<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sw-&gt;conv =3D mixeng_conv<br>
+#else<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sw-&gt;clip =3D mixeng_clip<br>
+#endif<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [sw-&gt;info.nchannels =3D=3D 2]=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [sw-&gt;info.is_signed]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [sw-&gt;info.swap_endianness]<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [audio_bits_to_index(sw-&gt;info=
.bits)];<br>
+=C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0sw-&gt;name =3D g_strdup (name);<br>
=C2=A0 =C2=A0 =C2=A0err =3D glue (audio_pcm_sw_alloc_resources_, TYPE) (sw)=
;<br>
@@ -276,22 +284,23 @@ static HW *glue(audio_pcm_hw_add_new_, TYPE)(AudioSta=
te *s,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err1;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 if (s-&gt;dev-&gt;driver =3D=3D AUDIODEV_DRIVER_COREAUDIO) {=
<br>
+=C2=A0 =C2=A0 if (hw-&gt;info.is_float) {<br>
=C2=A0#ifdef DAC<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 hw-&gt;clip =3D clip_natural_float_from_stereo=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 hw-&gt;clip =3D mixeng_clip_float[hw-&gt;info.=
nchannels =3D=3D 2];<br>
=C2=A0#else<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 hw-&gt;conv =3D conv_natural_float_to_stereo;<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 hw-&gt;conv =3D mixeng_conv_float[hw-&gt;info.=
nchannels =3D=3D 2];<br>
=C2=A0#endif<br>
-=C2=A0 =C2=A0 } else<br>
+=C2=A0 =C2=A0 } else {<br>
=C2=A0#ifdef DAC<br>
-=C2=A0 =C2=A0 hw-&gt;clip =3D mixeng_clip<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 hw-&gt;clip =3D mixeng_clip<br>
=C2=A0#else<br>
-=C2=A0 =C2=A0 hw-&gt;conv =3D mixeng_conv<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 hw-&gt;conv =3D mixeng_conv<br>
=C2=A0#endif<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 [hw-&gt;info.nchannels =3D=3D 2]<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 [hw-&gt;info.sign]<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 [hw-&gt;info.swap_endianness]<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 [audio_bits_to_index (hw-&gt;info.bits)];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [hw-&gt;info.nchannels =3D=3D 2]=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [hw-&gt;info.is_signed]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [hw-&gt;info.swap_endianness]<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [audio_bits_to_index(hw-&gt;info=
.bits)];<br>
+=C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0glue(audio_pcm_hw_alloc_resources_, TYPE)(hw);<br>
<br>
diff --git a/audio/mixeng.h b/audio/mixeng.h<br>
index 7ef61763e8..2dcd6df245 100644<br>
--- a/audio/mixeng.h<br>
+++ b/audio/mixeng.h<br>
@@ -38,13 +38,13 @@ typedef struct st_sample st_sample;<br>
=C2=A0typedef void (t_sample) (struct st_sample *dst, const void *src, int =
samples);<br>
=C2=A0typedef void (f_sample) (void *dst, const struct st_sample *src, int =
samples);<br>
<br>
+/* indices: [stereo][signed][swap endiannes][8, 16 or 32-bits] */<br>
=C2=A0extern t_sample *mixeng_conv[2][2][2][3];<br>
=C2=A0extern f_sample *mixeng_clip[2][2][2][3];<br>
<br>
-void conv_natural_float_to_stereo(struct st_sample *dst, const void *src,<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int samples);<br>
-void clip_natural_float_from_stereo(void *dst, const struct st_sample *src=
,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int samples);<br>
+/* indices: [stereo] */<br>
+extern t_sample *mixeng_conv_float[2];<br>
+extern f_sample *mixeng_clip_float[2];<br>
<br>
=C2=A0void *st_rate_start (int inrate, int outrate);<br>
=C2=A0void st_rate_flow(void *opaque, st_sample *ibuf, st_sample *obuf,<br>
diff --git a/audio/alsaaudio.c b/audio/alsaaudio.c<br>
index f37ce1ce85..768b896a93 100644<br>
--- a/audio/alsaaudio.c<br>
+++ b/audio/alsaaudio.c<br>
@@ -307,6 +307,13 @@ static snd_pcm_format_t aud_to_alsafmt (AudioFormat fm=
t, int endianness)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return SND_PCM_FORMAT_U32_L=
E;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
+=C2=A0 =C2=A0 case AUDIO_FORMAT_F32:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (endianness) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return SND_PCM_FORMAT_FLOAT_BE;<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return SND_PCM_FORMAT_FLOAT_LE;<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0default:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dolog (&quot;Internal logic error: Bad au=
dio format %d\n&quot;, fmt);<br>
=C2=A0#ifdef DEBUG_AUDIO<br>
@@ -370,6 +377,16 @@ static int alsa_to_audfmt (snd_pcm_format_t alsafmt, A=
udioFormat *fmt,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*fmt =3D AUDIO_FORMAT_U32;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
<br>
+=C2=A0 =C2=A0 case SND_PCM_FORMAT_FLOAT_LE:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 *endianness =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 *fmt =3D AUDIO_FORMAT_F32;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+<br>
+=C2=A0 =C2=A0 case SND_PCM_FORMAT_FLOAT_BE:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 *endianness =3D 1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 *fmt =3D AUDIO_FORMAT_F32;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0default:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dolog (&quot;Unrecognized audio format %d=
\n&quot;, alsafmt);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
diff --git a/audio/audio.c b/audio/audio.c<br>
index f63f39769a..53fdb42ec7 100644<br>
--- a/audio/audio.c<br>
+++ b/audio/audio.c<br>
@@ -218,6 +218,9 @@ static void audio_print_settings (struct audsettings *a=
s)<br>
=C2=A0 =C2=A0 =C2=A0case AUDIO_FORMAT_U32:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AUD_log (NULL, &quot;U32&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
+=C2=A0 =C2=A0 case AUDIO_FORMAT_F32:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 AUD_log (NULL, &quot;F32&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
=C2=A0 =C2=A0 =C2=A0default:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AUD_log (NULL, &quot;invalid(%d)&quot;, a=
s-&gt;fmt);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
@@ -252,6 +255,7 @@ static int audio_validate_settings (struct audsettings =
*as)<br>
=C2=A0 =C2=A0 =C2=A0case AUDIO_FORMAT_U16:<br>
=C2=A0 =C2=A0 =C2=A0case AUDIO_FORMAT_S32:<br>
=C2=A0 =C2=A0 =C2=A0case AUDIO_FORMAT_U32:<br>
+=C2=A0 =C2=A0 case AUDIO_FORMAT_F32:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0default:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0invalid =3D 1;<br>
@@ -264,24 +268,28 @@ static int audio_validate_settings (struct audsetting=
s *as)<br>
<br>
=C2=A0static int audio_pcm_info_eq (struct audio_pcm_info *info, struct aud=
settings *as)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 int bits =3D 8, sign =3D 0;<br>
+=C2=A0 =C2=A0 int bits =3D 8;<br>
+=C2=A0 =C2=A0 bool is_signed =3D false, is_float =3D false;<br>
<br>
=C2=A0 =C2=A0 =C2=A0switch (as-&gt;fmt) {<br>
=C2=A0 =C2=A0 =C2=A0case AUDIO_FORMAT_S8:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 sign =3D 1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 is_signed =3D true;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* fall through */<br>
=C2=A0 =C2=A0 =C2=A0case AUDIO_FORMAT_U8:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
<br>
=C2=A0 =C2=A0 =C2=A0case AUDIO_FORMAT_S16:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 sign =3D 1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 is_signed =3D true;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* fall through */<br>
=C2=A0 =C2=A0 =C2=A0case AUDIO_FORMAT_U16:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bits =3D 16;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
<br>
+=C2=A0 =C2=A0 case AUDIO_FORMAT_F32:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 is_float =3D true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* fall through */<br>
=C2=A0 =C2=A0 =C2=A0case AUDIO_FORMAT_S32:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 sign =3D 1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 is_signed =3D true;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* fall through */<br>
=C2=A0 =C2=A0 =C2=A0case AUDIO_FORMAT_U32:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bits =3D 32;<br>
@@ -292,33 +300,38 @@ static int audio_pcm_info_eq (struct audio_pcm_info *=
info, struct audsettings *a<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0return info-&gt;freq =3D=3D as-&gt;freq<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;&amp; info-&gt;nchannels =3D=3D as-&=
gt;nchannels<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;&amp; info-&gt;sign =3D=3D sign<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;&amp; info-&gt;is_signed =3D=3D is_signed=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;&amp; info-&gt;is_float =3D=3D is_float<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;&amp; info-&gt;bits =3D=3D bits<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;&amp; info-&gt;swap_endianness =3D=
=3D (as-&gt;endianness !=3D AUDIO_HOST_ENDIANNESS);<br>
=C2=A0}<br>
<br>
=C2=A0void audio_pcm_init_info (struct audio_pcm_info *info, struct audsett=
ings *as)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 int bits =3D 8, sign =3D 0, mul;<br>
+=C2=A0 =C2=A0 int bits =3D 8, mul;<br>
+=C2=A0 =C2=A0 bool is_signed =3D false, is_float =3D false;<br>
<br>
=C2=A0 =C2=A0 =C2=A0switch (as-&gt;fmt) {<br>
=C2=A0 =C2=A0 =C2=A0case AUDIO_FORMAT_S8:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 sign =3D 1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 is_signed =3D true;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* fall through */<br>
=C2=A0 =C2=A0 =C2=A0case AUDIO_FORMAT_U8:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mul =3D 1;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
<br>
=C2=A0 =C2=A0 =C2=A0case AUDIO_FORMAT_S16:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 sign =3D 1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 is_signed =3D true;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* fall through */<br>
=C2=A0 =C2=A0 =C2=A0case AUDIO_FORMAT_U16:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bits =3D 16;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mul =3D 2;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
<br>
+=C2=A0 =C2=A0 case AUDIO_FORMAT_F32:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 is_float =3D true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* fall through */<br>
=C2=A0 =C2=A0 =C2=A0case AUDIO_FORMAT_S32:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 sign =3D 1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 is_signed =3D true;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* fall through */<br>
=C2=A0 =C2=A0 =C2=A0case AUDIO_FORMAT_U32:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bits =3D 32;<br>
@@ -331,7 +344,8 @@ void audio_pcm_init_info (struct audio_pcm_info *info, =
struct audsettings *as)<br>
<br>
=C2=A0 =C2=A0 =C2=A0info-&gt;freq =3D as-&gt;freq;<br>
=C2=A0 =C2=A0 =C2=A0info-&gt;bits =3D bits;<br>
-=C2=A0 =C2=A0 info-&gt;sign =3D sign;<br>
+=C2=A0 =C2=A0 info-&gt;is_signed =3D is_signed;<br>
+=C2=A0 =C2=A0 info-&gt;is_float =3D is_float;<br>
=C2=A0 =C2=A0 =C2=A0info-&gt;nchannels =3D as-&gt;nchannels;<br>
=C2=A0 =C2=A0 =C2=A0info-&gt;bytes_per_frame =3D as-&gt;nchannels * mul;<br=
>
=C2=A0 =C2=A0 =C2=A0info-&gt;bytes_per_second =3D info-&gt;freq * info-&gt;=
bytes_per_frame;<br>
@@ -344,7 +358,7 @@ void audio_pcm_info_clear_buf (struct audio_pcm_info *i=
nfo, void *buf, int len)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 if (info-&gt;sign) {<br>
+=C2=A0 =C2=A0 if (info-&gt;is_signed || info-&gt;is_float) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memset(buf, 0x00, len * info-&gt;bytes_pe=
r_frame);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0else {<br>
@@ -770,8 +784,9 @@ static size_t audio_pcm_sw_write(SWVoiceOut *sw, void *=
buf, size_t size)<br>
=C2=A0#ifdef DEBUG_AUDIO<br>
=C2=A0static void audio_pcm_print_info (const char *cap, struct audio_pcm_i=
nfo *info)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 dolog (&quot;%s: bits %d, sign %d, freq %d, nchan %d\n&quot;=
,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cap, info-&gt;bits, info-&gt;sign=
, info-&gt;freq, info-&gt;nchannels);<br>
+=C2=A0 =C2=A0 dolog(&quot;%s: bits %d, sign %d, float %d, freq %d, nchan %=
d\n&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cap, info-&gt;bits, info-&gt;is_signed,=
 info-&gt;is_float, info-&gt;freq,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 info-&gt;nchannels);<br>
=C2=A0}<br>
=C2=A0#endif<br>
<br>
@@ -1837,11 +1852,15 @@ CaptureVoiceOut *AUD_add_capture(<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cap-&gt;buf =3D g_malloc0_n(hw-&gt;mix_bu=
f-&gt;size, hw-&gt;info.bytes_per_frame);<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 hw-&gt;clip =3D mixeng_clip<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [hw-&gt;info.nchannels =3D=3D 2]=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [hw-&gt;info.sign]<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [hw-&gt;info.swap_endianness]<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [audio_bits_to_index (hw-&gt;inf=
o.bits)];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (hw-&gt;info.is_float) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hw-&gt;clip =3D mixeng_clip_floa=
t[hw-&gt;info.nchannels =3D=3D 2];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hw-&gt;clip =3D mixeng_clip<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [hw-&gt;info.nchan=
nels =3D=3D 2]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [hw-&gt;info.is_si=
gned]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [hw-&gt;info.swap_=
endianness]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [audio_bits_to_ind=
ex(hw-&gt;info.bits)];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0QLIST_INSERT_HEAD (&amp;s-&gt;cap_head, c=
ap, entries);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0QLIST_INSERT_HEAD (&amp;cap-&gt;cb_head, =
cb, entries);<br>
@@ -2080,6 +2099,7 @@ int audioformat_bytes_per_sample(AudioFormat fmt)<br>
<br>
=C2=A0 =C2=A0 =C2=A0case AUDIO_FORMAT_U32:<br>
=C2=A0 =C2=A0 =C2=A0case AUDIO_FORMAT_S32:<br>
+=C2=A0 =C2=A0 case AUDIO_FORMAT_F32:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 4;<br>
<br>
=C2=A0 =C2=A0 =C2=A0case AUDIO_FORMAT__MAX:<br>
diff --git a/audio/coreaudio.c b/audio/coreaudio.c<br>
index 0049db97fa..f1a009610c 100644<br>
--- a/audio/coreaudio.c<br>
+++ b/audio/coreaudio.c<br>
@@ -491,14 +491,9 @@ static int coreaudio_init_out(HWVoiceOut *hw, struct a=
udsettings *as,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 /*<br>
-=C2=A0 =C2=A0 =C2=A0* The canonical audio format for CoreAudio on macOS is=
 float. Currently<br>
-=C2=A0 =C2=A0 =C2=A0* there is no generic code for AUDIO_FORMAT_F32 in qem=
u. Here we select<br>
-=C2=A0 =C2=A0 =C2=A0* AUDIO_FORMAT_S32 instead because only the sample siz=
e has to match.<br>
-=C2=A0 =C2=A0 =C2=A0*/<br>
=C2=A0 =C2=A0 =C2=A0fake_as =3D *as;<br>
=C2=A0 =C2=A0 =C2=A0as =3D &amp;fake_as;<br>
-=C2=A0 =C2=A0 as-&gt;fmt =3D AUDIO_FORMAT_S32;<br>
+=C2=A0 =C2=A0 as-&gt;fmt =3D AUDIO_FORMAT_F32;<br>
=C2=A0 =C2=A0 =C2=A0audio_pcm_init_info (&amp;hw-&gt;info, as);<br>
<br>
=C2=A0 =C2=A0 =C2=A0status =3D coreaudio_get_voice(&amp;core-&gt;outputDevi=
ceID);<br>
diff --git a/audio/mixeng.c b/audio/mixeng.c<br>
index 16b646d48c..c14b0d874c 100644<br>
--- a/audio/mixeng.c<br>
+++ b/audio/mixeng.c<br>
@@ -267,55 +267,77 @@ f_sample *mixeng_clip[2][2][2][3] =3D {<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0};<br>
<br>
-void conv_natural_float_to_stereo(struct st_sample *dst, const void *src,<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int samples)<br>
+#ifdef FLOAT_MIXENG<br>
+#define FLOAT_CONV_TO(x) (x)<br>
+#define FLOAT_CONV_FROM(x) (x)<br>
+#else<br>
+static const float float_scale =3D UINT_MAX;<br>
+#define FLOAT_CONV_TO(x) ((x) * float_scale)<br>
+<br>
+#ifdef RECIPROCAL<br>
+static const float float_scale_reciprocal =3D 1.f / UINT_MAX;<br>
+#define FLOAT_CONV_FROM(x) ((x) * float_scale_reciprocal)<br>
+#else<br>
+#define FLOAT_CONV_FROM(x) ((x) / float_scale)<br>
+#endif<br>
+#endif<br>
+<br>
+static void conv_natural_float_to_mono(struct st_sample *dst, const void *=
src,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int sampl=
es)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0float *in =3D (float *)src;<br>
-#ifndef FLOAT_MIXENG<br>
-=C2=A0 =C2=A0 const float scale =3D UINT_MAX;<br>
-#endif<br>
<br>
=C2=A0 =C2=A0 =C2=A0while (samples--) {<br>
-#ifdef FLOAT_MIXENG<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 dst-&gt;l =3D *in++;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 dst-&gt;r =3D *in++;<br>
-#else<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 dst-&gt;l =3D *in++ * scale;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 dst-&gt;r =3D *in++ * scale;<br>
-#endif<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 dst-&gt;r =3D dst-&gt;l =3D FLOAT_CONV_TO(*in+=
+);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 dst++;<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+static void conv_natural_float_to_stereo(struct st_sample *dst, const void=
 *src,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0in=
t samples)<br>
+{<br>
+=C2=A0 =C2=A0 float *in =3D (float *)src;<br>
+<br>
+=C2=A0 =C2=A0 while (samples--) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 dst-&gt;l =3D FLOAT_CONV_TO(*in++);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 dst-&gt;r =3D FLOAT_CONV_TO(*in++);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dst++;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
-void clip_natural_float_from_stereo(void *dst, const struct st_sample *src=
,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int samples)<br>
+t_sample *mixeng_conv_float[2] =3D {<br>
+=C2=A0 =C2=A0 conv_natural_float_to_mono,<br>
+=C2=A0 =C2=A0 conv_natural_float_to_stereo,<br>
+};<br>
+<br>
+static void clip_natural_float_from_mono(void *dst, const struct st_sample=
 *src,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0in=
t samples)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0float *out =3D (float *)dst;<br>
-#ifndef FLOAT_MIXENG<br>
-#ifdef RECIPROCAL<br>
-=C2=A0 =C2=A0 const float scale =3D 1.f / UINT_MAX;<br>
-#else<br>
-=C2=A0 =C2=A0 const float scale =3D UINT_MAX;<br>
-#endif<br>
-#endif<br>
<br>
=C2=A0 =C2=A0 =C2=A0while (samples--) {<br>
-#ifdef FLOAT_MIXENG<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 *out++ =3D src-&gt;l;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 *out++ =3D src-&gt;r;<br>
-#else<br>
-#ifdef RECIPROCAL<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 *out++ =3D src-&gt;l * scale;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 *out++ =3D src-&gt;r * scale;<br>
-#else<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 *out++ =3D src-&gt;l / scale;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 *out++ =3D src-&gt;r / scale;<br>
-#endif<br>
-#endif<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 *out++ =3D FLOAT_CONV_FROM(src-&gt;l) + FLOAT_=
CONV_FROM(src-&gt;r);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 src++;<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+static void clip_natural_float_from_stereo(<br>
+=C2=A0 =C2=A0 void *dst, const struct st_sample *src, int samples)<br>
+{<br>
+=C2=A0 =C2=A0 float *out =3D (float *)dst;<br>
+<br>
+=C2=A0 =C2=A0 while (samples--) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 *out++ =3D FLOAT_CONV_FROM(src-&gt;l);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 *out++ =3D FLOAT_CONV_FROM(src-&gt;r);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0src++;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
+f_sample *mixeng_clip_float[2] =3D {<br>
+=C2=A0 =C2=A0 clip_natural_float_from_mono,<br>
+=C2=A0 =C2=A0 clip_natural_float_from_stereo,<br>
+};<br>
+<br>
=C2=A0void audio_sample_to_uint64(void *samples, int pos,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t *left, uint64_t *right)<br>
=C2=A0{<br>
diff --git a/audio/paaudio.c b/audio/paaudio.c<br>
index dbfe48c03a..1278c5a775 100644<br>
--- a/audio/paaudio.c<br>
+++ b/audio/paaudio.c<br>
@@ -279,6 +279,9 @@ static pa_sample_format_t audfmt_to_pa (AudioFormat afm=
t, int endianness)<br>
=C2=A0 =C2=A0 =C2=A0case AUDIO_FORMAT_U32:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0format =3D endianness ? PA_SAMPLE_S32BE :=
 PA_SAMPLE_S32LE;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
+=C2=A0 =C2=A0 case AUDIO_FORMAT_F32:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 format =3D endianness ? PA_SAMPLE_FLOAT32BE : =
PA_SAMPLE_FLOAT32LE;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
=C2=A0 =C2=A0 =C2=A0default:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dolog (&quot;Internal logic error: Bad au=
dio format %d\n&quot;, afmt);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0format =3D PA_SAMPLE_U8;<br>
@@ -304,6 +307,12 @@ static AudioFormat pa_to_audfmt (pa_sample_format_t fm=
t, int *endianness)<br>
=C2=A0 =C2=A0 =C2=A0case PA_SAMPLE_S32LE:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*endianness =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return AUDIO_FORMAT_S32;<br>
+=C2=A0 =C2=A0 case PA_SAMPLE_FLOAT32BE:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 *endianness =3D 1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return AUDIO_FORMAT_F32;<br>
+=C2=A0 =C2=A0 case PA_SAMPLE_FLOAT32LE:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 *endianness =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return AUDIO_FORMAT_F32;<br>
=C2=A0 =C2=A0 =C2=A0default:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dolog (&quot;Internal logic error: Bad pa=
_sample_format %d\n&quot;, fmt);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return AUDIO_FORMAT_U8;<br>
diff --git a/audio/sdlaudio.c b/audio/sdlaudio.c<br>
index 5c6bcfcb3e..6af1911db9 100644<br>
--- a/audio/sdlaudio.c<br>
+++ b/audio/sdlaudio.c<br>
@@ -77,6 +77,14 @@ static int aud_to_sdlfmt (AudioFormat fmt)<br>
=C2=A0 =C2=A0 =C2=A0case AUDIO_FORMAT_U16:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return AUDIO_U16LSB;<br>
<br>
+=C2=A0 =C2=A0 case AUDIO_FORMAT_S32:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return AUDIO_S32LSB;<br>
+<br>
+=C2=A0 =C2=A0 /* no unsigned 32-bit support in SDL */<br>
+<br>
+=C2=A0 =C2=A0 case AUDIO_FORMAT_F32:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return AUDIO_F32LSB;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0default:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dolog (&quot;Internal logic error: Bad au=
dio format %d\n&quot;, fmt);<br>
=C2=A0#ifdef DEBUG_AUDIO<br>
@@ -119,6 +127,26 @@ static int sdl_to_audfmt(int sdlfmt, AudioFormat *fmt,=
 int *endianness)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*fmt =3D AUDIO_FORMAT_U16;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
<br>
+=C2=A0 =C2=A0 case AUDIO_S32LSB:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 *endianness =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 *fmt =3D AUDIO_FORMAT_S32;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+<br>
+=C2=A0 =C2=A0 case AUDIO_S32MSB:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 *endianness =3D 1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 *fmt =3D AUDIO_FORMAT_S32;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+<br>
+=C2=A0 =C2=A0 case AUDIO_F32LSB:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 *endianness =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 *fmt =3D AUDIO_FORMAT_F32;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+<br>
+=C2=A0 =C2=A0 case AUDIO_F32MSB:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 *endianness =3D 1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 *fmt =3D AUDIO_FORMAT_F32;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0default:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dolog (&quot;Unrecognized SDL audio forma=
t %d\n&quot;, sdlfmt);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
-- <br>
2.25.0<br>
<br>
<br></blockquote><div>Hi,</div><div><br></div><div>I applied the 2 patches =
to <a href=3D"https://github.com/mcayland/qemu/tree/screamer" target=3D"_bl=
ank">https://github.com/mcayland/qemu/tree/screamer</a> to test audio suppo=
rt in qemu-system-ppc running Mac OS 9.2 and OSX 10.5. Host is OSX Sierra. =
Coreaudio seems happy with them.</div><div><br></div><div>Best,</div><div>H=
oward<br></div></div></div>

--000000000000b658ca059d9f20be--

