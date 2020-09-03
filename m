Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D619C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 10:23:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A6A720767
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 10:23:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T0sUsYCA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A6A720767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDmP8-0002R6-0t
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 06:23:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51126)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kDmOW-0001uR-28
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 06:23:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40098
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kDmOS-0007Ww-Pp
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 06:23:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599128579;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TtMwpYvNESO4kPM+nlvo9PTe48tCCli1B4xPaXswEsk=;
 b=T0sUsYCAlZjL4P9o339hhAdPpxjZ8SG+m4hX0gs4LQHvbd9EKLcUW4mAt7WoPavblILLrr
 Umr99/VYha2NZtHD6SHBQR3O1MrzWLmsfBaiHil9+tIVb9u1GVOgrLFD248Tt09pxIj6sc
 Dwev9AwvmBS6zrSHo/6lo8haNQ2UPoE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-178-rmemyOqpMKG0ndmMWWdnbw-1; Thu, 03 Sep 2020 06:22:56 -0400
X-MC-Unique: rmemyOqpMKG0ndmMWWdnbw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 51477802B7E
 for <qemu-devel@nongnu.org>; Thu,  3 Sep 2020 10:22:55 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-90.ams2.redhat.com [10.36.112.90])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 79F845C1C2;
 Thu,  3 Sep 2020 10:22:54 +0000 (UTC)
Subject: Re: [PATCH] stubs: Move qemu_fd_register stub to util/main-loop.c
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20200903054503.425435-1-thuth@redhat.com>
 <20200903082425.GC441291@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <862e304a-fd86-6da4-4e19-fa907c8956dc@redhat.com>
Date: Thu, 3 Sep 2020 12:22:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200903082425.GC441291@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 01:58:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.324, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03/09/2020 10.24, Daniel P. Berrangé wrote:
> On Thu, Sep 03, 2020 at 07:45:03AM +0200, Thomas Huth wrote:
>> The linker of MinGW sometimes runs into the following problem:
>>
>> libqemuutil.a(util_main-loop.c.obj): In function `qemu_fd_register':
>> /builds/huth/qemu/build/../util/main-loop.c:331: multiple definition of
>>  `qemu_fd_register'
>> libqemuutil.a(stubs_fd-register.c.obj):/builds/huth/qemu/stubs/fd-register.c:5:
>>  first defined here
>> collect2: error: ld returned 1 exit status
>> /builds/huth/qemu/rules.mak:88: recipe for target 'tests/test-timed-average.exe'
>>  failed
>>
>> qemu_fd_register() is defined in util/main-loop.c for WIN32, so let's simply
>> move the stub also there in the #else part of the corresponding #ifndef
>> to fix this problem.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  stubs/fd-register.c | 6 ------
>>  stubs/meson.build   | 1 -
>>  util/main-loop.c    | 4 ++++
> 
>>  3 files changed, 4 insertions(+), 7 deletions(-)
>>  delete mode 100644 stubs/fd-register.c
> 
> The util/meson.build only adds main-loop.c under 'if have_block'.
> 
> Since you didn't remove that conditional, I assume that nothing
> built in a "if not have_block" scenario was relying on the existing
> stub ?

Right, as far as I can see, this is not used by the linux-user or
bsd-user builds, and since

 have_block = have_system or have_tools

we should be fine without the separate stub.

> Assuming the answer is yes and/or CI passes 

CI compilation succeeded here:

 https://gitlab.com/huth/qemu/-/pipelines/185094808
 (the failed acceptance test is something different)

and:

 https://cirrus-ci.com/build/4756242964938752

> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

Thanks!

 Thomas


