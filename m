Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1506C43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 14:51:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 470502074D
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 14:51:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qy9GPd2L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 470502074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFext-0005Ed-FD
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 10:51:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45074)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kFexH-0004i0-Rx
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 10:50:43 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:56847
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kFexF-00021M-29
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 10:50:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599576639;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eoRFHLUdMSkSgyer7bttDSdg2ApYkQth4g7QPCSDkjY=;
 b=Qy9GPd2L+NdgdWatTDuVKyoH+1PZU03WISuJWmzL5BkSiZrjIsqVvemZoy+N3AEYcChHU2
 X6JBuVWnpOcER7RtQgcV0j3JZKznc+7D8f9xgN/ZNrLwo1M7KtW3cns9JFPuiRQSLmoCXr
 XvQGW9KfQNJfoYnRMmnMdAl9rIEtMxs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-503-lEQFGiiGNkOaDKuRJjKTXA-1; Tue, 08 Sep 2020 10:50:38 -0400
X-MC-Unique: lEQFGiiGNkOaDKuRJjKTXA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 418CF18B9F00;
 Tue,  8 Sep 2020 14:50:37 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-131.ams2.redhat.com [10.36.112.131])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 129415D9EF;
 Tue,  8 Sep 2020 14:50:35 +0000 (UTC)
Subject: Re: [PATCH] Simplify the .gitignore file
From: Thomas Huth <thuth@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20200907174255.179652-1-thuth@redhat.com>
 <e6755ee5-5d41-da76-1a34-e4a05fd76663@redhat.com>
 <fac14891-3cff-4a27-8fa5-12ddd286e9db@redhat.com>
Message-ID: <01416c95-b956-0b58-f272-c75cceff73a9@redhat.com>
Date: Tue, 8 Sep 2020 16:50:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <fac14891-3cff-4a27-8fa5-12ddd286e9db@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.81; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 03:00:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.626, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: qemu-trivial@nongnu.org,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08/09/2020 16.41, Thomas Huth wrote:
> On 07/09/2020 21.43, Philippe Mathieu-Daudé wrote:
>> On 9/7/20 7:42 PM, Thomas Huth wrote:
>>> Now that we always do out-of-tree builds (and the in-tree builds are
>>> faked via a "build" directory), we can simplify out .gitignore file
>>> quite a bit.
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>  .gitignore | 158 -----------------------------------------------------
>>>  1 file changed, 158 deletions(-)
>>>
>>> diff --git a/.gitignore b/.gitignore
>>> index 4ccb9ed975..bb916594eb 100644
>>> --- a/.gitignore
>>> +++ b/.gitignore
>>> @@ -1,165 +1,7 @@
>>>  /GNUmakefile
>>>  /build/
>>> -/.doctrees
>>> -/config-devices.*
>>> -/config-all-devices.*
>>> -/config-all-disas.*
>>> -/config-host.*
>>> -/config-target.*
>>> -/config.status
>>> -/config-temp
>>> -/tools/virtiofsd/50-qemu-virtiofsd.json
>>> -/elf2dmp
>>> -/trace-events-all
>>> -/trace/generated-events.h
>>> -/trace/generated-events.c
>>> -/trace/generated-helpers-wrappers.h
>>> -/trace/generated-helpers.h
>>> -/trace/generated-helpers.c
>>> -/trace/generated-tcg-tracers.h
>>> -/ui/shader/texture-blit-frag.h
>>> -/ui/shader/texture-blit-vert.h
>>> -/ui/shader/texture-blit-flip-vert.h
>>> -/ui/input-keymap-*.c.inc
>>> -*-timestamp
>>> -/*-softmmu
>>> -/*-darwin-user
>>> -/*-linux-user
>>> -/*-bsd-user
>>> -/ivshmem-client
>>> -/ivshmem-server
>>> -/libdis*
>>> -/libuser
>>> -/linux-headers/asm
>>> -/qga/qapi-generated
>>> -/qapi-gen-timestamp
>>> -/qapi/qapi-builtin-types.[ch]
>>> -/qapi/qapi-builtin-visit.[ch]
>>> -/qapi/qapi-commands-*.[ch]
>>> -**/qapi/qapi-commands.[ch]
>>> -**/qapi/qapi-emit-events.[ch]
>>> -/qapi/qapi-events-*.[ch]
>>> -**/qapi/qapi-events.[ch]
>>> -**/qapi/qapi-init-commands.[ch]
>>> -**/qapi/qapi-introspect.[ch]
>>> -/qapi/qapi-types-*.[ch]
>>> -**/qapi/qapi-types.[ch]
>>> -/qapi/qapi-visit-*.[ch]
>>> -!/qapi/qapi-visit-core.c
>>> -**/qapi/qapi-visit.[ch]
>>> -**/qapi/qapi-doc.texi
>>> -/qemu-edid
>>> -/qemu-img
>>> -/qemu-nbd
>>> -/qemu-options.def
>>> -/qemu-options.texi
>>> -/qemu-img-cmds.texi
>>> -/qemu-img-cmds.h
>>> -/qemu-io
>>> -/qemu-ga
>>> -/qemu-bridge-helper
>>> -/qemu-keymap
>>> -/qemu-monitor.texi
>>> -/qemu-monitor-info.texi
>>> -/qemu-storage-daemon
>>> -/qemu-version.h
>>> -/qemu-version.h.tmp
>>> -/module_block.h
>>> -/scsi/qemu-pr-helper
>>> -/vhost-user-scsi
>>> -/vhost-user-blk
>>> -/vhost-user-gpu
>>> -/vhost-user-input
>>> -/fsdev/virtfs-proxy-helper
>>> -*.tmp
>>
>> I'm not sure about this one.
> 
> According to git blame, it has been added in commit b8bd2f598b7 for
> tests/vm images.

I forgot to add: These are properly created in the build directory, so
it is fine to remove this line.

 Thomas


