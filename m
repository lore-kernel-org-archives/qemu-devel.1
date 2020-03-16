Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B36FC0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 12:24:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3438E2051A
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 12:24:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j1M/XKzq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3438E2051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDonZ-0004LV-0Q
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 08:24:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46766)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1jDnth-0000sJ-An
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 07:27:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1jDntg-0005QH-1p
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 07:27:05 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:55553)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1jDntf-00056a-Nc
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 07:27:03 -0400
Received: by mail-wm1-x344.google.com with SMTP id 6so17213623wmi.5
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 04:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=5MUvwtubsSuljVSwOrfcQ8rfBzcgm1BJcBFMBORmFX4=;
 b=j1M/XKzqf+TE/B3c/71iMsRJh7cm3G5l5GgSxE3OWEa4ULcEZLI+G1SY3Q+8YtpTDo
 kaYP077oDwMyCXYpbPyg1xQwlMQLMzQPTK7ni9oMMUzElyZ9iKOvNNAl1kJAX2Prb8tN
 vrAhpU9MfT4v6geWPOGgCKYjTC5wrguc4ADsxWbvNjLR5Zrz8rXv/yNxEehTziVS10n9
 n/43ESgn8xQam0EvLTAd0y4U48B317pvAjzG4kKjm7hCTNXbtyH0nHt+K3qjz1p4wBI9
 vja9W+zEIoTi66yrGC6WFjUqlG0lLI9efZzithRTKHYfIV/eV9V9HC666h1yGB51wgbV
 ZuAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=5MUvwtubsSuljVSwOrfcQ8rfBzcgm1BJcBFMBORmFX4=;
 b=sp5Lw/R4UU6hbEJcSGdzMBJ7SfxTPDItauWKTY+Ccfx3NowlxgO4ocZ6gHY7O63ptg
 XJTNwktVMJj7fmWD2N3eq0CQSy6H8iKHQetCYNoDF6Y5Ou1a5dRfBt+DhMXiv6kYZSgf
 MuYGyA6bcZbBWwtJbFmUeQ+28vsG/0HmIMlLu6Q62a9oVHZiy5BeIxxbmWW39SfTjm5A
 mmbVYKzdx/4LDK2wz8wcR+4CWQBRKnBCyREvVEK9u/l4jRMKMj17Xod1XtiorZsUiNXM
 IfBhEaivMMB4l6lt86W+OuQzeIkJfM6MGZ/r8spOc5empgXspBLtlIjq3aX1evkPjnN9
 RRBA==
X-Gm-Message-State: ANhLgQ2ebV+VhvuvL4IhGZN27HMzTr6g34AqqHaURUJ9MYyzFEOhMjre
 Cn/cmbwWYTDkHXhktIRCt74=
X-Google-Smtp-Source: ADFU+vvcRHNbk5h8A1seNpZmpCnmX9RdzKeBCo0Du/5C0MdlwTptXTZNneHvIs3TRA7RIBYs0LtUlA==
X-Received: by 2002:a05:600c:21d1:: with SMTP id
 x17mr23354995wmj.94.1584358022273; 
 Mon, 16 Mar 2020 04:27:02 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id b187sm14591448wmc.14.2020.03.16.04.27.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 04:27:00 -0700 (PDT)
Date: Mon, 16 Mar 2020 11:26:59 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Subject: Re: [PATCH v5 07/50] multi-process: define mpqemu-link object
Message-ID: <20200316112659.GA449851@stefanha-x1.localdomain>
References: <cover.1582576372.git.jag.raman@oracle.com>
 <20ec6f6666cc8adb211642156f5230e478143b81.1582576372.git.jag.raman@oracle.com>
 <20200310160941.GK140737@stefanha-x1.localdomain>
 <20200310182623.GA6543@flaka>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="VbJkn9YxBvnuCH5J"
Content-Disposition: inline
In-Reply-To: <20200310182623.GA6543@flaka>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: fam@euphon.net, john.g.johnson@oracle.com, swapnil.ingle@nutanix.com,
 mst@redhat.com, qemu-devel@nongnu.org, kraxel@redhat.com,
 Jagannathan Raman <jag.raman@oracle.com>, quintela@redhat.com,
 armbru@redhat.com, kanth.ghatraju@oracle.com, felipe@nutanix.com,
 thuth@redhat.com, ehabkost@redhat.com, konrad.wilk@oracle.com,
 dgilbert@redhat.com, liran.alon@oracle.com,
 Stefan Hajnoczi <stefanha@redhat.com>, pbonzini@redhat.com, rth@twiddle.net,
 kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com,
 thanos.makatos@nutanix.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2020 at 11:26:23AM -0700, Elena Ufimtseva wrote:
> On Tue, Mar 10, 2020 at 04:09:41PM +0000, Stefan Hajnoczi wrote:
> > On Mon, Feb 24, 2020 at 03:54:58PM -0500, Jagannathan Raman wrote:
> > > +    msg->num_fds =3D 0;
> > > +    for (chdr =3D CMSG_FIRSTHDR(&hdr); chdr !=3D NULL;
> > > +         chdr =3D CMSG_NXTHDR(&hdr, chdr)) {
> > > +        if ((chdr->cmsg_level =3D=3D SOL_SOCKET) &&
> > > +            (chdr->cmsg_type =3D=3D SCM_RIGHTS)) {
> > > +            fdsize =3D chdr->cmsg_len - CMSG_LEN(0);
> > > +            msg->num_fds =3D fdsize / sizeof(int);
> > > +            if (msg->num_fds > REMOTE_MAX_FDS) {
> > > +                /*
> > > +                 * TODO: Security issue detected. Sender never sends=
 more
> > > +                 * than REMOTE_MAX_FDS. This condition should be sig=
naled to
> > > +                 * the admin
> > > +                 */
> >=20
> > This TODO doesn't seem actionable.  The error is already handled.
> >=20
> > > +                qemu_log_mask(LOG_REMOTE_DEBUG,
> > > +                              "%s: Max FDs exceeded\n", __func__);
> > > +                return -ERANGE;
> >=20
> > The mutex must be released.
>=20
> Thank you! Will fix this and above.

I have posted a patch series that adds lock guards (automatic unlocking)
to prevent cases like this in the future:
https://lists.gnu.org/archive/html/qemu-devel/2020-03/msg04628.html

You can use the QEMU_LOCK_GUARD() and/or WITH_QEMU_LOCK_GUARD() macros
to avoid the need for manual qemu_mutex_unlock() calls.

Stefan

--VbJkn9YxBvnuCH5J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl5vYoMACgkQnKSrs4Gr
c8gcJggAnJI2D5ozFNi1rsllFqgOatfdf9xL7XporiCWpqxJGBZT28QC/mLY7dw5
vmIuxzJpG0P0AFK98GF3nqeLhftOkU7FcuTdycRBt6VRFBFiAANHKpKYTjWL3J/W
ClAsVerXKj+JzmIm23oW7yKfW6P+gHKGRf6Dy96lX8bfJMg48PBXQXeZ9OJG09QQ
EFPMcLTB19QTq+h6GgZO6a+kULY7FvHBBcmld0sF2ZC6nuBnoP6zJKrFTUQROcKq
sZ9m/BYOGtoOXLXJd5uiqUiQj7fQ5LvG4pyZ4muc6t8Ju8f1HernUdLmOak7sU6D
Z/YpO0L1im2vbVibE4wBkyB8x8SbDQ==
=KJ1x
-----END PGP SIGNATURE-----

--VbJkn9YxBvnuCH5J--

