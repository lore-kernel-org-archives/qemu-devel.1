Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D468AC76186
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 03:38:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A65D822387
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 03:38:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A65D822387
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpldR-0004j2-Ni
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 23:38:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41896)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jasowang@redhat.com>) id 1hpldH-0004KI-G0
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 23:38:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1hpldG-0007sk-IB
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 23:38:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45516)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1hpldG-0007s1-Cy
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 23:38:30 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3DCF459449;
 Tue, 23 Jul 2019 03:38:29 +0000 (UTC)
Received: from [10.72.12.57] (ovpn-12-57.pek2.redhat.com [10.72.12.57])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9D21D5D9C5;
 Tue, 23 Jul 2019 03:38:21 +0000 (UTC)
To: "Oleinik, Alexander" <alxndr@bu.edu>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20190719185158.20316-1-alxndr@bu.edu>
 <20190719185158.20316-2-alxndr@bu.edu>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <6342b3c5-0cb2-74ba-89f0-6d28ef859c70@redhat.com>
Date: Tue, 23 Jul 2019 11:38:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190719185158.20316-2-alxndr@bu.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Tue, 23 Jul 2019 03:38:29 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 1/2] net: assert that tx packets have
 nonzero size
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "bsd@redhat.com" <bsd@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2019/7/20 =E4=B8=8A=E5=8D=882:52, Oleinik, Alexander wrote:
> Virtual devices should not try to send zero-sized packets. The caller
> should check the size prior to calling qemu_sendv_packet_async.
>
> Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
> ---
>   net/net.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/net/net.c b/net/net.c
> index 7d4098254f..fad20bc611 100644
> --- a/net/net.c
> +++ b/net/net.c
> @@ -741,6 +741,9 @@ ssize_t qemu_sendv_packet_async(NetClientState *sen=
der,
>       size_t size =3D iov_size(iov, iovcnt);
>       int ret;
>  =20
> +    /* 0-sized packets are unsupported. Check size in the caller */
> +    assert(size);


Can this be triggered through a buggy device by guest? If yes, we need=20
avoid using assert() here.

Thanks


> +
>       if (size > NET_BUFSIZE) {
>           return size;
>       }

