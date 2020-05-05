Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02DEDC47254
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 16:01:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4049206A4
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 16:01:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BQJXVK9A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4049206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jW00W-0000OI-TA
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 12:01:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52596)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jVzyy-0007rW-G3
 for qemu-devel@nongnu.org; Tue, 05 May 2020 11:59:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55166
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jVzyx-0005AL-50
 for qemu-devel@nongnu.org; Tue, 05 May 2020 11:59:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588694381;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h2b/5nTnyap0EYt2+CldYLCkCZjlMmySgAJZA8L4he4=;
 b=BQJXVK9AKPNEUBYuADclUAPAbsefCpmHgk9/zdMewGGMIl/KMhbLwpr7FdneJkZNc2eBnL
 5jjWtWUFfuVH9BhQddcLBqo1XuLEdYiWuDGYoxjnRmoccokkv1oMFSEy0BVh3mpDERUf/T
 0fzvi+0HOSeAnotdBhF2qJJwSYv6Bio=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-193-zy8Ef1Y0OEKO0f_2J5mCZA-1; Tue, 05 May 2020 11:59:39 -0400
X-MC-Unique: zy8Ef1Y0OEKO0f_2J5mCZA-1
Received: by mail-wr1-f72.google.com with SMTP id q13so1431449wrn.14
 for <qemu-devel@nongnu.org>; Tue, 05 May 2020 08:59:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=h2b/5nTnyap0EYt2+CldYLCkCZjlMmySgAJZA8L4he4=;
 b=Oe24FwaYp7vUhnsO+phrUg790vcm8Tl5nqPU/uvvZyniZYjYt9ycfkhVWySIpPbhXP
 RKFDECKXyJEqwTJjGXBSt5HVSw+HNYobCRtD7tvvuCJfNF9fyJjMFWaiwry/MJHxVjTj
 T6T8YjR7JAJKaNC5tNFB6iGpFBo1oUY30oYlrxEhIB13r3UobJYWbKkspbp7DwWh5bfz
 8ST32rixhAnJu5pbcAMY5XGzC4fuSH2IuGru4uqigxFIfJ8Pd0Pi8AF5mlUuvVimr0Fz
 cjpMu1IFeJB1Ep6KHkWT9knBUNbSOd9cTPMA29xxUQmNKt94Tff79Sh44ZfSNALLUiCv
 ugaA==
X-Gm-Message-State: AGi0PuYMj67x5phrKnfnjuf1hRkhYOk4bG2ssAfHWJCo0UK6Pce5r3jn
 6KVAad2Km1fhT7rHfKdA0nDP5D3KzvIl0t7gLUxMWZ8s6r93+x56IFyN2qbzMHzTxDk5Qv9TsOu
 iW6Hw26tDnfXOj08=
X-Received: by 2002:a1c:1dc3:: with SMTP id d186mr3994016wmd.90.1588694376828; 
 Tue, 05 May 2020 08:59:36 -0700 (PDT)
X-Google-Smtp-Source: APiQypK6PcK/nc80w54JzMtuxZv25eKjZmpcFleTOkVsuHnK16qaiKyacOOqbVKcbp8icKoIcMSuuQ==
X-Received: by 2002:a1c:1dc3:: with SMTP id d186mr3993990wmd.90.1588694376580; 
 Tue, 05 May 2020 08:59:36 -0700 (PDT)
Received: from [192.168.1.38] (26.red-88-21-207.staticip.rima-tde.net.
 [88.21.207.26])
 by smtp.gmail.com with ESMTPSA id x5sm3557998wro.12.2020.05.05.08.59.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 May 2020 08:59:35 -0700 (PDT)
Subject: Re: [PATCH v2 04/18] qom: Simplify object_property_get_enum()
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200505152926.18877-1-armbru@redhat.com>
 <20200505152926.18877-5-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <fb6ea8af-ca83-661b-d708-4648acb3afc5@redhat.com>
Date: Tue, 5 May 2020 17:59:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200505152926.18877-5-armbru@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 00:37:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: pbonzini@redhat.com, berrange@redhat.com, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/5/20 5:29 PM, Markus Armbruster wrote:
> Reuse object_property_get_str().  Switches from the string to the
> qobject visitor under the hood.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   qom/object.c | 11 ++---------
>   1 file changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/qom/object.c b/qom/object.c
> index 3d65658059..b374af302c 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -1521,8 +1521,6 @@ typedef struct EnumProperty {
>   int object_property_get_enum(Object *obj, const char *name,
>                                const char *typename, Error **errp)
>   {
> -    Error *err = NULL;
> -    Visitor *v;
>       char *str;
>       int ret;
>       ObjectProperty *prop = object_property_find(obj, name, errp);
> @@ -1541,15 +1539,10 @@ int object_property_get_enum(Object *obj, const char *name,
>   
>       enumprop = prop->opaque;
>   
> -    v = string_output_visitor_new(false, &str);
> -    object_property_get(obj, v, name, &err);
> -    if (err) {
> -        error_propagate(errp, err);
> -        visit_free(v);
> +    str = object_property_get_str(obj, name, errp);
> +    if (!str) {

Patch looks good but I'm not confident enough to add a R-b tag :)

>           return 0;
>       }
> -    visit_complete(v, &str);
> -    visit_free(v);
>   
>       ret = qapi_enum_parse(enumprop->lookup, str, -1, errp);
>       g_free(str);
> 


