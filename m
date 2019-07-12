Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 847EDC742B2
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 11:13:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 583EE20863
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 11:13:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 583EE20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hltUa-0005tv-7M
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 07:13:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45709)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hltUP-0005VV-SW
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 07:13:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hltUO-0003kD-Vl
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 07:13:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60528)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hltUO-0003iS-Pe
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 07:13:20 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CCBEB81F12;
 Fri, 12 Jul 2019 11:13:19 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-111.ams2.redhat.com
 [10.36.116.111])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9A9FD5C26D;
 Fri, 12 Jul 2019 11:13:19 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0C2861138648; Fri, 12 Jul 2019 13:13:17 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
References: <20190711122827.18970-1-armbru@redhat.com>
 <20190711122827.18970-2-armbru@redhat.com>
 <e5139329-82e3-26dc-b72a-136f8a9c1cc0@linaro.org>
Date: Fri, 12 Jul 2019 13:13:16 +0200
In-Reply-To: <e5139329-82e3-26dc-b72a-136f8a9c1cc0@linaro.org> (Richard
 Henderson's message of "Thu, 11 Jul 2019 18:56:30 +0200")
Message-ID: <87muhjecab.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Fri, 12 Jul 2019 11:13:19 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH RFC v5 1/3] tests: New make target
 check-source
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Richard Henderson <richard.henderson@linaro.org> writes:

> On 7/11/19 2:28 PM, Markus Armbruster wrote:
>>  include/exec/cpu_ldst_template.h          |  3 +
>>  include/exec/cpu_ldst_useronly_template.h |  3 +
>>  include/exec/cputlb.h                     |  3 +
>>  include/exec/exec-all.h                   |  3 +
>>  include/exec/gen-icount.h                 |  2 +
>>  include/exec/helper-gen.h                 |  2 +
>>  include/exec/helper-proto.h               |  2 +
>>  include/exec/helper-tcg.h                 |  2 +
>>  include/exec/ioport.h                     |  2 +
>>  include/exec/memory-internal.h            |  2 +
>>  include/exec/memory_ldst.inc.h            |  2 +
>>  include/exec/memory_ldst_cached.inc.h     |  2 +
>>  include/exec/memory_ldst_phys.inc.h       |  2 +
>
> The pattern used should not match all *.h, but exclude *_template.h (older
> naming style) and *.inc.h (newer naming style; we really should finish the
> conversion).
>
> These headers are not standalone, and will be included multiple times by one of
> the other headers.

Yes.

I excluded them the stupid way in this RFC, in part because I was unsure
about the naming convention for "special .h meant to be included
multiple times".  My cover letter should have mentioned this under
"Known issues".

For my series to shed the RFC tag, I need to eliminate the FIXMEs in
headers that aren't actually broken.  This includes the FIXMEs marking
"special .h meant to be included multiple times".

Perhaps I can finish the conversion to the .inc.h convention in v6.

