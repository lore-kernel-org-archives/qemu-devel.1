Return-Path: <SRS0=McoT=XE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DAEAC4740A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 15:04:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25ED12086D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 15:04:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CG0BciGl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25ED12086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7LD9-0005QC-8g
	for qemu-devel@archiver.kernel.org; Mon, 09 Sep 2019 11:04:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47842)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i7LBp-0004op-IJ
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 11:02:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i7LBn-0000Ly-SF
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 11:02:49 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:39538)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i7LBn-0000LN-ID
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 11:02:47 -0400
Received: by mail-wm1-x342.google.com with SMTP id q12so15118210wmj.4
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2019 08:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=bIZz3WCVyfRuWabTAHvQTz9bv/FAI2+7WA4tHFnOxrM=;
 b=CG0BciGlOVkXCejd9wzBx6NWHhwCveh0z7Kb1LB9CD7J8BPa+HvvnTOJH4xezW6XJh
 3KcCY9uzZSTY6tksVKqAJ5P+HwEZvcsCsn8mzGr5aSniaZ2fefdcfVb8Jli2FYpweF5x
 nVvgtXZOJjqOgohAo8LYSxd3oqX5MQdTVRrEgX25+NsPHDeiW0alg0tD/Kie5ydzQqL/
 tBaZux/5li9mnjdnfnDncqCJMiBp3vYfRns9Sclagjb7gEHTHgEptlTzNeLXy6hUuQEI
 hZQ0BFe1OYmTgnJg0hUPBkmZdUAV3z9dEo1s5VWJhJdJi51rnObWq4m9xGFJSUxRDE4z
 ByJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=bIZz3WCVyfRuWabTAHvQTz9bv/FAI2+7WA4tHFnOxrM=;
 b=YF9jE+5Rc0ALwOInoyOnbVqlwJQVZFHaN03bhQLyx2XL2uUkS8DwqjDC0JhwsjTOEB
 8TesvUnv5bqYDLHdtgr4vkrtciXnSVF9VDm+ZeWL27yt7U+yQSKlJEvT5YVoosLdbUkl
 s+yZ/sTKs09v8WoWoSweWSl+xvlEkW/sk63ZOFLCeyHyQ4hvm7epccRupQ387k6HR9sz
 u8aKdRwAzW/y6SJt6+9txFjsYLB1ZHupneSSwqxUbNbvHlwh6pM21U59pSGUBktsAjV4
 WXSA04nhO3fY3a+JD6KgJoVbIpC1niIP9NMqs4UyveHQRZwMIZkq8Mi2nFQur3a+zJF8
 p/MA==
X-Gm-Message-State: APjAAAVV073n9kaJtkr5HBrzdn6HgHwm142MIClTcQs8Nq+1MoqfRI1N
 e2s6d+Ybh6ZTMJycdhXDvnTI4n8/gu4=
X-Google-Smtp-Source: APXvYqy1YbPAdR6G4JK0RqCi53+yr7AukodBc4seAaSk3ZVWCjYszrd69Yl67onbOoaOjeJuDiFAWA==
X-Received: by 2002:a7b:c4d6:: with SMTP id g22mr19037110wmk.21.1568041365628; 
 Mon, 09 Sep 2019 08:02:45 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id g3sm23095887wrh.28.2019.09.09.08.02.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2019 08:02:44 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 353321FF87;
 Mon,  9 Sep 2019 16:02:44 +0100 (BST)
References: <20190909135842.25469-1-alex.bennee@linaro.org>
 <20190909141100.GK24509@redhat.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
In-reply-to: <20190909141100.GK24509@redhat.com>
Date: Mon, 09 Sep 2019 16:02:44 +0100
Message-ID: <87r24p1pij.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: Re: [Qemu-devel] [qemu-web PATCH v2] add support page
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
Cc: pbonzini@redhat.com, thuth@redhat.com, qemu-devel@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Mon, Sep 09, 2019 at 02:58:42PM +0100, Alex Benn=C3=A9e wrote:
>> This is intended to be a useful page we can link to in the banner of
>> the IRC channel explaining the various support options someone might
>> have.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>
>> ---
>> v2
>>   - add cleanups suggested by Stefan
>> ---
>>  support.md | 40 ++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 40 insertions(+)
>>  create mode 100644 support.md
>
> I would have expected some other file to be modified to link to this
> page from elsewhere on the website too.

The initial use-case is to link from the IRC channel so I avoided making
a decision on the layout of the rest of the page.

>
>>
>> diff --git a/support.md b/support.md
>> new file mode 100644
>> index 0000000..9174bbb
>> --- /dev/null
>> +++ b/support.md
>> @@ -0,0 +1,40 @@
>> +---
>> +title: Support
>> +permalink: /support/
>> +---
>> +
>> +If you have a support question that is not answered by our
>> +[documentation](/documentation) you have a number of options available
>> +to you.
>> +
>> +If the question is specifically about the integration of QEMU with the
>> +rest of your Linux distribution you may be better served by asking
>> +through your distribution's support channels. This includes questions
>> +about a specifically packaged version of QEMU. The QEMU developers are
>> +generally concerned with the latest release and the current state of
>> +the [master branch](https://git.qemu.org/?p=3Dqemu.git) and do not
>> +provide support for QEMU binaries shipped by Linux distributions.
>> +
>> +Questions about complex configurations of networking and storage are
>> +usually met with a recommendation to use management tools like
>> +[virt-manager](https://virt-manager.org/) from the [libvirt
>> +project](https://libvirt.org/) to configure and run QEMU. Management
>> +tools handle the low-level details of setting up devices that most
>> +users should not need to learn.
>> +
>> +* There is a
>> +[qemu-discuss@nongnu.org](https://lists.nongnu.org/mailman/listinfo/qem=
u-discuss)
>> +mailing list for user focused questions<br>
>> +If your question is more technical or architecture specific you may
>> +want to send your question to another of [QEMU's mailing
>> +lists](https://wiki.qemu.org/MailingLists)
>> +
>> +* A lot of developers hang around on IRC (network: irc.oftc.net,
>> +channel #qemu)<br> QEMU developers tend to hold normal office hours
>> +and are distributed around the world. Please be patient as you may
>> +have to wait some time for a response. If you can't leave IRC open and
>> +wait you may be better served by a mailing list.
>> +
>> +* If you think you have found a bug you can report it on [our bug
>> +  tracker](https://bugs.launchpad.net/qemu/)<br>
>> +Please see our guide on [how to report a bug](/contribute/report-a-bug/)
>
> For this content though:
>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>
>
> Regards,
> Daniel


--
Alex Benn=C3=A9e

