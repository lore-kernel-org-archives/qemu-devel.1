Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF1DC10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 08:21:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 237F024677
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 08:21:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 237F024677
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBa9E-0003fj-AR
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 04:21:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50187)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jBa8c-0003Gp-7i
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 04:21:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jBa8b-0005Oh-4T
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 04:21:18 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:52233)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jBa8a-0005MG-KP
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 04:21:17 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue010 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1N2Unv-1jKkLY1u4V-013xW4; Tue, 10 Mar 2020 09:21:03 +0100
Subject: Re: [PATCH v10 04/10] qemu-binfmt-conf.sh: add QEMU_CREDENTIAL and
 QEMU_PERSISTENT
To: Unai Martinez-Corral <unai.martinezcorral@ehu.eus>, qemu-devel@nongnu.org
References: <20200309191200.GA60@669c1c222ef4>
 <20200309192021.GD65@669c1c222ef4>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <0d0b5735-85f0-0325-abb9-c90e4bdfc5cd@vivier.eu>
Date: Tue, 10 Mar 2020 09:20:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200309192021.GD65@669c1c222ef4>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:A2/CRGkzXguK4lr780myYgTT/XUx01Cqp1yh5+0LSerEpGuzq3L
 RcaOH2unh92xyDqEdWi9V1G8lmS+o54hQOVKHhUOMHMsfEgK8vBqiU/+wnrKVxkoNvO/Rpw
 lkWXkgZvfmekjhDhP7kvnKurePYUfQDHWQstf2iDZS1xqY7jTo8wnPJKiFuGBs5pV8eqqHC
 T/xWU/cC8u7E/EF5kSHOg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SNt3p/fChng=:XKuKJJT1jbD1gIOblqWMzz
 jmaQQf4l0pL9lMDKXsdmaHrGRi17gWUzrSfO1wGbkMENGMajvRhGyTAa/BY1IwNoP3OncocSa
 CethbHwOqJ3PMUIHTfrvRqkTBbgjU8FsFjJ01UzpYojiUyTmaFrAl0YlpDeZBEVWLIgeSWdKA
 wtfP3rxysnXblwCkmTdxzyS2eeTiDM1wkaLwtUTBwK7uEXZWGORhxVDjqIqykoGYXS5ZY6y+C
 TWlqJrMDRG0YpJTQcu4nsvJc6Flhz8iVaFsWERbqVye3rpcX7MDD194nrxXIVdj2dEl0Na+E6
 AKvDEMLzSObz0kWzlMcMcQ5KQOG1VRJBrCnnC9F6nWEjT50ccMJGKfRbLlbQYV5IvMujaEePA
 Qf25jak0HR6SH9TEaPdy+qj4pSeKhJCLRut/SohJuvZr86GKx78xJmZV4/miYt6sEfjoPSsof
 jz7h0XC7j3h2rB+r/156Ipe5Fdq+yrD9/PJk+uHTxARuMyTV986eAcIMD48zII0vG1OV59rYb
 o5i5mvY1wW/xfhLTs4DW0O9atoekAbOoDImBHyuVePqTspAH5v7EcEIT96VmPi6jfQ84nrc8N
 DPdKM1xXvsll58LdpjHjqVu+fQOQBtllAXqemN2RnfQEBzephIxEYiMhByYgSysoZdMLPUpXK
 zdhIX9gGosi4WPlF0ypwwRpf5r6kColIokxd5rD1IMpU+fBgklFUdxrPSR10hbj0CApg2N+I8
 GZ11NhpKXTK+gwQv3NijYtDGnSMI81UwBJi5GRSNoXmmmZeUfoABacxBhB9Vu0MCu+kIStTve
 Rs+gRU42HRnjxUNdxrVa1ZsPmOSRxQCE1UOjyiv7TW2xRtJm9dCP9Y8tnV0wLjOOvfdX+i+
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.130
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

Le 09/03/2020 à 20:20, Unai Martinez-Corral a écrit :
> Allow to set options '--persistent' and/or '--credential' through
> environment variables. If not defined, defaults are used ('no').
> Anyway, command-line arguments have priority over environment variables.

If variable are set to 'yes', how do you force the value to no with the
command line?

Please, refresh my memory, why do we need these variables?
Do you have an use case?

Thanks,
Laurent

> Signed-off-by: Unai Martinez-Corral <unai.martinezcorral@ehu.eus>
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  scripts/qemu-binfmt-conf.sh | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/scripts/qemu-binfmt-conf.sh b/scripts/qemu-binfmt-conf.sh
> index 285ce528d1..0c28db5ca4 100755
> --- a/scripts/qemu-binfmt-conf.sh
> +++ b/scripts/qemu-binfmt-conf.sh
> @@ -190,9 +190,11 @@ Usage: qemu-binfmt-conf.sh [--qemu-path PATH][--debian][--systemd CPU]
>                        (default: $SYSTEMDDIR or $DEBIANDIR)
>         --credential:  if present, credential and security tokens are
>                        calculated according to the binary to interpret
> +                      (QEMU_CREDENTIAL=yes)
>         --persistent:  if present, the interpreter is loaded when binfmt is
>                        configured and remains in memory. All future uses
>                        are cloned from the open file.
> +                      (QEMU_PERSISTENT=yes)
>  
>      To import templates with update-binfmts, use :
>  
> @@ -259,10 +261,10 @@ qemu_check_systemd() {
>  
>  qemu_generate_register() {
>      flags=""
> -    if [ "x$CREDENTIAL" = "xyes" ]; then
> +    if [ "x$QEMU_CREDENTIAL" = "xyes" ]; then
>          flags="OC"
>      fi
> -    if [ "x$PERSISTENT" = "xyes" ]; then
> +    if [ "x$QEMU_PERSISTENT" = "xyes" ]; then
>          flags="${flags}F"
>      fi
>  
> @@ -285,7 +287,7 @@ package qemu-$cpu
>  interpreter $qemu
>  magic $magic
>  mask $mask
> -credential $CREDENTIAL
> +credential $QEMU_CREDENTIAL
>  EOF
>  }
>  
> @@ -324,8 +326,10 @@ SYSTEMDDIR="/etc/binfmt.d"
>  DEBIANDIR="/usr/share/binfmts"
>  
>  QEMU_PATH=/usr/local/bin
> -CREDENTIAL=no
> -PERSISTENT=no
> +
> +QEMU_PERSISTENT="${QEMU_PERSISTENT:-no}"
> +QEMU_CREDENTIAL="${QEMU_CREDENTIAL:-no}"
> +
>  QEMU_SUFFIX=""
>  
>  options=$(getopt -o ds:Q:S:e:hcp -l debian,systemd:,qemu-path:,qemu-suffix:,exportdir:,help,credential,persistent -- "$@")
> @@ -377,10 +381,10 @@ while true; do
>          exit 1
>          ;;
>      -c|--credential)
> -        CREDENTIAL="yes"
> +        QEMU_CREDENTIAL="yes"
>          ;;
>      -p|--persistent)
> -        PERSISTENT="yes"
> +        QEMU_PERSISTENT="yes"
>          ;;
>      *)
>          break
> 


