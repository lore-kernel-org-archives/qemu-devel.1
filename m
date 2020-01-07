Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E44A0C33C99
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 11:47:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A71622070E
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 11:47:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="STMIoIou"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A71622070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ionKr-0007BK-Ap
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 06:47:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40147)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1ion0N-00067g-Q9
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 06:26:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1ion0M-0007a2-Mo
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 06:26:35 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:36021
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ion0M-0007ZI-IE
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 06:26:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578396394;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=N3y6qe5/JHaMhEeKlFhhDLl52vVW/QTu+uNcjtsh3zg=;
 b=STMIoIoulkl5wYGfhJwUkfFzvtCsCMlF+XHu8PkVCAhEMolhUXIiFFpB06W2L6dMH6xKEe
 5EFz9PNlwyhcJvbVAn2D52C5bCfLazkYjyUW1zHthLXdB+rwyJtuhrRylGB51PXhqsvj8+
 NiZkw0eRFqcp97+oMfYB1GO+241a25Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-420-UjMRQ31QMEecTwI6wRDWKg-1; Tue, 07 Jan 2020 06:26:25 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C1CFFDB20;
 Tue,  7 Jan 2020 11:26:24 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-116.ams2.redhat.com [10.36.116.116])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BA0765C290;
 Tue,  7 Jan 2020 11:26:23 +0000 (UTC)
Subject: Re: [PATCH v1 30/59] util/module.c: remove unneeded label in
 module_load_file()
To: Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org
References: <20200106182425.20312-1-danielhb413@gmail.com>
 <20200106182425.20312-31-danielhb413@gmail.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <2d940fe2-0fbd-4db8-c5bf-1b5b44dffef9@redhat.com>
Date: Tue, 7 Jan 2020 12:26:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200106182425.20312-31-danielhb413@gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: UjMRQ31QMEecTwI6wRDWKg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06/01/2020 19.23, Daniel Henrique Barboza wrote:
> 'out' can be replaced by the apropriate return values set
> in 'ret' for each case.
> 
> CC: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
> ---
>  util/module.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/util/module.c b/util/module.c
> index e9fe3e5422..9b5453f878 100644
> --- a/util/module.c
> +++ b/util/module.c
> @@ -111,12 +111,10 @@ static int module_load_file(const char *fname)
>  
>      if (len <= suf_len || strcmp(&fname[len - suf_len], dsosuf)) {
>          /* wrong suffix */
> -        ret = -EINVAL;
> -        goto out;
> +        return -EINVAL;
>      }
>      if (access(fname, F_OK)) {
> -        ret = -ENOENT;
> -        goto out;
> +        return -ENOENT;
>      }
>  
>      assert(QTAILQ_EMPTY(&dso_init_list));
> @@ -125,8 +123,7 @@ static int module_load_file(const char *fname)
>      if (!g_module) {
>          fprintf(stderr, "Failed to open module: %s\n",
>                  g_module_error());
> -        ret = -EINVAL;
> -        goto out;
> +        return -EINVAL;
>      }
>      if (!g_module_symbol(g_module, DSO_STAMP_FUN_STR, (gpointer *)&sym)) {
>          fprintf(stderr, "Failed to initialize module: %s\n",
> @@ -151,7 +148,7 @@ static int module_load_file(const char *fname)
>          QTAILQ_REMOVE(&dso_init_list, e, node);
>          g_free(e);
>      }
> -out:
> +
>      return ret;
>  }
>  #endif
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>


