Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE79C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 23:26:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1EEB206A4
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 23:26:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MKvw84sz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1EEB206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jindN-0003Zg-25
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 19:26:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55034)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <coiby.xu@gmail.com>)
 id 1jincY-0002lZ-Le; Tue, 09 Jun 2020 19:25:30 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:42206)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <coiby.xu@gmail.com>)
 id 1jincX-0007eX-Id; Tue, 09 Jun 2020 19:25:30 -0400
Received: by mail-pf1-x441.google.com with SMTP id b5so239621pfp.9;
 Tue, 09 Jun 2020 16:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:date:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=b8SO35WiYUbBURYx7HNC6iiJvixKUGseKY9k9aG7Odw=;
 b=MKvw84szMo3ljOUtdzPiL6MW5QtjXjX9LXWqbfko2y4O9mDzsXWoMogNMbVFdqZxy8
 QSnNyOu51kGe/Dcy6TLmHYfWKP3KkzAKhLYNuYtIgizscL3YKHnqXnpeuQGMYJPRspEa
 4voLVhbY5+XkpzpvpPUYqCk9sVdDRvbF8XGb0zxgxebrcfzK2VcW8AbbmVlJXbd4grnz
 cc60WWvdpH5WqOgTCKvTmnVOrgeJWEJVJfJmHWUaE3nFcTArJtC2aSbdKXYkRNtpNdqG
 jgzmLvEklNAIMstav8bNavg76I9N8Qj6i4qKrnL4MIIPXvcIv1e7P57WXv1KNHm2uqh5
 5ELA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:date:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=b8SO35WiYUbBURYx7HNC6iiJvixKUGseKY9k9aG7Odw=;
 b=C3iahSo2KzE7JUTaRqU46Kwaj2OFxxtzdgUWwi6ajCUmO0f0EwGRBN1rsWDneLH9d8
 1S7zxXR4v3mSvnm77UFGSztCg3m3z8WJve0LkzAt4054Cl/qBZOMB/V76KvWcxkj5qGR
 hl8zjlkIa/fy+xdSNxz22YwdLKZAbe7+wkvfoGmUduepPxmcfuNXpxbNr1Ou7Qb1spiC
 AvzsQZn7r4R9j12G0Y0IkcQhYBs6G7CinlyXhN/BoOHxB2JhfoxiIVwItfe030EcQ/Ds
 ABNr0znj2vITvRY/MOtBgubQJ2WIziQ286gVI2PCQuBMmCoaI9XCxHGnoZURV0zT2icd
 w2Yw==
X-Gm-Message-State: AOAM532y8+/79pGaafa7Q/TbY9xGhigN9c+e6JAcJsJE6R7Sq1BH9gmS
 bzs9Ynf7pB91nrupB5uo5Sw=
X-Google-Smtp-Source: ABdhPJza6G4Dz5ZqWXR3AHn+D1nsA++KoTfFIrd56VykM3pzDtOISs1BM8BUx9hP32H7VBwrAdIGMQ==
X-Received: by 2002:a63:d04b:: with SMTP id s11mr305056pgi.384.1591745116664; 
 Tue, 09 Jun 2020 16:25:16 -0700 (PDT)
Received: from localhost ([2001:e42:102:1532:160:16:113:140])
 by smtp.gmail.com with ESMTPSA id d5sm11055367pfd.124.2020.06.09.16.25.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 16:25:16 -0700 (PDT)
From: Coiby Xu <coiby.xu@gmail.com>
X-Google-Original-From: Coiby Xu <Coiby.Xu@gmail.com>
Date: Wed, 10 Jun 2020 07:25:11 +0800
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v2 08/20] qemu-storage-daemon: Add --object option
Message-ID: <20200609232511.ucfrpj2ftfmbtfwf@r>
References: <20200224143008.13362-1-kwolf@redhat.com>
 <20200224143008.13362-9-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200224143008.13362-9-kwolf@redhat.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=coiby.xu@gmail.com; helo=mail-pf1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, armbru@redhat.com,
 stefanha@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Feb 24, 2020 at 03:29:56PM +0100, Kevin Wolf wrote:
>Add a command line option to create user-creatable QOM objects.
>
>Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>---
> qemu-storage-daemon.c | 47 +++++++++++++++++++++++++++++++++++++++++++
> Makefile.objs         |  2 +-
> qom/Makefile.objs     |  1 +
> 3 files changed, 49 insertions(+), 1 deletion(-)
>
>diff --git a/qemu-storage-daemon.c b/qemu-storage-daemon.c
>index c30caaf59e..0cd8144c81 100644
>--- a/qemu-storage-daemon.c
>+++ b/qemu-storage-daemon.c
>@@ -33,15 +33,19 @@
> #include "qapi/error.h"
> #include "qapi/qapi-visit-block-core.h"
> #include "qapi/qapi-commands-block-core.h"
>+#include "qapi/qmp/qdict.h"
> #include "qapi/qobject-input-visitor.h"
>
> #include "qemu-common.h"
> #include "qemu-version.h"
> #include "qemu/config-file.h"
> #include "qemu/error-report.h"
>+#include "qemu/help_option.h"
> #include "qemu/log.h"
> #include "qemu/main-loop.h"
> #include "qemu/module.h"
>+#include "qemu/option.h"
>+#include "qom/object_interfaces.h"
>
> #include "trace/control.h"
>
>@@ -63,12 +67,31 @@ static void help(void)
> "             [,driver specific parameters...]\n"
> "                         configure a block backend\n"
> "\n"
>+"  --object help          list object types that can be added\n"
>+"  --object <type>,help   list properties for the given object type\n"
>+"  --object <type>[,<property>=<value>...]\n"
>+"                         create a new object of type <type>, setting\n"
>+"                         properties in the order they are specified. Note\n"
>+"                         that the 'id' property must be set.\n"
>+"                         See the qemu(1) man page for documentation of the\n"
>+"                         objects that can be added.\n"
>+"\n"
> QEMU_HELP_BOTTOM "\n",
>     error_get_progname());
> }
>
> enum {
>     OPTION_BLOCKDEV = 256,
>+    OPTION_OBJECT,
>+};
>+
>+static QemuOptsList qemu_object_opts = {
>+    .name = "object",
>+    .implied_opt_name = "qom-type",
>+    .head = QTAILQ_HEAD_INITIALIZER(qemu_object_opts.head),
>+    .desc = {
>+        { }
>+    },
> };
>
I'm not sure whether qemu-storage-daemon's QMP monitor is supposed to support
`object-del` or not. If it's yes, we should add `qemu_add_opts(&qemu_object_opts);`,
otherwise, qemu-storage-daemon will exit with the following error,


    Unexpected error in find_list() at util/qemu-config.c:24:

The steps to reproduce this error,

   1. start qemu-storage-daemon

     ./qemu-storage-daemon --object iothread,id=iothread0 --chardev socket,id=qmp,path=abc,server,nowait --monitor chardev=qmp

   2. send object-del command

     echo '{ "execute": "qmp_capabilities" }'\
             '{ 'object-del', 'arguments': {'id': 'iothread0'} }'\
             '{ "execute": "quit" } ' | socat - UNIX-CONNECT:abc

