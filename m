Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB757C43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 15:32:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42E4C218AC
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 15:32:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42E4C218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG25H-0000d5-Oq
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 11:32:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41640)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kG24Q-00009v-7x; Wed, 09 Sep 2020 11:31:38 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:45595)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kG24O-0006r7-1J; Wed, 09 Sep 2020 11:31:37 -0400
Received: from [192.168.100.1] ([82.252.148.206]) by mrelayeu.kundenserver.de
 (mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1N6KQZ-1kZr9I2kYL-016dEi; Wed, 09 Sep 2020 17:31:17 +0200
Subject: Re: [PATCH] meson.build: tweak sdl-image error message
To: Paolo Bonzini <pbonzini@redhat.com>, Sergei Trofimovich <slyfox@gentoo.org>
References: <20200908074016.2593596-1-slyfox@gentoo.org>
 <CABgObfaqxdOuH93OB=_ioiHR3np00hwNuzvpOXD=Wte4ErkUqQ@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <51084888-77f4-f3ca-4eee-fbfd765c13ef@vivier.eu>
Date: Wed, 9 Sep 2020 17:31:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CABgObfaqxdOuH93OB=_ioiHR3np00hwNuzvpOXD=Wte4ErkUqQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:odvXJiwPXaCt4vG0eRonaM41wSzzkaA7Uej6z26t+hWeiTOLiS2
 z3qvKjMetYNdVdCrjmR2hR6S9McX4ZK+Zo7pUM71RToltw8K04FrKQoNFqraKfHu8LC0+DU
 WXhPv0+xF3wbr40sbvMmk57Vws4yOmAsLsSebJlGTicgzV8LasepX/vFO6GhzyK3IspCwLS
 m4bCFDkulfjudogqvng1w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jeu/XPcCtiI=:FfbTAUhch2gU/qpQLhl1SU
 bP0RA0+h++G6pDWcjmlRW2b4ZNux/0XJR3zx/R6BqUarB0FTeLcXFP/ithPrte0mOz6Bx/3oe
 tsl0zxWj6vj9EJEWlfb1QEzOT27GM6Nm4PZcO7flR7Hb4oCjdpJ4fibgKaw8fc/H4kL0sSS6Y
 7ByIMek5NKwOJY0HpZAUoxtnnwCLGcxlGX45FHR0Gzga/VQuNfRqZOs/FdPPiYKuyGRm3QZlI
 qp05l5EEpEeMdzlJK8D6qFNcD1eJPoSUV0vmAKZ2a/XtWM3BBL6T9F/y9M0jwF7iHk3FmciFV
 9qZSQD1QqLzD2n1b4vtqLZvSfrXCz3xIPFm6ef3sS9ziY343XjO4nmim6e8DxYSRUZs3M90cC
 OTA6qJytB91G98YOC0UaS8YLf6T9BpsxIqNYg+J+4Vsl7kc5VIqV+GagcnCQRLHZ6K7ZzGZra
 6wvmL5GeK5IJrrX6oEUveIVGWBs1/tnpwMPIIYPnMyHSUSbe/IdcSpqKE528W8LXXo3V222tb
 Z5ZNZ5Gsu78GiaYyfTPlvwkGRinaeFRvMzrk6SLAJsHQ7gG0HaS91LD7ut2JBMy8dtMNQosU+
 aNh8fcOmDBtvf31VTakHjWJSQSxCIwE4ZsDXCk80GXTK8sIIIS+y+RfS3lFBuDg1kWCE0wH4u
 mthHJ6naWcgvJnrSjRWozbxUkIneFHacO2G783tM0n44A5NtYskjytGxEqky+DCvrqVkDALD4
 +/iZxiE8TzyqhVot+R6Hz26BXkiKt8j2/FZdUm4nDz3aYXkpppsQDVL5YbOtFxSs5fqNtS2te
 9ltGx/pcIM5ocOkGQpMY5WjS8CYxN9VFkV7df0MT74LFXShMB+R0WXhW6peWFxPsLvejRpN
Received-SPF: none client-ip=212.227.17.13; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 11:31:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -54
X-Spam_score: -5.5
X-Spam_bar: -----
X-Spam_report: (-5.5 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-3.576,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-trivial@nongnu.org,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Rafael Kitover <rkitover@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 08/09/2020 à 10:24, Paolo Bonzini a écrit :
> Cc: qemu-trivial@nongnu.org <mailto:qemu-trivial@nongnu.org>
> 
> Il mar 8 set 2020, 09:50 Sergei Trofimovich <slyfox@gentoo.org
> <mailto:slyfox@gentoo.org>> ha scritto:
> 
>     Before the change missing SDL was reported as:
> 
>         ../meson.build:253:4: ERROR: Expected 1 arguments, got 2.
> 
>     After the error as:
> 
>         ../meson.build:258:4: ERROR: Problem encountered: sdl-image
>     required, but SDL was not found
> 
>     CC: Paolo Bonzini <pbonzini@redhat.com <mailto:pbonzini@redhat.com>>
>     CC: "Marc-André Lureau" <marcandre.lureau@redhat.com
>     <mailto:marcandre.lureau@redhat.com>>
>     CC: "Philippe Mathieu-Daudé" <philmd@redhat.com
>     <mailto:philmd@redhat.com>>
>     CC: Rafael Kitover <rkitover@gmail.com <mailto:rkitover@gmail.com>>
>     Signed-off-by: Sergei Trofimovich <slyfox@gentoo.org
>     <mailto:slyfox@gentoo.org>>
>     ---
>      meson.build | 4 ++--
>      1 file changed, 2 insertions(+), 2 deletions(-)
> 
>     diff --git a/meson.build b/meson.build
>     index 04e070bb3b..7fd2a903c5 100644
>     --- a/meson.build
>     +++ b/meson.build
>     @@ -255,8 +255,8 @@ if sdl.found()
>                               method: 'pkg-config', static: enable_static)
>      else
>        if get_option('sdl_image').enabled()
>     -    error('sdl-image required, but SDL was @0@',
>     -          get_option('sdl').disabled() ? 'disabled' : 'not found')
>     +    error('sdl-image required, but SDL was @0@'.format(
>     +          get_option('sdl').disabled() ? 'disabled' : 'not found'))
>        endif
>        sdl_image = not_found
>      endif
>     -- 
>     2.28.0
> 

Applied to my trivial-patches branch.

Thanks,
Laurent


