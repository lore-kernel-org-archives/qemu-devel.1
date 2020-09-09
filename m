Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F15DEC10DAA
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 14:37:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9224D22261
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 14:37:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9224D22261
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG1Dw-0006Pe-Jo
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 10:37:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54020)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1kG1D6-00054A-90
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 10:36:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:42640)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1kG1D4-0006Hc-HH
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 10:36:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 1237DB2F0;
 Wed,  9 Sep 2020 14:36:45 +0000 (UTC)
Subject: Re: Meson can't recover from deletion of generated QAPI file(s)
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
References: <87pn6vw2he.fsf@dusky.pond.sub.org>
 <ff7ef6e4-254a-b171-22bf-c5cca4945160@redhat.com>
 <26432e3f-2b22-4966-ebea-8be448636fbb@suse.de>
 <2d49cdbb-41e2-ae1d-79cd-3a05678e9b87@redhat.com>
From: Claudio Fontana <cfontana@suse.de>
Message-ID: <a443d9fe-d831-c7f2-5300-7f1d8660c81f@suse.de>
Date: Wed, 9 Sep 2020 16:36:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <2d49cdbb-41e2-ae1d-79cd-3a05678e9b87@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=195.135.220.15; envelope-from=cfontana@suse.de;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 00:22:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic]
X-Spam_score_int: -77
X-Spam_score: -7.8
X-Spam_bar: -------
X-Spam_report: (-7.8 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-3.576,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/9/20 4:35 PM, Paolo Bonzini wrote:
> On 09/09/20 15:35, Claudio Fontana wrote:
>> On 9/9/20 3:06 PM, Philippe Mathieu-Daudé wrote:
>>> Maybe related:
>>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg736135.html
>>> and later:
>>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg738777.html
>>>
>>
>> My use case is this:
> 
> Hi Claudio,
> 
> unlike Markus's, your issue is a genuine meson.build bug.  It should be
> fixed like so:
> 
> diff --git a/tests/meson.build b/tests/meson.build
> index 998e4c48f9..721641afbb 100644
> --- a/tests/meson.build
> +++ b/tests/meson.build
> @@ -223,7 +223,7 @@ foreach test_name, extra: tests
>      src += test_ss.all_sources()
>      deps += test_ss.all_dependencies()
>    endif
> -  exe = executable(test_name, src, dependencies: deps)
> +  exe = executable(test_name, src, genh, dependencies: deps)
> 
>    test(test_name, exe,
>         depends: test_deps.get(test_name, []),
> 
> 
> Paolo
> 

Will test right away, thanks!

C

