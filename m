Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0FAAC2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 19:25:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 427F2208C0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 19:25:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 427F2208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51724 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZKU3-0000AU-Nr
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 15:25:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44867)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hZJID-0002ZO-GK
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 14:08:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hZJIA-0001Ph-Of
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 14:08:45 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41483)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hZJIA-0001ML-IS
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 14:08:42 -0400
Received: by mail-wr1-f65.google.com with SMTP id c2so3026647wrm.8
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 11:08:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1FSb5TW4zUOhdoNpagbT9woia/2lTvP4MogienbhEO8=;
 b=JS9s/UFrHiyC/SvDf7+Ld1rFcyuS2lycdTBLnc9TXyMC1oxy3qd/+fElHAPl/hEy+E
 ohVbJtHOHaxUExVOMIh4b1nWr1MyN3V0s7V7TN1BBac6lOH5xT1zkUENZ5mNi4wJ/3Z1
 Yw4QRnUBfFr2rKsnDiESVLl87+WXOItzUP+Ahluz0IrvYDFyFzSYzICsPQVq1ZUBMKH7
 a5npvuxYI8HQl515QbJDmRAbbpqYQmHQQlW27CPSi1DvNpenZBvM477ckhOzQvZvFlbY
 UWaHHxXegJ9H5IoC+4s17N+c+tvbBOzoU+mnQ9i7mcMOzw+uAK12SH3mxLHJHNuM6mNn
 iGEQ==
X-Gm-Message-State: APjAAAUUMqRNC6jCGyh67uf1zsrsv8rawI6pDJKU9UA3QHQKtvXydT0O
 HvuxRm92Cg3U5ke58d/Qz+Acqw==
X-Google-Smtp-Source: APXvYqxd7faCCtiX/Nsg7s1NhcGYSyhFgbQ1ApX8Yt02+wz07iZbNygLcwsR9eApvUJSf6mzRqfRsg==
X-Received: by 2002:adf:b69b:: with SMTP id j27mr11310375wre.328.1559930920516; 
 Fri, 07 Jun 2019 11:08:40 -0700 (PDT)
Received: from [192.168.0.156] ([78.192.181.46])
 by smtp.gmail.com with ESMTPSA id j8sm1404439wrr.64.2019.06.07.11.08.39
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 07 Jun 2019 11:08:40 -0700 (PDT)
To: Eric Blake <eblake@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20190607153725.18055-1-philmd@redhat.com>
 <20190607153725.18055-16-philmd@redhat.com>
 <de0ec4fd-9041-4926-7920-d66618b78113@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <841d30bd-4ec7-29b8-c7fb-7fe208a0d3bc@redhat.com>
Date: Fri, 7 Jun 2019 20:08:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <de0ec4fd-9041-4926-7920-d66618b78113@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH v18 15/29] target/rx: Add RX to SysEmuTarget
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
Cc: Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/7/19 8:04 PM, Eric Blake wrote:
> On 6/7/19 10:37 AM, Philippe Mathieu-Daudé wrote:
>> From: Richard Henderson <richard.henderson@linaro.org>
>>
>> Fixes check-qtest-rx: tests/qmp-cmd-test
> 
> Is that in master? If so, what commit id; if not, why not just squash
> this into that patch before merging it?

Right, we should squash it in "[PATCH v18 18/29] Add rx-softmmu" IMO.

