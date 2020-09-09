Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B5FC43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 21:26:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDF7920BED
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 21:26:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDF7920BED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG7bd-0002Xp-2j
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 17:26:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36984)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1kG7af-0001wz-7i
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 17:25:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:39870)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1kG7ac-00030K-Q9
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 17:25:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id C7B62AFBF;
 Wed,  9 Sep 2020 21:25:25 +0000 (UTC)
Subject: Re: Meson can't recover from deletion of generated QAPI file(s)
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
References: <87pn6vw2he.fsf@dusky.pond.sub.org>
 <ff7ef6e4-254a-b171-22bf-c5cca4945160@redhat.com>
 <26432e3f-2b22-4966-ebea-8be448636fbb@suse.de>
 <2d49cdbb-41e2-ae1d-79cd-3a05678e9b87@redhat.com>
 <a443d9fe-d831-c7f2-5300-7f1d8660c81f@suse.de>
 <0b2617b8-10dd-d487-cfa0-67b646c72ac0@suse.de>
 <25206eb0-8f06-5f38-0cfd-f92e65494eb9@redhat.com>
From: Claudio Fontana <cfontana@suse.de>
Message-ID: <8e1bdcd7-a060-1a22-e2eb-622648560f80@suse.de>
Date: Wed, 9 Sep 2020 23:25:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <25206eb0-8f06-5f38-0cfd-f92e65494eb9@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/9/20 5:10 PM, Paolo Bonzini wrote:
> On 09/09/20 17:05, Claudio Fontana wrote:
>> Hmm, I still encounter problems:
> 
> And another:
> 
> diff --git a/tests/meson.build b/tests/meson.build
> index 998e4c48f9..95789f43b3 100644
> --- a/tests/meson.build
> +++ b/tests/meson.build
> @@ -56,7 +56,7 @@ test_qapi_files = custom_target('Test QAPI files',
>  # perhaps change qapi_gen to replace / with _, like Meson itself does?
>  subdir('include')
>  
> -libtestqapi = static_library('testqapi', sources: [test_qapi_files, test_qapi_outputs_extra])
> +libtestqapi = static_library('testqapi', sources: [test_qapi_files, genh, test_qapi_outputs_extra])
>  testqapi = declare_dependency(link_with: libtestqapi)
>  
>  testblock = declare_dependency(dependencies: [block], sources: 'iothread.c')
> 
> Paolo
> 

adding this one as well fixes it for me, thanks!

Tested-by: Claudio Fontana <cfontana@suse.de>


