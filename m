Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 596D3C04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 14:41:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E68D2173E
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 14:41:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y5lw0Z06"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E68D2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54963 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT5xY-0002sQ-En
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 10:41:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46395)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hT5wJ-0002HM-2o
	for qemu-devel@nongnu.org; Tue, 21 May 2019 10:40:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hT5wH-0006js-I3
	for qemu-devel@nongnu.org; Tue, 21 May 2019 10:40:27 -0400
Received: from mail-yb1-xb42.google.com ([2607:f8b0:4864:20::b42]:39220)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hT5wG-0006jD-Sy
	for qemu-devel@nongnu.org; Tue, 21 May 2019 10:40:25 -0400
Received: by mail-yb1-xb42.google.com with SMTP id a3so4012218ybr.6
	for <qemu-devel@nongnu.org>; Tue, 21 May 2019 07:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:from:to:references:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=AFqZSUfshh40XPhFrhSh6f33dTnjFn+2C+zJ/ZhwozA=;
	b=Y5lw0Z06uTov4fGlXRnxLAyo2uytqzbzk9J4uu8e7yY1QRszHZlVkp4bGgjXDQbOmL
	wpBNjc6bDjXwTzaV69KLcVJ+ewqaKC56dTaMZ4LNAIgKwYLp+ctTRKgp25nchwrsRwgB
	oJ+hXzxoqX2g1K+HiB9NZMwdsd4VOrnla77wDNNZM8f+NCJaheser+lSa7TNZv4TkhaY
	4bcZ9u0x6FkI7QynMdqDwEaeFSVNykl3olOoSWGarbf8NcasqiTmkZg7ahPQ032FOTu0
	cFwKToAv1Hig8ELMsHztP4mqNEN1H9u/goz46s0GDOUiAqSCTbEHOpNbentSuoQkQMAs
	Zl9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:from:to:references:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=AFqZSUfshh40XPhFrhSh6f33dTnjFn+2C+zJ/ZhwozA=;
	b=BqxPEcKAI2vWqIoLB3cG+NO8win7a2y1wx885OQFeJeTUwTbTIhKtmcFZmu9NdD79B
	MfAg58zaJIUe74ttLh0T9Ym4bv3KgzpzVVHhDxqkDy5IaITnTdM06ymMhj5CfHlwh7Xj
	HibmGkK8baI3G7bAfI/ltMmSMG/4uxFVpSQ1YlnNS0R9HF5rceaeRjbqOTKVKQZakmkz
	MSVrmRCyNToNM5U1KvxLVGYWktvIhEiodnzvPwFFMOab6gU0qiqLjHr2w3guACB41zje
	+tOSk434AaIud6C07hIkUtfj6Owjlh3igAlu5wCkxOG/I1NoBZFGFDYagHZY5afiD70R
	WXNA==
X-Gm-Message-State: APjAAAWhaCA8cdnD26kSbdV7Tlv2/ScvAL80cNLnyxh7RrlW9a4O8AWa
	j5SAyWy38Ncr8byFRTz9c+p7adclTBA=
X-Google-Smtp-Source: APXvYqxABriIdm8khK1Q2uj7kVHfaplG9zOjEU2bTKESIBVkMvQr/B9E7jzgXrE2zF0lmUbco6LHEw==
X-Received: by 2002:a05:6902:4cf:: with SMTP id
	v15mr5022226ybs.199.1558449622999; 
	Tue, 21 May 2019 07:40:22 -0700 (PDT)
Received: from [10.240.180.184] ([71.46.56.58])
	by smtp.gmail.com with ESMTPSA id i1sm5795908ywa.19.2019.05.21.07.40.22
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 21 May 2019 07:40:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
	qemu-devel@nongnu.org
References: <20190521093227.4661-1-berrange@redhat.com>
	<10d9f115-337e-f14e-c79a-93d98d72248b@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <14e4acb0-cabb-cdb5-831c-5d5e388997b0@linaro.org>
Date: Tue, 21 May 2019 10:40:20 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <10d9f115-337e-f14e-c79a-93d98d72248b@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::b42
Subject: Re: [Qemu-devel] [PATCH] authz: optimize linking of objects for
 authorization services
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/21/19 10:39 AM, Richard Henderson wrote:
> On 5/21/19 5:32 AM, Daniel P. Berrangé wrote:
>> The core authorization API is a dependancy of the crypto code for the
>> TLS servers. The TLS server code is pulled into anything which links
>> to the crypto objects, which is every QEMU tool. This in turns means
>> that every tool ended up linking to the authz code, which in turn
>> pulls in the PAM library dep.
>>
>> This splits the authz code so that everything links to the base object
>> which defines the API. Only the system emulators and qemu-nbd link to
>> the object classes providing the implementations of the authz object
>> API. This has the effect of removing the PAM library dep from qemu-img,
>> qemu-io and other helper tools.
>>
>> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
>> ---
>>  Makefile            | 5 +++--
>>  Makefile.objs       | 1 +
>>  Makefile.target     | 3 ++-
>>  authz/Makefile.objs | 9 +++++----
>>  4 files changed, 11 insertions(+), 7 deletions(-)
> 
> No changes to tests/?  Surely that means some tests no longer link?

Or I could notice your v2, farther down in my mailbox...  ;-)


r~

