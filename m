Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_HK_NAME_DR,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC0A5C04AAF
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 08:58:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6406204FD
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 08:58:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6406204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60388 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSe7q-00006H-I2
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 04:58:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51679)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hSe6z-000882-CI
	for qemu-devel@nongnu.org; Mon, 20 May 2019 04:57:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hSe6w-0000Oy-AM
	for qemu-devel@nongnu.org; Mon, 20 May 2019 04:57:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50406)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>)
	id 1hSe6w-0000Br-55; Mon, 20 May 2019 04:57:34 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 25889149A2;
	Mon, 20 May 2019 08:57:15 +0000 (UTC)
Received: from work-vm (ovpn-116-127.ams2.redhat.com [10.36.116.127])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 6F93D60CA4;
	Mon, 20 May 2019 08:57:07 +0000 (UTC)
Date: Mon, 20 May 2019 09:57:04 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>, lvivier@redhat.com
Message-ID: <20190520085704.GB2726@work-vm>
References: <20190520081805.15019-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520081805.15019-1-kraxel@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.38]);
	Mon, 20 May 2019 08:57:19 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] usb-tablet: fix serial compat property
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
Cc: qemu-stable@nongnu.org, qemu-devel@nongnu.org,
	Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Gerd Hoffmann (kraxel@redhat.com) wrote:
> s/kbd/tablet/, fixes cut+paste bug.
> 
> Cc: qemu-stable@nongnu.org
> Reported-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  hw/core/machine.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 5d046a43e3d2..eb34f53a85b0 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -36,7 +36,7 @@ GlobalProperty hw_compat_3_1[] = {
>      { "tpm-tis", "ppi", "false" },
>      { "usb-kbd", "serial", "42" },
>      { "usb-mouse", "serial", "42" },
> -    { "usb-kbd", "serial", "42" },
> +    { "usb-tablet", "serial", "42" },
>      { "virtio-blk-device", "discard", "false" },
>      { "virtio-blk-device", "write-zeroes", "false" },
>  };
> -- 
> 2.18.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

