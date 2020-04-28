Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C6EC83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 13:11:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE96F206A1
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 13:11:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Olhb/2AZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE96F206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTQ12-0005VA-Lj
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 09:11:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59998)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1jTPxC-0002qF-QT
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 09:10:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1jTPvC-0008KI-PY
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 09:07:14 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:36843
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jTPvC-0008K9-BA
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 09:05:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588079109;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QJYeEeU2W5Zbt4lIHEAzak6g6ZdWtwkXqu983b08u90=;
 b=Olhb/2AZcGVp+r4pBv2BwvVkMYJAcc+YHyx8M0k9BP+YIq9njDidI7HuaxDmk3kEA/zNH1
 TPJcfJW/OXohI5QYdO3kYS2R39PYUeiKt40C8J7EmbQvHZsvqPwXGPuVYJUPGpyKEnQt3C
 JHP0430F2R1LgXMdQNz2khvN73Kczj8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-455-90ZUCyqOMbuEYJOpK1WJDA-1; Tue, 28 Apr 2020 09:05:07 -0400
X-MC-Unique: 90ZUCyqOMbuEYJOpK1WJDA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6AB93800C78;
 Tue, 28 Apr 2020 13:05:06 +0000 (UTC)
Received: from [10.72.13.37] (ovpn-13-37.pek2.redhat.com [10.72.13.37])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ED2F41001DC2;
 Tue, 28 Apr 2020 13:04:59 +0000 (UTC)
Subject: Re: [PATCH 3/3] virtio-net: remove VIRTIO_NET_HDR_F_RSC_INFO compat
 handling
To: Yuri Benditovich <yuri.benditovich@daynix.com>,
 Cornelia Huck <cohuck@redhat.com>
References: <20200427102415.10915-1-cohuck@redhat.com>
 <20200427102415.10915-4-cohuck@redhat.com>
 <7f703bea-2cae-dcdc-71bd-9623c7db33ac@redhat.com>
 <20200428103407.12612838.cohuck@redhat.com>
 <85367d20-e4f5-6869-319e-2f60d2510130@redhat.com>
 <20200428111801.7422d95a.cohuck@redhat.com>
 <CAOEp5OcgjWQzU=pRwc+2ftwGnX97wVR+vO-7HkV4=yNnsjcdhg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <0dac9fae-5604-8ae2-1afa-7a4e1fcdfb75@redhat.com>
Date: Tue, 28 Apr 2020 21:04:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAOEp5OcgjWQzU=pRwc+2ftwGnX97wVR+vO-7HkV4=yNnsjcdhg@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 04:11:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/4/28 =E4=B8=8B=E5=8D=886:55, Yuri Benditovich wrote:
>
> On Tue, Apr 28, 2020 at 12:18 PM Cornelia Huck <cohuck@redhat.com=20
> <mailto:cohuck@redhat.com>> wrote:
>
>     On Tue, 28 Apr 2020 16:58:44 +0800
>     Jason Wang <jasowang@redhat.com <mailto:jasowang@redhat.com>> wrote:
>
>     > On 2020/4/28 =E4=B8=8B=E5=8D=884:34, Cornelia Huck wrote:
>     > > On Tue, 28 Apr 2020 16:19:15 +0800
>     > > Jason Wang <jasowang@redhat.com <mailto:jasowang@redhat.com>>
>     wrote:
>     > >
>     > >> On 2020/4/27 =E4=B8=8B=E5=8D=886:24, Cornelia Huck wrote:
>     > >>> VIRTIO_NET_HDR_F_RSC_INFO is available in the headers now.
>     > >>>
>     > >>> Signed-off-by: Cornelia Huck <cohuck@redhat.com
>     <mailto:cohuck@redhat.com>>
>     > >>> ---
>     > >>>=C2=A0 =C2=A0 hw/net/virtio-net.c | 8 --------
>     > >>>=C2=A0 =C2=A0 1 file changed, 8 deletions(-)
>     > >>>
>     > >>> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
>     > >>> index e85d902588b3..7449570c7123 100644
>     > >>> --- a/hw/net/virtio-net.c
>     > >>> +++ b/hw/net/virtio-net.c
>     > >>> @@ -77,14 +77,6 @@
>     > >>>=C2=A0 =C2=A0 =C2=A0 =C2=A0tso/gso/gro 'off'. */
>     > >>>=C2=A0 =C2=A0 #define VIRTIO_NET_RSC_DEFAULT_INTERVAL 300000
>     > >>>
>     > >>> -/* temporary until standard header include it */
>     > >>> -#if !defined(VIRTIO_NET_HDR_F_RSC_INFO)
>     > >>> -
>     > >>> -#define VIRTIO_NET_HDR_F_RSC_INFO=C2=A0 4 /* rsc_ext data in
>     csum_ fields */
>     > >>> -#define VIRTIO_NET_F_RSC_EXT=C2=A0 =C2=A0 =C2=A0 =C2=A061
>     > >>> -
>     > >>> -#endif
>     > >>> -
>     > >>>=C2=A0 =C2=A0 static inline __virtio16 *virtio_net_rsc_ext_num_p=
ackets(
>     > >>>=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct virtio_net_hdr *hdr)
>     > >>>=C2=A0 =C2=A0 {
>     > >>
>     > >> I think we should not keep the those tricky
>     num_packets/dup_acks.
>     > > No real opinion here, patch 3 is only a cleanup.
>     > >
>     > > The important one is patch 1, because without it I cannot do a
>     headers
>     > > update.
>     >
>     >
>     > Yes, at least we should dereference segments/dup_acks instead of
>     > csum_start/csum_offsets since the header has been synced.
>
>     So what about:
>
>     - I merge patch 1 and the header sync now (because I have a bunch of
>     =C2=A0 patches that depend on it...)
>     - We change virtio-net to handle that properly on top (probably best
>     =C2=A0 done by someone familiar with the code base ;)
>
>
> Jason,
> This series just solves the conflict caused by the update of Linux=20
> headers.
> After this series is applied I can submit further patch to use actual=20
> RSC definitions from linux headers.
>
> Thanks,
> Yuri


Yes, please.

Thanks



