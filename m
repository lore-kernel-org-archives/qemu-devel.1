Return-Path: <SRS0=faK4=7T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97462C433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 19:50:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C67E2053B
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 19:50:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="JSjx9ofi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C67E2053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhepZ-0005nw-De
	for qemu-devel@archiver.kernel.org; Sat, 06 Jun 2020 15:50:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42978)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jheao-0000Np-PX; Sat, 06 Jun 2020 15:34:58 -0400
Received: from mout.web.de ([212.227.17.12]:35333)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jhean-0000Qh-8E; Sat, 06 Jun 2020 15:34:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1591472079;
 bh=lKUg2PhSFx6sUFem2OVSuuT/pnnC9Z/U+JZQ9f2W1EY=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=JSjx9ofinJBv+SozHFfL4ZkwiOhDZ+taFFsMkB5z6y4OVKBC0Y7OjFEJqq/WHo0bG
 bQXdHZtzTOhHh2RsxXB68bufGCwRKyhoVacORdj9gXbTHX8QRYJxhSCgXjkQbz7wY+
 vcl9m58ZSTVEVfCAXYs7m3hZYgSEkQkA2+a7hcI4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([87.123.206.73]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MPKB5-1jKDLv3JD3-00PpsX; Sat, 06
 Jun 2020 21:34:38 +0200
Date: Sat, 6 Jun 2020 21:34:35 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v3 08/20] migration/colo: Use ram_block_discard_disable()
Message-ID: <20200606213435.664ca5e4@luklap>
In-Reply-To: <20200603144914.41645-9-david@redhat.com>
References: <20200603144914.41645-1-david@redhat.com>
 <20200603144914.41645-9-david@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/LYHMMuSwfzP+qx4=p_ni+M6";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:6/EiRazrWk4aoVSSJLHR/x+lzc9SP4jIhe6OtRGTKIE2vIIS39u
 +9MU1wXuX5wMqOEr6M2hIwSDy5i5IOCKDIeu+A+Nj9tUGCoNZgcVl3jiNzI7Ferxjr8dOLk
 XB8AkKuoreoVIu+lev4ShwOdWY4S8hU6envKebReReOdULc7uR8igOgVjgVSLwTbmJOV4Zq
 KfCJkHVw+af7sX6qzECWQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NlkEyiKaNyw=:pIc6AxLTI8LTPkTs9aVvWs
 hyoadoiWE6feoptSNsvxry1/Xzwi/hYv/1bEtdfwTfIEoC5LIYq2T1042Suv02D4JnH+qHCC5
 zJi/etzDrRHpqVcU1YsWOv+7edppI33pZOYydz2gnmWS94Vtb++meOfMhGTSczvr18KI0/UOT
 t4s9o1xn9dBZNE1bjxvYHVmN+LCwcHbAd1xWG842s4EroTbvcpD/yE7zBSxGJN2uBnZRjtUrZ
 Zhez/GVm7PPqceA8C7QzAZaAHCW15lWimFftGfzmZZEnRbl5iy0WHL+TUpXEwNS9+EhEhM6VM
 N5iY2hOc3sQr4KHbHdyAuOp9TW6cWA4KYhtUfB8c4G2Vd3z0xhx9gecykCnvYrP61OWyNOjoA
 RgZ2DymITWXSDojqaeOp6y83tmEmM1HuzCAL1/HdTQpK626kf91kKdm0LNvSRKC8whYgR0SPm
 lsKo7X+fNHXO1x9rRv/yDxUljGiGQVGn4Y53XCjaz6JHDhhftj1OFAqqQa1SPUvF9Q4ZErQLk
 xn2NkmSrxWLMtlCojYMlrWCU32ued6xY21gTlIO7HokoQJ1bXhlI3O1dswPAta1eMa7niTP2C
 pQLE6xVeZsInaYBoZ8R6FTWvmkb3zMGAmuYgpglWxozDHznBQ91U/++5KJ9MC8TXJcGpzepmI
 P8Sd0rSbY8KVqDpnqo7GzYUAxT4Nx7OItnHASrxcBJYv3RBNWy7/jvHd1INhnDLHJQPA6bXyy
 ssOGf0sKjfbaMd9S8NZzKmva+zoqEWM0pbLBME/oLZkDT77rkVAemxpRvSExXnsCkYvKsOC6C
 tKZoacES7u0TjiErd/mrB8KmZQXKNIndlapbL1jvkT8enX56dbPvsp0J942EyjjiBOJT2c0PS
 wiiQXmkM+mESeKBMfwga15qmKfgls/nQpSLPqSXurJkgLcLfj086j2P9pNn8woSfSVem64YBP
 MOdKGexIahoC6YhMz637Pg171Whhqxd7EylDBPp1KSvkqCa0dW4BgBTRmyPyGZGeQRZosXgyX
 yJsVm9hWaNUkFdN9SkJMRYf7MRS3kHbgtvsWya6zyo87ZyhtCbbapiYI+JxJhmcv3l9CphJrq
 kZusiFvnUjdQOoczAuziScWvrrjLYW1YChWAYrOcioTphWmkE5wyET+k/3imbdE3G8WInd/Ap
 +yS21v6A1mrHsWYxZonGUAsHcHzwbc55ZsU9JgF96a9qoY1pYeMzJlmA6b+RsX8Idb/MOHYWv
 7WUw0hTP5UjkzPuia
Received-SPF: pass client-ip=212.227.17.12; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/06 15:18:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 Juan Quintela <quintela@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>,
 Hailiang Zhang <zhang.zhanghailiang@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/LYHMMuSwfzP+qx4=p_ni+M6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed,  3 Jun 2020 16:49:02 +0200
David Hildenbrand <david@redhat.com> wrote:

> COLO will copy all memory in a RAM block, disable discarding of RAM.
>=20
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Hailiang Zhang <zhang.zhanghailiang@huawei.com>
> Cc: Juan Quintela <quintela@redhat.com>
> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---

Hi,
This works well in my colo tests.
Tested-by: Lukas Straub <lukasstraub2@web.de>

Regards,
Lukas Straub

--Sig_/LYHMMuSwfzP+qx4=p_ni+M6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl7b78sACgkQNasLKJxd
slgswQ/9HxF5Kde3XJ4TbdV2756BABKJDSIQxKbvLTFAVJ3J9uMZSP8lv0h1Yftc
oMiKl1oKyeUDHZiwz+5MjCP6UZiIjl5UNqg4oJD7Tsl43aUYuxfBXhxtPGNVKFx1
EJRphGSiZcd+kYFx5OUvzB+f/fNsu5n0YhJ+iyD54Ttj2NZgBgeTyQ2UCoGM2RQc
kG8ZiUOGh6AEd/D5gRh5mbPToB9GVR54col2891RBBATA5gIfpxzRBY/gUoKCjKY
t8aGiZ3NB9/Ekb4Zv0zpodsUPxfS4xfhJSFyU7DtNeF0PclVZDjhWKWpmoWUvo1P
dhKCj7FtikfbuhRKbr5+myjYu+mZyK82+v7fR5KydmiAo5dL5x2uYD0sSKq/fZT9
6xakcwHCi3h0438Pi7iIuH+COKw4IKIeF8Rt2UEz6pz+1xCGGfLi7M5MYl3qi4MI
SQapHk1uruog/YLVK73H8KzqU7bc8qgKLOTqCcCdyWvhTf0t90J8k3fNQ8Fv62ej
1Loyy/WOuaHfEO2ajYamJPCRbJm95echI6E4odyCLu2hAfQq1Z78+78EiXP9Cxnq
rArF5n4vtGinKBLy4MDCByR/H0SYf2KAV0vSh9N82WhKHc3hNbN2jvijVK3CEn+E
wc9Jyymae3vXdkU4CCZudCSwhuNX2w/eJ13WZVTWo9nftO8vJVE=
=kqMZ
-----END PGP SIGNATURE-----

--Sig_/LYHMMuSwfzP+qx4=p_ni+M6--

