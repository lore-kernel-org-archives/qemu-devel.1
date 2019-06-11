Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22333C43218
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 07:25:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E97622086D
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 07:25:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E97622086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52369 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1habA6-0001cw-12
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 03:25:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35265)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jasowang@redhat.com>) id 1hab7i-0007sM-OM
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 03:23:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1hab7g-000318-NZ
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 03:23:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42354)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>)
 id 1hab7f-0002V4-Le; Tue, 11 Jun 2019 03:23:11 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DF2612F8BDB;
 Tue, 11 Jun 2019 07:22:52 +0000 (UTC)
Received: from [10.72.12.214] (ovpn-12-214.pek2.redhat.com [10.72.12.214])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 162BB5C22E;
 Tue, 11 Jun 2019 07:22:48 +0000 (UTC)
To: Tiwei Bie <tiwei.bie@intel.com>, mst@redhat.com
References: <20190611065137.16329-1-tiwei.bie@intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <15f37c7d-5246-e093-e92c-1bd6ff77786a@redhat.com>
Date: Tue, 11 Jun 2019 15:22:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190611065137.16329-1-tiwei.bie@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Tue, 11 Jun 2019 07:22:52 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC] vhost-user: don't ignore CTRL_VLAN feature
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
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2019/6/11 =E4=B8=8B=E5=8D=882:51, Tiwei Bie wrote:
> The VIRTIO_NET_F_CTRL_VLAN feature requires the support of
> vhost-user backend. But it will be advertised to guest driver
> as long as it's enabled by users in QEMU, while it's not
> supported by vhost-user backend. This patch fixes this issue.
>
> Fixes: 72018d1e1917 ("vhost-user: ignore qemu-only features")


My understanding is if may want to revert this patch.


> Cc: qemu-stable@nongnu.org
>
> Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> ---
> It's not clear in the spec that, whether vlan filtering is
> also best-effort:
> https://github.com/oasis-tcs/virtio-spec/blob/37057052e7/content.tex#L3=
372


It should be a bug of the code, we should consider to implement ctrl=20
command for vhost-user.

Thanks


>
>   hw/net/vhost_net.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
> index a6b719035c..1444fc9230 100644
> --- a/hw/net/vhost_net.c
> +++ b/hw/net/vhost_net.c
> @@ -75,6 +75,8 @@ static const int user_feature_bits[] =3D {
>       VIRTIO_NET_F_MTU,
>       VIRTIO_F_IOMMU_PLATFORM,
>  =20
> +    VIRTIO_NET_F_CTRL_VLAN,
> +
>       /* This bit implies RARP isn't sent by QEMU out of band */
>       VIRTIO_NET_F_GUEST_ANNOUNCE,
>  =20

