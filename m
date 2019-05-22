Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9865EC282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 11:38:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70E6C20868
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 11:38:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70E6C20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40655 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTPaD-00045z-J6
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 07:38:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hTPYx-0003UH-JU
	for qemu-devel@nongnu.org; Wed, 22 May 2019 07:37:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hTPYw-00089p-Im
	for qemu-devel@nongnu.org; Wed, 22 May 2019 07:37:39 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:57105)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hTPYw-00088p-9S
	for qemu-devel@nongnu.org; Wed, 22 May 2019 07:37:38 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
	(mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
	1Mq2vU-1gqS5x2u7m-00nBkM; Wed, 22 May 2019 13:37:23 +0200
To: =?UTF-8?Q?Daniel_P._Berrang=c3=a9?= <berrange@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>
References: <20190517023924.1686-1-richard.henderson@linaro.org>
	<20190522105807.GF32359@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <74b28475-7b29-c106-50ef-262d2e52570c@vivier.eu>
Date: Wed, 22 May 2019 13:37:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20190522105807.GF32359@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:SHKm5SNsFV9678xtSX3IcMFZZQ+MBr7vkifY54kba1Lt7z8pnY6
	n8Pg7XRsE4HoAYk8JwFKurqTbcBa0s3NzzxNg87rD4u4KE2Ai6V0XjUME3DeCWYgnIXPZm6
	twLXObQpqCBaWQa9eYmheIbX22MqpF6zvSx1WndBRVGYiXZrOEhr7BgOihG7lAohD/sAJYL
	pbYWHpRx5Ej1KhiKtsAXA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KNaud4Y0CD8=:dqQSlGm9O+N7UqFN1OUtBJ
	oRPnNPY62ML8XxwDCurnL0XT8xGiNagiO31cNdiqmjE/Vu34MfEJ3k+UYZWZtO5j8OqdNpLFW
	KImCQH3ae9TrCjmP4vXeaf2vstP4oJqlJ6FexU9/dw62G7UhwLnvKI/tOzPHRAQf3gIrvN0UP
	QnINBPCGLBd8coThvZwcnTzI5pXy7bNEwqH5aJfn3M0tzXi/yfuEvb+xjXG/nsKVKWzG4B8Q3
	RieHLrVWOUEEY7mRSt6xiCNKCpg2YOcI2DdTQQrp7bZFqLXwFX46xQznlB6AeSYgvlwUf9Yw6
	KJEZ/9/Yb9JVaIuWo2MCqFbbWgLJa3RyAMUu5l48lHcMbPDBQwmOl4V/lPLmPgt3srQfwA8ye
	DXnWC2nw5GvR3/dGG+NWyr2l1Zuc0YSW9K7n9yQ25DvlP9WWoyGLrsKNhby7rXQhR1oOV0lt9
	ooAqRfTcQSvGnfgsNq8pUD0jr5dWt/7pWIsYPBVrrEuhwXopsSZ3avLdJiiwoups9ASBj2M1A
	bPjKDaAEDASIU0zbvyavb4yVMwr8gIK7Mw1A0g7iKd2Wfe+S0Eyxu0zqgOoLqtjd2FHf0yakO
	UyzS+QM86Dz6ZQooDHYFwUctnXCVNn4v1CaHGwiu5NwoUMrbRDkyTQlcf3EaeNpZIepjgk/0a
	yFdN94zta6YMikFzkSQjqZW6iKzJ2zJmfQzlsbkgK/ubiekjWfxhxEh0tqgMpvsYTEWahVBM4
	z/C6g9Lw/XvMhzi0vq8UQBfSUv8k6/78SZcq3xjBkkJeDPNo2hXKYf5+8Lw=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.24
Subject: Re: [Qemu-devel] [PATCH v8 00/25] Add qemu_getrandom and
 ARMv8.5-RNG etc
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
Cc: lvivier@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22/05/2019 12:58, Daniel P. Berrangé wrote:
> On Thu, May 16, 2019 at 07:38:59PM -0700, Richard Henderson wrote:
>> The change in v8 is to which objects are linked in to user-only
>> from the crypto directory.  Daniel asked for all of crypto-obj-y
>> to be added, but I have been unable to find a solution that works.
>>
>> If I add crypto-obj-y, then authz-obj-y must be included to resolve
>> dependencies.  Daniel suggested splitting authz-obj-y into two, so
>> that linux-user plus some of the tools need not link against libpam.
>>
>> However, I tried that, and in the process managed to break testing.
>> I'm not really sure what I did wrong:
>>
>>    TEST    check-speed: tests/benchmark-crypto-cipher
>>    ERROR - too few tests run (expected 32, got 0)
>>
>> Or maybe it was broken before, but at least this way I'm not touching
>> any of the variables that affect tests/Makefile.include.
>>
>> Given that user-only *is* being linked against the enabled crypto libs,
>> the behaviour between static and non-static is identical, which is I
>> believe the major portion of Daniel's request.  I think further cleanup
>> to the makefiles can be done separately.
>>
> 
> For avoidance of any doubt
> 
>    Acked-by: Daniel P. Berrangé <berrange@redhat.com>
> 
> for Richard to send a pull request with any of the crypto related patches
> I'm tagged as maintainer for.

The same for linux-user part:

   Acked-by: Laurent Vivier <laurent@vivier.eu>

Thanks,
Laurent

