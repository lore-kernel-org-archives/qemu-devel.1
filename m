Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E35C43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 14:42:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 510E322206
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 14:42:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N5OmCm6Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 510E322206
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFep4-0005aD-Sk
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 10:42:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43054)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kFeoO-0004qq-AP
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 10:41:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38056)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kFeoL-0000wp-Sv
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 10:41:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599576088;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=20DuaKPLW2jRiLxGaRrROMn1vz5ZOVzWeqC0ckFNwSI=;
 b=N5OmCm6QcW4OJ6xI9PbNgPYFltrbnkXh28xPwuGma/pL5K9yK918iD7q3IiUdIA8Z1IxMW
 mf/52WxbwEGl5+2lK7YRI2UZj+KmLL3X+lY6QGU07/GJZChqjjq+2MHLHY9exrdnDPxsVm
 MJ169wOaRIoik5euf9ArXarM5c0Ou64=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-506-lwBLe7SUNA2S10q3xXvaaQ-1; Tue, 08 Sep 2020 10:41:24 -0400
X-MC-Unique: lwBLe7SUNA2S10q3xXvaaQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A482910BBECF;
 Tue,  8 Sep 2020 14:41:23 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-131.ams2.redhat.com [10.36.112.131])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D77A27ED85;
 Tue,  8 Sep 2020 14:41:21 +0000 (UTC)
Subject: Re: [PATCH] Simplify the .gitignore file
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20200907174255.179652-1-thuth@redhat.com>
 <e6755ee5-5d41-da76-1a34-e4a05fd76663@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <fac14891-3cff-4a27-8fa5-12ddd286e9db@redhat.com>
Date: Tue, 8 Sep 2020 16:41:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <e6755ee5-5d41-da76-1a34-e4a05fd76663@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 02:11:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.626, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 07/09/2020 21.43, Philippe Mathieu-Daudé wrote:
> On 9/7/20 7:42 PM, Thomas Huth wrote:
>> Now that we always do out-of-tree builds (and the in-tree builds are
>> faked via a "build" directory), we can simplify out .gitignore file
>> quite a bit.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  .gitignore | 158 -----------------------------------------------------
>>  1 file changed, 158 deletions(-)
>>
>> diff --git a/.gitignore b/.gitignore
>> index 4ccb9ed975..bb916594eb 100644
>> --- a/.gitignore
>> +++ b/.gitignore
>> @@ -1,165 +1,7 @@
>>  /GNUmakefile
>>  /build/
>> -/.doctrees
>> -/config-devices.*
>> -/config-all-devices.*
>> -/config-all-disas.*
>> -/config-host.*
>> -/config-target.*
>> -/config.status
>> -/config-temp
>> -/tools/virtiofsd/50-qemu-virtiofsd.json
>> -/elf2dmp
>> -/trace-events-all
>> -/trace/generated-events.h
>> -/trace/generated-events.c
>> -/trace/generated-helpers-wrappers.h
>> -/trace/generated-helpers.h
>> -/trace/generated-helpers.c
>> -/trace/generated-tcg-tracers.h
>> -/ui/shader/texture-blit-frag.h
>> -/ui/shader/texture-blit-vert.h
>> -/ui/shader/texture-blit-flip-vert.h
>> -/ui/input-keymap-*.c.inc
>> -*-timestamp
>> -/*-softmmu
>> -/*-darwin-user
>> -/*-linux-user
>> -/*-bsd-user
>> -/ivshmem-client
>> -/ivshmem-server
>> -/libdis*
>> -/libuser
>> -/linux-headers/asm
>> -/qga/qapi-generated
>> -/qapi-gen-timestamp
>> -/qapi/qapi-builtin-types.[ch]
>> -/qapi/qapi-builtin-visit.[ch]
>> -/qapi/qapi-commands-*.[ch]
>> -**/qapi/qapi-commands.[ch]
>> -**/qapi/qapi-emit-events.[ch]
>> -/qapi/qapi-events-*.[ch]
>> -**/qapi/qapi-events.[ch]
>> -**/qapi/qapi-init-commands.[ch]
>> -**/qapi/qapi-introspect.[ch]
>> -/qapi/qapi-types-*.[ch]
>> -**/qapi/qapi-types.[ch]
>> -/qapi/qapi-visit-*.[ch]
>> -!/qapi/qapi-visit-core.c
>> -**/qapi/qapi-visit.[ch]
>> -**/qapi/qapi-doc.texi
>> -/qemu-edid
>> -/qemu-img
>> -/qemu-nbd
>> -/qemu-options.def
>> -/qemu-options.texi
>> -/qemu-img-cmds.texi
>> -/qemu-img-cmds.h
>> -/qemu-io
>> -/qemu-ga
>> -/qemu-bridge-helper
>> -/qemu-keymap
>> -/qemu-monitor.texi
>> -/qemu-monitor-info.texi
>> -/qemu-storage-daemon
>> -/qemu-version.h
>> -/qemu-version.h.tmp
>> -/module_block.h
>> -/scsi/qemu-pr-helper
>> -/vhost-user-scsi
>> -/vhost-user-blk
>> -/vhost-user-gpu
>> -/vhost-user-input
>> -/fsdev/virtfs-proxy-helper
>> -*.tmp
> 
> I'm not sure about this one.

According to git blame, it has been added in commit b8bd2f598b7 for
tests/vm images.

>> -*.[1-9]
>> -*.a
>> -*.aux
>> -*.cp
>> -*.exe
>> -*.msi
>> -*.dll
>> -*.so
>> -*.fn
>> -*.ky
> 
> Need to double-check where this come from.

Looking at 0cb3fb1e30a7789881e18 and some other commits, it seems like
these were once used for the qemu-doc PDF file generation. Should be ok
to remove them now since we moved to Sphinx.

>> -*.log
>> -*.pdf
>> -*.pod
>> -*.cps
>> -*.fns
>> -*.kys
>> -*.pg
>> -*.pyc
>> -*.toc
>> -*.tp
>> -*.vr
>> -*.d
>> -!/.gitlab-ci.d
>> -!/scripts/qemu-guest-agent/fsfreeze-hook.d
>> -*.o
>> -.sdk
> 
> Need to double-check where this come from.

It's used for the Win32 SDK symlink in "configure":

 symlink "$vss_win32_sdk/inc" "$source_path/.sdk/vss/inc"

Indeed, it might be necessary to keep this entry.

>> -*.gcda
>> -*.gcno
>> -*.gcov
>> -/pc-bios/bios-pq/status
>> -/pc-bios/edk2-*.fd
> 
> I'm not sure about this one but will check.

Are the pc-bios/edk* file still built in-tree?

>> -/pc-bios/vgabios-pq/status
>> -/pc-bios/optionrom/linuxboot.asm
>> -/pc-bios/optionrom/linuxboot.bin
>> -/pc-bios/optionrom/linuxboot.raw
>> -/pc-bios/optionrom/linuxboot.img
>> -/pc-bios/optionrom/linuxboot_dma.asm
>> -/pc-bios/optionrom/linuxboot_dma.bin
>> -/pc-bios/optionrom/linuxboot_dma.raw
>> -/pc-bios/optionrom/linuxboot_dma.img
>> -/pc-bios/optionrom/pvh.asm
>> -/pc-bios/optionrom/pvh.bin
>> -/pc-bios/optionrom/pvh.raw
>> -/pc-bios/optionrom/pvh.img
>> -/pc-bios/optionrom/multiboot.asm
>> -/pc-bios/optionrom/multiboot.bin
>> -/pc-bios/optionrom/multiboot.raw
>> -/pc-bios/optionrom/multiboot.img
>> -/pc-bios/optionrom/kvmvapic.asm
>> -/pc-bios/optionrom/kvmvapic.bin
>> -/pc-bios/optionrom/kvmvapic.raw
>> -/pc-bios/optionrom/kvmvapic.img
>> -/pc-bios/s390-ccw/s390-ccw.elf
>> -/pc-bios/s390-ccw/s390-ccw.img
>> -/docs/built
>> -/docs/interop/qemu-ga-qapi.texi
>> -/docs/interop/qemu-ga-ref.html
>> -/docs/interop/qemu-ga-ref.info*
>> -/docs/interop/qemu-ga-ref.txt
>> -/docs/interop/qemu-qmp-qapi.texi
>> -/docs/interop/qemu-qmp-ref.html
>> -/docs/interop/qemu-qmp-ref.info*
>> -/docs/interop/qemu-qmp-ref.txt
>> -/docs/version.texi
>> -/contrib/vhost-user-gpu/50-qemu-gpu.json
>> -*.tps
> 
> Need to double-check where this come from.

According to 56e8bdd46a8 this is related to the QAPI doc generation ...
I hope this is done properly out-of-tree now, so it should be ok to
remove it.

>> -.stgit-*
> 
> Need to double-check where this come from.

I assume that this is related to temporary files from "Stacked Git" ...
if anybody is still using that tool, I think that line should rather go
into their global ~/.gitignore file instead.

>>  .git-submodule-status
>>  cscope.*
>>  tags
>>  TAGS
>> -docker-src.*
>>  *~
>> -*.ast_raw
>> -*.depend_raw
> 
> Coccinelle generated in source tree, please keep.

Ok.

 Thomas


