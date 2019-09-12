Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AFDDC47404
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 11:58:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2007F2081B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 11:58:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2007F2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8Njj-0007HG-9E
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 07:58:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45933)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1i8Nid-0006EM-Cz
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 07:57:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1i8Nib-0006km-3A
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 07:56:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40316)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1i8NiZ-0006k5-SV
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 07:56:56 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EEBE3C056807
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2019 11:56:53 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id f11so11838387wrt.18
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2019 04:56:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=d+ePzB9pk+KT6E/1L3k86VN/UHQcm1vKJZ0nKRjB4XY=;
 b=OQNnRCwOkwt5749r9sjNTs/NSOmmQYuvMFXKeKpboOyLmOJiCYGNZLyAsgK8u0lMPI
 FWb+r7ea9n6ht337YNTPCTAwYeaS3ebruvLfrAaagnWFrvkICMQ+nAPex9lREbtxiL5d
 b6Oe62woSDfQHhyo9w+YTjgFb+H5ymmkzUTG/zXCa4/zOYuR26+alG+1F8BfjhKfCKXk
 qFzxkxqO8tho4mQ91HyE7BB8/g+Z8YG/AzmZKLOMWlhoY2ApxFiTlBLy2hOsLLdQhts5
 6aSxld6G6BcdpSbQ4fZHsrPeOt94ES6KB/sMlR0O1H6mTPd93rM4iYbmCGnTUh0GAFJw
 EQfw==
X-Gm-Message-State: APjAAAVrtsnpibYI55uq6icUcooU9hwisXHjmmEBP8+fe3M7WePtqHti
 wR5RyqbTmVvE4mxdN0aR9ce3P0woJvuyAdaUxtX0tjdKolrzaAO30r+iigDahVUX0KOlf7NA482
 qKGXVYaqBos28eCM=
X-Received: by 2002:a5d:4081:: with SMTP id o1mr6446297wrp.41.1568289412175;
 Thu, 12 Sep 2019 04:56:52 -0700 (PDT)
X-Google-Smtp-Source: APXvYqySvKn4lYSnr04knUJ3hiLp4SykFNbUm7tZMbkdb3pOhOccndd+uRz8ZPjqVObkNozCTp2hXA==
X-Received: by 2002:a5d:4081:: with SMTP id o1mr6446274wrp.41.1568289411867;
 Thu, 12 Sep 2019 04:56:51 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id y72sm9371930wmc.26.2019.09.12.04.56.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Sep 2019 04:56:50 -0700 (PDT)
To: Stefan Hajnoczi <stefanha@gmail.com>
References: <20190830093056.12572-1-stefanha@redhat.com>
 <20190830184445.GF3694@habkost.net>
 <20190912102551.GA23174@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <0d743e7d-fb63-38d0-fe6e-4f24d7c101df@redhat.com>
Date: Thu, 12 Sep 2019 13:56:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190912102551.GA23174@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] memory: fetch pmem size in get_file_size()
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
Cc: Haozhong Zhang <haozhong.zhang@intel.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 qemu-devel@nongnu.org, Junyan He <junyan.he@intel.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/09/19 12:25, Stefan Hajnoczi wrote:
> On Fri, Aug 30, 2019 at 03:44:45PM -0300, Eduardo Habkost wrote:
>> On Fri, Aug 30, 2019 at 10:30:56AM +0100, Stefan Hajnoczi wrote:
>>> Neither stat(2) nor lseek(2) report the size of Linux devdax pmem
>>> character device nodes.  Commit 314aec4a6e06844937f1677f6cba21981005f=
389
>>> ("hostmem-file: reject invalid pmem file sizes") added code to
>>> hostmem-file.c to fetch the size from sysfs and compare against the
>>> user-provided size=3DNUM parameter:
>>>
>>>   if (backend->size > size) {
>>>       error_setg(errp, "size property %" PRIu64 " is larger than "
>>>                  "pmem file \"%s\" size %" PRIu64, backend->size,
>>>                  fb->mem_path, size);
>>>       return;
>>>   }
>>>
>>> It turns out that exec.c:qemu_ram_alloc_from_fd() already has an
>>> equivalent size check but it skips devdax pmem character devices beca=
use
>>> lseek(2) returns 0:
>>>
>>>   if (file_size > 0 && file_size < size) {
>>>       error_setg(errp, "backing store %s size 0x%" PRIx64
>>>                  " does not match 'size' option 0x" RAM_ADDR_FMT,
>>>                  mem_path, file_size, size);
>>>       return NULL;
>>>   }
>>>
>>> This patch moves the devdax pmem file size code into get_file_size() =
so
>>> that we check the memory size in a single place:
>>> qemu_ram_alloc_from_fd().  This simplifies the code and makes it more
>>> general.
>>>
>>> This also fixes the problem that hostmem-file only checks the devdax
>>> pmem file size when the pmem=3Don parameter is given.  An unchecked
>>> size=3DNUM parameter can lead to SIGBUS in QEMU so we must always fet=
ch
>>> the file size for Linux devdax pmem character device nodes.
>>>
>>> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>>
>> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
>>
>> Paolo, do you want to queue this, or should it go through my
>> memory backend queue?
>=20
> Ping for Paolo

I had actually queued it already, thanks.

Paolo


