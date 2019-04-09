Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4090C10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 18:47:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B7FA20883
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 18:47:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B7FA20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47650 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDvmf-00045Q-IT
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 14:47:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60635)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hDvli-0003le-Sc
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 14:46:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hDvlh-0004dX-E6
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 14:46:50 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40108)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hDvlg-0004dR-Vu
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 14:46:49 -0400
Received: by mail-wm1-f67.google.com with SMTP id z24so4546664wmi.5
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 11:46:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=iDBmAevVS/srtGkKpjwZ3lR/TD79XnkMTFgVzRa5xic=;
	b=Zpu1W61l1jTofBK4MUf8PDr9ZP9ZfBzeO2CW3so8WXqAYcFaHlwSc5wH+H/o8blfH2
	T2nVnbyIfa5xEM6NTZzkCaQHOk54vYJOg0V+mbo0JXqarJ6t6DgyDJ3HsDyR77rK1NE5
	CxduVUAqU2dvDa5gRlmTSSujXr6416ytJau1OALMRbMFFwc5oqq+NIXb3ATNW6J1YK+0
	uxCXg1KauLJHNXPFv2IYwZnWYtzHpO5jvG9WjUG0JeNihF7hdu2znw+XgQU6mJK6hKYt
	cFsFJ/A2J6n2u+p/eJ1m9kaRTeH8jJj50H1R5xkAVZM4cAxpycnuN6I3C6sw/M15YV3s
	EhNg==
X-Gm-Message-State: APjAAAUPabDcMBf10oYR4BxNL22RUMe6cRocVyMoDTAeKSc4EacW7U+E
	JUkixcW7VDdk2GYLfA/4DDBcJFv1uaE=
X-Google-Smtp-Source: APXvYqxLuCxrypfCG2MbUII831fx4zH/BlddUmGy4o9AComNHAk6xwoJjJFosUbhFrr/jE6UhNuztw==
X-Received: by 2002:a1c:ca07:: with SMTP id a7mr22606782wmg.104.1554835607643; 
	Tue, 09 Apr 2019 11:46:47 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	v6sm40568806wrt.56.2019.04.09.11.46.46
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Tue, 09 Apr 2019 11:46:47 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>,
	Paolo Bonzini <pbonzini@redhat.com>
References: <1554827719-10184-1-git-send-email-pbonzini@redhat.com>
	<CAFEAcA8fs_H-gwk251mCq1V2tOBF=Mr96e4FY0aePyCre-D9NA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <0c2b0c36-26ce-b272-c304-89120c2de489@redhat.com>
Date: Tue, 9 Apr 2019 20:46:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8fs_H-gwk251mCq1V2tOBF=Mr96e4FY0aePyCre-D9NA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [PULL v3 0/5] Misc patches for QEMU 5.0-rc3
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190409184646.-h4d4aFB4Ta00JExX8jyQbwW240oDjI6YpIP53l9oYA@z>

On 4/9/19 7:25 PM, Peter Maydell wrote:
> On Tue, 9 Apr 2019 at 17:36, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> The following changes since commit 248987f92cfda8305d6d44ced23e173e62a8bc0e:
>>
>>   Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-4.0-pull-request' into staging (2019-04-09 10:02:30 +0100)
>>
>> are available in the git repository at:
>>
>>
>>   git://github.com/bonzini/qemu.git tags/for-upstream
>>
>> for you to fetch changes up to 3e20c81ed87cb15cd04f929b075e244e0758641a:
>>
>>   tests: Make check-block a phony target (2019-04-09 18:34:21 +0200)
>>
>> ----------------------------------------------------------------
>> * fixes for Alpine and SuSE
>> * fix crash when hot-plugging nvdimm on older machine types
>>
> 
> Applied, thanks.
> 
> Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
> for any user-visible changes.

The subject says 5.0 <:O) Hopefully Peter applied it for 4.0 :)

Thanks both for this PR,

Phil.

