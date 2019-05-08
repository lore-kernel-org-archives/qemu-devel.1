Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DBA7C04AAD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 13:11:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04356214AF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 13:11:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04356214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36989 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOMMF-0007tB-9g
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 09:11:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hOMLR-00076m-Gk
	for qemu-devel@nongnu.org; Wed, 08 May 2019 09:10:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hOMLQ-0006DK-JM
	for qemu-devel@nongnu.org; Wed, 08 May 2019 09:10:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41328)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>)
	id 1hOMLQ-0006Ca-EK; Wed, 08 May 2019 09:10:48 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 310DFA96E2;
	Wed,  8 May 2019 13:10:47 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-28.ams2.redhat.com
	[10.36.116.28])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id F2AF05C269;
	Wed,  8 May 2019 13:10:46 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 206531132B35; Wed,  8 May 2019 15:10:45 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <20190501053522.10967-1-sjitindarsingh@gmail.com>
	<87woj2cyhu.fsf@dusky.pond.sub.org> <20190508102621.GD2718@work-vm>
Date: Wed, 08 May 2019 15:10:45 +0200
In-Reply-To: <20190508102621.GD2718@work-vm> (David Alan Gilbert's message of
	"Wed, 8 May 2019 11:26:21 +0100")
Message-ID: <87pnot148a.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.38]);
	Wed, 08 May 2019 13:10:47 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 1/2] monitor: Add dump-stack command
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
	Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
	david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

"Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:

> * Markus Armbruster (armbru@redhat.com) wrote:
>> Suraj Jitindar Singh <sjitindarsingh@gmail.com> writes:
>> 
>> > Add a monitor command "dump-stack" to be used to dump the stack for the
>> > current cpu.
>> 
>> I guess this is just for debugging.  Correct?
>> 
>> Shouldn't this be "info stack", to match "info registers" and "info
>> cpustats"?
>
> Since this is primarily about walking the guests stack frames and not
> walking qemu internal data structures, I think it's probably OK to be
> a dump-stack rather than an info subcommand.

Well, "info registers" is also about the guest's state and not QEMU
internal state.  Arguably, so are "info pic", "info tlb", ...

We have a long-standing tradition of using "info" for "pure"
information-retrieving commands.  I rather like that pattern.

Ultimately your choice as the HMP maintainer, of course.

