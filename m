Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F4AAC04AAD
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 11:22:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3406F20989
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 11:22:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3406F20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44812 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNyAq-00076Q-3b
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 07:22:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38137)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hNy9o-0006Ua-Jc
	for qemu-devel@nongnu.org; Tue, 07 May 2019 07:21:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hNy9l-0008CX-VJ
	for qemu-devel@nongnu.org; Tue, 07 May 2019 07:21:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39274)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>)
	id 1hNy9l-0008Bu-PM; Tue, 07 May 2019 07:21:09 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C766B307CDD5;
	Tue,  7 May 2019 11:21:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-28.ams2.redhat.com
	[10.36.116.28])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 5BEA01A7D9;
	Tue,  7 May 2019 11:21:08 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 932011132B35; Tue,  7 May 2019 13:21:05 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
References: <20190501053522.10967-1-sjitindarsingh@gmail.com>
	<20190502004420.GD13618@umbus.fritz.box>
	<2f1ec028-0bfd-d571-6a34-b8f3adc35a13@ozlabs.ru>
Date: Tue, 07 May 2019 13:21:05 +0200
In-Reply-To: <2f1ec028-0bfd-d571-6a34-b8f3adc35a13@ozlabs.ru> (Alexey
	Kardashevskiy's message of "Thu, 2 May 2019 12:15:40 +1000")
Message-ID: <87sgtqcxy6.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.49]);
	Tue, 07 May 2019 11:21:08 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 1/2] monitor: Add dump-stack
 command
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
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, dgilbert@redhat.com,
	Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Alexey Kardashevskiy <aik@ozlabs.ru> writes:

> On 02/05/2019 10:44, David Gibson wrote:
>> On Wed, May 01, 2019 at 03:35:21PM +1000, Suraj Jitindar Singh wrote:
>>> Add a monitor command "dump-stack" to be used to dump the stack for the
>>> current cpu.
>> 
>> So, you can already get guest backtraces by using the gdbstub
>
> Not in the field - this requires QEMU to run with -s which is not
> usually the case.

If I understand help correctly, you can hot-add a gdbserver with HMP
command gdbserver.  Makes me think ...

> But since we almost always deal with QEMUs run by libvirt and HMP/QMP is
> always available, one could write a script doing QMP's
> "human-monitor-command x/16g" or "virsh qemu-monitor-command --hmp
> x/16g" to read the guest memory and MSR:LE and dump the stack with the
> exception frame.
>
>
>> functionality.  I can see some benefit in allowing this more easily
>> through hmp, but whether it's worth the code size, I'm less certain.

... David's "why not use gdb" should be considered once more.

> It still seems easier than running an external script talking to HMP/QMP
> as you would not want to write such script in bash but rather in a
> better language which might not be installed on the client machine (like
> missing python3 on many RHEL :) ). Thanks,

Your point "while it's possible to trace the stack with nothing but
x/16g and a general purpose programming language, we shouldn't make our
users jump through this hoop" is valid.

However, the new command is actually competing with gdb.  How much of
gdb do we want to build into QEMU to avoid the inconvenience of having
to install gdb and hot-add a gdb server?

