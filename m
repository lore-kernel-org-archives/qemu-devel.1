Return-Path: <SRS0=e36u=CI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80385C433E2
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2020 19:50:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AACA20757
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2020 19:50:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AACA20757
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCTL6-0003xD-EZ
	for qemu-devel@archiver.kernel.org; Sun, 30 Aug 2020 15:50:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38520)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kCTJy-0002Xb-Rg; Sun, 30 Aug 2020 15:48:59 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:48911)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kCTJw-00070T-Ne; Sun, 30 Aug 2020 15:48:58 -0400
Received: from [192.168.100.1] ([82.252.135.186]) by mrelayeu.kundenserver.de
 (mreue010 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MRmwM-1k28GV2xli-00TD13; Sun, 30 Aug 2020 21:48:53 +0200
Subject: Re: [PATCH] linux-user: Add strace support for printing OFD fcntl
 operations
To: Mike Gelfand <mikedld@mikedld.com>, qemu-devel@nongnu.org
References: <20200830092242.31506-1-mikedld@mikedld.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <b832edf4-966b-3ac3-39e1-df57dc2f958c@vivier.eu>
Date: Sun, 30 Aug 2020 21:48:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200830092242.31506-1-mikedld@mikedld.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:FTfcmPvHmdGDoZa3seVZIVI9OkfYwYwlbr99rsOae7o3M0G8cyB
 hAJAQ7eSE7y/RSSnDoXJCKx/ZTAbh1MmyppPHa6o58jXrOicCjEIKj3vfvP8uo7CltI5MfJ
 xwL7JQMoJA23lhV1M630DFeumEvNQB7ykDW9CPC8gu37YaOFCe8X2V9wb57Cv3dGGDbDVH/
 UU1OQg5MClcBDlEotOE4g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+MdfIVKSGfs=:MbCXnxiDiH109HnXySQzqZ
 O08FrPmNBtpHyRkke1uE6gAmH4yApvEuDDzNayzqsuZlqPR+Xj1nTsxMXz2UdHQTgM7TIHi3F
 vl9aXTfvjYxv0TAZk/wrhcAfWxabEp+3iO5bsmQ+5QMwp9cQnmxwnx2iJCaCXSTiso4ZMZfsU
 QbvvRKP4om3qsA8VoDfMZCkSs1l2JKWCi5ZGmwCfOJPiGBREXlwe4AxXf41EMOtRSkzRu80Mx
 LZEKEh5ZJBIJyBhOKQafktqfNKxDlGVl+lufU+xbGjoojyF9C/k9KyTfSGUerFQpgw+Me1wg5
 W1ZQaGC0fhvxOv+o5gRmfPELS9bFEfEV0W2FiwgrtZ6Qa6OKkVL6ZwhKiRQZCukKbxCp2ooa1
 yb8/rIiRSswTxWMHfroF/vBME2E3D8+ras0odWnVQUf3kCvVd2YERLf+AcooXgplWVcvKELpu
 WB9pu+FbbOBcz+C1ilekZB7SOGw5ceOPevwd/kLLfgi6jOnbCRIteIVYl7EEsvCXZuLmjzPne
 ezvSFJYa5Lz8E8vLQx51u0rD8chWUg6DbZEf7vfmYyYJ5LzmUA/XB/zK51sg/l21I80YFZXDk
 3ZqO8iIhtBB0Dsn/H8zqHHoeRzf4KdoJN0OkvYIUpSKLPZns523RqH6xSR0RuUp4HU4DSH7b+
 JEXU5nIzbknnOO8RbT9g8fnPNdyTvdQP6uRUmzkTIhtFe4nQcNcFXZx/ztQPjKHK7YYJPVwbN
 HBK1NUVMpQj74Ujx4pMhzm2PUJ9a5GF1pfpx1BpRJ5mz30xP9ePr3PXnSIJepbpyyatfxog+G
 A8YJOQIwbp4VePeaVsy5FllB2im9VjLYuJfumxwhBNxf6YVP6kipLKQJuUqP4DpwecKNgYs
Received-SPF: none client-ip=212.227.126.131; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/30 15:48:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.207,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: qemu-trivial@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 30/08/2020 à 11:22, Mike Gelfand a écrit :
> Signed-off-by: Mike Gelfand <mikedld@mikedld.com>
> ---
>  linux-user/strace.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/linux-user/strace.c b/linux-user/strace.c
> index 4f77b0cf76..11fea14fba 100644
> --- a/linux-user/strace.c
> +++ b/linux-user/strace.c
> @@ -2056,6 +2056,18 @@ print_fcntl(void *cpu_env, const struct syscallname *name,
>          print_pointer(arg2, 1);
>          break;
>  #endif
> +    case TARGET_F_OFD_GETLK:
> +        qemu_log("F_OFD_GETLK,");
> +        print_pointer(arg2, 1);
> +        break;
> +    case TARGET_F_OFD_SETLK:
> +        qemu_log("F_OFD_SETLK,");
> +        print_pointer(arg2, 1);
> +        break;
> +    case TARGET_F_OFD_SETLKW:
> +        qemu_log("F_OFD_SETLKW,");
> +        print_pointer(arg2, 1);
> +        break;
>      case TARGET_F_SETLEASE:
>          qemu_log("F_SETLEASE,");
>          print_raw_param(TARGET_ABI_FMT_ld, arg2, 0);
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

