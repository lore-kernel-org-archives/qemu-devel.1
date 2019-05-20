Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 056C6C04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 17:52:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6EC920675
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 17:52:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6EC920675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39613 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSmSL-0007Ml-Ru
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 13:52:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hSm6U-000654-7l
	for qemu-devel@nongnu.org; Mon, 20 May 2019 13:29:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hSm6S-0007yT-CW
	for qemu-devel@nongnu.org; Mon, 20 May 2019 13:29:37 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38298)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hSm6S-0007xn-5N
	for qemu-devel@nongnu.org; Mon, 20 May 2019 13:29:36 -0400
Received: by mail-wm1-f66.google.com with SMTP id t5so167288wmh.3
	for <qemu-devel@nongnu.org>; Mon, 20 May 2019 10:29:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=IoECUOL5/7gflP4Be+bmrblCNay89B6gtLpPtlCPIcw=;
	b=PtWjshgKdg6IE9H9LdkALLfbj3uaGsMmp65CSovKoETk2AXSMKWJfCvXc+nraNm5tg
	csCfp4ab8nDVDZ6T4AYqOwbbx96IxEs8/XtXFBvY3EduLw01r+1FL4dDwm1PLv7W3ORJ
	zMWCHHYYOWwP8BBi5o46zIS0J7CMxG1YY15WhhMdojsYezeL4PpZ5WhGE14mEEKvhdFh
	240tzCiGY2eOtUKvVPlB7StVrda5dVAT5k26z7jv6JBWkcXhTX9jKaRqAii6Zsbdq8Yh
	wZQwKlD2cH/a82PdvHrD78dnoEZxLmkD9XsDtPA+cDANZfvA2n2er3sw6YoPCILy9wxf
	Yjzg==
X-Gm-Message-State: APjAAAWKmzlKSUXwxGsIbOi3IfftvHHZY17ee/HqeJS8Ks6+niGfhL4y
	SKMs+d9SqHGGWRaxxcjyxL04Uw==
X-Google-Smtp-Source: APXvYqzRZg3o0eueyPKnT+Az9NGrLIF8TmmxhRcJ0lKeia78BEtJnteI27iFTq3Lh26Yx0D3dUmmxw==
X-Received: by 2002:a1c:9c02:: with SMTP id f2mr219851wme.8.1558373374168;
	Mon, 20 May 2019 10:29:34 -0700 (PDT)
Received: from [192.168.1.43] (228.red-83-52-173.dynamicip.rima-tde.net.
	[83.52.173.228])
	by smtp.gmail.com with ESMTPSA id i125sm337367wmi.2.2019.05.20.10.29.33
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Mon, 20 May 2019 10:29:33 -0700 (PDT)
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
	Peter Maydell <peter.maydell@linaro.org>
References: <1558263144-8776-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<CAFEAcA842fq=CG+y_qGySWV3i_JNPEk0iQwCJxed6cQcCMidWA@mail.gmail.com>
	<CAL1e-=i91f-vgyFJOJhN51JaUoTZgdhby_F_YyeTr_KYWBsZeA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <72e09057-0011-04e0-4166-5ad27aa0da3b@redhat.com>
Date: Mon, 20 May 2019 19:29:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAL1e-=i91f-vgyFJOJhN51JaUoTZgdhby_F_YyeTr_KYWBsZeA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [PULL 00/10] MIPS queue for May 19th, 2019
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
Cc: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Aleksandar,

On 5/20/19 2:35 PM, Aleksandar Markovic wrote:
> On May 20, 2019 2:11 PM, "Peter Maydell" <peter.maydell@linaro.org> wrote:
>>
>> On Sun, 19 May 2019 at 11:52, Aleksandar Markovic
>> <aleksandar.markovic@rt-rk.com> wrote:
>>>
>>> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>>>
>>> The following changes since commit
> 1b46b4daa6fbf45eddcf77877379a0afac341df9:
>>>
>>>   Merge remote-tracking branch
> 'remotes/kraxel/tags/ui-20190517-pull-request' into staging (2019-05-17
> 17:25:19 +0100)
>>>
>>> are available in the git repository at:
>>>
>>>   https://github.com/AMarkovic/qemu tags/mips-queue-may-19-2019
>>>
>>> for you to fetch changes up to 71074d1d2fae9a0c8dab87c5bb5271a71d6cb7ab:
>>>
>>>   mips: Decide to map PAGE_EXEC in map_address (2019-05-19 12:11:46
> +0200)
>>>
>>> ----------------------------------------------------------------
>>>
>>> MIPS queue for May 19th, 2019
>>>
>>>   * A fix for HelenOS boot hang (related to the flag PAGE_EXEC)
>>>   * A set of fixes for emulation of MSA ASE on big endian hosts
>>>   * Improved usage of object_initialize() and object_initialize_child()
>>>   * Better handling of 'div by zero' cases in MSA ASE
>>>
>>> ----------------------------------------------------------------
>>
>> Hi -- I'm afraid this fails to build with clang:
>> /home/petmay01/linaro/qemu-for-merges/target/mips/op_helper.c:4536:20:
>> error: unused function 'ensure_writable_pages'
>> [-Werror,-Wunused-function]
>> static inline void ensure_writable_pages(CPUMIPSState *env,
>>                    ^
>> 1 error generated.
>>
>> It looks like "target/mips: Fix MSA instructions ST.<B|H|W|D>
>> on big endian host" removed the last use of this function
>> but didn't remove the now-unused definition.
>>
>> (clang is pickier than gcc about not allowing unused 'static
>> inline' functions -- gcc ignores them anywhere, clang only if
>> they're in .h files.)
>>
> 
> Ughhh... Sorry. I should have had a script for this. I'll send v2 in few
> days.

You can use Travis-CI for that, simply register an account (free) and
push branches/tags to your GitHub repo, that will trigger many build
configs run by upstream:

https://travis-ci.org/philmd/qemu/builds/534805597

> 
> Regards,
> Aleksandar
> 
>> thanks
>> -- PMm
>>

