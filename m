Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 038F4C388F2
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 05:13:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42F192145D
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 05:13:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LY4bJ6+4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42F192145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVSuZ-00049z-8B
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 01:13:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60968)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kVStD-0003JG-1L
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 01:11:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25839)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kVStA-0003dy-FE
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 01:11:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603343506;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lkmpEGBCCF2I9wjsvmJU/TYv78/PfjnXwN6GvRcy1Ko=;
 b=LY4bJ6+4Gg93f8NlYOewXhALcBM4NuDGPU8NIRanqb2LR9TlHkPliyz6GmnRVRgfB/cCk6
 1xwusVXGJPywEfEZQmbhrTwAzIK3ulj4mw7ywkLOBWFHLwrwypGZDUM+V42T0S+vkKHdwO
 5TNqudtkuQKeWujtIz0RgGanRWpxFQw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-154-MO47S_HbMi6q_dhmM7acGA-1; Thu, 22 Oct 2020 01:11:44 -0400
X-MC-Unique: MO47S_HbMi6q_dhmM7acGA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B5E42804B60
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2020 05:11:43 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-77.ams2.redhat.com [10.36.112.77])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 89F8E60C15;
 Thu, 22 Oct 2020 05:11:41 +0000 (UTC)
Subject: Re: [PATCH 03/22] machine: move UP defaults to class_base_init
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20201021205716.2359430-1-pbonzini@redhat.com>
 <20201021205716.2359430-4-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <638dae62-9a48-8098-d41e-bb0ff6eeb4c3@redhat.com>
Date: Thu, 22 Oct 2020 07:11:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201021205716.2359430-4-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/21 23:30:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: berrange@redhat.com, jsnow@redhat.com, ehabkost@redhat.com,
 imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21/10/2020 22.56, Paolo Bonzini wrote:
> Clean up vl.c, default min/max/default_cpus to uniprocessor
> directly in the QOM class initialization code.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/core/machine.c | 6 +++++-
>  softmmu/vl.c      | 5 -----
>  2 files changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 80a918895a..d3a8450b1f 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -854,8 +854,12 @@ static void machine_class_init(ObjectClass *oc, void *data)
>  
>  static void machine_class_base_init(ObjectClass *oc, void *data)
>  {
> +    MachineClass *mc = MACHINE_CLASS(oc);
> +    mc->max_cpus = mc->max_cpus ?: 1;
> +    mc->min_cpus = mc->min_cpus ?: 1;
> +    mc->default_cpus = mc->default_cpus ?: 1;
> +
>      if (!object_class_is_abstract(oc)) {
> -        MachineClass *mc = MACHINE_CLASS(oc);
>          const char *cname = object_class_get_name(oc);
>          assert(g_str_has_suffix(cname, TYPE_MACHINE_SUFFIX));
>          mc->name = g_strndup(cname,
> diff --git a/softmmu/vl.c b/softmmu/vl.c
> index 42314e6ff9..75bc686397 100644
> --- a/softmmu/vl.c
> +++ b/softmmu/vl.c
> @@ -3966,11 +3966,6 @@ void qemu_init(int argc, char **argv, char **envp)
>          exit(0);
>      }
>  
> -    /* machine_class: default to UP */
> -    machine_class->max_cpus = machine_class->max_cpus ?: 1;
> -    machine_class->min_cpus = machine_class->min_cpus ?: 1;
> -    machine_class->default_cpus = machine_class->default_cpus ?: 1;
> -
>      /* default to machine_class->default_cpus */
>      current_machine->smp.cpus = machine_class->default_cpus;
>      current_machine->smp.max_cpus = machine_class->default_cpus;
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>


