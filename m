Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A895C2D0F7
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 20:21:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 664A820740
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 20:21:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 664A820740
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYbOy-0006qK-Jh
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 16:21:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53314)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jYbO4-0005kS-AW; Tue, 12 May 2020 16:20:24 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:49383)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jYbO3-0004S8-1D; Tue, 12 May 2020 16:20:23 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue010 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1McGp2-1iyRgU3WPM-00ck8w; Tue, 12 May 2020 22:20:11 +0200
Subject: Re: [PATCH 2/2] linux-user: add do_setsockopt CAN_RAW_FD_FRAMES
 support
To: Tomas Krcka <tomas.krcka@gmail.com>, qemu-devel@nongnu.org
References: <20200506132114.76406-1-tomas.krcka@gmail.com>
 <20200506132114.76406-2-tomas.krcka@gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <70c3f462-d1eb-73c6-745b-8872ef0a6f12@vivier.eu>
Date: Tue, 12 May 2020 22:20:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200506132114.76406-2-tomas.krcka@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:WMDM2ekR7RKBlo8K5oWhrE2qZVKTAV5Vegd5PAgQiPpAAYRq0M/
 9gsE5FHRzafxUJ4Xg60eRWX5Jg+jYOLx50f9BU8RHa94bvMltvS5wuVlUfLDyf/NsgQyfv2
 hu/Gt5oycQcnf38PnFz2mMzkiE2+HyKYkMp21X06ndZeEXQdSZn81EW8rs9i7EheDzFvxcg
 4CWw/1dl4zg+nf7XEUiCg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cGJBYSfY30Q=:2DioiJTEYQwn9rdeiZmLXW
 fgee02Bp5RXHbjtp9D3LkeRZS0fvttu5zmAtENMpMotPQabHhf53zyPp6F6/LlDhd0cgRiAok
 4K+iH2KjSLDRAfmpImYYI5Tg6E3OkBpPAH7Qj8bwHZErlZq4+HhGZbA2mTxkFToHbWqR1lVt0
 1UEkYpmtfk7JMloJih3LefOwhOgQZUWQZmfzmCEjGqL3MKoXlM76mm1QabsNZvBlYODTgiQ1Q
 NuB4Yx0GLnglEo/pz26LRDTU0RyDogUhImrF2ebbtGlYTExolOx7sI41WlxvRPlk+s7+CiV4Z
 Cj2sY3BsLMQOAVFZcU1vFwAd5OxE/VKuqmJL0UNVgFFo5b8K8NsLZP6eSOXkqL536igrZGk+n
 v0Y/ldLfsMBjgTT8J8f4XNmwiQWfrfvzfGnc+rqkeP5BbPpUNCqgUqQVViVU1PMmW+5egIA4H
 EOyTldP/mxXma0EZdb+rnq7dgZKSN+gTwRjBl1zjgpHWryIF4L3ttSves//RcUVCnAlw1psoI
 k4zQF+Lfnr6fSCCxIXVvy8EfbfTPbT1D1s9LlMtwK3zZVaSTfsjKTAfisT0j0hF5qiVG5x3Cb
 VYIXtE9z6mg6Eziit6V6jw23jWLTAGbE73bEqLYE1fFMGTMIHGzH92YQnrhJ/lX0NwC836Mfd
 vihe1W5GGjxYaxhxuaTslz6wwTY+PHteYO7E2xDM602L1vZPNEfRgsj5sVtlaA7SOLrRza4B1
 IOxk8W4/5Tiwtup5bBtV8D+8ICOkYgkDISMH0mf3UdJZc4Sq1Aka3/3/mjX1bDSXdSPI3Qgcm
 gbTv8YJxz9LkwHcfilPQ+A/WCJD2bkwHTxsiCUqNnd9ao5cLI7ki6VRhCXYPRjbsUvM9ezS
Received-SPF: none client-ip=212.227.126.135; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 16:09:14
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-trivial@nongnu.org, Riku Voipio <riku.voipio@iki.fi>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 06/05/2020 à 15:21, Tomas Krcka a écrit :
> Signed-off-by: Tomas Krcka <tomas.krcka@gmail.com>
> ---
>  linux-user/syscall.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 88d4c85b70..f751ed8b37 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -2141,6 +2141,19 @@ static abi_long do_setsockopt(int sockfd, int level, int optname,
>              g_free(can_filters);
>              break;
>          }
> +        case CAN_RAW_FD_FRAMES:
> +        {
> +            val = 0;

You don't need to set val to 0.

> +            if (optlen < sizeof(uint32_t)) {

kernel checks for the exact size and fails otherwise.

> +                return -TARGET_EINVAL;
> +            }
> +            if (get_user_u32(val, optval_addr)) {
> +                return -TARGET_EFAULT;
> +            }
> +            ret = get_errno(setsockopt(sockfd, level, optname,
> +                                    &val, sizeof(val)));
> +            break;
> +        }
>          default:
>              goto unimplemented;
>          }
> 

Could you implement getsockopt() too?

Thanks,
Laurent

