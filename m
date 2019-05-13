Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3BEEC04AA7
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 15:33:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C10472084F
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 15:33:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C10472084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59190 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQCxD-0005MY-VH
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 11:33:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50954)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1hQCuo-0003gn-JX
	for qemu-devel@nongnu.org; Mon, 13 May 2019 11:31:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1hQCiZ-0006Pn-5G
	for qemu-devel@nongnu.org; Mon, 13 May 2019 11:18:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36104)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>)
	id 1hQCiY-0006P4-Vc; Mon, 13 May 2019 11:18:19 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3D51685363;
	Mon, 13 May 2019 15:18:18 +0000 (UTC)
Received: from [10.40.204.20] (ovpn-204-20.brq.redhat.com [10.40.204.20])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 24E3D5D71E;
	Mon, 13 May 2019 15:17:52 +0000 (UTC)
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20190401141222.30034-1-lvivier@redhat.com>
	<6f3c5f49-9be7-85cb-d693-d608135975b5@redhat.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <b8d003fb-1d53-3723-4eef-b39a3d965bc0@redhat.com>
Date: Mon, 13 May 2019 17:17:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <6f3c5f49-9be7-85cb-d693-d608135975b5@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.25]);
	Mon, 13 May 2019 15:18:18 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 0/5] build: cleanup in Makefile.objs
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org,
	Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
	=?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
	=?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/04/2019 10:08, Paolo Bonzini wrote:
> On 01/04/19 16:12, Laurent Vivier wrote:
>> This cleanup removes hardware objects from the list of files to be
>> built for linux-user only targets.
>>
>> It also builds traces files only when the related file is built.
>>
>> Tested with all combinations of --{disable,enable}-{system,user,tools}
>>
>> v3:
>>    - don't move hw/display to CONFIG_BLOCK section
>> v2:
>>    - add CONFIG_TOOLS and CONFIG_BLOCK
>>    - replace GENERATED_FILES by generated-files-y
>>      and use generated-files-${CONFIG_TRACE_UST} and
>>      generated-files-${CONFIG_SOFTMMU}
>>    - move chardev-obj-y from SUBDIR_RULES to SOFTMMU_SUBDIR_RULES
>>    - use $(CONFIG_BLOCK) in tests/Makefile.include
>>    - disable qemu-ga with linux-user only
>>
>> Laurent Vivier (5):
>>    trace: only include trace-event-subdirs when they are needed
>>    build: replace GENERATED_FILES by generated-files-y
>>    configure: qemu-ga is only needed with softmmu targets
>>    build: chardev is only needed for softmmu targets
>>    build: don't build hardware objects with linux-user
>>
>>   Makefile                   |  43 +++++++-------
>>   Makefile.objs              |  22 ++++---
>>   Makefile.target            |   6 +-
>>   configure                  |   4 +-
>>   target/s390x/Makefile.objs |   2 +-
>>   tests/Makefile.include     | 116 ++++++++++++++++++-------------------
>>   6 files changed, 102 insertions(+), 91 deletions(-)
>>
> 
> Queued for 4.1, thanks.

Any news?

Thanks,
Laurent


