Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F35CC433E4
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 15:38:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4323A22CBB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 15:38:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=blade-group.com header.i=@blade-group.com header.b="QDNMebnB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4323A22CBB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=blade-group.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxXrr-0004bf-Fu
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 11:38:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52332)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <antoine.damhet@blade-group.com>)
 id 1jxXr6-0003rV-KH
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 11:37:28 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:50283)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <antoine.damhet@blade-group.com>)
 id 1jxXr4-0007Uf-H1
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 11:37:27 -0400
Received: by mail-wm1-x344.google.com with SMTP id c80so22718154wme.0
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2020 08:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blade-group.com; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=TxNiv0mmwz5tykaYIMa25MfWsV2KeVFrzqGHWHnQ3oo=;
 b=QDNMebnBKEU7OAIncO403byn2hNfmcM/hoh91kZVEGghNjjp1RGfUgt6f3KqV1ZP2L
 MurlvhdtjmyKNFf87DkKnRqP2sJ3QVXoQ0bUiTBKsmO34zA4C7r3UW3oHIDlBpZBPVlz
 hrwIek6vR5oSZh05jE/1FRtK41AnqKNkM+xSNcUKn3X58s19ss7Mh2s9EzaS3szDWBBN
 prEw8dJjJA2cCu7b8D4TtD7hIhZKCj7dc5BvB7axUuSRBALjYbzvdDHaO9gGG9cMlvLE
 t4Ya61g6dtYatb+XYNLoCuxoB0t0i0rrHABwyzgKZd84yVCYRnAYKc0IQphhYfEZKYLp
 u8nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=TxNiv0mmwz5tykaYIMa25MfWsV2KeVFrzqGHWHnQ3oo=;
 b=rtpXCXeTs6iccV3BBZNknrEvbuEMGN7Ht9znbwXDZo2rJxgAT6J950cYVATBDVckBJ
 TmmjTk0haqPslzFt9DI755acgYiMGDcNZunwwO+PpuXqkb9+Zniiafa/ExkVJhGrko+W
 ZRKZi3zHLoY/fGoQTrvVPCBSCPT2JFvbEkcXqy0D9C1ovvJeCS8+MCxT/AZ0NfJCKgKb
 wCDvA3HWDLOVhHf5Fij8kuNs/axyng4CDyZTKH3kCX/tk9PJZy6maK4jTybLDmZ2Z8pV
 cejtbSLCc1/oiS5PEEaM/8RX1vWMuNoT4HyNXsj889fgoxu0mqNZgT43ZuAgoEYLHAJ9
 dxhQ==
X-Gm-Message-State: AOAM5320ggKclSWoapaZgbQOkD/zlRo8uTrw4dxUG5Am4cifARSUMEfg
 JImdaxbRubI78bzQIsDXFbafxw==
X-Google-Smtp-Source: ABdhPJz8ruxlaxqSQ+G4YGOY3GQNTWt7USyDpzNT0uzE3oh5c/xmmhfUygCSsN7XX6K03nuv8+Q8Sg==
X-Received: by 2002:a1c:9e4c:: with SMTP id h73mr23752951wme.177.1595259444241; 
 Mon, 20 Jul 2020 08:37:24 -0700 (PDT)
Received: from localhost ([2a01:e34:ec16:8a90:4e1d:96ff:fe49:7109])
 by smtp.gmail.com with ESMTPSA id y11sm17747298wrs.80.2020.07.20.08.37.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2020 08:37:23 -0700 (PDT)
Date: Mon, 20 Jul 2020 17:37:22 +0200
From: Antoine Damhet <antoine.damhet@blade-group.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH RESEND] file-posix: Handle `EINVAL` fallocate return value
Message-ID: <20200720153722.2zv2vhzficgg73lo@tartarus>
References: <20200717135603.51180-1-antoine.damhet@blade-group.com>
 <20200720140726.GD5541@linux.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="qq6g4k2v5x3z4g5d"
Content-Disposition: inline
In-Reply-To: <20200720140726.GD5541@linux.fritz.box>
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=antoine.damhet@blade-group.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: qemu-devel@nongnu.org, "open list:raw" <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--qq6g4k2v5x3z4g5d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 20, 2020 at 04:07:26PM +0200, Kevin Wolf wrote:
> Am 17.07.2020 um 15:56 hat antoine.damhet@blade-group.com geschrieben:
> > From: Antoine Damhet <antoine.damhet@blade-group.com>
> >=20
> > The `detect-zeroes=3Dunmap` option may issue unaligned
> > `FALLOC_FL_PUNCH_HOLE` requests, raw block devices can (and will) return
> > `EINVAL`, qemu should then write the zeroes to the blockdev instead of
> > issuing an `IO_ERROR`.
> >=20
> > Signed-off-by: Antoine Damhet <antoine.damhet@blade-group.com>
>=20
> Do you have a simple reproducer for this? I tried it with something like
> this (also with a LV instead of loop, but it didn't really make a
> difference):
>=20
> $ ./qemu-io -c 'write -P 0 42 1234' --image-opts driver=3Dhost_device,fil=
ename=3D/dev/loop0,cache.direct=3Don,detect-zeroes=3Don
> wrote 1234/1234 bytes at offset 42
> 1.205 KiB, 1 ops; 00.00 sec (2.021 MiB/sec and 1717.5697 ops/sec)
>=20
> So I don't seem to run into an error.

```
$ qemu-io -c 'write -P 0 42 1234' --image-opts driver=3Dhost_device,filenam=
e=3D/dev/loop0,detect-zeroes=3Dunmap
write failed: Invalid argument
```

This seems do do the trick :) (We triggered the bug with Windows 10
guests and with an iSCSI drive so it was hardly a simple reproducer).

>=20
> > diff --git a/block/file-posix.c b/block/file-posix.c
> > index 8067e238cb..b2fabcc1b8 100644
> > --- a/block/file-posix.c
> > +++ b/block/file-posix.c
> > @@ -1620,7 +1620,11 @@ static int handle_aiocb_write_zeroes_unmap(void =
*opaque)
> >  #ifdef CONFIG_FALLOCATE_PUNCH_HOLE
> >      int ret =3D do_fallocate(s->fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_K=
EEP_SIZE,
> >                             aiocb->aio_offset, aiocb->aio_nbytes);
> > -    if (ret !=3D -ENOTSUP) {
> > +    switch (ret) {
> > +    case -ENOTSUP:
> > +    case -EINVAL:
> > +        break;
> > +    default:
> >          return ret;
> >      }
> >  #endif
>=20
> This means that we fall back to BLKZEROOUT in case of -EINVAL. Does this
> return a better error code in the relevant cases, or did you just happen
> to test a case where it was skipped or returned -ENOTSUP?

I guess I misinterpreted the comment before calling
`handle_aiocb_write_zeroes`.

The codepath is:
* handle_aiocb_write_zeroes_unmap -> handle_aiocb_write_zeroes -> handle_ai=
ocb_write_zeroes_block

In witch the code will return `-ENOSTUP` (`!s->has_write_zeroes`) and
never fall back to `BLKZEROOUT`.

So it's working as I expected but now I am unsure that my fix is the
right thing to do, what do you think ?

>=20
> Kevin
>=20
>=20

--=20
Antoine 'xdbob' Damhet

--qq6g4k2v5x3z4g5d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEArm1WbQx2GmOsfF83AmjLzzljz4FAl8Vui8ACgkQ3AmjLzzl
jz624gf/eQnV+Y8IAvqNRSfvm3DFHxWabfMAAHltXYcgNkD+Z6eZc/cprCu9fbll
hYotSNLfnmEeEiQNIymW0PF7MmYQEoP3SexDnureayPeeVATqHMQC0GDZ0xcrZvU
pzKl/Tt5yu1o/TYM8hxAO4umPUwYRLIR731Ac/0Q3rH37103nYc0bzbOrmTnha/1
UUncwJYaUbetRPDgMc1OC54ANWoBqxumWBwXouxbNsvNnoGX1wZIIX1TCiswQ/Ga
8ZfzgwN5tX6eIFxIke98Ohed6YSTdGEdJK7XvKn3htPLVLdUlvGANvFGeiA7GzHC
W5SyDMCND7rHd/ZJ7F3/U9cImQljkw==
=tOfX
-----END PGP SIGNATURE-----

--qq6g4k2v5x3z4g5d--

