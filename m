Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B0DC432C3
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 01:06:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F9B32073F
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 01:06:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F9B32073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZ2pk-0004AL-Hw
	for qemu-devel@archiver.kernel.org; Sun, 24 Nov 2019 20:06:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39045)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tao3.xu@intel.com>) id 1iZ2p2-0003YC-9r
 for qemu-devel@nongnu.org; Sun, 24 Nov 2019 20:05:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tao3.xu@intel.com>) id 1iZ2p0-0007sO-BL
 for qemu-devel@nongnu.org; Sun, 24 Nov 2019 20:05:47 -0500
Received: from mga09.intel.com ([134.134.136.24]:19133)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1iZ2p0-0007mk-1v
 for qemu-devel@nongnu.org; Sun, 24 Nov 2019 20:05:46 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 24 Nov 2019 17:05:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,239,1571727600"; d="scan'208";a="205950853"
Received: from txu2-mobl.ccr.corp.intel.com (HELO [10.239.197.13])
 ([10.239.197.13])
 by fmsmga008.fm.intel.com with ESMTP; 24 Nov 2019 17:05:35 -0800
Subject: Re: [PATCH v17 01/14] util/cutils: Add Add qemu_strtold and
 qemu_strtold_finite
To: "armbru@redhat.com" <armbru@redhat.com>
References: <20191122074826.1373-1-tao3.xu@intel.com>
 <20191122074826.1373-2-tao3.xu@intel.com>
From: Tao Xu <tao3.xu@intel.com>
Message-ID: <8088b091-8f7c-a637-6333-e7c40935974f@intel.com>
Date: Mon, 25 Nov 2019 09:05:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191122074826.1373-2-tao3.xu@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.24
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
Cc: "lvivier@redhat.com" <lvivier@redhat.com>,
 "thuth@redhat.com" <thuth@redhat.com>, "Du, Fan" <fan.du@intel.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "sw@weilnetz.de" <sw@weilnetz.de>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "mdroth@linux.vnet.ibm.com" <mdroth@linux.vnet.ibm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Liu,
 Jingqi" <jingqi.liu@intel.com>, "imammedo@redhat.com" <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Markus,

Do you have any comments on this patch and 02/14 05/14 06/14.
Thank you!

On 11/22/2019 3:48 PM, Xu, Tao3 wrote:
> Work like qemu_strtod() and qemu_strtold_finite, except store long
> double.
> 
> Signed-off-by: Tao Xu <tao3.xu@intel.com>
> ---
> 
> No changes in v17.
> ---
>   include/qemu/cutils.h |  3 +++
>   util/cutils.c         | 48 ++++++++++++++++++++++++++++++++++++++++++-
>   2 files changed, 50 insertions(+), 1 deletion(-)
> 
> diff --git a/include/qemu/cutils.h b/include/qemu/cutils.h
> index b54c847e0f..48cf9bf776 100644
> --- a/include/qemu/cutils.h
> +++ b/include/qemu/cutils.h
> @@ -146,6 +146,9 @@ int qemu_strtou64(const char *nptr, const char **endptr, int base,
>                     uint64_t *result);
>   int qemu_strtod(const char *nptr, const char **endptr, double *result);
>   int qemu_strtod_finite(const char *nptr, const char **endptr, double *result);
> +int qemu_strtold(const char *nptr, const char **endptr, long double *result);
> +int qemu_strtold_finite(const char *nptr, const char **endptr,
> +                        long double *result);
>   
>   int parse_uint(const char *s, unsigned long long *value, char **endptr,
>                  int base);
> diff --git a/util/cutils.c b/util/cutils.c
> index fd591cadf0..5db3b2add5 100644
> --- a/util/cutils.c
> +++ b/util/cutils.c
> @@ -553,7 +553,7 @@ int qemu_strtou64(const char *nptr, const char **endptr, int base,
>   
>   /**
>    * Convert string @nptr to a double.
> -  *
> + *
>    * This is a wrapper around strtod() that is harder to misuse.
>    * Semantics of @nptr and @endptr match strtod() with differences
>    * noted below.
> @@ -616,6 +616,52 @@ int qemu_strtod_finite(const char *nptr, const char **endptr, double *result)
>       return ret;
>   }
>   
> +/*
> + * Convert string @nptr to a long double.
> + *
> + * Works like qemu_strtod(), except it stores long double.
> + */
> +int qemu_strtold(const char *nptr, const char **endptr, long double *result)
> +{
> +    char *ep;
> +
> +    if (!nptr) {
> +        if (endptr) {
> +            *endptr = nptr;
> +        }
> +        return -EINVAL;
> +    }
> +
> +    errno = 0;
> +    *result = strtold(nptr, &ep);
> +    return check_strtox_error(nptr, ep, endptr, errno);
> +}
> +
> +/*
> + * Convert string @nptr to a finite long double.
> + *
> + * Works like qemu_strtod_finite(), except it stores long double.
> + */
> +int qemu_strtold_finite(const char *nptr, const char **endptr,
> +                        long double *result)
> +{
> +    long double tmp;
> +    int ret;
> +
> +    ret = qemu_strtold(nptr, endptr, &tmp);
> +    if (!ret && !isfinite(tmp)) {
> +        if (endptr) {
> +            *endptr = nptr;
> +        }
> +        ret = -EINVAL;
> +    }
> +
> +    if (ret != -EINVAL) {
> +        *result = tmp;
> +    }
> +    return ret;
> +}
> +
>   /**
>    * Searches for the first occurrence of 'c' in 's', and returns a pointer
>    * to the trailing null byte if none was found.
> 


