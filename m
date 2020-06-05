Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E31A0C433E2
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 14:41:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B36ED206DC
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 14:41:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FVwnpFri"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B36ED206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhDXR-0002Vv-0l
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 10:41:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48916)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jhDWQ-0001AF-99
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 10:40:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55191
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jhDWP-0003hH-EO
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 10:40:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591368036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=JB0NYH5yFroXvb17zxsw58lLnYSX7v59jZ8xc5Fn0ms=;
 b=FVwnpFriMo/YdGSMNRgeIVE37jhBT1XeEt7CKy6Ss9LcQ7vo4YIE1fYTzzQ1EdWEU7yjO3
 +gEMgFR4o1scg2truArL28dm/elRYn5AK09JFFcI67CPNPbZrpQ6SDgdM8J0eiJrL0CsBS
 X+AS3w8wQfMkTXXuJEf0hBMQSIjJB0k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-513-JpH_WLOdPSqvGcLl3_WBAw-1; Fri, 05 Jun 2020 10:40:31 -0400
X-MC-Unique: JpH_WLOdPSqvGcLl3_WBAw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B1758107ACCA;
 Fri,  5 Jun 2020 14:40:30 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-70.ams2.redhat.com [10.36.112.70])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7D2C35C663;
 Fri,  5 Jun 2020 14:40:29 +0000 (UTC)
Subject: Re: [PATCH] configure: Disable -Wtautological-type-limit-compare
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200604034513.75103-1-richard.henderson@linaro.org>
 <f5bc0532-e731-b56f-df7f-55da2585e955@redhat.com>
 <8bee167c-098c-a298-cd05-ffd753dbd934@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <51412778-5b6d-f080-c62b-eda42d9f52cc@redhat.com>
Date: Fri, 5 Jun 2020 16:40:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <8bee167c-098c-a298-cd05-ffd753dbd934@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 03:07:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 05/06/2020 14.51, Philippe Mathieu-Daudé wrote:
> On 6/4/20 8:11 AM, Philippe Mathieu-Daudé wrote:
>> On 6/4/20 5:45 AM, Richard Henderson wrote:
>>> Clang 10 enables this by default with -Wtype-limit.
>>>
>>> All of the instances flagged by this Werror so far have been
>>> cases in which we really do want the compiler to optimize away
>>> the test completely.  Disabling the warning will avoid having
>>> to add ifdefs to work around this.
>>>
>>
>> Fixes: https://bugs.launchpad.net/qemu/+bug/1878628
>>
>> Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> 
> Clarifying: I tested with clang-10, but Alex/Cornelia reported on IRC
> the failure persist with clang-9 until using --disabler-werror.

Does -Wno-tautological-constant-compare help on Clang-9 instead?

 Thomas


>>
>> I dare to add:
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>>
>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>> ---
>>>  configure | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/configure b/configure
>>> index f087d2bcd1..693f01327f 100755
>>> --- a/configure
>>> +++ b/configure
>>> @@ -2009,6 +2009,8 @@ gcc_flags="-Wno-missing-include-dirs -Wempty-body -Wnested-externs $gcc_flags"
>>>  gcc_flags="-Wendif-labels -Wno-shift-negative-value $gcc_flags"
>>>  gcc_flags="-Wno-initializer-overrides -Wexpansion-to-defined $gcc_flags"
>>>  gcc_flags="-Wno-string-plus-int -Wno-typedef-redefinition $gcc_flags"
>>> +gcc_flags="$gcc_flags -Wno-tautological-type-limit-compare"
>>> +
>>>  # Note that we do not add -Werror to gcc_flags here, because that would
>>>  # enable it for all configure tests. If a configure test failed due
>>>  # to -Werror this would just silently disable some features,
>>>
>>
> 
> 


