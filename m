Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62B42C10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 19:48:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE0252070D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 19:48:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE0252070D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54019 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEfgA-0007cg-VC
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 15:48:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59608)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hEffA-0007El-99
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 15:47:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hEff9-0001i4-Bc
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 15:47:08 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:60001)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>)
	id 1hEff8-0001h2-SI; Thu, 11 Apr 2019 15:47:07 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
	(mreue010 [213.165.67.103]) with ESMTPSA (Nemesis) id
	1M4K6z-1hEOXs1pTt-000OvG; Thu, 11 Apr 2019 21:47:01 +0200
To: Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
	qemu-devel@nongnu.org
References: <20190313162812.8885-1-armbru@redhat.com>
	<8cd63797-76f6-9ba8-0113-13a4bf04e6ed@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <9585a1fc-fc7c-d3f4-06be-46d1a544a0ce@vivier.eu>
Date: Thu, 11 Apr 2019 21:46:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <8cd63797-76f6-9ba8-0113-13a4bf04e6ed@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:BsLtIAyNBcvpkz0AYDgdIQuMWkHGIaA34Ha9Is1vN4UrNPMPdec
	Qzxu+CcMoWehvY3NEN0GgrQ+EwltCm8vpgeHGYDwkdRgXTdeMC3ZbtcKRPoqm54pzPnLhiP
	GOWZzKx+8uVayCm+9NACbUTZRbVXQ3B/UKHncNHqNBSk6gofkhUO0t71uY5R27WqmoGu/Gb
	OhTz3eqTvM6s1X43Z6+7w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EPUUrfK9nQw=:SlXxgXllZLsU09YiH9DPRv
	B53iyGKKkNr/7tyntouA2JAhyzgC9+CzE3du5RPTxdkJ5SEEbZGHD/yqrJkxX5MhJjD4e9oAv
	zF8HEitLAZF34XEggMTHmqWxt6A7RhnB0RI/jsla7K1qKyFvXNGC+a+CTs6ExUulAjO5Vt9uL
	hH/GURcH6L4wB0APzR5oeXHO36MmX4DOUlYwWXGS/iXbDHz6OQz4WIyu43fx4ks1i07jilCmI
	2ZkZ6Z+Maem2GDdWX1q9YGh46wNiRGZeukXWxzQc+FIkCdQXziI4URYYOTKgsSNzar2/prCxm
	ceroTzXvnaNE+yHXFlb2992CHPfHisIwlQWCpTABCX8L8se0h0Lgv70aIf1yrMkScSWkbmmPI
	2RqTGSD42FijU+nogV0tjLrg367NherGV81Mq1S68H4qcitbQ9SP4cH/f5d5M67u0/7NTIDrQ
	NHp6FVIM+SeoZGuWDQeYy5VO2hJV2i/zsiS1+qjqlvolzocd+sSTUP0YFRoEqZ0VvvBCZ1E55
	2X3ARRY0d9lbrwqZHyppOBlQQQ1sTX15QRfFov6iEC51ba71Xy1zzI89wGEY8Do6WJgnBls+Q
	VEjfMx6Ou+kX4n+UVE7miNUVHmbo5pT0jrgDkV1GmlxvbZd9Y6VJ7mimZ1gWIrLuV1zki1xtT
	kbIF0RtTfI+hvuvbI8XFSE4cmaEk0WRknf/j4FZrMFYAC5b75gAsYaAtnLkFzX7+y1rb72dVT
	D8OeQlmqmkTuJrXlpVjl3U0S04ACbHnBwUAAs/CFOfpqavjWt3zx9RU4cQk=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.134
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] Clean up includes
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: lvivier@redhat.com, peter.maydell@linaro.org, ehabkost@redhat.com,
	viktor.prutyanov@phystech.edu,
	QEMU Trivial <qemu-trivial@nongnu.org>, kraxel@redhat.com,
	alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190411194659.pqLeFO-OgRMd5Iof0vN99HJOf6wyFN7Y5AVevuUYv_g@z>

On 21/03/2019 10:21, Thomas Huth wrote:
> On 13/03/2019 17.28, Markus Armbruster wrote:
>> Clean up includes so that osdep.h is included first and headers
>> which it implies are not included manually.
>>
>> This commit was created with scripts/clean-includes, with the changes
>> to the following files manually reverted:
>>
>>     contrib/libvhost-user/libvhost-user-glib.h
>>     contrib/libvhost-user/libvhost-user.c
>>     contrib/libvhost-user/libvhost-user.h
>>     linux-user/mips64/cpu_loop.c
>>     linux-user/mips64/signal.c
>>     linux-user/sparc64/cpu_loop.c
>>     linux-user/sparc64/signal.c
>>     linux-user/x86_64/cpu_loop.c
>>     linux-user/x86_64/signal.c
>>     slirp/src/*
>>     target/s390x/gen-features.c
>>     tests/migration/s390x/a-b-bios.c
>>     tests/test-rcu-simpleq.c
>>     tests/test-rcu-tailq.c
>>     tests/uefi-test-tools/UefiTestToolsPkg/BiosTablesTest/BiosTablesTest.c
>>
>> We're in the process of spinning out slirp/.  tests/uefi-test-tools/
>> is guest software.  The remaining reverts are the same as in commit
>> b7d89466dde.
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  contrib/elf2dmp/main.c   | 3 +--
>>  contrib/elf2dmp/pdb.c    | 3 +--
>>  hw/display/ati.c         | 1 +
>>  hw/display/ati_2d.c      | 1 +
>>  hw/display/ati_dbg.c     | 1 +
>>  hw/display/ati_int.h     | 1 -
>>  include/hw/cpu/cluster.h | 1 -
>>  tests/fp/platform.h      | 1 -
>>  tests/libqos/qgraph.h    | 4 ----
>>  tests/qos-test.c         | 2 +-
>>  10 files changed, 6 insertions(+), 12 deletions(-)
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 


Applied to my trivial-patches branch.

Thanks,
Laurent

