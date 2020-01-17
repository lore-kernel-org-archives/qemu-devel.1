Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64882C33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 10:29:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E3EC2082F
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 10:29:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L0mspWXv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E3EC2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isOsT-0003M9-Ca
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 05:29:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55640)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1isOrS-0002EK-8q
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 05:28:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1isOrM-00082J-Mo
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 05:28:16 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33392
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1isOrM-00081Z-Ap
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 05:28:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579256891;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DMIDfk34oV+ffHzqhqhrJL1oPlkiq0tvGckbe4tNCeY=;
 b=L0mspWXvRfgYsBSIEl47HEXX0nDrdAw5KgnIyjexJaJpYvog9u9wsqWGdnxkxgfTUtK3pY
 3wb4h50s0FKECVxdU5gKbKIt2jtLhkYU9OFZLAhpP3KE/eCUte22rdp2q3ImHc2uBTKj2h
 6Hk/aHbv/pEikGIvEUiuwHR5NknzZok=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-361-61e2bX-kMyeO2tKrMi92fA-1; Fri, 17 Jan 2020 05:28:05 -0500
X-MC-Unique: 61e2bX-kMyeO2tKrMi92fA-1
Received: by mail-wr1-f69.google.com with SMTP id t3so10295512wrm.23
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 02:28:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to;
 bh=/38p6Hl2WIrbMvBc8THYkENzVSbB2BMb4ZP4lWjv340=;
 b=Qvo0D4l+5b23g0D3a0xGv9GrKtuCLigDEvGXrycCdJ/HchlsqTi54XDgyofux/Jwlw
 0CDGcMmPty52Dc3MGzA31NRvhGBxiUZQpDncZ73B5lApKEh/XtjcZ/PA/PB770N62aSM
 7uhMUo+uwl1KDHh81xYNCUJaOGvxW0rfXR87/A1fFFHC/7C1CxDOj7obu7+L0+ZuAcpG
 kqE6nGZi/hsvFmQpSR33u/k5BLFksc9er8vtIaigzMEOjVs9YK5aezLoICMv7jY3CqfB
 sbCbITYNB3PJmEziOWMVPae2ahrIOihisaz6kTO1gm25JldJ/coBZbclEKwBxuSp2WTx
 tUvQ==
X-Gm-Message-State: APjAAAWvpWRpCCGLvU9pEn/2axZQ5trcWaRbVELeevYXtFo4twmKjxDQ
 zSVLWKD5iKj6HfMH3qOcYT3+oRXGhN6m79Grd+OtySfMtbwDIY1VUc7gCh1L7QRmMN8Zgwsr9wb
 eFa1fpujRYJSTyu8=
X-Received: by 2002:a05:600c:2c0b:: with SMTP id
 q11mr3786622wmg.2.1579256883693; 
 Fri, 17 Jan 2020 02:28:03 -0800 (PST)
X-Google-Smtp-Source: APXvYqz+/wXCtSzv60AuxRkBM/+3esw/PPCpEWNeOlkAYcXbmAFH3kOfovCR9TDj5gRvuPFm+Oc83Q==
X-Received: by 2002:a05:600c:2c0b:: with SMTP id
 q11mr3786604wmg.2.1579256883503; 
 Fri, 17 Jan 2020 02:28:03 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:436:e17d:1fd9:d92a?
 ([2001:b07:6468:f312:436:e17d:1fd9:d92a])
 by smtp.gmail.com with ESMTPSA id b16sm34970695wrj.23.2020.01.17.02.28.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jan 2020 02:28:02 -0800 (PST)
Subject: Re: [PATCH v2] hw/i386: disable smbus migration for xenfv
To: Olaf Hering <olaf@aepfle.de>
References: <20200113174521.3336-1-olaf@aepfle.de>
 <20200116180321.24968-1-olaf@aepfle.de>
 <0335edd2-3d33-88f8-2ab4-4791f7289885@redhat.com>
 <20200117102244.22edd8a6.olaf@aepfle.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ea3a65c3-bd69-7815-6893-cb1cd8b9cfd6@redhat.com>
Date: Fri, 17 Jan 2020 11:27:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200117102244.22edd8a6.olaf@aepfle.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="uEXOxKf3l6O71wuUhjZYiJ363CRxUIzR4"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Paul Durrant <paul@xen.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uEXOxKf3l6O71wuUhjZYiJ363CRxUIzR4
Content-Type: multipart/mixed; boundary="NYc7u98H1MwD1MawDQ4fErJpAygClQOxH"

--NYc7u98H1MwD1MawDQ4fErJpAygClQOxH
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 17/01/20 10:22, Olaf Hering wrote:
> Am Thu, 16 Jan 2020 19:26:39 +0100
> schrieb Paolo Bonzini <pbonzini@redhat.com>:
>=20
>> My understanding is that Xen is able to use "-M
>> pc-i440fx-VERSION,accel=3Dxen".  The presence of the version in the
>> machine type guarantees that the migration stream is compatible and that
>> the hardware exposed to the guest is the same on the source and destinat=
ion.
>=20
> It seems 'xenfv' is not a 'pc-i440fx-X.X', even with accel=3Dxen.
> The "xen-platform" will not be created and as a result no PV driver can b=
e used.

Just add "-device xen-platform" to the command line.

> I do not know what a 'xenfv' is supposed to be, and how it is supposed to
> behave compatible for all existing and future guests.

It's nothing more than a synonym for "-machine pc -device xen-platform
-accel xen" (plus some magic to support igd passthrough, which we could
and should move to the pc machine type as well).  It doesn't even try to
be compatible for all existing and future guests.

Paolo


--NYc7u98H1MwD1MawDQ4fErJpAygClQOxH--

--uEXOxKf3l6O71wuUhjZYiJ363CRxUIzR4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAl4hjDEACgkQv/vSX3jH
roPM5gf/VphJL7BlnDm5TQtYvsDKyeXNRVlKCM64CkAFcZhuD87OgBC15Chu969o
s7CUJ0kbn4wbrAG/n3x5cK/7ZBLAAbXJ0sp1BdzVwXC6AaZnOBRRFUPKgsHmGE/Z
wnZG3pBdmiA1xuwJpRfZ6G9NoTgAHBNtVAPWuybYSv8dO7OFbqKlpQV54DH7Kcfn
QxuNo8UplBdVTBr+i6nzQfQRFUiMAnMSJzcoI44ZjefnmqZqEr2AhWt+14WOK3gI
t9WSusNAJr2sYX0xvHqvjjKdTNFJ3khdWWIuiAndUOjv2jz1wEMOp6FZp5e5jGJd
SxYbpR2pKYmbzBHuUGaVax6bA6xj6w==
=kPDV
-----END PGP SIGNATURE-----

--uEXOxKf3l6O71wuUhjZYiJ363CRxUIzR4--


