Return-Path: <SRS0=vrBk=VF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA78C606C2
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 17:07:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15D1F21479
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 17:07:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15D1F21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkX6p-0002jv-4e
	for qemu-devel@archiver.kernel.org; Mon, 08 Jul 2019 13:07:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58104)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hkX6B-0002L1-8p
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 13:06:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hkX6A-0002sV-2u
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 13:06:43 -0400
Received: from mail.ilande.co.uk ([46.43.2.167]:52608
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1hkX69-0001y8-Sx
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 13:06:42 -0400
Received: from host86-189-155-55.range86-189.btcentralplus.com
 ([86.189.155.55] helo=[192.168.1.65])
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.89)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1hkX2F-0005tl-OB; Mon, 08 Jul 2019 18:02:41 +0100
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <3c8b83fe-120b-40e6-84d5-5a3b88e46ee3@ilande.co.uk>
 <CAFEAcA9KjJUE7R0OYfM9AT=Ydu8eXBYJR=sGoGog25xrpRMZig@mail.gmail.com>
 <914f608a-5128-87a5-1c08-e20db88ad216@ilande.co.uk>
 <CAFEAcA9=KKtbR624rV77cu41zUTyu2N8-+1Gjmg-rQwdS1htuw@mail.gmail.com>
 <20190708094107.GD3082@redhat.com>
 <28ca7c60-5795-31ff-1d71-1fac477ad996@redhat.com>
 <20190708101919.GF3082@redhat.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Openpgp: preference=signencrypt
Autocrypt: addr=mark.cave-ayland@ilande.co.uk; keydata=
 mQENBFQJuzwBCADAYvxrwUh1p/PvUlNFwKosVtVHHplgWi5p29t58QlOUkceZG0DBYSNqk93
 3JzBTbtd4JfFcSupo6MNNOrCzdCbCjZ64ik8ycaUOSzK2tKbeQLEXzXoaDL1Y7vuVO7nL9bG
 E5Ru3wkhCFc7SkoypIoAUqz8EtiB6T89/D9TDEyjdXUacc53R5gu8wEWiMg5MQQuGwzbQy9n
 PFI+mXC7AaEUqBVc2lBQVpAYXkN0EyqNNT12UfDLdxaxaFpUAE2pCa2LTyo5vn5hEW+i3VdN
 PkmjyPvL6DdY03fvC01PyY8zaw+UI94QqjlrDisHpUH40IUPpC/NB0LwzL2aQOMkzT2NABEB
 AAG0ME1hcmsgQ2F2ZS1BeWxhbmQgPG1hcmsuY2F2ZS1heWxhbmRAaWxhbmRlLmNvLnVrPokB
 OAQTAQIAIgUCVAm7PAIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQW8LFb64PMh9f
 NAgAuc3ObOEY8NbZko72AGrg2tWKdybcMVITxmcor4hb9155o/OWcA4IDbeATR6cfiDL/oxU
 mcmtXVgPqOwtW3NYAKr5g/FrZZ3uluQ2mtNYAyTFeALy8YF7N3yhs7LOcpbFP7tEbkSzoXNG
 z8iYMiYtKwttt40WaheWuRs0ZOLbs6yoczZBDhna3Nj0LA3GpeJKlaV03O4umjKJgACP1c/q
 T2Pkg+FCBHHFP454+waqojHp4OCBo6HyK+8I4wJRa9Z0EFqXIu8lTDYoggeX0Xd6bWeCFHK3
 DhD0/Xi/kegSW33unsp8oVcM4kcFxTkpBgj39dB4KwAUznhTJR0zUHf63LkBDQRUCbs8AQgA
 y7kyevA4bpetM/EjtuqQX4U05MBhEz/2SFkX6IaGtTG2NNw5wbcAfhOIuNNBYbw6ExuaJ3um
 2uLseHnudmvN4VSJ5Hfbd8rhqoMmmO71szgT/ZD9MEe2KHzBdmhmhxJdp+zQNivy215j6H27
 14mbC2dia7ktwP1rxPIX1OOfQwPuqlkmYPuVwZP19S4EYnCELOrnJ0m56tZLn5Zj+1jZX9Co
 YbNLMa28qsktYJ4oU4jtn6V79H+/zpERZAHmH40IRXdR3hA+Ye7iC/ZpWzT2VSDlPbGY9Yja
 Sp7w2347L5G+LLbAfaVoejHlfy/msPeehUcuKjAdBLoEhSPYzzdvEQARAQABiQEfBBgBAgAJ
 BQJUCbs8AhsMAAoJEFvCxW+uDzIfabYIAJXmBepHJpvCPiMNEQJNJ2ZSzSjhic84LTMWMbJ+
 opQgr5cb8SPQyyb508fc8b4uD8ejlF/cdbbBNktp3BXsHlO5BrmcABgxSP8HYYNsX0n9kERv
 NMToU0oiBuAaX7O/0K9+BW+3+PGMwiu5ml0cwDqljxfVN0dUBZnQ8kZpLsY+WDrIHmQWjtH+
 Ir6VauZs5Gp25XLrL6bh/SL8aK0BX6y79m5nhfKI1/6qtzHAjtMAjqy8ChPvOqVVVqmGUzFg
 KPsrrIoklWcYHXPyMLj9afispPVR8e0tMKvxzFBWzrWX1mzljbBlnV2n8BIwVXWNbgwpHSsj
 imgcU9TTGC5qd9g=
Message-ID: <267315a5-9969-9bfb-b4f6-57c61890fae4@ilande.co.uk>
Date: Mon, 8 Jul 2019 18:03:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190708101919.GF3082@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.189.155.55
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.43.2.167
Subject: Re: [Qemu-devel] Parallel make build fails on fast machine
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08/07/2019 11:19, Daniel P. Berrangé wrote:

> On Mon, Jul 08, 2019 at 12:17:12PM +0200, Philippe Mathieu-Daudé wrote:
>> On 7/8/19 11:41 AM, Daniel P. Berrangé wrote:
>>> On Sat, Jul 06, 2019 at 09:35:30PM +0100, Peter Maydell wrote:
>>>> On Sat, 6 Jul 2019 at 11:28, Mark Cave-Ayland
>>>> <mark.cave-ayland@ilande.co.uk> wrote:
>>>>>
>>>>> On 06/07/2019 11:16, Peter Maydell wrote:
>>>>>> If you just do 'make' rather than 'make install' does it fail the same way?
>>>>>
>>>>> Interesting. A quick test shows that "make V=1 -j2" works fine, it's just "make V=1
>>>>> -j2 install" which is failing.
>>>>
>>>> Mmm. I suspect most people just do the plain make (with the make install
>>>> phase either never or as a second command afterwards), so missing-dependency
>>>> bugs between the install targets and the build targets are probably more
>>>> likely to lurk around. We should stil fix them, though, assuming we
>>>> can track them down...
>>>
>>> The main 'install' target depends on 'all':
>>>
>>> install: all $(if $(BUILD_DOCS),install-doc) install-datadir install-localstatedir \
>>>
>>>
>>> but I think still allows 'install-doc', 'install-datadir' and
>>> 'install-localstatedir'  to parallelize wrt 'all'. I guess the fix is to
>>> make each of those 'install-xxx' targets depend on 'all' instead.
>>
>> I'm not sure I follow, are you suggesting this as a kludge for this
>> release, or you recommend this as a default?
> 
> I think it is the right solution in general.
> 
>> Apparently only 'recurse-install' depends of 'all'.

Something also looks a bit odd with distclean here on a fresh checkout:

build@ezio:~/src/qemu/git/tmp/qemu$ make distclean
  LD      recurse-clean.mo
cc: fatal error: no input files
compilation terminated.
rules.mak:118: recipe for target 'recurse-clean.mo' failed
make: *** [recurse-clean.mo] Error 1

A bit more experimentation shows that it's related to having multiple softmmu targets:

Works:

'./configure' '--target-list=x86_64-softmmu' '--prefix=/home/build/rel-qemu-git'
make V=1 -j4 install

'./configure' '--target-list=x86_64-softmmu arm-softmmu'
'--prefix=/home/build/rel-qemu-git'
make V=1 -j4 install

'./configure' '--target-list=x86_64-softmmu arm-softmmu ppc-softmmu'
'--prefix=/home/build/rel-qemu-git'
make V=1 -j4 install

Fails:

'./configure' '--target-list=x86_64-softmmu arm-softmmu ppc-softmmu sparc-softmmu'
'--prefix=/home/build/rel-qemu-git'
make V=1 -j4 install

'./configure' '--target-list=x86_64-softmmu arm-softmmu ppc-softmmu mips-softmmu'
'--prefix=/home/build/rel-qemu-git'
make V=1 -j4 install

Looking at the output it feels as if we're trying to build something that depends
upon libqemu.a before it's ready, but only with a long list of targets on a fast machine.


ATB,

Mark.

