Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5460C072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 14:12:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE1A2206A3
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 14:12:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE1A2206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55259 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUAwI-00024T-0P
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 10:12:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hUAuS-000072-Lv
	for qemu-devel@nongnu.org; Fri, 24 May 2019 10:11:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hUAuR-0008V6-Jh
	for qemu-devel@nongnu.org; Fri, 24 May 2019 10:11:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33066)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>)
	id 1hUAuO-0008Qb-Lg; Fri, 24 May 2019 10:10:56 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D7A3330C0DC5;
	Fri, 24 May 2019 14:10:50 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3FDE12CFD6;
	Fri, 24 May 2019 14:10:49 +0000 (UTC)
Date: Fri, 24 May 2019 16:10:45 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>
Message-ID: <20190524161045.314fa2de@redhat.com>
In-Reply-To: <20190524103521.13847-1-lvivier@redhat.com>
References: <20190524103521.13847-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.45]);
	Fri, 24 May 2019 14:10:50 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3] numa: improve cpu hotplug error message
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

On Fri, 24 May 2019 12:35:21 +0200
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
> topology information (node-id, socket-id and thread-id if they are
> available) to use with the core-id he's providing:
> 
>   Error: node-id=1 must match numa node specified with -numa option 'node-id 0'
> 
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
> 
> Notes:
>     v3: only add the topology to the existing message
>         As suggested by Igor replace
>           Error: core-id 30 can only be plugged into node-id 0
>         by
>           Error: node-id=1 must match numa node specified with -numa option 'node-id 0'
>     
>     v2: display full topology in the error message
> 
>  numa.c | 25 ++++++++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/numa.c b/numa.c
> index 3875e1efda3a..7882ec294be4 100644
> --- a/numa.c
> +++ b/numa.c
> @@ -458,6 +458,27 @@ void qmp_set_numa_node(NumaOptions *cmd, Error **errp)
>      set_numa_options(MACHINE(qdev_get_machine()), cmd, errp);
>  }
>  
> +static char *cpu_topology_to_string(const CPUArchId *cpu)
> +{
> +    GString *s = g_string_new(NULL);
> +    if (cpu->props.has_socket_id) {
> +        g_string_append_printf(s, "socket-id %"PRId64, cpu->props.socket_id);
> +    }
> +    if (cpu->props.has_node_id) {
> +        if (s->len) {
> +            g_string_append_printf(s, ", ");
> +        }
> +        g_string_append_printf(s, "node-id %"PRId64, cpu->props.node_id);
> +    }
> +    if (cpu->props.has_thread_id) {
> +        if (s->len) {
> +            g_string_append_printf(s, ", ");
> +        }
> +        g_string_append_printf(s, "thread-id %"PRId64, cpu->props.thread_id);
> +    }
> +    return g_string_free(s, false);
> +}

turns out we already have such helper: cpu_slot_to_string()

> +
>  void numa_cpu_pre_plug(const CPUArchId *slot, DeviceState *dev, Error **errp)
>  {
>      int node_id = object_property_get_int(OBJECT(dev), "node-id", &error_abort);
> @@ -470,8 +491,10 @@ void numa_cpu_pre_plug(const CPUArchId *slot, DeviceState *dev, Error **errp)
>                                      "node-id", errp);
>          }
>      } else if (node_id != slot->props.node_id) {
> +        char *topology = cpu_topology_to_string(slot);
>          error_setg(errp, "node-id=%d must match numa node specified "
> -                   "with -numa option", node_id);
> +                   "with -numa option '%s'", node_id, topology);
> +        g_free(topology);
>      }
>  }
>  


