Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76364C33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 12:21:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 413C12070E
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 12:21:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Bti6pkMf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 413C12070E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ionrw-0003TZ-88
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 07:21:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47135)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <deller@gmx.de>) id 1ionQa-0005QF-PP
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 06:53:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <deller@gmx.de>) id 1ionQZ-0007m1-HW
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 06:53:40 -0500
Received: from mout.gmx.net ([212.227.15.18]:48673)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <deller@gmx.de>) id 1ionQZ-0007ks-4Z
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 06:53:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1578398013;
 bh=g964XNydCTu3bouXWu2b9JqFUYk9RHgbdO1TWKR8rZw=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=Bti6pkMfh2B55aQy8fkEVz/JdeeG5tnqXmXKBwoJsWr+ws6FySraM16Vf6/G+LsvM
 f5Hh1iAf95j0tU/XS+co64d3RqDd8f76G4QIQ2iG/6pLVnr/jtLvn65FL1XjUxKIZF
 LX8ZaQAM3SQjLQYduINBZmq0eiZQ9qNflfTaM8LE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [10.20.71.210] ([193.16.224.2]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MbRk3-1jQc9E2L9N-00bvWE; Tue, 07
 Jan 2020 12:53:33 +0100
Subject: Re: [PATCH v2] hppa: allow max ram size upto 4Gb
To: Igor Mammedov <imammedo@redhat.com>
References: <27c3e31d-82ae-e62f-caba-a0a3fbd55e7c@redhat.com>
 <1577987162-150529-1-git-send-email-imammedo@redhat.com>
 <2f226aa4-5f61-6e6d-d6b9-a98685a79e8c@gmx.de>
 <20200103105434.050d28ea@redhat.com>
 <6fa7bcd3-ee67-cc84-fd4e-d3677e3ae51a@redhat.com>
 <20200106114828.6bc96b23@redhat.com>
 <8ef57947-dba6-9273-0b1e-7f0c052795da@gmx.de>
 <20200106172411.5a6f2efe@redhat.com>
 <a54bf2ab-a0ae-5374-300c-77d7bc926330@gmx.de>
 <20200107122127.4c8ac59d@redhat.com>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
 c2TFWAS8k6RLkk41ZUU8ENX8+qZx/Q==
Message-ID: <4272cf03-cd8a-3a29-b3c2-65788a60b50a@gmx.de>
Date: Tue, 7 Jan 2020 12:53:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200107122127.4c8ac59d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ap+vKKNqzNlwhi5AgiPxL8YUpytfbjKrxWZvq5XH8DAPrcYh/jV
 avsiDpawMfiFK3qbBNu9brplTyEzEbTTd4k8SjTefFW/ULGr6ky3e4Mlcdf5Zi+FWJ09Mgl
 cteGgilDRqpVWuMB2BpselV/SiP2w+sx/O9+zdsjr5EZ4I5igX8nf4TkXjPlUHt13vDvpMT
 ecSdoDxRsHi2uCttiUZUw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1fahBedr6yc=:bYpmQtCF1cSi+QKrjL1hCj
 z/7808fvBq4ziRxTiPYJIj1abqHGZNt2tO1Xjfoui+RBliLTc+Xoz/mwp3HOwWiWcrOJXfu4q
 l5zjZoS7Ci8dsuI6mSGljyji2RW4k4Ulc4CFVXkvD8I9u777a4fpbymRWB5Naxw0Io817nf/0
 1v66X0Af2ICqJbkzTK671AZ5NnIwpBjCQbKWT+aRFJh7kQIlxubjr++Hk7DIz2sRRw8vHFPgz
 J+731GmEqRW7Pc1RZexur2vkdniey3sYvLslH1krdzpyY5+i76EEwVuVkrJX2jBjh9y4gRArE
 nXneChQNcNjsq0uskIo7rtpke/3u7PSJjzUIGQk9+k15C1KMdToWU4zPBXMgGzIfxawy1hOi7
 8vxC9WxXeYS02VnleQQXF4e3NgOH8yCD5+Oggcswed54xDpBGT+QtT6JlGOdLX/IjE3Qz0xQT
 3RH/pXyJgPMkLTTRsj68ZGd4f/9EVNEld+q7zVOjWYIrKPlsEU0chISj3YRw3u0ZG4lBjqedV
 j6yI5zMNh31VZQSYfEmCIX9YClQL2KmS01dkPvp8xCYn0eCPXmeIcg5pL0wvq/oHFXtVyyDCP
 NZceQGwveslAvInLO8ZDjRhPOsPGOTEs1Ma0LM6Nv+RMIYIj4rlT+6JVX3HVvFlhTyztXYgu3
 FoC6wpLsjyt93ewdLrgjt6C/1/sOt6wnR4s9B/JJCoFw3YZAFDOiPwC6Rs5FWyM2RmgEMQJ1N
 thzA6AliAKPHqUoiCSp7qeqZQ5VQSye6C2y/cp2+f3bxOM52jN0ukPb4Z8NMIH2gMVIHi3fJG
 IAP51M0PZROvLXo89ZOTgPGNL0O+0mkkfSKCqmdE0LoIoMfws8uyW/pNEuanisHxMxp30sxDy
 hc/4bjd2po8NNx0h3Nb71uCL711s2gEsAWZN42Fln/cxuOUy9rLuIgCc/fjQKDvELqUzjwBDp
 Xbp0LagP4BusdkwNm1FVnPaUQxTcnZTjvz2bnZxH7DDta4fuJf8lqyL9aoYG+80fOm0aUyyrh
 m/f1fVik9yeA/OugSyn5+YhckT/2OjQQJ3okAstAfUo9HtMLcGHFevQHXXkdXPt69vq/cLcqn
 v8Nejso+TqeMsM45Wzy+27jF5OU39Vx4UCrC2zTZXKf0CNL8MdHWVusEnlBjovP8xiDoEfutI
 SJn96GJ9kdcmT/ySYpiIuOVMpIOf5SWjZXRtdGpYsrYJUZiP42C0zqhkrIW/XrKBbOH4F/NSe
 T4B74cfDrCNGjSUXEWkdx8QPIghL4xbts/pED6Q==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.15.18
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
Cc: Sven Schnelle <svens@stackframe.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07.01.20 12:21, Igor Mammedov wrote:
> On Mon, 6 Jan 2020 18:03:49 +0100
>> So, I'd suggest to drop your wrong patch #43.
> As you noted in your first reply, patch is correct.

You probably got me wrong.
Your patch #43 is wrong, and your fixup patch to some degree reverts it ba=
ck again.

In patch #43 you error out and stop, which real hardware wouldn't do.
Real hardware simply ignores the memory which wouldn't be used.

> All it's doing is validating user input versus RAM size
> actually supported by the current code, telling user> current supported =
limit and enforcing it.

Real hardware would not tell user.

> I agree it's inconvenience for the users since they
> won't be able to specify non-sense values and still
> get board running, but that's clear user error and
> should be corrected on user side and not by QEMU
> magically masking wrong CLI values.

I disagree.
Everything worked as expected before, but with *your* change now people
might need to modify their CLI.
4GB is a valid amount of memory which can be plugged into
the virtual and physical machine.
It's not magic, it's how the architecture works and you changed it.

> Since it could be fixed on user side, I care less
> about user convenience when it comes to correctness
> and unified code.

IMHO, you should care about that the emulation works the same
way as physical machine. Not, how you want to educate end users.

>> If you don't want to drop it, my suggestion for a commit message is:
>>
>> hppa: Revert last wrong patch and give warning if user specified > 4GB =
RAM
>
> I have to disagree on definition of wrong here,
> in my opinion covering up user errors is wrong especially
> when all users have to do is to adapt their CLI.

See above. Nobody ever needs to adapt anything unless your patches gets ap=
plied.

Helge

