Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 286C1C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 04:53:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E80572177B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 04:53:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ep5gwaK6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E80572177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kB9uw-0000iu-7W
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 00:53:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60004)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kB9uP-0000I3-1K
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 00:53:09 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:45543
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kB9uL-000455-V6
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 00:53:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598503984;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pdpv7UQJiZxAeWDRb3n2YB0Nf5eGJJJwTC1SMKh0+vU=;
 b=ep5gwaK6Ip8VxcdcSBMcToS6QgqOU6eLEP2HwnDGzi7ZHnZVhUyQZDdzmwUu6xKnRen/ug
 F5GbwCVbfKSbmNAjuViMxi3hEbklCIJLBkd2gi88edCz8yc+QSA8TQiEZ0t07Ex8E63hv8
 AQcxAGBxBvzPkhMIwn+CQPHKsXZ6UOo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-8qnab6huO5aFVSuptCY23Q-1; Thu, 27 Aug 2020 00:53:00 -0400
X-MC-Unique: 8qnab6huO5aFVSuptCY23Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 65F3118A2251;
 Thu, 27 Aug 2020 04:52:59 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-56.ams2.redhat.com [10.36.112.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 164AA5C1DA;
 Thu, 27 Aug 2020 04:52:57 +0000 (UTC)
Subject: Re: [PATCH] meson: move pixman detection to meson
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20200826070243.11969-1-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <cc6af807-a24f-42bb-b1f7-8c8c5e59200b@redhat.com>
Date: Thu, 27 Aug 2020 06:52:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200826070243.11969-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.81; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 00:53:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -52
X-Spam_score: -5.3
X-Spam_bar: -----
X-Spam_report: (-5.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.239, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Rafael Kitover <rkitover@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 26/08/2020 09.02, Paolo Bonzini wrote:
> When pixman is not installed (or too old), but virglrenderer is available
> and "configure" has been run with "--disable-system", the build currently
> aborts when trying to compile vhost-user-gpu (since it requires pixman).
> 
> Let's skip the build of vhost-user-gpu when pixman is not installed or
> too old.  Instead of adding CONFIG_PIXMAN, it is simpler to move the
> detection to pixman.
> 
> Based on a patch by Thomas Huth. <thuth@redhat.com>
> 
> Fixes: 9b52b17ba5 ("configure: Allow to build tools without pixman")
> Reported-by: Rafael Kitover <rkitover@gmail.com>
> Reported-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  configure                          | 21 ++-------------------
>  contrib/vhost-user-gpu/meson.build |  3 ++-
>  meson.build                        | 12 +++++++-----
>  3 files changed, 11 insertions(+), 25 deletions(-)
> 
> diff --git a/configure b/configure
> index a5fa472c64..51b6164f69 100755
> --- a/configure
> +++ b/configure
> @@ -3923,20 +3923,6 @@ if test "$modules" = yes; then
>      fi
>  fi
>  
> -##########################################
> -# pixman support probe
> -
> -if test "$softmmu" = "no"; then
> -  pixman_cflags=
> -  pixman_libs=
> -elif $pkg_config --atleast-version=0.21.8 pixman-1 > /dev/null 2>&1; then
> -  pixman_cflags=$($pkg_config --cflags pixman-1)
> -  pixman_libs=$($pkg_config --libs pixman-1)
> -else
> -  error_exit "pixman >= 0.21.8 not present." \
> -      "Please install the pixman devel package."
> -fi

The "else" part now got completely lost, didn't it? pixman is required
for building the softmmu targets, so we should error out if configure is
run with a softmmu target on systems where pixman is not installed.

Maybe you can simply replace the above check with:

if test "$softmmu" = "yes" && ! $pkg_config --atleast-version=0.21.8
pixman-1 > /dev/null 2>&1; then
  error_exit "pixman >= 0.21.8 not present." \
      "Please install the pixman devel package."
fi

?

 Thomas


>  ##########################################
>  # libmpathpersist probe
>  
> @@ -6649,8 +6635,8 @@ echo_version() {
>      fi
>  }
>  
> -# prepend pixman and ftd flags after all config tests are done
> -QEMU_CFLAGS="$pixman_cflags $fdt_cflags $QEMU_CFLAGS"
> +# prepend ftd flags after all config tests are done
> +QEMU_CFLAGS="$fdt_cflags $QEMU_CFLAGS"
>  QEMU_LDFLAGS="$fdt_ldflags $QEMU_LDFLAGS"
>  
>  config_host_mak="config-host.mak"
> @@ -8053,9 +8039,6 @@ fi
>  
>  done # for target in $targets
>  
> -echo "PIXMAN_CFLAGS=$pixman_cflags" >> $config_host_mak
> -echo "PIXMAN_LIBS=$pixman_libs" >> $config_host_mak
> -
>  if [ "$fdt" = "git" ]; then
>    subdirs="$subdirs dtc"
>  fi
> diff --git a/contrib/vhost-user-gpu/meson.build b/contrib/vhost-user-gpu/meson.build
> index 8df4c13bc5..7d9b29da8b 100644
> --- a/contrib/vhost-user-gpu/meson.build
> +++ b/contrib/vhost-user-gpu/meson.build
> @@ -1,5 +1,6 @@
>  if 'CONFIG_TOOLS' in config_host and 'CONFIG_VIRGL' in config_host \
> -    and 'CONFIG_GBM' in config_host and 'CONFIG_LINUX' in config_host
> +    and 'CONFIG_GBM' in config_host and 'CONFIG_LINUX' in config_host \
> +    and pixman.found()
>    executable('vhost-user-gpu', files('vhost-user-gpu.c', 'virgl.c', 'vugbm.c'),
>               link_with: libvhost_user,
>               dependencies: [qemuutil, pixman, gbm, virgl],
> diff --git a/meson.build b/meson.build
> index bcd39b39da..57c2fe2b65 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -114,8 +114,11 @@ if 'CONFIG_GNUTLS' in config_host
>    gnutls = declare_dependency(compile_args: config_host['GNUTLS_CFLAGS'].split(),
>                                link_args: config_host['GNUTLS_LIBS'].split())
>  endif
> -pixman = declare_dependency(compile_args: config_host['PIXMAN_CFLAGS'].split(),
> -                            link_args: config_host['PIXMAN_LIBS'].split())
> +pixman = not_found
> +if have_system or have_tools
> +  pixman = dependency('pixman', required: have_system, version:'>=0.21.8',
> +                      static: enable_static)
> +endif
>  pam = not_found
>  if 'CONFIG_AUTH_PAM' in config_host
>    pam = cc.find_library('pam')
> @@ -1094,9 +1097,7 @@ if have_tools
>    if 'CONFIG_VHOST_USER' in config_host
>      subdir('contrib/libvhost-user')
>      subdir('contrib/vhost-user-blk')
> -    if 'CONFIG_LINUX' in config_host
> -      subdir('contrib/vhost-user-gpu')
> -    endif
> +    subdir('contrib/vhost-user-gpu')
>      subdir('contrib/vhost-user-input')
>      subdir('contrib/vhost-user-scsi')
>    endif
> @@ -1303,6 +1304,7 @@ summary_info += {'SDL image support': sdl_image.found()}
>  # TODO: add back version
>  summary_info += {'GTK support':       config_host.has_key('CONFIG_GTK')}
>  summary_info += {'GTK GL support':    config_host.has_key('CONFIG_GTK_GL')}
> +summary_info += {'pixman':            pixman.found()}
>  # TODO: add back version
>  summary_info += {'VTE support':       config_host.has_key('CONFIG_VTE')}
>  summary_info += {'TLS priority':      config_host['CONFIG_TLS_PRIORITY']}
> 


