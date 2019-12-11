Return-Path: <SRS0=Q6KP=2B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E84C2D0CA
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 14:39:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8943620836
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 14:39:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8943620836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1if39C-0004jq-9n
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 09:39:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56018)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <samuel.thibault@gnu.org>) id 1if37G-0002MX-SY
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 09:37:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <samuel.thibault@gnu.org>) id 1if37F-00024K-KG
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 09:37:26 -0500
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:1384)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <samuel.thibault@gnu.org>)
 id 1if37F-00021K-9C; Wed, 11 Dec 2019 09:37:25 -0500
X-IronPort-AV: E=Sophos;i="5.69,301,1571695200"; d="scan'208";a="332831152"
Received: from unknown (HELO function) ([193.50.111.121])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/AES256-GCM-SHA384;
 11 Dec 2019 15:37:22 +0100
Received: from samy by function with local (Exim 4.92.3)
 (envelope-from <samuel.thibault@gnu.org>)
 id 1if37C-000lCa-A6; Wed, 11 Dec 2019 15:37:22 +0100
Date: Wed, 11 Dec 2019 15:37:22 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] build-sys: do not include Windows SLIRP dependencies in
 $LIBS
Message-ID: <20191211143722.a4co5wi53gylo2sr@function>
References: <1576074210-52834-2-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1576074210-52834-2-git-send-email-pbonzini@redhat.com>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.134.164.104
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
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo Bonzini, le mer. 11 déc. 2019 15:23:23 +0100, a ecrit:
> When including the internal SLIRP library, we should add all the libraries that
> it needs for the build.  Right now they are all included by QEMU, but -liphlpapi
> is not needed without slirp.  Move it from LIBS to slirp_libs.
> 
> Based on a patch by Marc-André Lureau.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Acked-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

(I don't have a win environment to test this)

> ---
>  configure | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/configure b/configure
> index 6099be1..d16dad2 100755
> --- a/configure
> +++ b/configure
> @@ -926,7 +926,7 @@ if test "$mingw32" = "yes" ; then
>    DSOSUF=".dll"
>    # MinGW needs -mthreads for TLS and macro _MT.
>    QEMU_CFLAGS="-mthreads $QEMU_CFLAGS"
> -  LIBS="-lwinmm -lws2_32 -liphlpapi $LIBS"
> +  LIBS="-lwinmm -lws2_32 $LIBS"
>    write_c_skeleton;
>    if compile_prog "" "-liberty" ; then
>      LIBS="-liberty $LIBS"
> @@ -6069,6 +6069,9 @@ case "$slirp" in
>      mkdir -p slirp
>      slirp_cflags="-I\$(SRC_PATH)/slirp/src -I\$(BUILD_DIR)/slirp/src"
>      slirp_libs="-L\$(BUILD_DIR)/slirp -lslirp"
> +    if test "$mingw32" = "yes" ; then
> +      slirp_libs="$slirp_libs -lws2_32 -liphlpapi"
> +    fi
>      ;;
>  
>    system)
> -- 
> 1.8.3.1
> 
> 

-- 
Samuel
 > Quelqu'un aurait-il une solution pour réinitialiser un MBR
 Si tu veux qu'il soit complètement blanc (pas souhaitable, à mon avis) :
 dd if=/dev/zero of=/dev/hda bs=512 count=1 (sous Linux)
 -+- OT in Guide du linuxien (très) pervers - "Pour les K difficiles" -+-

