Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A271C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 05:13:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1ABF2065F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 05:13:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CoqVHehT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1ABF2065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkhQq-0004ft-59
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 01:13:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44236)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jkhQH-0004GJ-9E
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 01:12:41 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:58570
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jkhQE-00074Y-Q3
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 01:12:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592197956;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=ia+C12z2Ucwp0vR10wHCy+xmy3VA3kNNhxNj2Dsiu+I=;
 b=CoqVHehTuhnRGVLo1js3E5k6snqmnziaw8hNRqXOROXymXgucKLYM75uS7u7vLnbwxow49
 Uw7UwmTJbavmQMVlpG3OkZUyZ9dJjE8qCmFDv49UfNmyHKcBdl5vWPGNrOiMPCdHufJJxb
 QQowgOPM2g+YvZWTSBTPTbw7LE/hoEo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-oSoyd2zoPrC35gZgAh7uxg-1; Mon, 15 Jun 2020 01:12:28 -0400
X-MC-Unique: oSoyd2zoPrC35gZgAh7uxg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 70CAA10082EB;
 Mon, 15 Jun 2020 05:12:27 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-111.ams2.redhat.com [10.36.112.111])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 42F3D7CAB8;
 Mon, 15 Jun 2020 05:12:25 +0000 (UTC)
Subject: Re: [PATCH] .travis.yml: Use travis_retry() in case of network issues
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200613130622.20541-1-f4bug@amsat.org>
 <5ba02176-34c9-f984-95f4-1f61103d785c@ilande.co.uk>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <bc9c331b-cfd4-9d46-3c02-86e95d93be88@redhat.com>
Date: Mon, 15 Jun 2020 07:12:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <5ba02176-34c9-f984-95f4-1f61103d785c@ilande.co.uk>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/15 01:12:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 14/06/2020 11.48, Mark Cave-Ayland wrote:
> On 13/06/2020 14:06, Philippe Mathieu-Daudé wrote:
> 
>> Use travis_retry() when cloning SLOF (see 31c8cc4f94e) in the
>> s390x container job, to avoid build failures:
>>
>>   $ ( cd ${SRC_DIR} ; git submodule update --init roms/SLOF )
>>   Submodule 'roms/SLOF' (https://git.qemu.org/git/SLOF.git) registered for path 'roms/SLOF'
>>   Cloning into '/home/travis/build/user/qemu/roms/SLOF'...
>>   fatal: unable to access 'https://git.qemu.org/git/SLOF.git/': Could not resolve host: git.qemu.org
>>   fatal: clone of 'https://git.qemu.org/git/SLOF.git' into submodule path '/home/travis/build/user/qemu/roms/SLOF' failed
>>   Failed to clone 'roms/SLOF'. Retry scheduled
>>   Cloning into '/home/travis/build/user/qemu/roms/SLOF'...
>>   fatal: unable to access 'https://git.qemu.org/git/SLOF.git/': Could not resolve host: git.qemu.org
>>   fatal: clone of 'https://git.qemu.org/git/SLOF.git' into submodule path '/home/travis/build/user/qemu/roms/SLOF' failed
>>   Failed to clone 'roms/SLOF' a second time, aborting
>>   The command "( cd ${SRC_DIR} ; git submodule update --init roms/SLOF )" exited with 1.
>>
>> Reported-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  .travis.yml | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/.travis.yml b/.travis.yml
>> index ec6367af1f..19a1b55aab 100644
>> --- a/.travis.yml
>> +++ b/.travis.yml
>> @@ -496,7 +496,7 @@ jobs:
>>          - CONFIG="--disable-containers --target-list=${MAIN_SOFTMMU_TARGETS},s390x-linux-user"
>>          - UNRELIABLE=true
>>        script:
>> -        - ( cd ${SRC_DIR} ; git submodule update --init roms/SLOF )
>> +        - ( cd ${SRC_DIR} ; travis_retry git submodule update --init roms/SLOF )
>>          - BUILD_RC=0 && make -j${JOBS} || BUILD_RC=$?
>>          - |
>>            if [ "$BUILD_RC" -eq 0 ] ; then
> 
> Hi Phil,
> 
> Thanks for diagnosing and proposing a fix. Is there a reason why SLOF in particular
> is failing compared to other repositories that might also need a similar change?

That's what I wonder, too. If git.qemu.org could not be resolved for
SLOF.git, why should it be resolvable for the other submodules that are
checked out automatically during the build process?

 Thomas


