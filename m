Return-Path: <SRS0=9jkQ=VP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D715C76191
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 08:58:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45EAE2173E
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 08:58:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45EAE2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ho2FT-00052W-9F
	for qemu-devel@archiver.kernel.org; Thu, 18 Jul 2019 04:58:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60812)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1ho2FD-0004BI-4q
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 04:58:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ho2FB-0000RS-Pw
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 04:58:30 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]:41230)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ho2FB-0000QG-FX
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 04:58:29 -0400
Received: by mail-wr1-f41.google.com with SMTP id c2so24564201wrm.8
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2019 01:58:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=229f7PLtEEbGDai1zpI8Eg0paoVVLuL+yF+ZoQ2tn9c=;
 b=paPUG3EXJwd/I1lfjd+/qThL/TQUD4DgjE3Xksgn0/ol4+c4Qa3GyiUgopw4y8GpQw
 9nDW9PKI3CLzQkh+zn3wSiiDJFXMtIdiLPANbH58MHq3dqNq2+95KmYdaPn0htdaxLwl
 KAZ69EpyUfGij4krPG2yJFWd+e4pfED70ERFQXzI16aAHYKJPQPMPiBj3cjDyE32thBE
 oyE2TIIVGtcd6tfXkPxfuQQG3578s282fWofhJRWG3euAioZd2Q5FnSb/evTwftAIPRv
 BDQtmifatvt2Kgj1OuYaY85opJi8ye+THC66LbHxRA+LzWY5okB7dmsZgCLb2G2fQJoK
 X+xg==
X-Gm-Message-State: APjAAAWnhozqNtNERoQ5bFZLBq/+QDM/d2nU0xkpTVTFWr5ZkukgQOtX
 lFkKR1OJz+o57ENK3kTXFhUrLg==
X-Google-Smtp-Source: APXvYqygojA6MTBn4VGVTcraAEEI5rshpn8eNRk3xs9SvPAeLJDAOLk9pKu8IToZfQAjrYS1hVrHqg==
X-Received: by 2002:a5d:63c8:: with SMTP id c8mr5935483wrw.21.1563440308146;
 Thu, 18 Jul 2019 01:58:28 -0700 (PDT)
Received: from [192.168.1.37] (62.red-83-42-61.dynamicip.rima-tde.net.
 [83.42.61.62])
 by smtp.gmail.com with ESMTPSA id k63sm33911375wmb.2.2019.07.18.01.58.27
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 18 Jul 2019 01:58:27 -0700 (PDT)
To: Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 "Daniel P. Berrange" <berrange@redhat.com>, Stefan Weil <sw@weilnetz.de>
References: <cb727b5d-683f-115d-f3c0-06f5a6761aea@redhat.com>
 <126a3ec4-f5e3-0590-011a-9c2a10d07b24@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <bf5da6c7-74c1-8950-2869-2d94419f1820@redhat.com>
Date: Thu, 18 Jul 2019 10:58:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <126a3ec4-f5e3-0590-011a-9c2a10d07b24@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.41
Subject: Re: [Qemu-devel] No archives to download from www.qemu.org/download/
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/18/19 9:10 AM, Thomas Huth wrote:
> On 18/07/2019 08.25, Philippe Mathieu-Daudé wrote:
>> When building from the GitHub generated archive
>> (https://github.com/qemu/qemu/archive/v4.1.0-rc0.tar.gz)
>> we get:
>>
>> ---
>> $ ./configure
>>
>> ERROR: missing file /tmp/qemu-4.1.0-rc0/ui/keycodemapdb/README
>>
>> This is not a GIT checkout but module content appears to
>> be missing. Do not use 'git archive' or GitHub download links
>> to acquire QEMU source archives. Non-GIT builds are only
>> supported with source archives linked from:
>>
>>   https://www.qemu.org/download/
>>
>> Developers working with GIT can use scripts/archive-source.sh
>> if they need to create valid source archives.
>> ---
>>
>> Now there are no archive to download at this url...
> 
> You just have to click on the "Source code" tab ... is that too hard?

Argh it has been a rough night, now I feel ashamed. I scrolled but
missed that tab. Really sorry for crying wolf here :/

