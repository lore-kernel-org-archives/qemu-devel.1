Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AADEC18E7D
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 09:22:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2028B2075B
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 09:22:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2028B2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39067 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTNSc-0008Vn-CR
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 05:22:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hTNOp-0006DR-RD
	for qemu-devel@nongnu.org; Wed, 22 May 2019 05:19:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hTNOo-0003ab-Pe
	for qemu-devel@nongnu.org; Wed, 22 May 2019 05:19:03 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:36627)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hTNOo-0003ZC-El
	for qemu-devel@nongnu.org; Wed, 22 May 2019 05:19:02 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
	(mreue107 [213.165.67.119]) with ESMTPSA (Nemesis) id
	1MCsDe-1hKbxR42wi-008vTB; Wed, 22 May 2019 11:18:02 +0200
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
References: <1558282527-22183-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1558282527-22183-5-git-send-email-aleksandar.markovic@rt-rk.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <6358a49b-515d-92e6-d3dc-97f0adcaa23b@vivier.eu>
Date: Wed, 22 May 2019 11:18:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1558282527-22183-5-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:FNDZBDna56lF+w11k2G+dB0iIHREX14A79uSG2Af8O4AlUnt290
	ISy3r4HOU8GHd9BTKbEm4dmqXZg3EoiePz66uCzoN43QTf0cnjygXMNyPEwdnWbxMZKBNhb
	Iw2nAvjGXLoftS7IndTGY3iMcQ2SF/IU3uR+J60Igyq0mk4PcpIp75TFRw/1mRob0PnBQsw
	qeAeJxCL8BvZo1kxYpS+w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BEH/wzH51jk=:SKTskUd3ozE4SU9SSoWeh7
	VdVcii7Qo2tZqKfHF9HgpTi7mBVDZ8nsv7Edyn9KFQlgPSAJx/YSkogmvnEdHK7zhZ+65wg/1
	mglze1bIP6UEQedRYdo7eHCam5bHxtRlbCUSatvS73LDZfDWvXW1NcjLCUy5YPVhKDHo2R6gD
	aen3Fbi/7/f74tgr0++UjLg6IM5xPCqQchJUVAmvN4ZB44/3Zc2fOFdBwW37dKYeL1msPWtVc
	OzVXhigEfMaHMVd95KuFexOImPI3L0WWTk/wiZDtw9xVjYrUajQNubxuqepWYCMnuNF0v3IGK
	FTPNtzKYo/XLl0s9NIb+8zbFDbXt3PvRCxa5CHbptrxuZeH76AZA9HUIOG31X4G3NNIGYmu6r
	4PKV56nksAcCRDNvLcU74VJUhd7tFPTF2ZbFkPNZfdcwr7DKZJcEYqQ1IDMMNqYBSAEU8K/o8
	z+hOFuA3DR5nFOl1S31bELtYhMr1c7elU0vAOJ9SRlgRx5aaY5HzVb71aToprnXmoYYxz8qyk
	r+qqLijYk2G8XUwLl8J/C4kOhDe2+SkwXw03I3KsCoNrI3pIJcGrqV9jkiAeAZmyqFA4rTTZW
	ZKWF1wYpgBpYmL3zmtGVSuft+voIMkIcYtIOaRv6vapXjkgHr8YSDQyNtkza63VKBCfGBAeiq
	f5UhY5Lae7+6KoobMvkq2E7SZ57pnsOUp6TxVunlgTVRMbVrU+qQgcHbmXNA7tABjNfAHUCU/
	na3r9j4K8udO9zpvghOX96ggDKch3D70oawftF6MLcZOcJUCrD6k5G8uaEc=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.10
Subject: Re: [Qemu-devel] [PATCH v6 4/6] linux-user: Add support for
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

On 19/05/2019 18:15, Aleksandar Markovic wrote:
> From: Neng Chen <nchen@wavecomp.com>
> 
> Add support for options IPV6_ADD_MEMBERSHIP and IPV6_DROP_MEMPEMBERSHIP
> of the syscall setsockopt(). These options control membership in
> multicast groups. Their argument is a pointer to a struct ipv6_mreq,
> which is in turn defined in IP v6 header netinet/in.h as:
> 
>   struct ipv6_mreq {
>       /* IPv6 multicast address of group */
>       struct  in6_addr  ipv6mr_multiaddr;
>       /* local IPv6 address of interface */
>       int     ipv6mr_interface;
>   };
> 
> ...whereas its definition in kernel's include/uapi/linux/in6.h is:
> 
>   #if __UAPI_DEF_IPV6_MREQ
>   struct ipv6_mreq {
>       /* IPv6 multicast address of group */
>           struct  in6_addr ipv6mr_multiaddr;
>       /* local IPv6 address of interface */
>       int     ipv6mr_ifindex;
>   };
>   #endif
> 
> The first field of ipv6_mreq has the same name ("ipv6mr_multiaddr")
> and type ("in6_addr") in both cases. Moreover, the in6_addr structure
> consists of fields that are always big-endian (on host of any endian),
> therefore the ipv6_mreq's field ipv6mr_multiaddr doesn't need any
> endian conversion.
> 
> The second field of ipv6_mreq may, however, depending on the build
> environment, have different names. This is the reason why the line
> "#if __UAPI_DEF_IPV6_MREQ" is used in this patch - to establish the
> right choice for the field name. Also, endian conversion is needed
> for this field, since it is of type "int".
> 
> Signed-off-by: Neng Chen <nchen@wavecomp.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>   linux-user/syscall.c | 23 +++++++++++++++++++++++
>   1 file changed, 23 insertions(+)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 96cd4bf..acff14d 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -1892,6 +1892,29 @@ static abi_long do_setsockopt(int sockfd, int level, int optname,
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
> +#if __UAPI_DEF_IPV6_MREQ
> +            ipv6mreq.ipv6mr_ifindex = tswap32(ipv6mreq.ipv6mr_ifindex);
> +#else
> +            ipv6mreq.ipv6mr_interface = tswap32(ipv6mreq.ipv6mr_interface);
> +#endif /* __UAPI_DEF_IVP6_MREQ */
> +
> +            ret = get_errno(setsockopt(sockfd, level, optname,
> +                                       &ipv6mreq, sizeof(ipv6mreq)));
> +            break;
> +        }
>           default:
>               goto unimplemented;
>           }
> 

Applied to my linux-user branch.

Thanks,
Laurent

