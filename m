Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13006C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 10:00:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC0A720674
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 10:00:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC0A720674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tls.msk.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyuUx-0000u3-OT
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 06:00:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36744)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1jyuQx-0007hA-6S; Fri, 24 Jul 2020 05:56:07 -0400
Received: from isrv.corpit.ru ([86.62.121.231]:51641)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1jyuQu-0003iH-Sw; Fri, 24 Jul 2020 05:56:06 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8C03F4071A;
 Fri, 24 Jul 2020 12:55:53 +0300 (MSK)
Received: from [192.168.177.99] (mjt.vpn.tls.msk.ru [192.168.177.99])
 by tsrv.corpit.ru (Postfix) with ESMTP id 5C66A93;
 Fri, 24 Jul 2020 12:55:54 +0300 (MSK)
Subject: Re: [PATCH v2] configure: actually disable 'git_update' mode with
 --disable-git-update
To: Dan Streetman <ddstreet@canonical.com>, qemu-trivial@nongnu.org
References: <20200715205013.2367760-1-ddstreet@canonical.com>
 <20200716102213.2931209-1-ddstreet@canonical.com>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <e55fea6e-e403-166f-e693-9e73ae29e5cc@msgid.tls.msk.ru>
Date: Fri, 24 Jul 2020 12:55:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200716102213.2931209-1-ddstreet@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 05:55:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Rafael David Tinoco <rafael.tinoco@canonical.com>,
 Christian Ehrhardt <christian.ehrhardt@canonical.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi!

Dan, can you please resend this with To: qemu-devel@, maybe Cc: qemu-trivial@?
It isn't exactly trivial and it needs some review from the developers.

Thanks,

/mjt

16.07.2020 13:22, Dan Streetman wrote:
> The --disable-git-update configure param sets git_update=no, but
> some later checks only look for the .git dir. This changes the
> --enable-git-update to set git_update=yes but also fail if it
> does not find a .git dir. Then all the later checks for the .git
> dir can just be changed to a check for $git_update = "yes".
> 
> Also update the Makefile to skip the 'git_update' checks if it has
> been disabled.
> 
> This is needed because downstream packagers, e.g. Debian, Ubuntu, etc,
> also keep the source code in git, but do not want to enable the
> 'git_update' mode; with the current code, that's not possible even
> if the downstream package specifies --disable-git-update.
> 
> Signed-off-by: Dan Streetman <ddstreet@canonical.com>
> ---
> Changes in v2:
>  - change GIT_UPDATE default to "" if no .git found
>  - change Makefile to skip git update checks if GIT_UPDATE=no
> 
>  Makefile  | 15 +++++++++------
>  configure | 21 +++++++++++++--------
>  2 files changed, 22 insertions(+), 14 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 32345c610e..9bcd3f9af4 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -25,6 +25,8 @@ git-submodule-update:
>  
>  .PHONY: git-submodule-update
>  
> +# If --disable-git-update specified, skip these git checks
> +ifneq (no,$(GIT_UPDATE))
>  git_module_status := $(shell \
>    cd '$(SRC_PATH)' && \
>    GIT="$(GIT)" ./scripts/git-submodule.sh status $(GIT_SUBMODULES); \
> @@ -32,7 +34,12 @@ git_module_status := $(shell \
>  )
>  
>  ifeq (1,$(git_module_status))
> -ifeq (no,$(GIT_UPDATE))
> +ifeq (yes,$(GIT_UPDATE))
> +git-submodule-update:
> +	$(call quiet-command, \
> +          (cd $(SRC_PATH) && GIT="$(GIT)" ./scripts/git-submodule.sh update $(GIT_SUBMODULES)), \
> +          "GIT","$(GIT_SUBMODULES)")
> +else
>  git-submodule-update:
>  	$(call quiet-command, \
>              echo && \
> @@ -41,11 +48,7 @@ git-submodule-update:
>              echo "from the source directory checkout $(SRC_PATH)" && \
>              echo && \
>              exit 1)
> -else
> -git-submodule-update:
> -	$(call quiet-command, \
> -          (cd $(SRC_PATH) && GIT="$(GIT)" ./scripts/git-submodule.sh update $(GIT_SUBMODULES)), \
> -          "GIT","$(GIT_SUBMODULES)")
> +endif
>  endif
>  endif
>  
> diff --git a/configure b/configure
> index b751c853f5..eefda62210 100755
> --- a/configure
> +++ b/configure
> @@ -318,7 +318,7 @@ then
>      git_submodules="$git_submodules tests/fp/berkeley-testfloat-3"
>      git_submodules="$git_submodules tests/fp/berkeley-softfloat-3"
>  else
> -    git_update=no
> +    git_update=""
>      git_submodules=""
>  
>      if ! test -f "$source_path/ui/keycodemapdb/README"
> @@ -1603,7 +1603,12 @@ for opt do
>    ;;
>    --with-git=*) git="$optarg"
>    ;;
> -  --enable-git-update) git_update=yes
> +  --enable-git-update)
> +      git_update=yes
> +      if test ! -e "$source_path/.git"; then
> +          echo "ERROR: cannot --enable-git-update without .git"
> +          exit 1
> +      fi
>    ;;
>    --disable-git-update) git_update=no
>    ;;
> @@ -2017,7 +2022,7 @@ fi
>  # Consult white-list to determine whether to enable werror
>  # by default.  Only enable by default for git builds
>  if test -z "$werror" ; then
> -    if test -e "$source_path/.git" && \
> +    if test "$git_update" = "yes" && \
>          { test "$linux" = "yes" || test "$mingw32" = "yes"; }; then
>          werror="yes"
>      else
> @@ -4418,10 +4423,10 @@ EOF
>      fdt=system
>    else
>        # have GIT checkout, so activate dtc submodule
> -      if test -e "${source_path}/.git" ; then
> +      if test "$git_update" = "yes" ; then
>            git_submodules="${git_submodules} dtc"
>        fi
> -      if test -d "${source_path}/dtc/libfdt" || test -e "${source_path}/.git" ; then
> +      if test -d "${source_path}/dtc/libfdt" || test "$git_update" = "yes" ; then
>            fdt=git
>            mkdir -p dtc
>            if [ "$pwd_is_source_path" != "y" ] ; then
> @@ -5391,7 +5396,7 @@ case "$capstone" in
>    "" | yes)
>      if $pkg_config capstone; then
>        capstone=system
> -    elif test -e "${source_path}/.git" && test $git_update = 'yes' ; then
> +    elif test "$git_update" = "yes" ; then
>        capstone=git
>      elif test -e "${source_path}/capstone/Makefile" ; then
>        capstone=internal
> @@ -6447,7 +6452,7 @@ case "$slirp" in
>    "" | yes)
>      if $pkg_config slirp; then
>        slirp=system
> -    elif test -e "${source_path}/.git" && test $git_update = 'yes' ; then
> +    elif test "$git_update" = "yes" ; then
>        slirp=git
>      elif test -e "${source_path}/slirp/Makefile" ; then
>        slirp=internal
> @@ -6809,7 +6814,7 @@ if test "$cpu" = "s390x" ; then
>      roms="$roms s390-ccw"
>      # SLOF is required for building the s390-ccw firmware on s390x,
>      # since it is using the libnet code from SLOF for network booting.
> -    if test -e "${source_path}/.git" ; then
> +    if test "$git_update" = "yes" ; then
>        git_submodules="${git_submodules} roms/SLOF"
>      fi
>    fi
> 


