Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E58C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 18:28:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EBCB2074B
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 18:28:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="JQU18/x4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EBCB2074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfpB8-00039x-0g
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 14:28:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37880)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jfovi-0007LM-L3
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 14:12:58 -0400
Received: from mout.web.de ([217.72.192.78]:46205)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jfovh-0002GB-Cn
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 14:12:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1591035138;
 bh=WmmKUUNPo0qEBUlgOQbunhnFj5UkS+Zb/Z3TozJP1bI=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=JQU18/x4Q21Ja3lT91tfoRlAu7QARMk0mn5y+dENOFRhMMQUPFKgzuE+zZ165CibF
 Xq2GO35IZdcRz0HJ98+1LAd54s+svY1z4HfgT7uPyzV96Lr15DlPYy7vzp68i1kqMc
 ER9I5ii84toOWOWeLR/BVTgJsRUbOgWVWopvMVpY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([87.123.206.136]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mq1CC-1jBlRI0TPm-00myK0; Mon, 01
 Jun 2020 20:12:18 +0200
Date: Mon, 1 Jun 2020 20:12:00 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: Alberto Garcia <berto@igalia.com>
Subject: Re: [PATCH] block/quorum.c: Decrease child index when del_child
Message-ID: <20200601201200.10e2ea59@luklap>
In-Reply-To: <w515zcbm5p3.fsf@maestria.local.igalia.com>
References: <20200601071956.18006-1-chen.zhang@intel.com>
 <w515zcbm5p3.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/tJHQsFT35LfpwcOqOrd/0VX";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:vqHKcM73yYXlBtv3NXNZfswbm8gWdGai+20ODFcUTcLDKFnhChb
 bPsWFJcLpkTVom4sleSZ4w/DfEptC07d19J2yZo2YH06rWqtMh5ZHqZ3Yai07vcxBvWzK0g
 4E5zihLseF2xz4iJrwHycZ9u43dbeKaHbWQzM7PWFMr5g4NDZ8pRnnJtZRptcEjfc6hMkjj
 yz0s+9P8PYvZxb0g/evqQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xXYT9rC8w0s=:ZlS/vi9oM1khST1uuSlL4/
 CJydbnXufjLpiQb4cpI5psxM/dAgWblzCSqiWhKNaaBKNoqnAfRq8jiNGAs9yCZa31lTiqeqI
 FIX5yU0MKxtmeJKkKY6BG8P+N5JIg/2GkSW4lRABKrb3F/12qLVjmjgOhshb79hG3Os4b0q4a
 Pd9V3yQu6mz4YVSFeN7T3nbGTclLjlDGm2nXrHjCERHJjPw+eFIq+bJDomld3fIJlVKuiIVoB
 GI6IM8AE1uqQ1mlUVRugvdYqhxLSDLbP1yU9w3j1hZnrJsSIu9CA7MkfEnx7RnyLPiL+LN/yy
 arYA2oqttG260MLxu+ujyPe9DJoWC2YChdTv3VXSR13zQPf9c4BzuKEpogERaXfzPUnTYL+PY
 eKSprN8Y6y3wHqFAei586TxH5MkBeEvVyUedBKKsc9ihbAv+SFqpSKy9gC44VdUzsLgxtknL7
 KzQx3W/bU2Q71kc95pl1Hl37I1yjOFGDV1B0l57mbPAn/6NbUdTlKyIZ8+NjBRhugJ3yQP2mi
 a5CcamSSHTNRYHCGILoRc6BRXsGNSgNoz48O5Zke3u/YuPOuh2TpVsGu6uW4kVVrnU19WZbZL
 2ads1eKxfuDLIEMFt2ICr6edqfN+qOLhjewEhKghA4/EnmttBLRZ7jwZxCggwpMWR2Sk5vjID
 fGhI0VpMy0IA9d4c+s5fneL9SBkMzuf8cjCGGu+fzKUD7xECbOZR7KdhJkoviXP25Rjdf+FRq
 ao3Ojjc61R6lI49d5Gp4eOL3OdHPY4IAXpm1nvROI6q4KvFIBD8a6Ey6jPsb96FJ8OK6yqHey
 H2g6WmjnUHnbt7JqhUOkXIicBJdlfyFqL/93smjq/TNW8zdwCNcBNx1a8ZcU2v0Z0mfCHgRDa
 wSa1QTje9rO2OlN6Px9gNCJcv9FJ1F7sn4sPCRr0Wy276V/7EaGb8/kr9KijlWgOgeubh4jt6
 FHjwM8IZdZHkFANg1fPNFoiIXCB1wK/nQKAz325TK+d1hJUTFe4liM5KYlDG+B/jUll7Vhqj1
 vnQejAXdnNIuNArXUBl7Xm3bdQ4ggdh6h0c0QmQnYOIgrR3rmVDJK1gOU5qcJ5WwAQ4zJZCkt
 O1u6R0/zJYv6zM1ZHTyLZBNr3kh5rQWTdL6FM0bPeyxrjARCE/yd2YrHPWNCmcmwn6mE5uPO8
 V1NsFAr++Fz4Za8YqBHSLQ+f3yq2wKlqr5JpFWqXZvYuCB96M/fD8B8OXk/CiHLJdpKe4aDKC
 Wijhp3BJSrZOsAZ30
Received-SPF: pass client-ip=217.72.192.78; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/01 14:12:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Zhanghailiang <zhang.zhanghailiang@huawei.com>,
 Jason Wang <jasowang@redhat.com>, qemu-dev <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, Zhang Chen <chen.zhang@intel.com>,
 Zhang Chen <zhangckid@gmail.com>, "Dr
 . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/tJHQsFT35LfpwcOqOrd/0VX
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 01 Jun 2020 12:38:32 +0200
Alberto Garcia <berto@igalia.com> wrote:
> As I explained a few weeks ago this patch is not correct.
> quorum_del_child() allows you to remove any child from the Quorum
> device, so nothing guarantees that next_child_index-1 is free.
>=20
> https://lists.gnu.org/archive/html/qemu-block/2020-05/msg00634.html
>=20
> Berto
>=20

Hi,
Did you have a look at my series? There it's fixed properly:
https://lore.kernel.org/qemu-devel/9df6b3723ec30cb749ceaa555d82a29a6d79496d=
.1589199922.git.lukasstraub2@web.de/

Regards,
Lukas Straub

--Sig_/tJHQsFT35LfpwcOqOrd/0VX
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl7VRPAACgkQNasLKJxd
slhcihAAhaJidrn8QD/0hWKajtRmlJiGY1ITPxIcuj17mR1QmJJ+PxA16q14Mwqu
cAzMbctmMYugIh1L+Gv8XEqdrC30o4SGgh0Mino69ZBafG2couR0cWvWff5Nwg2I
7SSiRGbp4qdsMnKU+nnKVuu8OfDTAUS4fCU9nQ5TO0gAliDyPuGfEMWMS20FUtLF
K++82t1Uv110/CZrwFXNSqhY41WXRIwbjGkasWppbrOpeEZLVupW6KO1ktDTNpLE
MGUVqD/69NfSRsrnjmnmW9+E4iTBXG85bIBVxmQsEhinc36Igu7esGFZLDNgsEBz
I5f4UqB2ZG5rxEn3BqXbNxBrxxbB1+o2rAK02m03PN2tIcs2EpRYWWw7r3Sf+KwP
IrtX3SjIfPR81CzrCLfHuB+WHNM6r6dKgWrSsKIjLMq6o4xUJV6x3lthmXbISvHC
TaqmZwp2zLqkKbps3VaYNvXn4SK2ry6LdR9t8H4GVk6T7VoF/oamEZH2WVT5+otL
N+TMm44dB76l9HxGZ/lr8NmpbAWn92aqf1K5v2XusLmVDcQIi959AvAvcNefZqSK
H6er20s0FiD1aqdlzJXRceZQwKkQf8tR7OIej3UNxrfv8mHiiqSQJJbmof6W+/Vz
I4j8lZCLgXg1yrOGjYWan/YJ0mIxEMY0EPo+e0w8FXNV/xwxCF4=
=zBcI
-----END PGP SIGNATURE-----

--Sig_/tJHQsFT35LfpwcOqOrd/0VX--

