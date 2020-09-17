Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A84CC433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 08:30:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B00522083B
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 08:30:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fX5GpzN3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B00522083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIpIx-0005fK-I0
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 04:30:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56568)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1kIp2C-0008NE-Ps
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 04:12:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55835
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1kIp2A-00088s-UD
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 04:12:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600330370;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6tMBenZwZgz1qalsrYhPuXgGamXvglozQwBCFf1bGPY=;
 b=fX5GpzN37/kUSkUZYy+g22q+Q5fgmMXRrRJxmXNukSNgs7blXxEbi3d2egjirZ6hL9Zile
 qqK6SElANXp7fCaIcz2yaQPYKZoQVQUSC+OuVnqCz3KlEEjGhgU21yZBAJEqxnzbMlJsmy
 KeVoKPk01lMNwwkCnSPR1z7aeZU//cI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-252-cOSGnFIfOiSVC2nNvBg0eg-1; Thu, 17 Sep 2020 04:12:46 -0400
X-MC-Unique: cOSGnFIfOiSVC2nNvBg0eg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 16DBD10074B1;
 Thu, 17 Sep 2020 08:12:45 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.192.179])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B278778814;
 Thu, 17 Sep 2020 08:12:42 +0000 (UTC)
Date: Thu, 17 Sep 2020 10:12:39 +0200
From: Andrew Jones <drjones@redhat.com>
To: Ying Fang <fangying1@huawei.com>
Subject: Re: [RFC PATCH 04/12] device_tree: add qemu_fdt_add_path
Message-ID: <20200917081239.bdfhkofodqvhg3i6@kamzik.brq.redhat.com>
References: <20200917032033.2020-1-fangying1@huawei.com>
 <20200917032033.2020-5-fangying1@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20200917032033.2020-5-fangying1@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=drjones@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=drjones@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 02:30:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: peter.maydell@linaro.org, zhang.zhanghailiang@huawei.com,
 Peter Crosthwaite <crosthwaite.peter@gmail.com>,
 Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org, alex.chen@huawei.com,
 shannon.zhaosl@gmail.com, qemu-arm@nongnu.org, alistair.francis@wdc.com,
 imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 17, 2020 at 11:20:25AM +0800, Ying Fang wrote:
> From: Andrew Jones <drjones@redhat.com>
> 
> qemu_fdt_add_path works like qemu_fdt_add_subnode, except it
> also recursively adds any missing parent nodes.
> 
> Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>
> Cc: Alexander Graf <agraf@suse.de>
> Signed-off-by: Andrew Jones <drjones@redhat.com>
> ---
>  device_tree.c                | 24 ++++++++++++++++++++++++
>  include/sysemu/device_tree.h |  1 +
>  2 files changed, 25 insertions(+)
> 
> diff --git a/device_tree.c b/device_tree.c
> index b335dae707..1854be3a02 100644
> --- a/device_tree.c
> +++ b/device_tree.c
> @@ -524,6 +524,30 @@ int qemu_fdt_add_subnode(void *fdt, const char *name)
>      return retval;
>  }
>  
> +int qemu_fdt_add_path(void *fdt, const char *path)
> +{
> +    char *parent;
> +    int offset;
> +
> +    offset = fdt_path_offset(fdt, path);
> +    if (offset < 0 && offset != -FDT_ERR_NOTFOUND) {
> +        error_report("%s Couldn't find node %s: %s", __func__, path,
> +                     fdt_strerror(offset));
> +        exit(1);
> +    }
> +
> +    if (offset != -FDT_ERR_NOTFOUND) {
> +        return offset;
> +    }
> +
> +    parent = g_strdup(path);
> +    strrchr(parent, '/')[0] = '\0';
> +    qemu_fdt_add_path(fdt, parent);
> +    g_free(parent);
> +
> +    return qemu_fdt_add_subnode(fdt, path);
> +}

Igor didn't like the recursion when I posted this before so I changed
it when doing the refresh[*] that I gave to Salil Mehta. Salil also
works for Huawei, are you guys not working together?

[*] https://github.com/rhdrjones/qemu/commits/virt-cpu-topology-refresh

Thanks,
drew

> +
>  void qemu_fdt_dumpdtb(void *fdt, int size)
>  {
>      const char *dumpdtb = qemu_opt_get(qemu_get_machine_opts(), "dumpdtb");
> diff --git a/include/sysemu/device_tree.h b/include/sysemu/device_tree.h
> index 982c89345f..15fb98af98 100644
> --- a/include/sysemu/device_tree.h
> +++ b/include/sysemu/device_tree.h
> @@ -104,6 +104,7 @@ uint32_t qemu_fdt_get_phandle(void *fdt, const char *path);
>  uint32_t qemu_fdt_alloc_phandle(void *fdt);
>  int qemu_fdt_nop_node(void *fdt, const char *node_path);
>  int qemu_fdt_add_subnode(void *fdt, const char *name);
> +int qemu_fdt_add_path(void *fdt, const char *path);
>  
>  #define qemu_fdt_setprop_cells(fdt, node_path, property, ...)                 \
>      do {                                                                      \
> -- 
> 2.23.0
> 
> 


