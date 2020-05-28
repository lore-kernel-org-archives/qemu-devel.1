Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A8AC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 09:13:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF4CB208E4
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 09:13:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BqKPVary"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF4CB208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeEbY-0007bs-Uv
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 05:13:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34306)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jeEaE-0005uG-Jz
 for qemu-devel@nongnu.org; Thu, 28 May 2020 05:12:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35746
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jeEaC-0000vb-QE
 for qemu-devel@nongnu.org; Thu, 28 May 2020 05:12:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590657131;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=TaTxXQ6axHKnh/mazii4ExK9ajTJNjt03EelnBn6764=;
 b=BqKPVaryLvbOGREmYOs9u+7dbsye6SEIMZ00iyqTf0y/2lmH7dZB29pYyERtlbWoJtJR6i
 oAHrNvrUq9nK38j63TY+wAz1llL/OP2UyT3ZUwULbF8X8PK+0pajg4kqDJgmR9iIHQJFth
 f4r0XkBEwHdMry6N/Mm6hxV99FsxmIE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-223-dgg6hFYvPhe7FnhuFAHBOw-1; Thu, 28 May 2020 05:12:07 -0400
X-MC-Unique: dgg6hFYvPhe7FnhuFAHBOw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E30A0464;
 Thu, 28 May 2020 09:12:06 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-213.ams2.redhat.com [10.36.112.213])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D82A35D9F7;
 Thu, 28 May 2020 09:11:54 +0000 (UTC)
Subject: Re: [PATCH 6/7] gitlab-ci: Determine the number of jobs dynamically
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20200525131823.715-1-thuth@redhat.com>
 <20200525131823.715-7-thuth@redhat.com> <87pnao4fjs.fsf@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <db3e3dfe-f0b8-4947-1fd7-c50e57bb2040@redhat.com>
Date: Thu, 28 May 2020 11:11:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <87pnao4fjs.fsf@linaro.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 03:11:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 28/05/2020 10.41, Alex Bennée wrote:
> 
> Thomas Huth <thuth@redhat.com> writes:
> 
>> Some people might want to run the gitlab CI pipelines in an environment
>> where multiple CPUs are available to the runners, so let's rather get
>> the number for "-j" from the "nproc" program (increased by 1 to compensate
>> for jobs that wait for I/O) instead of hard-coding it.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
> <snip>
>> @@ -25,8 +27,8 @@ build-system1:
>>   - ../configure --enable-werror --target-list="aarch64-softmmu alpha-softmmu
>>        cris-softmmu hppa-softmmu lm32-softmmu moxie-softmmu microblazeel-softmmu
>>        mips64el-softmmu m68k-softmmu ppc-softmmu riscv64-softmmu sparc-softmmu"
>> - - make -j2
>> - - make -j2 check
>> + - make -j"$JOBS"
>> + - make -j"$JOBS" check
>>  
>>  build-system2:
>>   image: fedora:latest
>> @@ -40,8 +42,8 @@ build-system2:
>>   - ../configure --enable-werror --target-list="tricore-softmmu unicore32-softmmu
>>        microblaze-softmmu mips-softmmu riscv32-softmmu s390x-softmmu sh4-softmmu
>>        sparc64-softmmu x86_64-softmmu xtensa-softmmu nios2-softmmu or1k-softmmu"
>> - - make -j2
>> - - make -j2 check
>> + - make -j"$JOBS"
>> + - make -j"$JOBS" check
>>  
>>  build-disabled:
>>   image: fedora:latest
>> @@ -56,8 +58,8 @@ build-disabled:
>>        --disable-qom-cast-debug --disable-spice --disable-vhost-vsock
>>        --disable-vhost-net --disable-vhost-crypto --disable-vhost-user
>>        --target-list="i386-softmmu ppc64-softmmu mips64-softmmu i386-linux-user"
>> - - make -j2
>> - - make -j2 check-qtest SPEED=slow
>> + - make -j"$JOBS"
>> + - make -j"$JOBS" check-qtest SPEED=slow
> 
> I would make all the check jobs use a single core as it otherwise gets
> hard to figure out exactly where something broke/hung.

It's a somewhat double-edged sword ... either faster CI test times, or
more deterministic output ... so far I didn't suffer the problem with
the deterministic output in the gitlab-CI yet (unlike with Travis), so
I'd rather keep the -j here for now. We can still remove it later if we
hit a bug that is hard to debug otherwise.

 Thomas


