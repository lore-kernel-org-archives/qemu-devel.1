Return-Path: <SRS0=PlQC=BZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1852C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 15:48:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CE1023B31
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 15:48:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TUogl15I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CE1023B31
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6yQ0-0004EB-Q8
	for qemu-devel@archiver.kernel.org; Sat, 15 Aug 2020 11:48:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48136)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1k6yP1-0003BW-I4; Sat, 15 Aug 2020 11:47:27 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:36522)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1k6yOz-0007ZW-SM; Sat, 15 Aug 2020 11:47:27 -0400
Received: by mail-oi1-x242.google.com with SMTP id l204so10899710oib.3;
 Sat, 15 Aug 2020 08:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=7Jnq2PjERJLs/GO9/4baZQ//w2zkwIz0zzZeTVJKRcU=;
 b=TUogl15Ihu9IJh05cXZppSTXCvVb63Ib0zuv3MFKpFp7YWgBFDSoPALaKUmC8v+c4d
 /qlXqwJ8nb0xfoLza982lNCf8aS23WRotVIZVj0/OkN+P5rUsFpxeE6+2h8UflXeidZ5
 IVDuiyhzZzw8gxGOcg4md9YlrZ7lOBY26C/RvSi+Ij9lvW752uoYvK0mRS/QGS1wFera
 ecLS7Z63xneyVPtIptSeCqUR/HB52ZjRZQTFZVvFvkzHLsN/C8yfZuOcR1uJNZm7FR2G
 9VpGtmK/LoTA2gSGxlznanvOhKur16z2E1nplFNaxpNlN96a3Kq1j983ZhVQfRYYKdWc
 sUgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=7Jnq2PjERJLs/GO9/4baZQ//w2zkwIz0zzZeTVJKRcU=;
 b=HGVow6aGhHjZm+WUd7fKkgOj8jn/28mHk0wtHx4LdVFUg7AkbkbVQoSzCC3e8h8loH
 wc3duyGufZ3I8H19S4emEljPVhXOHYrPbulfn+1teNH9NY2+JzUxGaUT0/vwfUMlOPnq
 XfhSU7zQ/iErkwsuW1HKeo9JKpXTdx5G9LLwEPaXHVbDAj3lkL8zoSJO3LoOxUWZ+BKh
 nSCco46tn+8XcfWF3WqItO/VUuxEJmjhmTCOgjdiiPS+4qKdhM204m1+v7a3MLwHzri3
 HIZk139mU0Dusj1OxPfvz8kI8mFamDD3bNQkSSC9EPLuUZTMb1n0wkJdlHjvukkHwght
 8Edw==
X-Gm-Message-State: AOAM532PvWMRes6tHQqwHXFtcazlD6wxoGsUwMr4ui1nGwBix2RgAPQB
 gFkThXxjCrfT+BeXcYm7BcaZ3rbaIUhtNehf7g0pVbk25h8=
X-Google-Smtp-Source: ABdhPJyBm61wARtWHsmce0n7gjQyDw+KSNq/H2UHw3rm6ix30D9v0MkrG8zIRVMjR/J/EbGzA/63Hdscld+CfhiRSi8=
X-Received: by 2002:aca:1117:: with SMTP id 23mr3486076oir.97.1597461878912;
 Fri, 14 Aug 2020 20:24:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200814082841.27000-1-f4bug@amsat.org>
 <20200814082841.27000-8-f4bug@amsat.org>
In-Reply-To: <20200814082841.27000-8-f4bug@amsat.org>
From: Li Qiang <liq3ea@gmail.com>
Date: Sat, 15 Aug 2020 11:24:02 +0800
Message-ID: <CAKXe6SKLqZ6HRFLENFkZCX3kkWUPQVD=OH0cqY7iwo77876azw@mail.gmail.com>
Subject: Re: [PATCH 7/7] hw/scsi/scsi-disk: Replace magic '512' value by
 BDRV_SECTOR_SIZE
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::242;
 envelope-from=liq3ea@gmail.com; helo=mail-oi1-x242.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, Qemu Developers <qemu-devel@nongnu.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =E4=BA=8E2020=E5=B9=B48=E6=9C=
=8814=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=884:34=E5=86=99=E9=81=93=
=EF=BC=9A
>
> Use self-explicit definitions instead of magic '512' value.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Li Qiang <liq3ea@gmail.com>

> ---
>  hw/scsi/scsi-disk.c | 44 +++++++++++++++++++++++---------------------
>  1 file changed, 23 insertions(+), 21 deletions(-)
>
> diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
> index 8ce68a9dd6..7612035a4e 100644
> --- a/hw/scsi/scsi-disk.c
> +++ b/hw/scsi/scsi-disk.c
> @@ -71,7 +71,7 @@ typedef struct SCSIDiskClass {
>
>  typedef struct SCSIDiskReq {
>      SCSIRequest req;
> -    /* Both sector and sector_count are in terms of qemu 512 byte blocks=
.  */
> +    /* Both sector and sector_count are in terms of BDRV_SECTOR_SIZE byt=
es.  */
>      uint64_t sector;
>      uint32_t sector_count;
>      uint32_t buflen;
> @@ -141,7 +141,7 @@ static void scsi_init_iovec(SCSIDiskReq *r, size_t si=
ze)
>          r->buflen =3D size;
>          r->iov.iov_base =3D blk_blockalign(s->qdev.conf.blk, r->buflen);
>      }
> -    r->iov.iov_len =3D MIN(r->sector_count * 512, r->buflen);
> +    r->iov.iov_len =3D MIN(r->sector_count * BDRV_SECTOR_SIZE, r->buflen=
);
>      qemu_iovec_init_external(&r->qiov, &r->iov, 1);
>  }
>
> @@ -311,7 +311,7 @@ static void scsi_read_complete_noio(SCSIDiskReq *r, i=
nt ret)
>          goto done;
>      }
>
> -    n =3D r->qiov.size / 512;
> +    n =3D r->qiov.size / BDRV_SECTOR_SIZE;
>      r->sector +=3D n;
>      r->sector_count -=3D n;
>      scsi_req_data(&r->req, r->qiov.size);
> @@ -505,7 +505,7 @@ static void scsi_write_complete_noio(SCSIDiskReq *r, =
int ret)
>          goto done;
>      }
>
> -    n =3D r->qiov.size / 512;
> +    n =3D r->qiov.size / BDRV_SECTOR_SIZE;
>      r->sector +=3D n;
>      r->sector_count -=3D n;
>      if (r->sector_count =3D=3D 0) {
> @@ -1284,7 +1284,7 @@ static int scsi_disk_emulate_mode_sense(SCSIDiskReq=
 *r, uint8_t *outbuf)
>          } else { /* MODE_SENSE_10 */
>              outbuf[7] =3D 8; /* Block descriptor length  */
>          }
> -        nb_sectors /=3D (s->qdev.blocksize / 512);
> +        nb_sectors /=3D (s->qdev.blocksize / BDRV_SECTOR_SIZE);
>          if (nb_sectors > 0xffffff) {
>              nb_sectors =3D 0;
>          }
> @@ -1342,7 +1342,7 @@ static int scsi_disk_emulate_read_toc(SCSIRequest *=
req, uint8_t *outbuf)
>      start_track =3D req->cmd.buf[6];
>      blk_get_geometry(s->qdev.conf.blk, &nb_sectors);
>      trace_scsi_disk_emulate_read_toc(start_track, format, msf >> 1);
> -    nb_sectors /=3D s->qdev.blocksize / 512;
> +    nb_sectors /=3D s->qdev.blocksize / BDRV_SECTOR_SIZE;
>      switch (format) {
>      case 0:
>          toclen =3D cdrom_read_toc(nb_sectors, outbuf, msf, start_track);
> @@ -1738,9 +1738,10 @@ static void scsi_write_same_complete(void *opaque,=
 int ret)
>
>      block_acct_done(blk_get_stats(s->qdev.conf.blk), &r->acct);
>
> -    data->nb_sectors -=3D data->iov.iov_len / 512;
> -    data->sector +=3D data->iov.iov_len / 512;
> -    data->iov.iov_len =3D MIN(data->nb_sectors * 512, data->iov.iov_len)=
;
> +    data->nb_sectors -=3D data->iov.iov_len / BDRV_SECTOR_SIZE;
> +    data->sector +=3D data->iov.iov_len / BDRV_SECTOR_SIZE;
> +    data->iov.iov_len =3D MIN(data->nb_sectors * BDRV_SECTOR_SIZE,
> +                            data->iov.iov_len);
>      if (data->iov.iov_len) {
>          block_acct_start(blk_get_stats(s->qdev.conf.blk), &r->acct,
>                           data->iov.iov_len, BLOCK_ACCT_WRITE);
> @@ -1805,9 +1806,10 @@ static void scsi_disk_emulate_write_same(SCSIDiskR=
eq *r, uint8_t *inbuf)
>
>      data =3D g_new0(WriteSameCBData, 1);
>      data->r =3D r;
> -    data->sector =3D r->req.cmd.lba * (s->qdev.blocksize / 512);
> -    data->nb_sectors =3D nb_sectors * (s->qdev.blocksize / 512);
> -    data->iov.iov_len =3D MIN(data->nb_sectors * 512, SCSI_WRITE_SAME_MA=
X);
> +    data->sector =3D r->req.cmd.lba * (s->qdev.blocksize / BDRV_SECTOR_S=
IZE);
> +    data->nb_sectors =3D nb_sectors * (s->qdev.blocksize / BDRV_SECTOR_S=
IZE);
> +    data->iov.iov_len =3D MIN(data->nb_sectors * BDRV_SECTOR_SIZE,
> +                            SCSI_WRITE_SAME_MAX);
>      data->iov.iov_base =3D buf =3D blk_blockalign(s->qdev.conf.blk,
>                                                data->iov.iov_len);
>      qemu_iovec_init_external(&data->qiov, &data->iov, 1);
> @@ -1980,7 +1982,7 @@ static int32_t scsi_disk_emulate_command(SCSIReques=
t *req, uint8_t *buf)
>          if ((req->cmd.buf[8] & 1) =3D=3D 0 && req->cmd.lba) {
>              goto illegal_request;
>          }
> -        nb_sectors /=3D s->qdev.blocksize / 512;
> +        nb_sectors /=3D s->qdev.blocksize / BDRV_SECTOR_SIZE;
>          /* Returned value is the address of the last sector.  */
>          nb_sectors--;
>          /* Remember the new size for read/write sanity checking. */
> @@ -2049,7 +2051,7 @@ static int32_t scsi_disk_emulate_command(SCSIReques=
t *req, uint8_t *buf)
>              if ((req->cmd.buf[14] & 1) =3D=3D 0 && req->cmd.lba) {
>                  goto illegal_request;
>              }
> -            nb_sectors /=3D s->qdev.blocksize / 512;
> +            nb_sectors /=3D s->qdev.blocksize / BDRV_SECTOR_SIZE;
>              /* Returned value is the address of the last sector.  */
>              nb_sectors--;
>              /* Remember the new size for read/write sanity checking. */
> @@ -2180,8 +2182,8 @@ static int32_t scsi_disk_dma_command(SCSIRequest *r=
eq, uint8_t *buf)
>          if (!check_lba_range(s, r->req.cmd.lba, len)) {
>              goto illegal_lba;
>          }
> -        r->sector =3D r->req.cmd.lba * (s->qdev.blocksize / 512);
> -        r->sector_count =3D len * (s->qdev.blocksize / 512);
> +        r->sector =3D r->req.cmd.lba * (s->qdev.blocksize / BDRV_SECTOR_=
SIZE);
> +        r->sector_count =3D len * (s->qdev.blocksize / BDRV_SECTOR_SIZE)=
;
>          break;
>      case WRITE_6:
>      case WRITE_10:
> @@ -2211,8 +2213,8 @@ static int32_t scsi_disk_dma_command(SCSIRequest *r=
eq, uint8_t *buf)
>          if (!check_lba_range(s, r->req.cmd.lba, len)) {
>              goto illegal_lba;
>          }
> -        r->sector =3D r->req.cmd.lba * (s->qdev.blocksize / 512);
> -        r->sector_count =3D len * (s->qdev.blocksize / 512);
> +        r->sector =3D r->req.cmd.lba * (s->qdev.blocksize / BDRV_SECTOR_=
SIZE);
> +        r->sector_count =3D len * (s->qdev.blocksize / BDRV_SECTOR_SIZE)=
;
>          break;
>      default:
>          abort();
> @@ -2229,9 +2231,9 @@ static int32_t scsi_disk_dma_command(SCSIRequest *r=
eq, uint8_t *buf)
>      }
>      assert(r->iov.iov_len =3D=3D 0);
>      if (r->req.cmd.mode =3D=3D SCSI_XFER_TO_DEV) {
> -        return -r->sector_count * 512;
> +        return -r->sector_count * BDRV_SECTOR_SIZE;
>      } else {
> -        return r->sector_count * 512;
> +        return r->sector_count * BDRV_SECTOR_SIZE;
>      }
>  }
>
> @@ -2243,7 +2245,7 @@ static void scsi_disk_reset(DeviceState *dev)
>      scsi_device_purge_requests(&s->qdev, SENSE_CODE(RESET));
>
>      blk_get_geometry(s->qdev.conf.blk, &nb_sectors);
> -    nb_sectors /=3D s->qdev.blocksize / 512;
> +    nb_sectors /=3D s->qdev.blocksize / BDRV_SECTOR_SIZE;
>      if (nb_sectors) {
>          nb_sectors--;
>      }
> --
> 2.21.3
>
>

