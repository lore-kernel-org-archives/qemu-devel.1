Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B56AC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 08:01:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26D912067B
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 08:01:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fdFDW78Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26D912067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkk3V-0005ht-Cz
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 04:01:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55232)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jkk2g-0005IK-RX
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 04:00:30 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:53563
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jkk2a-0001vT-SL
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 04:00:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592208023;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jbfvwewZXppjxFQNQsUlf5US9s3rgy3hUr/O15QgB1Y=;
 b=fdFDW78QjPy2M6SQNfXIJClSdeOUqHOc6eS6Qrj++zk7JfWnQVhiO2sufuPKGnfge8P6aZ
 dSC53bCgSSTQjOgaD+/ipJXsm7kXTNriMkgPGKAZEhIUYl60goqYl/PPU9aACNmnKdvN05
 BmxAQwXacm43TrS/yGxZUjMcGf1dp08=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-VS7WmcKEMFi0J7iTc-VKqA-1; Mon, 15 Jun 2020 04:00:19 -0400
X-MC-Unique: VS7WmcKEMFi0J7iTc-VKqA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 000FE108BD16;
 Mon, 15 Jun 2020 08:00:17 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3DBCD90345;
 Mon, 15 Jun 2020 08:00:03 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9CD241138648; Mon, 15 Jun 2020 10:00:01 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Michal Privoznik <mprivozn@redhat.com>
Subject: Re: [PATCH v2 1/2] qemu-options.hx: Mark all hmat-cache attributes
 required
References: <cover.1591794890.git.mprivozn@redhat.com>
 <b6d3bc2ac8b38a419c98fb5eb1454ffbcb4fa172.1591794890.git.mprivozn@redhat.com>
Date: Mon, 15 Jun 2020 10:00:01 +0200
In-Reply-To: <b6d3bc2ac8b38a419c98fb5eb1454ffbcb4fa172.1591794890.git.mprivozn@redhat.com>
 (Michal Privoznik's message of "Wed, 10 Jun 2020 15:17:34 +0200")
Message-ID: <87a714bvy6.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/15 01:12:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Igor Mammedov <imammedo@redhat.com>, Liu Jingqi <jingqi.liu@intel.com>,
 Tao Xu <tao3.xu@intel.com>, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc: the people involved in commit c412a48d4d "numa: Extend CLI to
provide memory side cache information".

Michal Privoznik <mprivozn@redhat.com> writes:

> The documentation to `-numa hmat-cache` says that @node-id, @size
> and @level are the only required attributes. The rest
> (@associativity, @policy and @line) is optional. Well, not quite
> - if I try to start QEMU with only the three required attributes
> defined the QAPI code is complaining about associativity missing.

Only because @associativity visited first.

> According to QAPI all attributes are required. Make the docs
> reflect that.

Correct.

> Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
> ---
>  qemu-options.hx | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 93bde2bbc8..b1a399079a 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -188,7 +188,7 @@ DEF("numa", HAS_ARG, QEMU_OPTION_numa,
>      "-numa dist,src=source,dst=destination,val=distance\n"
>      "-numa cpu,node-id=node[,socket-id=x][,core-id=y][,thread-id=z]\n"
>      "-numa hmat-lb,initiator=node,target=node,hierarchy=memory|first-level|second-level|third-level,data-type=access-latency|read-latency|write-latency[,latency=lat][,bandwidth=bw]\n"
> -    "-numa hmat-cache,node-id=node,size=size,level=level[,associativity=none|direct|complex][,policy=none|write-back|write-through][,line=size]\n",
> +    "-numa hmat-cache,node-id=node,size=size,level=level,associativity=none|direct|complex,policy=none|write-back|write-through,line=size\n",
>      QEMU_ARCH_ALL)
>  SRST
>  ``-numa node[,mem=size][,cpus=firstcpu[-lastcpu]][,nodeid=node][,initiator=initiator]``
> @@ -201,7 +201,7 @@ SRST
>    \ 
>  ``-numa hmat-lb,initiator=node,target=node,hierarchy=hierarchy,data-type=tpye[,latency=lat][,bandwidth=bw]``
>    \ 
> -``-numa hmat-cache,node-id=node,size=size,level=level[,associativity=str][,policy=str][,line=size]``
> +``-numa hmat-cache,node-id=node,size=size,level=level,associativity=str,policy=str,line=size``
>      Define a NUMA node and assign RAM and VCPUs to it. Set the NUMA
>      distance from a source node to a destination node. Set the ACPI
>      Heterogeneous Memory Attributes for the given nodes.

Assuming non-optional is what we want:
Reviewed-by: Markus Armbruster <armbru@redhat.com>


