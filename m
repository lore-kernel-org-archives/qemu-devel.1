Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0BFBC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 20:29:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F0C320575
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 20:29:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KXSeahsb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F0C320575
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYy06-0003qe-NA
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 16:29:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53388)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jYxyn-0001oL-GH
 for qemu-devel@nongnu.org; Wed, 13 May 2020 16:27:49 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:40954
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jYxyl-0005IN-DZ
 for qemu-devel@nongnu.org; Wed, 13 May 2020 16:27:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589401666;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=fpOblpsChEVSwJJyQMeP1u1HXTIIEDuSAfSgT5ay+WI=;
 b=KXSeahsbiWOArjwdBGx/ALXAQnQkm0VJN7cFqNc6+x9JBeeQgZ/57dPpLq+B9AskUefS52
 msZtbkxBCHVINV14Wdpr+exOezy8KyrJXa/J/FCAvH9vQV1svp9GM21IVKYUsoYrZKWVlt
 zy5Bg91QwV1u82P6Jx8G6VPD/KJLn44=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-487-VX1liiW1NoasZ_SIzGVKfA-1; Wed, 13 May 2020 16:27:44 -0400
X-MC-Unique: VX1liiW1NoasZ_SIzGVKfA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 771CB835B49;
 Wed, 13 May 2020 20:27:43 +0000 (UTC)
Received: from [10.10.113.80] (ovpn-113-80.rdu2.redhat.com [10.10.113.80])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9CD3261541;
 Wed, 13 May 2020 20:27:38 +0000 (UTC)
Subject: Re: [PATCH] scripts/tracetool: Update maintainer email address
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200511082816.696-1-philmd@redhat.com>
From: John Snow <jsnow@redhat.com>
Autocrypt: addr=jsnow@redhat.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <9f05c462-8a1f-ac2f-ecc9-d3a1f71f328c@redhat.com>
Date: Wed, 13 May 2020 16:27:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200511082816.696-1-philmd@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 04:17:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-trivial@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 5/11/20 4:28 AM, Philippe Mathieu-Daudé wrote:
> There is an effort in progress to generate a QEMU Python
> package. As I'm not sure this old email is still valid,
> update it to not produce package with broken maintainer
> email.
> 
> Patch created mechanically by running:
> 
>  $ sed -i 's,\(__email__ *= "\)stefanha@linux.vnet.ibm.com",\1stefanha@redhat.com",' \
>          $(git grep -l 'email.*stefanha@linux.vnet.ibm.com')
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>

I hadn't started trying to move the tracetool yet, but this can't hurt :)

Reviewed-by: John Snow <jsnow@redhat.com>

> ---
>  scripts/tracetool.py                             | 2 +-
>  scripts/tracetool/__init__.py                    | 2 +-
>  scripts/tracetool/backend/__init__.py            | 2 +-
>  scripts/tracetool/backend/dtrace.py              | 2 +-
>  scripts/tracetool/backend/log.py                 | 2 +-
>  scripts/tracetool/backend/simple.py              | 2 +-
>  scripts/tracetool/backend/ust.py                 | 2 +-
>  scripts/tracetool/format/__init__.py             | 2 +-
>  scripts/tracetool/format/c.py                    | 2 +-
>  scripts/tracetool/format/d.py                    | 2 +-
>  scripts/tracetool/format/h.py                    | 2 +-
>  scripts/tracetool/format/stap.py                 | 2 +-
>  scripts/tracetool/format/tcg_h.py                | 2 +-
>  scripts/tracetool/format/tcg_helper_c.py         | 2 +-
>  scripts/tracetool/format/tcg_helper_h.py         | 2 +-
>  scripts/tracetool/format/tcg_helper_wrapper_h.py | 2 +-
>  scripts/tracetool/transform.py                   | 2 +-
>  scripts/tracetool/vcpu.py                        | 2 +-
>  18 files changed, 18 insertions(+), 18 deletions(-)
> 
> diff --git a/scripts/tracetool.py b/scripts/tracetool.py
> index 264cc9eecc..31146242b7 100755
> --- a/scripts/tracetool.py
> +++ b/scripts/tracetool.py
> @@ -10,7 +10,7 @@
>  __license__    = "GPL version 2 or (at your option) any later version"
>  
>  __maintainer__ = "Stefan Hajnoczi"
> -__email__      = "stefanha@linux.vnet.ibm.com"
> +__email__      = "stefanha@redhat.com"
>  
>  
>  import sys
> diff --git a/scripts/tracetool/__init__.py b/scripts/tracetool/__init__.py
> index 13d29f1e42..3ccfa1e116 100644
> --- a/scripts/tracetool/__init__.py
> +++ b/scripts/tracetool/__init__.py
> @@ -9,7 +9,7 @@
>  __license__    = "GPL version 2 or (at your option) any later version"
>  
>  __maintainer__ = "Stefan Hajnoczi"
> -__email__      = "stefanha@linux.vnet.ibm.com"
> +__email__      = "stefanha@redhat.com"
>  
>  
>  import re
> diff --git a/scripts/tracetool/backend/__init__.py b/scripts/tracetool/backend/__init__.py
> index 54cab2c4de..7bfcc86cc5 100644
> --- a/scripts/tracetool/backend/__init__.py
> +++ b/scripts/tracetool/backend/__init__.py
> @@ -50,7 +50,7 @@
>  __license__    = "GPL version 2 or (at your option) any later version"
>  
>  __maintainer__ = "Stefan Hajnoczi"
> -__email__      = "stefanha@linux.vnet.ibm.com"
> +__email__      = "stefanha@redhat.com"
>  
>  
>  import os
> diff --git a/scripts/tracetool/backend/dtrace.py b/scripts/tracetool/backend/dtrace.py
> index 638990db79..5711892ba0 100644
> --- a/scripts/tracetool/backend/dtrace.py
> +++ b/scripts/tracetool/backend/dtrace.py
> @@ -9,7 +9,7 @@
>  __license__    = "GPL version 2 or (at your option) any later version"
>  
>  __maintainer__ = "Stefan Hajnoczi"
> -__email__      = "stefanha@linux.vnet.ibm.com"
> +__email__      = "stefanha@redhat.com"
>  
>  
>  from tracetool import out
> diff --git a/scripts/tracetool/backend/log.py b/scripts/tracetool/backend/log.py
> index 23b274c0fd..877222bbe9 100644
> --- a/scripts/tracetool/backend/log.py
> +++ b/scripts/tracetool/backend/log.py
> @@ -9,7 +9,7 @@
>  __license__    = "GPL version 2 or (at your option) any later version"
>  
>  __maintainer__ = "Stefan Hajnoczi"
> -__email__      = "stefanha@linux.vnet.ibm.com"
> +__email__      = "stefanha@redhat.com"
>  
>  
>  from tracetool import out
> diff --git a/scripts/tracetool/backend/simple.py b/scripts/tracetool/backend/simple.py
> index b650c262b5..a74d61fcd6 100644
> --- a/scripts/tracetool/backend/simple.py
> +++ b/scripts/tracetool/backend/simple.py
> @@ -9,7 +9,7 @@
>  __license__    = "GPL version 2 or (at your option) any later version"
>  
>  __maintainer__ = "Stefan Hajnoczi"
> -__email__      = "stefanha@linux.vnet.ibm.com"
> +__email__      = "stefanha@redhat.com"
>  
>  
>  from tracetool import out
> diff --git a/scripts/tracetool/backend/ust.py b/scripts/tracetool/backend/ust.py
> index a772a3b53b..6c0a5f8d68 100644
> --- a/scripts/tracetool/backend/ust.py
> +++ b/scripts/tracetool/backend/ust.py
> @@ -9,7 +9,7 @@
>  __license__    = "GPL version 2 or (at your option) any later version"
>  
>  __maintainer__ = "Stefan Hajnoczi"
> -__email__      = "stefanha@linux.vnet.ibm.com"
> +__email__      = "stefanha@redhat.com"
>  
>  
>  from tracetool import out
> diff --git a/scripts/tracetool/format/__init__.py b/scripts/tracetool/format/__init__.py
> index aba2f7a441..2dc46f3dd9 100644
> --- a/scripts/tracetool/format/__init__.py
> +++ b/scripts/tracetool/format/__init__.py
> @@ -32,7 +32,7 @@
>  __license__    = "GPL version 2 or (at your option) any later version"
>  
>  __maintainer__ = "Stefan Hajnoczi"
> -__email__      = "stefanha@linux.vnet.ibm.com"
> +__email__      = "stefanha@redhat.com"
>  
>  
>  import os
> diff --git a/scripts/tracetool/format/c.py b/scripts/tracetool/format/c.py
> index 78af8aff72..23d82ea861 100644
> --- a/scripts/tracetool/format/c.py
> +++ b/scripts/tracetool/format/c.py
> @@ -9,7 +9,7 @@
>  __license__    = "GPL version 2 or (at your option) any later version"
>  
>  __maintainer__ = "Stefan Hajnoczi"
> -__email__      = "stefanha@linux.vnet.ibm.com"
> +__email__      = "stefanha@redhat.com"
>  
>  
>  from tracetool import out
> diff --git a/scripts/tracetool/format/d.py b/scripts/tracetool/format/d.py
> index d3980b914b..0afb5f3f47 100644
> --- a/scripts/tracetool/format/d.py
> +++ b/scripts/tracetool/format/d.py
> @@ -9,7 +9,7 @@
>  __license__    = "GPL version 2 or (at your option) any later version"
>  
>  __maintainer__ = "Stefan Hajnoczi"
> -__email__      = "stefanha@linux.vnet.ibm.com"
> +__email__      = "stefanha@redhat.com"
>  
>  
>  from tracetool import out
> diff --git a/scripts/tracetool/format/h.py b/scripts/tracetool/format/h.py
> index 83e1a2f355..e94f0be7da 100644
> --- a/scripts/tracetool/format/h.py
> +++ b/scripts/tracetool/format/h.py
> @@ -9,7 +9,7 @@
>  __license__    = "GPL version 2 or (at your option) any later version"
>  
>  __maintainer__ = "Stefan Hajnoczi"
> -__email__      = "stefanha@linux.vnet.ibm.com"
> +__email__      = "stefanha@redhat.com"
>  
>  
>  from tracetool import out
> diff --git a/scripts/tracetool/format/stap.py b/scripts/tracetool/format/stap.py
> index 8fc808f2ef..a218b0445c 100644
> --- a/scripts/tracetool/format/stap.py
> +++ b/scripts/tracetool/format/stap.py
> @@ -9,7 +9,7 @@
>  __license__    = "GPL version 2 or (at your option) any later version"
>  
>  __maintainer__ = "Stefan Hajnoczi"
> -__email__      = "stefanha@linux.vnet.ibm.com"
> +__email__      = "stefanha@redhat.com"
>  
>  
>  from tracetool import out
> diff --git a/scripts/tracetool/format/tcg_h.py b/scripts/tracetool/format/tcg_h.py
> index 0180e3d76c..33cf6a31b3 100644
> --- a/scripts/tracetool/format/tcg_h.py
> +++ b/scripts/tracetool/format/tcg_h.py
> @@ -9,7 +9,7 @@
>  __license__    = "GPL version 2 or (at your option) any later version"
>  
>  __maintainer__ = "Stefan Hajnoczi"
> -__email__      = "stefanha@linux.vnet.ibm.com"
> +__email__      = "stefanha@redhat.com"
>  
>  
>  from tracetool import out, Arguments
> diff --git a/scripts/tracetool/format/tcg_helper_c.py b/scripts/tracetool/format/tcg_helper_c.py
> index 6527b69afd..2db6317f3c 100644
> --- a/scripts/tracetool/format/tcg_helper_c.py
> +++ b/scripts/tracetool/format/tcg_helper_c.py
> @@ -9,7 +9,7 @@
>  __license__    = "GPL version 2 or (at your option) any later version"
>  
>  __maintainer__ = "Stefan Hajnoczi"
> -__email__      = "stefanha@linux.vnet.ibm.com"
> +__email__      = "stefanha@redhat.com"
>  
>  
>  from tracetool import Arguments, out
> diff --git a/scripts/tracetool/format/tcg_helper_h.py b/scripts/tracetool/format/tcg_helper_h.py
> index 98ebe52f18..08554fbc85 100644
> --- a/scripts/tracetool/format/tcg_helper_h.py
> +++ b/scripts/tracetool/format/tcg_helper_h.py
> @@ -9,7 +9,7 @@
>  __license__    = "GPL version 2 or (at your option) any later version"
>  
>  __maintainer__ = "Stefan Hajnoczi"
> -__email__      = "stefanha@linux.vnet.ibm.com"
> +__email__      = "stefanha@redhat.com"
>  
>  
>  from tracetool import out
> diff --git a/scripts/tracetool/format/tcg_helper_wrapper_h.py b/scripts/tracetool/format/tcg_helper_wrapper_h.py
> index 6adeab74df..0c5a9797d1 100644
> --- a/scripts/tracetool/format/tcg_helper_wrapper_h.py
> +++ b/scripts/tracetool/format/tcg_helper_wrapper_h.py
> @@ -9,7 +9,7 @@
>  __license__    = "GPL version 2 or (at your option) any later version"
>  
>  __maintainer__ = "Stefan Hajnoczi"
> -__email__      = "stefanha@linux.vnet.ibm.com"
> +__email__      = "stefanha@redhat.com"
>  
>  
>  from tracetool import out
> diff --git a/scripts/tracetool/transform.py b/scripts/tracetool/transform.py
> index 8fd4dcf20d..ea8b27799d 100644
> --- a/scripts/tracetool/transform.py
> +++ b/scripts/tracetool/transform.py
> @@ -9,7 +9,7 @@
>  __license__    = "GPL version 2 or (at your option) any later version"
>  
>  __maintainer__ = "Stefan Hajnoczi"
> -__email__      = "stefanha@linux.vnet.ibm.com"
> +__email__      = "stefanha@redhat.com"
>  
>  
>  def _transform_type(type_, trans):
> diff --git a/scripts/tracetool/vcpu.py b/scripts/tracetool/vcpu.py
> index 0b104e4f15..b54e4f4e7a 100644
> --- a/scripts/tracetool/vcpu.py
> +++ b/scripts/tracetool/vcpu.py
> @@ -10,7 +10,7 @@
>  __license__    = "GPL version 2 or (at your option) any later version"
>  
>  __maintainer__ = "Stefan Hajnoczi"
> -__email__      = "stefanha@linux.vnet.ibm.com"
> +__email__      = "stefanha@redhat.com"
>  
>  
>  from tracetool import Arguments, try_import
> 

-- 
—js


