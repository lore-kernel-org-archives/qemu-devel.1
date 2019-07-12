Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2714C742BD
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 14:07:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA302206B8
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 14:07:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA302206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlwCf-0005SW-3G
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 10:07:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36330)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <quintela@redhat.com>) id 1hlwCU-00054A-IX
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 10:07:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1hlwCT-0004yB-Df
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 10:07:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60802)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1hlwCT-0004wH-5y
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 10:07:01 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C45D8307CDEA;
 Fri, 12 Jul 2019 14:06:58 +0000 (UTC)
Received: from redhat.com (ovpn-117-198.ams2.redhat.com [10.36.117.198])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E62DA5DABA;
 Fri, 12 Jul 2019 14:06:57 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
In-Reply-To: <CAFEAcA8uwgmV47Dt8e=ZRLzssXKWn+1DivDFEuN5s2+N1FJX3w@mail.gmail.com>
 (Peter Maydell's message of "Thu, 11 Jul 2019 13:39:50 +0100")
References: <20190711104412.31233-1-quintela@redhat.com>
 <CAFEAcA8uwgmV47Dt8e=ZRLzssXKWn+1DivDFEuN5s2+N1FJX3w@mail.gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
Date: Fri, 12 Jul 2019 16:06:53 +0200
Message-ID: <878st38hz6.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Fri, 12 Jul 2019 14:06:58 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PULL 00/19] Migration patches
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
Reply-To: quintela@redhat.com
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 kvm-devel <kvm@vger.kernel.org>, QEMU Developers <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> wrote:
> On Thu, 11 Jul 2019 at 11:56, Juan Quintela <quintela@redhat.com> wrote:
>>
>> The following changes since commit 6df2cdf44a82426f7a59dcb03f0dd2181ed7fdfa:
>>
>>   Update version for v4.1.0-rc0 release (2019-07-09 17:21:53 +0100)
>>
>> are available in the Git repository at:
>>
>>   https://github.com/juanquintela/qemu.git tags/migration-pull-request
>>
>> for you to fetch changes up to 0b47e79b3d04f500b6f3490628905ec5884133df:
>>
>>   migration: allow private destination ram with x-ignore-shared
>> (2019-07-11 12:30:40 +0200)
>>
>> ----------------------------------------------------------------
>> Migration pull request
>>
>> ----------------------------------------------------------------
>
> Hi; this fails "make check" on aarch32 host (possibly a general
> 32-bit host issue, as this is the only 32-bit host I test on):
>
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> tests/test-bitmap -m=quick -k --tap < /dev/null |
> ./scripts/tap-driver.pl --test-name="test-bitmap"
> **
> ERROR:/home/peter.maydell/qemu/tests/test-bitmap.c:39:check_bitmap_copy_with_offset:
> assertion failed (bmap1 == bmap2)
> Aborted
> ERROR - Bail out!
> ERROR:/home/peter.maydell/qemu/tests/test-bitmap.c:39:check_bitmap_copy_with_offset:
> assertion failed (bmap1 == bmap2)
> /home/peter.maydell/qemu/tests/Makefile.include:904: recipe for target
> 'check-unit' failed

Problem fixed, the code is right (TM), the test is wrong (also TM).

@@ -35,8 +36,8 @@ static void check_bitmap_copy_with_offset(void)
     /* Shift back 200 bits back */
     bitmap_copy_with_src_offset(bmap2, bmap3, 200, total);
 
-    g_assert_cmpmem(bmap1, total / sizeof(unsigned long),
-                    bmap2, total / sizeof(unsigned long));
+    g_assert_cmpmem(bmap1, total / BITS_PER_LONG,
+                    bmap2, total / BITS_PER_LONG);
 
     bitmap_clear(bmap1, 0, BMAP_SIZE);
     /* Set bits in bmap1 are 100-245 */


A long has 32 or 64 bits, not 4 or 8.

And why it worked in 64 bit?  Due to (bad?) luck.  64 bit is bigger, and
then it "overwrote" everypthing, and then it ends being zero on
destination by luck.

Resending.

Later, Juan.

