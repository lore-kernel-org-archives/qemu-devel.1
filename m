Return-Path: <SRS0=OEAU=5Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37AD1C2D0EA
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 04:17:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F29CE2074F
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 04:17:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p+0XOkbY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F29CE2074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jM29P-0007km-Fu
	for qemu-devel@archiver.kernel.org; Wed, 08 Apr 2020 00:17:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46373)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <arilou@gmail.com>) id 1jM28q-0007FQ-Bf
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 00:16:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <arilou@gmail.com>) id 1jM28p-0007OW-5S
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 00:16:44 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:46497)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <arilou@gmail.com>) id 1jM28o-0007Ne-Ty
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 00:16:43 -0400
Received: by mail-wr1-x444.google.com with SMTP id y44so2634571wrd.13
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2020 21:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=UnUlRsbYDJ4s6fbGcDTEdATWc1g7FiATolixG+fpz1s=;
 b=p+0XOkbYcPzQO4jR9yDck5JvngCznlmMaPjsly73uhdIBq+ENVd7r7itPtmoy/M4WC
 6rqs6KDtSD7zieGhKCQecgLp4kn0ajL0NaiX7GXCN7410k6yM3RSWwCZaqLA6L9ms8J+
 0L9o1P7iEifBQNb8t4t5chr+BM9Bwc7g/YhGgFgYHcBSGYTIKtvSl4BFPJaCklWr2mhV
 dj/qW3+zAu6Z6z8fWlzw8Z8iOwXLxixNRrsNXMYPeWCjghADUuK+B6nyQwm8NJ5XIKs9
 e+o4adsz2hIQ7PwDgvcJqVVzdjWxZU/YNkjYwvDTS1HiF0ulnt5kOGWxe/iqOI4Ix6By
 FX1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=UnUlRsbYDJ4s6fbGcDTEdATWc1g7FiATolixG+fpz1s=;
 b=XZm9KTvZBuIzoWSa/Ey/gPJAS9Se78U+449MPTxYtHBVo5yvy//itKxDtGio/pO1IT
 YNzv/QG4zv9zc1mR6oig/DTBCPtckgOUHxSHevhidBcUFk+7fPBpZ+5Fyvef+Z/aHlOO
 S2XH2nexTSTabnd88/JsrP7diarOHD67b2yEVm1PvCBEQwvyg8E01yUcFl4jc6cNG8SM
 8RJQ59Nx3phlz7yF0WHd0Haift2YhPRDDRDlGl7JHuvNx/JzaioEZAv5Qf3mizmr8DzA
 Z+3ex5UCgrPh0SFtQFFI3dM0YeMOqePTIQs9dYHW1F64VhWT3Oz7c9/5ClW9AHs2ht7N
 fZrw==
X-Gm-Message-State: AGi0Pub5YAkCH1om5v7MyDw+LFNQHU2M3NUsJIEqOLVGmou7usODRa/E
 rqhvZVE5v3swAjhMWR1NRDQ=
X-Google-Smtp-Source: APiQypKvHBl0ZelenwBnaEzoaPUT3pa8osJoGCvNkQR84MFoBXX7XMOqn9gFHR7KUXa649itIPk8JQ==
X-Received: by 2002:adf:bbc5:: with SMTP id z5mr6184057wrg.168.1586319401468; 
 Tue, 07 Apr 2020 21:16:41 -0700 (PDT)
Received: from jondnuc (IGLD-84-229-155-55.inter.net.il. [84.229.155.55])
 by smtp.gmail.com with ESMTPSA id h2sm18097400wrp.50.2020.04.07.21.16.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2020 21:16:40 -0700 (PDT)
Date: Wed, 8 Apr 2020 07:16:39 +0300
From: Jon Doron <arilou@gmail.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [PATCH v1 5/5] i386: Hyper-V VMBus ACPI DSDT entry
Message-ID: <20200408041639.GA7606@jondnuc>
References: <20200403142308.82990-6-arilou@gmail.com>
 <76017793-735b-4bb5-0e69-ecded78af54d@maciej.szmigiero.name>
 <CAP7QCog_EmLJ=O8Xi9Tc4Jst1=z62DXim9ScCyoPv7WugrSyOw@mail.gmail.com>
 <CAP7QCogMdUis-=KsC--0ar2Zt2Vwcpn4HS+qCxPn5khtDTu+mA@mail.gmail.com>
 <9b9c42d3-af9e-25e9-210e-c58ee5975941@maciej.szmigiero.name>
 <472544e7-498a-4e28-06e9-83c102d6436b@maciej.szmigiero.name>
 <20200406073246.GA7707@rvkaganb>
 <CAP7QCojPsOYjw94k3rkH0A3rLFADLeVhgy502N=8X5wrUnoC6Q@mail.gmail.com>
 <20200407185608.GA178651@rvkaganb>
 <8c278ea8-81c5-7458-8979-c319470440d7@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <8c278ea8-81c5-7458-8979-c319470440d7@maciej.szmigiero.name>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: Evgeny Yakovlev <eyakovlev@virtuozzo.com>, ehabkost@redhat.com,
 QEMU <qemu-devel@nongnu.org>, Roman Kagan <rvkagan@yandex-team.ru>,
 Liran Alon <liran.alon@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/04/2020, Maciej S. Szmigiero wrote:
>On 07.04.2020 20:56, Roman Kagan wrote:
>> On Mon, Apr 06, 2020 at 11:20:39AM +0300, Jon Doron wrote:
>>> Well I want it to be merged in :-)
>>
>> Hmm I'm curious why, it has little to offer over virtio.
>>
>> Anyway the series you've posted seems to be based on a fairly old
>> version.
>>
>> The one in openvz repo is more recent.  It's still in need for
>> improvement, too, but should be testable at least.

Well I have implemented the hyperv synthetic kernel debugger interface, 
but on Windows 10 it requires to have a working VMBus (it's not really 
using it, but without a function vmbus that will answer to the initiate 
contact then the kdnet will simply be stuck in a loop.

With the synthetic kernel debugger interface you can debug older OS 
(Win7 up to latest Win10). The benefit is that its much faster than all 
other interfaces.

In addition to that Michael Kelley from Microsoft has informed us that 
Microsoft might be dropped the synthetic kernel debugger interface 
sometime in the future, and it seems like the new mode is simply to use 
hvnet device for the communication (which is again much faster).

Cheers,
-- Jon.
>
>Isn't the one at
>https://src.openvz.org/projects/UP/repos/qemu/commits?until=refs%2Fheads%2Fvmbus
>the latest one?
>
>It seems to be last changed in October 2019 - is there a
>later one?
>
>> Thanks,
>> Roman.
>
>Thanks,
>Maciej

