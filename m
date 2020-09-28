Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17DAEC2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 22:00:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49FD421D7F
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 22:00:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49FD421D7F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netbsd.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kN1Br-0006BL-MA
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 18:00:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57912)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kamil@netbsd.org>) id 1kN16r-0004td-0E
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 17:55:01 -0400
Received: from mail.netbsd.org ([199.233.217.200]:61625)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kamil@netbsd.org>) id 1kN16m-0004a9-Rl
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 17:55:00 -0400
Received: from [IPv6:::1] (localhost [127.0.0.1])
 by mail.netbsd.org (Postfix) with ESMTP id E327784C71;
 Mon, 28 Sep 2020 21:54:48 +0000 (UTC)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200928131934.739451-1-philmd@redhat.com>
 <20200928131934.739451-8-philmd@redhat.com>
From: Kamil Rytarowski <kamil@netbsd.org>
Autocrypt: addr=kamil@netbsd.org; keydata=
 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
Subject: Re: [PATCH v2 7/8] qemu/bswap: Use compiler __builtin_bswap() on
 NetBSD
Message-ID: <dcb7bb1f-eaec-7039-1cbd-80e50d298707@netbsd.org>
Date: Mon, 28 Sep 2020 23:51:47 +0200
User-Agent: Mozilla/5.0 (X11; NetBSD amd64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200928131934.739451-8-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=199.233.217.200; envelope-from=kamil@netbsd.org;
 helo=mail.netbsd.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 17:54:52
X-ACL-Warn: Detected OS   = ???
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Fam Zheng <fam@euphon.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Kamil Rytarowski <kamil@netbsd.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 28.09.2020 15:19, Philippe Mathieu-Daudé wrote:
> Since commit efc6c070aca ("configure: Add a test for the minimum
> compiler version") the minimum compiler version required for GCC
> is 4.8, which supports __builtin_bswap().
> Remove the NetBSD specific ifdef'ry.
> 
> This reverts commit 1360677cfe3ca8f945fa1de77823df21a77e4500
> ("makes NetBSD use the native bswap functions").
> 

Personally, I prefer using the system headers. but if you want to use
the GCC builtins, please go for it.

> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  configure            | 15 ---------------
>  include/qemu/bswap.h |  5 -----
>  2 files changed, 20 deletions(-)
> 
> diff --git a/configure b/configure
> index bff787daea7..1b0a02a0af8 100755
> --- a/configure
> +++ b/configure
> @@ -4886,18 +4886,6 @@ if test "$docs" != "no" ; then
>    fi
>  fi
>  
> -# Search for bswap32 function
> -bswap_h=no
> -cat > $TMPC << EOF
> -#include <sys/endian.h>
> -#include <sys/types.h>
> -#include <machine/bswap.h>
> -int main(void) { return bswap32(0); }
> -EOF
> -if compile_prog "" "" ; then
> -  bswap_h=yes
> -fi
> -
>  ##########################################
>  # Do we have libiscsi >= 1.9.0
>  if test "$libiscsi" != "no" ; then
> @@ -6779,9 +6767,6 @@ fi
>  if test "$st_atim" = "yes" ; then
>    echo "HAVE_STRUCT_STAT_ST_ATIM=y" >> $config_host_mak
>  fi
> -if test "$bswap_h" = "yes" ; then
> -  echo "CONFIG_MACHINE_BSWAP_H=y" >> $config_host_mak
> -fi
>  if test "$curl" = "yes" ; then
>    echo "CONFIG_CURL=y" >> $config_host_mak
>    echo "CURL_CFLAGS=$curl_cflags" >> $config_host_mak
> diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
> index 1a297bfec22..7e586531c09 100644
> --- a/include/qemu/bswap.h
> +++ b/include/qemu/bswap.h
> @@ -3,17 +3,12 @@
>  
>  #include "fpu/softfloat-types.h"
>  
> -#ifdef CONFIG_MACHINE_BSWAP_H
> -# include <sys/endian.h>
> -# include <machine/bswap.h>
> -#else
>  #undef  bswap16
>  #define bswap16(_x) __builtin_bswap16(_x)
>  #undef  bswap32
>  #define bswap32(_x) __builtin_bswap32(_x)
>  #undef  bswap64
>  #define bswap64(_x) __builtin_bswap64(_x)
> -#endif /* ! CONFIG_MACHINE_BSWAP_H */
>  
>  static inline void bswap16s(uint16_t *s)
>  {
> 


