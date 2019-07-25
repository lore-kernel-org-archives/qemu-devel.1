Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B6FC76191
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 09:41:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92C2222BE8
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 09:41:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92C2222BE8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqaFB-00053d-TO
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 05:41:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41005)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <laurent@vivier.eu>) id 1hqaF2-0004fG-Fs
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 05:40:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1hqaF1-0001Jp-F9
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 05:40:52 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:53961)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hqaF1-0001JS-6Q
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 05:40:51 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1M8QBa-1hmANv2ZyC-004QK5; Thu, 25 Jul 2019 11:40:35 +0200
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
References: <1563977563-29715-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1563977563-29715-4-git-send-email-aleksandar.markovic@rt-rk.com>
From: Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <9855d23e-2c7f-4a91-e60d-67f513bc05cb@vivier.eu>
Date: Thu, 25 Jul 2019 11:40:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1563977563-29715-4-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:YgtU+BEG6jEBnCesV1OAq6OE6S8YnPcSkF8LjNLb8kRZOCi/fcf
 vFaAaCCADYaEpVYuIIBgdjMia153ZddFpHeQhXJ5fSPhxcZ/5QQJNqIUzKYxSkj6KFot64e
 7Q4bFqEAl6m5ZxuIZwhJ70IvnPkUp7GzH68jajIv698cHZ/EgS3adB0QogWGnzVwoepcU1+
 lruHtlY1JK8/9vUyoCumA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hityFt6DGds=:iZSEt0QJUd9Nx1rKvG6mC3
 1Z5ZCf13p0bVVDcmTaSzg+4xc7hjeQP7i1cJUL5Aat2nVY5OykNGxjBGCGoIRuw/bhyAtnKQ7
 cHPl1XJ6/jr5R48iYmvewbKJQUGkQzj2rjA8NPhSQouhjcC6I8q/FuYCGbNSxfShB/u0ThSsI
 CyAE+37gIWPwaP1aAEnwbhnRpy5LYkYqsDiYe0PHBW7GvXbcD64WGGweIxqjFGBrSRTx/w+ly
 f7uraFRsTqjadTgINrxSIHio361ZDgJ335dQDMDAXSxG+d/svNiIhuMJwjlSZTfPkFlAjOGc6
 CDKFcs8wmHFuI6kn+tx6Cx5Qm3M+fS9bNRvNqL9K0RsceZD3oE2rneTN4VjNHIVKME3n4MS0R
 XpbUwzajNfH0Fh1FE+dMs/IVRo5hv6Ify+H2zQQj4cm+m7TQKkE8iFBc+/ubuf4O3qAWKp2h0
 LsOtjMlH/860be4RmKV40VTF+DiKDhnkCXUl9Z/k+5AwbBZo9SwlSxNTsBiVFGKunsqRlfBtG
 R01sIF4wwbbW5MFb6oF9QZBfTKKJRpV6Q8HMoGKgkHNwPgaHuMoK38OLT71x1GczzXizY63QM
 F1ij5nimL/blneFq27nMKo+g8fBYkMBn+WgjQ2u+R0GIzJ3t1CW3FafBMI77AqcQMSArX2BT4
 +nSmoxp1oOm3fcwTyPY31wulIyktdVs54gl+A/xYBXFxFENyYLa+6S6AOEODTzOF/RX0tV3Sb
 ZvaODWVUSHu5xDjKcMHNWoIFruak382JAyC7lNSVGOxlp9WxnEILkACGENQ=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.74
Subject: Re: [Qemu-devel] [PATCH for 4.2 3/3] linux-user: Add support for
 RNDRESEEDCRNG ioctl
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
Cc: amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 24/07/2019 à 16:12, Aleksandar Markovic a écrit :
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
> 
> RNDRESEEDCRNG is a newer ioctl (added in mid-2018 in kernel), and
> "ifdef" guard is used for that reason in this patch.

since kernel 4.17

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

> 
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  linux-user/ioctls.h       | 3 +++
>  linux-user/syscall_defs.h | 1 +
>  2 files changed, 4 insertions(+)
> 
> diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
> index 7fac4fc..4264ff5 100644
> --- a/linux-user/ioctls.h
> +++ b/linux-user/ioctls.h
> @@ -233,6 +233,9 @@
>    IOCTL(RNDADDTOENTCNT, IOC_W, MK_PTR(TYPE_INT))
>    IOCTL(RNDZAPENTCNT, 0, TYPE_NULL)
>    IOCTL(RNDCLEARPOOL, 0, TYPE_NULL)
> +#ifdef RNDRESEEDCRNG
> +  IOCTL(RNDRESEEDCRNG, 0, TYPE_NULL)
> +#endif
>  
>    IOCTL(CDROMPAUSE, 0, TYPE_NULL)
>    IOCTL(CDROMSTART, 0, TYPE_NULL)
> diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
> index 61c2f3c..bc3f52b 100644
> --- a/linux-user/syscall_defs.h
> +++ b/linux-user/syscall_defs.h
> @@ -824,6 +824,7 @@ struct target_pollfd {
>  #define TARGET_RNDADDTOENTCNT  TARGET_IOW('R', 0x01, int)
>  #define TARGET_RNDZAPENTCNT    TARGET_IO('R', 0x04)
>  #define TARGET_RNDCLEARPOOL    TARGET_IO('R', 0x06)
> +#define TARGET_RNDRESEEDCRNG   TARGET_IO('R', 0x07)
>  
>  /* From <linux/fs.h> */
>  
> 


