Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18BBBC4363D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 16:38:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 747EC2399A
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 16:38:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hMRhHjMS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 747EC2399A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKlJf-00057h-Bx
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 12:38:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54640)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kKlFo-0002TU-1S
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 12:34:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38479
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kKlFl-0002Tl-33
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 12:34:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600792491;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=QRxj8dPH9E9VfRo7Ep/L4de59moMFx7wopbmpC2LnjM=;
 b=hMRhHjMSwTp/BPk3/AWTcjg28EdyQ1hkLZGeY+bVHQzT8uDaCyscsHS31REk5lAmKZLDS1
 jl7EKeeBkGemlVmKxX5CmfN2t7oaTSLqE4kD+ZA9bVg9dqJE1F/1ljrYwvzVPWbRFOWmOZ
 kBeKLPoSTmwY3YZGh7Lt42X5PibmwY0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-5DYc0er9NKKwefIK4l73Xw-1; Tue, 22 Sep 2020 12:34:47 -0400
X-MC-Unique: 5DYc0er9NKKwefIK4l73Xw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3DB69186841A;
 Tue, 22 Sep 2020 16:34:46 +0000 (UTC)
Received: from redhat.com (ovpn-114-64.ams2.redhat.com [10.36.114.64])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A9EDE1B42F;
 Tue, 22 Sep 2020 16:34:44 +0000 (UTC)
Date: Tue, 22 Sep 2020 17:34:41 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Dan Streetman <ddstreet@canonical.com>
Subject: Re: [PATCH] configure: actually disable 'git_update' mode with
 --disable-git-update
Message-ID: <20200922163441.GA2049853@redhat.com>
References: <e55fea6e-e403-166f-e693-9e73ae29e5cc@msgid.tls.msk.ru>
 <20200729195829.1335082-1-ddstreet@canonical.com>
MIME-Version: 1.0
In-Reply-To: <20200729195829.1335082-1-ddstreet@canonical.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 01:57:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 Christian Ehrhardt <christian.ehrhardt@canonical.com>,
 Rafael David Tinoco <rafael.tinoco@canonical.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 29, 2020 at 03:58:29PM -0400, Dan Streetman wrote:
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

Lets recap the original intended behaviour

 1. User building from master qemu.git or a fork
     a) git_update=yes (default)
         - Always sync submodules to required commit

     b) git_update=no  (--disable-git-update)
         - Never sync submodules, user is responsible for sync
	 - Validate submodules are at correct commit and fail if not.

 2. User building from tarball
     - Never do anything git related at all


Your change is removing the validation from  1.b). This is not desirable
in general, because if a user has done a git pull and failed to sync the
submodules, they are liable to get obscure, hard to diagnose errors later
in the build process. This puts a burden on the user and maintainers who
have to waste time diagnosing such problems.



> Signed-off-by: Dan Streetman <ddstreet@canonical.com>
> ---
> Note this is a rebased resend of a previous email to qemu-trivial:
> https://lists.nongnu.org/archive/html/qemu-trivial/2020-07/msg00180.html

NB, I'm removing qemu-trivial, because I don't think this patch
qualifies as trivial.


> 
>  Makefile  | 15 +++++++++------
>  configure | 21 +++++++++++++--------
>  2 files changed, 22 insertions(+), 14 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index c2120d8d48..42550ae086 100644
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
> index 2acc4d1465..e7a241e971 100755
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
> @@ -1598,7 +1598,12 @@ for opt do
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
> @@ -2011,7 +2016,7 @@ fi
>  # Consult white-list to determine whether to enable werror
>  # by default.  Only enable by default for git builds
>  if test -z "$werror" ; then
> -    if test -e "$source_path/.git" && \
> +    if test "$git_update" = "yes" && \
>          { test "$linux" = "yes" || test "$mingw32" = "yes"; }; then
>          werror="yes"
>      else
> @@ -4412,10 +4417,10 @@ EOF
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
> @@ -5385,7 +5390,7 @@ case "$capstone" in
>    "" | yes)
>      if $pkg_config capstone; then
>        capstone=system
> -    elif test -e "${source_path}/.git" && test $git_update = 'yes' ; then
> +    elif test "$git_update" = "yes" ; then
>        capstone=git
>      elif test -e "${source_path}/capstone/Makefile" ; then
>        capstone=internal
> @@ -6414,7 +6419,7 @@ case "$slirp" in
>    "" | yes)
>      if $pkg_config slirp; then
>        slirp=system
> -    elif test -e "${source_path}/.git" && test $git_update = 'yes' ; then
> +    elif test "$git_update" = "yes" ; then
>        slirp=git
>      elif test -e "${source_path}/slirp/Makefile" ; then
>        slirp=internal
> @@ -6776,7 +6781,7 @@ if test "$cpu" = "s390x" ; then
>      roms="$roms s390-ccw"
>      # SLOF is required for building the s390-ccw firmware on s390x,
>      # since it is using the libnet code from SLOF for network booting.
> -    if test -e "${source_path}/.git" ; then
> +    if test "$git_update" = "yes" ; then
>        git_submodules="${git_submodules} roms/SLOF"
>      fi
>    fi
> -- 
> 2.25.1
> 
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


