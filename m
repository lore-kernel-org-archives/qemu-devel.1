Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7103C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 17:10:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B0CD20731
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 17:10:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jr1+MLCO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B0CD20731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIawe-0005OQ-3K
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 13:10:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36902)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kIavq-0004tX-4d
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 13:09:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50584
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kIavn-00075O-Kn
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 13:09:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600276158;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ag2EahiSSy6q5U0uFqpvZ/EgtuWBPLlenSykbEa/Koo=;
 b=Jr1+MLCO6PMAcmwMG++/A6as9dni4e4TCuzeGd4GJmEgLwsXVf5lmF8k3QFKgNj4502gWI
 ChpoqBnLvK/qG8svAkCpiydKY9KNzM0opH6VlUzGE1VdgrJD+Edp+qqSXtBFqGPKcI64LQ
 ZNRDw0HGoJB3GNJAFIm3BBfqhDV4/mg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355-2uz4NLC6O6WiCQXviJmxqQ-1; Wed, 16 Sep 2020 13:09:11 -0400
X-MC-Unique: 2uz4NLC6O6WiCQXviJmxqQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A1092100830A
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 17:09:10 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-113-19.ams2.redhat.com [10.36.113.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A0AB11002393;
 Wed, 16 Sep 2020 17:09:09 +0000 (UTC)
Subject: Re: [PATCH 2/2] meson: move libmpathpersist test
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20200916162621.100141-1-pbonzini@redhat.com>
 <20200916162621.100141-3-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <d9b12d18-c008-514d-b29c-23621f206788@redhat.com>
Date: Wed, 16 Sep 2020 19:09:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200916162621.100141-3-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 13:09:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.062, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 16/09/2020 18.26, Paolo Bonzini wrote:
> This is the first compiler/linker test that has been moved to Meson.
> Add more section headings to keep things clearer.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  configure         | 77 +++------------------------------------------
>  meson.build       | 80 ++++++++++++++++++++++++++++++++++++++++++-----
>  meson_options.txt |  2 ++
>  3 files changed, 78 insertions(+), 81 deletions(-)
[...]
> diff --git a/meson.build b/meson.build
> index 5092aec439..60ef988d9d 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -86,6 +86,14 @@ if 'SPARSE_CFLAGS' in config_host
>                         'compile_commands.json'])
>  endif
>  
> +###########################################
> +# Target-specific checks and dependencies #
> +###########################################
> +
> +if targetos != 'linux' and get_option('mpath').enabled()
> +  error('Multipath is supported only on Linux')
> +endif
> +
>  m = cc.find_library('m', required: false)
>  util = cc.find_library('util', required: false)
>  winmm = []
> @@ -117,6 +125,11 @@ elif targetos == 'haiku'
>              cc.find_library('network'),
>              cc.find_library('bsd')]
>  endif
> +
> +################
> +# Dependencies #
> +################
> +
>  # The path to glib.h is added to all compilation commands.  This was
>  # grandfathered in from the QEMU Makefiles.
>  add_project_arguments(config_host['GLIB_CFLAGS'].split(),
> @@ -223,10 +236,6 @@ if 'CONFIG_SPICE' in config_host
>                               link_args: config_host['SPICE_LIBS'].split())
>  endif
>  rt = cc.find_library('rt', required: false)
> -libmpathpersist = not_found
> -if config_host.has_key('CONFIG_MPATH')
> -  libmpathpersist = cc.find_library('mpathpersist')
> -endif
>  libdl = not_found
>  if 'CONFIG_PLUGIN' in config_host
>    libdl = cc.find_library('dl', required: true)
> @@ -257,9 +266,62 @@ if 'CONFIG_CURL' in config_host
>                              link_args: config_host['CURL_LIBS'].split())
>  endif
>  libudev = not_found
> -if target_os == 'linux'
> -  libudev = dependency('libudev', static: enable_static)
> +if targetos == 'linux'
> +  libudev = dependency('libudev',
> +                       required: get_option('mpath'),
> +                       static: enable_static)
> +endif
> +
> +mpathpersist = not_found
> +if targetos == 'linux' and not get_option('mpath').disabled()
> +  libmultipath = cc.find_library('multipath',
> +                                 required: get_option('mpath'),
> +                                 static: enable_static)
> +  libmpathpersist = cc.find_library('mpathpersist',
> +                                    required: get_option('mpath'),
> +                                    static: enable_static)
> +  if libmultipath.found() and libmpathpersist.found() and libudev.found()
> +    if cc.links('''
> +      #include <libudev.h>
> +      #include <mpath_persist.h>
> +      unsigned mpath_mx_alloc_len = 1024;
> +      int logsink;
> +      static struct config *multipath_conf;
> +      extern struct udev *udev;
> +      extern struct config *get_multipath_config(void);
> +      extern void put_multipath_config(struct config *conf);
> +      struct udev *udev;
> +      struct config *get_multipath_config(void) { return multipath_conf; }
> +      void put_multipath_config(struct config *conf) { }
> +      int main(void) {
> +          udev = udev_new();
> +          multipath_conf = mpath_lib_init();
> +          return 0;
> +      }''', dependencies: [libmultipath, libmpathpersist, libudev])
> +      mpathpersist = declare_dependency(dependencies: [libmultipath, libmpathpersist, libudev])
> +      mpathpersist_new_api = true
> +    elif cc.links('''
> +      #include <libudev.h>
> +      #include <mpath_persist.h>
> +      unsigned mpath_mx_alloc_len = 1024;
> +      int logsink;
> +      int main(void) {
> +          struct udev *udev = udev_new();
> +          mpath_lib_init(udev);
> +          return 0;
> +      }''', dependencies: [libmultipath, libmpathpersist, libudev])
> +      mpathpersist = declare_dependency(dependencies: [libmultipath, libmpathpersist, libudev])
> +      mpathpersist_new_api = false
> +    else
> +      if get_option('mpath').enabled()
> +        error('Cannot detect libmpathpersist API')
> +      else
> +        warning('Cannot detect libmpathpersist API, disabling')
> +      endif
> +    endif
> +  endif
>  endif
> +

I just gave this a try on my laptop, but I'm seeing:

../../devel/qemu/meson.build:508:17: ERROR: Unknown variable
"mpathpersist_new_api".

... I guess it should only be printed if mpathpersist.found() ?

 Thomas


