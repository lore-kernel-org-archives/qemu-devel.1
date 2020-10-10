Return-Path: <SRS0=BZbV=DR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30AD0C433E7
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 08:46:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82A26207C4
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 08:46:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uCh8h0Gs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82A26207C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRAWI-0005P9-Kd
	for qemu-devel@archiver.kernel.org; Sat, 10 Oct 2020 04:46:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50052)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <coiby.xu@gmail.com>)
 id 1kRAV8-0004Yi-2W
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 04:45:14 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:41239)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <coiby.xu@gmail.com>)
 id 1kRAV5-0003ng-Ps
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 04:45:13 -0400
Received: by mail-pg1-x543.google.com with SMTP id g9so9271315pgh.8
 for <qemu-devel@nongnu.org>; Sat, 10 Oct 2020 01:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:date:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=N5Js2OUURb2NA+phRgMTUajuSTb6xcBps+OS0rvYq5M=;
 b=uCh8h0Gs1V9vpSHctxHPvU3lYY6SLEzUBU3ZNn1nnrP3qgEQv2ILB49XuzubuAbpak
 xEOwhmdc5lSQPlW1lJ5H4ICKrop7TUZPMRF+vB/2wCkO4NrjD+hDypVyZmFVhJ87smYs
 WTnlwOpAWZ9q+QC42Do8MSfZjIKgmtuYskDMUaE+Bj78KnO5+KJTqZLIfG6bz0HGVMmi
 oIhXsP6MFEikYSl4/pdLMITOXVRd8sNbW8kl/vdw2Bh+I8jkPtGGxEtbg6zb0r4Jnr/V
 Te8lPIsy7Ufxkpy3h/l9IlMCjlXY/Nc26+CxbaKTL8LfNo1IU2XwWYv7YKcuGyZkFjqm
 DT4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:date:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=N5Js2OUURb2NA+phRgMTUajuSTb6xcBps+OS0rvYq5M=;
 b=DBApiHQn1uMiYYiMmBGoC2dnDpNlocFPIjtbGZWoMpZWSd+PCNCmCevjtdQGTCq5w4
 F4/izqWS5an/yKHGJjfvsjPZAOEtbNFtXSAEcf2ztTa9owbkZ2P3eV9EWOmr+UlsXlwb
 bWkKQp1krdKg9Qi0B2qPLHIEOw05l5zQ/B9nS+ztQDAuFfSvLekxSSJiGeU6poK5sg7x
 3ZMAdi6xT3xWulqUe/X+hlIxn9wpw43ZD9WB9wWrcyZsKXy8XjHbTWvvGHLI07ZIy6CU
 ZX2xEWJA8n8tLl86lskuAZs82qKWWLK7k/Na75Te8m6PAEpsBZU0XpqcW1n4Ieqgd3Zv
 FYOA==
X-Gm-Message-State: AOAM530QQnnbN+4voXgeWs6iZcuY8q6ObvZJbQV0X+NJlVY25/5CxOm2
 PG+9SxhxISH68vm3q2C7S40=
X-Google-Smtp-Source: ABdhPJySgJ8mqn/MC6LNhznYsCLmJHBAVi/jjlHYGy+BQd4K+WJqoNFacJGW1/aMpULVJ6gPMTNBkw==
X-Received: by 2002:a65:664a:: with SMTP id z10mr6328988pgv.171.1602319509999; 
 Sat, 10 Oct 2020 01:45:09 -0700 (PDT)
Received: from localhost ([2001:e42:102:1532:160:16:113:140])
 by smtp.gmail.com with ESMTPSA id c3sm13329064pfn.23.2020.10.10.01.45.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Oct 2020 01:45:09 -0700 (PDT)
From: Coiby Xu <coiby.xu@gmail.com>
X-Google-Original-From: Coiby Xu <Coiby.Xu@gmail.com>
Date: Sat, 10 Oct 2020 16:45:01 +0800
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v10 0/7] vhost-user block device backend implementation
Message-ID: <20201010084501.aiimigeiqnpwqngv@Rk>
References: <20200918080912.321299-1-coiby.xu@gmail.com>
 <20201009101843.GE168921@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20201009101843.GE168921@stefanha-x1.localdomain>
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=coiby.xu@gmail.com; helo=mail-pg1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: kwolf@redhat.com, bharatlkmlkvm@gmail.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 09, 2020 at 11:18:43AM +0100, Stefan Hajnoczi wrote:
>On Fri, Sep 18, 2020 at 04:09:05PM +0800, Coiby Xu wrote:
>> v10
>>  - Use a linked list of VuFdWatch objects to keep kick info [Stefan]
>>  - Merge improvements and fixes from Stefan
>>  - Rename libvhost-user's vu_message_read to vu_message_read_default [Kevin]
>>  - When shutting down the client, wait for the coroutine of processing
>>    vhost-user messages to be finished [Kevin]
>>  - Allocate struct req_data on the heap [Kevin]
>>  - Improve coding of qtest case [Thomas]
>>  - Fix several memory leaks detected by ASAN
>>
>> v9
>>  - move logical block size check function to a utility function
>>  - fix issues regarding license, coding style, memory deallocation, etc.
>>
>> v8
>>  - re-try connecting to socket server to fix asan error
>>  - fix license naming issue
>>
>> v7
>>  - fix docker-test-debug@fedora errors by freeing malloced memory
>>
>> v6
>>  - add missing license header and include guard
>>  - vhost-user server only serve one client one time
>>  - fix a bug in custom vu_message_read
>>  - using qemu-storage-daemon to start vhost-user-blk-server
>>  - a bug fix to pass docker-test-clang@ubuntu
>>
>> v5:
>>  * re-use vu_kick_cb in libvhost-user
>>  * keeping processing VhostUserMsg in the same coroutine until there is
>>    detachment/attachment of AIOContext
>>  * Spawn separate coroutine for each VuVirtqElement
>>  * Other changes including relocating vhost-user-blk-server.c, coding
>>    style etc.
>>
>> v4:
>>  * add object properties in class_init
>>  * relocate vhost-user-blk-test
>>  * other changes including using SocketAddress, coding style, etc.
>>
>> v3:
>>  * separate generic vhost-user-server code from vhost-user-blk-server
>>    code
>>  * re-write vu_message_read and kick hander function as coroutines to
>>    directly call blk_co_preadv, blk_co_pwritev, etc.
>>  * add aio_context notifier functions to support multi-threading model
>>  * other fixes regarding coding style, warning report, etc.
>>
>> v2:
>>  * Only enable this feature for Linux because eventfd is a Linux-specific
>>    feature
>>
>>
>> This patch series is an implementation of vhost-user block device
>> backend server, thanks to Stefan and Kevin's guidance.
>>
>> Vhost-user block device backend server is a UserCreatable object and can be
>> started using object_add,
>>
>>  (qemu) object_add vhost-user-blk-server,id=ID,unix-socket=/tmp/vhost-user-blk_vhost.socket,node-name=DRIVE_NAME,writable=off,logical-block-size=512
>>  (qemu) object_del ID
>>
>> or appending the "-object" option when starting QEMU,
>>
>>   $ -object vhost-user-blk-server,id=disk,unix-socket=/tmp/vhost-user-blk_vhost.socket,node-name=DRIVE_NAME,writable=off,logical-block-size=512
>>
>> Then vhost-user client can connect to the server backend.
>> For example, QEMU could act as a client,
>>
>>   $ -m 256 -object memory-backend-memfd,id=mem,size=256M,share=on -numa node,memdev=mem -chardev socket,id=char1,path=/tmp/vhost-user-blk_vhost.socket -device vhost-user-blk-pci,id=blk0,chardev=char1
>>
>> And guest OS could access this vhost-user block device after mounting it.
>>
>> Coiby Xu (7):
>>   libvhost-user: Allow vu_message_read to be replaced
>>   libvhost-user: remove watch for kick_fd when de-initialize vu-dev
>>   util/vhost-user-server: generic vhost user server
>>   block: move logical block size check function to a common utility
>>     function
>>   block/export: vhost-user block device backend server
>>   test: new qTest case to test the vhost-user-blk-server
>>   MAINTAINERS: Add vhost-user block device backend server maintainer
>>
>>  MAINTAINERS                                |   8 +
>>  block/export/vhost-user-blk-server.c       | 661 ++++++++++++++++++
>>  block/export/vhost-user-blk-server.h       |  36 +
>>  block/meson.build                          |   1 +
>>  contrib/libvhost-user/libvhost-user-glib.c |   2 +-
>>  contrib/libvhost-user/libvhost-user.c      |  15 +-
>>  contrib/libvhost-user/libvhost-user.h      |  21 +
>>  hw/core/qdev-properties.c                  |  31 +-
>>  softmmu/vl.c                               |   4 +
>>  tests/qtest/libqos/libqtest.h              |  17 +
>>  tests/qtest/libqos/meson.build             |   1 +
>>  tests/qtest/libqos/vhost-user-blk.c        | 129 ++++
>>  tests/qtest/libqos/vhost-user-blk.h        |  48 ++
>>  tests/qtest/libqtest.c                     |  36 +-
>>  tests/qtest/meson.build                    |   4 +-
>>  tests/qtest/vhost-user-blk-test.c          | 751 +++++++++++++++++++++
>>  tests/vhost-user-bridge.c                  |   2 +
>>  tools/virtiofsd/fuse_virtio.c              |   4 +-
>>  util/block-helpers.c                       |  46 ++
>>  util/block-helpers.h                       |  19 +
>>  util/meson.build                           |   2 +
>>  util/vhost-user-server.c                   | 428 ++++++++++++
>>  util/vhost-user-server.h                   |  65 ++
>>  23 files changed, 2292 insertions(+), 39 deletions(-)
>>  create mode 100644 block/export/vhost-user-blk-server.c
>>  create mode 100644 block/export/vhost-user-blk-server.h
>>  create mode 100644 tests/qtest/libqos/vhost-user-blk.c
>>  create mode 100644 tests/qtest/libqos/vhost-user-blk.h
>>  create mode 100644 tests/qtest/vhost-user-blk-test.c
>>  create mode 100644 util/block-helpers.c
>>  create mode 100644 util/block-helpers.h
>>  create mode 100644 util/vhost-user-server.c
>>  create mode 100644 util/vhost-user-server.h
>>
>> --
>> 2.28.0
>>
>
>Thanks, applied to my block tree:
>https://github.com/stefanha/qemu/commits/block
>

Thank you for improving the code! I'm going to study the changes to
understand how the improvements are made.

>Stefan



--
Best regards,
Coiby

