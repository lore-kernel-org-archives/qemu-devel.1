Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AAA9C2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 11:18:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 979B6221EB
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 11:17:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jteped5I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 979B6221EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKgJ4-0008HY-ID
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 07:17:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46188)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kKgGC-0005JB-KB
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 07:15:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52953
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kKgG9-0005b2-71
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 07:15:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600773296;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G/DD5ZFIasgFKzBz4BlUXPeGAzvmAbxXiLsEcR70Sgk=;
 b=Jteped5I+T3VqZTbqzLjXAnL2MgkUgZmwBiF0zhhBL33u7rm8vuHeFnBmKUTc2MsWra6pV
 DMM+KpNfWkz8n/runeBFRnr9qIzT+cJB+As6eqgroA5olkgXXj42wrJNnyQKECqmx80W4l
 y3S2OHb/qwi5JSFxPdO/J57lXdmKoG4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-151-BxXEl_D9N_y_EYzF4YUCYw-1; Tue, 22 Sep 2020 07:14:52 -0400
X-MC-Unique: BxXEl_D9N_y_EYzF4YUCYw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 25F93807341;
 Tue, 22 Sep 2020 11:14:51 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-113-122.ams2.redhat.com [10.36.113.122])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E4BC55DD99;
 Tue, 22 Sep 2020 11:14:46 +0000 (UTC)
Subject: Re: [PATCH v2 01/20] configure: Detect libfuse
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200922104932.46384-1-mreitz@redhat.com>
 <20200922104932.46384-2-mreitz@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <0360f62c-9074-594d-8e12-b00166380513@redhat.com>
Date: Tue, 22 Sep 2020 13:14:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200922104932.46384-2-mreitz@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 01:57:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22/09/2020 12.49, Max Reitz wrote:
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  configure   | 34 ++++++++++++++++++++++++++++++++++
>  meson.build |  6 ++++++
>  2 files changed, 40 insertions(+)
> 
> diff --git a/configure b/configure
> index ce27eafb0a..21c31e4694 100755
> --- a/configure
> +++ b/configure
> @@ -538,6 +538,7 @@ meson=""
>  ninja=""
>  skip_meson=no
>  gettext=""
> +fuse=""
>  
>  bogus_os="no"
>  malloc_trim=""
> @@ -1621,6 +1622,10 @@ for opt do
>    ;;
>    --disable-libdaxctl) libdaxctl=no
>    ;;
> +  --enable-fuse) fuse=yes
> +  ;;
> +  --disable-fuse) fuse=no
> +  ;;
>    *)
>        echo "ERROR: unknown option $opt"
>        echo "Try '$0 --help' for more information"
> @@ -1945,6 +1950,7 @@ disabled with --disable-FEATURE, default is enabled if available:
>    xkbcommon       xkbcommon support
>    rng-none        dummy RNG, avoid using /dev/(u)random and getrandom()
>    libdaxctl       libdaxctl support
> +  fuse            fuse block device export
>  
>  NOTE: The object files are built at the place where configure is launched
>  EOF
> @@ -6206,6 +6212,28 @@ but not implemented on your system"
>      fi
>  fi
>  
> +##########################################
> +# FUSE support
> +
> +if test "$fuse" != "no"; then
> +  cat > $TMPC <<EOF
> +#define FUSE_USE_VERSION 31
> +#include <fuse.h>
> +#include <fuse_lowlevel.h>
> +int main(void) { return 0; }
> +EOF
> +  fuse_cflags=$(pkg-config --cflags fuse3)
> +  fuse_libs=$(pkg-config --libs fuse3)
> +  if compile_prog "$fuse_cflags" "$fuse_libs"; then
> +    fuse=yes
> +  else
> +    if test "$fuse" = "yes"; then
> +      feature_not_found "fuse"
> +    fi
> +    fuse=no
> +  fi
> +fi

Could you turn this immediately into a meson test instead? See e.g.
https://lists.gnu.org/archive/html/qemu-devel/2020-09/msg07112.html as
an example for how to do this.

 Thomas


