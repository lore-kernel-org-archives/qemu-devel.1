Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EDD1C2BB1D
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 08:24:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DD3A206EB
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 08:24:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fExyju89"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DD3A206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCJ8f-000223-2f
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 04:24:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44773)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jCJ7t-0000os-0u
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 04:23:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jCJ7s-00018J-2I
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 04:23:32 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:46199
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jCJ7r-00018B-Ug
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 04:23:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584001411;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Sb1M8shC6Fkbvp/IB81QO6vS18WnUZtrSCtSCP8ibBg=;
 b=fExyju89+/2bYZvIU6IdEK5fX/f9Ureli9pWYXnSOj45hcBRnQRK2pLPqdTpm7GhSBMLKa
 AFM+eOclN1usRMqenNyHm2O42crZluEfn3uWaKEiRaxu9c+2MRcoAa2NeuUERHYVKYH2Y7
 3CsFrvQ3mmavvpSDLDFXJZw4w8TkQq8=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-9-qQSwoMDfPAqAb6qiuGnTsA-1; Thu, 12 Mar 2020 04:23:26 -0400
X-MC-Unique: qQSwoMDfPAqAb6qiuGnTsA-1
Received: by mail-qt1-f199.google.com with SMTP id l1so2971729qtp.10
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 01:23:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=3mDJAPcF19GH1Q9P98p4ad/9GRtbeU4MLRUhzJ/JRMo=;
 b=MOHbkIjEcO96+4vETn16cvLalWFHvDZwKm/HMttPpudzpTP8BlYQsSuhb8NnCZCuZk
 7j4cX8XO3rn4t+aq5sV3j1i8nB3bieunw/QFa0HPk7RfWXPvxtHKyiJbUEFtcbjA+l/V
 bb0zUzhoAaHULpfHvZ5cCPWtswAmVJJ7xbhUHUNdlQc98lWlEgvyG4kUCQtcZFJS+l23
 ODGtx94ebPa96PoxoyWSHOMZV1ADWdT0ATINtqVHG+4u3iCAajdq7XDs2tPo9jjO5+0l
 ktq3YJL6nRusK4HCRm7RPcFq3mVU823YRAGJ4onOD5ffgJVVcgtovkf0CEBJuYKNQSVM
 Lqtg==
X-Gm-Message-State: ANhLgQ32AuufdSdDihCy7s/+ADQJV+n59cgUbWqtoEZl3BjSkwwIc0Iq
 R1McQ/iJMAwqNGOb+Y2gMKRtfheGOUU24H/latOsOC8r62NBgbV8PUYckXs6GFQgG/gLWFJcNvr
 uWcqejsVOeZ1qRiM=
X-Received: by 2002:aed:3b4c:: with SMTP id q12mr6102978qte.18.1584001406154; 
 Thu, 12 Mar 2020 01:23:26 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vserAA5yRt5NoWv/evfX/PFiPnTVnyFhwIrFlC32ZQZPyQX6QsXdx0hnrbstLeuDLwvr4M2Tw==
X-Received: by 2002:aed:3b4c:: with SMTP id q12mr6102965qte.18.1584001405954; 
 Thu, 12 Mar 2020 01:23:25 -0700 (PDT)
Received: from redhat.com (bzq-79-178-2-19.red.bezeqint.net. [79.178.2.19])
 by smtp.gmail.com with ESMTPSA id l6sm26773067qti.10.2020.03.12.01.23.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2020 01:23:25 -0700 (PDT)
Date: Thu, 12 Mar 2020 04:23:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yuri Benditovich <yuri.benditovich@daynix.com>
Subject: Re: [PATCH v3 1/6] virtio-net: introduce RSS and hash report features
Message-ID: <20200312042252-mutt-send-email-mst@kernel.org>
References: <20200311123518.4025-1-yuri.benditovich@daynix.com>
 <20200311123518.4025-2-yuri.benditovich@daynix.com>
 <20200311094553-mutt-send-email-mst@kernel.org>
 <CAOEp5OdgDB5u-SeZO3y4iCTjFy6hpNfPA-ADaBbnvx=MHD_dTw@mail.gmail.com>
 <20200311161819-mutt-send-email-mst@kernel.org>
 <CAOEp5OcrWewBYNT8TT6r1oFc=diq-HoGfe-zXwXPNSP0RguFkQ@mail.gmail.com>
 <20200312031427-mutt-send-email-mst@kernel.org>
 <CAOEp5Od=GW1onOqchw3H8nYSUByuekYCvi6jsWO8v9SYiFF27Q@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAOEp5Od=GW1onOqchw3H8nYSUByuekYCvi6jsWO8v9SYiFF27Q@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

On Thu, Mar 12, 2020 at 09:42:20AM +0200, Yuri Benditovich wrote:
>=20
>=20
> On Thu, Mar 12, 2020 at 9:21 AM Michael S. Tsirkin <mst@redhat.com> wrote=
:
>=20
>     On Thu, Mar 12, 2020 at 09:02:38AM +0200, Yuri Benditovich wrote:
>     >=A0 =A0 =A0>=A0 =A0 =A0> +#define virtio_net_config virtio_net_confi=
g_with_rss
>     >=A0 =A0 =A0>
>     >=A0 =A0 =A0>=A0 =A0 =A0Do we have to? Let's just tweak code to do th=
e right thing...
>     >=A0 =A0 =A0>
>     >=A0 =A0 =A0>
>     >=A0 =A0 =A0> Are we going to update the virtio_net some time?
>     >=A0 =A0 =A0> If yes, IMO makes sense to do less tweaking in the midd=
le of the
>     code.
>     >=A0 =A0 =A0> Then, upon update of virtio_net.h - easily remove all t=
hese defines
>     that
>     >=A0 =A0 =A0were
>     >=A0 =A0 =A0> added in virtio-net.c=A0
>     >
>     >=A0 =A0 =A0We'll update it in a month or two. But I'd be reluctant t=
o merge
>     hacks
>     >=A0 =A0 =A0since people tend to copy-paste code ...
>     >
>     >
>     > I agree that merging hacks is very bad practice.
>     > Which change is more looks like a hack: redefine the struct to its =
_real_
>     > layout or change the type of the struct in 5 places?
>=20
>     Anything that would be unacceptable as a permanent solution is a hack=
.
>     In this case how about
>     =A0 =A0 =A0 =A0 virtio_net_config_rss {
>     =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct virtio_net_config config;
>     =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* RSS things */
>     =A0 =A0 =A0 =A0 }
>=20
>=20
> No problem.
>=20
> '#define virtio_net_config virtio_net_config_with_rss ' is OK?
>=20

I don't think it is, macros are supposed to be all upper case.

>=20
>=20
>=20
>     --
>     MST
>=20
>=20


