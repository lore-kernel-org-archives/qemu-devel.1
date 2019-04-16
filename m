Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65756C10F13
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 06:24:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EBE32075B
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 06:24:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EBE32075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60039 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGHW5-0001AD-36
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 02:24:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hGHVG-0000rQ-VK
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 02:23:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hGHVG-0003Ck-3a
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 02:23:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57614)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hGHVF-0003CF-Sl
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 02:23:34 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B0E12308793A;
	Tue, 16 Apr 2019 06:23:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-116.ams2.redhat.com
	[10.36.116.116])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 3124F60C43;
	Tue, 16 Apr 2019 06:23:32 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id AF08F1138648; Tue, 16 Apr 2019 08:23:30 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <20190411152520.10061-1-armbru@redhat.com>
	<20190411152520.10061-11-armbru@redhat.com>
	<20190415155306.GN2852@work-vm>
Date: Tue, 16 Apr 2019 08:23:30 +0200
In-Reply-To: <20190415155306.GN2852@work-vm> (David Alan Gilbert's message of
	"Mon, 15 Apr 2019 16:53:07 +0100")
Message-ID: <87tvey79jx.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.45]);
	Tue, 16 Apr 2019 06:23:32 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 10/17] target: Clean up how the dump_mmu()
 print
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
	Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190416062330.OphqMK6BSJXeVTXM9Lwpo7TSXDH9shLuXueLMWWBEoQ@z>

"Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:

> * Markus Armbruster (armbru@redhat.com) wrote:
>> The various dump_mmu() take an fprintf()-like callback and a FILE * to
>> pass to it, and so do their helper functions.  Passing around callback
>> and argument is rather tiresome.
>> 
>> Most dump_mmu() are called only by the target's hmp_info_tlb().  These
>> all pass monitor_printf() cast to fprintf_function and the current
>> monitor cast to FILE *.
>> 
>> SPARC's dump_mmu() gets also called from target/sparc/ldst_helper.c a
>> few times #ifdef DEBUG_MMU.  These calls pass fprintf() and stdout.
>
> You might want to fixup the DPRINTF_MMU in ldst_helper.c to also
> use qemu_printf.

Hmm.  Makes DPRINTF_MMU() consistent with how dump_mmu() prints, but
inconsistent with how the other DPRINTF_*() print.  Dunno...

All that debug code should really be tracepoints of course.

I'll leave DPRINTF_MMU() alone unless a maintainer (cc'ed) wants me to
update it.

>> The type-punning is technically undefined behaviour, but works in
>> practice.  Clean up: drop the callback, and call qemu_printf()
>> instead.
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Thanks!

