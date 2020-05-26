Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85858C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 20:43:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A1EE207CB
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 20:43:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E1ycnENH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A1EE207CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdgQT-00050G-Hm
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 16:43:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34662)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jdgPb-00044z-3j
 for qemu-devel@nongnu.org; Tue, 26 May 2020 16:42:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51283
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jdgPZ-0006Sx-JX
 for qemu-devel@nongnu.org; Tue, 26 May 2020 16:42:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590525776;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4b2N3HB+mptn6S9xvtKiKeTw/Neh/mcI3og6Dpvc0KU=;
 b=E1ycnENH3v4gEtOBy6z1KtjjfXTTjuSAtWrjk6niS4VKUf7XxZqbEcWNjFGgR6eE1kT2xZ
 +XHczI+kHvZ35ul4vKx+7Y8tGkWa9e7MTTbWu0se09kg692Nam14VY6QEDur8kVkHNucQD
 X+MMp5ZeS9f0WUOAAZe4MPwHnVqc5y0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-IWaI2G06NcaEDlSSoD8z1A-1; Tue, 26 May 2020 16:42:53 -0400
X-MC-Unique: IWaI2G06NcaEDlSSoD8z1A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A298C1007B09;
 Tue, 26 May 2020 20:42:52 +0000 (UTC)
Received: from [10.3.112.88] (ovpn-112-88.phx2.redhat.com [10.3.112.88])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0777579C4D;
 Tue, 26 May 2020 20:42:48 +0000 (UTC)
Subject: Re: [PATCH v4 0/5] coroutines: generate wrapper code
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <159041246428.2646.2773751210145691653@45ef0f9c86ae>
 <13e2fafe-8897-c55c-49f7-1d9283949615@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <495c85cd-016d-2da9-ad7a-80d715eff12d@redhat.com>
Date: Tue, 26 May 2020 15:42:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <13e2fafe-8897-c55c-49f7-1d9283949615@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 15:25:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, fam@euphon.net, ehabkost@redhat.com,
 qemu-block@nongnu.org, mreitz@redhat.com, stefanha@redhat.com,
 crosa@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/25/20 8:48 AM, Vladimir Sementsov-Ogievskiy wrote:
> 25.05.2020 16:14, no-reply@patchew.org wrote:
>> Patchew 
>> URL:https://patchew.org/QEMU/20200525100801.13859-1-vsementsov@virtuozzo.com/ 
>>
>>
>>
>>
>> Hi,
>>
>> This series failed the docker-quick@centos7 build test. Please find 
>> the testing commands and
>> their output below. If you have Docker installed, you can probably 
>> reproduce it
>> locally.
>>
>> === TEST SCRIPT BEGIN ===
>> #!/bin/bash
>> make docker-image-centos7 V=1 NETWORK=1
>> time make docker-test-quick@centos7 SHOW_ENV=1 J=14 NETWORK=1
>> === TEST SCRIPT END ===
>>
>> block/vhdx-log.o: In function `vhdx_log_write_and_flush':
>> /tmp/qemu-test/src/block/vhdx-log.c:1049: undefined reference to 
>> `bdrv_flush'
>> /tmp/qemu-test/src/block/vhdx-log.c:1061: undefined reference to 
>> `bdrv_flush'
>> collect2: error: ld returned 1 exit status
>> make: *** [qemu-nbd] Error 1
> 
> Hmm. Who can help?
> 
> I assume, that this is because I've added block/block-gen.o into 
> ./Makefile.objs, and not into block/Makefile.objs. I'll try it with next 
> resend.

Are you doing in-tree or VPATH builds?  When I tried a VPATH build, I got:

$ make -C build block/block-gen.c V=1
make: Entering directory '/home/eblake/qemu/build'
...
cat include/block/block.h block/coroutines.h | 
/home/eblake/qemu/scripts/coroutine-wrapper.py > block/block-gen.c
cat: include/block/block.h: No such file or directory
cat: block/coroutines.h: No such file or directory
make: 'block/block-gen.c' is up to date.
make: Leaving directory '/home/eblake/qemu/build'

and a resulting block/block-gen.c that declares nothing but 3 #includes.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


