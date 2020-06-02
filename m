Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C37F8C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 15:56:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98F6520674
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 15:56:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98F6520674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jg9HV-0000wP-Qn
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 11:56:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57176)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jg9GK-0008Du-8E; Tue, 02 Jun 2020 11:55:36 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:40121)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jg9GJ-00013f-0r; Tue, 02 Jun 2020 11:55:35 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue009 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MiagR-1j1I8V0rmZ-00flng; Tue, 02 Jun 2020 17:55:20 +0200
Subject: Re: [PATCH v4 00/13] user-mode: Prune build dependencies (part 1)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200522172510.25784-1-philmd@redhat.com>
 <71ea2e86-11e7-277c-9757-d4fc282e0787@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <d3ced536-b3f1-c0f4-eee1-6f3b5e9c9206@vivier.eu>
Date: Tue, 2 Jun 2020 17:55:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <71ea2e86-11e7-277c-9757-d4fc282e0787@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Lu+H7kcXfS98szxgFVP/gvKkGjcdYi4aubKh6+D+JPOlP4FNVY+
 DovcO4UebOvbqCwQOthjELN765Gy0QDSTdjLa2YLI6fhGs8JhxISwO9zOPlBzNQnsyJ6JnD
 imJZqUFjNwb/BuENimRz1YZd59KeVqlDH2/tHnsh+Ig7bgolhY9HRqs2o/eRjnEiJpvjGP1
 elCPnGAyov2knm2XkuMJw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:urNGIvAfpiA=:Hru6RMoaXBTCTAhRd0GhLt
 x40BLsy7B65kRZ/DlNEr3FridY9zl4evSaAh2EobYJ043YVfT4iBBGv/mSxFk6BI1ui1I38JW
 MFEsO+oxHRL73eh8TkQp3lTAt2HZ+jejF+epynDMQfHp3UUThIk3BWbZsYlN2EjCTYcghsnVW
 wnJGvBPqA6D3mksRZrwyStqdR/LokZkb7UGb0EQYsk0DcP5rbXa744XdVs+O0rI5lDbjyP2Iw
 v8jw45Nm/JKqdve+oLjhiW7aFZ6tCrT16Mxkqg6mSS7b9JejKvUYyYk9dga5Gn6Ij+1aChoQu
 Xjc+zDzPpTryFWBGu3KIPZ+D398YLeHbDqpkeXO1H/XJVNKu48TzibGt2jPnhtEUqqsuCPLCI
 LSLohZQZ4TifhuIKlwclOZML959Nb7cfS/mEi/0tHrXFSb9v1iYr6qOwBwOgsTPSehOQFPQ0k
 D9FYbGc4UGtZ5i5FVQ6pshpplkYJWvjMlMGyW1cA75QaJ/oGC6mhFuwYLiwqkkRIHCwERSDdX
 fyNyavR2j3x1d7QJXWHw0UXimQgHH+sZVSBi5cCFvQQ8W5FT2Ab29AYYrR2vFcYDenuCj+s3W
 QyYhk9clCtBxVGF/LiUujCLUsrcWarpcBdeafPQZvwpBHwKHlDQ2v/p5TM9hzNepUYBpVmz1i
 MM8hzqXUwCZqREC+pnQcVBAE7rid+gtELCaFXGZJeuyv9o2D+M9E56eR3RvCz+d/h0kk5Ga1T
 cs9MnVohwPcDyGK9AGJMl086cgY/SriLBtjiOyysDroBjPYJn9uukkQkgfpIcxr349H95HFWm
 ZUT5jbcuWg3IyYzb/dDNp4AYbr6NbvYtGDlocez4KEQmXhYKYZsc5+Th0fOR0V9rZZztAK6
Received-SPF: none client-ip=212.227.126.130; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/02 11:55:33
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-riscv@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 02/06/2020 à 16:46, Philippe Mathieu-Daudé a écrit :
> This series is now fully reviewed.
> 
> Laurent, as Paolo's misc-tree is already full, can it go via your
> linux-user tree (as it improve linux-user at the end)?

OK, I add the series to my queue. I plan to do a linux-user PR soon.

Thanks,
Laurent

> Thanks,
> 
> Phil.
> 
> On 5/22/20 7:24 PM, Philippe Mathieu-Daudé wrote:
>> This is the first part of a series reducing user-mode
>> dependencies. By stripping out unused code, the build
>> and testing time is reduced (as is space used by objects).
>>
>> Part 1 (generic):
>> - reduce user-mode object list
>> - remove some migration code from user-mode
>> - remove cpu_get_crash_info()
>>
> [...]
>>
>> Philippe Mathieu-Daudé (13):
>>   Makefile: Only build virtiofsd if system-mode is enabled
>>   configure: Avoid building TCG when not needed
>>   tests/Makefile: Only display TCG-related tests when TCG is available
>>   tests/Makefile: Restrict some softmmu-only tests
>>   util/Makefile: Reduce the user-mode object list
>>   stubs/Makefile: Reduce the user-mode object list
>>   target/riscv/cpu: Restrict CPU migration to system-mode
>>   exec: Assert CPU migration is not used on user-only build
>>   arch_init: Remove unused 'qapi-commands-misc.h' include
>>   target/i386: Restrict CpuClass::get_crash_info() to system-mode
>>   target/s390x: Restrict CpuClass::get_crash_info() to system-mode
>>   hw/core: Restrict CpuClass::get_crash_info() to system-mode
>>   stubs: Restrict ui/win32-kbd-hook to system-mode
> 


