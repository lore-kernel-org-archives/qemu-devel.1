Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44946C04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 21:54:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17A3A20989
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 21:54:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17A3A20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44215 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOUWT-0001du-Cf
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 17:54:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hOUVi-0001MV-3F
	for qemu-devel@nongnu.org; Wed, 08 May 2019 17:53:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hOUVg-0003M4-8i
	for qemu-devel@nongnu.org; Wed, 08 May 2019 17:53:57 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38434)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hOUVf-0003L3-VF
	for qemu-devel@nongnu.org; Wed, 08 May 2019 17:53:56 -0400
Received: by mail-wr1-f65.google.com with SMTP id v11so9028360wru.5
	for <qemu-devel@nongnu.org>; Wed, 08 May 2019 14:53:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=eV5UVRRbZXR8KvHlef67FpJf8bnUZkFHZ/xXGlfmDlM=;
	b=g6dsHSgYZGwPIe0Xtukh7sR7bhfFqA3VDTvYI3C/v7ayht9jueSsObGxmzAnOo0eVw
	gRDqCxDxB5jqZm1QAtivr3AvZgKfbdAwaeX+0COrwR3wGLz+Du9jHQr/lPh6oSOvqN6o
	oqeTxLUDOr/qOtT/jKpVNEkLZ35PPr5h0+Rrfn6U5tFmKPvqpRDrsUA0tDFvoEQEoLAu
	ciGHrQ8uCJ+2YpW2s65zUm6rKQ5kssJ9l2zIguK+Ey+t0JfO5tNSR6zJuU+9rB4D9/Bl
	FmCS6/BwNbJQmhN1xpOKoY858/Pdnv7BC98QNXPVCeZng/qZZ9PuJSozD0GBg/Mpd3k5
	pLaQ==
X-Gm-Message-State: APjAAAXhWlmDc0t1xxcXaGagZ0ldWUSJxvnFOWAQsX7MlnjXXpbof+w+
	i323KTqs19CPndFf9KnXLLTX+n5FS0g=
X-Google-Smtp-Source: APXvYqxvlHWofXbY9FByjWW+tld6B6lTv9TX7XYMrcYcu6GsQghLwwfk3XtaGdp76V9jY6kQ6rqy2Q==
X-Received: by 2002:a5d:65d1:: with SMTP id e17mr131096wrw.65.1557352433258;
	Wed, 08 May 2019 14:53:53 -0700 (PDT)
Received: from [192.168.1.37] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193])
	by smtp.gmail.com with ESMTPSA id a5sm164209wrt.10.2019.05.08.14.53.52
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Wed, 08 May 2019 14:53:52 -0700 (PDT)
To: Richard Henderson <richard.henderson@linaro.org>,
	Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <20190508000641.19090-1-richard.henderson@linaro.org>
	<20190508000641.19090-19-richard.henderson@linaro.org>
	<CAL1e-=iRwS-1LvP2m5oS2PAKigiDr0g8jRNP6xPV2b_9AYU08Q@mail.gmail.com>
	<de1b6006-866c-b3a8-9726-4620821a9657@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <b363c6b2-5186-de29-b341-4511da4049b8@redhat.com>
Date: Wed, 8 May 2019 23:53:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <de1b6006-866c-b3a8-9726-4620821a9657@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH v3 18/39] target/mips: Use env_cpu,
 env_archcpu
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Richard, Aleksandar.

On 5/8/19 4:32 PM, Richard Henderson wrote:
> On 5/8/19 1:15 AM, Aleksandar Markovic wrote:
>>
>> On May 8, 2019 2:19 AM, "Richard Henderson" <richard.henderson@linaro.org
>> <mailto:richard.henderson@linaro.org>> wrote:
>>>
>>>
>>>
>>
>> This commit message doesnˊt explain the reason for the change, and why is this
>> an improvement. The underlyng reason for distingishing between  env_cpu and
>> env_archcpu cases is not explained too.
> 
> It's certainly explained in the preceeding patches that introduce those functions.
> 
> Are you suggesting that it is beneficial to copy-and-paste a common block
> explanation into 21 commit messages for each of target/foo/?


*) Richard:

I tried to put myself in Aleksandar shoes. I believe Aleksandar is
worried about his MIPS maintainer duty, wanting to Ack-by this patch.

It is true that out of the context of the series, it is hard to see what
is the problem you try to solve.

You could copy/paste the explanation you used previously,
with s/$arch/mips/:

"Cleanup in the boilerplate that each target must define."

"Combined uses of CPU(mips_env_get_cpu()) were failures to use
the more proper, ENV_GET_CPU macro, now replaced by env_cpu."

Now to clearly understand this patch we still need to look at the
previous two arch-generic patches
- "cpu: Replace ENV_GET_CPU with env_cpu" and
- "cpu: Introduce env_archcpu".

Also, it is tedious to copy/paste the same explanation, but thinking of
forks or stable branch that cherry-pick not all but some commits of a
series, it might be useful.

Another guess is Aleksandar might have looked at the series cover, which
is not well explained as your v2:
https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg07635.html
I think you mistakenly copied the v1 blurb instead of the v2 one.

So at some point I can understand Aleksandar frustation.


*) Aleksandar:

This series fall under the "Overall Guest CPU cores (TCG)" section
maintained by Richard and Paolo. I think you have to see this series as
a whole to understand the benefits of it.

With the same reasoning, I believe you shouldn't worry to not give your
Ack if you don't feel comfortable.

I think Richard sent this v3 to simply address comments raised by the
previous reviewer during v1/v2, where there was some discussions: I took
it as "this is the last round before getting merged" (unless someone
object).

It is hard to make everybody happy on a such big project, with so many
areas, lines of code, people, culture, etc... I believe we all try to
give our best, neither the commiters nor the reviewers are perfect, but
slowly we help this project to improve :)


Best regards,

Phil.

