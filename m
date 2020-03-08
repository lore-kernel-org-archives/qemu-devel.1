Return-Path: <SRS0=qQQb=4Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF1B6C10F28
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2020 08:07:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B31B52072A
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2020 08:07:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XGBzzxKm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B31B52072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAqy8-0002yd-Vv
	for qemu-devel@archiver.kernel.org; Sun, 08 Mar 2020 04:07:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47456)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jAqxP-0002a1-8x
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 04:06:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jAqxN-000783-Di
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 04:06:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25724
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jAqxM-000779-OU
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 04:06:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583654800;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aEvZBDhWcZXlviTCN+pHMJTGTkGHa5XPngwwwhBasr0=;
 b=XGBzzxKmw+vQwlMA3ubFxQ996tXb7h85pV1Bx+uKna5HhKRxS/f4P4JMY0tw0pQLdbu204
 AZriACvybf1V+j6o+LVSzACcHrwDutLQtZ2tbEvrblKxc1b2plDZVFpe+M4E6F2ssGpyNq
 dPz6/PV0dQ2+reRSfTMPowOM0EYcjrU=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-wV2UfmHiOtGAntyRTRr0nQ-1; Sun, 08 Mar 2020 04:06:36 -0400
X-MC-Unique: wV2UfmHiOtGAntyRTRr0nQ-1
Received: by mail-qv1-f70.google.com with SMTP id fc5so4631457qvb.17
 for <qemu-devel@nongnu.org>; Sun, 08 Mar 2020 00:06:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=7c5HbLDHb7V+Xunbgn/tZu2rnh1tp4qR5LFNvuae20w=;
 b=G6EhC6l219vU7fWbQnJxK4kzqW33lRMPzRgjvxOi/rDk77iCL4Bq7CRPUeBxnR+31q
 nL8Cyue2kE2g1ateh44nBEw/IcXhiBIC+y6yLaSxnQ+BgJkFsaJf0DkaZ2gv+wP6MlAP
 +u5zi1ggvSWg5Wa6xjG7SsPh/rLCSURrGOEi+61QXp0sRohp7hyb6L3inIlZJ1u4bfi4
 nzEN30VLNFwsRUePqWeB+kVOTknR/64AxeR+fes7H6VMUm/2tlVAeP8MaIQNTMbq+G2G
 QdDuvrvCeLKe2bCJWDG/iiHJTzKVdRkpNgQjb59lXNi7zBcornyF7o0T5XiSMoJIYgUD
 Q2VA==
X-Gm-Message-State: ANhLgQ3I57dFfSi40LrbPnHP4SnG7TqfpflzuffQF0SqQAcOz77YeOmL
 ijED6CYziYi/dhBULlvAhDA+kTLhD+kfLkWOGpETDeYXmgbA43Kylj2UtiTi0k3NRi7gsUbQ/ob
 DR1OWCMGuXa9ATY0=
X-Received: by 2002:a37:b243:: with SMTP id b64mr10738003qkf.164.1583654795799; 
 Sun, 08 Mar 2020 00:06:35 -0800 (PST)
X-Google-Smtp-Source: ADFU+vuEuFjg7j3vtY/ATFDcjYelGeJmP0d9HU+N4RHgV7du61TSJ+EZINPlUt44q4bOMsCroFGR7Q==
X-Received: by 2002:a37:b243:: with SMTP id b64mr10737989qkf.164.1583654795584; 
 Sun, 08 Mar 2020 00:06:35 -0800 (PST)
Received: from redhat.com (bzq-79-178-2-19.red.bezeqint.net. [79.178.2.19])
 by smtp.gmail.com with ESMTPSA id j18sm20046553qka.95.2020.03.08.00.06.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Mar 2020 00:06:34 -0800 (PST)
Date: Sun, 8 Mar 2020 04:06:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yuri Benditovich <yuri.benditovich@daynix.com>
Subject: Re: [PATCH 0/3] reference implementation of RSS
Message-ID: <20200308040540-mutt-send-email-mst@kernel.org>
References: <20200226174809.9675-1-yuri.benditovich@daynix.com>
 <87242152-5823-59a0-b0ce-2aa555559391@redhat.com>
 <CAOEp5OfPkQsWs=kYzwxHA0t_gv0iFb4OD6Wppde+qo42wr-eGg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAOEp5OfPkQsWs=kYzwxHA0t_gv0iFb4OD6Wppde+qo42wr-eGg@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: Yan Vugenfirer <yan@daynix.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Mar 06, 2020 at 11:50:30AM +0200, Yuri Benditovich wrote:
>=20
>=20
> On Fri, Mar 6, 2020 at 11:27 AM Jason Wang <jasowang@redhat.com> wrote:
>=20
>=20
>     On 2020/2/27 =E4=B8=8A=E5=8D=881:48, Yuri Benditovich wrote:
>     > Support for VIRTIO_NET_F_RSS feature in QEMU for reference
>     > purpose. Implements Toeplitz hash calculation for incoming
>     > packets according to configuration provided by driver.
>     >
>     > This series requires previously submitted and accepted
>     > patch to be applied:
>     > https://lists.gnu.org/archive/html/qemu-devel/2020-01/msg06448.html
>     >
>     > Yuri Benditovich (3):
>     >=C2=A0 =C2=A0 virtio-net: introduce RSS RX steering feature
>     >=C2=A0 =C2=A0 virtio-net: implement RSS configuration command
>     >=C2=A0 =C2=A0 virtio-net: implement RX RSS processing
>     >
>     >=C2=A0 =C2=A0hw/net/trace-events=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A03 +
>     >=C2=A0 =C2=A0hw/net/virtio-net.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 234
>     +++++++++++++++++++-VIRTIO_NET_F_RSS
>     >=C2=A0 =C2=A0include/hw/virtio/virtio-net.h=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 12 +
>     >=C2=A0 =C2=A0include/standard-headers/linux/virtio_net.h |=C2=A0 37 =
+++-
>     >=C2=A0 =C2=A04 files changed, 273 insertions(+), 13 deletions(-)
>     >
>=20
>     One question before the reviewing.
>=20
>     Do we need to deal with migration (which I think yes)?
>=20
>=20
> I think we don't (yet) as this is a reference implementation and the main=
 goal
> is to provide the functional reference for hardware solution.


That's fine, but then we must block migration, and add appropriate code
comments. Just silently losing data isn't a good idea.

> I agree with the general direction that for complete support of RSS and h=
ash
> delivery the best way is to do that in kernel using bpf.
> For that, IMO, the bpf should be a part of the kernel (it uses skb fields=
) and
> the tap should receive just RSS parameters for it.
> At this stage we definitely will need to add migration support and propag=
ation
> of RSS parameters.
> =C2=A0
>=20
>=20
>     Thanks
>=20
>=20


