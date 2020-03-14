Return-Path: <SRS0=i8Yf=47=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E44C0044D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 09:42:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9B2F2074C
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 09:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hcLUULmL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9B2F2074C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jD3J3-0007DA-01
	for qemu-devel@archiver.kernel.org; Sat, 14 Mar 2020 05:42:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53467)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jD3IO-0006UJ-LU
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 05:41:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jD3IM-0005hJ-Rn
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 05:41:27 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:42682
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jD3IL-0005fY-Py
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 05:41:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584178884;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U7YksAgXLtbU04JaDfwkezrnGsn5hk6zTB+gLUAwaTQ=;
 b=hcLUULmLaGRYDldbIGWUFI0b+ycb+6LXzkItxJgT44o9OlAazWamV7D2PpBVidwnhxPDVj
 VnaAv+Cs7C0sDat+cJmilnxgaX1BzJdyx/nuM6lryWdEKuugY5SO0XwI5MeaPG+8OLVwHQ
 Z1+OEZIL2kgSg8EZVkfDVRp+vjMbXAU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-QLHTSbYTPsuPPN4Pam5xjg-1; Sat, 14 Mar 2020 05:41:21 -0400
X-MC-Unique: QLHTSbYTPsuPPN4Pam5xjg-1
Received: by mail-wr1-f71.google.com with SMTP id w6so5672587wrm.16
 for <qemu-devel@nongnu.org>; Sat, 14 Mar 2020 02:41:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=U7YksAgXLtbU04JaDfwkezrnGsn5hk6zTB+gLUAwaTQ=;
 b=Ui3Jaxuf+/Wiy4ZY8U6TTdLun9rQZtkYiPHNG7saVcSxgP80PFLl73SwZUKzdUw3H/
 fKKpjEzH8JTu3LlS1xMTHtn5JrDAp8Ns5pIofyxOTxlKdOEjF9At9A4Gnd1ZtngV4UYe
 gfp2Tu1xMqd49O5khe1XjpJ2EsOZngYeo2n69dJBCM9ECv2K3MrNTjTeYM56aXEt9s8+
 TkS8/2dtMoHxGn4u/cuH5qzsNAdB/3sHg0cyc5pJl8b2szaCoI+WK1I4J0GC0vwqbKZn
 +EkLsPH3qU49nR4UBa4gkrnfFKKRcvcespZC1Ptvjiuo8E68lghZy7esZmWC/1RpKzPe
 bGKQ==
X-Gm-Message-State: ANhLgQ02tHHw5RMe0cXG2vpTNHG2ilgCFCsRCyO79L2VO3UM/gFHFQfH
 7YkjiMaW7sVybZEpOyAMNqb7w+M6ooTgs1VsS08qCtCPoXTO6kqsA5rPREY2z7S9komxSpJ4akg
 oDOb0taViyKWCwkk=
X-Received: by 2002:adf:b641:: with SMTP id i1mr23365959wre.18.1584178880533; 
 Sat, 14 Mar 2020 02:41:20 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuJeeqRK6tV01g2uRESv8Mtb2vv8oYqONfQNIdc0ZbmMX0LbaOSIbHHkm+4w9sETALa74LNrw==
X-Received: by 2002:adf:b641:: with SMTP id i1mr23365926wre.18.1584178880259; 
 Sat, 14 Mar 2020 02:41:20 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.174.5])
 by smtp.gmail.com with ESMTPSA id h13sm26433101wrv.39.2020.03.14.02.41.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Mar 2020 02:41:19 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] Fix MAP_SYNC support when host has older glibc
 version
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
References: <20200311232342.1614944-1-ehabkost@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7a2bc684-b07e-3825-10db-5f2bf0c33edf@redhat.com>
Date: Sat, 14 Mar 2020 10:39:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200311232342.1614944-1-ehabkost@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: peter.maydell@linaro.org, jingqi.liu@intel.com, jtomko@redhat.com,
 mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/03/20 00:23, Eduardo Habkost wrote:
> Changes v1 -> v2:
> * Use -isystem for $PWD/linux-headers too
>   Reported-by: "Michael S. Tsirkin" <mst@redhat.com>
> 
> This is an alternative to the patch submitted at:
> 
>   From: Jingqi Liu <jingqi.liu@intel.com>
>   Subject: [PATCH] util: fix to get configuration macros in util/mmap-alloc.c
>   Date: Thu,  5 Mar 2020 23:41:42 +0800
>   Message-Id: <20200305154142.63070-1-jingqi.liu@intel.com>
> 
> Before moving the osdep.h include to the top of the file, we had
> to address warnings triggered when <linux/mman.h> was included
> after <sys/mman.h> (done in patch 1/2).
> 
> Eduardo Habkost (2):
>   Use -isystem for linux-headers dir
>   mmap-alloc: Include osdep.h before checking CONFIG_LINUX
> 
>  Makefile.target   | 2 +-
>  configure         | 2 +-
>  util/mmap-alloc.c | 7 +++----
>  3 files changed, 5 insertions(+), 6 deletions(-)
> 

Queued, thanks.

Paolo


