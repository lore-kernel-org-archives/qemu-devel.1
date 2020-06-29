Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A5EC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 10:40:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1041C23770
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 10:40:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WdsCCPlR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1041C23770
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jprDR-0003up-Bz
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 06:40:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35258)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jprCc-00034j-W5
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 06:39:55 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:42749)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jprCb-0002JC-9W
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 06:39:54 -0400
Received: by mail-wr1-x443.google.com with SMTP id o11so16014206wrv.9
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2020 03:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=YB/qQRNxTkxp2uR5MWmEPE0Ri5A8mKb8LeF4giYfXvo=;
 b=WdsCCPlRcn4DKOuSucrud3+VzEKtdz6i+dOAicYd7hJJ5umoX05Ntqp4K4wroELFqc
 3BGrHlREp7iJ9ljlho31ll1MGfUcS5P6fXsqTqM5jwno0UgWzuVYw1ZgPPEW1wLi6ZSK
 mniyEGBiBYMtTbYKTCnSjlfUquF1M0GLRXkWgKmb6yd4+3BBDMSTdg8v6dqmrjpk1Mde
 PGN5+Aofz/cYn6vlVr9VNFDOI1BdwDOdi/Nr2C4uhzR74gRZ1LoPE3NNXe5w6MD1znIO
 PP5mKxMqFMq5dnR9QBRdjXnCo9pGyHZvkARlIYBNrkbXMdICrbBOjF7vcWvweP40YLFN
 BeOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=YB/qQRNxTkxp2uR5MWmEPE0Ri5A8mKb8LeF4giYfXvo=;
 b=M2E2hcaF0QcSaSnEd7Ran4CGWUHITX/VAbBNbLwBCZFsA3CrzvX9mACU6dgG0CE+NL
 gBxNjomdaO34X4IqiJzkHrCjznN9CfxWSFlzQ4sRSkNFT4BVjuSTPnyLT8wU1usRpQSF
 8uXOMGTuQVsm53KYhQPXk8VL8/8ss8R9n7SOBPqBpM8NmufwSoxl4dms4KQeaq4ZJF5G
 r/N+QuNWSTRLwB5MN7+EdgdpgHHUUqjQk5z5ScMr/uY/6v1jEyAXfnyh8XTn4utQ1Bn3
 owcaHRD6dCndifamPJrbaxM7oZ1xk98WjTJFifINDjxP0Vn3ve1UsYvGCHsaDVX+2VL3
 6k9A==
X-Gm-Message-State: AOAM5312MEypb1eNYyhG5XY+wtpDNovUji2ESNSITmUEG3w6kQxwoOHN
 VS5tdCy6OqVEoFNtJoYiBMM=
X-Google-Smtp-Source: ABdhPJzVxdeagA2gbeRjlKexVAAzfNP+jlIwxaU0ZzD/9QXbJJ2X/AGrtP91Ya152RDWdjfyjdPu6g==
X-Received: by 2002:adf:e98f:: with SMTP id h15mr17834672wrm.25.1593427191585; 
 Mon, 29 Jun 2020 03:39:51 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id b23sm8335189wmd.37.2020.06.29.03.39.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2020 03:39:50 -0700 (PDT)
Date: Mon, 29 Jun 2020 11:39:48 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Lin Ma <LMa@suse.com>
Subject: Re: [PATCH v2 3/3] scsi-disk: Add support for the GET LBA STATUS 16
 command
Message-ID: <20200629103948.GF31392@stefanha-x1.localdomain>
References: <AM6PR04MB578290CA80CC6000756C4C0EC5920@AM6PR04MB5782.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Y/WcH0a6A93yCHGr"
Content-Disposition: inline
In-Reply-To: <AM6PR04MB578290CA80CC6000756C4C0EC5920@AM6PR04MB5782.eurprd04.prod.outlook.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=stefanha@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: "fam@euphon.net" <fam@euphon.net>, "kwolf@redhat.com" <kwolf@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--Y/WcH0a6A93yCHGr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 25, 2020 at 01:31:56PM +0000, Lin Ma wrote:
> On 2020-06-25 21:25, Lin Ma wrote:
> >> +    /*
> >> +     * 8 + 16 is the length in bytes of response header and
> >> +     * one LBA status descriptor
> >> +     */
> >> +    memset(outbuf, 0, 8 + 16);
> >> +    outbuf[3] =3D 20;
> >> +    outbuf[8] =3D (req->cmd.lba >> 56) & 0xff;
> >> +    outbuf[9] =3D (req->cmd.lba >> 48) & 0xff;
> >> +    outbuf[10] =3D (req->cmd.lba >> 40) & 0xff;
> >> +    outbuf[11] =3D (req->cmd.lba >> 32) & 0xff;
> >> +    outbuf[12] =3D (req->cmd.lba >> 24) & 0xff;
> >> +    outbuf[13] =3D (req->cmd.lba >> 16) & 0xff;
> >> +    outbuf[14] =3D (req->cmd.lba >> 8) & 0xff;
> >> +    outbuf[15] =3D req->cmd.lba & 0xff;
> >> +    outbuf[16] =3D (*num_blocks >> 24) & 0xff;
> >> +    outbuf[17] =3D (*num_blocks >> 16) & 0xff;
> >> +    outbuf[18] =3D (*num_blocks >> 8) & 0xff;
> >> +    outbuf[19] =3D *num_blocks & 0xff;
> >> +    outbuf[20] =3D *is_deallocated ? 1 : 0;
> >=20
> > SCSI defines 3 values and QEMU can represent all of them:
> >=20
> > 0 - mapped or unknown
> > 1 - deallocated
> > 2 - anchored
> >=20
> > See the BDRV_BLOCK_* constants in include/block/block.h. The
> > is_deallocated boolean is not enough to represent this state, but the
> > bdrv_block_status() return value can be used instead.
>=20
> I don't know which one in BDRV_BLOCK_* can be used to represent 'anchored=
'.
> It seems that I need to use BDRV_BLOCK_* combination to recognized 'ancho=
red',
>=20
> I'd like to use these combinations to analyze the bdrv_block_status() ret=
urn value:
> 'deallocated': BDRV_BLOCK_ALLOCATED | BDRV_BLOCK_OFFSET_VALID | BDRV_BLOC=
K_ZERO
> 'anchored':    BDRV_BLOCK_ALLOCATED | BDRV_BLOCK_OFFSET_VALID | ! BDRV_BL=
OCK_ZERO | ! BDRV_BLOCK_DATA
> Am I right?

My understanding is that the SCSI status are mapped to QEMU block status
as follows:

allocated: BDRV_BLOCK_DATA | !BDRV_BLOCK_ZERO | BDRV_BLOCK_OFFSET_VALID
anchored: BDRV_BLOCK_DATA | BDRV_BLOCK_ZERO | BDRV_BLOCK_OFFSET_VALID
deallocated: !BDRV_BLOCK_DATA

I have CCed Eric Blake, who is familiar with block status.

> >> +}
> >> +
> >>  static int32_t scsi_disk_emulate_command(SCSIRequest *req, uint8_t *b=
uf)
> >>  {
> >>      SCSIDiskReq *r =3D DO_UPCAST(SCSIDiskReq, req, req);
> >> @@ -2076,6 +2159,13 @@ static int32_t scsi_disk_emulate_command(SCSIRe=
quest *req, uint8_t *buf)
> >>
> >>              /* Protection, exponent and lowest lba field left blank. =
*/
> >>              break;
> >> +        } else if ((req->cmd.buf[1] & 31) =3D=3D SAI_GET_LBA_STATUS) {
> >> +            if (req->cmd.lba > s->qdev.max_lba) {
> >> +                goto illegal_lba;
> >> +            }
> >> +            scsi_disk_emulate_get_lba_status(req, outbuf);
> >> +            r->iov.iov_len =3D req->cmd.xfer;
> >> +            return r->iov.iov_len;
> >=20
> > Is there something tricky going on here with iov_len that prevents us
> > from using break here and sharing the functions normal return code path?
>=20
> Using 'break' here and following the normal return code path cause the as=
sertion
> 'assert(!r->req.aiocb)'.
>=20
> In fact, There is a 'return' statement in the 'case SYNCHRONIZE_CACHE' in=
 function
> scsi_disk_emulate_command, It causes the same assertion if no this 'retur=
n' statement.
> I borrowed this idea to avoid the assertion.

The assertion shows that this patch isn't asynchronous. I think the
assertion will pass once you convert GET_LBA_STATUS to async and then
a break statement will work.

--Y/WcH0a6A93yCHGr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl75xPQACgkQnKSrs4Gr
c8gyqgf/S+uUrqCg1kzO7LvAyeaSs9GN62eUPqBf9976RGzI67AMyl35FivmBOom
ZEQTGqmiJhbNXx4YzPsmhGBUenQoWy549RJkbuFijMAV0miC/tSFBSf/k7zzv1EF
qZAMBQdXVKXQWKBvLuUQMYakX2/9g8zSXNMBs2KbG5x4zejOjxykYxlSvHJzkT2n
chm4UbzC/EK6Iw9y8/VAhmT+Tw5ARX1242nMNR96DGXmiojrj+UxXCiwuuMZH++g
/EaVSuArzcBx71tbah1/5/LwR/Bl3gA2PF465klK6UgmDtLTgSTCZzBeukRiJLtu
n9H5hUEETOqc+8S5hnhCKA/0qSrBvA==
=cUrv
-----END PGP SIGNATURE-----

--Y/WcH0a6A93yCHGr--

