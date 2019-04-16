Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E80FC10F13
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 06:15:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6776C2075B
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 06:15:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6776C2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59967 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGHN5-00085b-Id
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 02:15:07 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hGHML-0007mi-0C
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 02:14:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hGHMJ-0006zy-IK
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 02:14:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60220)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hGHMI-0006wR-Ls
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 02:14:19 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F123C30832E8
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 06:14:13 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-116.ams2.redhat.com
	[10.36.116.116])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C0F095C1B4;
	Tue, 16 Apr 2019 06:14:13 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 36E4E1138648; Tue, 16 Apr 2019 08:14:12 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <20190411152520.10061-1-armbru@redhat.com>
	<20190411152520.10061-10-armbru@redhat.com>
	<20190415154342.GM2852@work-vm>
Date: Tue, 16 Apr 2019 08:14:12 +0200
In-Reply-To: <20190415154342.GM2852@work-vm> (David Alan Gilbert's message of
	"Mon, 15 Apr 2019 16:43:44 +0100")
Message-ID: <871s228ojv.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.44]);
	Tue, 16 Apr 2019 06:14:14 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 09/17] target: Simplify how the
 TARGET_cpu_list() print
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
Message-ID: <20190416061412.FvJEXyI58XNiQYsrun68gNQXO7eVAGRrGtgov-ReXTY@z>

"Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:

> * Markus Armbruster (armbru@redhat.com) wrote:
>> The various TARGET_cpu_list() take an fprintf()-like callback and a
>> FILE * to pass to it.  Their callers (vl.c's main() via list_cpus(),
>> bsd-user/main.c's main(), linux-user/main.c's main()) all pass
>> fprintf() and stdout.  Thus, the flexibility provided by the (rather
>> tiresome) indirection isn't actually used.
>> 
>> Drop the callback, and call qemu_fprintf() instead.
>
> Actually calling qemu_printf

Typo, will fix.  Thanks!

>> Calling printf() would also work, but would make the code unsuitable
>> for monitor context without making it simpler.
>
> Gernally OK; but just checking - are there any flag combos that will
> mean this ends up with the result going down a monitor rather than
> stdout, and will that upset something like libvirt that might be using
> this to enumerate a cpu list?

No.

qemu_printf() prints to current monitor if we have one, else to stdout.
Thus, it prints to stdout as long as !cur_mon.

cur_mon is thread-local, and always set like this:

    Monitor *old_mon = cur_mon;
    cur_mon = ... non-null value ...
    ... do something ...
    cur-mon = old_mon;

It's set and restored

* in monitor_qmp_dispatch() around executing a QMP command

* in monitor_read() around handling HMP input (this includes executing
  a command)

* in qmp_human_monitor_command() around executing the HMP command (this
  is where monitors become nested)

Therefore, cur_mon is null unless we're executing a QMP command, an HMP
command, or are processing HMP input.

Clearer now?

