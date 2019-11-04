Return-Path: <SRS0=KlJF=Y4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A21ECA9EB5
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 19:44:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FCD9206BA
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 19:44:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dlhPiLkc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FCD9206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRiGd-0006Qo-9I
	for qemu-devel@archiver.kernel.org; Mon, 04 Nov 2019 14:43:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36428)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iRiF6-0005wy-Ab
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 14:42:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iRiF0-00069W-Jg
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 14:42:24 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:37865)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iRiF0-000697-CK
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 14:42:18 -0500
Received: by mail-wm1-x341.google.com with SMTP id q130so17355543wme.2
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2019 11:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=3pdwtpEMuYpNmcJew2XR2Uq4e5PrIRzFboXtLYMH6Fo=;
 b=dlhPiLkcsEgm+Tu77L3dLxvUlYGn3z44dWIby+DFMACVCGD2T0o5e/+EgjamCaiPK1
 A3K8etZB678q3dES2EZg6tJlqmHAskVEUhHUFeMkuifQS3zY8oTla0t3lhRux2RDj5pP
 Tin97hf8CuhUxeTfCM2/GacAVG5ROUqVxCHCE/NrTLcdMWKZ82Ldlho0dvv0JjoKj1QZ
 aVzfP6GG2zxcDxJOIqyjmPRc5RosbU+sGUX/wQSvc+BOF3qvHi8+efzk0rxHgdwJizkd
 WAbtdE0zCLn1wEwq+icuqR0OtvEZeIvumHsAAPB8NfZPjlXnExv/DDhnx92vuadwi4Dl
 NxrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=3pdwtpEMuYpNmcJew2XR2Uq4e5PrIRzFboXtLYMH6Fo=;
 b=KDDqEwjqBSY7w3SqgFBv7m/NqJxcFVcftwL/H5I9rJeQvqrX49LbaIufrsrjfjJum4
 aaCLnPeK9ORM/Ef0FWsSQEbIpoauM8w4C7C/5wJM5FqrIvECp5EnLk2F8hGtPfnB28+Q
 mb4wGo/jYWjJ2dH/qm6BqiXCDZTWO5uybMTVzPLHePT2zJ4B+GCqJ9Yc8RzvAXX/kT43
 3Lerzux9SSE+ceRSDGnM31D6PbP6KwOUXd9FtRN7WcW0ujzaqtvnN0JMZjiAUMiixQOE
 TdNecLuUNHdBcGLf8fMZlKXoDD+7bjZMIbfRoYcoQGaug/dk2RxMnh14Hq2OW4TboJHt
 2Tyw==
X-Gm-Message-State: APjAAAVJNuV2cVpvcd9YAephNs08IG92jo6bcJGIZqSUCZav94Qm8GnS
 phbA8gcwOj84AsqGqfVVF2IVqg==
X-Google-Smtp-Source: APXvYqwKviqUsy7fpcgZ+7GjBqDEMsCNvP0EnGT8I7D6s+CW4LdCk4DZeriy+dl1fI5P/YaAMjhvgA==
X-Received: by 2002:a7b:c94f:: with SMTP id i15mr722981wml.8.1572896536892;
 Mon, 04 Nov 2019 11:42:16 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id i13sm10520856wrp.12.2019.11.04.11.42.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2019 11:42:15 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 38DAD1FF87;
 Mon,  4 Nov 2019 19:42:15 +0000 (GMT)
References: <20191104173654.30125-1-alex.bennee@linaro.org>
 <20191104173654.30125-6-alex.bennee@linaro.org>
 <20191104183632.GO3093@minyard.net>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: cminyard@mvista.com
Subject: Re: [PATCH  v1 5/6] tests: only run ipmi-bt-test if CONFIG_LINUX
In-reply-to: <20191104183632.GO3093@minyard.net>
Date: Mon, 04 Nov 2019 19:42:15 +0000
Message-ID: <87o8xrjunc.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 richard.henderson@linaro.org, qemu-devel@nongnu.org, f4bug@amsat.org,
 Kamil Rytarowski <kamil@netbsd.org>, cota@braap.org, stefanha@redhat.com,
 marcandre.lureau@redhat.com, pbonzini@redhat.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Corey Minyard <cminyard@mvista.com> writes:

> On Mon, Nov 04, 2019 at 05:36:53PM +0000, Alex Benn=C3=A9e wrote:
>> This test has been unstable on NetBSD for awhile. It seems the
>> mechanism used to listen to a random port is a Linux-ism (although a
>> received wisdom Linux-ism rather than a well documented one). As
>
> Hmm.  I got reports of this issue and tried to reproduce, but I was
> never able to.  I thought I had fixed it via other means, but I had no
> idea this was the cause of the issue.
>
> It's not a Linux-ism, I don't think, Richard Steven's "Unix Network
> Programming" mentions that is how this works (at least on UDP), and that
> is pre-Linux.  That's probably where I got this technique.  I've saw
> some web pages mention that Solaris and Windows do it this way.
>
> However, it's not specified, so it's probably a bad idea.  The only way
> I can think to do it another way is to remove the bind() call, then it
> should randomly assign the port (per the spec, I think).  The trouble
> with that is the address will be INADDR_ANY, so it will be bound on
> other interfaces besides the loopback, which make me slightly worried
> from a security point of view.

The other option is to keep the bind but seed it ourselves with a random
port. However then you need to loop until you succeed and avoid locking
up if something fatal has gone wrong.

> I'm ok with this being linux-only, but I'd like to fix it so it works
> everywhere.

One option could be to use the glib networking stuff to set this up.
That has options for creating dynamic ports for incoming connections
although the docs are a bit light on details.
g_socket_listener_add_any_inet_port certainly seems to do the retry
approach (for a weirdly arbitrary 37 times). It leaves the fancy stuff
to a hopefully well tested library although I note QEMU's own use of
g_io APIs seems to be pretty sporadic.


>
> -corey
>
>> working around would add more hard to test complexity to the test I've
>> gone for the easier option of making it CONFIG_LINUX only.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Cc: Corey Minyard <cminyard@mvista.com>
>> Cc: Kamil Rytarowski <kamil@netbsd.org>
>> ---
>>  tests/Makefile.include | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/tests/Makefile.include b/tests/Makefile.include
>> index 534ee487436..8566f5f119d 100644
>> --- a/tests/Makefile.include
>> +++ b/tests/Makefile.include
>> @@ -177,7 +177,9 @@ check-qtest-i386-$(CONFIG_SGA) +=3D tests/boot-seria=
l-test$(EXESUF)
>>  check-qtest-i386-$(CONFIG_SLIRP) +=3D tests/pxe-test$(EXESUF)
>>  check-qtest-i386-y +=3D tests/rtc-test$(EXESUF)
>>  check-qtest-i386-$(CONFIG_ISA_IPMI_KCS) +=3D tests/ipmi-kcs-test$(EXESU=
F)
>> +ifdef CONFIG_LINUX
>>  check-qtest-i386-$(CONFIG_ISA_IPMI_BT) +=3D tests/ipmi-bt-test$(EXESUF)
>> +endif
>>  check-qtest-i386-y +=3D tests/i440fx-test$(EXESUF)
>>  check-qtest-i386-y +=3D tests/fw_cfg-test$(EXESUF)
>>  check-qtest-i386-y +=3D tests/device-plug-test$(EXESUF)
>> --
>> 2.20.1
>>


--
Alex Benn=C3=A9e

