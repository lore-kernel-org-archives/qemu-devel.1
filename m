Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0307AC4360C
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 13:52:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0D9221D7F
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 13:52:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0D9221D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD7iN-00035d-1i
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 09:52:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44116)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iD7hb-0002Cz-W9
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 09:51:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iD7hZ-0002Qe-G4
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 09:51:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59468)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iD7hZ-0002QW-9y
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 09:51:29 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2C54F6378
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 13:51:28 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id s25so2105003wmh.1
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 06:51:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=REcETu9fbY9cb6ZVYkzQgGOkDJ3kS+rLYhqyZfj2naM=;
 b=Otayw38KmPkDnp8D+Xm/SO7NKeSnY8v6YGpdnz7eDa9NDf96wV7pCl1xMGSo2l3Nsx
 a1jFGB+fxqqwr8PAarJ8vZy65vuEFlZ6knjxmVpxOcShfrMUzXu8LZY0eSRsot696wbe
 mv30WZwauPtcTHb4Hnkpw+12Tp4KJ2LTSbChIaO0NXBMhoIySKrZhv2ggifv6DHDvxgm
 wkUD11seuGJoe0tQepjki+NHN+MOr13s7pjtnyMf+voz5rKcV9LtUEGDmaOCsJOYGAop
 C1YpH4Rg2vGs0X44e12TmBTtJ/nWZSSWLFNCNdbbDP/VWHqdN6+8YA82jAfc+BUssFxF
 WLew==
X-Gm-Message-State: APjAAAVsizH7/Y8pDX7kP2oV/+k0vHO4X2mVFDJV00yXI1hsUGgEHS4r
 s32S9KIwYUIa3gRg+ZZ5iH4GyfNMH0dX6XOMvVQhJisnkoyWDw7T+SHLh9yvCA9mh9fOWVENQds
 eGx+k3D1x2pwHD5I=
X-Received: by 2002:a5d:4f86:: with SMTP id d6mr9599942wru.384.1569419486814; 
 Wed, 25 Sep 2019 06:51:26 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxwrrroBiNAcJ5Y9NHJF+BgeEUEQGvXIlAm+FK793p7XG6YP9F8X2ZdvmTlkCXsQ1jPjlVPKw==
X-Received: by 2002:a5d:4f86:: with SMTP id d6mr9599921wru.384.1569419486509; 
 Wed, 25 Sep 2019 06:51:26 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9520:22e6:6416:5c36?
 ([2001:b07:6468:f312:9520:22e6:6416:5c36])
 by smtp.gmail.com with ESMTPSA id q124sm5156705wma.5.2019.09.25.06.51.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Sep 2019 06:51:25 -0700 (PDT)
Subject: Re: [PATCH] hw/core/loader: Fix possible crash in rom_copy()
To: "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>
References: <20190925130331.27825-1-thuth@redhat.com>
 <20190925092212-mutt-send-email-mst@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <ab3bcbf3-6d7b-06a1-c9bc-3fc7d471fbd0@redhat.com>
Date: Wed, 25 Sep 2019 15:51:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190925092212-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: mdroth@linux.vnet.ibm.com, qemu-devel@nongnu.org, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 25/09/19 15:22, Michael S. Tsirkin wrote:
>> Both, "rom->addr" and "addr" are derived from the binary image
>> that can be loaded with the "-kernel" paramer. The code in
>> rom_copy() then calculates:
>> 
>>     d = dest + (rom->addr - addr);
>> 
>> and uses "d" as destination in a memcpy() some lines later. Now with
>> bad kernel images, it is possible that rom->addr is smaller than addr,
>> thus "rom->addr - addr" gets negative and the memcpy() then tries to
>> copy contents from the image to a bad memory location. In the best case,
>> this just crashes QEMU, in the worst case, this could maybe be used to
>> inject code from the kernel image into the QEMU binary, so we better fix
>> it with an additional sanity check here.
>> 
>> Cc: qemu-stable@nongnu.org
>> Reported-by: Guangming Liu
>> Buglink: https://bugs.launchpad.net/qemu/+bug/1844635
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

Queued, thanks.

Paolo

