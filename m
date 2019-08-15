Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB3C7C3A589
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 13:21:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 709522083B
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 13:21:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gpo05l9P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 709522083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyFgh-0004Ec-Ge
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 09:21:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45932)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1hyFfv-0003TF-Kn
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 09:20:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1hyFfs-0002Jw-5Z
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 09:20:19 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:38243)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hyFfr-0002JG-LJ
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 09:20:15 -0400
Received: by mail-wr1-x443.google.com with SMTP id g17so2208710wrr.5
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2019 06:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=gsRzpuxPuG0tEvg7NT3BA7aoPEIMGSJPI6OQ9O15cDc=;
 b=gpo05l9PfkB8XCQ4I7z3JG0DqIgze6Y/ODu/9tOfqaEe9qcOCPp/VpagJwO5OzuYx3
 rLnSznPTfpQIBdcZj2SrIMT1lOU/1lfCtM22pAMYh0k51bU5NI3GQ9a3HLVIVvWcplb5
 mdQhIPJXX+82dtiNw70sK/Uuca8JEfiQrQ63qC877F4VAaJEZkZQcqnRcvQ/rINhi6Ge
 laHe1/cnwS27hCqkJXcZ+ryflTMxQrPc2OT8oQXnIyK1+P5WTatvFe64KDHeITvw+X11
 VVvlNJMtaQGOVDTSD0Bl4Zrdyes6ziPm4YH1hB1nFkSrY5IQS0npa2e04FPKIuIzJ3l+
 dTXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=gsRzpuxPuG0tEvg7NT3BA7aoPEIMGSJPI6OQ9O15cDc=;
 b=lelTBmrrsQ5J2TefEGBQ96SEQiI+Oaxd0S2QplGu0STdXHNz/evT6qOMGC02ASYEsO
 8Jn20nFSysdeK8/rmenf5FnsyjuumCT+fxJt8F+0oVyy2SDBtuYjZ+Bq9clSRb9UDhWl
 Cz0EVi2uZ3L4G+5OScovbfVY77PYqNwcx0sYbS80YJOnOpvHz1+0aYoZwTM26adrM+sT
 aRsdMxvyAfQOGMd8VZXtu7AmHv2vaqHcnbAkk9EXqgiGp72dgmBwhE/acvT3SEztylKB
 HQUME+Soa1qTEjY80TNqBOjXOYPOl8sbnZ3oiMZhqkjHTXgeZe/CWoIoXoBcCrCKeXJF
 n4ZA==
X-Gm-Message-State: APjAAAVI/fz351ulUb8oOZ61Nsb5QbwNgw7j1LSmGjlhY2j9YPTk0UYR
 WvLvO2TU5eSYvpNZxvDPrM8=
X-Google-Smtp-Source: APXvYqw7fuxixC342XjweFpzHT9NJIB/fLugfO3zP5pciMl+yPBfaUlCaWgfU/mLwY1zy+Qz+3z5yA==
X-Received: by 2002:adf:82d4:: with SMTP id 78mr5083274wrc.85.1565875214172;
 Thu, 15 Aug 2019 06:20:14 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id p10sm1188204wma.8.2019.08.15.06.20.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2019 06:20:13 -0700 (PDT)
Date: Thu, 15 Aug 2019 14:20:12 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190815132012.GB10996@stefanha-x1.localdomain>
References: <HK2PR04MB38595779EA521C94675599F981DC0@HK2PR04MB3859.apcprd04.prod.outlook.com>
 <20190730162803-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="K8nIJk4ghYZn606h"
Content-Disposition: inline
In-Reply-To: <20190730162803-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: Re: [Qemu-devel] [PATCH] vhost-vsock: report QMP event when set
 running
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
Cc: "N. B." <n.b@live.com>, Ning Bo <ning.bo9@zte.com.cn>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, stefanha@redhat.com,
 "armbru@redhat.com" <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--K8nIJk4ghYZn606h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2019 at 04:29:35PM -0400, Michael S. Tsirkin wrote:
> On Tue, Jul 30, 2019 at 12:24:27PM +0000, N. B. wrote:
> > From: Ning Bo <n.b@live.com>
> >=20
> > Report vsock running event so that the upper application can
> > control boot sequence.
> > see https://github.com/kata-containers/runtime/pull/1918
> >=20
> > Signed-off-by: Ning Bo <ning.bo9@zte.com.cn>
>=20
> Cc Stefan.
>=20
> Stefan, are you willing to maintain virtio/vhost-vsock in qemu, too?
>=20
> If yes let's add an entry to MAINTAINERS, ok?

Yes, I'll send a patch.

Stefan

--K8nIJk4ghYZn606h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1VXAwACgkQnKSrs4Gr
c8iIEQf8CHaO2PWMSm0/zUQyXg2Js/wPjeZ4cN0aECNdvw0SRK54WUdQlngYKgx9
2VrT6oI4xTLo8/MHoE1SJeh+vttfROM/duAmF5aRxiYvUG22OH2SM0cbLm78bz5L
SufVGd5UFGejIVYIlN045i0urhuhkBvo7/oPglauUtt6CmXkuoYj8UBNS06Mr/qU
Ldqi/kgpa7t0P6Utzb5bxGybPquLWNO6aRfYbHliYfsNpoTAPeK4TYWdW5zqxAve
1riBDyLoXm7C4ylQSYrqa728uT4dYez3wDWkEMoJeIsM71OhtZpfqen2zFlrXjqE
E8Q8B16rioiQeqXpqHS6wELWQN4VCQ==
=nr8q
-----END PGP SIGNATURE-----

--K8nIJk4ghYZn606h--

