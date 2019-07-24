Return-Path: <SRS0=qU7A=VV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CFBDC7618B
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 10:54:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7364122387
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 10:54:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7364122387
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqEuv-0003nb-Iz
	for qemu-devel@archiver.kernel.org; Wed, 24 Jul 2019 06:54:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44413)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hqEuk-0003Kf-Ny
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 06:54:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hqEuj-0005kE-P7
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 06:54:30 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34434)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hqEuj-0005jk-I7
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 06:54:29 -0400
Received: by mail-wr1-f66.google.com with SMTP id 31so46509008wrm.1
 for <qemu-devel@nongnu.org>; Wed, 24 Jul 2019 03:54:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=DTAPJoVmDC2sbWdLlvbH4uTZANKqjlG4iEXhNRsemU8=;
 b=mg0yGu6DOAMTf0g9DcImYtDIa7uEs6N32Zx9nZHJPk+pEO7L/l2HllNGG24qhUUI+X
 mSB0oASkTAFuCbdmkkamGejsc7fng6QjY8luLv6eZHlnuES8C5cr2ZuJsTwvSHloAdwV
 TiU34mu2rMwFV3jAT/3kHV7W87aOSRTbA9eQC4XeBOLQy3Tus1npnP+Lp6wjWO99YMSf
 owg+C2u9ugcR4zJvI3vyVtV7EEQd0FpD2KyClq4rczX5RwstPQt8bimfUwr+v1kwN0d2
 bJ0OKmhhiA19MGenmPemXjNWJhlDMZMoDe0XkTJh6p6hs9x3nZz/58uFCgAoCPoHS85E
 8Z6g==
X-Gm-Message-State: APjAAAX/mPHZQFE9pMVUESaYpUhBV7nFzIRKbphqOV868Bi9MjjlKNb/
 m1ebDZcx5B81Q48imi5e4qw3+Q==
X-Google-Smtp-Source: APXvYqyCIItjFe8zWvdObwy8aYRt7X8bmjBGhDOvDlDpKY7cVhpsghC+zXE0TjbG9y7Cbz3TGHIL6Q==
X-Received: by 2002:adf:9bcd:: with SMTP id e13mr87185468wrc.338.1563965668562; 
 Wed, 24 Jul 2019 03:54:28 -0700 (PDT)
Received: from [10.201.33.105] ([195.166.127.210])
 by smtp.gmail.com with ESMTPSA id v16sm25172255wrn.28.2019.07.24.03.54.27
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 24 Jul 2019 03:54:27 -0700 (PDT)
To: Stefan Hajnoczi <stefanha@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>
References: <20190723190623.21537-1-stefanha@redhat.com>
 <CAJSP0QV3SyY3F9-6OEXqVOEfSHbhp4yAa2nB-1nHWYVnz3qm7A@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <7e1d6de1-cce3-45ad-9a77-c1120baebe88@redhat.com>
Date: Wed, 24 Jul 2019 12:54:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAJSP0QV3SyY3F9-6OEXqVOEfSHbhp4yAa2nB-1nHWYVnz3qm7A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] util/async: hold AioContext
 ref to prevent use-after-free
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
Cc: Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/23/19 9:09 PM, Stefan Hajnoczi wrote:
> On Tue, Jul 23, 2019 at 8:06 PM Stefan Hajnoczi <stefanha@redhat.com> wrote:
>> So if co causes ctx to be freed then we're in trouble.  Fix this problem
>> by holding a reference to ctx.
> 
> For QEMU 4.2.  I'm not aware of a way to trigger this bug in QEMU
> proper.  This fix just makes tests/test-bdrv-drain more reliable.

This looks harmless for 4.1-rc3.

