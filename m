Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E59C43219
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 22:09:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 839F6206BA
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 22:09:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cUfWIcgH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 839F6206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35732 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJmYS-00022Q-Do
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 18:09:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1hJmWp-0000eg-5U
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 18:07:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1hJmWo-0002VL-64
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 18:07:39 -0400
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744]:37273)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <danielhb413@gmail.com>)
	id 1hJmWo-0002V4-1w
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 18:07:38 -0400
Received: by mail-qk1-x744.google.com with SMTP id c1so755426qkk.4
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 15:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-transfer-encoding:content-language;
	bh=VCqOLzcQzOry238anwTWgEnTusWrukckbQ5KfuhSRmY=;
	b=cUfWIcgHMACeXz4sB+dtbYXC84qBlUh7ZPrdsVtx1gjQmJt1+bdGedirTm4c3tHBL0
	7CoXxuM0D+VXCPA6ZnH/nz5htV60weN5CofIQvYdcAqXr7/cAi4MLVYyD8CXBQpKoNaf
	+G4cN5XweP7KfSF017PVZb2IsUr/TsBiwYPXChZD5SGC45VFdXaP2bYCn+phkGNNBrL5
	z2ntvWbDheyIB4evHBrKTpeCsE85/66R+ScWzrcJbYgmXDRxoe+N2SwIQeMkZbQkdfnf
	UQzrxs0GiF/8s/JNlHt66GpPIZDu7wwHSqMnHdzN2v8FLAwSb7gilYYq4VtZgBZDJ3rD
	3+Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-transfer-encoding
	:content-language;
	bh=VCqOLzcQzOry238anwTWgEnTusWrukckbQ5KfuhSRmY=;
	b=WrLKFxMCjYdp47Y8SvDBkPueuR3DnB912I/5jGUqxXZCtpdZntJoznp//dmpYNeJEW
	JAV4HemUT9GnfNKC7u0LjuK5R8aucnSH6k2ro9g6m/ntwF7ww756qQNKIUbgt6ZVNhcO
	wfHXrQzvjtfEtviDuBtAtf/n5NUvcQgsSNk7tG16lC+kddM8nxPeJbQ1vupfUBnLI1ke
	8ry1G72k42WwddrmWtREYTEwPBejlVMirVYYY8/dgVf4oFoFS6MGEKi42OPE5RZYlZVo
	FKUT5njcwFcN8yfIBkS4IPd3nmEJsAvv1/LuRUA6/sK6mTDUmwl5F6mbTBIU5Vkjb5mW
	03Rg==
X-Gm-Message-State: APjAAAUyOM/X37u+k2IcvXZtc1isd/nwHCx7dS8VxXRNgwuHFAuu0AMJ
	2T23E1c1UUDdR1Q4e56LtWE=
X-Google-Smtp-Source: APXvYqyFK3w5b2F525U1y9H3Uj6XY5jfHrJpCIxUX8kst9ekdSbH5M6QD3eK2JE5MAUXVfFkVwSCEQ==
X-Received: by 2002:a05:620a:1014:: with SMTP id
	z20mr1225313qkj.258.1556230057414; 
	Thu, 25 Apr 2019 15:07:37 -0700 (PDT)
Received: from ?IPv6:2804:431:f700:e6ba:b454:b6bb:95ea:4a7d?
	([2804:431:f700:e6ba:b454:b6bb:95ea:4a7d])
	by smtp.gmail.com with ESMTPSA id 11sm15646173qtu.5.2019.04.25.15.07.35
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 25 Apr 2019 15:07:36 -0700 (PDT)
To: Wei Yang <richardw.yang@linux.intel.com>, qemu-devel@nongnu.org
References: <20190424004700.12766-1-richardw.yang@linux.intel.com>
	<20190424004700.12766-5-richardw.yang@linux.intel.com>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-ID: <31fe8ef8-56c0-ee41-4fd4-9197a6b1bbdb@gmail.com>
Date: Thu, 25 Apr 2019 19:07:33 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190424004700.12766-5-richardw.yang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::744
Subject: Re: [Qemu-devel] [PATCH 4/4] migration/savevm: wrap into
 qemu_loadvm_state_header()
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
Cc: dgilbert@redhat.com, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190425220733.d9aM037RtC_Z1n06CU_MSbAEYyuGNj6dx2XGOnVFIis@z>



On 4/23/19 9:47 PM, Wei Yang wrote:
> On source side, we have qemu_savevm_state_header() to send related data,
> while on the receiving side those steps are scattered in
> qemu_loadvm_state().
>
> This patch wrap those related steps into qemu_loadvm_state_header() to
> make it friendly to read.
>
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>


Reviewed-by: Daniel Henrique Barboza <danielhb413@gmail.com>


> ---
>   migration/savevm.c | 69 +++++++++++++++++++++++++++-------------------
>   1 file changed, 40 insertions(+), 29 deletions(-)
>
> diff --git a/migration/savevm.c b/migration/savevm.c
> index a80ae83663..64d23682c6 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -2256,6 +2256,43 @@ qemu_loadvm_section_part_end(QEMUFile *f, MigrationIncomingState *mis)
>       return 0;
>   }
>   
> +static int qemu_loadvm_state_header(QEMUFile *f)
> +{
> +    unsigned int v;
> +    int ret;
> +
> +    v = qemu_get_be32(f);
> +    if (v != QEMU_VM_FILE_MAGIC) {
> +        error_report("Not a migration stream");
> +        return -EINVAL;
> +    }
> +
> +    v = qemu_get_be32(f);
> +    if (v == QEMU_VM_FILE_VERSION_COMPAT) {
> +        error_report("SaveVM v2 format is obsolete and don't work anymore");
> +        return -ENOTSUP;
> +    }
> +    if (v != QEMU_VM_FILE_VERSION) {
> +        error_report("Unsupported migration stream version");
> +        return -ENOTSUP;
> +    }
> +
> +    if (migrate_get_current()->send_configuration) {
> +        if (qemu_get_byte(f) != QEMU_VM_CONFIGURATION) {
> +            error_report("Configuration section missing");
> +            qemu_loadvm_state_cleanup();
> +            return -EINVAL;
> +        }
> +        ret = vmstate_load_state(f, &vmstate_configuration, &savevm_state, 0);
> +
> +        if (ret) {
> +            qemu_loadvm_state_cleanup();
> +            return ret;
> +        }
> +    }
> +    return 0;
> +}
> +
>   static int qemu_loadvm_state_setup(QEMUFile *f)
>   {
>       SaveStateEntry *se;
> @@ -2403,7 +2440,6 @@ int qemu_loadvm_state(QEMUFile *f)
>   {
>       MigrationIncomingState *mis = migration_incoming_get_current();
>       Error *local_err = NULL;
> -    unsigned int v;
>       int ret;
>   
>       if (migration_is_blocked(&local_err)) {
> @@ -2411,34 +2447,9 @@ int qemu_loadvm_state(QEMUFile *f)
>           return -EINVAL;
>       }
>   
> -    v = qemu_get_be32(f);
> -    if (v != QEMU_VM_FILE_MAGIC) {
> -        error_report("Not a migration stream");
> -        return -EINVAL;
> -    }
> -
> -    v = qemu_get_be32(f);
> -    if (v == QEMU_VM_FILE_VERSION_COMPAT) {
> -        error_report("SaveVM v2 format is obsolete and don't work anymore");
> -        return -ENOTSUP;
> -    }
> -    if (v != QEMU_VM_FILE_VERSION) {
> -        error_report("Unsupported migration stream version");
> -        return -ENOTSUP;
> -    }
> -
> -    if (migrate_get_current()->send_configuration) {
> -        if (qemu_get_byte(f) != QEMU_VM_CONFIGURATION) {
> -            error_report("Configuration section missing");
> -            qemu_loadvm_state_cleanup();
> -            return -EINVAL;
> -        }
> -        ret = vmstate_load_state(f, &vmstate_configuration, &savevm_state, 0);
> -
> -        if (ret) {
> -            qemu_loadvm_state_cleanup();
> -            return ret;
> -        }
> +    ret = qemu_loadvm_state_header(f);
> +    if (ret) {
> +        return ret;
>       }
>   
>       if (qemu_loadvm_state_setup(f) != 0) {


