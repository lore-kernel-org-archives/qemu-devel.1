Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BADE1C3815B
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 08:17:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9030020775
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 08:17:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9030020775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOdF5-0002QS-Lm
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 04:17:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54919)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cfontana@suse.de>) id 1jOdEA-000094-So
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 04:16:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cfontana@suse.de>) id 1jOdE9-000254-IE
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 04:16:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:43204)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cfontana@suse.de>) id 1jOdE9-00023R-CI
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 04:16:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id BE471AD57;
 Wed, 15 Apr 2020 08:16:53 +0000 (UTC)
Subject: Re: [PATCH RESEND v3 0/2] Makefile: libfdt: build only the strict
 necessary
To: David Gibson <david@gibson.dropbear.id.au>
References: <20200411093150.4741-1-cfontana@suse.de>
 <20200414020303.GC48061@umbus.fritz.box>
From: Claudio Fontana <cfontana@suse.de>
Message-ID: <47c51117-133c-9b88-4dec-b56d883f5e8b@suse.de>
Date: Wed, 15 Apr 2020 10:16:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200414020303.GC48061@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
 timestamps) [generic]
X-Received-From: 195.135.220.15
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Philippe Mathieu-Daude <philmd@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Alex Bennee <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/14/20 4:03 AM, David Gibson wrote:
> On Sat, Apr 11, 2020 at 11:31:48AM +0200, Claudio Fontana wrote:
>> v2 -> v3:
>>
>> * changed into a 2 patch series; in the second patch we remove the old
>>   compatibility gunks that were meant for removal some time after 4.1.
>>
>> * renamed the libfdt PHONY rule to dtc/all, with the intent to make
>>   existing working trees forward and backward compatible across the change.
>>
>> v1 -> v2:
>>
>> * fix error generated when running UNCHECKED_GOALS without prior configure,
>>   for example during make docker-image-fedora. Without configure, DSOSUF is
>>   empty, and the module pattern rule in rules.mak that uses this variable
>>   can match too much; provide a default in the Makefile to avoid it.
>>
>> * only attempt to build the archive when there is a non-empty list of objects.
>>   This could be done in general for the %.a: pattern in rules.mak, but maybe
>>   there are valid reasons to build an empty .a?
>>
>> * removed some intermediate variables that did not add much value
>>   (LIBFDT_srcdir, LIBFDT_archive)
>>
>> Tested locally with 3 VPATH configurations (no-, VPATH, VPATH in src subdir),
>> and with docker-image-fedora, docker-test-debug@fedora that failed
>> before.
> 
> Seems reasonable to me.  It's a bit of a shame that we can't use the
> dtc makefiles more simply for this.  But I don't quickly know how to
> fix them upstream to allow that.


Hi David,

I tried to look at dtc upstream makefiles, I don't see a perfect solution at the moment.

I came up with this idea though (not fully tested..) that _could_ work, ie special casing the libfdt target when it is the only goal in MAKECMDGOALS.

Any thoughts?

Ciao,

Claudio


diff --git a/Makefile b/Makefile
index f02aa19..cb256e8 100644
--- a/Makefile
+++ b/Makefile
@@ -176,6 +176,7 @@ endif
 
 
 ifneq ($(DEPTARGETS),)
+ifneq ($(MAKECMDGOALS),libfdt)
 -include $(DTC_OBJS:%.o=%.d)
 -include $(CONVERT_OBJS:%.o=%.d)
 -include $(FDTDUMP_OBJS:%.o=%.d)
@@ -183,6 +184,7 @@ ifneq ($(DEPTARGETS),)
 -include $(FDTPUT_OBJS:%.o=%.d)
 -include $(FDTOVERLAY_OBJS:%.o=%.d)
 endif
+endif
 
 
 
@@ -318,7 +320,9 @@ ifeq ($(NO_PYTHON),0)
 TESTS_PYLIBFDT += maybe_pylibfdt
 endif
 
+ifneq ($(MAKECMDGOALS),libfdt)
 include tests/Makefile.tests
+endif
 
 #
 # Clean rules


> 
>>
>> Claudio Fontana (2):
>>   Makefile: libfdt: build only the strict necessary
>>   Makefile: remove old compatibility gunks
>>
>>  Makefile  | 32 ++++++++++++++++----------------
>>  configure |  6 +-----
>>  rules.mak |  2 ++
>>  3 files changed, 19 insertions(+), 21 deletions(-)
>>
> 


