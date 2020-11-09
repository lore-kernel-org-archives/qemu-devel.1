Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70631C388F7
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 11:19:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1B1B20679
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 11:19:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oc+NyWlw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1B1B20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc5D5-0008Fk-Dm
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 06:19:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52512)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kc5CT-0007Yo-QE
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 06:19:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46582)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kc5CS-0002DX-0r
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 06:19:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604920743;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kX+1/RX9WascEA/D7J3edkc6OFTsgOuBCOq1/OOK7OQ=;
 b=Oc+NyWlwP/JpCX/9Re+hP7KlNtn4KwDzpwy6WFQTuccniR/K2uwViYX5Go3PM98S5nOkEM
 p1xVkRs8gaP83A0Mipt4uMuH58LQASt3euKsbFItwjgUJlj3owlOWYDt6DYvIqUh/zSrUo
 AAnvrX3NXcVKWasulJcPbg81DiZiiaY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-wjK90U_FMESrf0rNIe5RPw-1; Mon, 09 Nov 2020 06:19:00 -0500
X-MC-Unique: wjK90U_FMESrf0rNIe5RPw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A46B1842BE3;
 Mon,  9 Nov 2020 11:18:59 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-53.ams2.redhat.com [10.36.112.53])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B59165D9D2;
 Mon,  9 Nov 2020 11:18:49 +0000 (UTC)
Subject: Re: [PATCH-for-6.0 v4 07/17] gitlab-ci: Move job testing
 --without-default-devices across to gitlab
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20201108204535.2319870-1-philmd@redhat.com>
 <20201108204535.2319870-8-philmd@redhat.com>
 <1498febb-afdf-0510-7b7b-57bf1c43cfe0@redhat.com>
 <268d47cb-e814-da62-daf6-44fb0a94d42f@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <93520252-d58d-ba4c-56e2-aa51283f68dc@redhat.com>
Date: Mon, 9 Nov 2020 12:18:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <268d47cb-e814-da62-daf6-44fb0a94d42f@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 00:04:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: Fam Zheng <fam@euphon.net>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/11/2020 12.04, Philippe Mathieu-Daudé wrote:
> On 11/9/20 11:20 AM, Thomas Huth wrote:
>> On 08/11/2020 21.45, Philippe Mathieu-Daudé wrote:
>>> Similarly to commit 8cdb2cef3f1, move the job testing the
>>> '--without-default-devices' configure option to GitLab.
>>>
>>> Since building all softmmu targets takes too long, split
>>> the job in 2.
>>>
>>> As smoke test, run the qtests on the AVR and m68k targets.
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>>> ---
>>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>>>
>>> v3 had:
>>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>>> Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
>>> ---
>>>  .gitlab-ci.yml | 46 ++++++++++++++++++++++++++++++++++++++++++++++
>>>  .travis.yml    |  8 --------
>>>  2 files changed, 46 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
>>> index b98800462ed..3fc3d0568c6 100644
>>> --- a/.gitlab-ci.yml
>>> +++ b/.gitlab-ci.yml
>>> @@ -315,6 +315,52 @@ build-user-plugins:
>>>      MAKE_CHECK_ARGS: check-tcg
>>>    timeout: 1h 30m
>>>  
>>> +build-system-ubuntu-without-default-devices 1/2:
>>> +  <<: *native_build_job_definition
>>> +  variables:
>>> +    IMAGE: ubuntu2004
>>> +    CONFIGURE_ARGS: --without-default-devices --disable-tools --disable-docs
>>> +    TARGETS:
>>> +      aarch64-softmmu
>>> +      alpha-softmmu
>>> +      arm-softmmu
>>> +      avr-softmmu
>>> +      cris-softmmu
>>> +      hppa-softmmu
>>> +      i386-softmmu
>>> +      m68k-softmmu
>>> +      microblazeel-softmmu
>>> +      microblaze-softmmu
>>> +      mips64el-softmmu
>>> +      mips64-softmmu
>>> +      mipsel-softmmu
>>> +      mips-softmmu
>>> +      moxie-softmmu
>>> +    MAKE_CHECK_ARGS: check-qtest-avr check-qtest-m68k
>>> +
>>> +build-system-ubuntu-without-default-devices 2/2:
>>> +  <<: *native_build_job_definition
>>> +  variables:
>>> +    IMAGE: ubuntu2004
>>> +    CONFIGURE_ARGS: --without-default-devices --disable-tools --disable-docs
>>> +    TARGETS:
>>> +      nios2-softmmu
>>> +      or1k-softmmu
>>> +      ppc64-softmmu
>>> +      ppc-softmmu
>>> +      riscv32-softmmu
>>> +      riscv64-softmmu
>>> +      rx-softmmu
>>> +      s390x-softmmu
>>> +      sh4eb-softmmu
>>> +      sh4-softmmu
>>> +      sparc64-softmmu
>>> +      sparc-softmmu
>>> +      tricore-softmmu
>>> +      x86_64-softmmu
>>> +      xtensaeb-softmmu
>>> +      xtensa-softmmu
>>
>> Could you please add a MAKE_CHECK_ARGS here, too? check-qtest-rx or
>> check-qtest-sh4 sound like good candidates...
> 
> OK.
> 
>> And could you please also use Fedora and/or CentOS for these tests now?
>> We're using --without-default-devices in downstream RHEL, so testing with
>> that option in Fedora and CentOS would be helpful for us.
> 
> I wanted to do that, but expected someone to object as "we are not
> testing the same than before". I'll change one (maybe CentOS 8, which
> is less tested than Fedora).

Well, we simply used Ubuntu on Travis since there was no other option. Now
we are free to choose. Thus I'd prefer if you could use one Fedora and one
CentOS job here now if possible. We've already got some other Ubuntu jobs in
the gitlab-CI, so I doubt that anybody will complain.

 Thomas


