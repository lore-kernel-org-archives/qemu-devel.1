Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC198C352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 11:11:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6C0F2190F
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 11:11:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6C0F2190F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFG3t-0006pb-U6
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 07:11:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55935)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iFG3E-0006Q3-72
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 07:10:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iFG3B-0001Ad-RW
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 07:10:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38804)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1iFG3B-00019m-Is
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 07:10:37 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E97D58A1C8B;
 Tue,  1 Oct 2019 11:10:35 +0000 (UTC)
Received: from redhat.com (ovpn-112-70.ams2.redhat.com [10.36.112.70])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4C9CA1001B08;
 Tue,  1 Oct 2019 11:10:34 +0000 (UTC)
Date: Tue, 1 Oct 2019 12:10:31 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Felipe Franciosi <felipe@nutanix.com>
Subject: Re: Thoughts on VM fence infrastructure
Message-ID: <20191001111031.GH26133@redhat.com>
References: <20190930160316.GH2759@work-vm>
 <417D4B96-2641-4DA8-B00B-3302E211E939@nutanix.com>
 <20190930171109.GL2759@work-vm>
 <CA2CBDDF-99ED-4693-8622-89D4F2E71DE9@nutanix.com>
 <20190930175914.GM2759@work-vm>
 <DE224DBA-FEFF-42C4-8F04-43BA75DF26AA@nutanix.com>
 <20191001082345.GA2781@work-vm>
 <2248E813-102F-4E60-AF9B-A5A2F21C1687@nutanix.com>
 <20191001103111.GF26133@redhat.com>
 <E1A62EE3-9EC0-49DC-A871-C6424F5FD807@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <E1A62EE3-9EC0-49DC-A871-C6424F5FD807@nutanix.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.69]); Tue, 01 Oct 2019 11:10:36 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Rafael David Tinoco <rafaeldtinoco@ubuntu.com>,
 Aditya Ramesh <aramesh@nutanix.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 01, 2019 at 10:46:24AM +0000, Felipe Franciosi wrote:
> Hi Daniel!
>=20
>=20
> > On Oct 1, 2019, at 11:31 AM, Daniel P. Berrang=C3=A9 <berrange@redhat=
.com> wrote:
> >=20
> > On Tue, Oct 01, 2019 at 09:56:17AM +0000, Felipe Franciosi wrote:
>=20
> (Apologies for the mangled URL, nothing I can do about that.) :(
>=20
> There are several points which favour adding this to Qemu:
> - Not all environments use systemd.

Sure, if you want to cope with that you can just use the HW watchdog
directly instead of via systemd.=20

> - HW watchdogs always reboot the host, which is too drastic.
> - You may not want to protect all VMs in the same way.

Same points repeated below, so I'll respond there....

> > IMHO doing this at the host OS level is going to be more reliable in
> > terms of detecting the problem in the first place, as well as more
> > reliable in taking the action - its very difficult for a hardware CPU
> > reset to fail to work.
>=20
> Absolutely, but it's a very drastic measure that:
> - May be unnecessary.

Of course, the inability to predict future consequences is what
forces us into assuming the worst case & taking actions to
mitigate that. It will definitely result in unccessary killing
of hosts, but that is what gives you the safety guarantees you
can't otherwise achieve.

I gave the example elsewhere that even if you kill QEMU, the kernel
can have pending I/O associated with QEMU that can be sent if the
host later recovers.

> - Will fence everything even perhaps only some VMs need protection.

I don't believe its viable to have offer real protection to only
a subset of VMs, principally because the kernel is doing I/O work
on behalf of the VM, so to protect just 1 VM you must fence the
kernel.

> What are your thoughts on this 3-level approach?
> 1) Qemu tries to log() + abort() (deadline)

Just abort()'ing isn't going to be a viable strategy with QEMU's move
towards a multi-process architecture. This introduces the problem that
the "main" QEMU process has to enumerate all the helpers it is dealing
with and kill them all off in some way. This is non-trivial especially
if some of the helpers are running under different privilege levels.

You could declare that multi-process QEMU is out of scope, but I think
QEMU self-fencing would need to offer compelling benefits over host OS
self-fencing to justify that exception. Personally I'm not seeing it.

> 2) Kernel sends SIGKILL (harddeadline)

This is slightly easier to deal with multiple processes in that it
isn't restricted by the privileges of the main QEMU vs helpers and
could take advantage of cgroups perhaps.

> 3) HW watchdog kicks in (harderdeadline)


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

