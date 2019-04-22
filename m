Return-Path: <SRS0=5Zkg=SY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17504C10F11
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 22:19:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D109D205F4
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 22:19:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D109D205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44995 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIhHG-0004Oi-Nu
	for qemu-devel@archiver.kernel.org; Mon, 22 Apr 2019 18:19:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hIhFT-0003Mu-Sf
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 18:17:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hIhFQ-0006qs-It
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 18:17:15 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35217)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hIhFP-0006qC-SB
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 18:17:12 -0400
Received: by mail-wr1-f68.google.com with SMTP id o12so14137157wrn.2
	for <qemu-devel@nongnu.org>; Mon, 22 Apr 2019 15:17:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=x4vqMXfmM7OsPn6i0NjHQmDCtUzYbqlYACLNOrI0Z4s=;
	b=EQY+O6mloIIMnXurjHHSAsIzwGvRvYnWugiJuyQypuCXR3mQ3a/xjX5e/3WE2kTOQq
	JQ1nHtliLhjcAE4mM0Plwg6OChqtexwUkuXRYR2t3tECbk2EhQATks3gTw4mkvqNPq8V
	GH6Nvfc1UfP8WHZKBFAsNrjoy4uG7yibpU0Of72XYQHs8Mh0MpKD9vh6TrQsJmqTvM9B
	rcjtLZBXGrArmzoJ53LP/thS3YzOHHZutvNb1NGToP1SVT2cM45FBGiISF7hK0bpDHt2
	TgyGA/Bcwta9vZh6lVw9h/s9YdGuylcmTwrq4ojC81yDkHAnfwywVydBBgyXzbA+GDtW
	mSyQ==
X-Gm-Message-State: APjAAAXGhYUT4BvXPt2DqCBS1Atp2zmOPdTM64biS2r1gzuVIMXIchti
	3Z1xg22SEunAiqDXqwr7Yk9FpA==
X-Google-Smtp-Source: APXvYqzqrJfx/Ki7X0jBP+6v4SjLnw7dEGZISdl3y7/GPk93wwcM7qBgIUJqdJe+hGwfe2X0uuqhIw==
X-Received: by 2002:a5d:6848:: with SMTP id o8mr129262wrw.204.1555971430912;
	Mon, 22 Apr 2019 15:17:10 -0700 (PDT)
Received: from [192.168.1.25] (atoulouse-656-1-803-163.w86-221.abo.wanadoo.fr.
	[86.221.12.163]) by smtp.gmail.com with ESMTPSA id
	o1sm20357542wmh.47.2019.04.22.15.17.09
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Mon, 22 Apr 2019 15:17:09 -0700 (PDT)
To: Eduardo Habkost <ehabkost@redhat.com>
References: <20190422210448.2488-1-ehabkost@redhat.com>
	<20190422210448.2488-2-ehabkost@redhat.com>
	<edbaa0c1-d7ae-11a7-2ada-e3c5f4ca7c8a@redhat.com>
	<20190422220814.GA25134@habkost.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <37c1d38f-06b6-fb8e-2cc1-c4094ae05931@redhat.com>
Date: Tue, 23 Apr 2019 00:17:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190422220814.GA25134@habkost.net>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH 1/3] qtest: Move accel code to accel/qtest.c
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190422221708.qtZkulyiwFcs9_InmYu93Z9qaHm9ngAUI-hWhpu9ogQ@z>

On 4/23/19 12:08 AM, Eduardo Habkost wrote:
> On Mon, Apr 22, 2019 at 11:56:18PM +0200, Philippe Mathieu-Daudé wrote:
>> Hi Eduardo,
>>
>> On 4/22/19 11:04 PM, Eduardo Habkost wrote:
>>> QTest has two parts: the server (-qtest) and the accelerator
>>> (-machine accel=qtest).  The accelerator depends on CONFIG_POSIX
>>> due to its usage of sigwait(), but the server doesn't.
>>>
>>> Move the accel code to accel/qtest.c.  Later we will disable
>>> compilation of accel/qtest.c on non-POSIX systems.
>>>
> [...]
>>> +#include "qemu/module.h"
>>
>> Why include "qemu/module.h"?
>> I guess you don't need it.
> 
> That's where the type_init() macro is defined.

Oh correct...

I tried to remove it/compile and it worked because it is pulled by:

"sysemu/cpus.h"
 -> "qemu/timer.h"
     -> "qemu-common.h"
         -> "qemu/module.h"

Thanks!

>>> +type_init(qtest_type_init);
> [...]
> 
> 
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> 
> Thanks!
> 

