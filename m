Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E544C432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 03:41:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7677E206E1
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 03:41:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=comstyle.com header.i=@comstyle.com header.b="g0Y+qijP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7677E206E1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=comstyle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iV60p-0001nL-BN
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 22:41:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47366)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <brad@comstyle.com>) id 1iV606-0001OQ-CQ
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 22:40:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <brad@comstyle.com>) id 1iV604-0002Hq-Uy
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 22:40:54 -0500
Received: from speedy.comstyle.com ([206.51.28.2]:45368 helo=mail.comstyle.com)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <brad@comstyle.com>) id 1iV604-0002Aj-O0
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 22:40:52 -0500
Received: from mail.comstyle.com (localhost [127.0.0.1])
 by mail.comstyle.com (Postfix) with ESMTP id 47D6Wx17nrz4glt;
 Wed, 13 Nov 2019 22:33:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=comstyle.com; h=subject:to
 :cc:references:from:message-id:date:mime-version:in-reply-to
 :content-type; s=selector1; bh=L1bHjLxb7iCyIuTzOCtPzBG/AGM=; b=g
 0Y+qijPeuPJqBP0fHkUWPv6/A89It0ImnmZ2mIkApEwYuA/gGK7A8rqyYvkMuGeT
 sIAp7jrdz7I7At6v5GE2QCYwwTSFOyHBI5+YkEbKcDhFEkohwcTgp2foc90gftjL
 gbSOVPdsYs4q4wzORe/NUY8Sz5fZ1Kb+rXAaZvddV4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=comstyle.com; h=subject:to
 :cc:references:from:message-id:date:mime-version:in-reply-to
 :content-type; q=dns; s=selector1; b=rIU2qGebE+JDM+P4KJTfjWrcp8F
 pJlmr9B4tQD1Y39eOFnbO8ISkQVJ+haMgQn1y9fTczabeBHh6O2+gm6ud7wC17Qr
 o9xeyvGtRG26smdZzkP5wkuwBPYasK2H9+y46Y1yAH4Ggq/o92EocXCQ72FKRJO+
 Cbu75EwMYKH74bfk=
Received: from [192.168.180.3] (toroon0812w-lp140-02-64-229-183-77.dsl.bell.ca
 [64.229.183.77])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested) (Authenticated sender: brad)
 by mail.comstyle.com (Postfix) with ESMTPSA id 47D6Wx073cz4gls;
 Wed, 13 Nov 2019 22:33:33 -0500 (EST)
Subject: Re: [PATCH] tests/vm: update openbsd to release 6.6
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20191018102443.26469-1-kraxel@redhat.com>
From: Brad Smith <brad@comstyle.com>
Message-ID: <ca7e9094-bb0b-08f5-7523-778f89c4b333@comstyle.com>
Date: Wed, 13 Nov 2019 22:33:55 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:71.0) Gecko/20100101
 Thunderbird/71.0
MIME-Version: 1.0
In-Reply-To: <20191018102443.26469-1-kraxel@redhat.com>
Content-Type: multipart/alternative;
 boundary="------------FB3AD1D146EA64ABEE21FC38"
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 206.51.28.2
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
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a multi-part message in MIME format.
--------------FB3AD1D146EA64ABEE21FC38
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Thanks.

Reviewed-by: Brad Smith <brad@comstyle.com>

On 10/18/2019 6:24 AM, Gerd Hoffmann wrote:
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>   tests/vm/openbsd | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tests/vm/openbsd b/tests/vm/openbsd
> index b92c39f89a6f..9f82cd459fde 100755
> --- a/tests/vm/openbsd
> +++ b/tests/vm/openbsd
> @@ -22,8 +22,8 @@ class OpenBSDVM(basevm.BaseVM):
>       name = "openbsd"
>       arch = "x86_64"
>   
> -    link = "https://cdn.openbsd.org/pub/OpenBSD/6.5/amd64/install65.iso"
> -    csum = "38d1f8cadd502f1c27bf05c5abde6cc505dd28f3f34f8a941048ff9a54f9f608"
> +    link = "https://cdn.openbsd.org/pub/OpenBSD/6.6/amd64/install66.iso"
> +    csum = "b22e63df56e6266de6bbeed8e9be0fbe9ee2291551c5bc03f3cc2e4ab9436ee3"
>       size = "20G"
>       pkgs = [
>           # tools

--------------FB3AD1D146EA64ABEE21FC38
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <pre>Thanks.

Reviewed-by: Brad Smith <a class="moz-txt-link-rfc2396E" href="mailto:brad@comstyle.com">&lt;brad@comstyle.com&gt;</a>
</pre>
    <div class="moz-cite-prefix">On 10/18/2019 6:24 AM, Gerd Hoffmann
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20191018102443.26469-1-kraxel@redhat.com">
      <pre class="moz-quote-pre" wrap="">Signed-off-by: Gerd Hoffmann <a class="moz-txt-link-rfc2396E" href="mailto:kraxel@redhat.com">&lt;kraxel@redhat.com&gt;</a>
---
 tests/vm/openbsd | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/vm/openbsd b/tests/vm/openbsd
index b92c39f89a6f..9f82cd459fde 100755
--- a/tests/vm/openbsd
+++ b/tests/vm/openbsd
@@ -22,8 +22,8 @@ class OpenBSDVM(basevm.BaseVM):
     name = "openbsd"
     arch = "x86_64"
 
-    link = <a class="moz-txt-link-rfc2396E" href="https://cdn.openbsd.org/pub/OpenBSD/6.5/amd64/install65.iso">"https://cdn.openbsd.org/pub/OpenBSD/6.5/amd64/install65.iso"</a>
-    csum = "38d1f8cadd502f1c27bf05c5abde6cc505dd28f3f34f8a941048ff9a54f9f608"
+    link = <a class="moz-txt-link-rfc2396E" href="https://cdn.openbsd.org/pub/OpenBSD/6.6/amd64/install66.iso">"https://cdn.openbsd.org/pub/OpenBSD/6.6/amd64/install66.iso"</a>
+    csum = "b22e63df56e6266de6bbeed8e9be0fbe9ee2291551c5bc03f3cc2e4ab9436ee3"
     size = "20G"
     pkgs = [
         # tools
</pre>
    </blockquote>
  </body>
</html>

--------------FB3AD1D146EA64ABEE21FC38--

