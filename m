Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2679C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 02:50:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 148EA2236F
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 02:50:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H2E2Yv7/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 148EA2236F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ka8sk-0008Ho-1G
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 21:50:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58720)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1ka8ro-0007oY-4W
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 21:49:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41945)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1ka8rj-0003gX-Nl
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 21:49:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604458177;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JuHKpx6igcSueLfvDTw4ZVsDWSY+pVFG8HmNO4Bdxow=;
 b=H2E2Yv7/b8dhNNml4KFxPiXKsSjjqfP6bPE7FVLjQdPrtX275t8dfBvtSJ+aqLxORAQeEC
 RwCBYaR9CPyx2yaUJTsV2djJLaiwK9NudH+HJ+b4fqk+fmavRTvycN/e1t/wojTONj9iEy
 qEnwASDr2hB0rcimPzYW8LfScIwdU3I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-319-PeSt_EJrNw-RFGKrcVo70A-1; Tue, 03 Nov 2020 21:49:34 -0500
X-MC-Unique: PeSt_EJrNw-RFGKrcVo70A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0B583803F42;
 Wed,  4 Nov 2020 02:49:33 +0000 (UTC)
Received: from [10.72.13.133] (ovpn-13-133.pek2.redhat.com [10.72.13.133])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2A0395D9CC;
 Wed,  4 Nov 2020 02:49:27 +0000 (UTC)
Subject: Re: [RFC PATCH 1/6] net: Added SetSteeringEBPF method for
 NetClientState.
To: Andrew Melnychenko <andrew@daynix.com>, mst@redhat.com
References: <20201102185115.7425-1-andrew@daynix.com>
 <20201102185115.7425-2-andrew@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <b94d69ef-8067-9bc9-aaae-2bca88e5d9ba@redhat.com>
Date: Wed, 4 Nov 2020 10:49:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201102185115.7425-2-andrew@daynix.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: yan@daynix.com, yuri.benditovich@daynix.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/11/3 上午2:51, Andrew Melnychenko wrote:
> From: Andrew <andrew@daynix.com>
>
> For now, that method supported only by Linux TAP.
> Linux TAP uses TUNSETSTEERINGEBPF ioctl.
> TUNSETSTEERINGBPF was added 3 years ago.
> Qemu checks if it was defined before using.
>
> Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
> ---
>   include/net/net.h |  2 ++
>   net/tap-bsd.c     |  5 +++++
>   net/tap-linux.c   | 19 +++++++++++++++++++
>   net/tap-solaris.c |  5 +++++
>   net/tap-stub.c    |  5 +++++
>   net/tap.c         |  9 +++++++++
>   net/tap_int.h     |  1 +
>   7 files changed, 46 insertions(+)
>
> diff --git a/include/net/net.h b/include/net/net.h
> index 897b2d7595..d8a41fb010 100644
> --- a/include/net/net.h
> +++ b/include/net/net.h
> @@ -60,6 +60,7 @@ typedef int (SetVnetBE)(NetClientState *, bool);
>   typedef struct SocketReadState SocketReadState;
>   typedef void (SocketReadStateFinalize)(SocketReadState *rs);
>   typedef void (NetAnnounce)(NetClientState *);
> +typedef bool (SetSteeringEBPF)(NetClientState *, int);
>   
>   typedef struct NetClientInfo {
>       NetClientDriver type;
> @@ -81,6 +82,7 @@ typedef struct NetClientInfo {
>       SetVnetLE *set_vnet_le;
>       SetVnetBE *set_vnet_be;
>       NetAnnounce *announce;
> +    SetSteeringEBPF *set_steering_ebpf;
>   } NetClientInfo;
>   
>   struct NetClientState {
> diff --git a/net/tap-bsd.c b/net/tap-bsd.c
> index 77aaf674b1..4f64f31e98 100644
> --- a/net/tap-bsd.c
> +++ b/net/tap-bsd.c
> @@ -259,3 +259,8 @@ int tap_fd_get_ifname(int fd, char *ifname)
>   {
>       return -1;
>   }
> +
> +int tap_fd_set_steering_ebpf(int fd, int prog_fd)
> +{
> +    return -1;
> +}
> diff --git a/net/tap-linux.c b/net/tap-linux.c
> index b0635e9e32..196373019f 100644
> --- a/net/tap-linux.c
> +++ b/net/tap-linux.c
> @@ -31,6 +31,7 @@
>   
>   #include <net/if.h>
>   #include <sys/ioctl.h>
> +#include <linux/if_tun.h> /* TUNSETSTEERINGEBPF */
>   
>   #include "qapi/error.h"
>   #include "qemu/error-report.h"
> @@ -316,3 +317,21 @@ int tap_fd_get_ifname(int fd, char *ifname)
>       pstrcpy(ifname, sizeof(ifr.ifr_name), ifr.ifr_name);
>       return 0;
>   }
> +
> +int tap_fd_set_steering_ebpf(int fd, int prog_fd)
> +{
> +#ifdef TUNSETSTEERINGEBPF


I'm not sure how much this can help.

But looking at tap-linux.h, I wonder do we need to pull TUN/TAP uapi 
headers.

Thanks


> +    if (ioctl(fd, TUNSETSTEERINGEBPF, (void *) &prog_fd) != 0) {
> +        error_report("Issue while setting TUNSETSTEERINGEBPF:"
> +                    " %s with fd: %d, prog_fd: %d",
> +                    strerror(errno), fd, prog_fd);
> +
> +       return -1;
> +    }
> +
> +    return 0;
> +#else
> +    error_report("TUNSETSTEERINGEBPF is not supported");
> +    return -1;
> +#endif
> +}
> diff --git a/net/tap-solaris.c b/net/tap-solaris.c
> index 0475a58207..d85224242b 100644
> --- a/net/tap-solaris.c
> +++ b/net/tap-solaris.c
> @@ -255,3 +255,8 @@ int tap_fd_get_ifname(int fd, char *ifname)
>   {
>       return -1;
>   }
> +
> +int tap_fd_set_steering_ebpf(int fd, int prog_fd)
> +{
> +    return -1;
> +}
> diff --git a/net/tap-stub.c b/net/tap-stub.c
> index de525a2e69..a0fa25804b 100644
> --- a/net/tap-stub.c
> +++ b/net/tap-stub.c
> @@ -85,3 +85,8 @@ int tap_fd_get_ifname(int fd, char *ifname)
>   {
>       return -1;
>   }
> +
> +int tap_fd_set_steering_ebpf(int fd, int prog_fd)
> +{
> +    return -1;
> +}
> diff --git a/net/tap.c b/net/tap.c
> index c46ff66184..81f50017bd 100644
> --- a/net/tap.c
> +++ b/net/tap.c
> @@ -337,6 +337,14 @@ static void tap_poll(NetClientState *nc, bool enable)
>       tap_write_poll(s, enable);
>   }
>   
> +static bool tap_set_steering_ebpf(NetClientState *nc, int prog_fd)
> +{
> +    TAPState *s = DO_UPCAST(TAPState, nc, nc);
> +    assert(nc->info->type == NET_CLIENT_DRIVER_TAP);
> +
> +    return tap_fd_set_steering_ebpf(s->fd, prog_fd) == 0;
> +}
> +
>   int tap_get_fd(NetClientState *nc)
>   {
>       TAPState *s = DO_UPCAST(TAPState, nc, nc);
> @@ -362,6 +370,7 @@ static NetClientInfo net_tap_info = {
>       .set_vnet_hdr_len = tap_set_vnet_hdr_len,
>       .set_vnet_le = tap_set_vnet_le,
>       .set_vnet_be = tap_set_vnet_be,
> +    .set_steering_ebpf = tap_set_steering_ebpf,
>   };
>   
>   static TAPState *net_tap_fd_init(NetClientState *peer,
> diff --git a/net/tap_int.h b/net/tap_int.h
> index 225a49ea48..547f8a5a28 100644
> --- a/net/tap_int.h
> +++ b/net/tap_int.h
> @@ -44,5 +44,6 @@ int tap_fd_set_vnet_be(int fd, int vnet_is_be);
>   int tap_fd_enable(int fd);
>   int tap_fd_disable(int fd);
>   int tap_fd_get_ifname(int fd, char *ifname);
> +int tap_fd_set_steering_ebpf(int fd, int prog_fd);
>   
>   #endif /* NET_TAP_INT_H */


