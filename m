Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF44EC433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 15:45:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B13420719
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 15:45:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HLSPpCPm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B13420719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGOle-0008BY-K8
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 11:45:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45544)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kGOkQ-0007Hv-0o
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 11:44:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31176)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kGOkN-0002gA-Tb
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 11:44:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599752666;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SLH6RyZ7kMi6trdcDafu5sU/JBsP9ftbbCE8RUae1Kg=;
 b=HLSPpCPmobZVozl1xkv+1uhHahhZ0Pw1lJU/wUOBQwjhvNvPT0jSulOvq+MOTpJDXfhqKR
 Pa2Ey1V75eJIzIcyS6pJj3gTlq47+FmPecCtAdpsGCcn4jsZRFONno1EVnJS6UVQAnFip2
 ECeUsPC/foED1tQuHCi1XYA751Irglk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-19-3pccAYd0OyeoUWiBpM7GYA-1; Thu, 10 Sep 2020 11:44:22 -0400
X-MC-Unique: 3pccAYd0OyeoUWiBpM7GYA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7CD991009444
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2020 15:44:21 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-114-83.ams2.redhat.com
 [10.36.114.83])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E14101002382;
 Thu, 10 Sep 2020 15:44:20 +0000 (UTC)
Subject: Re: [PATCH 05/10] roms/edk2: update submodule from edk2-stable201905
 to edk2-stable202008
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu devel list <qemu-devel@nongnu.org>
References: <20200908072939.30178-1-lersek@redhat.com>
 <20200908072939.30178-6-lersek@redhat.com>
 <1356c404-517c-cf5c-bc04-04237c03f572@redhat.com>
 <2e0b207b-d902-f56c-18d7-50998c7de991@redhat.com>
 <0309f104-854a-840b-8ec3-fb50960d7821@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <96e060e8-767c-9f2c-942e-597b38473846@redhat.com>
Date: Thu, 10 Sep 2020 17:44:19 +0200
MIME-Version: 1.0
In-Reply-To: <0309f104-854a-840b-8ec3-fb50960d7821@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lersek@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 08:38:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/10/20 17:32, Philippe Mathieu-Daudé wrote:
> On 9/8/20 2:08 PM, Laszlo Ersek wrote:
>> On 09/08/20 10:22, Philippe Mathieu-Daudé wrote:
>>> Hi Laszlo,
>>>
>>> On 9/8/20 9:29 AM, Laszlo Ersek wrote:
>>>> Update the edk2 submodule from release edk2-stable201905 to
>>>> edk2-stable202008. The release notes can be read at
>>> [...]
>>>>
>>>> Cc: Philippe Mathieu-Daudé <philmd@redhat.com>
>>>> Ref: https://bugs.launchpad.net/qemu/+bug/1852196
>>>> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
>>>> ---
>>>>  roms/edk2 | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/roms/edk2 b/roms/edk2
>>>> index 20d2e5a125e3..06dc822d045c 160000
>>>> --- a/roms/edk2
>>>> +++ b/roms/edk2
>>>> @@ -1 +1 @@
>>>> -Subproject commit 20d2e5a125e34fc8501026613a71549b2a1a3e54
>>>> +Subproject commit 06dc822d045c2bb42e497487935485302486e151
>>>
>>> FYI applying this I got:
>>>
>>> Fetching submodule roms/edk2
>>> Fetching submodule roms/edk2/CryptoPkg/Library/OpensslLib/openssl
>>> From https://github.com/openssl/openssl
>>> Could not access submodule 'krb5'
>>> Errors during submodule fetch:
>>>         CryptoPkg/Library/OpensslLib/openssl
>>> Errors during submodule fetch:
>>>         roms/edk2
>>>
>>> Probably harmless, as if one care about this submodule,
>>> will run "make edk2-basetools" which runs 'git submodule
>>> update --init --force' and silently fixes the submodules.
>>>
>>
>> Did you pass the "--recursive" option to the "git submodule" perhaps?
> 
> No I didn't used it.

So what was the precise command? git-am, git-fetch, or something else?...

I'm asking because I've genuinely not seen git attempt to fetch edk2 ->
openssl -> krb, apart from "--recursive".

(Anyway, I don't think I can do anything about the krb5 fetch...)

Thanks!
Laszlo

> 
>>
>> (Because, krb5 is a submodule of edk2's openssl submodule.)
>>
>> "--recursive" should not be used. See "ReadMe.rst" in edk2:
>>
>> """
>> Note: When cloning submodule repos, '--recursive' option is not
>> recommended. EDK II itself will not use any code/feature from
>> submodules in above submodules. So using '--recursive' adds a
>> dependency on being able to reach servers we do not actually want
>> any code from, as well as needlessly downloading code we will not
>> use.
>> """
>>
>> QEMU's current submodules do not require the usage of "--recursive".
>>
>> Thanks
>> Laszlo
>>
> 


