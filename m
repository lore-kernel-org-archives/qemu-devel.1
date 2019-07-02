Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC6AC06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 10:10:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F45720659
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 10:10:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F45720659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiFkV-0005kG-J9
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 06:10:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44305)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hiFjn-0005Dd-P2
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 06:10:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hiFjm-0000Ny-NE
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 06:10:11 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]:43867)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hiFjm-0000NU-GS
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 06:10:10 -0400
Received: by mail-wr1-f46.google.com with SMTP id p13so17063351wru.10
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2019 03:10:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Cwo/JAhlwrU+jG114Oz0QBWrqhK7Ohun74Y5U8htOCU=;
 b=Y5KVT5aV9kqoYTEex1UXXdpFDn22l4lscWcceS0C85jzGNNAIck7QdYQLb/EXFA75a
 42m0maFzXd3A2KZasiQVpm6+zcni3W16OAizZPdikcPNtbD8xHVqvzZwL8G0uqBN69gK
 nWn4Q2bxduAlS3jvTzglDIxOxZFAnyo8rYbqAntS/y8zV7eRnTTd2Ce4jcV7HQPxvL8J
 IqyvGzxoNcz4zBMdr2pNc+PvH8PxYw04ZSInJMgdrI/ITWFEqid/48nzt6eRRk2JwfOY
 XD4gTwt0pqVTab5959xC05zkEqNYwOwhhHo0Gm698GyK+fS466FQj+ngt9S3TnLNWuiE
 eCzA==
X-Gm-Message-State: APjAAAVZ1BGeVIj1hpf1NonDdoH1Dg07gahgd/8AIN69CbSTQskfCK8p
 QddERaCBN+fCWUMEqcC9ErwxC9vynsI=
X-Google-Smtp-Source: APXvYqxER7bPJRaXaAynp8ONTMbsZcEndBLnJ0jr6jwCtayPXf0RVUaYPB90sqClbWhT15RS0WJdVA==
X-Received: by 2002:a05:6000:1011:: with SMTP id
 a17mr12847113wrx.0.1562062209156; 
 Tue, 02 Jul 2019 03:10:09 -0700 (PDT)
Received: from [192.168.1.38] (56.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.56])
 by smtp.gmail.com with ESMTPSA id n125sm3026304wmf.6.2019.07.02.03.10.08
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 02 Jul 2019 03:10:08 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20190624134337.10532-1-alex.bennee@linaro.org>
 <CAFEAcA_VPcqxVjmSkRYoRRYS9TvM9KXU7e7pww9UofApp42O7Q@mail.gmail.com>
 <874l45sq55.fsf@zen.linaroharston>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <c803aca4-aa53-845b-fc35-8d221df036a1@redhat.com>
Date: Tue, 2 Jul 2019 12:10:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <874l45sq55.fsf@zen.linaroharston>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.46
Subject: Re: [Qemu-devel] [PULL 00/19] testing/next (tests/vm,
 Travis and hyperv build fix)
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/1/19 5:58 PM, Alex Bennée wrote:
> 
> Peter Maydell <peter.maydell@linaro.org> writes:
> 
>> On Mon, 24 Jun 2019 at 14:43, Alex Bennée <alex.bennee@linaro.org> wrote:
>>>
>>> The following changes since commit 474f3938d79ab36b9231c9ad3b5a9314c2aeacde:
>>>
>>>   Merge remote-tracking branch 'remotes/amarkovic/tags/mips-queue-jun-21-2019' into staging (2019-06-21 15:40:50 +0100)
> <snip>
>>
>> OpenBSD also passes but has some output which my 'find warnings'
>> grep picks up:
>>
>> con recv: WARNING: root is targeted by password guessing attacks,
>> pubkeys are safer.
> 
> This is a warning the installer issues before it asks you the question:
> 
>   Allow root ssh login?
> 
> Again this will only occur on the initial setup.
> 
> Can you whitelist these warnings on your script?

Hmm if this is installer-only warning, why not filter it in
OpenBSDVM::build_image()?

