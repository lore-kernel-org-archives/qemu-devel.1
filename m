Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C10C10F13
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 06:33:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 086EC2073F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 06:33:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 086EC2073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60129 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGHex-0002Q0-4X
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 02:33:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hGHdu-000267-VL
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 02:32:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hGHdu-0008Mp-47
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 02:32:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44408)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hGHdt-0008Lm-Sf
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 02:32:30 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CC9F33078AAC
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 06:32:28 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-116.ams2.redhat.com
	[10.36.116.116])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 95F5F1001E84;
	Tue, 16 Apr 2019 06:32:28 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 020BE1138648; Tue, 16 Apr 2019 08:32:26 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <20190411152520.10061-1-armbru@redhat.com>
	<20190411152520.10061-15-armbru@redhat.com>
	<20190415164744.GO2852@work-vm>
Date: Tue, 16 Apr 2019 08:32:26 +0200
In-Reply-To: <20190415164744.GO2852@work-vm> (David Alan Gilbert's message of
	"Mon, 15 Apr 2019 17:47:46 +0100")
Message-ID: <87o9567951.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.48]);
	Tue, 16 Apr 2019 06:32:28 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 14/17] qom/cpu: Simplify how
 CPUClass:cpu_dump_state() prints
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190416063226.JymgvEhNTMGr_Di3jEeQpmFvREF_r1z4yc39PdgWN0E@z>

"Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:

> * Markus Armbruster (armbru@redhat.com) wrote:
>> CPUClass method dump_statistics() takes an fprintf()-like callback and
>> a FILE * to pass to it.  Most callers pass fprintf() and stderr.
>> log_cpu_state() passes fprintf() and qemu_log_file.
>> hmp_info_registers() passes monitor_fprintf() and the current monitor
>> cast to FILE *.  monitor_fprintf() casts it right back, and is
>> otherwise identical to monitor_printf().
>> 
>> The callback gets passed around a lot, which is tiresome.  The
>> type-punning around monitor_fprintf() is ugly.
>> 
>> Drop the callback, and call qemu_fprintf() instead.  Also gets rid of
>> the type-punning, since qemu_fprintf() takes NULL instead of the
>> current monitor cast to FILE *.
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>
> <phew long patch>
> Yes, I think so.

Thanks for persevering!

> There seems to be a place which changes hmp_info_local_apic in a plce
> that was changed in an earlier patch which seems a shame, but OK.

Hmm.  I think I can avoid that.

> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Thanks!

