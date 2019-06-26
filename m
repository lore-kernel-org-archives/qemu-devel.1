Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58106C48BD3
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 15:57:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 307C721743
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 15:57:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 307C721743
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgAJ0-00009L-FZ
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 11:57:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50547)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <laurent@vivier.eu>) id 1hgAIG-0007qd-J0
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 11:57:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1hgAIF-0006wD-IP
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 11:57:08 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:33707)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1hgAID-0006ox-6Y; Wed, 26 Jun 2019 11:57:05 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue011 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MlfL0-1iNViA3Jcw-00ijJb; Wed, 26 Jun 2019 17:56:36 +0200
To: Antonio Ospite <ao2@ao2.it>, qemu-devel@nongnu.org
References: <20190526144747.30019-1-ao2@ao2.it>
 <20190526144747.30019-2-ao2@ao2.it>
From: Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <180dd63a-fdce-419a-8b55-e2918f5e189d@vivier.eu>
Date: Wed, 26 Jun 2019 17:56:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190526144747.30019-2-ao2@ao2.it>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:4xLIkUFOj9xbBN0We6EksbK7D80ZPYT7lOF7tbIqa3DP+CwwdPO
 uEiKLNKUxazBmIf9DVxf6EY7JjPDQi+bB2h68jTjIfcuWecDlCCpU60P7fHgVrS/HsidjO6
 PF62KdLQgFxN7HuZK2RRgpnEQNs1Z6knsuYo8TKzPfHpSEc1Dmtx8thZmRNdkzj6Cem5Olf
 C5H1aj4cM3CXAvxHPb/6A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4OmvNQyiZ+E=:z5ZV5pPnOC+LlZLG5D9oyL
 56KydDklw34UOiKQgMyDPltt0KJHz+YxnOf95E1AOflsg8sKpBSSc06z1swDc/aAOCpLrd52r
 2BzWhlFqy2EtT27wInZTmrkrkEY24igwr97sr7mWxmdaTI8o0lVzRLxut0e055goBuNjsbhbq
 K0dg5+8izgLD621/FhGtFdRkJzvr6SL7YJYuXUbBzMlnd86poC8DDvOrMQ8vdIwfjU9I8kTYe
 /Cn+7S8Ph0RxPJp1EfcEMxr0Febax+F0pNsfUJFIAtuKvobKcxKoJu6GHVWDmYrKeAFoDOETZ
 lSzn+Nwmr4SZFxqRhdKp9ldUK0PhAURRYbuWrIu7PEoi1KWIzPBfGrsquARb9/Zchk36NEzhr
 igcoqjhpga8vwAvRxcNQKkwyJBof9LtMrhkCJQnKvNhFGJKtkB1hrwgeUVeckfZa02IUeFjG+
 EBiZXEugLaIc6muagQ1MRufZM7xVcBso3Fx8he9NrRyBxp9nQWwwld0wvCzV8aR4AnTSTxDFn
 KfJSs3NCwsIe82HO19K2L+JOUFUUjfVoR/3ajvinITkupRSuD7kNvc7i/b1lJ+T+pdzI0oAAZ
 Hq8nxZq2tpvjTX9d27IJM5pE9ynRFHemR6bkdb539xvkbPZCQPExAKkaDYIaaYLWeYvVfoe7J
 cQKriXqdVYUCZfNsxmRvZnfW/DGAU6vscEigjGUX78qBaCV2kZS9HI60TjlCEsMUXWb7i1wH5
 VVxXKWnllymAYsZ1WemriBKCnI1Lro+VubyeRyxSsDJqkMheA//pNaOssIM=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.130
Subject: Re: [Qemu-devel] [PATCH v3 1/2] configure: set source_path only
 once and make its definition more robust
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
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 Antonio Ospite <antonio.ospite@collabora.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 26/05/2019 à 16:47, Antonio Ospite a écrit :
> From: Antonio Ospite <antonio.ospite@collabora.com>
> 
> Since commit 79d77bcd36 (configure: Remove --source-path option,
> 2019-04-29) source_path cannot be overridden anymore, move it out of the
> "default parameters" block since the word "default" may suggest that the
> value can change, while in fact it does not.
> 
> While at it, only set source_path once and separate the positional
> argument of basename with "--" to more robustly cover the case of path
> names starting with a dash.
> 
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Antonio Ospite <antonio.ospite@collabora.com>
> ---
>  configure | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/configure b/configure
> index 528b9ff705..9f12120ad9 100755
> --- a/configure
> +++ b/configure
> @@ -276,10 +276,10 @@ ld_has() {
>      $ld --help 2>/dev/null | grep ".$1" >/dev/null 2>&1
>  }
>  
> -# default parameters
> -source_path=$(dirname "$0")
>  # make source path absolute
> -source_path=$(cd "$source_path"; pwd)
> +source_path=$(cd "$(dirname -- "$0")"; pwd)
> +
> +# default parameters
>  cpu=""
>  iasl="iasl"
>  interp_prefix="/usr/gnemul/qemu-%M"
> 

Applied to my trivial-patches branch.

Thanks,
Laurent


