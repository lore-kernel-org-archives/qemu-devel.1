Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50906C10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 14:56:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25D1C2084F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 14:56:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25D1C2084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42920 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJJIj-00047T-N3
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 10:55:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47124)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJJ6u-0003qi-Dq
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 10:42:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJJ6t-0001lA-Ac
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 10:42:56 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35698)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hJJ6t-0001k3-2e
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 10:42:55 -0400
Received: by mail-wr1-f66.google.com with SMTP id f7so2949773wrs.2
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 07:42:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=686hV+N9wV4kxn7ElTY1pOv1juz6qF6k/xh8hfedPk0=;
	b=O+2GQMMeD8MtBEbK4/tsLXq6RucGShTTSNmlPCZlpS2SmSrD/KxRhgVsbjfd3SVqe6
	H4YAPFoA8e/eWf+b+5lY7fjisjOozW/HMTHR+f4+/nteA9E0DYVYnbCRTH9qNF9b2i/k
	qpVEySZU4usnPqY2qT+h0wdX/XKD/WWJjLSdGhiPd/yQVWlHwOXBfBtm7qump6VfGHCP
	/Nz7KqrnFdJKpDjOnxilxtWTKBm2q7DFYLIhsEOSwjx9d2lr2JEq65lSxzlEd7LpxZDD
	goU1vKSw3Ko1InNZ7Z6UECa1EQIJW1u2h9okZUj4sDrabdL2KP6dNFRqpkTL/47LnuLw
	rijQ==
X-Gm-Message-State: APjAAAV8o35+iI1qeObPYcIg6IqJziOQxqlZHIX34veUe/1vZ8vdriLf
	j5LqQmFBsMvC0K3mv0cQrG0aQA==
X-Google-Smtp-Source: APXvYqxeHi8CAO5YeSCmwv08zI3L7sn1zXUt0frWO5hOxyzDb6WKQr5As7rP+KdL7/xWgFqLqmD2TQ==
X-Received: by 2002:a5d:430f:: with SMTP id h15mr7199128wrq.132.1556116974008; 
	Wed, 24 Apr 2019 07:42:54 -0700 (PDT)
Received: from [192.168.1.25] (atoulouse-656-1-803-163.w86-221.abo.wanadoo.fr.
	[86.221.12.163]) by smtp.gmail.com with ESMTPSA id
	w130sm19805987wma.36.2019.04.24.07.42.52
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Wed, 24 Apr 2019 07:42:53 -0700 (PDT)
To: Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>,
	qemu-devel@nongnu.org
References: <20190424103747.10173-1-thuth@redhat.com>
	<20190424103747.10173-4-thuth@redhat.com>
	<167b6b7c-3fef-47e8-d30d-09abfe1e50ba@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <04383486-acc8-f07e-e6be-63cb654be25c@redhat.com>
Date: Wed, 24 Apr 2019 16:42:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <167b6b7c-3fef-47e8-d30d-09abfe1e50ba@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH 3/6] tests/qemu-iotests: Do not hard-code
 the path to bash
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
	Ed Maste <emaste@freebsd.org>, qemu-block@nongnu.org,
	Max Reitz <mreitz@redhat.com>,
	=?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190424144251.tJIEDA6_w_cFLYEZ1absOVPUyVRuaOLI9Pasj0wGUyk@z>

On 4/24/19 4:14 PM, Eric Blake wrote:
> On 4/24/19 5:37 AM, Thomas Huth wrote:
>> bash is installed in a different directory on non-Linux systems like
>> FreeBSD. Do not hard-code /bin/bash here so that the tests can run
>> there, too.
> 
> These tests were obviously copy-and-pasted from a fork point prior to
> commit 11a82d14.

:(

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> 
> Reviewed-by: Eric Blake <eblake@redhat.com>
> 
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  tests/qemu-iotests/239 | 2 +-
>>  tests/qemu-iotests/240 | 2 +-
>>  tests/qemu-iotests/241 | 2 +-
>>  tests/qemu-iotests/243 | 2 +-
>>  tests/qemu-iotests/244 | 2 +-
>>  5 files changed, 5 insertions(+), 5 deletions(-)
> 
> 

