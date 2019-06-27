Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D32FC48BD6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 00:09:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E582216C8
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 00:09:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E582216C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgHyz-000729-3R
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 20:09:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59363)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <laurent@vivier.eu>) id 1hgHxz-0006ML-2N
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 20:08:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1hgHxx-00009s-Os
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 20:08:42 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:33469)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1hgHxx-000097-EB; Wed, 26 Jun 2019 20:08:41 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue011 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1N7iT4-1icIHt3BSM-014oZj; Thu, 27 Jun 2019 02:08:31 +0200
To: Justin Hibbits <chmeeedalf@gmail.com>
References: <20190607135653.6ece685d@titan.knownspace>
 <8676232e-917d-44e2-1149-b25f26698a73@vivier.eu>
 <92053c9c-e7bf-76cb-9399-987f4ab31bfb@vivier.eu>
 <20190626113742.6bcd8a26@titan.knownspace>
 <d60f142d-27ef-bfe5-1eb6-cefb22640625@vivier.eu>
 <20190626130414.08940342@titan.knownspace>
 <CAHSQbTCxP09J9NtFiN4UpdXHJZHtTw_F66hfdAS2sM4=E5GHyQ@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <477ebe22-eddb-41ba-5811-4a70e639a89a@vivier.eu>
Date: Thu, 27 Jun 2019 02:08:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAHSQbTCxP09J9NtFiN4UpdXHJZHtTw_F66hfdAS2sM4=E5GHyQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:9VWNAulYL9p6uI+rwl2SFYmEnPAF9+cWUx9CZo78ZqTuqEqShWp
 t3L0tPRyL7FQzvmqVg7NAbd0wH7dTMq0SN+eSj8ThIIgHF+Kcipt8j9kij0wzEGHpFSUS6/
 tOkcTsUUE3mQ9Eqt62I9kS5TfZ3uG3VaGl8GJAQBluWr7MkTkdbCwqEqKmmtgfHEVHN+BIy
 AzSkzvG4q1UINych3V9Mg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:opuad1ZTRJI=:mHKin+lyFcxR+23YKK4vZN
 1SVeqoDU8EYAxaOaQHr3vo2OS8vGd5xLmrBanjNZ5fjTsZOT6JhH6hCjQxItWUmAAo9r8YIA9
 4QlOvLzmZCqMd1vgkO0KbvhDq0qzTDqFfl4Wy/QxrVJl/lWiCQbf7DmO9z2138SREooQYqMFs
 z/yJUB8vJdrCg/e6r0MbPePay7nJzr0vTjciM2Ri5plVJWo246YbBAT32FEvROr83mKaWS0qs
 puFfYli4ddDpH1XH/OercfYW4179kRaG0ZsMco2bmeEis26O8EO+J5cPJ2LaLhUZJ0cnpB7Nu
 Nn8t/gfdGCka4jnCuZQfwsZ3bEKPYXYJ1q5fpkh5g8MdZpu/QmPwegNl6ZPCe93HhzxK3MVXS
 +/GGFlQ6/L7TyZHWzAp0rQ8ryC9YOLm0klpDo6HtEIMdRahQSVlynBGexxH4R2RxgSlLJP/3g
 xI2eNiq09Nu55leNI2l9bo+IyJTEPVO+Ng2HfP/aTtWtEr1AMtHMU9N11Ws18gDuLeUyeQ2gX
 UFjuQRkQCfOJZl7bs+H3N5ypKiIpgzfFm3Ssp8J/GVxZCQv31dc1QB40u+jsI2Gm2q9vnKTr7
 vpfZRT39eedtl2JZspfWdYeEbCcvB67FV/Lmlgying1lDsu0DT4ixXCtljbLGOS9RlKplTQ+P
 nW+gKsg1V9dobTjJCB3oAr9oGxsoBKTS+nJ+y/YPyNK0394Tmzu3nRAzlqqq5JJmOG6/Hu9uX
 4CuClY23JX56Dg8rCh+D4S8XFTnPS7DOAQQkJhcT0vpfC6757hXsXtkKPRM=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.135
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

Le 27/06/2019 à 02:02, Justin Hibbits a écrit :
> 
> 
> On Wed, Jun 26, 2019, 13:04 Justin Hibbits <chmeeedalf@gmail.com
> <mailto:chmeeedalf@gmail.com>> wrote:
> 
>     On Wed, 26 Jun 2019 18:47:42 +0200
>     Laurent Vivier <laurent@vivier.eu <mailto:laurent@vivier.eu>> wrote:
> 
>     > Le 26/06/2019 à 18:37, Justin Hibbits a écrit :
>     > > On Wed, 26 Jun 2019 18:16:36 +0200
>     > > Laurent Vivier <laurent@vivier.eu <mailto:laurent@vivier.eu>> wrote:
>     > >   
>     > >> Le 26/06/2019 à 18:14, Laurent Vivier a écrit : 
>     > >>> Le 07/06/2019 à 20:56, Justin Hibbits a écrit :   
>     > >>>> The attached very trivial patch fixes a startup bug that prevents
>     > >>>> at least Qemu 3.1 and later from working on FreeBSD/powerpc64.
>     > >>>>
>     > >>>> - Justin
>     > >>>>   
>     > >>>
>     > >>> Please don't send a patch in attachment but inlined in the message
>     > >>> (you may use "git send-email" for that).
>     > >>>
>     > >>> This patch fixes "util: add cacheinfo" that has changed the type
>     > >>> from unsigned to long.
>     > >>>
>     > >>> You can add the following line in the commit message:
>     > >>>
>     > >>> Fixes: b255b2c8a548 ("util: add cacheinfo")
>     > >>>
>     > >>> Reviewed-by: Laurent Vivier <laurent@vivier.eu
>     <mailto:laurent@vivier.eu>>
>     > >>>     
>     > >>
>     > >> CC: author of b255b2c8a548 ("util: add cacheinfo")
>     > >>
>     > >> Thanks,
>     > >> Laurent 
>     > >
>     > > Hi Laurent,
>     > >
>     > > Sorry.  I had never used git send-email before, so wasn't
>     > > comfortable with it.  I just updated the commit message with your
>     > > feedback and used git send-email to submit the patch.  I hope
>     > > everything went well. 
>     >
>     > It seems not. I didn't receive it.
>     >
>     > Did you configure the SMTP server. See git-send-email(1):
>     >
>     >    Use gmail as the smtp server
>     >
>     >        To use git send-email to send your patches through the GMail
>     > SMTP server, edit ~/.gitconfig to specify your account settings:
>     >
>     >            [sendemail]
>     >                    smtpEncryption = tls
>     >                    smtpServer = smtp.gmail.com <http://smtp.gmail.com>
>     >                    smtpUser = yourname@gmail.com
>     <mailto:yourname@gmail.com>
>     >                    smtpServerPort = 587
>     >
>     >        If you have multifactor authentication setup on your gmail
>     > account, you will need to generate an app-specific password for use
>     > with git send-email. Visit
>     >        https://security.google.com/settings/security/apppasswords to
>     > create it.
>     >
>     >        Once your commits are ready to be sent to the mailing list,
>     > run the following commands:
>     >
>     >            $ git format-patch --cover-letter -M origin/master -o
>     > outgoing/ $ edit outgoing/0000-*
>     >            $ git send-email outgoing/*
>     >
>     >        The first time you run it, you will be prompted for your
>     > credentials. Enter the app-specific or your regular password as
>     > appropriate. If you have credential helper configured (see
>     > git-credential(1)), the password will be saved in the credential
>     > store so you won’t have to type it the next time.
>     >
>     >        Note: the following perl modules are required Net::SMTP::SSL,
>     >        MIME::Base64 and Authen::SASL
>     >
>     > Thanks,
>     > Laurent
>     >
>     > 
> 
>     Hm, you're right.  Even after making the config changes and installing
>     the necessary packages, I still have no luck with git send-email.  Might
>     take a bit to debug this.
> 
>     - Justin
> 
> 
> Sorry for the multiplicity, looks like Gmail forwarded it eventually,
> but not until I tried several times debugging it.

Not sure, I didn't receive any of them.

Thanks,
Laurent


