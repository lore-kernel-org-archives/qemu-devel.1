Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE1FBC48BD3
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 16:51:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B47E32080C
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 16:51:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B47E32080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgB9E-0003AT-VK
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 12:51:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33946)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <laurent@vivier.eu>) id 1hgB5Q-0001rQ-HF
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 12:47:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1hgB5P-0003Yl-5n
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 12:47:56 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:56833)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1hgB5M-0003W6-B2; Wed, 26 Jun 2019 12:47:52 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue012 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MYLqs-1i1gEv1Gc6-00VTds; Wed, 26 Jun 2019 18:47:43 +0200
To: Justin Hibbits <chmeeedalf@gmail.com>
References: <20190607135653.6ece685d@titan.knownspace>
 <8676232e-917d-44e2-1149-b25f26698a73@vivier.eu>
 <92053c9c-e7bf-76cb-9399-987f4ab31bfb@vivier.eu>
 <20190626113742.6bcd8a26@titan.knownspace>
From: Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <d60f142d-27ef-bfe5-1eb6-cefb22640625@vivier.eu>
Date: Wed, 26 Jun 2019 18:47:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190626113742.6bcd8a26@titan.knownspace>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Sxw4H34TAQ8l9T/oC9EO1EUK++eQv7gFPsg8Lpc/7NHtQ+C2aTj
 2J3w9k0Hu4Fs7AKrLDfNAUHFcRIKFLnRCIDU9Qa/IaMNDDP+t79CFwUDVb5R61SLjHsblvn
 IokEqU1pCQiZu7nP4Pyzq7sBQ+1PkOBNJeBesbr6eNpnvgL0vdq7cRJRmKG7vaxLV+60QLo
 nZk4g9oTiT1IyE7ZrHB9w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tpIsUCZisMA=:rlvY+7+k2t7p8+HVkPMxmp
 sexvO5uibu2v22RCiaKZZ+glXx1rDdnswzXP2Y+YisILwlhyt01yOTX+EINViPBvEwVNwXlRH
 8N9R+3n8nNPyXHQSYU+6wDgIPab/9bfNFRNumXHyL/TnNc4DnZb3nj/3GB8fZ9Z8o69AtiJxu
 r2inD8wqALW1aMxWEAzNLilLMaqtqUlH7R7OjE6vqTuaMdC5S2NEr2X0nCV30sNEtPVMVl4xY
 VfB8NT7Bpl5Co/GsZcGUEhQjjbZlHBTU0coWFO1WTakmQd13GQ1Y7wg+Sn1+j+hiSwP/o0HgR
 soZclRqTB9xs7jbxWXy9RnUNvfxgky/WGZdWecB5GIQEB2LA+HDtKNT1jBDRe5DAVMCG+wVsN
 DYdhIH9qFu2rUYv2gX0T0EguyoqPHP2/MRWyPpFTTx2NVCs4n26NZKFshbTG1C4c7ZinH1VRx
 Kw7NrkD8sh2JrFAAqxvIBEoxE/12GLpEZ/80pv4evLdYEWurp/K1al+0/LuLNVWx1GFUDzX3q
 aAoKUSHcMtb2AC/iYfeHJxXftAwvxqegTHqquR4pTcrzjzTzwY0wo9KR4yU4OzOVRwicpXUsL
 9AqtGtAxhyVbjn8P9QGKf7N6fJgfKWbdySb4IzI1pDx8R8yUhcurulHplWBM6G9tUqE+0nOJd
 LHT19nbO3bC1E3ZGMqvqVFoYfFW5VtoCrpwFBf0/ysCkpPBJIn5nnH58TcfgXw1CoCzXb1aA+
 +A60JyX5Vh8hpFc4tPu2gi5Ye6bfxJwXTvEoVlT/ljiHNBAT/t7FlG1OPZE=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.130
Subject: Re: [Qemu-devel] [Qemu-trivial] Fix cacheline size retrieval on
 FreeBSD/PowerPC(64)
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
Cc: qemu-trivial@nongnu.org, "Emilio G. Cota" <cota@braap.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 26/06/2019 à 18:37, Justin Hibbits a écrit :
> On Wed, 26 Jun 2019 18:16:36 +0200
> Laurent Vivier <laurent@vivier.eu> wrote:
> 
>> Le 26/06/2019 à 18:14, Laurent Vivier a écrit :
>>> Le 07/06/2019 à 20:56, Justin Hibbits a écrit :  
>>>> The attached very trivial patch fixes a startup bug that prevents
>>>> at least Qemu 3.1 and later from working on FreeBSD/powerpc64.
>>>>
>>>> - Justin
>>>>  
>>>
>>> Please don't send a patch in attachment but inlined in the message
>>> (you may use "git send-email" for that).
>>>
>>> This patch fixes "util: add cacheinfo" that has changed the type
>>> from unsigned to long.
>>>
>>> You can add the following line in the commit message:
>>>
>>> Fixes: b255b2c8a548 ("util: add cacheinfo")
>>>
>>> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
>>>   
>>
>> CC: author of b255b2c8a548 ("util: add cacheinfo")
>>
>> Thanks,
>> Laurent
> 
> Hi Laurent,
> 
> Sorry.  I had never used git send-email before, so wasn't comfortable
> with it.  I just updated the commit message with your feedback and used
> git send-email to submit the patch.  I hope everything went well.

It seems not. I didn't receive it.

Did you configure the SMTP server. See git-send-email(1):

   Use gmail as the smtp server

       To use git send-email to send your patches through the GMail SMTP
       server, edit ~/.gitconfig to specify your account settings:

           [sendemail]
                   smtpEncryption = tls
                   smtpServer = smtp.gmail.com
                   smtpUser = yourname@gmail.com
                   smtpServerPort = 587

       If you have multifactor authentication setup on your gmail account, you
       will need to generate an app-specific password for use with git
       send-email. Visit
       https://security.google.com/settings/security/apppasswords to create
       it.

       Once your commits are ready to be sent to the mailing list, run the
       following commands:

           $ git format-patch --cover-letter -M origin/master -o outgoing/
           $ edit outgoing/0000-*
           $ git send-email outgoing/*

       The first time you run it, you will be prompted for your credentials.
       Enter the app-specific or your regular password as appropriate. If you
       have credential helper configured (see git-credential(1)), the password
       will be saved in the credential store so you won’t have to type it the
       next time.

       Note: the following perl modules are required Net::SMTP::SSL,
       MIME::Base64 and Authen::SASL

Thanks,
Laurent

 

