Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5609BCA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 12:56:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A73D20640
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 12:56:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A73D20640
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNGBm-0004aw-8p
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 08:56:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39898)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iNGAt-00047q-3t
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 08:55:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iNGAr-0000It-I8
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 08:55:39 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:37563)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iNGAr-0000DD-8I
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 08:55:37 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue009 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MrQN5-1hcyNc2dbr-00oSeY; Wed, 23 Oct 2019 14:55:27 +0200
Subject: Re: [Qemu-devel] [PATCH v2 2/2] linux-user: manage binfmt-misc
 preserve-arg[0] flag
To: qemu-devel@nongnu.org
References: <20190908104816.20713-1-laurent@vivier.eu>
 <20190908104816.20713-2-laurent@vivier.eu>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <d522100e-5966-ec49-e848-fa9e18a1a2e6@vivier.eu>
Date: Wed, 23 Oct 2019 14:55:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20190908104816.20713-2-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:f2g86obeH3L8FgADNj7I5JcL66c9Bw1HqHKtKWXVK6tCYK+Xrk+
 J0wESoohFilFNY8LU716YQPktOO5vi0Acwgpr6dAQm2zgLPolRQDalDTz+JtWRsQoDATYJq
 jVz7QJNBYsVpEByPvwoGpAkMg81MA5hkd/2YR89z3ZlPyltBr3PCYTbSWedv3dwF6vplfaB
 m4tF6Rw30t52qW0sjtZsQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4XChRZzHRDI=:QcWn+R8sh9VratJxjgZJRN
 KQ0jnu4km7kRJrKiHZN+Ns9M0o5uF7yGQfjJwGnPwQsntXogPQYfdlc8czkCxGXCVonHPhiFC
 jH48jua3EUHYn5kXpOlg/5Sg45/mL5p151KzLc3qFfuy7vd4Q8i1c0Bw2kA2AQJucUTDERTy6
 gKzlHP8zV+ebmpNW3CYihA/tYUekIvQwqJDOXM0FIMGR0tyAfQWJqIWJcUI4EN556CkdCQYCS
 kYPXextzRerhEFwP1UNVUnye+H6xtJi2e2uwHW5kecGHKtQKv+MUeuUh5dsUgPvu0efmqhVZx
 pz8Q/oKDxFZ/p0ZpiBd98N3DBdFj518spj5MwYKBjxc3LSyBo3v1a68Wb1w4ykgKKw9DgUBDK
 EunKXd/CO7OHusk1O5Uu4Lb+2rcabIKLgTs7chaQs35n/ScIe2sizUDIPAR1L3rtqsenzb08h
 SIgktvd8OX0fqBqRftG0o9GJMvBx88Y9Ys2TrXsNPT0MB8+o464C0OfZmTSwNbQza5YJBIczI
 L/z+lgTcTC+PAFNCGenxUW22FhYkuJpVdaPGiciIL9FelKLTFwgrhrR5pF9sBISI8xKyhgfyG
 tRoEuRlEHCz1SbNO6AgCg4F/wE2ua5t7itooJqT3RGJ1yvyLEo7p1+lcUYOjceMrkmVyHq1/B
 6gHcqaQqjAX1EwWVCViZi4CVLt3PK0elS40IhzfvVt8VriGr4Y2HFk34MjzVAfJEZn5DB5REz
 +OMsnPEdSJSmerPpWsMQzklOYZkbY9xC7rtHA8vgt9Jq7z3/vHc0xGF7dqGEopzF4QE8dieGu
 lOhBp9x8MkEgTkMmUGYwebVBklmPyes1u2rtKXiFGUmvHcSEgZXoIU3b46LigwPwlJYdWJjX9
 oLfAAUny6wq/zIUi120JDdC81Phri8f+3y3S2rDCU=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Riku Voipio <riku.voipio@iki.fi>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Any comments on this?

It would be interesting to have this in 4.2

Thanks,
Laurent

Le 08/09/2019 à 12:48, Laurent Vivier a écrit :
> Add --preserve-arg0 in qemu-binfmt-conf.sh to configure the preserve-arg0
> flag.
> 
> Now, if QEMU is started with -0 or QEMU_ARGV0 and an empty parameter
> argv[0] (the full pathname provided by binfmt-misc) is removed and
> replaced by argv[1] (the original argv[0] provided by binfmt-misc when
> 'P'/preserve-arg[0] is set)
> 
> For instance:
> 
>   $ sudo QEMU_ARGV0= chroot m68k-chroot sh -c 'echo $0'
>   sh
> 
> without this patch:
> 
>   $ sudo chroot m68k-chroot sh -c 'echo $0'
>   /usr/bin/sh
> 
> QEMU can be forced to always use preserve-argv[0] at configuration
> time with --force-preserve-argv0
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
> 
> Notes:
>     v2: add --force-preserve-argv0 configure option
> 
>  configure                   |  8 +++++++
>  linux-user/main.c           | 24 +++++++++++++++++++-
>  scripts/qemu-binfmt-conf.sh | 44 +++++++++++++++++++++++--------------
>  3 files changed, 58 insertions(+), 18 deletions(-)
> 
> diff --git a/configure b/configure
> index 95134c0180b2..3568e192776c 100755
> --- a/configure
> +++ b/configure
> @@ -498,6 +498,7 @@ libxml2=""
>  docker="no"
>  debug_mutex="no"
>  libpmem=""
> +force_preserve_argv0="no"
>  default_devices="yes"
>  
>  # cross compilers defaults, can be overridden with --cross-cc-ARCH
> @@ -1543,6 +1544,8 @@ for opt do
>    ;;
>    --disable-libpmem) libpmem=no
>    ;;
> +  --force-preserve-argv0) force_preserve_argv0=yes
> +  ;;
>    *)
>        echo "ERROR: unknown option $opt"
>        echo "Try '$0 --help' for more information"
> @@ -1740,6 +1743,8 @@ Advanced options (experts only):
>    --enable-profiler        profiler support
>    --enable-debug-stack-usage
>                             track the maximum stack usage of stacks created by qemu_alloc_stack
> +  --force-preserve-argv0   for linux-user only, force the use of binfmt_misc 'P'
> +                           flag (preserve-argv[0])
>  
>  Optional features, enabled with --enable-FEATURE and
>  disabled with --disable-FEATURE, default is enabled if available:
> @@ -7736,6 +7741,9 @@ if test "$target_user_only" = "yes" ; then
>  fi
>  if test "$target_linux_user" = "yes" ; then
>    echo "CONFIG_LINUX_USER=y" >> $config_target_mak
> +  if test "$force_preserve_argv0" = "yes" ; then
> +    echo "CONFIG_FORCE_PRESERVE_ARGV0=y" >> $config_target_mak
> +  fi
>  fi
>  list=""
>  if test ! -z "$gdb_xml_files" ; then
> diff --git a/linux-user/main.c b/linux-user/main.c
> index 28f0065b6ddf..02354d58e866 100644
> --- a/linux-user/main.c
> +++ b/linux-user/main.c
> @@ -605,6 +605,7 @@ int main(int argc, char **argv, char **envp)
>      int i;
>      int ret;
>      int execfd;
> +    bool preserve_argv0;
>  
>      error_init(argv[0]);
>      module_call_init(MODULE_INIT_TRACE);
> @@ -653,6 +654,9 @@ int main(int argc, char **argv, char **envp)
>  
>      init_qemu_uname_release();
>  
> +    /*
> +     * Manage binfmt-misc open-binary flag
> +     */
>      execfd = qemu_getauxval(AT_EXECFD);
>      if (execfd == 0) {
>          execfd = open(exec_path, O_RDONLY);
> @@ -662,6 +666,24 @@ int main(int argc, char **argv, char **envp)
>          }
>      }
>  
> +     /*
> +      * argv0 with an empty string will set argv[optind + 1]
> +      * as target_argv[0]
> +      */
> +#ifdef CONFIG_FORCE_PRESERVE_ARGV0
> +    preserve_argv0 = true;
> +#else
> +    preserve_argv0 = (argv0 != NULL && argv0[0] == 0);
> +#endif
> +    /*
> +     * Manage binfmt-misc preserve-arg[0] flag
> +     *    argv[optind]     full path to the binary
> +     *    argv[optind + 1] original argv[0]
> +     */
> +    if (optind + 1 < argc && preserve_argv0) {
> +        optind++;
> +    }
> +
>      if (cpu_model == NULL) {
>          cpu_model = cpu_get_model(get_elf_eflags(execfd));
>      }
> @@ -766,7 +788,7 @@ int main(int argc, char **argv, char **envp)
>       * argv[0] pointer with the given one.
>       */
>      i = 0;
> -    if (argv0 != NULL) {
> +    if (argv0 != NULL && argv0[0] != 0) {
>          target_argv[i++] = strdup(argv0);
>      }
>      for (; i < target_argc; i++) {
> diff --git a/scripts/qemu-binfmt-conf.sh b/scripts/qemu-binfmt-conf.sh
> index b5a16742a149..7c9a4609c232 100755
> --- a/scripts/qemu-binfmt-conf.sh
> +++ b/scripts/qemu-binfmt-conf.sh
> @@ -170,25 +170,27 @@ usage() {
>  Usage: qemu-binfmt-conf.sh [--qemu-path PATH][--debian][--systemd CPU]
>                             [--help][--credential yes|no][--exportdir PATH]
>                             [--persistent yes|no][--qemu-suffix SUFFIX]
> +                           [--preserve-arg0 yes|no]
>  
>         Configure binfmt_misc to use qemu interpreter
>  
> -       --help:        display this usage
> -       --qemu-path:   set path to qemu interpreter ($QEMU_PATH)
> -       --qemu-suffix: add a suffix to the default interpreter name
> -       --debian:      don't write into /proc,
> -                      instead generate update-binfmts templates
> -       --systemd:     don't write into /proc,
> -                      instead generate file for systemd-binfmt.service
> -                      for the given CPU. If CPU is "ALL", generate a
> -                      file for all known cpus
> -       --exportdir:   define where to write configuration files
> -                      (default: $SYSTEMDDIR or $DEBIANDIR)
> -       --credential:  if yes, credential and security tokens are
> -                      calculated according to the binary to interpret
> -       --persistent:  if yes, the interpreter is loaded when binfmt is
> -                      configured and remains in memory. All future uses
> -                      are cloned from the open file.
> +       --help:          display this usage
> +       --qemu-path:     set path to qemu interpreter ($QEMU_PATH)
> +       --qemu-suffix:   add a suffix to the default interpreter name
> +       --debian:        don't write into /proc,
> +                        instead generate update-binfmts templates
> +       --systemd:       don't write into /proc,
> +                        instead generate file for systemd-binfmt.service
> +                        for the given CPU. If CPU is "ALL", generate a
> +                        file for all known cpus
> +       --exportdir:     define where to write configuration files
> +                        (default: $SYSTEMDDIR or $DEBIANDIR)
> +       --credential:    if yes, credential and security tokens are
> +                        calculated according to the binary to interpret
> +       --persistent:    if yes, the interpreter is loaded when binfmt is
> +                        configured and remains in memory. All future uses
> +                        are cloned from the open file.
> +       --preserve-arg0  preserve arg[0]
>  
>      To import templates with update-binfmts, use :
>  
> @@ -261,6 +263,9 @@ qemu_generate_register() {
>      if [ "$PERSISTENT" = "yes" ] ; then
>          flags="${flags}F"
>      fi
> +    if [ "$PRESERVE_ARG0" = "yes" ] ; then
> +        flags="${flags}P"
> +    fi
>  
>      echo ":qemu-$cpu:M::$magic:$mask:$qemu:$flags"
>  }
> @@ -322,9 +327,10 @@ DEBIANDIR="/usr/share/binfmts"
>  QEMU_PATH=/usr/local/bin
>  CREDENTIAL=no
>  PERSISTENT=no
> +PRESERVE_ARG0=no
>  QEMU_SUFFIX=""
>  
> -options=$(getopt -o ds:Q:S:e:hc:p: -l debian,systemd:,qemu-path:,qemu-suffix:,exportdir:,help,credential:,persistent: -- "$@")
> +options=$(getopt -o ds:Q:S:e:hc:p:0: -l debian,systemd:,qemu-path:,qemu-suffix:,exportdir:,help,credential:,persistent:,preserve-arg0: -- "$@")
>  eval set -- "$options"
>  
>  while true ; do
> @@ -380,6 +386,10 @@ while true ; do
>          shift
>          PERSISTENT="$1"
>          ;;
> +    -0|--preserve-arg0)
> +        shift
> +        PRESERVE_ARG0="$1"
> +        ;;
>      *)
>          break
>          ;;
> 


