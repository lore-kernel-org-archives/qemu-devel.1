Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06DC5C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 05:00:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C91AB20882
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 05:00:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C91AB20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36935 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOxeL-0002E3-5H
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 01:00:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hOxdP-0001po-Af
	for qemu-devel@nongnu.org; Fri, 10 May 2019 00:59:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hOxdO-0000QR-Ee
	for qemu-devel@nongnu.org; Fri, 10 May 2019 00:59:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57606)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hOxdO-0000P8-95
	for qemu-devel@nongnu.org; Fri, 10 May 2019 00:59:50 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 84B08307D840;
	Fri, 10 May 2019 04:59:47 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-74.ams2.redhat.com
	[10.36.117.74])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2C07E665E6;
	Fri, 10 May 2019 04:59:47 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id 4B3E3A1E1; Fri, 10 May 2019 06:59:46 +0200 (CEST)
Date: Fri, 10 May 2019 06:59:46 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Hou Qiming <hqm03ster@gmail.com>
Message-ID: <20190510045946.u3e7kds72cu3wj52@sirius.home.kraxel.org>
References: <CABSdmrnNW6f=P64PviPP8CTJ5SVfYS8_6kmAtpw9yPObTEkpxg@mail.gmail.com>
	<CABSdmrnocrqLKWncgy_Lak33__GRPYfs-RzSA14e=vh4cRn2ag@mail.gmail.com>
	<20190509064848.wjhchsfov7q6komj@sirius.home.kraxel.org>
	<CABSdmrmm+wJ=+Ccav=X5Gw_oueQvPRejCWVG2SQeCw=K4BM9EA@mail.gmail.com>
	<CABSdmr=fCjBCVvDPGd+B9yGXFsCak3Z+0rOXYmxRLHNZMxcxAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABSdmr=fCjBCVvDPGd+B9yGXFsCak3Z+0rOXYmxRLHNZMxcxAQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.48]);
	Fri, 10 May 2019 04:59:47 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 1/3] ramfb enhancement
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, May 09, 2019 at 03:57:24PM +0800, Hou Qiming wrote:
> Pulled back the `qemu_create_displaysurface_guestmem` function to create
> the display surface so that the guest memory gets properly unmaped.
> 
> Signed-off-by: HOU Qiming <hqm03ster@gmail.com>
> ---
>  hw/display/ramfb.c | 53 ++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 42 insertions(+), 11 deletions(-)
> 
> diff --git a/hw/display/ramfb.c b/hw/display/ramfb.c
> index 25c8ad7..c27fcc7 100644
> --- a/hw/display/ramfb.c
> +++ b/hw/display/ramfb.c
> @@ -29,13 +29,50 @@ struct QEMU_PACKED RAMFBCfg {
>  struct RAMFBState {
>      DisplaySurface *ds;
>      uint32_t width, height;
> +    hwaddr addr, length;

Why do you add these?  Seem not to be used anywhere in the patch ...

Also a more descriptive subject line would be good.

cheers,
  Gerd


