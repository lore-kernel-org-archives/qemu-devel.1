Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B5E7C2BA2B
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 13:39:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CBDA2078E
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 13:39:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ABu0MRc7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CBDA2078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMXOa-0001Xs-HS
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 09:39:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59479)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jMXNx-00016a-W4
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 09:38:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jMXNw-00071t-H6
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 09:38:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28953
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jMXNw-00071P-AF
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 09:38:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586439503;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DCmskqG9EYEK1+sY/CawnppRKGB/NvX1yPDMPQStvSQ=;
 b=ABu0MRc7zanEC+krkvDl10nY71WkrGH6ptds33OFAks351uEU7Ibfz8AsT2SbGp2exMpV5
 VtzmDYTkBB4blLyMkNJaqK9UTbR99WWAa2rkMECVLAIjJ07P7C1Lx3/IccnczZRQnxHhXl
 a+CzFd0BoyCEbe33NAheeLqW3/bi3V0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-479-NLCtzkHkPCWE3AodcwUONQ-1; Thu, 09 Apr 2020 09:38:21 -0400
X-MC-Unique: NLCtzkHkPCWE3AodcwUONQ-1
Received: by mail-wm1-f70.google.com with SMTP id 2so1869655wmf.1
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2020 06:38:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=DCmskqG9EYEK1+sY/CawnppRKGB/NvX1yPDMPQStvSQ=;
 b=YR1dTv81ghLnJQPAtpygJqztt0dyuPOjBLQZMMiZPjlMPKk9H2mytudQ9MripAbQ9v
 xANY8EaSn+2CUfmd7qCYdKEcgZxt588PJqOoRdtYvg//GGpgdYZrQDyY6TIxy1nRs8u+
 zvy/EmY8PeQC+hTaBrS252drUfTqLWWQTlbIvStcGLfps66fxDgymBEzvD17r/GxhUBf
 TyUbETx8zaGMuZmDOL08haIUJvau9fI1x53uFXscvfSksoAr8oSC20ASBVRGL9WJvIfU
 71S6EpEScfkPDcXMbp7roftxGpjQEDavQKSyrqcH2nBafWA4nosvsS0/dKdpINgz/aO8
 FN9Q==
X-Gm-Message-State: AGi0PuZVxkNtpP0zJ62Al4xlKd7TDZcktN3jrLZmZ5YlRp96Ah913co6
 8VQUJHYNRZsbTFbtEvyy3SNoFO/ByO/OBwt0QKure7xiwAM5YsX4AfPY5C+y9oG6QQyVERZOSoZ
 2OZBX0dAZGa0yOqw=
X-Received: by 2002:a1c:2002:: with SMTP id g2mr9746912wmg.109.1586439500640; 
 Thu, 09 Apr 2020 06:38:20 -0700 (PDT)
X-Google-Smtp-Source: APiQypJvweJQio2JsgLYzi3UENTZYxwPV2cd2Db2z4eAKFDt2DSWnwCFlJ72r9rnnggDYLvC3pnf6A==
X-Received: by 2002:a1c:2002:: with SMTP id g2mr9746895wmg.109.1586439500386; 
 Thu, 09 Apr 2020 06:38:20 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e8a3:73c:c711:b995?
 ([2001:b07:6468:f312:e8a3:73c:c711:b995])
 by smtp.gmail.com with ESMTPSA id m8sm3632080wmc.28.2020.04.09.06.38.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Apr 2020 06:38:19 -0700 (PDT)
Subject: Re: [PATCH] hax: Windows doesn't like posix device names
To: Stefan Weil <sw@weilnetz.de>, =?UTF-8?Q?Volker_R=c3=bcmelin?=
 <vr_qemu@t-online.de>, Wenchao Wang <wenchao.wang@intel.com>,
 Colin Xu <colin.xu@intel.com>
References: <20200322210211.29603-1-vr_qemu@t-online.de>
 <e38bcea7-4fce-724f-d154-d3ffc3d3d33f@redhat.com>
 <f50df9e0-4115-c9fb-8823-4d0e7b254f1e@weilnetz.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <87efcd40-4c66-28e3-40d0-d39c893ea477@redhat.com>
Date: Thu, 9 Apr 2020 15:38:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <f50df9e0-4115-c9fb-8823-4d0e7b254f1e@weilnetz.de>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Julio Faracco <jcfaracco@gmail.com>, QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/04/20 15:24, Stefan Weil wrote:
>>> diff --git a/target/i386/hax-windows.c b/target/i386/hax-windows.c
>>> index 0ba488c468..863c2bcc19 100644
>>> --- a/target/i386/hax-windows.c
>>> +++ b/target/i386/hax-windows.c
>>> @@ -185,12 +185,12 @@ int hax_mod_version(struct hax_state *hax, struct hax_module_version *version)
>>>  
>>>  static char *hax_vm_devfs_string(int vm_id)
>>>  {
>>> -    return g_strdup_printf("/dev/hax_vm/vm%02d", vm_id);
>>> +    return g_strdup_printf("\\\\.\\hax_vm%02d", vm_id);
>>>  }
>>>  
>>>  static char *hax_vcpu_devfs_string(int vm_id, int vcpu_id)
>>>  {
>>> -    return g_strdup_printf("/dev/hax_vm%02d/vcpu%02d", vm_id, vcpu_id);
>>> +    return g_strdup_printf("\\\\.\\hax_vm%02d_vcpu%02d", vm_id, vcpu_id);
>>>  }
>>>  
>>>  int hax_host_create_vm(struct hax_state *hax, int *vmid)
>>>
>> Queued, thanks.
>>
>> Paolo
> 
> I am rather sure that macOS does not like Windows device names, so just
> reverting might be the wrong solution if HAX should work on Windows and
> on macOS.

This is hax-windows.c, macOS uses hax-posix.c.  These days
Hypervisor.framework is probably a better choice than HAX on macOS, but
IIUC hax-posix.c also supports NetBSD so we're keeping it.

Paolo

> Is this relevant? Or should we drop HAX support for Windows? Personally
> I have no experience with hardware acceleration for QEMU on macOS.


