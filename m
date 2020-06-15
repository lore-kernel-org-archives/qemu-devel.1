Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB39C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 09:34:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23D0C206B7
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 09:34:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23D0C206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jklW4-0001qu-8c
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 05:34:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37410)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jklV0-00014H-65
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 05:33:50 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:48685)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jklUy-0004YF-7N
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 05:33:49 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1M7JvO-1jqIKx2ugW-007oyB; Mon, 15 Jun 2020 11:33:43 +0200
To: Filip Bozuta <filip.bozuta@syrmia.com>, qemu-devel@nongnu.org
References: <20200612164001.27405-1-filip.bozuta@syrmia.com>
 <20200612164001.27405-2-filip.bozuta@syrmia.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH 1/2] linux-user: Add thunk argument types for SIOCGSTAMP
 and SIOCGSTAMPNS
Message-ID: <c6902958-51fc-0215-de52-6bcb11cb440a@vivier.eu>
Date: Mon, 15 Jun 2020 11:33:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200612164001.27405-2-filip.bozuta@syrmia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:OYoFDpO3/uis3Cub9cqg18ace4RxA475bwgi+a2p/+SAiCk1TeP
 LaA5+fQozazsIwZ3EVm81tRvE3mvn4CnCRPVI1k/XPPVrxDfe3mfjy71aO0WpCjtlTB0urX
 oDjek2LPBD3Xk3IuabcBkkDLaflymusHUsbcjur9rKr7fQYVXHE4+w//E0T/qm53RPvQVhh
 EOQXhYFzfoqoDOnKenYDA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Qs//D8iVnss=:zeZ03ZmAQ/q7wkaZ4Y1dPh
 boSmp3HocdMQFmzVsWFB4GiQlQInk800NTga445F/vOoyrehpdbz2WgPp9ytZQqNxPFUtcZ96
 l4Wa/xci/YCe4hM8U7wq9qmDJG12HwGEzYUKWw1Fb0JxS/zd/IjDZQrV1gG+jLu12fgIEJbZv
 raWU3Bs8Dv3KPscJuVLjLHMqFCbzWU/MCteM/APIQeQpBdg048Z5romyZsyzSHDgRtxBMmEHk
 H0iiLQJpkaEfdHj/iQ8ch2hPHgeCdR+Dt0WBPVfmoYVFmPoRB/Vt4xbzUuDofE8z8MX4Qmopx
 6UsZfSNNRxcVT9F4aZx4jp4C4TSLvgnogG9HiLnlyYd5MVWYBHIfdJNbZMYXf9LicPGOCZjx1
 eQrremUpf7+q8EJx9ZquWxhVH95l744WYfREkJb0ubQzSZDBnzEFyeMuJW88ozhrzolks9PM1
 8YF9EbwaiyId1AHTtlDZxiptrUvcwUbSiKeyn74T5sJm9lyAtxrQdewNFIt1U2Yd4Smy1PHEf
 3oGPd2E64/qzZZNc5QvKl0g1eRp5JsHdQiNfekSwTnrz58AS+k4kO0Ta1jJeUZCdDR/xKcpvc
 7LM56yxR3hVbSIYZH4hf3y7gIQMhcozvJmoAerEixW6krGAm+F411eOhyZie8S1AImOlqthPD
 i2dyCucKTbAw8tEWtOYmc2VYxDCzO22VaZX0R9FeSBsSjDVLkAxEtUHUnYUV9jYbeiXQfGGaY
 RccRmgov2DHpyHa2+6SgvatbnzlysHrym7GNCOMKu40aQsShJOoisLGFFn+xDzGnvwkTCnVVV
 nWLIuvK+pYQNBs0nunZIjHPV+fNLJ3/B6FhrLo+Kx3FD1j9hbGyEY7zHLegvWvRl1jp4SLS
Received-SPF: none client-ip=212.227.17.10; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/15 05:33:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 12/06/2020 à 18:40, Filip Bozuta a écrit :
> From: Filip Bozuta <Filip.Bozuta@syrmia.com>
> 
> Socket ioctls SIOCGSTAMP and SIOCGSTAMPNS, used for timestamping the socket
> connection, are defined in file "ioctls.h" differently from other ioctls.
> The reason for this difference is explained in the comments above their definition.
> These ioctls didn't have defined thunk argument types before changes from this
> patch. They have special handling functions ("do_ioctl_SIOCGSTAMP" and
> "do_ioctl_SIOCGSTAMPNS") that take care of setting values for approppriate argument
> types (struct timeval and struct timespec) and thus no thunk argument types were
> needed for their implementation. But this patch adds those argument type definitions
> in file "syscall_types.h" and "ioctls.h" as it is needed for printing arguments
> of these ioctls with strace.
> 
> Implementation notes:
> 
>     There are two variants of these ioctls: SIOCGSTAMP_OLD/SIOCGSTAM_NEW and
>     SIOCGSTAMPNS_OLD/SIOCGSTAMPNS_NEW. One is the old existing definition and the
>     other is the 2038 safe variant used for 32-bit architectures. These variants
>     use types "struct timeval/timeval64" and "struct timespec/timespec64" respectively.
>     That is the reason why corresponding structure definitions were added in file
>     "syscall_types.h". STRUCT_timeval definition was already inside the file as
>     it is used by another implemented ioctl.
> 
> Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
> ---
>  linux-user/ioctls.h        | 12 ++++++++----
>  linux-user/syscall_types.h | 12 ++++++++++++
>  2 files changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
> index 0defa1d8c1..68d43f71cc 100644
> --- a/linux-user/ioctls.h
> +++ b/linux-user/ioctls.h
> @@ -279,13 +279,17 @@
>     * FIXME: create a macro to define this kind of entry
>     */
>    { TARGET_SIOCGSTAMP_OLD, TARGET_SIOCGSTAMP_OLD,
> -    "SIOCGSTAMP_OLD", IOC_R, do_ioctl_SIOCGSTAMP },
> +    "SIOCGSTAMP_OLD", IOC_R, do_ioctl_SIOCGSTAMP,
> +    { MK_PTR(MK_STRUCT(STRUCT_timeval)) } },
>    { TARGET_SIOCGSTAMPNS_OLD, TARGET_SIOCGSTAMPNS_OLD,
> -    "SIOCGSTAMPNS_OLD", IOC_R, do_ioctl_SIOCGSTAMPNS },
> +    "SIOCGSTAMPNS_OLD", IOC_R, do_ioctl_SIOCGSTAMPNS,
> +    { MK_PTR(MK_STRUCT(STRUCT_timespec)) } },
>    { TARGET_SIOCGSTAMP_NEW, TARGET_SIOCGSTAMP_NEW,
> -    "SIOCGSTAMP_NEW", IOC_R, do_ioctl_SIOCGSTAMP },
> +    "SIOCGSTAMP_NEW", IOC_R, do_ioctl_SIOCGSTAMP,
> +    { MK_PTR(MK_STRUCT(STRUCT_timeval64)) } },
>    { TARGET_SIOCGSTAMPNS_NEW, TARGET_SIOCGSTAMPNS_NEW,
> -    "SIOCGSTAMPNS_NEW", IOC_R, do_ioctl_SIOCGSTAMPNS },
> +    "SIOCGSTAMPNS_NEW", IOC_R, do_ioctl_SIOCGSTAMPNS,
> +    { MK_PTR(MK_STRUCT(STRUCT_timespec64)) } },
>  
>    IOCTL(RNDGETENTCNT, IOC_R, MK_PTR(TYPE_INT))
>    IOCTL(RNDADDTOENTCNT, IOC_W, MK_PTR(TYPE_INT))
> diff --git a/linux-user/syscall_types.h b/linux-user/syscall_types.h
> index 4e12c1661e..a5ad5a9ddc 100644
> --- a/linux-user/syscall_types.h
> +++ b/linux-user/syscall_types.h
> @@ -137,10 +137,22 @@ STRUCT(snd_timer_params,
>         TYPE_INT, /* filter */
>         MK_ARRAY(TYPE_CHAR, 60)) /* reserved */
>  
> +STRUCT(timeval,
> +       TYPE_LONG, /* tv_sec */
> +       TYPE_LONG) /* tv_usec */

You have to manage the case when tv_usec is int.
See linux-user/syscall_defs.h, target_timeval (and
target__kernel_sock_timeval)

> +
> +STRUCT(timeval64,
> +       TYPE_LONGLONG, /* tv_sec */
> +       TYPE_LONGLONG) /* tv_usec */

perhaps you could call this "target__kernel_sock_timeval" as it is in
linux-user/syscall_defs.h.

> +
>  STRUCT(timespec,
>         TYPE_LONG, /* tv_sec */
>         TYPE_LONG) /* tv_nsec */
>  
> +STRUCT(timespec64,
> +       TYPE_LONGLONG, /* tv_sec */
> +       TYPE_LONGLONG) /* tv_nsec */
> +

ditto: target__kernel_timespec

>  STRUCT(snd_timer_status,
>         MK_STRUCT(STRUCT_timespec), /* tstamp */
>         TYPE_INT, /* resolution */
> 


