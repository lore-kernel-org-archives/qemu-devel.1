Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6487BC10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 18:27:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3375420818
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 18:27:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3375420818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41057 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hF0tp-0007jo-HM
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 14:27:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hF0rn-0006BB-4j
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 14:25:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hF0rk-0005KK-VY
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 14:25:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49248)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hF0rf-0005Ds-GT
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 14:25:29 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 11D2E81224
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 18:25:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-116.ams2.redhat.com
	[10.36.116.116])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 2282E1001E85;
	Fri, 12 Apr 2019 18:25:18 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id AD7781138648; Fri, 12 Apr 2019 20:25:16 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <20190411152520.10061-1-armbru@redhat.com>
	<20190411152520.10061-9-armbru@redhat.com>
	<20190412174441.GM2906@work-vm>
Date: Fri, 12 Apr 2019 20:25:16 +0200
In-Reply-To: <20190412174441.GM2906@work-vm> (David Alan Gilbert's message of
	"Fri, 12 Apr 2019 18:44:42 +0100")
Message-ID: <878swfjd2r.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.25]);
	Fri, 12 Apr 2019 18:25:20 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 08/17] memory: Clean up how mtree_info()
 prints
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
Message-ID: <20190412182516.y4CeKsdwlNfoQvR-8_tHyg-IXXURnYqvY4_yUEjhURk@z>

"Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:

> * Markus Armbruster (armbru@redhat.com) wrote:
>> dump_drift_info() takes an fprintf()-like callback and a FILE * to
>
> ^^^^^^^^^^^^^^^^^^^ looks like the wrong function for this patch?

Pasto, will fix.

>> pass to it, and so do its helper functions.  Passing around callback
>> and argument is rather tiresome.
>> 
>> Its only caller hmp_info_mtree() passes monitor_printf() cast to
>> fprintf_function and the current monitor cast to FILE *.
>> 
>> The type-punning is technically undefined behaviour, but works in
>> practice.  Clean up: drop the callback, and call qemu_printf()
>> instead.
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>
> Other than the function name above,
>
>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Thanks!

