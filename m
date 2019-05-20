Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8450C04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 10:45:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FF8F2081C
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 10:45:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FF8F2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33225 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSfnU-0003NI-Tf
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 06:45:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hSfmU-0002oN-JE
	for qemu-devel@nongnu.org; Mon, 20 May 2019 06:44:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hSfmT-00072C-Dp
	for qemu-devel@nongnu.org; Mon, 20 May 2019 06:44:34 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55305)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hSfmT-00071j-5L
	for qemu-devel@nongnu.org; Mon, 20 May 2019 06:44:33 -0400
Received: by mail-wm1-f66.google.com with SMTP id x64so12734563wmb.5
	for <qemu-devel@nongnu.org>; Mon, 20 May 2019 03:44:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=/RynCueCwB8JMjxtWlnenO8jqS/uHRN/I/6NF3klZng=;
	b=SbG+YaQ6BAd/+btwK5b93bJ28+WB8NoCQOzrwNRY9qmD2/xep4xMCQTcqrjBAWxw0M
	SfOH5dDXBbCIhzft2bWdiLWNdFQUq/P3i7xpoe7F1ZEQHib2SH7tD6ccLc2dtk/wg2i5
	Ah5wNL6paaFYny2GMMu75BjjKNJ9nB4H1RSgdMuzuvyoPuuttOFdMmnPU4ug+M/bZ5iG
	3UTCJ3ES+H+usIL6PcA7ERu+hVTvWnfIlSo7qdEBXlYsyPklocuPLUWlcdqrOSPLn4YO
	+Yj0LtBjConLiwyqkkcAQ/CFVYEQzWvFdrX1F0FxrXDicxg2Ck/aBVfn+WEQHNAI06Qu
	toag==
X-Gm-Message-State: APjAAAWggxSORD+eUBihRnQf7poxWx+WCMI69pI8TcivgX9xF9my075X
	M5zVhKGc12S9gtfFZtnAbwABoQ==
X-Google-Smtp-Source: APXvYqxcw8Qkn8fa2w9ioiWUoCSbblUaKtnI6mEsvKAlXsQ9UgJEj5PBsUesrtxA5Wy36yfjOn4plQ==
X-Received: by 2002:a7b:cd0e:: with SMTP id f14mr28112617wmj.127.1558349071719;
	Mon, 20 May 2019 03:44:31 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ac04:eef9:b257:b844?
	([2001:b07:6468:f312:ac04:eef9:b257:b844])
	by smtp.gmail.com with ESMTPSA id
	n4sm13751241wmk.24.2019.05.20.03.44.30
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Mon, 20 May 2019 03:44:30 -0700 (PDT)
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
References: <20190520030839.6795-1-peterx@redhat.com>
	<20190520030839.6795-14-peterx@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5d9174bc-0f3b-100f-e400-eeb94680020a@redhat.com>
Date: Mon, 20 May 2019 12:44:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190520030839.6795-14-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [PATCH v2 13/15] qmp: Expose
 manual_dirty_log_protect via "query-kvm"
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Laurent Vivier <lvivier@redhat.com>,
	"Dr . David Alan Gilbert" <dgilbert@redhat.com>,
	Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 20/05/19 05:08, Peter Xu wrote:
> Expose the new capability via "query-kvm" QMP command too so we know
> whether that's turned on on the source VM when we want.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>

Is this useful?  We could I guess make a migration capability in order
to benchmark with the old code, but otherwise I would just make this a
"hidden" optimization just like many others (same for patch 14).

In other words, there are many other capabilities that we could inform
the user about, I don't see what makes manual_dirty_log_protect special.

Paolo

> ---
>  accel/kvm/kvm-all.c  | 5 +++++
>  include/sysemu/kvm.h | 2 ++
>  qapi/misc.json       | 6 +++++-
>  qmp.c                | 1 +
>  4 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 062bf8b5b0..c79d6b51e2 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -169,6 +169,11 @@ int kvm_memcrypt_encrypt_data(uint8_t *ptr, uint64_t len)
>      return 1;
>  }
>  
> +bool kvm_manual_dirty_log_protect_enabled(void)
> +{
> +    return kvm_state && kvm_state->manual_dirty_log_protect;
> +}
> +
>  /* Must be with slots_lock held */
>  static KVMSlot *kvm_get_free_slot(KVMMemoryListener *kml)
>  {
> diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
> index a6d1cd190f..30757f1425 100644
> --- a/include/sysemu/kvm.h
> +++ b/include/sysemu/kvm.h
> @@ -547,4 +547,6 @@ int kvm_set_one_reg(CPUState *cs, uint64_t id, void *source);
>  int kvm_get_one_reg(CPUState *cs, uint64_t id, void *target);
>  struct ppc_radix_page_info *kvm_get_radix_page_info(void);
>  int kvm_get_max_memslots(void);
> +bool kvm_manual_dirty_log_protect_enabled(void);
> +
>  #endif
> diff --git a/qapi/misc.json b/qapi/misc.json
> index 8b3ca4fdd3..ce7a76755a 100644
> --- a/qapi/misc.json
> +++ b/qapi/misc.json
> @@ -253,9 +253,13 @@
>  #
>  # @present: true if KVM acceleration is built into this executable
>  #
> +# @manual-dirty-log-protect: true if manual dirty log protect is enabled
> +#
>  # Since: 0.14.0
>  ##
> -{ 'struct': 'KvmInfo', 'data': {'enabled': 'bool', 'present': 'bool'} }
> +{ 'struct': 'KvmInfo', 'data':
> +  {'enabled': 'bool', 'present': 'bool',
> +   'manual-dirty-log-protect': 'bool' } }
>  
>  ##
>  # @query-kvm:
> diff --git a/qmp.c b/qmp.c
> index b92d62cd5f..047bef032e 100644
> --- a/qmp.c
> +++ b/qmp.c
> @@ -73,6 +73,7 @@ KvmInfo *qmp_query_kvm(Error **errp)
>  
>      info->enabled = kvm_enabled();
>      info->present = kvm_available();
> +    info->manual_dirty_log_protect = kvm_manual_dirty_log_protect_enabled();
>  
>      return info;
>  }
> 


