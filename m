Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE65C433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 14:02:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51E1C206C2
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 14:02:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51E1C206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxXN9-0005t8-KS
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 10:01:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35702)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hxXMH-0004gP-Bs
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 10:01:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hxXMG-0002qZ-CU
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 10:01:05 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:39752)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hxXMG-0002px-68
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 10:01:04 -0400
Received: by mail-wr1-f52.google.com with SMTP id t16so17742508wra.6
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2019 07:01:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=S2nzCLiSk42XqO7Hc9bFKIwIPGuATEaC1EipNq0MK24=;
 b=mwVfcwZGPb3sf2vNZDvQ19La63PH7aWoG1EwYimRPh0cv0Rw4V0XrJhqBOwqKptMvE
 LWsQ/EoiWVNozlpl930ev0BuwxsIhCSQJOMEyn5RMWXMWMCqTe335h9mj3WUtwF39rFn
 +MtunsLNGF55DvhaA3/RRq0q8EQizw5g4qdYK/WvmoIQJUJsvpNUBjH52PQSBX1Hcwrv
 Z5FViX+J7Nb/2TB01LGDkApGYiSelpem45FBe+1J+BBZk5VQalMlNiaho7tsYEepB3FV
 vwhJqohbRScsI6y7HXWeUIiAtFyrBSI8HngFfSxUbNJ+5HNrWm6otwyklERhtrDoTs0w
 6BQQ==
X-Gm-Message-State: APjAAAUqmgyLksbjpDbB1xu+bAQNxnV4zacjBBI7sHfQNLTzfCISkQ8Y
 Ozn2x4PdgU+oc2aPdEjTZvDxYg==
X-Google-Smtp-Source: APXvYqzpauQy+iebN+0kE0RqYGMJnNf8UTaLnw6WyhbJFeC/axiU9nWVAk+E63RVqluXXgqBCTSydg==
X-Received: by 2002:adf:dec8:: with SMTP id i8mr5182289wrn.217.1565704863100; 
 Tue, 13 Aug 2019 07:01:03 -0700 (PDT)
Received: from [192.168.1.35] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id a2sm1370975wmj.9.2019.08.13.07.01.02
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 13 Aug 2019 07:01:02 -0700 (PDT)
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20190712133928.21394-1-philmd@redhat.com>
 <421f2fb2-6e8d-7579-029a-e8de726c6a5e@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <56d102b4-3f55-7070-c012-56ad65138873@redhat.com>
Date: Tue, 13 Aug 2019 16:00:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <421f2fb2-6e8d-7579-029a-e8de726c6a5e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.52
Subject: Re: [Qemu-devel] [PATCH-for-4.1? 0/7] vl: Allow building with
 CONFIG_BLUETOOTH disabled
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, qemu-arm@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Miroslav Rezanina <mrezanin@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/15/19 3:13 PM, Thomas Huth wrote:
> On 12/07/2019 15.39, Philippe Mathieu-Daudé wrote:
>> A series of obvious patches to build without the deprecated
>> bluetooth devices. Still worth for 4.1 or too late?
>> It is clearly not a bugfix.
> 
> I wonder whether this series is worth the effort right now, or whether
> we should simply nuke the bluetooth code after 4.1 has been released?

Well, perfect is the enemy of good :)

This series is already done and is an improvement to what we have.

Regarding nuking it, it depends on the Nokia N-series boards, they might
become useless without BT support.

Peter, as a maintainer of these boards, what do you prefer?

Thanks,

Phil.

