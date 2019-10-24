Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE3FCA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 08:54:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7250D20684
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 08:54:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hjLf8Jmc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7250D20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNYtF-0002G7-BG
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 04:54:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41499)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iNYre-0008C0-E4
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 04:53:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iNYrc-00006y-Se
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 04:53:02 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:33597)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iNYrc-00005s-I7
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 04:53:00 -0400
Received: by mail-wr1-x441.google.com with SMTP id s1so16340569wro.0
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 01:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=QyhvzHK1pGqsjMW4dbVLE7f7Mp1HBgJdCBqtnhdu5hY=;
 b=hjLf8JmciGFLqKDR2opqrUZa04XdSvzDqMoxvzr6H88bhHM2oZ2n9ZiLNSnRs/ovXc
 Yh6DWA5GgD3oxQdhWgErNvKAFvxaMIUwqeZtR/vTDoTY4Eya3u9KL/sdh9+XhUEK6/zK
 pMhtk/1PQYsPipNQ3KiQoVJisTQ1y9c/io4mcDRyEyvHudrbxYPUjCYXd4ik64YZDNCI
 +1fgnOL338nQIPHvaRaQCIFW/NmI9QaYmJSAfKxhLJz9O0yCqrtUJD69RKMxGONNDBEh
 VD1TeQxYWdMHHyv32916PruRRpWFUGwV5nAwexNw4c1E6OWtuum5XvWvhDrI2hKtG7mH
 +ByA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=QyhvzHK1pGqsjMW4dbVLE7f7Mp1HBgJdCBqtnhdu5hY=;
 b=Iv6Hd3FQRS6Euf0ytYmTfQjcJ+AD1hNFR9/5oSc4SrEBh0r4ogQBQrhv1WNTw0Sf1u
 ZewXCWFvWbTIO8fn+nIKCtRJ4GbA13NseEPLPAWD7nwZRgZpp2uKG0iavYfGhXDSsNeD
 E6v6gf3tpf8L6Ph2DsNH6rzgpYPFNTTHMpJD+J2dKK/b2AbrPaq3ZNDUJorVoekxkn5k
 SCYAP+hbA/o1DqwvlIw8M6E1t4Av3cqA5xqKSIUaChSHQouXUgZNRa95GZDRZIEIJjCb
 A4hk+yyommhjuYtYiIqHE8nYFVMT5ap0xUvAYj5+2ExtdHGs6X5MnqZldLfozyqfquY7
 sWnQ==
X-Gm-Message-State: APjAAAWGn8OY/xXAZmRg2XvoICYef1la6mm9FfdKFtwlU0zG+rVCiwdW
 ayX25sFUN4WyB+yCA4mazSxtFg==
X-Google-Smtp-Source: APXvYqyBj1Xq10bxtxJ57TP3VPnrX1zwMaCJdHnYpiLZfztyLJDhtnkBvmtva2kNv66ypr3Q1noSAA==
X-Received: by 2002:adf:b1d2:: with SMTP id r18mr2658432wra.138.1571907178841; 
 Thu, 24 Oct 2019 01:52:58 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id t16sm25025054wrq.52.2019.10.24.01.52.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 01:52:58 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5B98A1FF87;
 Thu, 24 Oct 2019 09:52:57 +0100 (BST)
References: <20191022191704.6134-1-alex.bennee@linaro.org>
 <20191022191704.6134-8-alex.bennee@linaro.org>
 <2020367759.8121043.1571815677935.JavaMail.zimbra@redhat.com>
 <87y2xbvkqa.fsf@linaro.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH  v1 07/19] cirrus.yml: reduce scope of MacOS build
In-reply-to: <87y2xbvkqa.fsf@linaro.org>
Date: Thu, 24 Oct 2019 09:52:57 +0100
Message-ID: <87lftamsnq.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: fam@euphon.net, berrange@redhat.com, pbonzini@redhat.com,
 stefanb@linux.vnet.ibm.com, richard henderson <richard.henderson@linaro.org>,
 f4bug@amsat.org, qemu-devel@nongnu.org, cota@braap.org, stefanha@redhat.com,
 marcandre
 lureau <marcandre.lureau@redhat.com>, Ed Maste <emaste@freebsd.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Thomas Huth <thuth@redhat.com> writes:
>
>> ----- Original Message -----
>>> From: "Alex Benn=C3=A9e" <alex.bennee@linaro.org>
>>> Sent: Tuesday, October 22, 2019 9:16:52 PM
>>>
>>> The MacOS build can time out on Cirrus running to almost an hour.
>>> Reduce the scope to the historical MacOS architectures much the same
>>> way we do on Travis.
>>
>> Oh, really? For me, the builds on Cirrus-CI work reasonable fast and
>> almost always finish within 20 minutes, e.g.:
>
> It seems to be an intermittent thing:
>
>   https://cirrus-ci.com/github/stsquad/qemu
>
> but looking again maybe it's only the xcode build that is reliably
> long...

So the MacOS build failed:

  https://cirrus-ci.com/task/5574076248096768

I think the MacOS builds just occasionally get stuck for some reason.

>
>>
>> https://cirrus-ci.com/build/4976412120842240
>>
>> Also the last macos_task from the official QEMU mirror on github finishe=
d within 15 minutes:
>>
>> https://github.com/qemu/qemu/runs/269964092
>>
>> ... so was your issue maybe just a temporary dropout?
>>
>>  Thomas


--
Alex Benn=C3=A9e

