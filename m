Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E29FBC2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 19:09:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1736208E3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 19:09:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1736208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51452 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZKFR-0002P7-2s
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 15:09:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44340)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hZJG6-0000rb-02
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 14:06:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hZJG4-0007E0-9d
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 14:06:33 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34578)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hZJG4-0006vK-29
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 14:06:32 -0400
Received: by mail-wr1-f65.google.com with SMTP id e16so3062907wrn.1
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 11:06:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=EwvgBqgPzOgq2pGoh9pa98wrkcJch83J3p27+D89V/Y=;
 b=iU/U2c+gFeks/zvoHUdaqRuNzZdUeb+ihHbf5WO7+o1r1cuYTx7EW1TLQziq4MrruT
 dh4sIQIU8zqWgkFDIwHKbKb5BSHiiIJfUwV5o64m+wozsqyF8yNxMHf2iqNkLOihSOuo
 LsZWRk1YBvvSUnfXdnDgzqPFwLP1TbJNviBCFFzLtQYLeup/FtA+w6xeTN9d/mJAf+PC
 H1dCo5QYbNHfoCVrWWbLzgujHR32/UgAsqYra2Xj9/eh6/ZGKTIWeJKw6HNvPIebPGkR
 yqqTAIASBblamZHRdANkJ5EZgvVmZVWR+5R0NvfU0eBRO3XILwRFyvirRQ9xjJbSr6HG
 TRrA==
X-Gm-Message-State: APjAAAXjQEA2RHm4n3M/YV7DshKSFr7eU9nVLy2C9y+fXwSfv224MDkk
 k7OwB651IstlkvcP4ZhiaPQbSw==
X-Google-Smtp-Source: APXvYqwschzukmDeMJNQ0ei72OSTi+8UVf9KO2mvVKeXidZeAPdw6w2W5dlY10qJ/Q9knrjXV8pbSg==
X-Received: by 2002:adf:9dcc:: with SMTP id q12mr8579157wre.93.1559930773446; 
 Fri, 07 Jun 2019 11:06:13 -0700 (PDT)
Received: from [192.168.0.156] ([78.192.181.46])
 by smtp.gmail.com with ESMTPSA id x6sm858091wrr.11.2019.06.07.11.06.12
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 07 Jun 2019 11:06:12 -0700 (PDT)
To: Eric Blake <eblake@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20190607153725.18055-1-philmd@redhat.com>
 <20190607153725.18055-5-philmd@redhat.com>
 <e6e5f4ef-27c1-ce7c-e404-621c86af43ea@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <b65a3316-005a-02cb-8ea4-b956f9c26941@redhat.com>
Date: Fri, 7 Jun 2019 20:06:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <e6e5f4ef-27c1-ce7c-e404-621c86af43ea@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH v18 04/29] !fixup target/rx: CPU definition
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

On 6/7/19 8:02 PM, Eric Blake wrote:
> On 6/7/19 10:37 AM, Philippe Mathieu-Daudé wrote:
>> Rename macros.
> 
> Why is this marked '!fixup' in the subject instead of just merging the
> patches directly?

Since all the series is reviewed/tested and Igor asked to amend a fixup
but we are having hard time to figure if we understand Igor request
correctly, I thought it would be easier for him to review this way, then
for Richard to squash the patches and send the pull request.

Is it confuse/bad practice?

In the cover I wrote:

  If Igor aggrees with the fixup patches, Richard, can you squash
  them and send a pull request?  (without the last patch, which is
  expected to go via Eduardo's tree, but since it is helpful for
  testing this series, I included it).

>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>>  target/rx/cpu.c | 22 ++++++++++++++--------
>>  target/rx/cpu.h | 12 ++++++------
>>  2 files changed, 20 insertions(+), 14 deletions(-)
>>

