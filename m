Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EFD8C0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 12:28:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 560512080C
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 12:28:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 560512080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hieMx-0003xA-Cp
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 08:28:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53402)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hieLn-0003M4-3C
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 08:27:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hieLm-0007gP-0q
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 08:27:03 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]:34180)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hieLl-0007eo-QJ
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 08:27:01 -0400
Received: by mail-wr1-f45.google.com with SMTP id u18so2615495wru.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2019 05:26:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:cc:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hUVolFCe2ntH5RMepW2y2IzgIvXKXGhK3evw12CedRw=;
 b=ovN+4ljzn0kfkN2ChHemPHMbRnBFB5Jm9hBtLIDOG7It/hDKZHo8qr4++sct/ytp7c
 ZmodfjeCdSYvEQCdRzwMbuu5in/zw8Lk3Hh8o9T1rOJujeh4SOy0fEC6sa0/+sd06LzY
 2zIPWzyNf/CU8y/BEq3JaZaa5odPjYlammxkJcLpGHeTHqWYgxuvDnVTRygoONELKmWQ
 o+XfTBE1RZsEjiWhemNt1DMaorfkUglh+R66AtGyH6/itf4DFQOj1rkvlAJvNyPaCL3V
 mybS3oXiQ205VC0YkasjlWiHnOwLrQEageHq6FhEA1G09zXqV6MP2movciDSgzuxHa8U
 ryzw==
X-Gm-Message-State: APjAAAWn+Huv1lws+gCVWNHC5rMBJ04CPmCsRDq4O7keHEzfBXRg1GX0
 zuPJOlzsZksS/71aTUIJfyEWHA==
X-Google-Smtp-Source: APXvYqwlFIDQfViJg3EKOOkS0NA5JNRTckHA/+mZC65xabDU3Qr9c5RBX8eHdUFcst4/9ic4RDYvMA==
X-Received: by 2002:adf:bc4d:: with SMTP id a13mr16562427wrh.296.1562156818176; 
 Wed, 03 Jul 2019 05:26:58 -0700 (PDT)
Received: from [192.168.1.38] (56.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.56])
 by smtp.gmail.com with ESMTPSA id p4sm1155447wrs.35.2019.07.03.05.26.56
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 03 Jul 2019 05:26:57 -0700 (PDT)
To: Sean Bruno <sbruno@freebsd.org>, QEMU Developers <qemu-devel@nongnu.org>, 
 Kamil Rytarowski <kamil@netbsd.org>, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <5dd3d27a-e630-4e92-43fa-13c131e9f880@freebsd.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <75c05e38-1dfe-81a0-a403-791489173fed@redhat.com>
Date: Wed, 3 Jul 2019 14:26:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <5dd3d27a-e630-4e92-43fa-13c131e9f880@freebsd.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.45
Subject: Re: [Qemu-devel] New Year's starting over ... bsd-user
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

[Reviving an old thread]

Hi Sean,

On 1/3/17 5:18 PM, Sean Bruno wrote:
> I'm pondering where to start with getting FreeBSD's bsd-user code into
> shape so it could actually be reviewed and accepted now that its sort of
> working again (signal handling fixed finally).
> 
> I almost feel like the existing code should be purged, except that it
> gives a good history (and this seems lazy to me).
> 
> As a first pass, I guess, I'd like to at least make i386 user run on
> x86_64.  What would you folks like to see in a first pass?
> 
> sean
> 
> ref: https://github.com/seanbruno/qemu-bsd-user/tree/bsd-user

Looking at your repository I see you are still active and merging
patches from other users.

Could you summarize how your tree differs from the upstream one?
I guess your work could benefit other users, stucked at the current
broken state of bsd-user.

Some users who reported they switched to the Unicorn Engine [*], I
haven't looked at it yet, since I found this thread first, while reading
on deprecating unsupported code (another old thread):
https://lists.gnu.org/archive/html/qemu-devel/2017-03/msg03519.html

Thanks,

Phil.

[*] https://www.unicorn-engine.org/


