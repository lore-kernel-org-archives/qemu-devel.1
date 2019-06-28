Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C0A1C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 15:54:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6EEF20828
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 15:54:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6EEF20828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgtCY-0002WJ-My
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 11:54:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42714)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jdurgin@redhat.com>) id 1hgryv-0000ae-9F
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 10:36:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jdurgin@redhat.com>) id 1hgryt-0003ci-67
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 10:36:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48754)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jdurgin@redhat.com>)
 id 1hgryp-0003Ah-2p; Fri, 28 Jun 2019 10:35:59 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E7A0687642;
 Fri, 28 Jun 2019 14:35:24 +0000 (UTC)
Received: from [10.3.116.146] (ovpn-116-146.phx2.redhat.com [10.3.116.146])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 863BA60922;
 Fri, 28 Jun 2019 14:35:22 +0000 (UTC)
To: jdillama@redhat.com, kwolf@redhat.com, mreitz@redhat.com,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
References: <20190628135508.8013-1-dillaman@redhat.com>
From: Josh Durgin <jdurgin@redhat.com>
Message-ID: <81ed4efb-856f-a65d-6ab7-a45e65dbd8bd@redhat.com>
Date: Fri, 28 Jun 2019 07:35:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190628135508.8013-1-dillaman@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Fri, 28 Jun 2019 14:35:24 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Mailman-Approved-At: Fri, 28 Jun 2019 11:48:45 -0400
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: update RBD block maintainer
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
Cc: Jason Dillaman <dillaman@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/28/19 6:55 AM, jdillama@redhat.com wrote:
> From: Jason Dillaman <dillaman@redhat.com>
> 
> Remove Josh as per his request since he is no longer the upstream RBD
> tech lead. Add myself as the maintainer since I am the current RBD tech
> lead.
> 
> Signed-off-by: Jason Dillaman <dillaman@redhat.com>
> ---
>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cad58b9487..47694cd02f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2367,7 +2367,7 @@ S: Supported
>   F: block/vmdk.c
>   
>   RBD
> -M: Josh Durgin <jdurgin@redhat.com>
> +M: Jason Dillaman <dillaman@redhat.com>
>   L: qemu-block@nongnu.org
>   S: Supported
>   F: block/rbd.c
> 

Reviewed-by: Josh Durgin <jdurgin@redhat.com>

