Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14104C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 10:31:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D382220872
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 10:31:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rhciqaTw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D382220872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXjkS-0003rk-3v
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 05:31:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44436)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1iXjjA-0002gx-1T
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 05:30:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1iXjj8-0005kD-1x
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 05:30:19 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:45839)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1iXjj7-0005go-8C
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 05:30:17 -0500
Received: by mail-wr1-x442.google.com with SMTP id z10so3650643wrs.12
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2019 02:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=nC3xsZrLGATM2Zo9g1tFijnsPXWLrHe8wTl7ixtqqQ4=;
 b=rhciqaTw64aK2V2XJLCQIUhU3seDgWb2TUd1w06yHpzFWSCMKYwRJCDsxH4m1IBNf5
 vJltHS3B5d2GdXhB0R5oR91WmW6vbgXje0Jw+HDtEfCblj0dY7VdsMdezgju/npUd2v4
 Zm4jaEoL3Mvj2h6DTYoSO11wBD+C204aG65xFfr3yJAezXQ6ex/L/wyM6XIEV6sWprWq
 nFNTFcNlW3M4Bbww4bX8ORDslKN8AT5FkrvEIm618LcI8jsEp4a1wsb6rniKmUzZ2bOT
 uLZrEhsBOtyZhkxptZnx/yGdkt2YEhvxnRNWvocRDPW573yE41D5t+Cj73rZQzLJUjz8
 WCdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=nC3xsZrLGATM2Zo9g1tFijnsPXWLrHe8wTl7ixtqqQ4=;
 b=QUjnqHE5jYwmT/spu0ySuDs/bU/9+2HCxTyDIDlmlrlSzcEhYEVi2cmHFVe6PNf70T
 G7Dciv5+cmmAiDIfBKEJ0A6pVxdcs+MVXI4qgLMtp2h+pbFyPP/hb/ChJ8tZzhKZAuJT
 j4mc7KXOrZPvcMyrWIWh9oi8wC4HYtdkLYtTpnnMTjJ8g6ufDW1O/ejRtXDx9xTO5Xj9
 4nhJ7XuN1+2yPWXEi23rxjYPoo8H+/t25Z9sSiI+sAKqUVBRlp5N+6DWNjc5IutciOxP
 vpP/UWptgXOgYLYYMk/o1cY1m7Vbxo9EjGFz8Z+R7G1PXn/hpGqFOCpfWfdrAxxu3DmX
 e9IQ==
X-Gm-Message-State: APjAAAXSHq1h5p+SbyPueu26mgy9zcycXq/7/FiFNQ+V1VngubO7YwlO
 JoOlihAbjmxpaZA/mAGiSs4=
X-Google-Smtp-Source: APXvYqz0BBa3Cq2fOj4sVIZ1L1S0VLzBBebNTmb7BKC+0lmHLQ4qY0V7ghMNaRmKKrOcrMZr05VxRw==
X-Received: by 2002:a5d:6a4c:: with SMTP id t12mr10242462wrw.141.1574332214795; 
 Thu, 21 Nov 2019 02:30:14 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id z4sm2528970wmf.36.2019.11.21.02.30.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2019 02:30:13 -0800 (PST)
Date: Thu, 21 Nov 2019 10:30:12 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Tony Asleson <tasleson@redhat.com>
Subject: Re: [RFC 0/4] POC: Generating realistic block errors
Message-ID: <20191121103012.GE439743@stefanha-x1.localdomain>
References: <20190919194847.18518-1-tasleson@redhat.com>
 <20190920092226.GH14365@stefanha-x1.localdomain>
 <32a302d7-b85a-991b-4366-2a82e38a9382@redhat.com>
 <0752f1c5-ed79-bda4-ad53-6b2566cc35a2@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="N1GIdlSm9i+YlY4t"
Content-Disposition: inline
In-Reply-To: <0752f1c5-ed79-bda4-ad53-6b2566cc35a2@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--N1GIdlSm9i+YlY4t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 14, 2019 at 09:47:48AM -0600, Tony Asleson wrote:
> On 9/20/19 12:28 PM, Tony Asleson wrote:
> > On 9/20/19 4:22 AM, Stefan Hajnoczi wrote:
> >> blkdebug is purely at the QEMU block layer level.  It is not aware of
> >> storage controller-specific error information or features.  If you want
> >> to inject NVMe- or SCSI-specific errors that make no sense in QEMU's
> >> block layer, then trying to do it in blkdebug becomes a layering
> >> violation.  This justifies adding a new error injection feature direct=
ly
> >> into AHCI, virtio-scsi, NVMe, etc devices.
> >=20
> > Good discussion point...
> >=20
> > In my opening use case for this POC I'm generically trying to create an
> > unrecoverable media error for a specific sector.  For each of the
> > different device types it's different on how that error is conveyed and
> > the associated data in transfer.
> >=20
>=20
> I would like to get some additional clarification on this point.  Should
> I be investing more time integrating my proposed functionality into
> blkdebug or other?
>=20
> Sorry for the long response time, got sidetracked with other stuff.

blkdebug can inject EIO when a specific LBA is accessed.  Is that
enough for what you want to do?  Then you can reuse and maybe extend
blkdebug.

Stefan

--N1GIdlSm9i+YlY4t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3WZzQACgkQnKSrs4Gr
c8i0mggAhjAQLMYjuznGf6WscY4fVuWP6MAeFK49mw8tDOA24+JyjKSNIeM76/Oj
DvGCpZrdR806E0HbXrK2OeTJaYp0EBbOyATdm82XHJFNAb7XayHRNGphcKfFFhsS
ASdRzojiW0aGS/m8hlzXUtW51OxuROuW7KnSNLoBK+UdFyUZVVYKRUfjtucMXIkz
DW6ac5BGWjG4M1VfxndQslVuoTj2LUivuVhOUl6HH6FK8sVf4loWAHB94txYnfpl
y8BcdrhX58UMI6TETUohLrouH7tUGuXULGmkpiKaXa7X7xOUrKSu8U3FtcSmYuj5
oX+ltLLWudB/7UMZg6utYwNm64gJMQ==
=aoZw
-----END PGP SIGNATURE-----

--N1GIdlSm9i+YlY4t--

