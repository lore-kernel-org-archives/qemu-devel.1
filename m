Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8224C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 13:18:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FBE62084C
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 13:18:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OD/9EKbQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FBE62084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdZT5-0006nr-LY
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 09:18:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55310)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jdZSW-0006HI-Va
 for qemu-devel@nongnu.org; Tue, 26 May 2020 09:17:32 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:21924
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jdZSW-0003FU-3u
 for qemu-devel@nongnu.org; Tue, 26 May 2020 09:17:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590499050;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H60CR2bumLUrZNbHAeSdtxU4wvH05jUxOQC8+WODwqE=;
 b=OD/9EKbQTq05bWHWZL2nZ4TGW80CXoEiGrHcxhlfmbEw8oKXEfbHZc2pPFcNmQYXHX40/6
 +ItzrjKX9gvJPhnpo8F/Jh+o5rfgxNqMEyeJ3nwM6mZlVYf4ZDsEFsdzuT6xw9+icx6RGZ
 h3S2IJpK6+GUdO6yBEZsTXvhAQSZOFs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-hpHn6f7sMeqAiTq33X5wQQ-1; Tue, 26 May 2020 09:17:29 -0400
X-MC-Unique: hpHn6f7sMeqAiTq33X5wQQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2F576461
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 13:17:28 +0000 (UTC)
Received: from localhost (unknown [10.40.208.12])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8F13319D61;
 Tue, 26 May 2020 13:17:26 +0000 (UTC)
Date: Tue, 26 May 2020 15:17:24 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Michal Privoznik <mprivozn@redhat.com>
Subject: Re: [PATCH v2 2/2] qmp: Expose MachineClass::default_ram_id
Message-ID: <20200526151724.37b6fe63@redhat.com>
In-Reply-To: <9384422f63fe594a54d801f9cb4539b1d2ce9b67.1590481402.git.mprivozn@redhat.com>
References: <cover.1590481402.git.mprivozn@redhat.com>
 <9384422f63fe594a54d801f9cb4539b1d2ce9b67.1590481402.git.mprivozn@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 01:14:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: armbru@redhat.com, qemu-devel@nongnu.org, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 26 May 2020 10:25:35 +0200
Michal Privoznik <mprivozn@redhat.com> wrote:

> If a management application (like Libvirt) want's to preserve
> migration ability and switch to '-machine memory-backend' it
> needs to set exactly the same RAM id as QEMU would. Since the id
> is machine type dependant, expose it under 'query-machines'
> result. Some machine types don't have the attribute set (riscv
> family for example), therefore the QMP attribute must be
> optional.
> 
> Signed-off-by: Michal Privoznik <mprivozn@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/core/machine-qmp-cmds.c | 4 ++++
>  qapi/machine.json          | 5 ++++-
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
> index 2c5da8413d..3e11a740c9 100644
> --- a/hw/core/machine-qmp-cmds.c
> +++ b/hw/core/machine-qmp-cmds.c
> @@ -238,6 +238,10 @@ MachineInfoList *qmp_query_machines(Error **errp)
>              info->default_cpu_type = g_strdup(mc->default_cpu_type);
>              info->has_default_cpu_type = true;
>          }
> +        if (mc->default_ram_id) {
> +            info->default_ram_id = g_strdup(mc->default_ram_id);
> +            info->has_default_ram_id = true;
> +        }
>  
>          entry = g_malloc0(sizeof(*entry));
>          entry->value = info;
> diff --git a/qapi/machine.json b/qapi/machine.json
> index 39caa1d914..76c1606390 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -355,13 +355,16 @@
>  # @default-cpu-type: default CPU model typename if none is requested via
>  #                    the -cpu argument. (since 4.2)
>  #
> +# @default-ram-id: the default ID of initial RAM memory backend (since 5.1)
> +#
>  # Since: 1.2.0
>  ##
>  { 'struct': 'MachineInfo',
>    'data': { 'name': 'str', '*alias': 'str',
>              '*is-default': 'bool', 'cpu-max': 'int',
>              'hotpluggable-cpus': 'bool',  'numa-mem-supported': 'bool',
> -            'deprecated': 'bool', '*default-cpu-type': 'str' } }
> +            'deprecated': 'bool', '*default-cpu-type': 'str',
> +            '*default-ram-id': 'str' } }
>  
>  ##
>  # @query-machines:


