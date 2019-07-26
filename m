Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02451C7618B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 16:05:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6A5721852
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 16:05:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6A5721852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr2iN-00007H-0s
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 12:05:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50439)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hr2iD-00082N-Ee
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 12:04:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hr2iB-0003wC-IQ
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 12:04:52 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39627)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hr2iB-0003tA-Ac
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 12:04:51 -0400
Received: by mail-wr1-f68.google.com with SMTP id x4so1829421wrt.6
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 09:04:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=DF1Sx9D0OJ3IK7QMgOVSvOk2Wc38MyP0pYUxIQxIkIQ=;
 b=rTyaSY2oMJdHaXqZKJ7aJg166/ONpPRSYZ7JwSj8gawU3yJ6QeLEFR4IFqMIhkwPQ9
 2VzbijmpuimEB3LsYeyI6fp9xXsA2GDqk7pIl0IHGcpzemPp62RbyzMvWn71V6g7hCm/
 03S1lUjyOTYFiMsWsPHK/73EYTk+IPG9NS9aC/gmWIGgLy7JuEZHJj9x0aom741Km3NM
 2xI2RGieiWOAZGSYrqIcufCknun0vNha3hUKFkBmVol2PWR7x4RUEjiWsvfTfKBMjEiC
 jDgCZKI3jrQHyXCAYLdMnPZr39qPFso8R0qlK+z/46hVKlR+MLyqdsEyRQ/kEz0gH/Pw
 1z9Q==
X-Gm-Message-State: APjAAAVKUpGpz6eSWQakfWAhrTeZY8dvZY9scYy8KDCRirBbujgIqh7J
 X1GZ9+cb7kbourA76quKRcfAXQ==
X-Google-Smtp-Source: APXvYqxnHvvvBsDHS9vm6Ym3OXzVlYEXQrr5Zc+XzVSq7yip+UwiNMFhIu16osaN6K8HErUC5yWaww==
X-Received: by 2002:adf:b60c:: with SMTP id f12mr67426349wre.231.1564157090313; 
 Fri, 26 Jul 2019 09:04:50 -0700 (PDT)
Received: from [192.168.1.37] (190.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.190])
 by smtp.gmail.com with ESMTPSA id d16sm45977944wrv.55.2019.07.26.09.04.49
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 26 Jul 2019 09:04:49 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20190726120542.9894-1-armbru@redhat.com>
 <20190726120542.9894-7-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <47d9768f-794d-fe37-c7e0-9dbe204bd419@redhat.com>
Date: Fri, 26 Jul 2019 18:04:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190726120542.9894-7-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH 06/28] trace: Eliminate use of
 TARGET_FMT_plx
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/26/19 2:05 PM, Markus Armbruster wrote:
> hw/tpm/trace-events uses TARGET_FMT_plx formats with uint64_t
> arguments.  That's wrong, TARGET_FMT_plx takes hwaddr.  Since hwaddr
> happens to be uint64_t, it works anyway.  Messed up in commit
> ec427498da5, v2.12.0.  Clean up by replacing TARGET_FMT_plx with its
> macro expansion.
> 
> scripts/tracetool/format/log_stap.py (commit 62dd1048c0b, v4.0.0) has
> a special case for TARGET_FMT_plx.  Delete it.
> 
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  hw/tpm/trace-events                  | 4 ++--
>  scripts/tracetool/format/log_stap.py | 3 ---
>  2 files changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/tpm/trace-events b/hw/tpm/trace-events
> index 0b94aa1526..25e47a595a 100644
> --- a/hw/tpm/trace-events
> +++ b/hw/tpm/trace-events
> @@ -1,8 +1,8 @@
>  # See docs/devel/tracing.txt for syntax documentation.
>  
>  # tpm_crb.c
> -tpm_crb_mmio_read(uint64_t addr, unsigned size, uint32_t val) "CRB read 0x" TARGET_FMT_plx " len:%u val: 0x%" PRIx32
> -tpm_crb_mmio_write(uint64_t addr, unsigned size, uint32_t val) "CRB write 0x" TARGET_FMT_plx " len:%u val: 0x%" PRIx32
> +tpm_crb_mmio_read(uint64_t addr, unsigned size, uint32_t val) "CRB read 0x016%" PRIx64 " len:%u val: 0x%" PRIx32
> +tpm_crb_mmio_write(uint64_t addr, unsigned size, uint32_t val) "CRB write 0x%016" PRIx64 " len:%u val: 0x%" PRIx32
>  
>  # tpm_passthrough.c
>  tpm_passthrough_handle_request(void *cmd) "processing command %p"
> diff --git a/scripts/tracetool/format/log_stap.py b/scripts/tracetool/format/log_stap.py
> index 3ccbc09d61..9ab0cf2cce 100644
> --- a/scripts/tracetool/format/log_stap.py
> +++ b/scripts/tracetool/format/log_stap.py
> @@ -30,9 +30,6 @@ def c_macro_to_format(macro):
>      if macro.startswith("PRI"):
>          return macro[3]
>  
> -    if macro == "TARGET_FMT_plx":
> -        return "%016x"
> -
>      raise Exception("Unhandled macro '%s'" % macro)
>  
>  def c_fmt_to_stap(fmt):
> 

