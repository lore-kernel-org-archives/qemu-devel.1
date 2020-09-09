Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 352C2C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 10:57:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94E3A21582
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 10:57:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94E3A21582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFxmj-0002CB-HK
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 06:57:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49760)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1kFxmF-0001nN-F2
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 06:56:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:58556)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1kFxmD-0001MZ-Bs
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 06:56:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 959E1AEF8;
 Wed,  9 Sep 2020 10:56:32 +0000 (UTC)
Subject: Re: meson build failure, configure without tcg, fixed by running make
 again
From: Claudio Fontana <cfontana@suse.de>
To: Paolo Bonzini <pbonzini@redhat.com>
References: <c9971e27-fded-3e5d-d489-b1fb539b8ec1@suse.de>
 <41c09bb2-1704-47c0-9638-9f1eff010e8c@redhat.com>
 <462d6cfa-f4ba-d001-200b-9fc017f7e2fc@suse.de>
Message-ID: <3981cd71-deaf-b939-d6fa-09b9b3b94521@suse.de>
Date: Wed, 9 Sep 2020 12:56:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <462d6cfa-f4ba-d001-200b-9fc017f7e2fc@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=195.135.220.15; envelope-from=cfontana@suse.de;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 00:22:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic]
X-Spam_score_int: -57
X-Spam_score: -5.8
X-Spam_bar: -----
X-Spam_report: (-5.8 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.626,
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
Cc: qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/2/20 3:02 PM, Claudio Fontana wrote:
> On 9/2/20 12:27 PM, Paolo Bonzini wrote:
>> On 02/09/20 12:03, Claudio Fontana wrote:
>>> Hi Paolo,
>>>
>>> there seems to be some parallelism or race condition somewhere?
>>>
>>> with master, commit 8d90bfc5c31ad60f6049dd39be636b06bc00b652
>>> I am doing:
>>>
>>> mkdir build-nontcg
>>> cd build-nontcg
>>> ../configure --disable-tcg --enable-kvm --enable-hax
>>> make -j120
>>> make -j120 check
>>>
>>> I am getting:
>>
>> Yes:
>>
>> diff --git a/tests/qtest/libqos/meson.build b/tests/qtest/libqos/meson.build
>> index 19931b9248..268ea23803 100644
>> --- a/tests/qtest/libqos/meson.build
>> +++ b/tests/qtest/libqos/meson.build
>> @@ -52,6 +52,6 @@ libqos = static_library('qos',
>>          'arm-xilinx-zynq-a9-machine.c',
>>          'ppc64_pseries-machine.c',
>>          'x86_64_pc-machine.c',
>> -), build_by_default: false)
>> +) + genh, build_by_default: false)
>>  
>>  qos = declare_dependency(link_whole: libqos)
>>
>> Paolo
>>
> 
> Hi Paolo,
> 
> this one worked for me just fine, I did not try your latest patch which is a bit different.
> 
> Ciao,
> 
> Claudio
> 

Hi Paolo,

a heads-up on this: while the diff above worked for me just fine, your latest patch committed to master does _not_ solve the issue for me.
Same errors as before during parallel builds with large number of cpus.

I replaced the solution currently in master with the meson.build as per the diff above, but still I got problems:

In file included from tests/test-qapi-events-sub-sub-module.c:16:0:
tests/test-qapi-visit-sub-sub-module.h:16:10: fatal error: qapi/qapi-builtin-visit.h: No such file or directory
 #include "qapi/qapi-builtin-visit.h"
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
In file included from tests/include/test-qapi-events-sub-module.c:16:0:
tests/include/test-qapi-visit-sub-module.h:16:10: fatal error: qapi/qapi-builtin-visit.h: No such file or directory
 #include "qapi/qapi-builtin-visit.h"
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
compilation terminated.
In file included from tests/test-qapi-visit-sub-sub-module.c:16:0:
tests/test-qapi-visit-sub-sub-module.h:16:10: fatal error: qapi/qapi-builtin-visit.h: No such file or directory
 #include "qapi/qapi-builtin-visit.h"
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
In file included from tests/include/test-qapi-visit-sub-module.c:16:0:
tests/include/test-qapi-visit-sub-module.h:16:10: fatal error: qapi/qapi-builtin-visit.h: No such file or directory
 #include "qapi/qapi-builtin-visit.h"
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
tests/qapi-builtin-visit.c:15:10: fatal error: qapi/qapi-builtin-visit.h: No such file or directory
 #include "qapi/qapi-builtin-visit.h"
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
In file included from tests/test-qapi-commands-sub-sub-module.c:20:0:
tests/test-qapi-visit-sub-sub-module.h:16:10: fatal error: qapi/qapi-builtin-visit.h: No such file or directory
 #include "qapi/qapi-builtin-visit.h"
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
In file included from tests/include/test-qapi-types-sub-module.c:16:0:
tests/include/test-qapi-visit-sub-module.h:16:10: fatal error: qapi/qapi-builtin-visit.h: No such file or directory
 #include "qapi/qapi-builtin-visit.h"
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
tests/qapi-builtin-types.c:16:10: fatal error: qapi/qapi-builtin-visit.h: No such file or directory
 #include "qapi/qapi-builtin-visit.h"
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
In file included from tests/test-qapi-events.c:16:0:
tests/test-qapi-visit.h:16:10: fatal error: qapi/qapi-builtin-visit.h: No such file or directory
 #include "qapi/qapi-builtin-visit.h"
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
In file included from tests/test-qapi-types-sub-sub-module.c:16:0:
tests/test-qapi-visit-sub-sub-module.h:16:10: fatal error: qapi/qapi-builtin-visit.h: No such file or directory
 #include "qapi/qapi-builtin-visit.h"
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make: *** [Makefile.ninja:1760: tests/libtestqapi.a.p/meson-generated_.._qapi-builtin-types.c.o] Error 1
make: *** Waiting for unfinished jobs....
make: *** [Makefile.ninja:1761: tests/libtestqapi.a.p/meson-generated_.._qapi-builtin-visit.c.o] Error 1
make: *** [Makefile.ninja:1762: tests/libtestqapi.a.p/meson-generated_.._test-qapi-commands-sub-sub-module.c.o] Error 1
make: *** [Makefile.ninja:1765: tests/libtestqapi.a.p/meson-generated_.._test-qapi-events-sub-sub-module.c.o] Error 1
make: *** [Makefile.ninja:1766: tests/libtestqapi.a.p/meson-generated_.._test-qapi-events.c.o] Error 1
make: *** [Makefile.ninja:1771: tests/libtestqapi.a.p/meson-generated_.._test-qapi-visit-sub-sub-module.c.o] Error 1
make: *** [Makefile.ninja:1774: tests/libtestqapi.a.p/meson-generated_.._include_test-qapi-events-sub-module.c.o] Error 1
make: *** [Makefile.ninja:1775: tests/libtestqapi.a.p/meson-generated_.._include_test-qapi-types-sub-module.c.o] Error 1
make: *** [Makefile.ninja:1776: tests/libtestqapi.a.p/meson-generated_.._include_test-qapi-visit-sub-module.c.o] Error 1
make: *** [Makefile.ninja:1769: tests/libtestqapi.a.p/meson-generated_.._test-qapi-types-sub-sub-module.c.o] Error 1
In file included from tests/test-qapi-types.c:16:0:
tests/test-qapi-visit.h:16:10: fatal error: qapi/qapi-builtin-visit.h: No such file or directory
 #include "qapi/qapi-builtin-visit.h"
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
In file included from tests/test-qapi-visit.c:16:0:
tests/test-qapi-visit.h:16:10: fatal error: qapi/qapi-builtin-visit.h: No such file or directory
 #include "qapi/qapi-builtin-visit.h"
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
In file included from tests/test-qapi-commands.c:20:0:
tests/test-qapi-visit.h:16:10: fatal error: qapi/qapi-builtin-visit.h: No such file or directory
 #include "qapi/qapi-builtin-visit.h"
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make: *** [Makefile.ninja:1772: tests/libtestqapi.a.p/meson-generated_.._test-qapi-visit.c.o] Error 1
make: *** [Makefile.ninja:1770: tests/libtestqapi.a.p/meson-generated_.._test-qapi-types.c.o] Error 1
In file included from tests/include/test-qapi-commands-sub-module.c:20:0:
tests/include/test-qapi-visit-sub-module.h:16:10: fatal error: qapi/qapi-builtin-visit.h: No such file or directory
 #include "qapi/qapi-builtin-visit.h"
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make: *** [Makefile.ninja:1763: tests/libtestqapi.a.p/meson-generated_.._test-qapi-commands.c.o] Error 1
make: *** [Makefile.ninja:1773: tests/libtestqapi.a.p/meson-generated_.._include_test-qapi-commands-sub-module.c.o] Error 1


Thanks!

Claudio




