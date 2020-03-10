Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27C2EC10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 08:29:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFD8124677
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 08:29:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFD8124677
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBaH0-00031d-7N
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 04:29:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34511)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jBaGJ-0002ZR-Nk
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 04:29:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jBaGI-0004T0-I6
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 04:29:15 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:58917)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jBaGI-0004OZ-9H
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 04:29:14 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue009 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MPGJh-1iz8yx45Ub-00PhYd; Tue, 10 Mar 2020 09:28:55 +0100
To: Unai Martinez-Corral <unai.martinezcorral@ehu.eus>, qemu-devel@nongnu.org
References: <20200309191200.GA60@669c1c222ef4>
 <20200309191924.GB65@669c1c222ef4>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH v10 02/10] qemu-binfmt-conf.sh: enforce safe tests
Message-ID: <b7389e46-c96b-a95b-5831-accfdbd1da4a@vivier.eu>
Date: Tue, 10 Mar 2020 09:28:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200309191924.GB65@669c1c222ef4>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:NX0sT9pFLs1VDUQnjOSQ0CUZBMwFO8o+4q0G83LnM0ZbvaJukHI
 2sjovXQ8vo/2Q3ynltI2Ak6NevTE+PnTjuXXta+96FboFc1lhLxtWe1P3MTxpa5KUAyYmIH
 7KlmF4hAjp0UOygEVxMQNAtaz7k12F5xTxnP+8zTQY4jJ/LZbp3CEeOkUnIy/bnq1uVyuq5
 4CrkatUCx9Kcc5kkDRCPw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:W5Cf1jc7mtA=:rFScEWNdhRQSDhK2NPlqaC
 Bay/bxJh7jVvxZKdQYKUy9kc8bZuGunD5bR3iuF+YD5meGXHKVrQZb4kz0k0SYtPt917H6nPg
 pJDOL27VKr+5KpsO3lDB7bitPLzXmunWZLFRoZF9zMKak8HJY0IxpMDibPgpkV0X/eXrhYKpx
 2UhY0DDPV1iJ9CK+IB/R68wJvYYX0AiGBK0MH0pTMKhL88QVdckuKtAV1hxsYkUlyxmqceiNy
 r3GIhdy5EX8lq8EftNOrW4xXUPYlNtro05vPt0R+rShYHp4x6mr7Rn7lFXiBco2qaWxt35gYw
 0VykSx9c+wloZQo67I7LJKllfIO5jwxhaG9LRw+REOz6UWrCm4IvjLNT97HPOWn9yNMlM/NoH
 JUzNAGG7PTNTneB09H2j8TZT2VVZrSVYWF7KxAFxfKlNZgODL8CpJxxh0bGt3hNkydCS5S+8h
 nYv2VDHWgShKKzeSolGbDeE8cZyYgC3EWfPxDDN2AFC0tYQGNwtOcyHDYhV0EnSoleYYX+zGS
 PjyTRjulfD7+7a69t2msNzZVArbL+c86NERhviCyfcMTazrse5LnfV52Zc2n1cpIW6vALMZiM
 QN9gWWEVfXyjdpmjKKD13SUWMSF8/taEZt2a9e3W4GxS2oQiTH+zf128fivx/YhzdXbWAO7OO
 HmElGSFyAIoSbgMN9WMKegOo3kr6OnNDvYfnawik69Qt7x8VaSiMKvkTSBP9cdifYd+IJqqm8
 5qKT+jvweFjEac4urets5cSRteJyn0DJffMhfT5EG2NYFjLG6GLqj98fDbOmPWzCqCwjxDxpJ
 5nlYtnFtJKmo1rr7R0qBCgW80x/wMt+g7Wu7Cub2mNLT7RKq6nJzkVUf7X22g0UZulm8oph
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.187
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
Cc: riku.voipio@iki.fi
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 09/03/2020 à 20:19, Unai Martinez-Corral a écrit :
> All the tests are prefixed with 'x', in order to avoid risky comparisons
> (i.e. a user deliberately trying to provoke a syntax error).

With the quotes I don't see how we can provoke a syntax error.
Could you provide an example?

Thanks,
Laurent

> Signed-off-by: Unai Martinez-Corral <unai.martinezcorral@ehu.eus>
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  scripts/qemu-binfmt-conf.sh | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/scripts/qemu-binfmt-conf.sh b/scripts/qemu-binfmt-conf.sh
> index c728443ba2..98401f4e7c 100755
> --- a/scripts/qemu-binfmt-conf.sh
> +++ b/scripts/qemu-binfmt-conf.sh
> @@ -259,10 +259,10 @@ qemu_check_systemd() {
>  
>  qemu_generate_register() {
>      flags=""
> -    if [ "$CREDENTIAL" = "yes" ]; then
> +    if [ "x$CREDENTIAL" = "xyes" ]; then
>          flags="OC"
>      fi
> -    if [ "$PERSISTENT" = "yes" ]; then
> +    if [ "x$PERSISTENT" = "xyes" ]; then
>          flags="${flags}F"
>      fi
>  
> @@ -300,18 +300,18 @@ qemu_set_binfmts() {
>          mask=$(eval echo \$${cpu}_mask)
>          family=$(eval echo \$${cpu}_family)
>  
> -        if [ "$magic" = "" ] || [ "$mask" = "" ] || [ "$family" = "" ]; then
> +        if [ "x$magic" = "x" ] || [ "x$mask" = "x" ] || [ "x$family" = "x" ]; then
>              echo "INTERNAL ERROR: unknown cpu $cpu" 1>&2
>              continue
>          fi
>  
>          qemu="$QEMU_PATH/qemu-$cpu"
> -        if [ "$cpu" = "i486" ]; then
> +        if [ "x$cpu" = "xi486" ]; then
>              qemu="$QEMU_PATH/qemu-i386"
>          fi
>  
>          qemu="$qemu$QEMU_SUFFIX"
> -        if [ "$host_family" != "$family" ]; then
> +        if [ "x$host_family" != "x$family" ]; then
>              $BINFMT_SET
>          fi
>      done
> 


