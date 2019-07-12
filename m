Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB706C742D7
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 19:37:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B891C205C9
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 19:37:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B891C205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hm1Me-0000xX-Bb
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 15:37:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48381)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hm1MU-0000Z6-Aw
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 15:37:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hm1MS-0008DL-AO
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 15:37:41 -0400
Received: from mail.ilande.co.uk ([46.43.2.167]:59976
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1hm1MS-0006Cq-3Y
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 15:37:40 -0400
Received: from host86-189-155-55.range86-189.btcentralplus.com
 ([86.189.155.55] helo=[192.168.1.65])
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.89)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1hm1Ia-00072Y-2I; Fri, 12 Jul 2019 20:33:40 +0100
To: Markus Armbruster <armbru@redhat.com>
References: <3c8b83fe-120b-40e6-84d5-5a3b88e46ee3@ilande.co.uk>
 <CAFEAcA9KjJUE7R0OYfM9AT=Ydu8eXBYJR=sGoGog25xrpRMZig@mail.gmail.com>
 <914f608a-5128-87a5-1c08-e20db88ad216@ilande.co.uk>
 <CAFEAcA9=KKtbR624rV77cu41zUTyu2N8-+1Gjmg-rQwdS1htuw@mail.gmail.com>
 <20190708094107.GD3082@redhat.com>
 <28ca7c60-5795-31ff-1d71-1fac477ad996@redhat.com>
 <20190708101919.GF3082@redhat.com>
 <267315a5-9969-9bfb-b4f6-57c61890fae4@ilande.co.uk>
 <87lfx4wry6.fsf@dusky.pond.sub.org>
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
Message-ID: <98789380-7402-535b-0db9-b6c90af2f161@ilande.co.uk>
Date: Fri, 12 Jul 2019 20:34:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <87lfx4wry6.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
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
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/07/2019 15:45, Markus Armbruster wrote:

> Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> writes:
> 
>> Something also looks a bit odd with distclean here on a fresh checkout:
>>
>> build@ezio:~/src/qemu/git/tmp/qemu$ make distclean
>>   LD      recurse-clean.mo
>> cc: fatal error: no input files
>> compilation terminated.
>> rules.mak:118: recipe for target 'recurse-clean.mo' failed
>> make: *** [recurse-clean.mo] Error 1
> 
> This one should be fixed in master (commit 8d358a5ea08).  If it's still
> broken for you, let me know.

Yes, this is certainly looking much better! There still seems to be something wrong
with the tests/ subdirectory with your "make install" patch applied to git master if
I attempt a "make distclean" after a successful "make V=1 -j2 install" in an
out-of-tree build:

build@ezio:~/src/qemu/git/obj$ ../qemu/configure '--target-list=x86_64-softmmu
sparc64-softmmu sparc-softmmu ppc-softmmu arm-softmmu'
'--prefix=/home/build/rel-qemu-git' '--disable-pie' '--enable-debug'
build@ezio:~/src/qemu/git/obj$ make V=1 -j2 install

(lots of build output cut, but completes successfully)

build@ezio:~/src/qemu/git/obj$ make distclean
Makefile:85: rules.mak: No such file or directory
Makefile:437: tests/Makefile.include: No such file or directory
cat: VERSION: No such file or directory
Makefile:1127: tests/docker/Makefile.include: No such file or directory
Makefile:1128: tests/vm/Makefile.include: No such file or directory
make: *** No rule to make target 'tests/vm/Makefile.include'.  Stop.


ATB,

Mark.

