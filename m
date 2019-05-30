Return-Path: <SRS0=r6E1=T6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54AAAC28CC0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 09:02:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 315A0254EA
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 09:02:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 315A0254EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49476 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWGxH-0002Zs-Ez
	for qemu-devel@archiver.kernel.org; Thu, 30 May 2019 05:02:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hWGvt-0001pD-Eo
	for qemu-devel@nongnu.org; Thu, 30 May 2019 05:01:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hWGvr-000511-Cm
	for qemu-devel@nongnu.org; Thu, 30 May 2019 05:01:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54384)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>)
	id 1hWGvh-0004uw-Qf; Thu, 30 May 2019 05:00:58 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9B3612E95B1;
	Thu, 30 May 2019 09:00:49 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A809E2B1CA;
	Thu, 30 May 2019 09:00:44 +0000 (UTC)
Date: Thu, 30 May 2019 11:00:43 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>
Message-ID: <20190530110043.047b2f1f@redhat.com>
In-Reply-To: <20190529160747.778-1-lvivier@redhat.com>
References: <20190529160747.778-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.29]);
	Thu, 30 May 2019 09:00:54 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4] numa: improve cpu hotplug error message
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
	qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 29 May 2019 18:07:47 +0200
Laurent Vivier <lvivier@redhat.com> wrote:

> On pseries, core-ids are strongly binded to a node-id by the command
> line option. If an user tries to add a CPU to the wrong node, he has
> an error but it is not really helpful:
> 
>   qemu-system-ppc64 ... -smp 1,maxcpus=64,cores=1,threads=1,sockets=1 \
>                         -numa node,nodeid=0 -numa node,nodeid=1 ...
> 
>   (qemu) device_add power9_v2.0-spapr-cpu-core,core-id=30,node-id=1
>   Error: node-id=1 must match numa node specified with -numa option
> 
> This patch improves this error message by giving to the user the good
> node-id to use with the core-id he's providing
> 
>   Error: invalid node-id, must be 0
> 
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
> 
> Notes:
>     v4: simplify the message
>     
>     v3: only add the topology to the existing message
>         As suggested by Igor replace
>           Error: core-id 30 can only be plugged into node-id 0
>         by
>           Error: node-id=1 must match numa node specified with -numa option 'node-id 0'
>     
>     v2: display full topology in the error message
> 
>  numa.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/numa.c b/numa.c
> index 3875e1efda3a..955ec0c830db 100644
> --- a/numa.c
> +++ b/numa.c
> @@ -470,8 +470,8 @@ void numa_cpu_pre_plug(const CPUArchId *slot, DeviceState *dev, Error **errp)
>                                      "node-id", errp);
>          }
>      } else if (node_id != slot->props.node_id) {
> -        error_setg(errp, "node-id=%d must match numa node specified "
> -                   "with -numa option", node_id);
> +        error_setg(errp, "invalid node-id, must be %"PRId64,
> +                   slot->props.node_id);
>      }
>  }
>  


