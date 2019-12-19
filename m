Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4237C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 11:15:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E8AC206D8
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 11:15:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FTXWYLeD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E8AC206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihtm2-00009E-53
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 06:15:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41093)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ihtj6-0004NX-Cx
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 06:12:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ihtj3-00033o-Iy
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 06:12:15 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:35804
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ihtj3-000311-3s
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 06:12:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576753931;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1g5pi4hp6gqHZ8DFxclQTjsmnPlys216sRd5vj+hVAY=;
 b=FTXWYLeDMTE+dZRTF7i2E+9s+Hp50/j+Jc/tozbrlIGecGes9U+8xpCo2CDa9PmeHIY6tz
 8YgiIevFmrYM2yB8i859HX/DqEBTrlBZLSxgv3UmG7GqgwEplFNzObjn9T4Nvtdnwgzwp+
 TGk7lovdXxqfYmrAWEZ7aM3SsR8EbKk=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-sgnX5-_hPoqVTS6FGPFLIw-1; Thu, 19 Dec 2019 06:12:10 -0500
Received: by mail-ed1-f71.google.com with SMTP id y26so3305059eds.5
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 03:12:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8USiJNxg29+iVGEwRviVamr5n06M50bnccsfaM/5ZCY=;
 b=Ua17HzFPKpVUekKP8/x4Cm08ffob72uGocusDO2H/TLRfLPGMkKv2laBKZe07kWfSN
 axp3bvEaNsuqjitNra0Gqn79NoZCpzb5jNVuh2y9b0ITi0UON4IwreQISccyWnygtzXu
 3zJs9sJ8uWE6MDE1SU7+6OUrhZxgZgFbzj2juMXXRX3OCz05rBmrxKhXXLQqO/bFQWOg
 sIgBrLK/aOZMELkeHHqF3SLCehJhIbUWJf3gDOayzPFFqBlIzoQf9DLxB4Mw/JjuitxE
 uRbQSXoviE3ZCK1a/rm6diGIpOrzXDCNR9dh8ktUGTgktOd81Exxk/yqOT+jeOghkkRO
 49rQ==
X-Gm-Message-State: APjAAAUKYvxoHQStYkv8omMFpdpg/d7a1BjUHcEZ957hrlvrM1RzASaj
 Q4olOWegKbl9pc7XSSFZyR+SB113tQVGI5FPFPQLql6dWcyCJsR5VZuxe5+g+LYz5+y7ERSHvJk
 4UjGxrHhgCGI0xss=
X-Received: by 2002:a17:906:4bcb:: with SMTP id
 x11mr8905083ejv.100.1576753929422; 
 Thu, 19 Dec 2019 03:12:09 -0800 (PST)
X-Google-Smtp-Source: APXvYqyuyzenKTDcLxh5UH6vbDHaBEpwsCCSnT0dA93KzfYKQR+MUN01wfzi+MJTrNHUUQYHj7VfXg==
X-Received: by 2002:a17:906:4bcb:: with SMTP id
 x11mr8905052ejv.100.1576753929205; 
 Thu, 19 Dec 2019 03:12:09 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id dc5sm319423edb.61.2019.12.19.03.12.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Dec 2019 03:12:08 -0800 (PST)
Subject: Re: [PATCH v8 1/4] Acceptance tests: introduce BLD_DIR, SRC_DIR and
 LNK_DIR
To: Cleber Rosa <crosa@redhat.com>
References: <20191218232500.23530-1-crosa@redhat.com>
 <20191218232500.23530-2-crosa@redhat.com>
 <3362e435-73be-f5c3-a672-6208f2bacd95@redhat.com>
 <20191219002539.GA29918@localhost.localdomain>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <1d90bf81-7acb-f80c-959f-95ab8fee899b@redhat.com>
Date: Thu, 19 Dec 2019 12:12:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191219002539.GA29918@localhost.localdomain>
Content-Language: en-US
X-MC-Unique: sgnX5-_hPoqVTS6FGPFLIw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Fam Zheng <fam@euphon.net>, Beraldo Leal <bleal@redhat.com>,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/19/19 1:25 AM, Cleber Rosa wrote:
> On Thu, Dec 19, 2019 at 01:02:39AM +0100, Philippe Mathieu-Daud=E9 wrote:
>> On 12/19/19 12:24 AM, Cleber Rosa wrote:
>>> Some tests may benefit from using resources from a build directory.
>>> This introduces three variables that can help tests find resources in
>>> those directories.
>>>
>>> First, a BLD_DIR is assumed to exist, given that the primary form of
>>> running the acceptance tests is from a build directory (which may or
>>> may not be the same as the source tree, that is, the SRC_DIR).
>>
>> Can we name this BUILD_DIR?
>>
>=20
> Yes, of course.
>=20
>> This would be more in line with the other buildsys files (configure/make=
).
>>
>=20
> That's a good point.
>=20
>>> If the directory containing the acceptance tests happens to be a link
>>> to a directory (kept as LNK_DIR), it's assumed to it points to the
>>> source tree (SRC_DIR), which is the behavior defined on the QEMU
>>> Makefiles.  If the directory containing the acceptance tests is not a
>>> link, then a in-tree build is assumed, and the BLD_DIR and SRC_DIR are
>>> the same and LNK_DIR is set None.
>>
>> Similarly, can we name this CURRENT_DIR instead of LNK_DIR?
>>
>=20
> Yes, or maybe even drop it?  TBH, I can only see use cases for build

I haven't checked why you needed to add it, so if we don't need it,=20
let's drop it :)

> and source dirs.  So, I assume you'd propose SRC_DIR would be
> SOURCE_DIR?

This one is understandable as it, but SOURCE_DIR is cleaner indeed.

Thanks,

Phil.


