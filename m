Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19122C04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 16:44:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2FD9216F4
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 16:44:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2FD9216F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40259 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOPgb-0005pW-6d
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 12:44:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hOPfe-0005T1-3i
	for qemu-devel@nongnu.org; Wed, 08 May 2019 12:43:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hOPfd-0003sP-2l
	for qemu-devel@nongnu.org; Wed, 08 May 2019 12:43:54 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40218)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hOPfc-0003rr-TT
	for qemu-devel@nongnu.org; Wed, 08 May 2019 12:43:53 -0400
Received: by mail-wr1-f65.google.com with SMTP id h4so8815080wre.7
	for <qemu-devel@nongnu.org>; Wed, 08 May 2019 09:43:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=lKNhsIceZwY3ep1rHjPXvF3bz7fagvLHaWLCvW54oUc=;
	b=Hv2O6k9gnu2hJz1L1e5SGV+fTvDHadjF0ivCXFGlAs6E/p7yjDpoNHctZ8/LxzcWg0
	fD+pg0fERVkQJFjwehcqOFcQdm3OTJahY3/vUcqxCEAI/fXZepoV0bVsTnZSvtmZGZcP
	rjMBP1MVc31NVkf25AA1QAt90qcWN+yhW5YqQODQF4WY5f0In3RpPjncb3fYn/8OLeDc
	z8TKSqBc7jf3HdAjBlXE8w3ONLZ14/Rxqj2buRRx9H6JNY5Zo5MhEjZlmFuUUvudDszn
	gUs0xlhn4v+MI4DEcX7ocRhHc+0YagtjZFAaT+GQeEiGfdSEQV2KOegI7BTB8vUGv43R
	8fCA==
X-Gm-Message-State: APjAAAWR5mQTW7IiMjwJHqa/T+Q8zJ3dZ9wYhdNDHU5+QlHboX+0FATH
	3erUeCXFnMkiUkYr5oy6FaF9vqr23uA=
X-Google-Smtp-Source: APXvYqxTjmu0DpcIpsS2APvdeuhWHSp6+3Kyy2Ajvv46xKY5o0vtE7EUMtRhyqx2n66GeI9MJB3TGA==
X-Received: by 2002:a05:6000:c2:: with SMTP id
	q2mr16721972wrx.324.1557333831729; 
	Wed, 08 May 2019 09:43:51 -0700 (PDT)
Received: from [10.201.33.53] ([195.166.127.210])
	by smtp.gmail.com with ESMTPSA id r9sm9757667wrj.57.2019.05.08.09.43.50
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Wed, 08 May 2019 09:43:50 -0700 (PDT)
To: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
References: <20190507134521.31044-1-thuth@redhat.com>
	<CAFEAcA-j+wQXjPW+puxk=foi2T8O=MzXHtxdWJ6E5P7o89WQSg@mail.gmail.com>
	<c0cda8fc-cc68-eadd-0750-cc9eeca094a4@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <b93b1eb4-d2ff-67cd-a293-5ceb4db9b957@redhat.com>
Date: Wed, 8 May 2019 18:43:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <c0cda8fc-cc68-eadd-0750-cc9eeca094a4@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PULL v2 00/28] Kconfig for Arm machines
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
Cc: qemu-arm <qemu-arm@nongnu.org>, John Snow <jsnow@redhat.com>,
	QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/8/19 5:33 PM, Thomas Huth wrote:
> On 08/05/2019 17.09, Peter Maydell wrote:
>> On Tue, 7 May 2019 at 14:45, Thomas Huth <thuth@redhat.com> wrote:
>>>
>>>  Hi Peter,
>>>
>>> the following changes since commit a6ae23831b05a11880b40f7d58e332c45a6b04f7:
>>>
>>>   Merge remote-tracking branch 'remotes/ehabkost/tags/python-next-pull-request' into staging (2019-05-03 15:26:09 +0100)
>>>
>>> are available in the Git repository at:
>>>
>>>   https://gitlab.com/huth/qemu.git tags/pull-request-2019-05-07
>>>
>>> for you to fetch changes up to 69f879e9fefab9aaf24893fe4ce23e07756d703c:
>>>
>>>   hw/arm: Remove hard-enablement of the remaining PCI devices (2019-05-07 15:01:47 +0200)
>>>
>>> ----------------------------------------------------------------
>>> Kconfig settings for the Arm machines
>>> (v2: Fix the dependency of q35 to AHCI_ICH9 in the second patch)
>>> ----------------------------------------------------------------
>>
>> Hi -- this is still failing in the build test where I 'make clean'
> 
> Very weird. What is running before the "make clean"? Could you provide
> me with the content of i386-softmmu/config-devices.mak please?

It worked for me after running 'git fetch --tags', maybe because Thomas
used the same tag?

