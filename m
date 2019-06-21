Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B87FAC43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 00:32:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 904B82070B
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 00:32:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 904B82070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53622 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1he7TP-0004vF-Aw
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 20:32:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44986)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1he7Qs-0004Iz-S8
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 20:29:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1he7Qr-00040b-7X
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 20:29:34 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53647)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1he7Qq-0003wl-Sb
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 20:29:33 -0400
Received: by mail-wm1-f68.google.com with SMTP id x15so4689327wmj.3
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2019 17:29:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xiehg6TiFSb4nqyA4RqvQkca9AMegUjPTTMhVZgI/ew=;
 b=I7jiIal2+nL+RpTQ1YZ8EQwAgSth81UQRACShVgrXTtleODQrqR2yifH5cvKjeRtpM
 FBrVI7szNQFvC84F5KXzAsji/mbEyr+r/dRikBwZBFtQL3rKoirvr5jdi9ay80TdkuFR
 u4U340qaX3qG0ls6oDGAWBBEfjmoEdDFe8X0LfgYwrnnEJKyuBNFIZ23WXMOOtBIzRVT
 dhTLfXIZjqk5QnelR/wotW1DLQaLRHg+UkHpOuTApwhdZXm0x7tQWRpdV38UaLDlZW9X
 7IlOYiOiHXpfyhSQtNwY6vWQZO0iRafRnoLHd5zcFVSklBURSgvaAg3eVz4jY3U0+PtM
 C4pQ==
X-Gm-Message-State: APjAAAXEt2NIw41k23l9TbiwXGdD1qd8EXCs3jqaZKLUVC3roEGNKcsi
 wvFTw6/3tqJzWM4hQP6xllAemg==
X-Google-Smtp-Source: APXvYqwtgzh93wcneUl59vRYuMRu3Rh9Br+aYv3jOOYkpsh4DD9qSG/QVEhVplu3/4UfhwZtx7jmHQ==
X-Received: by 2002:a1c:10f:: with SMTP id 15mr1374676wmb.142.1561076970901;
 Thu, 20 Jun 2019 17:29:30 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:45fb:a0de:928e:79e8?
 ([2001:b07:6468:f312:45fb:a0de:928e:79e8])
 by smtp.gmail.com with ESMTPSA id j4sm819748wrx.57.2019.06.20.17.29.29
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 20 Jun 2019 17:29:29 -0700 (PDT)
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <1560174635-22602-1-git-send-email-imammedo@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9712632a-e84c-f88e-76d3-9ddc402b8256@redhat.com>
Date: Fri, 21 Jun 2019 02:29:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1560174635-22602-1-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [PATCH] pc: fix possible NULL pointer dereference
 in pc_machine_get_device_memory_region_size()
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
Cc: armbru@redhat.com, rth@twiddle.net, ehabkost@redhat.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/06/19 15:50, Igor Mammedov wrote:
> QEMU will crash when device-memory-region-size property is read if ms->device_memory
> wasn't initialized yet.
> 
> Crash can be reproduced with:
>  $QEMU -preconfig -qmp unix:qmp_socket,server,nowait &
>  ./scripts/qmp/qom-get -s qmp_socket /machine.device-memory-region-size
> 
> Instead of crashing return 0 if ms->device_memory hasn't been initialized.

This patch breaks bios-tables-test /x86_64/acpi/piix64/cpuhp:

acpi-test: Warning! SRAT binary file mismatch. Actual [aml:/tmp/aml-RIFK3Z], Expected [aml:tests/data/acpi/pc/SRAT.memhp].
acpi-test: Warning! SRAT mismatch. Actual [asl:/tmp/asl-TLFK3Z.dsl, aml:/tmp/aml-RIFK3Z], Expected [asl:/tmp/asl-JL5J3Z.dsl, aml:tests/data/acpi/pc/SRAT.memhp].
**
ERROR:/home/pbonzini/work/upstream/qemu/tests/bios-tables-test.c:434:test_acpi_asl: assertion failed: (all_tables_match)
ERROR - Bail out! ERROR:/home/pbonzini/work/upstream/qemu/tests/bios-tables-test.c:434:test_acpi_asl: assertion failed: (all_tables_match)

So I'm removing it from the pull request.

Paolo

> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> v2:
>   add reproducer to commit message
>    (Markus Armbruster <armbru@redhat.com>)
> 
>  hw/i386/pc.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index edc240b..1b7ead9 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -2459,7 +2459,11 @@ pc_machine_get_device_memory_region_size(Object *obj, Visitor *v,
>                                           Error **errp)
>  {
>      MachineState *ms = MACHINE(obj);
> -    int64_t value = memory_region_size(&ms->device_memory->mr);
> +    int64_t value = 0;
> +
> +    if (ms->device_memory) {
> +        memory_region_size(&ms->device_memory->mr);
> +    }
>  
>      visit_type_int(v, name, &value, errp);
>  }
> 


