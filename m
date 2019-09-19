Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38924C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 09:58:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D3E121927
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 09:58:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D3E121927
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAtDC-0005Rv-6O
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 05:58:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48394)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iAtCM-0004aK-6l
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 05:58:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iAtCL-0003II-5D
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 05:58:02 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:40613)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1iAtCI-0003GD-KN; Thu, 19 Sep 2019 05:57:58 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MKKd7-1iUuOF2pln-00Lpqk; Thu, 19 Sep 2019 11:57:52 +0200
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20190903120555.7551-1-philmd@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <265d9140-9bfc-0acf-3201-ff5dff8d5340@vivier.eu>
Date: Thu, 19 Sep 2019 11:57:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190903120555.7551-1-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:C2KAe9luv/mrmrFAsx4kjVQIIPioeSiXsuO3EpZLuC0zltdBeoL
 9VqUFp7Vi554nL0MJ1XKaXQufVBMg8LeZu7Bjf2hTHtbQTiYTw2F+nfgiy0xWnMPy03Auzh
 ksb633+LAvo57wgEqmuJ1Hw2Nlf3Pvv/zy4mlBeDGdtdIfe9e2elJ7FUovD9UdLGMh1QoQ3
 iDICdoimPent0lSgAhbmw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hwxw3QqKmY4=:XwBHh4NbEFuAREdhqGrS2z
 CPRyG1+nopVPwyDcrrQ71VwNxH4lvMORUPxWHP64kPw1g+MXa1/vYoTorHjpZWtJfeGXpScm7
 yawWkcdkCIxHV6sU+iO2onf68jyXteM9CvfFWQNE1lK5/9Vs2b2yJ4Aio4Ewg2fpkMo8XwonG
 tBzwXHa4yblI5wXOm19Q/NauWDl/0CPDtYOhC2KrDrINyLt3U1nrw0iAzyTw/+qWQrMk7UFXo
 eQB75ZDAas0iIuP+MulHBSxtFyHyrIsJLywlyGFddiDxHGebE4UNwu+85v0NZikTtn9NFjxa0
 jqmoS+VQb9e+y3FStUeR8ZwUu03vunT1Mvfz2gWARglRsOeDwacToDRVDLMlRZPfSLv0LVda9
 MKvFmTXTdMBVDQXC8MwB1b/NgSLHnFdzdpKHAuPW4NSUTNmenHjJBzZlEfB+cIMd9sNKz/PYh
 ot3ELMugU2w4KEphsxBc3FQTYmotzQ/uCPPDN16/JsCVNYEwiDD3mCMtxz6YMBgBZtxzqZF5X
 +w1xYZ00dq9AnD6idZxBwWtJseQs/rySFXnejXenfgHGcQG1Tb86PLwE8RdTdVhB0FVYk9GMP
 Nt8J71nqa7Wb9MvHRj+UgAfVT16i4NJfTXpdJqUh2Sts19dcbTHuFtEvszANtpaP5+Gy3K+53
 IhniErRxK6HjcXSc/cj4XwvvzYrnWGCA6UzamCMmwTSvC+BaYJbXaVLXGCJVAuAzw4WF3cCUd
 qOZNw43dMNBH0DuJhZMRtPEraMxEgs+FAOqpErVoOWy03qznQZREpzhQ8871C8oS/Mdr2GPrW
 YC2kg0YH6jcS3BuQvi8lL418YuFUCZXe8Qq7gVHQp6A1EioTd/PAgk2ceT6d6OqGPjzkMkYKh
 lEWkdRGrK0kSGyDp79qXVUb/1G/6pdz6X3AmGR2UM=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.24
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] cutils: Move size_to_str()
 from "qemu-common.h" to "qemu/cutils.h"
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 qemu-trivial@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Peter Xu <peterx@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 03/09/2019 à 14:05, Philippe Mathieu-Daudé a écrit :
> "qemu/cutils.h" contains various qemu_strtosz_*() functions
> useful to convert strings to size. It seems natural to have
> the opposite usage (from size to string) there too.
> 
> The function definition is already in util/cutils.c.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
> There are only 5 users, is it worthwhile renaming it qemu_sztostrt()?
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  block/qapi.c                 | 2 +-
>  include/qemu-common.h        | 1 -
>  include/qemu/cutils.h        | 2 ++
>  qapi/string-output-visitor.c | 2 +-
>  4 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/block/qapi.c b/block/qapi.c
> index 15f1030264..7ee2ee065d 100644
> --- a/block/qapi.c
> +++ b/block/qapi.c
> @@ -23,7 +23,7 @@
>   */
>  
>  #include "qemu/osdep.h"
> -#include "qemu-common.h"
> +#include "qemu/cutils.h"
>  #include "block/qapi.h"
>  #include "block/block_int.h"
>  #include "block/throttle-groups.h"
> diff --git a/include/qemu-common.h b/include/qemu-common.h
> index 0235cd3b91..8d84db90b0 100644
> --- a/include/qemu-common.h
> +++ b/include/qemu-common.h
> @@ -123,7 +123,6 @@ void qemu_hexdump(const char *buf, FILE *fp, const char *prefix, size_t size);
>  int parse_debug_env(const char *name, int max, int initial);
>  
>  const char *qemu_ether_ntoa(const MACAddr *mac);
> -char *size_to_str(uint64_t val);
>  void page_size_init(void);
>  
>  /* returns non-zero if dump is in progress, otherwise zero is
> diff --git a/include/qemu/cutils.h b/include/qemu/cutils.h
> index 12301340a4..b54c847e0f 100644
> --- a/include/qemu/cutils.h
> +++ b/include/qemu/cutils.h
> @@ -155,6 +155,8 @@ int qemu_strtosz(const char *nptr, const char **end, uint64_t *result);
>  int qemu_strtosz_MiB(const char *nptr, const char **end, uint64_t *result);
>  int qemu_strtosz_metric(const char *nptr, const char **end, uint64_t *result);
>  
> +char *size_to_str(uint64_t val);
> +
>  /* used to print char* safely */
>  #define STR_OR_NULL(str) ((str) ? (str) : "null")
>  
> diff --git a/qapi/string-output-visitor.c b/qapi/string-output-visitor.c
> index 7ab64468d9..0d93605d77 100644
> --- a/qapi/string-output-visitor.c
> +++ b/qapi/string-output-visitor.c
> @@ -11,7 +11,7 @@
>   */
>  
>  #include "qemu/osdep.h"
> -#include "qemu-common.h"
> +#include "qemu/cutils.h"
>  #include "qapi/string-output-visitor.h"
>  #include "qapi/visitor-impl.h"
>  #include "qemu/host-utils.h"
> 

Applied to my trivial-patches branch.

Thanks,
Laurent

