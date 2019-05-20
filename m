Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B5C0C04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 21:13:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46799216B7
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 21:13:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46799216B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41984 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSpah-0003ac-97
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 17:13:03 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hSpZn-0003B5-Kx
	for qemu-devel@nongnu.org; Mon, 20 May 2019 17:12:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hSpZm-0005Zr-Ny
	for qemu-devel@nongnu.org; Mon, 20 May 2019 17:12:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36378)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>)
	id 1hSpZk-0005YR-8w; Mon, 20 May 2019 17:12:04 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 80BD0308FC4E;
	Mon, 20 May 2019 21:11:56 +0000 (UTC)
Received: from localhost (ovpn-116-14.gru2.redhat.com [10.97.116.14])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6F69D19C71;
	Mon, 20 May 2019 21:11:53 +0000 (UTC)
Date: Mon, 20 May 2019 18:11:51 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>
Message-ID: <20190520211151.GF10764@habkost.net>
References: <20190520152921.15959-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520152921.15959-1-lvivier@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.43]);
	Mon, 20 May 2019 21:12:03 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] numa: improve cpu hotplug error message
 with a wrong node-id
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
	qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
	Igor Mammedov <imammedo@redhat.com>,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 20, 2019 at 05:29:21PM +0200, Laurent Vivier wrote:
> On pseries, core-ids are strongly binded to a node-id by the command
> line option. If a user tries to add a CPU to the wrong node, he has
> an error but it is not really helpful:
> 
>   qemu-system-ppc64 ... -smp 1,maxcpus=64,cores=1,threads=1,sockets=1 \
>                         -numa node,nodeid=0 -numa node,nodeid=1 ...
> 
>   (qemu) device_add power9_v2.0-spapr-cpu-core,core-id=30,node-id=1
>   Error: node-id=1 must match numa node specified with -numa option
> 
> This patch improves this error message by giving to the user the good
> node-id to use with the core-id he's providing:
> 
>   Error: core-id 30 can only be plugged into node-id 0

Why just core-id?  What about the other fields at slot->props?

> 
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>  numa.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/numa.c b/numa.c
> index 3875e1efda3a..c419c5b5b8ee 100644
> --- a/numa.c
> +++ b/numa.c
> @@ -470,8 +470,9 @@ void numa_cpu_pre_plug(const CPUArchId *slot, DeviceState *dev, Error **errp)
>                                      "node-id", errp);
>          }
>      } else if (node_id != slot->props.node_id) {
> -        error_setg(errp, "node-id=%d must match numa node specified "
> -                   "with -numa option", node_id);
> +        error_setg(errp,
> +                   "core-id %"PRId64" can only be plugged into node-id %"PRId64,
> +                   slot->props.core_id, slot->props.node_id);
>      }
>  }
>  
> -- 
> 2.20.1
> 

-- 
Eduardo

