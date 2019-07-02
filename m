Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4033AC06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 10:38:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16F6D204FD
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 10:38:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16F6D204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiGAm-0001f6-C0
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 06:38:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49403)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hiG9w-0001Cz-Uy
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 06:37:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hiG9w-00031V-03
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 06:37:12 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52270)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hiG9v-0002zh-Oy
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 06:37:11 -0400
Received: by mail-wm1-f66.google.com with SMTP id s3so349322wms.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2019 03:37:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=GnZPXbI1355tEt8G5re/d7Ljgk7NdDKh8vv2JLpeDPY=;
 b=T+snFHOvay31Bq/ma1iciGkjx3fs/gph65adVSHpGGh8KsQlpIPnapvP4+TqfplXQT
 pXOc8AffmQvQsNf7LwWeIB2Bjw4erIKrTJPWLTvYIZEZlxCnHCR/Mo0XO20HcUno4+mC
 XHKgBUMu6cOWDd1ufNEVQMB6CEa8CatH36C/iLqL4reUwNkxNw7DFEgBYLKTfvsJwgFj
 OhMbup/QEmpftqF+QxGiDnydrsKLS9I/vLmLp85N4z+ImUsdgiXzO67vtFglOOHnn8CH
 Ytf/0Y91gY4xyBa8cwgHlcVDAslZe91MZAif4uv2PBboRiSbHHoVy0hnr05NfsVldo4s
 aPIg==
X-Gm-Message-State: APjAAAWl+Tj8ibgZ7riwOYopKBVtoEvga1wDpekbx5sbu7PPJ1DBSwg7
 gEPcY7BLh6dMYmX9t2e7oD9ulqTQbjI=
X-Google-Smtp-Source: APXvYqyByuF6nDOZ1fkb//ZJA4DIV+d+BSz+Yt+aHUH4KzM3Wtua8vYR/cy6EYMgI5O1qUCElA0uAQ==
X-Received: by 2002:a1c:a783:: with SMTP id q125mr3202568wme.94.1562063830615; 
 Tue, 02 Jul 2019 03:37:10 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:68f6:70ea:5bb4:f73?
 ([2001:b07:6468:f312:68f6:70ea:5bb4:f73])
 by smtp.gmail.com with ESMTPSA id q20sm19034288wra.36.2019.07.02.03.37.08
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 02 Jul 2019 03:37:09 -0700 (PDT)
To: Sergio Lopez <slp@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>
References: <20190701144705.102615-1-slp@redhat.com>
 <20190701144705.102615-5-slp@redhat.com>
 <20190702081914.ulccsaokivd6epgv@steredhat> <877e90ygab.fsf@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e980826e-4e8d-7bdd-827a-63d8ce9a08ba@redhat.com>
Date: Tue, 2 Jul 2019 12:37:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <877e90ygab.fsf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [PATCH v2 4/4] hw/i386: Introduce the microvm
 machine type
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
Cc: ehabkost@redhat.com, maran.wilson@oracle.com, mst@redhat.com,
 qemu-devel@nongnu.org, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/07/19 10:47, Sergio Lopez wrote:
>> Could it be useful to support initrd as well?
>>
>> I'm thinking a possibility to a microvm to use only the initrd without a
>> block device.
> I agree, thanks for the suggestion. I'll add support for it.

I'd like to take a look at adding firmware support too, so that we get
linuxboot and multiboot for free.  This would also allow boot time
comparisons.

Paolo

