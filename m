Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E64EBC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 13:02:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0092208CD
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 13:02:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TrL6jSSI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0092208CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jACcL-0008BV-Ue
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 08:02:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40398)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1jACbY-0007NG-CL
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 08:01:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1jACbU-00056r-S0
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 08:01:25 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:35677)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1jACbT-0004ol-8c
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 08:01:23 -0500
Received: by mail-wr1-x443.google.com with SMTP id r7so2279919wro.2
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2020 05:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=QTas7TJflB9Mqm7mcMpIJ5WnuCiBx2sZYw6MYILlc+8=;
 b=TrL6jSSIWSq7WwCL9NRigL3owhThc8KYko7mFYhjBwGktRYEjsYD9/s0PRszdafyb6
 xeYVxDd59r4xZJuC4/nM+xRdA/+p4/OQ3YhLjRkoZnMAulZFVIep+1MCU5kAlpKweuyT
 /GrCa0HNA8duL2kjnkiCJ7lROn3wMlVHxKylyXXlSeQ/8Ngfj5YsDSrY8I8fF7mPD7lQ
 R3AIOjmL8laor6qclQYv65HFyHZLk7lKAfPIoZbKp2Wxng/krMTz9fRNOh7BmJb1cDXE
 XzW+S/YmoXazOc8mLGrqiBPpQ7d3V+0GQ3LF99fvXueqHPJMc7Dl2QbEkwjaXFiy0wBM
 9UgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=QTas7TJflB9Mqm7mcMpIJ5WnuCiBx2sZYw6MYILlc+8=;
 b=KmkoMWGjiZX36UjalCy0eNM4nwT+nGY1I+NWHtFEQqkf/5ruNLK6bXfrsyWijnPk7r
 1YmPCi9M5wbdHJVKTRug6h0sGe9bwUCJ1boCXxWol3aGu9TxgPUx7Goa1q3DJA0CkSgl
 1FFC3igpjVqO/EkOmfRWW/OZMq76OP+cRM16WDF45kN6BFnjCJb7sP5kL8ckaTXoiLaR
 kAByIPt8QMNd8bfFsHrQnmhvbJjoJDWyThEMnftUY9JkPhSW3Nqxsh5jWX3DO3/Qw5lO
 IRuiU1x9p1f20xd5oA0ib+1XEMOiLheWMR9C/Ru/nDHUrcKisHvqdYb5LMswzKRmtwwA
 LzBg==
X-Gm-Message-State: ANhLgQ3nO1bEJdgLUptX3YUQdC+9XYPSf4PFH+ELrOenMsZaw4NktdcZ
 t/0GiOqzVClR3NtYLCfcpZM=
X-Google-Smtp-Source: ADFU+vuCDIsBr8/6wA4iMfR6kLbr4bQAq/7+2gs/3lyE2PBt/zM1wrDnAwkRm5E2/dgAZ12GlSAz8g==
X-Received: by 2002:adf:bc0e:: with SMTP id s14mr3948562wrg.364.1583499672623; 
 Fri, 06 Mar 2020 05:01:12 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id o3sm16188516wme.36.2020.03.06.05.01.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2020 05:01:11 -0800 (PST)
Date: Fri, 6 Mar 2020 13:01:10 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Lin Ma <LMa@suse.com>
Subject: Re: [Question] About GET LBA STATUS(16) support in qemu scsi
 emulation layer
Message-ID: <20200306130110.GL1335569@stefanha-x1.localdomain>
References: <BY5PR18MB33131C4403EEE72D5DD0FA91C5E60@BY5PR18MB3313.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="CqfQkoYPE/jGoa5Q"
Content-Disposition: inline
In-Reply-To: <BY5PR18MB33131C4403EEE72D5DD0FA91C5E60@BY5PR18MB3313.namprd18.prod.outlook.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: Jon Maloy <jmaloy@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "hare@suse.de" <hare@suse.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--CqfQkoYPE/jGoa5Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 01, 2020 at 01:01:29PM +0000, Lin Ma wrote:
> Hi all,
>=20
> I'm not familiar with scsi, I'm curious why there is no GET LBA STATUS(16=
) support in qemu scsi emulation layer.
>=20
> So far, There is only one subcommand of SERVICE ACTION was implemented: T=
he READ CAPACITY(16)
> e.g.
> static int32_t scsi_disk_emulate_command(SCSIRequest *req, uint8_t *buf)
>     [......]
>     case SERVICE_ACTION_IN_16:
>         /* Service Action In subcommands. */
>         if ((req->cmd.buf[1] & 31) =3D=3D SAI_READ_CAPACITY_16) {
>             [......]
>         }
>         trace_scsi_disk_emulate_command_SAI_unsupported();
>         goto illegal_request;
>     [......]
>=20
>=20
> It seems that this situation has been for a long time. Is the GET LBA STA=
TUS (16 or 32) unnessesary for qemu scsi emulation or did I misunderstand s=
omething?

GET LBA STATUS is optional according to the SBC specification so QEMU's
SCSI target is conformant.

I guess the question is which applications need this command?

It's probably a case of no one needing this command enough to implement
it yet.

Stefan

--CqfQkoYPE/jGoa5Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl5iSZYACgkQnKSrs4Gr
c8hFKwf8DwMMUySrQDW3qFKLRytdU7uhPJhZapXM5Cj/3t2R4V9xItgBrc16vGA9
jhCnejoJCloqRru43K8PQpDTIVWPhaxTN/Jdr5m/n7+PphwPdzKIPl8nuYtzo0M5
4b/ciumkLRoUWbLB424y3f9lr2SgRKSNx5RDnSShKEr+hv5c3BeJPNCw34v1Bh4/
oiCSHuzZBEHoAphwsCCVvOOeUMXuHTRrCg4DE64gkam5mIOUbJhaYWhBQSAuWZsF
QcggSLPSgXjdvR/OWJvUAhLy4J/dbpadg98P+ZUyqDgbh/XzdGri6gVbV+onn5EV
uGjq+d0tT4rQ4N+lnoan5J465mxS+A==
=tT/r
-----END PGP SIGNATURE-----

--CqfQkoYPE/jGoa5Q--

