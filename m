Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72A07C282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 16:32:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41A362067D
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 16:32:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X8Q1VV53"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41A362067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipEFo-0002hH-Bq
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 11:32:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53979)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1ipEEo-00028p-3i
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 11:31:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1ipEEn-0000ND-44
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 11:31:18 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:38481)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1ipEEm-0000L4-R2
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 11:31:17 -0500
Received: by mail-wm1-x341.google.com with SMTP id u2so3168151wmc.3
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 08:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=rGyBOHCQcuexZ/dj0nfu9IfkV3dNR8DX6wOvn1971IM=;
 b=X8Q1VV53woiKImNiP1sJMLY68HEVFdj8FWmwfI2cmm6J5wq42JkbKMPAUJbMZdWxDh
 OCRaE3TQkv9w+g8jHAKVJ4K/RBAz5cVRNdp4WYMmDKLF8+y40JCRpPvDwHC2sqUOYR1Z
 oAlvcNWQpdSWtKB/TRZswfpXSK64YTLo7YU40LKjaeYOhpgKZ+Oxu2ydEoJkBzlBa1mY
 FYi8s3sEYomCpkqqpwTTZpfC+Qt7bQpzOYcQRUdQRC+89w35E9BDwyLQtljb1q0g3sAz
 yXuOQF1gfIJor3zaApAx7xKIJJMscWHeNimWv9NFfcufP4487uDrzxS+SyYzfF184Oih
 PpJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=rGyBOHCQcuexZ/dj0nfu9IfkV3dNR8DX6wOvn1971IM=;
 b=aEqeW9Hl8+6CA1mLebsAZy2JZtL6orwitQZ2Q30TXdQVOo+bTx/vrbj8WKEEvzn4/5
 VxJOz4WoF57kaE9g9/jQxKcDn2XoefRmDvejhgy3iPArDNrXpY/xbgu7LBKI/lRdbSNx
 rqE/DOYqjXPdTlbGd+ij7oqKrNdbhgGRqiWr1JTHIlQowT2pl+JAQAbNzagnKTknpuOX
 7XBjzEFK+1EsL2EuPnTdNWbD3EYlOyfZGT8n5Dutflqa8Oj34WHhtdjBfvA2+wODX1UL
 Jza/Z0D490fQwhuuwd1S8VD+6FcK7+0m+rGsQ0CCU0kfXTASVH4AMIKv1Lf6PGZ+Z5mY
 s/uQ==
X-Gm-Message-State: APjAAAUOPtVMkecEMTWOLhli2xHuvK5Whqk6kQZ9CCzZG4vY1l/Xbc7I
 vg9GYysBHuFs3NMgzzocOeE=
X-Google-Smtp-Source: APXvYqy9jF1+uq80gKkhCSDqSosaahz9ewt8TDK2ohLWWD1mZUtUfAv1X9cJaZ73vgAs6rVGPm0Wig==
X-Received: by 2002:a05:600c:145:: with SMTP id
 w5mr5201762wmm.157.1578501075594; 
 Wed, 08 Jan 2020 08:31:15 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id t131sm2331843wmb.13.2020.01.08.08.31.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2020 08:31:13 -0800 (PST)
Date: Wed, 8 Jan 2020 16:31:12 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Subject: Re: [RFC v4 PATCH 00/49] Initial support of multi-process qemu -
 status update
Message-ID: <20200108163112.GA501521@stefanha-x1.localdomain>
References: <20191217163316.GB1333385@stefanha-x1.localdomain>
 <DDE3DA62-31DD-437B-8392-CAD505253EED@nutanix.com>
 <20191219115545.GD1624084@stefanha-x1.localdomain>
 <772D9CF3-D15D-42D1-B9CF-1279619D7C20@nutanix.com>
 <20191219125504.GI1190276@redhat.com>
 <20191220094712.GA1635864@stefanha-x1.localdomain>
 <20191220102237.GA1699760@redhat.com>
 <20200102104255.GF121208@stefanha-x1.localdomain>
 <C4F6A4B0-607A-4BEE-B722-8F5447F1ADB7@nutanix.com>
 <CAJ+F1C+tKZy7T3R6HeMf+iNYq2nGjqizoKT5H=G-=9Zi8gHp=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
Content-Disposition: inline
In-Reply-To: <CAJ+F1C+tKZy7T3R6HeMf+iNYq2nGjqizoKT5H=G-=9Zi8gHp=Q@mail.gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 "fam@euphon.net" <fam@euphon.net>, Swapnil Ingle <swapnil.ingle@nutanix.com>,
 "john.g.johnson@oracle.com" <john.g.johnson@oracle.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Walker,
 Benjamin" <benjamin.walker@intel.com>, "kraxel@redhat.com" <kraxel@redhat.com>,
 "jag.raman@oracle.com" <jag.raman@oracle.com>, "Harris,
 James R" <james.r.harris@intel.com>,
 "quintela@redhat.com" <quintela@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "kanth.ghatraju@oracle.com" <kanth.ghatraju@oracle.com>,
 Felipe Franciosi <felipe@nutanix.com>, "thuth@redhat.com" <thuth@redhat.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "liran.alon@oracle.com" <liran.alon@oracle.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 "rth@twiddle.net" <rth@twiddle.net>, "kwolf@redhat.com" <kwolf@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "ross.lagerwall@citrix.com" <ross.lagerwall@citrix.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 02, 2020 at 10:55:46PM +0400, Marc-Andr=E9 Lureau wrote:
> On Thu, Jan 2, 2020 at 3:03 PM Felipe Franciosi <felipe@nutanix.com> wrot=
e:
> > I even recall highlighting that vhost-user could be moved underneath
> > that later, greatly simplifying lots of other Qemu code.
>=20
> That would eventually be an option, but vhost-user is already quite
> complicated. We could try to split it up somehow for the non-virtio
> parts.

I hope we can deprecate vhost-user.  New out-of-process devices should
just implement VFIO-over-socket with virtio-pci.  This way
out-of-process devices are full VIRTIO devices and it's cleaner than
having the vhost-user protocol that exposes a subset of VIRTIO.

Stefan

--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl4WA9AACgkQnKSrs4Gr
c8i/iQf9Gc5IJ5fMmtsZyjBS5rD0vKE7UQbopefU2kL43KOGlrCH3lepXD2mfFwI
0oyPk5w9fst/GSU0cWqwZv8jXF0ZW1OxqoEnbQ2z4yA/8u4hwuJit0wyUxmPAR+R
1My0t++e6lLiEygxMsYhAliV46/AIzbpzUAEFtAIYRvBwbsvY86kQCl9mK+3rZHt
AbvWZfKodsfO+Er2GaDldZ8PnN9eyKAa4SuaBos+73Vytt+9/ByrzNoww+GyAjJH
sW50cxBGzYVxIU7H9ZeAAnQfolzsG9uhbRU+/E1xfT3tJad35msDUxLOHmdIMPap
DmGo6/6qnuu8/2qOXyeFyriRlSvXLA==
=qRZk
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--

