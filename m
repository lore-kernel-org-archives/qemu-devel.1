Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 476B5C2D0EE
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 09:48:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D11E20714
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 09:48:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d0gu+1Vm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D11E20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIr21-0008Cm-69
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 05:48:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42441)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1jIr1C-0007hA-2a
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 05:47:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1jIr1A-0003sd-Jl
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 05:47:41 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:41910)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1jIr1A-0003s1-9M
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 05:47:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585561659;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fGZ48B7G3BziEjDZPS6wc9j+vNKY5YihIl3COxIMS0U=;
 b=d0gu+1Vmqu/7N+ZSMSfK2w4LdmWbos4HKGTO3Vut4gW5mO639O/OGpENzL95DCDulnzsms
 5dXaNWOuIPeDRt0lWBelomYQkSDeyqzEFMbdkKWFhHnnYshT0wN2fwSweJ3Wf+7cypm/A1
 04mp7NUG3NAPQj0rQ/D+FhLidDjvsec=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-zT3dh9OCM-e4u_k9ykyjqw-1; Mon, 30 Mar 2020 05:47:36 -0400
X-MC-Unique: zT3dh9OCM-e4u_k9ykyjqw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 05DF71005509;
 Mon, 30 Mar 2020 09:47:35 +0000 (UTC)
Received: from [10.72.13.226] (ovpn-13-226.pek2.redhat.com [10.72.13.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D7E0D5E026;
 Mon, 30 Mar 2020 09:47:33 +0000 (UTC)
Subject: Re: [PULL 00/13] Net patches
To: Peter Maydell <peter.maydell@linaro.org>
References: <1585307647-24456-1-git-send-email-jasowang@redhat.com>
 <CAFEAcA-u-vp6ETypJLTakc0bCTYfg7_9ONF6Za7GsmOtz6qXVQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <463a4d56-d843-a1a2-f078-b82c922730d9@redhat.com>
Date: Mon, 30 Mar 2020 17:47:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-u-vp6ETypJLTakc0bCTYfg7_9ONF6Za7GsmOtz6qXVQ@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/3/27 =E4=B8=8B=E5=8D=887:36, Peter Maydell wrote:
> On Fri, 27 Mar 2020 at 11:14, Jason Wang <jasowang@redhat.com> wrote:
>> The following changes since commit cfe68ae025f704f336d7dd3d1903ce37b4458=
31d:
>>
>>    Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-5.0=
-pull-request' into staging (2020-03-26 20:55:54 +0000)
>>
>> are available in the git repository at:
>>
>>    https://github.com/jasowang/qemu.git tags/net-pull-request
>>
>> for you to fetch changes up to f3b364f4f77fcb24cec468f518bf5e093dc27cb7:
>>
>>    hw/net/allwinner-sun8i-emac.c: Fix REG_ADDR_HIGH/LOW reads (2020-03-2=
7 18:59:47 +0800)
>>
>> ----------------------------------------------------------------
>>
>> ----------------------------------------------------------------
> Hi; this fails to compile (all platforms):


My bad, forget to run full docker test before sending the pull request.


>
> /home/petmay01/qemu-for-merges/hw/net/allwinner-sun8i-emac.c:773:20:
> error: initialization from incompatible pointer type
> [-Werror=3Dincompatible-pointer-types]
>       .can_receive =3D allwinner_sun8i_emac_can_receive,
>                      ^
> /home/petmay01/qemu-for-merges/hw/net/allwinner-sun8i-emac.c:773:20:
> note: (near initialization for
> 'net_allwinner_sun8i_emac_info.can_receive')
>
>
> There's also this one, though not every compiler picked it up:
>
> /home/peter.maydell/qemu/hw/net/i82596.c: In function 'i82596_receive':
> /home/peter.maydell/qemu/hw/net/i82596.c:657:30: error: comparison of
> unsigned expression >=3D 0 is always true [-Werror=3Dtype-limits]
>                   assert(bufsz >=3D 0);
>                                ^
> /home/peter.maydell/qemu/hw/net/i82596.c:657:30: error: comparison of
> unsigned expression >=3D 0 is always true [-Werror=3Dtype-limits]
>                   assert(bufsz >=3D 0);
>                                ^
>
>
> For the first error, I think this needs squashing into
> "hw/net: Make NetCanReceive() return a boolean":
>
> diff --git a/hw/net/allwinner-sun8i-emac.c b/hw/net/allwinner-sun8i-emac.=
c
> index fc67a1be70..28637ff4c1 100644
> --- a/hw/net/allwinner-sun8i-emac.c
> +++ b/hw/net/allwinner-sun8i-emac.c
> @@ -395,7 +395,7 @@ static void
> allwinner_sun8i_emac_flush_desc(FrameDescriptor *desc,
>       cpu_physical_memory_write(phys_addr, desc, sizeof(*desc));
>   }
>
> -static int allwinner_sun8i_emac_can_receive(NetClientState *nc)
> +static bool allwinner_sun8i_emac_can_receive(NetClientState *nc)
>   {
>       AwSun8iEmacState *s =3D qemu_get_nic_opaque(nc);
>       FrameDescriptor desc;
>
>
> Squashing this into my
> "hw/net/i82596.c: Avoid reading off end of buffer in i82596_receive()"
> commit fixes the second error.
>
> diff --git a/hw/net/i82596.c b/hw/net/i82596.c
> index a9bdbac339..055c3a1470 100644
> --- a/hw/net/i82596.c
> +++ b/hw/net/i82596.c
> @@ -653,8 +653,8 @@ ssize_t i82596_receive(NetClientState *nc, const
> uint8_t *buf, size_t sz)
>
>               if (bufcount > 0) {
>                   /* Still some of the actual data buffer to transfer */
> +                assert(bufsz >=3D bufcount);
>                   bufsz -=3D bufcount;
> -                assert(bufsz >=3D 0);
>                   address_space_write(&address_space_memory, rba,
>                                       MEMTXATTRS_UNSPECIFIED, buf, bufcou=
nt);
>                   rba +=3D bufcount;
>
> thanks
> -- PMM
>

Right, will fix them.

Thanks



