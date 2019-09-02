Return-Path: <SRS0=OFvx=W5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C38E2C3A59E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 19:05:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93DAA21883
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 19:05:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93DAA21883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i4rdM-0005Mq-MR
	for qemu-devel@archiver.kernel.org; Mon, 02 Sep 2019 15:05:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47238)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1i4rbi-0004nL-Qi
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 15:03:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1i4rbh-0002pM-M0
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 15:03:18 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:51959)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1i4rbh-0002fs-Cr
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 15:03:17 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue009 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MlNgz-1iRnHY2boD-00llb5; Mon, 02 Sep 2019 21:02:57 +0200
To: Olivier Dion <olivier.dion@polymtl.ca>
References: <20190807135458.32440-1-dion@linutronix.de>
 <20190807135458.32440-2-dion@linutronix.de>
 <7a8fa9b4-01b5-e431-be89-00e73235e3ff@vivier.eu> <875zmaeh1j.fsf@polymtl.ca>
From: Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <d1765c14-6abe-69b5-b4db-7a5dd13cf996@vivier.eu>
Date: Mon, 2 Sep 2019 21:02:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <875zmaeh1j.fsf@polymtl.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:kkHRlDRVz5uKMi/P99eDTQ5OsJ7fIrbJFuGyZ0R048vTJPJDyN6
 FbBWQTLfppVKXUZT7xgX5RJwWaXHeVjIqC7QjHLCkNCfpsYVEOXN29l3HMeaCc+tPLlk0Lj
 35Vq4QTEkkUuMXHkk9Lpqynn8yzuvJLgtpPtJ/IaZBie7EOxpFVJAACEPWKmGatWlRf2H0V
 MSgDrgYQif9xmVjK+DY1Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VzugbzRhmcI=:lLl50UsxqPav4Q3Rz9QnAn
 5rUXQCbN4BtGNPTBNbnDE00DKjtYrZpzrVBGWnLMmU62ayQ2eLojEbnLNyAxKac0Ry3IF/YgF
 to0FASNsm2H2fyQ7eItGNdG/nd+aYnvezqD6u+Cfs7myK7hXZpIaHL1fNYy9j6/G7Br9xcJWv
 +1dRT+qPKmasO85kco99KOsbeXlPdik8SUxVXgY29jUYDiZ9jn8c/7XFPL5eYany3grku33YI
 DZklj3CCEc/+ax2hPGMUBDOwz3Xx9i9FvTRmcwBQr+/ANjEXtXMW4og27FkSLuifrlA8CQZP1
 RCZ3tPmko+/j/1dPYKNamLeUMvMfReAA9f3PknvRVpUuHntHQkJpl7FIFMfmtDFSBy9Ny+QTG
 XG3luu5Nt1s6mxjHu1lBmguD8RvXUDDqsuzCpBLLyfKSq/cjY0LKRcvhFUXL6fm4wgJTMLQnX
 po0gmbFgeV8Kwz0r+AYUJIkTWKUh5oN4OGzkOfteSgL9KCLCQzMF5e1FONxgfuKrSgIlk+P2I
 LKS15YOcUcT49/srkC8wnVvQAPjWM42eOdR3S6Q/aBlB/mMnG7EFSzR4skBt58lcZ60wTFo42
 /qJJwuiy9h5QuwACwEd7J0mOXZL9QDF2nb/0/psPVNeOLA3gTXnqNPl6bvtKjRDMDXs5bvIEe
 8wZe5we1AMvM5hnbrRSqBoufjBZh5gga6jRusEN8xMrSBtf1ICBCqGZIZWZxniu24U+dVDU0K
 vd1DuxnKnAK1AdyYdjAfgJ8nBSvmnHOd1/4wVEq+MjEmrXcheBKCJW0IzqB0uq7VzIK6uHV2O
 ceqnjaAcK0hmHxMEsJ71QrA5hz41A==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.134
Subject: Re: [Qemu-devel] [PATCH 1/1] linux-user: Handle /proc/self/exe in
 syscall execve
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
Cc: qemu-devel@nongnu.org, john.ogness@linutronix.de
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 02/09/2019 à 19:36, Olivier Dion a écrit :
> 
> On 2019-08-23T12:58:43-0400, Laurent Vivier <laurent@vivier.eu> wrote:
> 
>> Le 07/08/2019 à 15:54, dion@linutronix.de a écrit :
>>> From: Olivier Dion <dion@linutronix.de>
>>>
>>> If not handled, QEMU will execve itself instead of the emulated
>>> process.  This could result in potential security risk.
>>>
> 
>> Could you explain what you mean by potential security risk?
> 
> I don't have any exploit in mind, but someone motivated enough could
> certainly find one.  For example, it's possible to ask qemu static to
> execute another program.

In the actual state, executing /proc/self/exe executes QEMU instead of
the binary and this is a minor bug not a security risk.

> The main point is that an emulator should never leak informations to its
> environnement.  If the emulated program can determine that it is being
> emulated, other than by an "official" way, then the emulator is at
> fault.

It should never leak _crucial_ information (like the serial number of
the host), but all emulators/hypervisors leak information (try to run
lscpu/lspci in a VM). In this case, again, I don't see any security risk.

Moreover qemu-user doesn't have kernel part and it has no way to elevate
privilege by itself (BTW you must not run it with suid bit).

We don't have a nice solution for all the files below /proc: we rely on
the path name and can't check if it's in a procfs filesystem, and that
is not perfect. Moreover, it doesn't work well if we use a link to
access the file or a relative path. If we want a solution managing all
the cases if becomes relatively complex.

From my point of view, all patches are welcome.

For this one:

- don't introduce it as security fix but as a bug fix
- propose a test case and show your fix really fixes it
- you should use do_openat() with execveat() as the exec_path can be
unset in the case of binfmt-misc with the credential flag (search for
AT_EXECFD in QEMU code).

Thanks,
Laurent

