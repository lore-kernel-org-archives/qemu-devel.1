Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62437C0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 13:24:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29C93214AE
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 13:24:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29C93214AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhwIf-00088L-Rz
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 09:24:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38974)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <laurent@vivier.eu>) id 1hhwBZ-0002xS-2l
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 09:17:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1hhwBT-0001Uc-Hh
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 09:17:33 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:36583)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1hhwBN-0001Hn-Ln; Mon, 01 Jul 2019 09:17:22 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MlNl5-1iPHgn1nf3-00lkpr; Mon, 01 Jul 2019 15:17:08 +0200
To: Justin Hibbits <chmeeedalf@gmail.com>
References: <20190607135653.6ece685d@titan.knownspace>
 <8676232e-917d-44e2-1149-b25f26698a73@vivier.eu>
 <92053c9c-e7bf-76cb-9399-987f4ab31bfb@vivier.eu>
 <20190626113742.6bcd8a26@titan.knownspace>
 <d60f142d-27ef-bfe5-1eb6-cefb22640625@vivier.eu>
 <20190626130414.08940342@titan.knownspace>
 <CAHSQbTCxP09J9NtFiN4UpdXHJZHtTw_F66hfdAS2sM4=E5GHyQ@mail.gmail.com>
 <477ebe22-eddb-41ba-5811-4a70e639a89a@vivier.eu>
 <CAHSQbTCUzR5WiykWGZOH1bvBPWx15_ZA-=7b17c6AnRK4kn3yA@mail.gmail.com>
 <cd0a35ce-1f8c-6718-13d9-7a481e1eeb31@vivier.eu>
 <CAHSQbTDMWXX978oWBvYhh1Uz7CeA1KQGz6+11rqwYv+ZOWyVOw@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <669c6835-20a6-2a60-f130-ff09b19175a8@vivier.eu>
Date: Mon, 1 Jul 2019 15:17:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAHSQbTDMWXX978oWBvYhh1Uz7CeA1KQGz6+11rqwYv+ZOWyVOw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:SXA0eItvCx9cfAoY/Mzfjg6UvMto20buqXWaWFgqD6vGMHEmCEn
 YyfGeYsYyteLx9NmOhes+M//1LstG4ca9jze96mAbMAhgbyFf/lrKifUDEL14IX/N1LVLWM
 ftA+i+IKIm7jN69UxrAobF2WQkUQGyFz9rIbBvj7IYj4r2+vf17svZ0gfozh7/zRpUe/NYD
 17nV508zinOeXrX8RgI5Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:E8h+fiRx6yw=:UX7dnLN7OiinsxVBzvqsx3
 UerOge24WA3slpBxPqZGqE3gVmutEuKzl8RQ4okItHNEOrKKrxxsvYt4owgprVhw8lR4joSBA
 2fmN5EVjT5xlThA0628nJJHc08KfSPtQqOfme/L6ciCjf9mqkxlOYAPNwBWUTJ7Sv6+Gq2pua
 n7zKotFeVBkTHnQXvSKJpyM2Uzv6o7y4U3AxfDD4Y1DeeGGe0qwHCA3k5VBd3ulpiEsQTrKWr
 ZdJkK98PcP07FgNHPP1ZY3htpCbP+2sbUWm8+5fs7UAEYziS+BM3KAoxd6wrkfpjBPUmcIzZZ
 IfyAT3hvRT8XnutvsDppGVHRXFUmbi+JNsQSei+ZH6xjX3as53uJuvteFFVdanmtjxwNsS0U7
 OHApSR7X4XXIwwPchG438069qniJdwTD5HkDO+Z5mrS2af6IY6FUtiqc4FlNm0A14hP7Y4GYt
 fR8dM40R3C9f0OnXlT5XYY9OH6V0gNVDBM0UFmU5/3W7t9V4Q9TJqKlETWF5MtpMlVQW9se6j
 G8fJ0sd1HYDukDMbi658RZuWCszfc06EmSZWtod5xNW/7ofF3GpmKkJ7YxzfD60U1KYbazRDQ
 qp2GCKhXY4fj5gWkIgg3TMouvOFgngiFhXjnjy6o3kWTTL4fKE9SJJH0YB+0f1EamLI4ANqtv
 9B1EOyaaQCIYT3xfzzkPV43G0EcAMMqY6YwndicBh+DICrR6kxqmM1+n9YmY57mD0lruzLtJr
 wP+Fe5IjwPl3ycpH+51aOoAhgv+46T8kRjlJEX0ZdMRl0I4JKECElyQE6DQ=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.74
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

Le 01/07/2019 à 15:02, Justin Hibbits a écrit :
> 
> 
> On Mon, Jul 1, 2019, 03:54 Laurent Vivier <laurent@vivier.eu
> <mailto:laurent@vivier.eu>> wrote:
> 
>     Le 27/06/2019 à 02:15, Justin Hibbits a écrit :
>     >
>     >
>     > On Wed, Jun 26, 2019, 19:08 Laurent Vivier <laurent@vivier.eu
>     <mailto:laurent@vivier.eu>
>     > <mailto:laurent@vivier.eu <mailto:laurent@vivier.eu>>> wrote:
>     >
>     >     Le 27/06/2019 à 02:02, Justin Hibbits a écrit :
>     >     >
>     >     >
>     >     > On Wed, Jun 26, 2019, 13:04 Justin Hibbits
>     <chmeeedalf@gmail.com <mailto:chmeeedalf@gmail.com>
>     >     <mailto:chmeeedalf@gmail.com <mailto:chmeeedalf@gmail.com>>
>     >     > <mailto:chmeeedalf@gmail.com <mailto:chmeeedalf@gmail.com>
>     <mailto:chmeeedalf@gmail.com <mailto:chmeeedalf@gmail.com>>>> wrote:
>     >     >
>     >     >     On Wed, 26 Jun 2019 18:47:42 +0200
>     >     >     Laurent Vivier <laurent@vivier.eu
>     <mailto:laurent@vivier.eu> <mailto:laurent@vivier.eu
>     <mailto:laurent@vivier.eu>>
>     >     <mailto:laurent@vivier.eu <mailto:laurent@vivier.eu>
>     <mailto:laurent@vivier.eu <mailto:laurent@vivier.eu>>>> wrote:
>     >     >
>     >     >     > Le 26/06/2019 à 18:37, Justin Hibbits a écrit :
>     >     >     > > On Wed, 26 Jun 2019 18:16:36 +0200
>     >     >     > > Laurent Vivier <laurent@vivier.eu
>     <mailto:laurent@vivier.eu>
>     >     <mailto:laurent@vivier.eu <mailto:laurent@vivier.eu>>
>     <mailto:laurent@vivier.eu <mailto:laurent@vivier.eu>
>     >     <mailto:laurent@vivier.eu <mailto:laurent@vivier.eu>>>> wrote:
>     >     >     > >   
>     >     >     > >> Le 26/06/2019 à 18:14, Laurent Vivier a écrit : 
>     >     >     > >>> Le 07/06/2019 à 20:56, Justin Hibbits a écrit :   
>     >     >     > >>>> The attached very trivial patch fixes a startup bug
>     >     that prevents
>     >     >     > >>>> at least Qemu 3.1 and later from working on
>     >     FreeBSD/powerpc64.
>     >     >     > >>>>
>     >     >     > >>>> - Justin
>     >     >     > >>>>   
>     >     >     > >>>
>     >     >     > >>> Please don't send a patch in attachment but inlined in
>     >     the message
>     >     >     > >>> (you may use "git send-email" for that).
>     >     >     > >>>
>     >     >     > >>> This patch fixes "util: add cacheinfo" that has
>     changed
>     >     the type
>     >     >     > >>> from unsigned to long.
>     >     >     > >>>
>     >     >     > >>> You can add the following line in the commit message:
>     >     >     > >>>
>     >     >     > >>> Fixes: b255b2c8a548 ("util: add cacheinfo")
>     >     >     > >>>
>     >     >     > >>> Reviewed-by: Laurent Vivier <laurent@vivier.eu
>     <mailto:laurent@vivier.eu>
>     >     <mailto:laurent@vivier.eu <mailto:laurent@vivier.eu>>
>     >     >     <mailto:laurent@vivier.eu <mailto:laurent@vivier.eu>
>     <mailto:laurent@vivier.eu <mailto:laurent@vivier.eu>>>>
>     >     >     > >>>     
>     >     >     > >>
>     >     >     > >> CC: author of b255b2c8a548 ("util: add cacheinfo")
>     >     >     > >>
>     >     >     > >> Thanks,
>     >     >     > >> Laurent 
>     >     >     > >
>     >     >     > > Hi Laurent,
>     >     >     > >
>     >     >     > > Sorry.  I had never used git send-email before, so
>     wasn't
>     >     >     > > comfortable with it.  I just updated the commit message
>     >     with your
>     >     >     > > feedback and used git send-email to submit the
>     patch.  I hope
>     >     >     > > everything went well. 
>     >     >     >
>     >     >     > It seems not. I didn't receive it.
>     >     >     >
>     >     >     > Did you configure the SMTP server. See git-send-email(1):
>     >     >     >
>     >     >     >    Use gmail as the smtp server
>     >     >     >
>     >     >     >        To use git send-email to send your patches through
>     >     the GMail
>     >     >     > SMTP server, edit ~/.gitconfig to specify your account
>     settings:
>     >     >     >
>     >     >     >            [sendemail]
>     >     >     >                    smtpEncryption = tls
>     >     >     >                    smtpServer = smtp.gmail.com
>     <http://smtp.gmail.com>
>     >     <http://smtp.gmail.com> <http://smtp.gmail.com>
>     >     >     >                    smtpUser = yourname@gmail.com
>     <mailto:yourname@gmail.com>
>     >     <mailto:yourname@gmail.com <mailto:yourname@gmail.com>>
>     >     >     <mailto:yourname@gmail.com <mailto:yourname@gmail.com>
>     <mailto:yourname@gmail.com <mailto:yourname@gmail.com>>>
>     >     >     >                    smtpServerPort = 587
>     >     >     >
>     >     >     >        If you have multifactor authentication setup on
>     your
>     >     gmail
>     >     >     > account, you will need to generate an app-specific
>     password
>     >     for use
>     >     >     > with git send-email. Visit
>     >     >     >       
>     >     https://security.google.com/settings/security/apppasswords to
>     >     >     > create it.
>     >     >     >
>     >     >     >        Once your commits are ready to be sent to the
>     mailing
>     >     list,
>     >     >     > run the following commands:
>     >     >     >
>     >     >     >            $ git format-patch --cover-letter -M
>     origin/master -o
>     >     >     > outgoing/ $ edit outgoing/0000-*
>     >     >     >            $ git send-email outgoing/*
>     >     >     >
>     >     >     >        The first time you run it, you will be prompted
>     for your
>     >     >     > credentials. Enter the app-specific or your regular
>     password as
>     >     >     > appropriate. If you have credential helper configured (see
>     >     >     > git-credential(1)), the password will be saved in the
>     credential
>     >     >     > store so you won’t have to type it the next time.
>     >     >     >
>     >     >     >        Note: the following perl modules are required
>     >     Net::SMTP::SSL,
>     >     >     >        MIME::Base64 and Authen::SASL
>     >     >     >
>     >     >     > Thanks,
>     >     >     > Laurent
>     >     >     >
>     >     >     > 
>     >     >
>     >     >     Hm, you're right.  Even after making the config changes and
>     >     installing
>     >     >     the necessary packages, I still have no luck with git
>     >     send-email.  Might
>     >     >     take a bit to debug this.
>     >     >
>     >     >     - Justin
>     >     >
>     >     >
>     >     > Sorry for the multiplicity, looks like Gmail forwarded it
>     eventually,
>     >     > but not until I tried several times debugging it.
>     >
>     >     Not sure, I didn't receive any of them.
>     >
>     >     Thanks,
>     >     Laurent
>     >
>     >
>     > Sigh, 4 copies ended up in my Gmail spam folder, so I thought it
>     made it
>     > through.
>     >
> 
>     Any news? Freeze is coming.
> 
>     Thanks,
>     Laurent
> 
> 
> I'll manually do it when I get home tomorrow.  Fixing git send-email
> will have to wait.

Don't bother: if you have problems with "git send-email" I can apply the
attachment.

Thanks,
Laurent

