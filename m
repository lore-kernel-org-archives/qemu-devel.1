Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5453AC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 10:59:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2129F20888
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 10:59:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2129F20888
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeGGB-0001le-79
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 06:59:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49086)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jeGFd-0000uV-NA
 for qemu-devel@nongnu.org; Thu, 28 May 2020 06:59:05 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:40731)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jeGFc-0003oR-ET
 for qemu-devel@nongnu.org; Thu, 28 May 2020 06:59:05 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue011 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MYvse-1jZwly0VjE-00UuUX; Thu, 28 May 2020 12:58:54 +0200
Subject: Re: [PATCH] linux-user: implement OFD locks
To: Andreas Schwab <schwab@suse.de>, qemu-devel@nongnu.org
References: <mvm7dx0cun3.fsf@suse.de>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <b9149709-f248-b460-7415-80fd5caca307@vivier.eu>
Date: Thu, 28 May 2020 12:58:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <mvm7dx0cun3.fsf@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:l3BMyI82E0JnP1OMaOcDAUgk80D/sO+1oNEme2RUNWpQTqT9mgl
 qZbFYzKiznV1mD5vhFgHB11sat7CJYJDzWhRJFSlHXsgIIkKnG1MuVUS7xqiAXWAV7jOg9x
 MOkH870gGKbf5q75jxYMdRDtZtZGiYK7y8JzaZ+RzSBlpH5t7g6hPDSeIVVOThpmEowDwcu
 WwWlQA6xDs4D2DBAjtKgQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:k2hrEPchLJ8=:R9YZEnInOi3RA+RRLOwOiI
 k83jB/f9oN3xnqq54obTUPb0fIpVgxP7XHAkzbsnMMSc0/+CcBxGgGoPAH+Y1GxLnbMsJsG6N
 cuL+5lOMu8ueeY4oGTDrOQexeT2HorguCKiT312dFHSJPHkQDoqXyaDMRWT2zt86BbF/whh4q
 ZFlaeQob8bRhxV11pS5FKhWFx7AufeYsbULXtTXnRPVovf33WiA5ACdPJhM/rcvWjUr+SeWef
 eBFQJnnpZmjRSBf5Yt0+ieBfNDkFmI1FuCx8067turohj+lK9gphoaJ6P4ryHLGg5vPcYICps
 SS/DpoX6T0AXluIk3IvBOaCWijUecKjGqUw6sAd/NSTX7P3NvPzUf8LczRKSEqXXdyQvDjA81
 ANsb0sItQCGC4iu1lHcjTghSTIePN6qIrYobT3Z4f1kWAgz4nPOSTEJ67zG9UeOlXVjbpH1IP
 KaYZNpBplf6ka9MG+g28Vfd5FHQ9mmAcOlpbsnY35Ao9IkXqnI/zKn2pKQBBkDC++w4HdKVh6
 EH9Jm51KVJbi4PUyzBDCyyUKSgF3+WFOgQAkDA6A0caICSclDPv2YAJOMXtYVT399BsD77Pil
 hbsajzNFEr53dE9K5DRa6fOR+wZJRu8aOiXbo3JCINff7pm6mLlW2JOacjZd7u6vAtJ0+t2+U
 1E+bJ8KboUbyIww6h1UBnGluRWWfrbuFwnXX4KbL8hPCx3MzB5G4dGmrqsGastFkvM2qMDI13
 3YZGjxGHe+V6CbKTd/a2vVewIiVIae8w8pU293MJNVlK3Ul4e0VyaJQ4iJ5jwG61f25wN8aU9
 nNzRpHd62FTb7HuCqd4M3hF2HojHhbrk7ASH8Ys6siaMZ34UAz50FXxEZlaHu/SHREMBXpD
Received-SPF: none client-ip=212.227.126.134; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 05:54:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

Le 25/05/2020 à 09:59, Andreas Schwab a écrit :
> Signed-off-by: Andreas Schwab <schwab@suse.de>
> ---
>  linux-user/generic/fcntl.h | 4 ++++
>  linux-user/syscall.c       | 6 ++++++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/linux-user/generic/fcntl.h b/linux-user/generic/fcntl.h
> index 9f727d4df2..c85c5b9fed 100644
> --- a/linux-user/generic/fcntl.h
> +++ b/linux-user/generic/fcntl.h
> @@ -99,6 +99,10 @@
>  #define TARGET_F_SETLKW64      14
>  #endif
>  
> +#define TARGET_F_OFD_GETLK     36
> +#define TARGET_F_OFD_SETLK     37
> +#define TARGET_F_OFD_SETLKW    38
> +
>  #ifndef TARGET_F_SETOWN_EX
>  #define TARGET_F_SETOWN_EX     15
>  #define TARGET_F_GETOWN_EX     16
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 7eac6b7d47..492450e77d 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -6097,6 +6097,9 @@ static int target_to_host_fcntl_cmd(int cmd)
>      case TARGET_F_SETFD:
>      case TARGET_F_GETFL:
>      case TARGET_F_SETFL:
> +    case TARGET_F_OFD_GETLK:
> +    case TARGET_F_OFD_SETLK:
> +    case TARGET_F_OFD_SETLKW:
>          ret = cmd;
>          break;
>      case TARGET_F_GETLK:
> @@ -6382,6 +6385,7 @@ static abi_long do_fcntl(int fd, int cmd, abi_ulong arg)
>          break;
>  
>      case TARGET_F_GETLK64:
> +    case TARGET_F_OFD_GETLK:
>          ret = copy_from_user_flock64(&fl64, arg);
>          if (ret) {
>              return ret;
> @@ -6393,6 +6397,8 @@ static abi_long do_fcntl(int fd, int cmd, abi_ulong arg)
>          break;
>      case TARGET_F_SETLK64:
>      case TARGET_F_SETLKW64:
> +    case TARGET_F_OFD_SETLK:
> +    case TARGET_F_OFD_SETLKW:
>          ret = copy_from_user_flock64(&fl64, arg);
>          if (ret) {
>              return ret;
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

