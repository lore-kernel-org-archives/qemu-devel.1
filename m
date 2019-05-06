Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9010C04A6B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 17:58:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B54DE20675
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 17:58:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B54DE20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60258 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNhsi-000507-21
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 13:58:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kheib@redhat.com>) id 1hNhaU-0006L3-GY
	for qemu-devel@nongnu.org; Mon, 06 May 2019 13:39:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kheib@redhat.com>) id 1hNhaS-0004Qj-Kf
	for qemu-devel@nongnu.org; Mon, 06 May 2019 13:39:38 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54809)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <kheib@redhat.com>) id 1hNhaQ-0004M7-6S
	for qemu-devel@nongnu.org; Mon, 06 May 2019 13:39:34 -0400
Received: by mail-wm1-f65.google.com with SMTP id b10so16911586wmj.4
	for <qemu-devel@nongnu.org>; Mon, 06 May 2019 10:39:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=3SXgy+7eZnHUrtsAa3ARviZuLvUWpGcvdPb7FvTH4sk=;
	b=AzOp5gTO3Pzf9LpJv10YM/QSLdRddjX531gGrZZ5Dmfjgfmong8Eq8l8K2I62NDV2Y
	qFt/KHUrCwUXAaY6FSZ+ELQW6jXg+4Tqd9p9Eklal56+pGuPT7SunlLmK4FK3831K0qs
	3sdh/kUVvJYztfPAnyYCsiMz3rdHm96Yv3sCrhLi46iN/iGsgZjzz5fRpX7gubdL/daK
	p0NtdAlMDHtSgJ/i+YWHJc9EpsJ1v56tVhdC1nQ3keM81aJjRu4xOYMydpRIkGBrRcJr
	VoGb0FOZhhG0T5IF1m/56ixpEp0c2jCFav+jhSo+EHF+nnZWx6C4xqYcRRwYOBA6kfH9
	D60Q==
X-Gm-Message-State: APjAAAUyAYYnCqyx08MnzRo1lIX4UtQ4PAPfA8PC4B8oHAUbY4rP6Qdn
	K2kvnRQaDl9sH5a1wlAAfLjuzg==
X-Google-Smtp-Source: APXvYqyv0o7wvQzV/Hq0nl+DbEPAy3dPyQLq197U45Jel0WJQ0FBshitfqCCouRZoM73uwgcreHphw==
X-Received: by 2002:a1c:f909:: with SMTP id x9mr17955282wmh.18.1557164368577; 
	Mon, 06 May 2019 10:39:28 -0700 (PDT)
Received: from [192.168.1.105] (bzq-109-67-4-126.red.bezeqint.net.
	[109.67.4.126]) by smtp.gmail.com with ESMTPSA id
	k206sm22167049wmk.16.2019.05.06.10.39.27
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Mon, 06 May 2019 10:39:27 -0700 (PDT)
To: Yuval Shaia <yuval.shaia@oracle.com>, marcel.apfelbaum@gmail.com,
	qemu-devel@nongnu.org, eblake@redhat.com
References: <20190506163704.1378-1-yuval.shaia@oracle.com>
From: Kamal Heib <kheib@redhat.com>
Message-ID: <04e28f0f-fbbb-bb86-7471-9da639f743c9@redhat.com>
Date: Mon, 6 May 2019 20:39:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190506163704.1378-1-yuval.shaia@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PATCH v1] hw/rdma: Add support for GID state
 changes for non-qmp frameworks
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 5/6/19 7:37 PM, Yuval Shaia wrote:
> Any GID change in guest must be propagated to the host. This is already
> done by firing QMP event to management system such as libvirt which in
> turn will update the host with the relevant change.
> 
> When qemu is executed on non-qmp framework (ex from command-line) we
> need to update the host instead.
> Fix it by adding support to update the RoCE device's Ethernet function
> IP list from qemu via netlink.
> 
> Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
> ---
> v0 -> v1:
> 	* Fix spelling mistakes pointed by Eric Blake
> ---
>  configure              |  6 ++++
>  hw/rdma/rdma_backend.c | 74 +++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 79 insertions(+), 1 deletion(-)
> 
> diff --git a/configure b/configure
> index 5b183c2e39..1f707b1a62 100755
> --- a/configure
> +++ b/configure
> @@ -3132,6 +3132,8 @@ fi
>  
>  cat > $TMPC <<EOF &&
>  #include <sys/mman.h>
> +#include <libmnl/libmnl.h>
> +#include <linux/rtnetlink.h>
>  
>  int
>  main(void)
> @@ -3144,10 +3146,13 @@ main(void)
>  }
>  EOF
>  
> +pvrdma_libs="-lmnl"
> +
>  if test "$rdma" = "yes" ; then
>      case "$pvrdma" in
>      "")
>          if compile_prog "" ""; then
> +            libs_softmmu="$libs_softmmu $pvrdma_libs"
>              pvrdma="yes"
>          else
>              pvrdma="no"
> @@ -3156,6 +3161,7 @@ if test "$rdma" = "yes" ; then
>      "yes")
>          if ! compile_prog "" ""; then
>              error_exit "PVRDMA is not supported since mremap is not implemented"
> +                        " or libmnl-devel is not installed"
>          fi
>          pvrdma="yes"
>          ;;
> diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c
> index 05f6b03221..f75e916195 100644
> --- a/hw/rdma/rdma_backend.c
> +++ b/hw/rdma/rdma_backend.c
> @@ -16,6 +16,11 @@
>  #include "qemu/osdep.h"
>  #include "qapi/qapi-events-rdma.h"
>  
> +#include "linux/if_addr.h"
> +#include "libmnl/libmnl.h"
> +#include "linux/rtnetlink.h"
> +#include "net/if.h"
> +
>  #include <infiniband/verbs.h>
>  
>  #include "contrib/rdmacm-mux/rdmacm-mux.h"
> @@ -47,6 +52,61 @@ static void dummy_comp_handler(void *ctx, struct ibv_wc *wc)
>      rdma_error_report("No completion handler is registered");
>  }
>  
> +static int netlink_route_update(const char *ifname, union ibv_gid *gid,
> +                                __u16 type)
> +{
> +    char buf[MNL_SOCKET_BUFFER_SIZE];
> +    struct nlmsghdr *nlh;
> +    struct ifaddrmsg *ifm;
> +    struct mnl_socket *nl;
> +    int ret;
> +    uint32_t ipv4;
> +
> +    nl = mnl_socket_open(NETLINK_ROUTE);
> +    if (!nl) {
> +        rdma_error_report("Fail to connect to netlink\n");
> +        return -EIO;
> +    }
> +
> +    ret = mnl_socket_bind(nl, 0, MNL_SOCKET_AUTOPID);
> +    if (ret < 0) {
> +        rdma_error_report("Fail to bind to netlink\n");
> +        goto out;
> +    }
> +
> +    nlh = mnl_nlmsg_put_header(buf);
> +    nlh->nlmsg_type = type;
> +    nlh->nlmsg_flags = NLM_F_REQUEST | NLM_F_CREATE | NLM_F_EXCL;
> +    nlh->nlmsg_seq = 1;
> +
> +    ifm = mnl_nlmsg_put_extra_header(nlh, sizeof(*ifm));
> +    ifm->ifa_index = if_nametoindex(ifname);
> +    if (gid->global.subnet_prefix) {
> +        ifm->ifa_family = AF_INET6;
> +        ifm->ifa_prefixlen = 64;
> +        ifm->ifa_flags = IFA_F_PERMANENT;
> +        ifm->ifa_scope = RT_SCOPE_UNIVERSE;
> +        mnl_attr_put(nlh, IFA_ADDRESS, sizeof(*gid), gid);
> +    } else {
> +        ifm->ifa_family = AF_INET;
> +        ifm->ifa_prefixlen = 24;
> +        memcpy(&ipv4, (char *)&gid->global.interface_id + 4, sizeof(ipv4));
> +        mnl_attr_put(nlh, IFA_LOCAL, 4, &ipv4);
> +    }
> +
> +    ret = mnl_socket_sendto(nl, nlh, nlh->nlmsg_len);
> +    if (ret < 0) {
> +        rdma_error_report("Fail to send msg to to netlink\n");
> +        goto out;
> +    }
> +
> +    ret = 0;
> +
> +out:
> +    mnl_socket_close(nl);
> +    return ret;
> +}
> +
>  static inline void complete_work(enum ibv_wc_status status, uint32_t vendor_err,
>                                   void *ctx)
>  {
> @@ -1123,7 +1183,13 @@ int rdma_backend_add_gid(RdmaBackendDev *backend_dev, const char *ifname,
>                                              gid->global.subnet_prefix,
>                                              gid->global.interface_id);
>  
> -    return ret;
> +    /*
> +     * We ignore return value since operation might have completed
> +     * successfully by the QMP consumer
> +     */
> +    netlink_route_update(ifname, gid, RTM_NEWADDR);
> +
> +    return 0;
>  }
>  
>  int rdma_backend_del_gid(RdmaBackendDev *backend_dev, const char *ifname,
> @@ -1149,6 +1215,12 @@ int rdma_backend_del_gid(RdmaBackendDev *backend_dev, const char *ifname,
>                                              gid->global.subnet_prefix,
>                                              gid->global.interface_id);
>  
> +    /*
> +     * We ignore return value since operation might have completed
> +     * successfully by the QMP consumer
> +     */
> +    netlink_route_update(ifname, gid, RTM_DELADDR);
> +
>      return 0;
>  }
>  
>

Reviewed-by: Kamal Heib <kheib@redhat.com>

