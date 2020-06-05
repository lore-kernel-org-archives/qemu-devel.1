Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C6D2C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 11:07:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66FC82074B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 11:07:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MH20xbtK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66FC82074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhACD-00021A-K7
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 07:07:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49750)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jhABf-0001af-Db
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 07:06:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25018
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jhABd-0006QY-3q
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 07:06:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591355215;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+HLwGjWqXmCLKNRFlPca9CAtZJUhEXkPLhyOM7u6h80=;
 b=MH20xbtKRKuBZcQVA/ha304uNGNipww2EZ0fR27yL3OYo733w0+RjIQx+SOwh4QiMgBTrC
 0tWWDJGH8IQf+X9kKzJ38Q2aN41gGGD8/iF8Lwyc74umIOFrTV2wSJ5taVh3ZF4cKc0AL3
 ezVCFP0m9PzjBssm2dPx+DCkb0mPFbc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-216-100kFChUPuOMJfiIvyCR3Q-1; Fri, 05 Jun 2020 07:06:47 -0400
X-MC-Unique: 100kFChUPuOMJfiIvyCR3Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 558D91883600;
 Fri,  5 Jun 2020 11:06:46 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.58])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 16BA875294;
 Fri,  5 Jun 2020 11:06:44 +0000 (UTC)
Date: Fri, 5 Jun 2020 12:06:41 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PULL 3/5] crypto/linux_keyring: add 'secret_keyring' secret
 object.
Message-ID: <20200605110641.GC3289519@redhat.com>
References: <20200529103555.2759928-1-berrange@redhat.com>
 <20200529103555.2759928-4-berrange@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200529103555.2759928-4-berrange@redhat.com>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 03:27:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_EXCESS_BASE64=0.979, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Alexey Krasikov <alex-krasikov@yandex-team.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 29, 2020 at 11:35:53AM +0100, Daniel P. Berrangé wrote:
> From: Alexey Krasikov <alex-krasikov@yandex-team.ru>
> 
> Add the ability for the secret object to obtain secret data from the
> Linux in-kernel key managment and retention facility, as an extra option
> to the existing ones: reading from a file or passing directly as a
> string.
> 
> The secret is identified by the key serial number. The upper layers
> need to instantiate the key and make sure the QEMU process has access
> permissions to read it.
> 
> Signed-off-by: Alexey Krasikov <alex-krasikov@yandex-team.ru>
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  configure                       |  38 ++++++++
>  crypto/Makefile.objs            |   1 +
>  crypto/secret_keyring.c         | 148 ++++++++++++++++++++++++++++++++
>  include/crypto/secret_keyring.h |  52 +++++++++++
>  4 files changed, 239 insertions(+)
>  create mode 100644 crypto/secret_keyring.c
>  create mode 100644 include/crypto/secret_keyring.h
> 
> diff --git a/configure b/configure
> index 2ffe365e2c..d95ff4e0b3 100755
> --- a/configure
> +++ b/configure
> @@ -510,6 +510,7 @@ default_devices="yes"
>  plugins="no"
>  fuzzing="no"
>  rng_none="no"
> +secret_keyring="yes"
>  
>  supported_cpu="no"
>  supported_os="no"
> @@ -1606,6 +1607,10 @@ for opt do
>    ;;
>    --disable-rng-none) rng_none=no
>    ;;
> +  --enable-keyring) secret_keyring="yes"
> +  ;;
> +  --disable-keyring) secret_keyring="no"
> +  ;;
>    *)
>        echo "ERROR: unknown option $opt"
>        echo "Try '$0 --help' for more information"
> @@ -6272,6 +6277,34 @@ case "$slirp" in
>      ;;
>  esac
>  
> +##########################################
> +# check for usable __NR_keyctl syscall
> +
> +if test "$linux" = "yes" ; then
> +
> +    have_keyring=no
> +    cat > $TMPC << EOF
> +#include <errno.h>
> +#include <asm/unistd.h>
> +#include <linux/keyctl.h>
> +#include <unistd.h>
> +int main(void) {
> +    return syscall(__NR_keyctl, KEYCTL_READ, 0, NULL, NULL, 0);
> +}
> +EOF
> +    if compile_prog "" "" ; then
> +        have_keyring=yes
> +    fi
> +fi
> +if test "$secret_keyring" = "yes"
> +then
> +    if test "$have_keyring" != "yes"
> +    then
> +    error_exit "syscall __NR_keyctl requested, \
> +but not implemented on your system"
> +    fi
> +fi

This logic doesn't correctly disable keyring on Non-Linux native
builds by default. eg mingw as reported by patchew

I'm going to repost with the following squashed in

diff --git a/configure b/configure
index f2ff722f7e..f17c2fd72e 100755
--- a/configure
+++ b/configure
@@ -510,7 +510,7 @@ default_devices="yes"
 plugins="no"
 fuzzing="no"
 rng_none="no"
-secret_keyring="yes"
+secret_keyring=""
 
 supported_cpu="no"
 supported_os="no"
@@ -6296,12 +6296,19 @@ EOF
         have_keyring=yes
     fi
 fi
-if test "$secret_keyring" = "yes"
+if test "$secret_keyring" != "no"
 then
-    if test "$have_keyring" != "yes"
+    if test "$have_keyring" == "yes"
     then
-    error_exit "syscall __NR_keyctl requested, \
+       secret_keyring=yes
+    else
+       if test "$secret_keyring" = "yes"
+       then
+           error_exit "syscall __NR_keyctl requested, \
 but not implemented on your system"
+       else
+           secret_keyring=no
+       fi
     fi
 fi


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


