Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 834A0C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 18:06:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52CD2206B9
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 18:06:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52CD2206B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYCpM-0008WE-Eg
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 14:06:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39978)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jYCnz-0006b7-BJ
 for qemu-devel@nongnu.org; Mon, 11 May 2020 14:05:31 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:50437)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jYCnx-000239-HN
 for qemu-devel@nongnu.org; Mon, 11 May 2020 14:05:30 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue011 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1Mw9Dg-1jHdp90gs8-00s8Ev; Mon, 11 May 2020 20:05:23 +0200
Subject: Re: [PATCH v1 0/7] various tcg and linux-user updates
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200501145713.19822-1-alex.bennee@linaro.org>
 <87tv0mg1y3.fsf@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <3bf57eac-311d-865f-bcda-a4e0257d24ec@vivier.eu>
Date: Mon, 11 May 2020 20:05:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <87tv0mg1y3.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:n2vctaIs1gWXYnLxXmLV1bCXx/9vHZCV8Ht0+8w0dpfceESF8e9
 X2pDwAxNlxMNHMMxpmBMLhjVgLUS7iwRDZxov1egj3p9jVrspmo+slemXp9sevC0jK4RVia
 140BPXG8bgvBJucsdGJX03l5aagUIAQEl5I505lpgiGdPfovI38tcsl4BCtfRKcAc7yTCkk
 USHzSo9qqRPPQ6ZIBjyLQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:G16dbckU93A=:e0WGx7xbk5E6HpUTR1fofH
 RWubnuGLlNxJMmpAeBfuME9HgODsQj+KOG3B/q1yJStZrfPiOb9WVS8qYAPTSHa9TtTHaYqYw
 g8oUWI3wYtBd+73pQXuUJPxB5Oj3ny9KglL+nGkQKk/tY2PPdKWcLgqLert0eQljltQnoHrGK
 sMFZwDSL5LiuWTlHVRvSfVgnEPGw77tOpufi/WyJGccf6bkk3gLa0wlWKnWUyj5k2VZwMCV71
 4E49Gxj2IHkRTfnU3gyuRh0dpVcY6KXAYbX0U6EGNo207RXdRObKFRGC00m5UtqSamp5VSHV+
 uBadItismEUxTODNZBbRFpqIs+ewjZkI9Hmk81nnfw0IUSgr/wCzpHj6x6WxyaH6urAkOisq4
 7UPdPzL9+r5GHRFc6CdSlji6NWyecwztGjtgwPfccC6N6fum0vZCdQ88R0rDC88eoSw6lSzbB
 COhGUGeBljiTidk0quBRkw5FbepBQtWUtiBhNA2CsXaLcdah8azmCZzmqBS1KR75SQnAv/C/P
 FlD53+jHH9HvDqoO6u1vUz41Kz4s4JInJxzGkTBdJt/D9/J+5VnZL7VgQvIoo2RS+ZoaBhGCi
 gvCyqNFKWls3BM/xq/7BVvxTtldMfvDlRHSgyMKOef6rLhMWnQVQzfBMikg8kmIa+zh9Fn+Zf
 J8EI6NaJ9QCIKDYq3alUcFya+skpz50NepE5ge7ybOuxNGNpIFt6PSL7B/RDHvzMfB/mxzJRR
 lQ5LCBZ0pJL7D+84c66T3hAn65hYkGT1JuWWOpdVx9p3+islR6eSvY5IpUNnUwpcnIFnB+M3X
 hmNQYkZ+cmEvp38vkIo6w76ILfzF60b8itQsCa5pxP6TE8aWiMxn8s2x4X+YPgfsXiqVV+B
Received-SPF: none client-ip=212.227.126.135; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 14:05:26
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: riku.voipio@iki.fi, richard.henderson@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 11/05/2020 à 13:12, Alex Bennée a écrit :
> 
> Alex Bennée <alex.bennee@linaro.org> writes:
> 
>> Hi,
>>
>> Cleaning up my queues into more focused trees these are all tweaks to
>> TCG related stuff. The guest_base changes where posted before but
>> where a little radical for 5.0 but I think are worth getting in early
>> as it enables the sanitizer builds for a range of linux-user targets
>> we couldn't run before. Finally there is a little tweak made to the
>> out_asm handling which makes it a bit easier to see which guest
>> instructions are being emulated by which host code.
>>
>> The following need review:
>>
>>  - translate-all: include guest address in out_asm output
>>  - disas: add optional note support to cap_disas
>>  - disas: include an optional note for the start of disassembly
>>  - accel/tcg: don't disable exec_tb trace events
>>  - linux-user: completely re-write init_guest_space
> 
> Gentle ping,
> 
> I would especially like some feed-back on the guest base updates from
> the linux-user maintainers so we can get the sanitizers more widely
> used.
> 
> If your happy for me to include them in my next PR I'll just take some
> Acked-by's ;-)
> 
I don't have enough time to review the changes, but if you are confident
with your patch you can add:

Acked-by: Laurent Vivier <laurent@vivier.eu>

Thanks,
Laurent

