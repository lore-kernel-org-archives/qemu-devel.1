Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA53CC47253
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 16:46:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B325E206D6
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 16:46:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y+CWxXcM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B325E206D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUYoL-0007Qg-TL
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 12:46:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50426)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jUYl0-0004yM-2t
 for qemu-devel@nongnu.org; Fri, 01 May 2020 12:45:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jUYi2-000234-8B
 for qemu-devel@nongnu.org; Fri, 01 May 2020 12:43:21 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30509
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jUYi1-00022E-MY
 for qemu-devel@nongnu.org; Fri, 01 May 2020 12:40:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588351215;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Lqa5/Hx93Kw/D1M5A4Wy1qx7l3BKhql7h3DSB1mtSco=;
 b=Y+CWxXcM20hw/zmqzahcTNBQScVbAIYji/6nSHnnu0hIRhwcxLftk+ZXowme5wPjko7ZlJ
 uyz3L3l8wn1FRggzUC4CXe+QD1wwHU0i5x9ySzX3mkxJpFCL+2Q4f8ePU5qnpy/llWqsPU
 8O5Y6OOL6Orr6xPY0SB1ceASoklIJdE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-400-x8WuzWcGPmir6lmkTJ3SAw-1; Fri, 01 May 2020 12:40:14 -0400
X-MC-Unique: x8WuzWcGPmir6lmkTJ3SAw-1
Received: by mail-wm1-f69.google.com with SMTP id h22so123232wml.1
 for <qemu-devel@nongnu.org>; Fri, 01 May 2020 09:40:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=nMGzYXXlt91nC35gLaccwBBOsZy+woR7AfDs4Zim8QY=;
 b=Yrxr3aqakWpRAr3B3hP8R+TpOwaAU4I101eMtLrwM+BRgjCmFedVXV0TxABsA9df+/
 GIIu4N9F0Om/65hrFCSoXqff02WqaOlf4taQ9KczEk0t1MAq5Rxn0hVrZZg+qXQC3zDM
 2Mm+Sy10Xyv5FTQ36uf+yF8/dVc5oH22He2oYH6d68bMv9AWVLJVUaWO/YYXv2iTsuvp
 6lD0pX4XZQ3KcQ2Cxt6wTmw1uttz6ujWrvd43T/0yP+NKVA6qWPDD5q5Mat2XDBLfiYQ
 LQDyW396Cqs0seUD1ay0pw9yeXkJ1BnMJPkeDliMMdUk1bKA1r4J/3vs7ydJW7tq+Vxs
 Nx5g==
X-Gm-Message-State: AGi0PuYPK0Zuje3W/ATQIZTM+4jdUTth4tH/9gluuLwXzkuHA3thF/AU
 kava7n1XtBw/GD9+R4+y1+cBkOk1nFLwXpL827QjxQ7Ry8KVN2iDkg9Vc889++SV2UiTU8ow5Jn
 ZJ+wunbK01oINIqQ=
X-Received: by 2002:a5d:4905:: with SMTP id x5mr5538083wrq.158.1588351212936; 
 Fri, 01 May 2020 09:40:12 -0700 (PDT)
X-Google-Smtp-Source: APiQypIRCGHwTccvJsAvicP8A0DpZq/du41x9SwaPrD3qakmQGh7aIbIbaxJj7zM2mLNA07i6S569w==
X-Received: by 2002:a5d:4905:: with SMTP id x5mr5538051wrq.158.1588351212669; 
 Fri, 01 May 2020 09:40:12 -0700 (PDT)
Received: from redhat.com (bzq-109-66-7-121.red.bezeqint.net. [109.66.7.121])
 by smtp.gmail.com with ESMTPSA id
 z16sm5485411wrl.0.2020.05.01.09.40.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 May 2020 09:40:11 -0700 (PDT)
Date: Fri, 1 May 2020 12:40:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yuri Benditovich <yuri.benditovich@daynix.com>
Subject: Re: [PATCH v7 0/7] reference implementation of RSS and hash report
Message-ID: <20200501123927-mutt-send-email-mst@kernel.org>
References: <20200329150953.23812-1-yuri.benditovich@daynix.com>
 <20200331102004-mutt-send-email-mst@kernel.org>
 <CAOEp5OeOcTZM_b254LxX5=jRiiAkGSoLsbMeiMjPs2OoF1MxNA@mail.gmail.com>
 <20200501104325-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20200501104325-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/01 12:40:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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

OK so now 5.0's out, I think it's easier if you just send v8,
but it's up to Jason.


On Fri, May 01, 2020 at 10:44:06AM -0400, Michael S. Tsirkin wrote:
> We are in freeze so nothing's applied right now.
> v8 which has all the bits will be a good step so we
> are ready for after freeze.
>=20
> On Fri, May 01, 2020 at 07:01:58AM +0300, Yuri Benditovich wrote:
> > Michael/Jason,
> >=20
> > As Linux headers was updated in qemu and now include RSC/RSS/Hash defin=
itions,
> > please let me know what you prefer:
> > 1. You apply this series as is, then I submit clean-up series that will=
 remove
> > all the redundant defines from virtio-net.c
> > 2. I post v8 of this series with cleanup of all the redundant defines a=
nd also
> > RSC ones
> > 3. Something other
> >=20
> > Thanks,
> > Yuri Benditovich
> >=20
> > On Tue, Mar 31, 2020 at 5:26 PM Michael S. Tsirkin <mst@redhat.com> wro=
te:
> >=20
> >     On Sun, Mar 29, 2020 at 06:09:46PM +0300, Yuri Benditovich wrote:
> >     > Support for VIRTIO_NET_F_RSS and VIRTIO_NET_F_HASH_REPORT
> >     > features in QEMU for reference purpose.
> >     > Implements Toeplitz hash calculation for incoming
> >     > packets according to configuration provided by driver.
> >     > Uses calculated hash for decision on receive virtqueue
> >     > and/or reports the hash in the virtio header
> >=20
> >=20
> >     Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> >=20
> >     Probably post 5.0 material.
> >=20
> >     > Changes from v6:
> >     > Fixed a bug in patch 5 "reference implementation of hash report"
> >     > that caused the ASAN test to fail
> >     > was: n->rss_data.populate_hash =3D true;
> >     > fixed: n->rss_data.populate_hash =3D !!hash_report;
> >     >
> >     > Yuri Benditovich (7):
> >     >=A0 =A0virtio-net: introduce RSS and hash report features
> >     >=A0 =A0virtio-net: implement RSS configuration command
> >     >=A0 =A0virtio-net: implement RX RSS processing
> >     >=A0 =A0tap: allow extended virtio header with hash info
> >     >=A0 =A0virtio-net: reference implementation of hash report
> >     >=A0 =A0vmstate.h: provide VMSTATE_VARRAY_UINT16_ALLOC macro
> >     >=A0 =A0virtio-net: add migration support for RSS and hash report
> >     >
> >     >=A0 hw/net/trace-events=A0 =A0 =A0 =A0 =A0 =A0 |=A0 =A03 +
> >     >=A0 hw/net/virtio-net.c=A0 =A0 =A0 =A0 =A0 =A0 | 448 +++++++++++++=
++++++++++++++++++--
> >     >=A0 include/hw/virtio/virtio-net.h |=A0 16 ++
> >     >=A0 include/migration/vmstate.h=A0 =A0 |=A0 10 +
> >     >=A0 net/tap.c=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 |=A0 11 +=
-
> >     >=A0 5 files changed, 460 insertions(+), 28 deletions(-)
> >     >
> >     > --
> >     > 2.17.1
> >=20
> >=20


