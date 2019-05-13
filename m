Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77BE9C04AA7
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 12:05:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DCBC20989
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 12:05:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DCBC20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56024 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQ9i9-0001Gq-GP
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 08:05:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hQ9eD-00072R-Cl
	for qemu-devel@nongnu.org; Mon, 13 May 2019 08:01:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hQ9e2-0003Zj-CS
	for qemu-devel@nongnu.org; Mon, 13 May 2019 08:01:30 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:43603)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hQ9e0-0003YI-Il
	for qemu-devel@nongnu.org; Mon, 13 May 2019 08:01:25 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
	(mreue012 [213.165.67.103]) with ESMTPSA (Nemesis) id
	1MlL5x-1gyXeB3mnd-00lkPb; Mon, 13 May 2019 14:00:51 +0200
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
References: <1556905846-14074-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1556905846-14074-5-git-send-email-aleksandar.markovic@rt-rk.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <df71e5d2-a880-80eb-0a35-dfd94daae7f7@vivier.eu>
Date: Mon, 13 May 2019 14:00:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1556905846-14074-5-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:2jjGkuc2KIh7Tt8WP3Ho8rBVBksZ/kpwZhq2z1UeWKpMgVopCQP
	dfK7f3VI829KIJ7reyB3gdRJ2PlG0NYtnUYcqMqFwgL5ZOThmedO27SyzdeD6BTYVhSu6Rq
	WPzwGaAQ8sAVb4VmUQGVE7JTtsxTO6Iq7QCO5MX5ZC7WERw3wlAgsOeq8IgTyNqex29PtWM
	Ts0e0iWWakoNkTuMGKr6g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:61LCaUVn0Zw=:ZE8iuLDKnIrMR8UTE37WMK
	zPZ1eo/P+ZB49uuChQcM6Ik1epgy/4tX8R2oVdYPgQ5P8Kfb3YGDqZxyNdJmiXK8YI3iJpfmu
	g3VlrAZsG3rR3DwuCXFpdC28vb3da74/qsHAVSsci3S9eESjtE8J5ZejooPCdLo7wA5n+L0Ha
	ZxbebqrPyN4bvIhJAKx/Z4lJ9uM0K8IfRWZs7VnANIXP+tNVH+0ktr1wc2KOm59vzZVefuHcR
	b/zhhCm3B/UUluDZV5LItlgKXgUb3V6u1MpTS+uJa4AzEGzIqsEmNrRK+r2b9truB+73jY0NN
	ApV6OC1SqQZF1z8OyQi1nIBFRNuRRBPsveTsJ/9cJmCw5Sb5ymhgoeLO7I0br7y7p8xCjJXZx
	QDc06FaeGV3vhJdi2e9QJl6NxCmjShwOEgWyMMIXus3kLcrdOvQdieUnDKl3T4bOrIRkpSJlO
	3c+DQdtxYstNhFc3mjDZ9PsRw+f6EHPZSUvxEp1zX4IA9wcuzK5YLqZOiC8IMQRnjn0S0YRz7
	OA08jUCYwPcD9lNT8te/xaXNhFF3eMBuJVpMaIc3W4tf3y/oY0zKjKN86as+oWxunpfdt3Wx/
	8XTnawEdLgkBLGKOl3y9mOsvmC5VlFQjdWHJ+yCHwt6bVXFRCgl/S9IOC9emhLGx785fjf5fi
	Yg6Vwu2bc3wLo/7AIDyhlsXEiALq4T6MWAVDehpoSO3IDmyVz3xZmS+duryrGXwXvFzAMo1fr
	28QM0SqXIo79NaKnm01RGw+KMTjMtoq5HaOIoIF3rFmwhPacluuE1+trxG0=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.187
Subject: Re: [Qemu-devel] [PATCH v4 4/5] linux-user: Add support for
 setsockopt() options IPV6_<ADD|DROP>_MEMBERSHIP
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
Cc: lvivier@redhat.com, thuth@redhat.com, daniel.santos@pobox.com,
	arikalo@wavecomp.com, jcmvbkbc@gmail.com, amarkovic@wavecomp.com,
	nchen@wavecomp.com, philmd@redhat.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03/05/2019 19:50, Aleksandar Markovic wrote:
> From: Neng Chen <nchen@wavecomp.com>
> 
> Add support for options IPV6_ADD_MEMBERSHIP and IPV6_DROP_MEMPEMBERSHIP
> of the syscall setsockopt(). These options control membership in
> multicast groups. Their argument is a pointer to a struct ipv6_mreq,
> which is in turn defined as:
> 
> struct ipv6_mreq {
>      /* IPv6 multicast address of group */
>      struct in6_addr  ipv6mr_multiaddr;
>      /* local IPv6 address of interface */
>      int              ipv6mr_interface;
> };
> 
> The in6_addr structure consists of fields that are always big-endian
> (on host of any endian), so the ipv6_mreq's field ipv6mr_multiaddr
> doesn't need any endian conversion, whereas ipv6mr_interface does.
> 
> Signed-off-by: Neng Chen <nchen@wavecomp.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>   linux-user/syscall.c | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 96cd4bf..b7eb4b7 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -1892,6 +1892,25 @@ static abi_long do_setsockopt(int sockfd, int level, int optname,
>                                          &pki, sizeof(pki)));
>               break;
>           }
> +        case IPV6_ADD_MEMBERSHIP:
> +        case IPV6_DROP_MEMBERSHIP:
> +        {
> +            struct ipv6_mreq ipv6mreq;
> +
> +            if (optlen < sizeof(ipv6mreq)) {
> +                return -TARGET_EINVAL;
> +            }
> +
> +            if (copy_from_user(&ipv6mreq, optval_addr, sizeof(ipv6mreq))) {
> +                return -TARGET_EFAULT;
> +            }
> +
> +            ipv6mreq.ipv6mr_interface = tswap32(ipv6mreq.ipv6mr_interface);

The name of this field seems to depend on where it is defined: in 
netinet/in.h, it's ipv6mr_interface, but in linux/in6.h it's 
ipv6mr_ifindex. I think you should check "__UAPI_DEF_IPV6_MREQ" to use 
the good one.

> +
> +            ret = get_errno(setsockopt(sockfd, level, optname,
> +                                       &ipv6mreq, sizeof(ipv6mreq)));
> +            break;
> +        }
>           default:
>               goto unimplemented;
>           }
> 

Thanks,
Laurent

