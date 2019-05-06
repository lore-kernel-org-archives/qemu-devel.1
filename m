Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9130FC04AAC
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 06:34:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 621B320830
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 06:34:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 621B320830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51220 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNXCZ-0002Ik-Py
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 02:34:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ndevos@redhat.com>) id 1hNXBb-0001wd-UP
	for qemu-devel@nongnu.org; Mon, 06 May 2019 02:33:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ndevos@redhat.com>) id 1hNXBb-0003A1-2M
	for qemu-devel@nongnu.org; Mon, 06 May 2019 02:33:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49408)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ndevos@redhat.com>)
	id 1hNXBY-00034C-GD; Mon, 06 May 2019 02:33:12 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8B44B308622C;
	Mon,  6 May 2019 06:33:10 +0000 (UTC)
Received: from localhost (ovpn-116-67.ams2.redhat.com [10.36.116.67])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id BB85398B0;
	Mon,  6 May 2019 06:33:09 +0000 (UTC)
Date: Mon, 6 May 2019 08:33:08 +0200
From: Niels de Vos <ndevos@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Message-ID: <20190506063308.GA5209@ndevos-x270>
References: <20190506061854.22207-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190506061854.22207-1-thuth@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.42]);
	Mon, 06 May 2019 06:33:10 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [QEMU PATCH] MAINTAINERS: Downgrade status of
 block sections without "M:" to "Odd Fixes"
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
Cc: kwolf@redhat.com, qemu-trivial@nongnu.org, integration@gluster.org,
	qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 06, 2019 at 08:18:54AM +0200, Thomas Huth wrote:
> Fixes might still get picked up via the qemu-block mailing list,
> so the status is not "Orphan" yet.
> Also add the gluster mailing list as suggested by Niels here:
> 
>  https://patchwork.kernel.org/patch/10613297/#22409943
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Thanks, this counts for the Gluster part:
Reviewed-by: Niels de Vos <ndevos@redhat.com>


> ---
>  MAINTAINERS | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 66ddbda9c9..899a4cd572 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2404,12 +2404,13 @@ F: block/ssh.c
>  
>  CURL
>  L: qemu-block@nongnu.org
> -S: Supported
> +S: Odd Fixes
>  F: block/curl.c
>  
>  GLUSTER
>  L: qemu-block@nongnu.org
> -S: Supported
> +L: integration@gluster.org
> +S: Odd Fixes
>  F: block/gluster.c
>  
>  Null Block Driver
> -- 
> 2.21.0
> 

