Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 177C5C28CC0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 15:57:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC57323C94
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 15:57:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC57323C94
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57023 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hW0x6-0003Hn-WB
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 11:57:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57607)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hW0vw-0002WB-BI
	for qemu-devel@nongnu.org; Wed, 29 May 2019 11:56:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hW0vv-0003Ao-CM
	for qemu-devel@nongnu.org; Wed, 29 May 2019 11:56:08 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40001)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hW0vv-00036T-5G
	for qemu-devel@nongnu.org; Wed, 29 May 2019 11:56:07 -0400
Received: by mail-wr1-f65.google.com with SMTP id t4so2164423wrx.7
	for <qemu-devel@nongnu.org>; Wed, 29 May 2019 08:56:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=jTz4HqNA9exRiAH5IpZGzZJh95v62szgh4vP1BY39vI=;
	b=ekIu9B6bZzjrWS5J7sO48qKp5kMQW9FfNKQQZ0lExRsZhdQbKT9b4rDD/jk3vdxEBZ
	7EbMSOoMzwa2CPRmdd2NXQL68xICbQYhT3J3AfnkXxBMT9FJhFCPbcrdVP9/g9nC7lT9
	QvxC7OD15F95p0hnUJrruWW4fMqQa7EUH8GSW36w40U0bS/rH/JVafB1UeJK9H/7ZVPw
	Gmfx+SQyJ+RyQplSwS3xODVlYyVJnwV9HXPzveL+HjC7EoTAl3jRO9WtrQBiKyTlwMcf
	wxe0wNhgbFrtqfFtQBcoNZhlq1LUW1lczFBkhHCqF9J/liXHV/Jkn3ShQK5fNHWbDWqC
	GMkg==
X-Gm-Message-State: APjAAAWh8TQ2L0Giyh0I3VMMuEhs5fzTIoCUfn0jSyLN6uUT/m0I/Fm2
	9uGWTaXTqfAN3T5LrSC6nlE6sw0VXTU=
X-Google-Smtp-Source: APXvYqwmnfNFl2eaIAihjLfr9LenC6ussMXpCVBMvJJy8wRm8xwKOtZHF8rXdhHu1rR9IFvyJ9R2jA==
X-Received: by 2002:adf:c709:: with SMTP id k9mr7339945wrg.144.1559145365833; 
	Wed, 29 May 2019 08:56:05 -0700 (PDT)
Received: from [10.201.33.53] ([195.166.127.210])
	by smtp.gmail.com with ESMTPSA id h8sm13828253wmf.5.2019.05.29.08.56.04
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Wed, 29 May 2019 08:56:04 -0700 (PDT)
To: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
	qemu-devel@nongnu.org
References: <20190529150853.9772-1-armbru@redhat.com>
	<20190529150853.9772-3-armbru@redhat.com>
	<84e2792c-3fd3-3236-dc45-83405abb9a12@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <1ddf4672-eea7-d4de-62ae-930f98f388be@redhat.com>
Date: Wed, 29 May 2019 17:56:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <84e2792c-3fd3-3236-dc45-83405abb9a12@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH 2/3] MAINTAINERS: Improve section headlines
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

On 5/29/19 5:16 PM, Eric Blake wrote:
> On 5/29/19 10:08 AM, Markus Armbruster wrote:
>> When scripts/get_maintainer.pl reports something like
>>
>>     John Doe <jdoe@example.org> (maintainer:Overall)
>>
>> the user is left to wonder *which* of our three "Overall" sections
>> applies.  We have three, one each under "Guest CPU cores (TCG)",
>> "Guest CPU Cores (KVM)", and "Overall usermode emulation".
>>
>> Rename sections under
>>
>> * "Guest CPU cores (TCG)" from "FOO" to "FOO CPU cores (TCG)"
>>
>> * "Guest CPU Cores (KVM)" from "FOO" to "FOO CPU cores (KVM)"
>>
>> * "Guest CPU Cores (Xen)" from "FOO" to "FOO CPU cores (Xen)"
>>
>> * "Architecture support" from "FOO" to "FOO general architecture
>>   support"
>>
>> * "Tiny Code Generator (TCG)" from "FOO target" to "FOO TCG target"
>>
>> While there,
>>
> 
> Unintentional truncation? Or leftover thought that should be removed
> after you instead split things?

leftover :)

"While there, polish headline decorations"

> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  MAINTAINERS | 78 ++++++++++++++++++++++++++---------------------------
>>  1 file changed, 39 insertions(+), 39 deletions(-)
> 

