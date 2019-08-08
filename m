Return-Path: <SRS0=Rh1V=WE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD6CC0650F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 23:16:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B28EA216C8
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 23:16:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B28EA216C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvrdh-0000S1-1F
	for qemu-devel@archiver.kernel.org; Thu, 08 Aug 2019 19:16:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52164)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jsnow@redhat.com>) id 1hvrdD-0008Hy-Fm
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 19:15:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1hvrdC-0008U1-9K
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 19:15:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37371)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1hvrd9-0008T4-Mq; Thu, 08 Aug 2019 19:15:35 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id F04988553D;
 Thu,  8 Aug 2019 23:15:34 +0000 (UTC)
Received: from [10.18.17.169] (dhcp-17-169.bos.redhat.com [10.18.17.169])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BC8AD60BE1;
 Thu,  8 Aug 2019 23:15:31 +0000 (UTC)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20190808130454.9930-1-philmd@redhat.com>
From: John Snow <jsnow@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jsnow@redhat.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <8c492ae0-63c1-7910-aa96-0382b1ad98a2@redhat.com>
Date: Thu, 8 Aug 2019 19:15:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190808130454.9930-1-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Thu, 08 Aug 2019 23:15:35 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] hw/ide/atapi: Use the ldst API
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
Cc: qemu-trivial@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 8/8/19 9:04 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> The big-endian load/store functions are already provided
> by "qemu/bswap.h".
> Avoid code duplication, use the generic API.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/ide/atapi.c | 80 ++++++++++++++++++--------------------------------
>  1 file changed, 28 insertions(+), 52 deletions(-)
>=20
> diff --git a/hw/ide/atapi.c b/hw/ide/atapi.c
> index 1b0f66cc08..17a9d635d8 100644
> --- a/hw/ide/atapi.c
> +++ b/hw/ide/atapi.c
> @@ -45,30 +45,6 @@ static void padstr8(uint8_t *buf, int buf_size, cons=
t char *src)
>      }
>  }
> =20
> -static inline void cpu_to_ube16(uint8_t *buf, int val)
> -{
> -    buf[0] =3D val >> 8;
> -    buf[1] =3D val & 0xff;
> -}
> -
> -static inline void cpu_to_ube32(uint8_t *buf, unsigned int val)
> -{
> -    buf[0] =3D val >> 24;
> -    buf[1] =3D val >> 16;
> -    buf[2] =3D val >> 8;
> -    buf[3] =3D val & 0xff;
> -}
> -
> -static inline int ube16_to_cpu(const uint8_t *buf)
> -{
> -    return (buf[0] << 8) | buf[1];
> -}
> -
> -static inline int ube32_to_cpu(const uint8_t *buf)
> -{
> -    return (buf[0] << 24) | (buf[1] << 16) | (buf[2] << 8) | buf[3];
> -}
> -
>  static void lba_to_msf(uint8_t *buf, int lba)
>  {
>      lba +=3D 150;
> @@ -485,7 +461,7 @@ static inline uint8_t ide_atapi_set_profile(uint8_t=
 *buf, uint8_t *index,
>      uint8_t *buf_profile =3D buf + 12; /* start of profiles */
> =20
>      buf_profile +=3D ((*index) * 4); /* start of indexed profile */
> -    cpu_to_ube16 (buf_profile, profile);
> +    stw_be_p(buf_profile, profile);
>      buf_profile[2] =3D ((buf_profile[0] =3D=3D buf[6]) && (buf_profile=
[1] =3D=3D buf[7]));
> =20
>      /* each profile adds 4 bytes to the response */
> @@ -518,9 +494,9 @@ static int ide_dvd_read_structure(IDEState *s, int =
format,
>                  buf[7] =3D 0;   /* default densities */
> =20
>                  /* FIXME: 0x30000 per spec? */
> -                cpu_to_ube32(buf + 8, 0); /* start sector */
> -                cpu_to_ube32(buf + 12, total_sectors - 1); /* end sect=
or */
> -                cpu_to_ube32(buf + 16, total_sectors - 1); /* l0 end s=
ector */
> +                stl_be_p(buf + 8, 0); /* start sector */
> +                stl_be_p(buf + 12, total_sectors - 1); /* end sector *=
/
> +                stl_be_p(buf + 16, total_sectors - 1); /* l0 end secto=
r */
> =20
>                  /* Size of buffer, not including 2 byte size field */
>                  stw_be_p(buf, 2048 + 2);
> @@ -839,7 +815,7 @@ static void cmd_get_configuration(IDEState *s, uint=
8_t *buf)
>      }
> =20
>      /* XXX: could result in alignment problems in some architectures *=
/
> -    max_len =3D ube16_to_cpu(buf + 7);
> +    max_len =3D lduw_be_p(buf + 7);
> =20
>      /*
>       * XXX: avoid overflow for io_buffer if max_len is bigger than
> @@ -859,16 +835,16 @@ static void cmd_get_configuration(IDEState *s, ui=
nt8_t *buf)
>       * to use as current.  0 means there is no media
>       */
>      if (media_is_dvd(s)) {
> -        cpu_to_ube16(buf + 6, MMC_PROFILE_DVD_ROM);
> +        stw_be_p(buf + 6, MMC_PROFILE_DVD_ROM);
>      } else if (media_is_cd(s)) {
> -        cpu_to_ube16(buf + 6, MMC_PROFILE_CD_ROM);
> +        stw_be_p(buf + 6, MMC_PROFILE_CD_ROM);
>      }
> =20
>      buf[10] =3D 0x02 | 0x01; /* persistent and current */
>      len =3D 12; /* headers: 8 + 4 */
>      len +=3D ide_atapi_set_profile(buf, &index, MMC_PROFILE_DVD_ROM);
>      len +=3D ide_atapi_set_profile(buf, &index, MMC_PROFILE_CD_ROM);
> -    cpu_to_ube32(buf, len - 4); /* data length */
> +    stl_be_p(buf, len - 4); /* data length */
> =20
>      ide_atapi_cmd_reply(s, len, max_len);
>  }
> @@ -878,7 +854,7 @@ static void cmd_mode_sense(IDEState *s, uint8_t *bu=
f)
>      int action, code;
>      int max_len;
> =20
> -    max_len =3D ube16_to_cpu(buf + 7);
> +    max_len =3D lduw_be_p(buf + 7);
>      action =3D buf[2] >> 6;
>      code =3D buf[2] & 0x3f;
> =20
> @@ -886,7 +862,7 @@ static void cmd_mode_sense(IDEState *s, uint8_t *bu=
f)
>      case 0: /* current values */
>          switch(code) {
>          case MODE_PAGE_R_W_ERROR: /* error recovery */
> -            cpu_to_ube16(&buf[0], 16 - 2);
> +            stw_be_p(&buf[0], 16 - 2);
>              buf[2] =3D 0x70;
>              buf[3] =3D 0;
>              buf[4] =3D 0;
> @@ -905,7 +881,7 @@ static void cmd_mode_sense(IDEState *s, uint8_t *bu=
f)
>              ide_atapi_cmd_reply(s, 16, max_len);
>              break;
>          case MODE_PAGE_AUDIO_CTL:
> -            cpu_to_ube16(&buf[0], 24 - 2);
> +            stw_be_p(&buf[0], 24 - 2);
>              buf[2] =3D 0x70;
>              buf[3] =3D 0;
>              buf[4] =3D 0;
> @@ -924,7 +900,7 @@ static void cmd_mode_sense(IDEState *s, uint8_t *bu=
f)
>              ide_atapi_cmd_reply(s, 24, max_len);
>              break;
>          case MODE_PAGE_CAPABILITIES:
> -            cpu_to_ube16(&buf[0], 30 - 2);
> +            stw_be_p(&buf[0], 30 - 2);
>              buf[2] =3D 0x70;
>              buf[3] =3D 0;
>              buf[4] =3D 0;
> @@ -946,11 +922,11 @@ static void cmd_mode_sense(IDEState *s, uint8_t *=
buf)
>                  buf[14] |=3D 1 << 1;
>              }
>              buf[15] =3D 0x00; /* No volume & mute control, no changer =
*/
> -            cpu_to_ube16(&buf[16], 704); /* 4x read speed */
> +            stw_be_p(&buf[16], 704); /* 4x read speed */
>              buf[18] =3D 0; /* Two volume levels */
>              buf[19] =3D 2;
> -            cpu_to_ube16(&buf[20], 512); /* 512k buffer */
> -            cpu_to_ube16(&buf[22], 704); /* 4x read speed current */
> +            stw_be_p(&buf[20], 512); /* 512k buffer */
> +            stw_be_p(&buf[22], 704); /* 4x read speed current */
>              buf[24] =3D 0;
>              buf[25] =3D 0;
>              buf[26] =3D 0;
> @@ -998,12 +974,12 @@ static void cmd_read(IDEState *s, uint8_t* buf)
>      int nb_sectors, lba;
> =20
>      if (buf[0] =3D=3D GPCMD_READ_10) {
> -        nb_sectors =3D ube16_to_cpu(buf + 7);
> +        nb_sectors =3D lduw_be_p(buf + 7);
>      } else {
> -        nb_sectors =3D ube32_to_cpu(buf + 6);
> +        nb_sectors =3D ldl_be_p(buf + 6);
>      }
> =20
> -    lba =3D ube32_to_cpu(buf + 2);
> +    lba =3D ldl_be_p(buf + 2);
>      if (nb_sectors =3D=3D 0) {
>          ide_atapi_cmd_ok(s);
>          return;
> @@ -1017,7 +993,7 @@ static void cmd_read_cd(IDEState *s, uint8_t* buf)
>      int nb_sectors, lba, transfer_request;
> =20
>      nb_sectors =3D (buf[6] << 16) | (buf[7] << 8) | buf[8];
> -    lba =3D ube32_to_cpu(buf + 2);
> +    lba =3D ldl_be_p(buf + 2);
> =20
>      if (nb_sectors =3D=3D 0) {
>          ide_atapi_cmd_ok(s);
> @@ -1057,7 +1033,7 @@ static void cmd_seek(IDEState *s, uint8_t* buf)
>      unsigned int lba;
>      uint64_t total_sectors =3D s->nb_sectors >> 2;
> =20
> -    lba =3D ube32_to_cpu(buf + 2);
> +    lba =3D ldl_be_p(buf + 2);
>      if (lba >=3D total_sectors) {
>          ide_atapi_cmd_error(s, ILLEGAL_REQUEST, ASC_LOGICAL_BLOCK_OOR)=
;
>          return;
> @@ -1098,15 +1074,15 @@ static void cmd_start_stop_unit(IDEState *s, ui=
nt8_t* buf)
> =20
>  static void cmd_mechanism_status(IDEState *s, uint8_t* buf)
>  {
> -    int max_len =3D ube16_to_cpu(buf + 8);
> +    int max_len =3D lduw_be_p(buf + 8);
> =20
> -    cpu_to_ube16(buf, 0);
> +    stw_be_p(buf, 0);
>      /* no current LBA */
>      buf[2] =3D 0;
>      buf[3] =3D 0;
>      buf[4] =3D 0;
>      buf[5] =3D 1;
> -    cpu_to_ube16(buf + 6, 0);
> +    stw_be_p(buf + 6, 0);
>      ide_atapi_cmd_reply(s, 8, max_len);
>  }
> =20
> @@ -1116,7 +1092,7 @@ static void cmd_read_toc_pma_atip(IDEState *s, ui=
nt8_t* buf)
>      int max_len;
>      uint64_t total_sectors =3D s->nb_sectors >> 2;
> =20
> -    max_len =3D ube16_to_cpu(buf + 7);
> +    max_len =3D lduw_be_p(buf + 7);
>      format =3D buf[9] >> 6;
>      msf =3D (buf[1] >> 1) & 1;
>      start_track =3D buf[6];
> @@ -1154,15 +1130,15 @@ static void cmd_read_cdvd_capacity(IDEState *s,=
 uint8_t* buf)
>      uint64_t total_sectors =3D s->nb_sectors >> 2;
> =20
>      /* NOTE: it is really the number of sectors minus 1 */
> -    cpu_to_ube32(buf, total_sectors - 1);
> -    cpu_to_ube32(buf + 4, 2048);
> +    stl_be_p(buf, total_sectors - 1);
> +    stl_be_p(buf + 4, 2048);
>      ide_atapi_cmd_reply(s, 8, 8);
>  }
> =20
>  static void cmd_read_disc_information(IDEState *s, uint8_t* buf)
>  {
>      uint8_t type =3D buf[1] & 7;
> -    uint32_t max_len =3D ube16_to_cpu(buf + 7);
> +    uint32_t max_len =3D lduw_be_p(buf + 7);
> =20
>      /* Types 1/2 are only defined for Blu-Ray.  */
>      if (type !=3D 0) {
> @@ -1196,7 +1172,7 @@ static void cmd_read_dvd_structure(IDEState *s, u=
int8_t* buf)
>      int format =3D buf[7];
>      int ret;
> =20
> -    max_len =3D ube16_to_cpu(buf + 8);
> +    max_len =3D lduw_be_p(buf + 8);
> =20
>      if (format < 0xff) {
>          if (media_is_cd(s)) {
>=20

neat!

I'll stage this cleanup, thank you.

(There are some other things in my IDE branch at the moment that keeps
me from pushing this to public staging, but it's in my local staging
area for now.)

--js

