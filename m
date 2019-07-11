Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EABAC74A35
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 15:38:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54FB021537
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 15:38:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54FB021537
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlb9m-0000w2-29
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 11:38:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55583)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hlb9Z-0000SY-UH
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 11:38:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hlb9Y-00074x-2o
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 11:38:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35926)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hlb9U-0006rW-EP
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 11:38:34 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 69DC1307D84D;
 Thu, 11 Jul 2019 15:38:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-111.ams2.redhat.com
 [10.36.116.111])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7AD9A60185;
 Thu, 11 Jul 2019 15:38:24 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CAE451138648; Thu, 11 Jul 2019 17:38:22 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Guenter Roeck <linux@roeck-us.net>
References: <20190710220153.GA10826@roeck-us.net>
 <20190711010742.GA810@roeck-us.net>
 <dc31e591-3b22-8626-10b2-48597f56ee0a@redhat.com>
 <11bd13d0-e5c0-76fc-2f75-e01588a9103b@roeck-us.net>
Date: Thu, 11 Jul 2019 17:38:22 +0200
In-Reply-To: <11bd13d0-e5c0-76fc-2f75-e01588a9103b@roeck-us.net> (Guenter
 Roeck's message of "Thu, 11 Jul 2019 06:33:38 -0700")
Message-ID: <874l3swpht.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Thu, 11 Jul 2019 15:38:29 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] Problems building and installing qemu v4.1.0-rc1
 in single step
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
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Guenter Roeck <linux@roeck-us.net> writes:

> Hi,
>
> On 7/11/19 12:48 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>> Hi Guenter,
>>
>> Cc'ing Markus/Dan/Alex
>>
>> On 7/11/19 3:07 AM, Guenter Roeck wrote:
>>> On Wed, Jul 10, 2019 at 03:01:53PM -0700, Guenter Roeck wrote:
>>>> Hi,
>>>>
>>>> when trying to run "make -j30 install" from a clean tree on v4.1.0-rc0=
, I get
>>>> _lots_ of undefined symbol errors.
>>>>
>>>> If I run "make -j30" followed by "make -j30 install", make succeeds, b=
ut then
>>>> I get linker errors such as the following when running "make -j30 inst=
all".
>>
>> Seems similar to this report:
>> https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg01860.html
>>
> Yes, that looks like the same problem.
>
> Reverting the following commits fixes the problem for me.
>
> 8d358a5 Makefile: Fix "make clean" in "unconfigured" source directory
> 	(possibly for context to be able to revert the next patch)
> 1338a4b Makefile: Reuse all's recursion machinery for clean and install

Hmm.

Target install depends on all.

Before commit 1338a4b, the recursion into target directories was in
install's recipe: it ran make install in a for-loop.  This trivially
ensured we run the sub-make install only after completing target all.

Since commit 1338a4b, the target recursion is in the dependencies, just
like for target all.  That's good, but I forgot to add dependencies to
ensure make runs the sub-make install only after completing target all.

Can you try the appended patch for me?  I'm having difficulties
reproducing the bug locally.

[...]

diff --git a/Makefile b/Makefile
index 1fcbaed62c..09b77e8a7b 100644
--- a/Makefile
+++ b/Makefile
@@ -522,6 +522,7 @@ $(ROM_DIRS_RULES):
 recurse-all: $(addsuffix /all, $(TARGET_DIRS) $(ROM_DIRS))
 recurse-clean: $(addsuffix /clean, $(TARGET_DIRS) $(ROM_DIRS))
 recurse-install: $(addsuffix /install, $(TARGET_DIRS))
+$(addsuffix /install, $(TARGET_DIRS)): all
=20
 $(BUILD_DIR)/version.o: $(SRC_PATH)/version.rc config-host.h
 	$(call quiet-command,$(WINDRES) -I$(BUILD_DIR) -o $@ $<,"RC","version.o")

