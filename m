Return-Path: <SRS0=clLO=73=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01FBCC433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2020 18:48:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B906F206B7
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2020 18:48:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GKFY1ck9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B906F206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkXfs-0001qM-W0
	for qemu-devel@archiver.kernel.org; Sun, 14 Jun 2020 14:48:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35130)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <coiby.xu@gmail.com>)
 id 1jkXeg-0000Xk-VT
 for qemu-devel@nongnu.org; Sun, 14 Jun 2020 14:46:55 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:34462)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <coiby.xu@gmail.com>)
 id 1jkXed-0002Yc-8q
 for qemu-devel@nongnu.org; Sun, 14 Jun 2020 14:46:53 -0400
Received: by mail-pl1-x644.google.com with SMTP id n9so5876645plk.1
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2020 11:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:date:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=wXsMzskj8fr5Z08nt8nRpof878YzMgZWrp79lcCoqms=;
 b=GKFY1ck9f4yEd89rvN9vbSJHZDic5ryw0ar1UU8TBGRi4VfrGorbQTStzDfSSFPyMi
 NZg7yoWxUZsaWQ0QMU8eT5eaya7SYSXbVqCZ284CIL+tB4hSHfpi/PbLiGegJmK2u54+
 EMhRTo/YcR3PT1reNUO9TJRUwulr041e5B2grGd9cXUt01rWsZ+hiL/kenb2ZntSCnBZ
 flqFWL3g6YDEowzmWc4kHpawWHC+iO/dnYa79Qp3Qxe3/znlH9UtlqMZfPB4sPOdklHh
 HZDXDzcBjE4cYpODAgJOa6j5yKv1XOl1IOgtJuhFNL8u30XxRj5c1LBmP0eZHlX5xCuK
 Abfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:date:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=wXsMzskj8fr5Z08nt8nRpof878YzMgZWrp79lcCoqms=;
 b=TbegMEE8e0bQsKYRYH54ywrQR2hA68a//nZZjoat6db6ZypVPvGJ0P/dBNEoDBKYUo
 6buZuk4q69HKpHdJ0fZ6RdihLGpwL2PoQ+CL94SMfyM9YCfMmoSDzhpNed/kK1WYju4v
 /iQ+dyvcCEaM/XPDHz0CI0AW+g0kNG/eOjtmue9wWFPKuCDwe+TQu68Wrj3icj743iaC
 8YcQINOEIAeWhT55mQrPKyC5VWsA5G1gw34hSrf8DLO9KNC4KgwsY6iO6TBLlmsjVmCQ
 J9Nxa4F4iYy6qOyNY52j4xP3ZGoMs90KWxGAFhdfarNjocObZlVne8KJqavxs1CVB6IH
 42Ow==
X-Gm-Message-State: AOAM531zxjbm0wHPhTjb7YoGUYZ3sVhEhbbXBl9NLXZex6CTgnM8up8e
 ES7LTqSJjl5EwAmTRm7mxLc=
X-Google-Smtp-Source: ABdhPJw0qk+ThLf4nH71gmX4Y50z604xQolF3mk1/2aZ+IOStpSRv3UPeYtpXgoB6pjdTtF6D906fw==
X-Received: by 2002:a17:90a:1ac3:: with SMTP id
 p61mr8915219pjp.23.1592160404511; 
 Sun, 14 Jun 2020 11:46:44 -0700 (PDT)
Received: from localhost ([2001:e42:102:1532:160:16:113:140])
 by smtp.gmail.com with ESMTPSA id w5sm11539038pfn.22.2020.06.14.11.46.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2020 11:46:43 -0700 (PDT)
From: Coiby Xu <coiby.xu@gmail.com>
X-Google-Original-From: Coiby Xu <Coiby.Xu@gmail.com>
Date: Mon, 15 Jun 2020 02:46:40 +0800
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH v8 0/4] vhost-user block device backend implementation
Message-ID: <20200614184640.ydfsi6dhs5jkhaqx@r>
References: <20200604233538.256325-1-coiby.xu@gmail.com>
 <20200611123703.jpokj4m75woxt55f@steredhat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200611123703.jpokj4m75woxt55f@steredhat>
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=coiby.xu@gmail.com; helo=mail-pl1-x644.google.com
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
Cc: kwolf@redhat.com, bharatlkmlkvm@gmail.com, qemu-devel@nongnu.org,
 stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Stefano Garzarella,

On Thu, Jun 11, 2020 at 02:37:03PM +0200, Stefano Garzarella wrote:
>Hi Coiby Xu,
>
>On Fri, Jun 05, 2020 at 07:35:34AM +0800, Coiby Xu wrote:
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
>>  (qemu) object_add vhost-user-blk-server,id=ID,unix-socket=/tmp/vhost-user-blk_vhost.socket,node-name=DRIVE_NAME,writable=off,blk-size=512
>>  (qemu) object_del ID
>>
>> or appending the "-object" option when starting QEMU,
>>
>>   $ -object vhost-user-blk-server,id=disk,unix-socket=/tmp/vhost-user-blk_vhost.socket,node-name=DRIVE_NAME,writable=off,blk-size=512
>>
>> Then vhost-user client can connect to the server backend.
>> For example, QEMU could act as a client,
>>
>>   $ -m 256 -object memory-backend-memfd,id=mem,size=256M,share=on -numa node,memdev=mem -chardev socket,id=char1,path=/tmp/vhost-user-blk_vhost.socket -device vhost-user-blk-pci,id=blk0,chardev=char1
>>
>> And guest OS could access this vhost-user block device after mounting it.
>>
>> Coiby Xu (4):
>>   Allow vu_message_read to be replaced
>>   generic vhost user server
>>   vhost-user block device backend server
>>   new qTest case to test the vhost-user-blk-server
>>
>>  block/Makefile.objs                        |   1 +
>>  block/export/vhost-user-blk-server.c       | 716 ++++++++++++++++++++
>>  block/export/vhost-user-blk-server.h       |  34 +
>>  contrib/libvhost-user/libvhost-user-glib.c |   2 +-
>>  contrib/libvhost-user/libvhost-user.c      |  11 +-
>>  contrib/libvhost-user/libvhost-user.h      |  21 +
>>  softmmu/vl.c                               |   4 +
>>  tests/Makefile.include                     |   3 +-
>>  tests/qtest/Makefile.include               |   2 +
>>  tests/qtest/libqos/vhost-user-blk.c        | 130 ++++
>>  tests/qtest/libqos/vhost-user-blk.h        |  44 ++
>>  tests/qtest/libqtest.c                     |  54 +-
>>  tests/qtest/libqtest.h                     |  38 ++
>>  tests/qtest/vhost-user-blk-test.c          | 737 +++++++++++++++++++++
>>  tests/vhost-user-bridge.c                  |   2 +
>>  tools/virtiofsd/fuse_virtio.c              |   4 +-
>>  util/Makefile.objs                         |   1 +
>>  util/vhost-user-server.c                   | 406 ++++++++++++
>>  util/vhost-user-server.h                   |  59 ++
>>  19 files changed, 2229 insertions(+), 40 deletions(-)
>>  create mode 100644 block/export/vhost-user-blk-server.c
>>  create mode 100644 block/export/vhost-user-blk-server.h
>>  create mode 100644 tests/qtest/libqos/vhost-user-blk.c
>>  create mode 100644 tests/qtest/libqos/vhost-user-blk.h
>>  create mode 100644 tests/qtest/vhost-user-blk-test.c
>>  create mode 100644 util/vhost-user-server.c
>>  create mode 100644 util/vhost-user-server.h
>>
>
>Should we add an entry in the MAINTAINERS file for some of the new files?
>(e.g. util/vhost-user-server.*)

Yes, please. Thank you!

--
Best regards,
Coiby

