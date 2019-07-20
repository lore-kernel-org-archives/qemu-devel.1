Return-Path: <SRS0=lwXe=VR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 359DCC76188
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2019 09:42:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E0022084D
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2019 09:42:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E0022084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1holsj-0007ad-9m
	for qemu-devel@archiver.kernel.org; Sat, 20 Jul 2019 05:42:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32781)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1holsZ-0007C9-DM
 for qemu-devel@nongnu.org; Sat, 20 Jul 2019 05:42:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1holsY-00047Z-9j
 for qemu-devel@nongnu.org; Sat, 20 Jul 2019 05:42:11 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38217)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1holsY-00046l-25
 for qemu-devel@nongnu.org; Sat, 20 Jul 2019 05:42:10 -0400
Received: by mail-wm1-f67.google.com with SMTP id s15so9678706wmj.3
 for <qemu-devel@nongnu.org>; Sat, 20 Jul 2019 02:42:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Vvn+QbvSGfazjxk/5hyANNg/2J1k0tz+OEoQx9NqFuA=;
 b=c32FhRz88HNovVX8H2rb0tFyw1U5NvtGCuQBhexN5UlzXygqUh01IPo7dvMNvd7XJb
 Y5Rd0XKlWbZpRTjhkVOikdpcTBE2cXS898IWBXhFXimZd4DAuawQ2ySvijTdtuvJi88a
 jL7fG4NWgk9YEkCCBDPNsWzmG0LbCZbcQvN1NOUq6RbU4lrH1ADthN98SbEGnML+eOU3
 7Ahae7voDZU//CO2QcqAs2ouJIW/JVWhPpw4zOU5cdaDUDupSsi3J6MNzMe7cyWpd/GD
 h9aQiGlygqjBjrA4nVlkLWb44rtjftFRVeaN1Y+53ibJIFCdgXCJe2iBmQ6IEYLDY+Cu
 CHww==
X-Gm-Message-State: APjAAAWPwFWVTWRMpshTPWerBXzHoyVmEraF5VMWRx32g3yaLkjJ+8+c
 1RLXP/dDiKcu9Z2ZpHe/WWWOog==
X-Google-Smtp-Source: APXvYqzpBrYW3feI7OiUGef0XcDEWNPZoGmR5ZBpgmbsNzRVpg1GqN15JBW+WmMxUtMxIdKRu+Z5LA==
X-Received: by 2002:a05:600c:230c:: with SMTP id
 12mr47575854wmo.151.1563615729088; 
 Sat, 20 Jul 2019 02:42:09 -0700 (PDT)
Received: from [192.168.1.37] (62.red-83-42-61.dynamicip.rima-tde.net.
 [83.42.61.62])
 by smtp.gmail.com with ESMTPSA id o20sm80685230wrh.8.2019.07.20.02.42.08
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Sat, 20 Jul 2019 02:42:08 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <87y30t43cp.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <316ea157-4c44-5d75-e4f4-7977d2e13345@redhat.com>
Date: Sat, 20 Jul 2019 11:42:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <87y30t43cp.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] Use of TARGET_FMT_plx in hw/tpm/trace-events
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
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/20/19 8:39 AM, Markus Armbruster wrote:
> Consider hw/tpm/trace-events
> 
>     # tpm_crb.c
>     tpm_crb_mmio_read(uint64_t addr, unsigned size, uint32_t val) "CRB read 0x" TARGET_FMT_plx " len:%u val: 0x%" PRIx32
>     tpm_crb_mmio_write(uint64_t addr, unsigned size, uint32_t val) "CRB write 0x" TARGET_FMT_plx " len:%u val: 0x%" PRIx32
> 
> Format is TARGET_FMT_plx formats a hwaddr, but the parameter type is
> uint64_t.  They happen to be the same.  Is this kosher?
> 

Missed when converting from DPRINTF() to trace-events:
https://git.qemu.org/?p=qemu.git;a=commitdiff;h=ec427498;hp=8cb340c613

PRIx64 certainly makes sense here.

Since it is the single use, once updated we can remote this hunk from
scripts/tracetool/format/log_stap.py:

    if macro == "TARGET_FMT_plx":
        return "%016x"

I guess remember a thread with Thomas talking about TARGET_FMT_plx but I
can't find it, maybe I dreamed about it...

The idea was, we poison TARGET_FMT_l[udx] but not TARGET_FMT_plx, we
could, but then we have to fix few formats, once done TARGET_FMT_plx
existence is almost irrelevant.

