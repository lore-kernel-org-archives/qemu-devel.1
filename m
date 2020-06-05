Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4529DC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 05:02:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C474207D3
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 05:02:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SZA6E6NP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C474207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jh4Uu-000570-9E
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 01:02:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43698)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jh4UK-0004ef-Ut
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 01:01:52 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:34682
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jh4UJ-0008M1-31
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 01:01:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591333309;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=vKBzN/AuSG1dEGI0wmCcNH7ND+/qJvTEkFmP+pTKdDI=;
 b=SZA6E6NPuy8Q9QeHdUCSzEzfpUKIt10d2zBXBdcHCs6pPw0edZNCu9n6RdAaRwF2hLLt87
 eS7vffMzPNFUyYbEEFC1/npq8LMvCBfGccMLdjAmgcPqukDoCsiLrVl+rJ3jmhnrX/91Ys
 +4ezSPmpCk85C+Ql2mj7kVnpARpwZ/M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-331-WmMuf5CZP5CppRbagl5IFw-1; Fri, 05 Jun 2020 01:01:41 -0400
X-MC-Unique: WmMuf5CZP5CppRbagl5IFw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AF719188360C;
 Fri,  5 Jun 2020 05:01:40 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-70.ams2.redhat.com [10.36.112.70])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7814F7CCCE;
 Fri,  5 Jun 2020 05:01:35 +0000 (UTC)
Subject: Re: [PATCH v8 4/4] new qTest case to test the vhost-user-blk-server
To: Coiby Xu <coiby.xu@gmail.com>, qemu-devel@nongnu.org
References: <20200604233538.256325-1-coiby.xu@gmail.com>
 <20200604233538.256325-5-coiby.xu@gmail.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <b8b6c706-e726-e7db-8a1c-ad6fce6ce461@redhat.com>
Date: Fri, 5 Jun 2020 07:01:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200604233538.256325-5-coiby.xu@gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 01:01:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: kwolf@redhat.com, Laurent Vivier <lvivier@redhat.com>,
 bharatlkmlkvm@gmail.com, stefanha@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 05/06/2020 01.35, Coiby Xu wrote:
> This test case has the same tests as tests/virtio-blk-test.c except for
> tests have block_resize. Since vhost-user server can only server one
> client one time, two instances of qemu-storage-daemon are launched
> for the hotplug test.
> 
> In order to not block scripts/tap-driver.pl, vhost-user-blk-server will
> send "quit" command to qemu-storage-daemon's QMP monitor. So a function
> is added to libqtest.c to establish socket connection with socket
> server.
> 
> Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
> ---
>  tests/Makefile.include              |   3 +-
>  tests/qtest/Makefile.include        |   2 +
>  tests/qtest/libqos/vhost-user-blk.c | 130 +++++
>  tests/qtest/libqos/vhost-user-blk.h |  44 ++
>  tests/qtest/libqtest.c              |  54 +-
>  tests/qtest/libqtest.h              |  38 ++
>  tests/qtest/vhost-user-blk-test.c   | 737 ++++++++++++++++++++++++++++
>  7 files changed, 976 insertions(+), 32 deletions(-)
>  create mode 100644 tests/qtest/libqos/vhost-user-blk.c
>  create mode 100644 tests/qtest/libqos/vhost-user-blk.h
>  create mode 100644 tests/qtest/vhost-user-blk-test.c
[...]
> new file mode 100644
> index 0000000000..3de9c59194
> --- /dev/null
> +++ b/tests/qtest/libqos/vhost-user-blk.c
> @@ -0,0 +1,130 @@
> +/*
> + * libqos driver framework
> + *
> + * Based on tests/qtest/libqos/virtio-blk.c
> + *
> + * Copyright (c) 2020 Coiby Xu <coiby.xu@gmail.com>
> + *
> + * Copyright (c) 2018 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License version 2.1 as published by the Free Software Foundation.

Thanks for the update! ...

[...]
> diff --git a/tests/qtest/libqos/vhost-user-blk.h b/tests/qtest/libqos/vhost-user-blk.h
> new file mode 100644
> index 0000000000..ef4ef09cca
> --- /dev/null
> +++ b/tests/qtest/libqos/vhost-user-blk.h
> @@ -0,0 +1,44 @@
> +/*
> + * libqos driver framework
> + *
> + * Copyright (c) 2018 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License version 2 as published by the Free Software Foundation.

... but you've missed the header here :-(

[...]
> diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
> index 49075b55a1..a7b7c96206 100644
> --- a/tests/qtest/libqtest.c
> +++ b/tests/qtest/libqtest.c
> @@ -31,40 +31,9 @@
>  #include "qapi/qmp/qlist.h"
>  #include "qapi/qmp/qstring.h"
>  
> -#define MAX_IRQ 256
>  #define SOCKET_TIMEOUT 50
>  #define SOCKET_MAX_FDS 16
>  
> -
> -typedef void (*QTestSendFn)(QTestState *s, const char *buf);
> -typedef void (*ExternalSendFn)(void *s, const char *buf);
> -typedef GString* (*QTestRecvFn)(QTestState *);
> -
> -typedef struct QTestClientTransportOps {
> -    QTestSendFn     send;      /* for sending qtest commands */
> -
> -    /*
> -     * use external_send to send qtest command strings through functions which
> -     * do not accept a QTestState as the first parameter.
> -     */
> -    ExternalSendFn  external_send;
> -
> -    QTestRecvFn     recv_line; /* for receiving qtest command responses */
> -} QTestTransportOps;
> -
> -struct QTestState
> -{
> -    int fd;
> -    int qmp_fd;
> -    pid_t qemu_pid;  /* our child QEMU process */
> -    int wstatus;
> -    int expected_status;
> -    bool big_endian;
> -    bool irq_level[MAX_IRQ];
> -    GString *rx;
> -    QTestTransportOps ops;
> -};

Why do you have to move struct QTestState and friends to the header
instead? I'd prefer if we could keep it here if possible?

 Thomas


