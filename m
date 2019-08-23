Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AE8BC3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 12:54:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4B8A22CEC
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 12:54:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4B8A22CEC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i195b-0004oQ-30
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 08:54:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60926)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrezanin@redhat.com>) id 1i18rM-00017Y-49
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 08:40:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrezanin@redhat.com>) id 1i18rK-0007KP-Ub
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 08:40:03 -0400
Received: from 212-4-128-36.cust.selfnet.cz ([212.4.128.36]:52567
 helo=workimage.localdomain) by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <mrezanin@redhat.com>) id 1i18rK-0007JB-O9
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 08:40:02 -0400
Received: by workimage.localdomain (Postfix, from userid 1000)
 id C5A9117B400; Fri, 23 Aug 2019 14:32:41 +0200 (CEST)
Date: Fri, 23 Aug 2019 14:32:41 +0200
From: Miroslav Rezanina <mrezanin@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20190823123241.24rpnxvg4v76gcim@lws.brq.redhat.com>
References: <1566495734-23297-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1566495734-23297-1-git-send-email-pbonzini@redhat.com>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.4.128.36
Subject: Re: [Qemu-devel] [PATCH] modules-test: fix const cast
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
Cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org,
 peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 22, 2019 at 07:42:13PM +0200, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  tests/modules-test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/modules-test.c b/tests/modules-test.c
> index 3aef0e5..a8118e9 100644
> --- a/tests/modules-test.c
> +++ b/tests/modules-test.c
> @@ -4,7 +4,7 @@
>  static void test_modules_load(const void *data)
>  {
>      QTestState *qts;
> -    const char **args = data;
> +    const char **args = (const char **)data;
>  
>      qts = qtest_init(NULL);
>      qtest_module_load(qts, args[0], args[1]);
> -- 
> 1.8.3.1
> 
> 

Reviewed-by: Miroslav Rezanina <mrezanin@redhat.com>

