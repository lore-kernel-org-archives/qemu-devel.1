Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B56C10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 20:16:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6DC620850
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 20:16:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6DC620850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54439 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEg7Y-0005KD-1r
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 16:16:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hEg6d-0004u2-P9
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 16:15:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hEg6c-0000ZU-RY
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 16:15:31 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:34253)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>)
	id 1hEg6Z-0000QX-KP; Thu, 11 Apr 2019 16:15:27 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
	(mreue010 [213.165.67.103]) with ESMTPSA (Nemesis) id
	1MqsL3-1gaeWf17Ev-00msZq; Thu, 11 Apr 2019 22:15:20 +0200
To: Markus Armbruster <armbru@redhat.com>,
	Peter Maydell <peter.maydell@linaro.org>
References: <20190409155635.10276-1-aruna.15@cse.mrt.ac.lk>
	<CAFEAcA-k0KEsjb0VvbhhkpvTN7nFBDNtqKwx-Lai5uYbCkztJA@mail.gmail.com>
	<CAH95U0j6rHGdZj4B8DK-Ty-SqZHMb3Kmg16w+j3jx5bdkeijLQ@mail.gmail.com>
	<CAFEAcA9DSaZE-dsKV4321meT2hBEJRLmWBLF0U5o0jG=mzcmRA@mail.gmail.com>
	<87d0lu4exq.fsf@dusky.pond.sub.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <d18656fb-332b-5e01-cb86-efa692ff5daa@vivier.eu>
Date: Thu, 11 Apr 2019 22:15:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <87d0lu4exq.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:YXUFUrL/cYKBtBP8NmnxLWyhNdSk1MT3oBQwm4vWZxfOCh8Rkey
	S4EqonlHMfUmwjC8Gx5sbY5AtAAMbQ9kzDAFp8BUgEOkcARDA2CTYLaQZKNVcqkkthjaeBv
	I2Hl62L33Rwa9w55/YfXdOTcTRPzkN1pFpabOc8Ib931Gx0gVe1PlPBVS/nBAjmb4YCPWO1
	Ucb9kkI49a+0IBQb1+TdA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Mgbw+UZtIaQ=:AC/zdgt/QR1iEKG1nQX8PB
	nYr71hqAMC6Zp4XYtF38n5j26kVb5px+8fPj0BX+M2py4uqLjE4kbtOjnHN+omJpWfIXQun/2
	lP5yRRDu3VjWBoijuFg6/gKSWa54wiIA+FncQcf0wQVua+jXwpBhzuZU7FUssFztyKg2GQwkP
	Tt1V1REWIycsX/bb35nA2Y+4LZJBnP8drfmCqKDTLWHBXdbF3UcKj5jLe83vPbCrBnqu4qVWr
	/P25403RUDtQxBxQnGa3wTQVDS4u1Vgs5jRxm6GW/EeeUwA3I01/W6z1XfGI84DttlSvIUjRJ
	hnyUYp5Khln3rr8/+HJfMqWHDM0KpBlLUyKwgn5g16eTKpG0l7JTJbh3/i87lsBmbCFzwHjoO
	PI/2xAS+8/p6/gYpXMSApu1A0IIQumF0Xxn3klW+6Pzov5bSMYkpihezV3eQqI8uhGPqNt0LD
	HZLmafpvv2qTleEkF+timQcuhTz9AaBhkS+wdaeBwt5f3YRnkoiamjKA1Pw4XYlJe/757TYFA
	tTjbNcw1rQ8P5S0y/8BfVsIPGq/yljXqPMZh6IZ5ZHJ7NAu5zSC/CzpkjtgILEJvoh/+TeLzL
	Z5USDj9Ji2ORBWsuVjsPimXPc9hrA94ZFCpRcRllWdeO9pRgsiI8i/tERa2zA1N1A5rZWM0GF
	b4llOmnJrfCR/gLz4UpD+J50RFdveE5+ObURuGEEeuAvez6dRrAsuedPyLu/H7B2AXTLK0/hG
	/RiJzofgoZWXAUFBOj6GFetVZpGUf0iqBhyGu8BeNJs+HuMqbjeBlAGyKV8=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.187
Subject: Re: [Qemu-devel] [Qemu-trivial]  [PATCH 0/4] Header cleanups
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
Cc: Aruna Jayasena <aruna.15@cse.mrt.ac.lk>,
	QEMU Trivial <qemu-trivial@nongnu.org>,
	QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190411201519.oEZ4-cUF_51-FJT7icOdLYclHUZ-mQ8ZrUeNhp8ViZM@z>

On 10/04/2019 07:17, Markus Armbruster wrote:
> Peter Maydell <peter.maydell@linaro.org> writes:
> 
>> On Tue, 9 Apr 2019 at 17:42, Aruna Jayasena <aruna.15@cse.mrt.ac.lk> wrote:
>>>
>>> Yeah this is a stand alone patch.
>>
>> OK, thanks -- just wanted to check there wasn't a missing
>> bit. I think this could go in via the qemu-trivial tree
>> so I have cc'd them.
>>
>> We're in the middle of a release at the moment, but we
>> should reopen for development in a couple of weeks. If
>> this patch still hasn't gone anywhere by a week or so after
>> that then please follow up with a 'ping' to check it hasn't
>> been forgotten by accident.
> 
> Hopefully, qemu-trivial won't wait for the next development cycle to
> begin just to queue patches for it.
> 
> Regardless, patch submitters should watch their patches and inquire when
> they don't get up within a reasonable time frame.  Normally, waiting for
> two weeks feels about right.  Perhaps give it an extra week or so when
> the release circus is in town (like now).
> 

Applied to my trivial-patches branch.

Thanks,
Laurent

