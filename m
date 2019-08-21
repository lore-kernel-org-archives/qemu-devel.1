Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FAEBC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 10:29:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 243A822DD3
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 10:29:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 243A822DD3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0NsK-0001YI-C3
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 06:29:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45658)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i0NrV-00017B-5A
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 06:29:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i0NrT-0003hQ-89
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 06:29:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58280)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i0NrT-0003g0-0C
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 06:29:03 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 277152D6A23
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 10:29:00 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id v15so1024570wrg.13
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 03:29:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pBaOSoOcJq/QPYSisns+NX9zdHLfEa7wrM7YKMP8d+0=;
 b=alF1R1gF8SHlB+K2um6nQNBZRC1R31OxQdzrTdyOZl+DiNu2zi+zurFW4/Bwx+ELVF
 l67M7GrnuDChS1aDIYNjoY2+/iW0OieBU/4Jy+qpF9tMUiWjuYef9m0U0eKnR6AJ8bJc
 rKnvAZwzoaLUZhCyKlNn8zsNVeoALROsN5MIrdS6AgELty4M0zBGZztPXggjDtTAQDOC
 7meZGWEAecqatQMzvnn13VMVaYwY+J6pRDG2lyBwxk9Mx8DIE1K+DUdkOAgB1J9A6lFt
 +JNtQLSP+v+welekQdcrPHbfdfIojIUBA/3uxYfDw0cNW5IJaXM/p7x2YLFiKEdEljEV
 95/A==
X-Gm-Message-State: APjAAAXnFuWZaN3Xnehw+RmgWl0DGPIQUOrSnF/0NxeTqxUjH/fvxfpW
 Y0RVu4xqNtzczNsremYIcob+TVV++OTJUDgFNzlUOW8NoUvgdUXRFBrxNIpvmouUdcPSlkg7e2o
 avec7cDHR0KVQ7nY=
X-Received: by 2002:a1c:541e:: with SMTP id i30mr5146380wmb.54.1566383338840; 
 Wed, 21 Aug 2019 03:28:58 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxcPJiPW6Ze/vRVbO3fNXxAZOB1UOH7JCSvTgbAqVajqnKulENcmdAErLGQQPyPs8YP2dGR8w==
X-Received: by 2002:a1c:541e:: with SMTP id i30mr5146365wmb.54.1566383338637; 
 Wed, 21 Aug 2019 03:28:58 -0700 (PDT)
Received: from [192.168.1.39] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id f6sm46146033wrh.30.2019.08.21.03.28.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Aug 2019 03:28:58 -0700 (PDT)
To: Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>
References: <20190817073628.94473-1-ysato@users.sourceforge.jp>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <be47ad7c-54ce-3d55-2ae0-2f72c5730f7a@redhat.com>
Date: Wed, 21 Aug 2019 12:28:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190817073628.94473-1-ysato@users.sourceforge.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v23 00/22] Add RX archtecture support
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
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Igor,

On 8/17/19 9:36 AM, Yoshinori Sato wrote:
> Hello.
> This patch series is added Renesas RX target emulation.
> 
> Changes for v22.
> Added some include.
> 
> Changes for v21.
> rebase latest master.
> Remove unneeded hmp_info_tlb.
> 
> Chanegs for v20.
> Reorderd patches.
> Squashed v19 changes.
> 
> Changes for v19.
> Follow tcg changes.
> Cleanup cpu.c.
> simplify rx_cpu_class_by_name and rx_load_image move to rx-virt.

Since do asked changes in the CPU QOM design in previous versions of
Yoshinori work, can you Ack this version (or provide guidance in how to
properly implement your suggestions, this is Yoshinori's first
contribution to the project)?

Thanks,

Phil.

