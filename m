Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE92C47404
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 12:39:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43CEF20830
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 12:39:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43CEF20830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8ONU-0006Eg-7w
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 08:39:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52654)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1i8OGl-0000Pb-0C
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 08:32:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1i8OGi-0001uR-UC
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 08:32:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47826)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1i8OGi-0001uE-Io
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 08:32:12 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B4D417EBDC
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2019 12:32:11 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id s5so11876966wrv.23
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2019 05:32:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=B0ud52UwoJAekdDpEVCgA0q3rgGF5rsKC66Ooj65vwE=;
 b=DvFpEOxoKeOgJFeBIKu3pNwde0CVkNsotiV/xbbvwy0NmWMm8VXg2o6I7xOuMhGKol
 r712teYkKnHjh8lv0fg22G+VVhCCsab/Tx7eutygfRHlkl9BrMxjMBq9BOlCzdnz8/nn
 Iyx5Cma3R7NJ5ZiQ9UVhO9eHY4vBl/Bl/CUy8I3oryGED36foFnMmVNyoILY91s0By53
 1hM7ESnrlFFiNv/tGtZNoGho+3eiq/VJmuusKwsAN3w8Py+Mj4/9u2HOTcNcILW+9mam
 QIWyn/BULSSu7q85XoaY16LJf0TCXP21HLT3v5G728ox0qgiX4aagSwDtKUihOkSdtUh
 z2Tg==
X-Gm-Message-State: APjAAAVciYVn/PM7XlPCMR2aJ4hx30A4xjwtjcUWbOaPj9W/HvGmycny
 okgFRJHuDZJ8uMDy0jZdsv7wL5LLw1wAQcivqf9AflihdRlmEYAGLM1fbUz9hhB0PLtiCKTWpAG
 D2rKVJxNnE9EYuSY=
X-Received: by 2002:adf:f282:: with SMTP id k2mr34192704wro.38.1568291530441; 
 Thu, 12 Sep 2019 05:32:10 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzcFp0yF3dsAAvHFEYqC76rqfYx5JVaCZQAyrJ8BtBqpHtvwasjAiDOqVE6IZIre+BLPcJ1wA==
X-Received: by 2002:adf:f282:: with SMTP id k2mr34192685wro.38.1568291530202; 
 Thu, 12 Sep 2019 05:32:10 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id k9sm45587772wrd.7.2019.09.12.05.32.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Sep 2019 05:32:09 -0700 (PDT)
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>,
 qemu-devel@nongnu.org, ehabkost@redhat.com, berrange@redhat.com,
 quintela@redhat.com
References: <20190911190622.7629-1-dgilbert@redhat.com>
 <20190911190622.7629-6-dgilbert@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <d6b85c24-852e-69c2-7c40-364b2a5548b4@redhat.com>
Date: Thu, 12 Sep 2019 14:32:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190911190622.7629-6-dgilbert@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 5/5] migration: Missing rcu_read_unlock
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/09/19 21:06, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Error path missing an unlock.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  migration/ram.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index 1bb82acfe0..977172ea7e 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -3445,6 +3445,7 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
>      RAMBLOCK_FOREACH_MIGRATABLE(block) {
>          if (!block->idstr[0]) {
>              error_report("%s: RAMBlock with empty name", __func__);
> +            rcu_read_unlock();
>              return -1;
>          }
>          qemu_put_byte(f, strlen(block->idstr));
> 

(The scoped version would be useful here).

Paolo

