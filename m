Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 326FCC2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 08:35:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92600206ED
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 08:35:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aDAvrUgf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92600206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc2e9-0002s0-Gv
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 03:35:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45338)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kc2dL-0002RT-G2
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 03:34:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27085)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kc2dI-0002bx-QI
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 03:34:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604910875;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VjGigfT6pTc5FI6e3W1rC6q5ZfBoUW8RyTIOrtRS/2A=;
 b=aDAvrUgfu/9eD4KFySFlG6RmX1UB1pYdvMVR3MUV/sBBbxoPf+/MKAlB2mMTr1bJD6tDRn
 /sd9LWYqg+3DeT2UUdKU0Osqe8oxkrYUi3DaEZnceR/R/12xHqeVVMSgLXRGLRERm9Z90c
 FZAt2WsGH5CX0eGOAgzsQKGO+aT3HCk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-149-U4IUw_WEPxWqQ8YUreCUxA-1; Mon, 09 Nov 2020 03:34:33 -0500
X-MC-Unique: U4IUw_WEPxWqQ8YUreCUxA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6E99C6D242;
 Mon,  9 Nov 2020 08:34:32 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-53.ams2.redhat.com [10.36.112.53])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7022A5D98A;
 Mon,  9 Nov 2020 08:34:22 +0000 (UTC)
Subject: Re: [PATCH-for-5.2 v4 01/17] configure: Check vhost-user is available
 to build vhost-user-blk-server
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20201108204535.2319870-1-philmd@redhat.com>
 <20201108204535.2319870-2-philmd@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <8f152950-8d95-c2c1-27dd-f3a7a0456520@redhat.com>
Date: Mon, 9 Nov 2020 09:34:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201108204535.2319870-2-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 00:04:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: Fam Zheng <fam@euphon.net>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08/11/2020 21.45, Philippe Mathieu-Daudé wrote:
> Check vhost-user is available to build vhost-user-blk-server to fix:
> 
>  $ ../configure \
>       --disable-vhost-user --enable-vhost-user-blk-server && \
>    make qemu-nbd
>  ...
>  [505/505] Linking target qemu-nbd
>  FAILED: qemu-nbd
>  cc  -o qemu-nbd qemu-nbd.p/qemu-nbd.c.o -Wl,--as-needed -Wl,--no-undefined -pie -Wl,--whole-archive libblockdev.fa libblock.fa libcrypto.fa libauthz.fa libqom.fa libio.fa -Wl,--no-whole-archive -Wl,--warn-common -Wl,-z,relro -Wl,-z,now -m64 -fstack-protector-strong -Wl,--start-group libqemuutil.a libblockdev.fa libblock.fa libcrypto.fa libauthz.fa libqom.fa libio.fa @block.syms -lgio-2.0 -lgobject-2.0 -lglib-2.0 -lgio-2.0 -lgobject-2.0 -lglib-2.0 -pthread -lgnutls -lutil -lm -lgthread-2.0 -lglib-2.0 -lbz2 -lgthread-2.0 -lglib-2.0 -lssh -lrbd -lrados -lcurl -lxml2 -lzstd -lacl -lgfapi -lglusterfs -lgfrpc -lgfxdr -luuid -laio /usr/lib64/libz.so -L/usr/lib64/iscsi -liscsi -lnettle -lgnutls -lpam -Wl,--end-group
>  /usr/bin/ld: libblockdev.fa(block_export_vhost-user-blk-server.c.o): in function `vu_blk_process_vq':
>  block/export/vhost-user-blk-server.c:203: undefined reference to `vu_get_queue'
>  /usr/bin/ld: block/export/vhost-user-blk-server.c:208: undefined reference to `vu_queue_pop'
>  /usr/bin/ld: libblockdev.fa(block_export_vhost-user-blk-server.c.o): in function `vu_blk_queue_set_started':
>  block/export/vhost-user-blk-server.c:228: undefined reference to `vu_get_queue'
>  /usr/bin/ld: libblockdev.fa(block_export_vhost-user-blk-server.c.o): in function `vu_blk_req_complete':
>  block/export/vhost-user-blk-server.c:55: undefined reference to `vu_queue_push'
>  /usr/bin/ld: block/export/vhost-user-blk-server.c:56: undefined reference to `vu_queue_notify'
>  /usr/bin/ld: libblockdev.fa(block_export_vhost-user-blk-server.c.o): in function `vu_blk_queue_set_started':
>  block/export/vhost-user-blk-server.c:229: undefined reference to `vu_set_queue_handler'
>  /usr/bin/ld: libqemuutil.a(util_vhost-user-server.c.o): in function `vu_client_trip':
>  util/vhost-user-server.c:176: undefined reference to `vu_dispatch'
>  /usr/bin/ld: util/vhost-user-server.c:180: undefined reference to `vu_deinit'
>  /usr/bin/ld: libqemuutil.a(util_vhost-user-server.c.o): in function `vu_accept':
>  util/vhost-user-server.c:291: undefined reference to `vu_init'
>  collect2: error: ld returned 1 exit status
>  ninja: build stopped: subcommand failed.
>  make: *** [Makefile:171: run-ninja] Error 1
> 
> Fixes: bc15e44cb21 ("configure: introduce --enable-vhost-user-blk-server")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  configure | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/configure b/configure
> index 805f7791503..5079ebb416a 100755
> --- a/configure
> +++ b/configure
> @@ -2390,6 +2390,9 @@ fi
>  
>  # libvhost-user is Linux-only
>  test "$vhost_user_blk_server" = "" && vhost_user_blk_server=$linux
> +if test "$vhost_user_blk_server" = "yes" && test "$vhost_user" = "no"; then
> +  error_exit "--enable-vhost-user-blk-server requires --enable-vhost-user"
> +fi

This patch looks incomplete to me. If I now do:

$ .../configure --target-list=x86_64-softmmu --disable-vhost-user

I get:

ERROR: --enable-vhost-user-blk-server requires --enable-vhost-user

... but I did not say --enable-vhost-user-blk-server ! So if
--disable-vhost-user has been given, it should also automatically disable
all the other vhost-user switches, I think.

 Thomas


