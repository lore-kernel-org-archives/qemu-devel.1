Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14CAFC282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 08:44:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E007A24B8C
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 08:44:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E007A24B8C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48742 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hY53V-0003PR-6i
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 04:44:29 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hY52T-0002us-28
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 04:43:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hY52R-0005Ea-2a
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 04:43:24 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40211)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hY52J-0004vM-RW
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 04:43:19 -0400
Received: by mail-wm1-f65.google.com with SMTP id u16so8534227wmc.5
	for <qemu-devel@nongnu.org>; Tue, 04 Jun 2019 01:42:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=qPoEKbMGuvU9BnLXJ9hZZI4+cC8xO+pYsGVRctwfA48=;
	b=ZHQDobvdTDrJZ2SU1+eDTe1YE9b9Y9/V79nNf6/k0aYW+mkqapJXR4S4Uf+T/tNvlO
	llFvOP+2kI6KpZGX87jAn4vr6NGzzPIBjAxVlxDLQgDhM7gm3lIkeqRr8o+OGDu3ErOr
	2e//iKH3JfrCKi8ggEpyfr3zgUjatdommYPmDpPUELgLTQj/r2mM0SOdbMw2nbx0ms+e
	2iiihkwByhJKnOv70S8evNMkrPLdiDIKwZ+7+PIY2S9SI19KWuKTeihh+ZcOoZoTGXBN
	rojwo3qU3MkyekyK9wUfmbQBM71NlUbkfcf6CdSoj1SXjppmr2A8rSF+LyIL30F7S0JJ
	66eA==
X-Gm-Message-State: APjAAAV8kQUdOYagjmvdOWLlo5GSKWd90p8q96QjpbgNuZ7ST5DRqKuJ
	K3Dpn8GiqYhNy4p+3A4YqQtK2g==
X-Google-Smtp-Source: APXvYqxsD1upUD2ZAyiNPGJo8hj6T/ciAwUwZAm8OI5qzx3BjzWSAo+yKuuIIpQ8C7CBkh4v4TsjZA==
X-Received: by 2002:a7b:c933:: with SMTP id h19mr17879429wml.52.1559637773256; 
	Tue, 04 Jun 2019 01:42:53 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
	[88.21.202.183])
	by smtp.gmail.com with ESMTPSA id l1sm5952310wmg.13.2019.06.04.01.42.52
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Tue, 04 Jun 2019 01:42:52 -0700 (PDT)
To: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster
	<armbru@redhat.com>, qemu-devel@nongnu.org,
	"qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>
References: <20190604080010.23186-1-armbru@redhat.com>
	<ff72b9fc-003f-275a-d382-860f2a483d60@redhat.com>
	<803fdb35-f28e-c033-b5ac-02d230dacf94@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <56d043be-efd0-cfb5-2c68-30855eb42d03@redhat.com>
Date: Tue, 4 Jun 2019 10:42:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <803fdb35-f28e-c033-b5ac-02d230dacf94@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PATCH] test: Fix make target check-report.tap
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

On 6/4/19 10:28 AM, Paolo Bonzini wrote:
> On 04/06/19 10:09, Philippe Mathieu-Daudé wrote:
>>>  check-report.tap: $(patsubst %,check-report-qtest-%.tap, $(QTEST_TARGETS)) check-report-unit.tap
>>> -	$(call quiet-command,./scripts/tap-merge.py $^ > $@,"GEN","$@")
>>> +	$(call quiet-command, cat $^ | scripts/tap-merge.pl >$@,"GEN","$@")
>> Paolo, did you intend to submit a new tap-merge.py script in commit
>> 9df43317b82?
>>
> 
> No, it's really just y vs l.

OK!

> 
> Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
> Cc: qemu-trivial@nongnu.org

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

