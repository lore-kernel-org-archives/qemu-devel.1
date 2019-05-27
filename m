Return-Path: <SRS0=zt/K=T3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF1BC282CE
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 08:25:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA46E2173C
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 08:25:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA46E2173C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41899 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVAwP-00025M-36
	for qemu-devel@archiver.kernel.org; Mon, 27 May 2019 04:25:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hVAvc-0001og-Ah
	for qemu-devel@nongnu.org; Mon, 27 May 2019 04:24:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hVAvZ-0000gj-VX
	for qemu-devel@nongnu.org; Mon, 27 May 2019 04:24:20 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:57101)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hVAvZ-0000eG-Ni
	for qemu-devel@nongnu.org; Mon, 27 May 2019 04:24:17 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
	(mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
	1MGz5h-1hPy060ZZj-00E84n; Mon, 27 May 2019 10:23:41 +0200
To: Thomas Huth <thuth@redhat.com>,
	Lucien Anti-Spam <lucienmp_antispam@yahoo.com>, qemu-devel@nongnu.org, 
	"patchew-devel@redhat.com" <patchew-devel@redhat.com>
References: <1573827788.7732060.1558858158263.ref@mail.yahoo.com>
	<1573827788.7732060.1558858158263@mail.yahoo.com>
	<664d5119-d172-e601-c503-6e53ee13efe1@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <e25de074-cf23-fcf5-821f-38ab1779919d@vivier.eu>
Date: Mon, 27 May 2019 10:23:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <664d5119-d172-e601-c503-6e53ee13efe1@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:iZPMDxc1BP5osC3GFnIXrsB56V6vlTpvHbJT8l9DQ3Hlbf+tWbw
	FMd0xG67QmFboVQ5rEC1Ow9PE+ji35+TexLwJak1NnfMtvmo9OZmxdxasifW94N8dAajJCa
	Jo/P2NAef1VB8LXFzkQcdHCjUs+aoil/usDUHwVdvWgGrztHdeK/55YY33oa/AnabgnDG53
	x2D5mFd7uxaOq2H97GL0A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pm8CiQwJ2nQ=:5/8EafP4NfxUGLXk0rZKJp
	+XeVBREdYJCdbklqxV9RYXE0nP/xLS4ltKVLaZLMAnrf/lMCkxZFPTY3ZhEcaI2VG/MsWxi3C
	JBzBW67XkqVpqyHuJxWN9XYlhFDTburJY1ftucNT6YhSV7zIElzYYWwenJgdTiMxKLdJGU7Gd
	T1ZkukaV576XISLFy8Tnwv+lvwxCZ0me5HKLzD2AhOtDlsYjay7Xnns3I+f1tn0JUd+nagmcK
	vfp4U2hA9C8a7/gtQZAy0a9SfLpiNNCo8JcVbv41iqrL7WmJrRS2sxCowlJgvFoNLaw6Tbd8Z
	kdSGvHkgMvUMX0DGNYW4X7UB7O6yZh881huakKy5YlJUlfQQVy0JfaCRuH0yFzbTyO0dKU2k6
	9T+/7IKEcg7IhzzfKIxJIHfZZVXivHpVTFrFvMrXnJN7euhROW3hqNEeSIwmh4yN973p8Odfe
	0KZdUggPVu5YeTa3Pmxnc9qzJMS/24ghczewOoqmE6fyVHQGOOsv28JO5eQZOPZQ6bJ57Icfn
	Gme6T0YKQGebGk8VVVAE/K8O5aA/UMxIr3LN59o3V1LAIc3CVN0/JGumoZAfdQYf3itAdLNxE
	Lynuy9TTYHhP36Lk7f+e7iZDmieSTSTU8K9wZXilBc9TPz/ORDzbwFcX9f+937axyFKmuMWUf
	D0bhSHXlRdAhJBxMnW0oCQOL06djK9qHcgda+6CN6J8WiIcknet1XA1c6SFI39zi+d6jI9M4K
	cAWpJ0FrDBrcfcNB3g+5SXZ551JFpE2shCxADXnbo0ajbaB9aO1q32T4G4A=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.74
Subject: Re: [Qemu-devel] Failure to submit patches,
 two questions - what should I do?
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 27/05/2019 10:13, Thomas Huth wrote:
> On 26/05/2019 10.09, Lucien Anti-Spam via Qemu-devel wrote:
>>   
>>
>>     > On Sunday, May 26, 2019, 4:45:26 PM GMT+9, <no-reply@patchew.org> wrote: > Subject; [Qemu-devel] [PATCH] Incorrect Stack Pointer shadow register support on some m68k CPUs > .....> snip> .....> === OUTPUT BEGIN ===
>>>   ERROR: Author email address is mangled by the mailing list
>>>   #2:
>>>   Author: Lucien Murray-Pitts via Qemu-devel <qemu-devel@nongnu.org>
>>>   
>>>   WARNING: Block comments use a leading /* on a separate line
>>>   #46: FILE: target/m68k/cpu.h:465:
>>>   +/* The ColdFire core ISA is a RISC-style reduction of the 68000 series
>>>   
>>>   WARNING: Block comments use * on subsequent lines
>>>   #47: FILE: target/m68k/cpu.h:466:>
>>>   +/* The ColdFire core ISA is a RISC-style reduction of the 68000 series
>>> +  Whilst the 68000 flourished by adding extended stack/instructions in>.........> snip
>> Q1:  Name mangling seems to be a bug, whats going on - how should I be submiting now?        ( perl script didnt catch it AND there seems to already be a patch from half year or more ago .. https://patchwork.kernel.org/patch/10662525/ )  whats the correct action here?
> 
> It's a problem with your mail provider (yahoo.com), you personally can't
> do anything about this (except complaining to your provider or to switch
> to another one). See this URL for some details:
> 
> https://lists.gnu.org/archive/html/qemu-devel/2017-03/msg05625.html
> 
> Unless you are bothered and want to switch your provider, you can ignore
> the warning here, it's rather a note to the maintainer that they've got
> to adjust the "author" of the patch manually when they pick up the patch.
> 
>> Q2:  I am getting a WARNING but I believe it is an exception in this case.        yes I know it breaks the coding style BUT this coding style was already there for these comments.        Should I submit this patch with a move to the RIGHT coding style? or will this patch be accepted as the code is older style?
> 
> It's up to the maintainer of the subsystem (Laurent?) - IMHO it's ok to
> ask for an exception in this case, but a separate clean-up patch is
> certainly also welcome.

In this case I thought it was just a missing carriage-return on the 
first line, but in fact we have a missing '*' on every line, so, yes, I 
agree it can stay as-is and a separate clean-up patch can be sent later.

Thanks,
Laurent



