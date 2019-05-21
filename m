Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 456BAC04AAC
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 03:23:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CF48213F2
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 03:23:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CF48213F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45723 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSvN1-0004Db-Dx
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 23:23:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1hSvMB-0003qh-5t
	for qemu-devel@nongnu.org; Mon, 20 May 2019 23:22:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1hSvMA-0007Qi-9k
	for qemu-devel@nongnu.org; Mon, 20 May 2019 23:22:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39530)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>)
	id 1hSvM8-0007P8-7y; Mon, 20 May 2019 23:22:24 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 60281F74A0;
	Tue, 21 May 2019 03:22:22 +0000 (UTC)
Received: from [10.72.12.36] (ovpn-12-36.pek2.redhat.com [10.72.12.36])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 907A71001E66;
	Tue, 21 May 2019 03:22:19 +0000 (UTC)
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
References: <20190520181111.20407-1-clg@kaod.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <57879890-1587-f66f-7947-6fade53f542f@redhat.com>
Date: Tue, 21 May 2019 11:22:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190520181111.20407-1-clg@kaod.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.38]);
	Tue, 21 May 2019 03:22:22 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] ftgmac100: do not link to netdev
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
	qemu-devel@nongnu.org, Wim Vervoorn <wvervoorn@eltan.com>,
	qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2019/5/21 =E4=B8=8A=E5=8D=882:11, C=C3=A9dric Le Goater wrote:
> qdev_set_nic_properties() is already used in the Aspeed SoC level to
> bind the ftgmac100 device to the netdev.
>
> This is fixing support for multiple net devices.
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>   hw/net/ftgmac100.c | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/hw/net/ftgmac100.c b/hw/net/ftgmac100.c
> index 790430346b51..d9986c6baa92 100644
> --- a/hw/net/ftgmac100.c
> +++ b/hw/net/ftgmac100.c
> @@ -1016,8 +1016,6 @@ static void ftgmac100_realize(DeviceState *dev, E=
rror **errp)
>       sysbus_init_irq(sbd, &s->irq);
>       qemu_macaddr_default_if_unset(&s->conf.macaddr);
>  =20
> -    s->conf.peers.ncs[0] =3D nd_table[0].netdev;
> -
>       s->nic =3D qemu_new_nic(&net_ftgmac100_info, &s->conf,
>                             object_get_typename(OBJECT(dev)), DEVICE(de=
v)->id,
>                             s);


Applied.

Thanks


