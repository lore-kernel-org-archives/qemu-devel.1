Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C18CDC3F2D1
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 02:44:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86CBC2073D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 02:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VWQU3FEk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86CBC2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9K1e-0003PB-OI
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 21:44:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48673)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1j9K0n-0002wL-LM
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 21:43:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1j9K0k-0005MJ-O5
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 21:43:52 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:45877
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1j9K0k-0005JN-J1
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 21:43:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583289829;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qXk8a2P3bdabfwuERI1M72BkDi12ztH/1Dmy2D68Zwg=;
 b=VWQU3FEkPPJhXPRYzC9/a4OJtguQk0RSvFW95/0T7yN89eBuNdN5F42yrW7LDFNbYHqWqU
 BPBd9s/2Ou3aMplqIp28IorLY5O+tMuHy45asHonuXfVqyC+PGPa1psWDEV9zRjukJxPis
 1KJQXoU+IT44EHjrFAP/HCoU7GMMxXo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-479-LH_NV7gaOZqDsWU7Oxd1Iw-1; Tue, 03 Mar 2020 21:43:45 -0500
X-MC-Unique: LH_NV7gaOZqDsWU7Oxd1Iw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1E8D5800D48;
 Wed,  4 Mar 2020 02:43:44 +0000 (UTC)
Received: from [10.72.12.59] (ovpn-12-59.pek2.redhat.com [10.72.12.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7692E60C05;
 Wed,  4 Mar 2020 02:43:42 +0000 (UTC)
Subject: Re: [PULL V2 01/23] dp8393x: Mask EOL bit from descriptor addresses
To: Finn Thain <fthain@telegraphics.com.au>
References: <1583230242-14597-1-git-send-email-jasowang@redhat.com>
 <1583230242-14597-2-git-send-email-jasowang@redhat.com>
 <alpine.LNX.2.22.394.2003040842130.9@nippy.intranet>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <aa8129f3-0fdf-93a1-0ce7-5e3ca49a12bb@redhat.com>
Date: Wed, 4 Mar 2020 10:43:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <alpine.LNX.2.22.394.2003040842130.9@nippy.intranet>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/3/4 =E4=B8=8A=E5=8D=886:44, Finn Thain wrote:
> Hi Jason,
>
> The patch in this pull request (since merged) differs from the patch that
> I sent. In particular, the change below is missing from commit 88f632fbb1
> ("dp8393x: Mask EOL bit from descriptor addresses") in mainline.
>
> --- a/hw/net/dp8393x.c
> +++ b/hw/net/dp8393x.c
> @@ -525,8 +525,8 @@ static void dp8393x_do_transmit_packets(dp8393xState =
*s)
>                                    * (4 + 3 * s->regs[SONIC_TFC]),
>                                  MEMTXATTRS_UNSPECIFIED, s->data,
>                                  size);
> -            s->regs[SONIC_CTDA] =3D dp8393x_get(s, width, 0) & ~0x1;
> -            if (dp8393x_get(s, width, 0) & SONIC_DESC_EOL) {
> +            s->regs[SONIC_CTDA] =3D dp8393x_get(s, width, 0);
> +            if (s->regs[SONIC_CTDA] & SONIC_DESC_EOL) {
>                   /* EOL detected */
>                   break;
>               }
>
> Please compare with "[PATCH v4 01/14] dp8393x: Mask EOL bit from
> descriptor addresses" in the mailing list archives:
> https://lore.kernel.org/qemu-devel/d6e8d06ad4d02f4a30c4caa6001967f806f21a=
1a.1580290069.git.fthain@telegraphics.com.au/
>
> It appears that this portion of my patch went missing when merge conflict=
s
> were resolved. The conflicts were apparently caused by commit 19f7034773
> ("Avoid address_space_rw() with a constant is_write argument").
>
> Regards,
> Finn


Exactly.

Please send a patch to fix this.

Thanks


