Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 216D9C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 06:59:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF5492176D
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 06:59:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MlZ+C9MO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF5492176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihTJN-0007Gu-1J
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 01:59:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40754)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1ihTIi-0006pL-CZ
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 01:59:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1ihTIf-0003Gf-0d
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 01:59:14 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:33157
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ihTIe-0003Ex-9N
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 01:59:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576652351;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=My8ceghHSCegZVNnGBUqaFop+CokWr2qvpMokSggwRE=;
 b=MlZ+C9MOErIElj4krytCY5QBK3QweKJ/wdS6UakN81Egdl2ylCnks80BEE4bQIdtzZb4gC
 POmj6tkEWJIg31Mtu2tI5dgovP8mumnhglU0XKwEMsgYacCbpDrdFYEg85YdJsm2qjKD9v
 EccZG11DSFSbHTyvVVh7TkmnG0axQGc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-Eqvr9YmKNPayQ-I1AFA5ew-1; Wed, 18 Dec 2019 01:59:07 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3DB9210054E3;
 Wed, 18 Dec 2019 06:59:06 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-150.ams2.redhat.com [10.36.116.150])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1EB937C856;
 Wed, 18 Dec 2019 06:59:01 +0000 (UTC)
Subject: Re: [PATCH 1/7] configure: Drop adjustment of textseg
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20191218031920.6414-1-richard.henderson@linaro.org>
 <20191218031920.6414-2-richard.henderson@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <881947d1-a9bc-f027-bd53-3abeea59449d@redhat.com>
Date: Wed, 18 Dec 2019 07:59:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191218031920.6414-2-richard.henderson@linaro.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: Eqvr9YmKNPayQ-I1AFA5ew-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: berrange@redhat.com, i@maskray.me, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 18/12/2019 04.19, Richard Henderson wrote:
> This adjustment was random and unnecessary.  The user mode
> startup code in probe_guest_base() will choose a value for
> guest_base that allows the host qemu binary to not conflict
> with the guest binary.
> 
> With modern distributions, this isn't even used, as the default
> is PIE, which does the same job in a more portable way.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  configure | 47 -----------------------------------------------
>  1 file changed, 47 deletions(-)
> 
> diff --git a/configure b/configure
> index 84b413dbfc..255ac432af 100755
> --- a/configure
> +++ b/configure
> @@ -6292,49 +6292,6 @@ if test "$cpu" = "s390x" ; then
>    fi
>  fi
>  
> -# Probe for the need for relocating the user-only binary.
> -if ( [ "$linux_user" = yes ] || [ "$bsd_user" = yes ] ) && [ "$pie" = no ]; then
> -  textseg_addr=
> -  case "$cpu" in
> -    arm | i386 | ppc* | s390* | sparc* | x86_64 | x32)
> -      # ??? Rationale for choosing this address
> -      textseg_addr=0x60000000
> -      ;;
> -    mips)
> -      # A 256M aligned address, high in the address space, with enough
> -      # room for the code_gen_buffer above it before the stack.
> -      textseg_addr=0x60000000
> -      ;;
> -  esac
> -  if [ -n "$textseg_addr" ]; then
> -    cat > $TMPC <<EOF
> -    int main(void) { return 0; }
> -EOF
> -    textseg_ldflags="-Wl,-Ttext-segment=$textseg_addr"
> -    if ! compile_prog "" "$textseg_ldflags"; then
> -      # In case ld does not support -Ttext-segment, edit the default linker
> -      # script via sed to set the .text start addr.  This is needed on FreeBSD
> -      # at least.
> -      if ! $ld --verbose >/dev/null 2>&1; then
> -        error_exit \
> -            "We need to link the QEMU user mode binaries at a" \
> -            "specific text address. Unfortunately your linker" \
> -            "doesn't support either the -Ttext-segment option or" \
> -            "printing the default linker script with --verbose." \
> -            "If you don't want the user mode binaries, pass the" \
> -            "--disable-user option to configure."
> -      fi
> -
> -      $ld --verbose | sed \
> -        -e '1,/==================================================/d' \
> -        -e '/==================================================/,$d' \
> -        -e "s/[.] = [0-9a-fx]* [+] SIZEOF_HEADERS/. = $textseg_addr + SIZEOF_HEADERS/" \
> -        -e "s/__executable_start = [0-9a-fx]*/__executable_start = $textseg_addr/" > config-host.ld
> -      textseg_ldflags="-Wl,-T../config-host.ld"

config-host.ld is mentioned one more time in the main "Makefile" ... I
think you could remove it from there now, too.

With such a hunk added:

Reviewed-by: Thomas Huth <thuth@redhat.com>


