Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C31FC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 19:29:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D100820663
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 19:29:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D100820663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv48N-0003kF-6F
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 15:29:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44330)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jv47p-0003Kf-2o
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 15:28:29 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:53353)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jv47n-0007F6-5d
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 15:28:28 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1M2fQ9-1jsb1503Kh-004BtE; Mon, 13 Jul 2020 21:28:24 +0200
Subject: Re: [PATCH] linux-user: Add several IFTUN ioctls
To: Josh Kunz <jkz@google.com>, qemu-devel@nongnu.org
References: <20200710195328.587462-1-jkz@google.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <c5af9eb0-c01a-b624-e753-f7533e4e2772@vivier.eu>
Date: Mon, 13 Jul 2020 21:28:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200710195328.587462-1-jkz@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:N43pOeOPsDdtrmbqvuRvGTY9qJDRw6laCxzE4zwOpiNvC7Wd5TJ
 MoW9l7RlJ5Cc7jCfypz+RS8DnhWcZdZWFr3jYi495ockZUcGAF5MzDEl7nwADe5B3uxCMNH
 Jh1gtP2QXbq0FEj5dGnuPu3ZvAJ9sDn/l5oiHiN4BSCVhdyOIc1HgMZr52idKlNL7XWBzFY
 OMerGLJU/jiNzoEyBvsxQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2gtjQiOGF9g=:BdKfg+hka6+FP2tFW0/Cdq
 FbvGABSB3Bm5aspJN2aQ/k9Ya8Zo7kKiyMnblXaHZJoZeachyfbJKv6IHpVLYgzUlcchTJr9W
 d6U5dtI05KeF9A33ZkHlWiR+OK9rorHRUqgfgHJPKHgEnt2E/jDN730UKThYmFJxQ+a48rbvm
 CertbHaK/Yeb7U12xKHYV21noFEMTEoTf77IIo5GOfBHPLzBpDszaySxV4tVYLQNvdTu8QlPo
 xBHvKEtAHFMd/5hPdnqCdXGHas6KPB4qrfxrCnvDexLp3bcXZVaxgqCRkkCGnS66H8VWTmBlE
 AakTTOa31A1cmzu4Qe9YHQpt8Qdsg0bKN7lvcT8iWGto4TgV08XIQhZmhgV41sLe1LUreCKzN
 p/AwzJOiLU+dIfy66gxJ72ghafklX91YKEzumyYWnhNuTWKI2uK23RzbLsNhgQdfssEIBXXOF
 +SoPACGedE1ZMoIPHbEMuGiUVD3PNMDXV6/N/4U0N7729pY5Wklkj5Y+LgHocFjFD6SKrUoYJ
 2KMNnmmn9RivzocFBEHdfn0UPXT/jL7JcTe8r7HdMiRiqxBq3n8kHYKtC5dQCtatUDOv4wOop
 yNCq/E+2wKWTbsgG85UXgN7nmlDE1Nujv6Vkev54Z9qIFiydxmvZazCpu+i0LQIQykVleietU
 9k+8sjlLvbjoZsAOL/ZH47KnD/h0FtuFowweixd90upK8xtcPsOwMVjkryc6J/JpBJkCyKCBL
 GNvodYnSZYC3H+NiT58ZRwKA/IfrWTCcIQvSmQ1kju5ZQlhs6QnGBQp4SC0QskNPdlvjgHyvO
 oWGY+eFLyEKNG5bIttePLpgymWXLvbX01ZdbEqxSMikLetMX5R2JqTDAy46yZY3pntzk6oa
Received-SPF: none client-ip=217.72.192.74; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 15:28:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: riku.voipio@iki.fi
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 10/07/2020 à 21:53, Josh Kunz a écrit :
> This change includes most widely-available if_tun ioctls that are
> integer typed.
> 
> Tested by compiling all linux-user emulators. This patch has also been
> used successfully to run several binaries that utilize these ioctls for
> several months.
> 
> Linux Header:
> https://github.com/torvalds/linux/blob/dcde237b9b0eb1d19306e6f48c0a4e058907619f/include/uapi/linux/if_tun.h#L31
> 
> Signed-off-by: Josh Kunz <jkz@google.com>
> ---
>  linux-user/ioctls.h       | 20 ++++++++++++++++++++
>  linux-user/syscall.c      |  1 +
>  linux-user/syscall_defs.h | 21 +++++++++++++++++++++
>  3 files changed, 42 insertions(+)
> 
> diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
> index 0713ae1311..9b4a67fe84 100644
> --- a/linux-user/ioctls.h
> +++ b/linux-user/ioctls.h
> @@ -593,3 +593,23 @@
>    IOCTL(KCOV_DISABLE, 0, TYPE_NULL)
>    IOCTL(KCOV_INIT_TRACE, IOC_R, TYPE_ULONG)
>  #endif
> +
> +  IOCTL(TUNGETFEATURES  , IOC_R , TYPE_INT)
> +  IOCTL(TUNGETIFF       , IOC_R , TYPE_INT)
> +  IOCTL(TUNGETSNDBUF    , IOC_R , TYPE_INT)
> +  IOCTL(TUNGETVNETHDRSZ , IOC_R , TYPE_INT)
> +  IOCTL(TUNGETVNETLE    , IOC_R , TYPE_INT)
> +  IOCTL(TUNSETDEBUG     , IOC_W , TYPE_INT)
> +  IOCTL(TUNSETGROUP     , IOC_W , TYPE_INT)
> +  IOCTL(TUNSETIFF       , IOC_W , TYPE_INT)
> +  IOCTL(TUNSETIFINDEX   , IOC_W , TYPE_INT)
> +  IOCTL(TUNSETLINK      , IOC_W , TYPE_INT)
> +  IOCTL(TUNSETNOCSUM    , IOC_W , TYPE_INT)
> +  IOCTL(TUNSETOFFLOAD   , IOC_W , TYPE_INT)
> +  IOCTL(TUNSETOWNER     , IOC_W , TYPE_INT)
> +  IOCTL(TUNSETPERSIST   , IOC_W , TYPE_INT)
> +  IOCTL(TUNSETQUEUE     , IOC_W , TYPE_INT)
> +  IOCTL(TUNSETSNDBUF    , IOC_W , TYPE_INT)
> +  IOCTL(TUNSETTXFILTER  , IOC_W , TYPE_INT)
> +  IOCTL(TUNSETVNETHDRSZ , IOC_W , TYPE_INT)
> +  IOCTL(TUNSETVNETLE    , IOC_W , TYPE_INT)
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 98ea86ca81..4ad4b36a84 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -58,6 +58,7 @@
>  #include <linux/icmpv6.h>
>  #include <linux/errqueue.h>
>  #include <linux/random.h>
> +#include <linux/if_tun.h>
>  #ifdef CONFIG_TIMERFD
>  #include <sys/timerfd.h>
>  #endif
> diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
> index 3c261cff0e..833ef68faf 100644
> --- a/linux-user/syscall_defs.h
> +++ b/linux-user/syscall_defs.h
> @@ -859,6 +859,27 @@ struct target_rtc_pll_info {
>  #define TARGET_SIOCSIFPFLAGS   0x8934          /* set extended flags          */
>  #define TARGET_SIOCGIFPFLAGS   0x8935          /* get extended flags          */
>  
> +/* if_tun ioctls */
> +#define TARGET_TUNGETFEATURES   TARGET_IOR('T', 207, unsigned int)
> +#define TARGET_TUNGETIFF        TARGET_IOR('T', 210, unsigned int)
> +#define TARGET_TUNGETSNDBUF     TARGET_IOR('T', 211, int)
> +#define TARGET_TUNGETVNETHDRSZ  TARGET_IOR('T', 215, int)
> +#define TARGET_TUNGETVNETLE     TARGET_IOR('T', 221, int)
> +#define TARGET_TUNSETDEBUG      TARGET_IOW('T', 201, int)
> +#define TARGET_TUNSETGROUP      TARGET_IOW('T', 206, int)
> +#define TARGET_TUNSETIFF        TARGET_IOW('T', 202, int)
> +#define TARGET_TUNSETIFINDEX    TARGET_IOW('T', 218, unsigned int)
> +#define TARGET_TUNSETLINK       TARGET_IOW('T', 205, int)
> +#define TARGET_TUNSETNOCSUM     TARGET_IOW('T', 200, int)
> +#define TARGET_TUNSETOFFLOAD    TARGET_IOW('T', 208, unsigned int)
> +#define TARGET_TUNSETOWNER      TARGET_IOW('T', 204, int)
> +#define TARGET_TUNSETPERSIST    TARGET_IOW('T', 203, int)
> +#define TARGET_TUNSETQUEUE      TARGET_IOW('T', 217, int)
> +#define TARGET_TUNSETSNDBUF     TARGET_IOW('T', 212, int)
> +#define TARGET_TUNSETTXFILTER   TARGET_IOW('T', 209, unsigned int)
> +#define TARGET_TUNSETVNETHDRSZ  TARGET_IOW('T', 216, int)
> +#define TARGET_TUNSETVNETLE     TARGET_IOW('T', 220, int)
> +
>  /* Bridging control calls */
>  #define TARGET_SIOCGIFBR       0x8940          /* Bridging support             */
>  #define TARGET_SIOCSIFBR       0x8941          /* Set bridging options         */
> 

Applied to my linux-user-for-5.1 branch.

Thanks,
Laurent

