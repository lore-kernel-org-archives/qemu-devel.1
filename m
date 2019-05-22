Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7AB2C18E7D
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 09:18:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C6C720675
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 09:18:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C6C720675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39008 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTNOS-0005lK-Q9
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 05:18:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hTNKl-0003Rx-O3
	for qemu-devel@nongnu.org; Wed, 22 May 2019 05:14:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hTNKk-000853-4c
	for qemu-devel@nongnu.org; Wed, 22 May 2019 05:14:51 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:46767)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hTNKj-00081u-Rs
	for qemu-devel@nongnu.org; Wed, 22 May 2019 05:14:50 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
	(mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
	1N17cq-1gWm7x3exO-012VyN; Wed, 22 May 2019 11:13:44 +0200
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
References: <1558282527-22183-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1558282527-22183-4-git-send-email-aleksandar.markovic@rt-rk.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <9fa4f5f8-d5ff-59b3-17b4-386cfb39062e@vivier.eu>
Date: Wed, 22 May 2019 11:13:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1558282527-22183-4-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:ajbKMTYs2iv4ROHAZ7B9yAukJqSkF7phndQ03mRGbKB80ebTSpe
	QS3M94pym300wJ7d+IwEew9hgXQQm1Xm1HLHqA2XfP+5W3ZPVxnIFYxd0AyZuJi0y/bLreo
	BD+hyoAVHLHtrhXeCTnoUXsZs3wGCE9MwM4dcc7snJky1Ze2JmL15J6SZqZUiRzb8+ZXws1
	xlQRF3n5JKadYbzrJOXIA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dW0sSKcs8rY=:aNdzfg/jsSXuj1Nu9nAn9c
	+A7eUTKG9bUXUWJRhtdDtnJ4jdeYves4U0TaisWJ6nXAiW5Lw7plZ5jInsy16LoPBubjg6akb
	HBmayA3dlDCCLaIEUnvgpVNJte1B4Wt8HceWPGoJv2iJYExuFhcEjns/3zd70kLd3NF0lJLQS
	5T6RkvtzO1cZWSmWruqr77tINPH5m4vsCGg6FJDKrrDFf2HInMpIR6qYrKHYLbuIYqa6S4h9L
	efixxjSBBjYrYGBf7TcHZlf8GNofBAy5BHIfo+JSUcKPHF6eQeRf/hZCGLJILc7vLQ6xbBjyM
	DNXzQiulQPPNXXuqCosGOOWIxnUIG5MRtVQWVnqitJeO3rg9bXqBkSHN+L6VAcOPbjPnpkPKy
	0P2pfTvnQNmuVDp81l51KTfm7cfO0qLg9JdD3YU2xpPN9POH3k6GEtK9fF7mYURQqRkofkaGk
	RSqdH+n1IJVijcqsgBHDjTeESsLSBaJLRsnnhvEfn4kH0esUjy6hyuvLgewERfR6BzYwYG7uM
	ZpLOucqsDMK2xN8N8mAOQRhS8vdBwa0BEiViCoocLZCIas03L67bBmxyihXNB2a4yYgCIwZ9w
	yi5N/mnW9eT7Q40MBb27PUXX26sSRZaWgn8FU4/f/dvccHqZPimb15adFIGQ7c2AGC+b9nrVT
	TWlpMePb4T2NfTbtvONKJOrjMMj4dg1AXcNVEj1cNqqGMAVc52H+GyEs4hRP9hCOim+x4XpdZ
	2GP1Tn8LLrZENYDZJZk36u28u1YNdSCrLZYpsfXJ7qhluI6u66q29bEqEZM=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.73
Subject: Re: [Qemu-devel] [PATCH v6 3/6] linux-user: Add support for
 SIOC<G|S>IFPFLAGS ioctls for all targets
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
> Add support for getting and setting extended private flags of a
> network device via SIOCSIFPFLAGS and SIOCGIFPFLAGS ioctls.
> 
> The ioctl numeric values are platform-independent and determined by
> the file include/uapi/linux/sockios.h in Linux kernel source code:
> 
>    #define SIOCSIFPFLAGS 0x8934
>    #define SIOCGIFPFLAGS	0x8935
> 
> These ioctls get (or set) the field ifr_flags of type short in the
> structure ifreq. Such functionality is achieved in QEMU by using
> MK_STRUCT() and MK_PTR() macros with an appropriate argument, as
> it was done for existing similar cases.
> 
> Signed-off-by: Neng Chen <nchen@wavecomp.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
> Message-Id: <1554839486-3527-1-git-send-email-aleksandar.markovic@rt-rk.com>
> ---
>   linux-user/ioctls.h       | 2 ++
>   linux-user/syscall_defs.h | 2 ++
>   2 files changed, 4 insertions(+)
> 
> diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
> index c37adc5..76375df 100644
> --- a/linux-user/ioctls.h
> +++ b/linux-user/ioctls.h
> @@ -206,6 +206,8 @@
>     IOCTL(SIOCADDMULTI, IOC_W, MK_PTR(MK_STRUCT(STRUCT_sockaddr_ifreq)))
>     IOCTL(SIOCDELMULTI, IOC_W, MK_PTR(MK_STRUCT(STRUCT_sockaddr_ifreq)))
>     IOCTL(SIOCGIFINDEX, IOC_W | IOC_R, MK_PTR(MK_STRUCT(STRUCT_int_ifreq)))
> +  IOCTL(SIOCSIFPFLAGS, IOC_W, MK_PTR(MK_STRUCT(STRUCT_short_ifreq)))
> +  IOCTL(SIOCGIFPFLAGS, IOC_W | IOC_R, MK_PTR(MK_STRUCT(STRUCT_short_ifreq)))
>     IOCTL(SIOCSIFLINK, 0, TYPE_NULL)
>     IOCTL_SPECIAL(SIOCGIFCONF, IOC_W | IOC_R, do_ioctl_ifconf,
>                   MK_PTR(MK_STRUCT(STRUCT_ifconf)))
> diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
> index 2941231..8904d35 100644
> --- a/linux-user/syscall_defs.h
> +++ b/linux-user/syscall_defs.h
> @@ -781,6 +781,8 @@ struct target_pollfd {
>   #define TARGET_SIOCADDMULTI    0x8931          /* Multicast address lists      */
>   #define TARGET_SIOCDELMULTI    0x8932
>   #define TARGET_SIOCGIFINDEX    0x8933
> +#define TARGET_SIOCSIFPFLAGS   0x8934          /* set extended flags          */
> +#define TARGET_SIOCGIFPFLAGS   0x8935          /* get extended flags          */
>   
>   /* Bridging control calls */
>   #define TARGET_SIOCGIFBR       0x8940          /* Bridging support             */
> 

Applied to my linux-user branch.

Thanks,
Laurent

