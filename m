Return-Path: <SRS0=gZkW=SM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A4BC10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 05:09:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDC3D2084B
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 05:09:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDC3D2084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53580 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hE5UI-00072f-1d
	for qemu-devel@archiver.kernel.org; Wed, 10 Apr 2019 01:09:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46608)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hE5TT-0006lY-JX
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 01:08:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hE5TS-0000dU-OI
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 01:08:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40328)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hE5TS-0000d9-Gf
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 01:08:38 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 96F2E821D8
	for <qemu-devel@nongnu.org>; Wed, 10 Apr 2019 05:08:37 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-116.ams2.redhat.com
	[10.36.116.116])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 653C7608A7;
	Wed, 10 Apr 2019 05:08:37 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id E054C1138648; Wed, 10 Apr 2019 07:08:35 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <20190408083627.7479-1-armbru@redhat.com>
	<20190408083627.7479-13-armbru@redhat.com>
	<20190409180028.GE2964@work-vm>
Date: Wed, 10 Apr 2019 07:08:35 +0200
In-Reply-To: <20190409180028.GE2964@work-vm> (David Alan Gilbert's message of
	"Tue, 9 Apr 2019 19:00:29 +0100")
Message-ID: <87h8b64fcc.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.28]);
	Wed, 10 Apr 2019 05:08:37 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 12/15] qemu-print: New qemu_printf(),
 qemu_vprintf() etc.
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
Message-ID: <20190410050835.QRBqm7Hu2gElan_9y_16Fq0sCX6rUcmiVwYVDJsWAVE@z>

"Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:

> * Markus Armbruster (armbru@redhat.com) wrote:
>> We commonly want to print to the current monitor if we have one, else
>> to stdout/stderr.  For stderr, have error_printf().  For stdout, all
>> we have is monitor_vfprintf(), which is rather unwieldy.  We often
>> print to stderr just because error_printf() is easier.
>> 
>> New qemu_printf() and qemu_vprintf() do exactly what's needed.  The
>> next commits will put them to use.
>> 
>> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>
> OK, it seems a little odd not to have the fprintf as well, but OK.

Wait for my next series touching this :)

> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Thanks!

