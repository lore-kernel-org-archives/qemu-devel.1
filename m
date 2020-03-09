Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5AA8C10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 11:30:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79BB520828
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 11:30:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79BB520828
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41167 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBGbp-0006yj-L4
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 07:30:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48459)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jBGXo-0007jP-3a
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 07:26:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jBGXm-0006sl-SN
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 07:25:59 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:58395)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1jBGXm-0006sH-J1; Mon, 09 Mar 2020 07:25:58 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue107 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1ML9i0-1itBQW0ViU-00IDoY; Mon, 09 Mar 2020 12:25:54 +0100
Subject: Re: [PATCH] build-sys: Move the print-variable rule to rules.mak
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200306170456.21977-1-philmd@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <e044e2cf-cb41-a2fc-f27f-cd54d76cd4bd@vivier.eu>
Date: Mon, 9 Mar 2020 12:25:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200306170456.21977-1-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:WX80ArZkF9DZQnJRTqBWq4Spfe/xW8NONjMadk02SXNZxgyJtVM
 6EZGtZupk6+wUbwwAmXYButiplGjmnN7NCB+MOhG4gdnVhr/wmggAnx0cYFZVoiqKsednBh
 9p6IlpeC+bkwlNZ744Pfy00hTnBl4WuwVJkk/tjLG2ehzkxqEFdIMHu7XoMfK9/RiJUBnv+
 5Rnz5V0yn5CZRvUvFBz+w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8sjUbY+aX/8=:Gfgq8c+kAsZV05KDFCToFC
 O6V0T+fqBy09MdGOHOpZfJBM965Cx+GB35UtatO8QKyp6uVyzk2fLgl1A1wUZPx4PEQrHM2tJ
 AOth/wJnR21ekxn6Vl3giWqYR0BEAIk7LYf85WV4v8tyBazKgt2YJFWteXJ0UNs1NhVhpyBkA
 CTseG1aiZqeUC8TOZkLWwOElQIu0bkEiftFxQD8PO7l1mbWElt86+fK+C6sniWmaWnL7/rkd9
 pY3nJJwj+Ld1EsY1b3IGY/7ewdPQkv5cRE8kmVVzvnMfMZ6sg7zKkfEHO8Tf5pRwOcKueubam
 w8ICbgDgwxwgkBybtKSOdYtegFUvXlB21c1Qw8r2n96zjyHBRDjAvbQHV1k4wr/5wAKlWyUnE
 O7Wxcokt+zbqacsTU+ZxiPcuGnoXaetfabjaylIG6pmgxRiH+ubVmbUc2zmx2s8A7h1Dr7rQi
 ub85uP+8Tdcos5tucMwS0AMLUHyetry+AV2vniDkKajS2iwWV/VWQGGH7NIXSJ8Hx/PYMLP1x
 5rCM9K0PxxV+KP1/2fjQT7ogbMdYBXAgbUOUSUuY3n6fquJDwpqlQADgN+zOgh0QWRqVA4K3B
 SmyA04DBKAF3zvMb1mMuBcACXooPt3ZylQVvo4WJgqnARkgOmQXLlHyo9E4/Okj96hNkQVfNs
 Z4QWyLdffI3YWsxKshdNy4cVIoMPHoPYNJD7tOZQz+wxT8zpXeIU74Pcj17se25ExisyxZz2K
 MUqctmxMOEdoNPRXkMeKp7TP22U/7CtnNar4hfuw9B8syM7TkMux+7Xy8v1z4fBc5X2pQNa4A
 OlJpH8/Zt1lDWm4AOlaDXkOYRWospoHM5X0Dr5Fi4aOioq7PS2OkLXHiqRvQnkBGLN0uEKw
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.10
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
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 06/03/2020 à 18:04, Philippe Mathieu-Daudé a écrit :
> Currently the print-variable rule can only be used in the
> root directory:
> 
>   $ make print-vhost-user-json-y
>   vhost-user-json-y= contrib/vhost-user-gpu/50-qemu-gpu.json tools/virtiofsd/50-qemu-virtiofsd.json
> 
>   $ make -C i386-softmmu print-obj-y
>   make: Entering directory 'build/i386-softmmu'
>   make: *** No rule to make target 'print-obj-y'.  Stop.
>   make: Leaving directory 'build/i386-softmmu'
> 
> Move it to rules.mak so we can use it from other directories:
> 
>   $ make -C i386-softmmu print-obj-y
>   make: Entering directory 'build/i386-softmmu'
>   obj-y=qapi-introspect.o qapi-types-machine-target.o qapi-types-misc-target.o qapi-types.o qapi-visit-machine-target.o qapi-visit-misc-target.o qapi-visit.o qapi-events-machine-target.o qapi-events-misc-target.o qapi-events.o qapi-commands-machine-target.o qapi-commands-misc-target.o qapi-commands.o qapi-init-commands.o
>   make: Leaving directory 'build/i386-softmmu'
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  Makefile  | 3 ---
>  rules.mak | 3 +++
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 9d4b224126..fdc5d29bb9 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -15,9 +15,6 @@ UNCHECKED_GOALS := %clean TAGS cscope ctags dist \
>      help check-help print-% \
>      docker docker-% vm-help vm-test vm-build-%
>  
> -print-%:
> -	@echo '$*=$($*)'
> -
>  # All following code might depend on configuration variables
>  ifneq ($(wildcard config-host.mak),)
>  # Put the all: rule here so that config-host.mak can contain dependencies.
> diff --git a/rules.mak b/rules.mak
> index e39b073d46..694865b63e 100644
> --- a/rules.mak
> +++ b/rules.mak
> @@ -435,3 +435,6 @@ sentinel = .$(subst $(SPACE),_,$(subst /,_,$1)).sentinel.
>  atomic = $(eval $1: $(call sentinel,$1) ; @:) \
>           $(call sentinel,$1) : $2 ; @touch $$@ \
>           $(foreach t,$1,$(if $(wildcard $t),,$(shell rm -f $(call sentinel,$1))))
> +
> +print-%:
> +	@echo '$*=$($*)'
> 

Applied to my trivial-patches branch.

Thanks,
Laurent


