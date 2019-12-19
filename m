Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B218C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 13:21:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA8D0227BF
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 13:21:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EpcbAeoG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA8D0227BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihvjw-0005te-2x
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 08:21:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40966)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1ihvKw-0008TU-Ve
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:55:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1ihvKu-0007qv-3T
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:55:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33124
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ihvKt-0007k3-Qs
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:55:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576760122;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yNLIioBNk1ZT8TeNI7etG3H5ZLGg4OnPEuqSZfTU9Zc=;
 b=EpcbAeoG9709Naw1e2/RehgaqANcSsCfoK8YtrdrdwaoWe3RKtrZqlsF0X/xtiStlelxfD
 eWY7ZabAi/wQEyIZ4h36nSREpz9Yvgvjq/sqskjj/Rw4z1VtdfctgK2uv4oAByQZjM787x
 EohWpMfhxgo1wTSgJeLSDpIVvuPz4yI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236--BSBZ28FP5i7PB46SixUOA-1; Thu, 19 Dec 2019 07:55:18 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6D0841083E84;
 Thu, 19 Dec 2019 12:55:16 +0000 (UTC)
Received: from redhat.com (unknown [10.42.16.105])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E3FE1675B8;
 Thu, 19 Dec 2019 12:55:06 +0000 (UTC)
Date: Thu, 19 Dec 2019 12:55:04 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Felipe Franciosi <felipe@nutanix.com>
Subject: Re: [RFC v4 PATCH 00/49] Initial support of multi-process qemu -
 status update
Message-ID: <20191219125504.GI1190276@redhat.com>
References: <cover.1571905346.git.jag.raman@oracle.com>
 <20191210064716.GA6401@flaka>
 <20191213104116.GB1180977@stefanha-x1.localdomain>
 <20191216194655.GA5922@flaka>
 <AFBAD3A1-0E22-4E22-AF22-C56794929D87@nutanix.com>
 <20191217163316.GB1333385@stefanha-x1.localdomain>
 <DDE3DA62-31DD-437B-8392-CAD505253EED@nutanix.com>
 <20191219115545.GD1624084@stefanha-x1.localdomain>
 <772D9CF3-D15D-42D1-B9CF-1279619D7C20@nutanix.com>
MIME-Version: 1.0
In-Reply-To: <772D9CF3-D15D-42D1-B9CF-1279619D7C20@nutanix.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: -BSBZ28FP5i7PB46SixUOA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 "fam@euphon.net" <fam@euphon.net>, Swapnil Ingle <swapnil.ingle@nutanix.com>,
 "john.g.johnson@oracle.com" <john.g.johnson@oracle.com>,
 Stefan Hajnoczi <stefanha@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Walker,
 Benjamin" <benjamin.walker@intel.com>, "kraxel@redhat.com" <kraxel@redhat.com>,
 "jag.raman@oracle.com" <jag.raman@oracle.com>, "Harris,
 James R" <james.r.harris@intel.com>,
 "quintela@redhat.com" <quintela@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "kanth.ghatraju@oracle.com" <kanth.ghatraju@oracle.com>,
 "thuth@redhat.com" <thuth@redhat.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "liran.alon@oracle.com" <liran.alon@oracle.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "rth@twiddle.net" <rth@twiddle.net>, "kwolf@redhat.com" <kwolf@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "ross.lagerwall@citrix.com" <ross.lagerwall@citrix.com>,
 "marcandre.lureau@gmail.com" <marcandre.lureau@gmail.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Dec 19, 2019 at 12:33:15PM +0000, Felipe Franciosi wrote:
> Hello,
>=20
> (I've added Jim and Ben from the SPDK team to the thread.)
>=20
> > On Dec 19, 2019, at 11:55 AM, Stefan Hajnoczi <stefanha@gmail.com> wrot=
e:
> >=20
> > On Tue, Dec 17, 2019 at 10:57:17PM +0000, Felipe Franciosi wrote:
> >>> On Dec 17, 2019, at 5:33 PM, Stefan Hajnoczi <stefanha@redhat.com> wr=
ote:
> >>> On Mon, Dec 16, 2019 at 07:57:32PM +0000, Felipe Franciosi wrote:
> >>>>> On 16 Dec 2019, at 20:47, Elena Ufimtseva <elena.ufimtseva@oracle.c=
om> wrote:
> >>>>> =EF=BB=BFOn Fri, Dec 13, 2019 at 10:41:16AM +0000, Stefan Hajnoczi =
wrote:
> >>> Questions I've seen when discussing muser with people have been:
> >>>=20
> >>> 1. Can unprivileged containers create muser devices?  If not, this is=
 a
> >>>  blocker for use cases that want to avoid root privileges entirely.
> >>=20
> >> Yes you can. Muser device creation follows the same process as general
> >> mdev device creation (ie. you write to a sysfs path). That creates an
> >> entry in /dev/vfio and the control plane can further drop privileges
> >> there (set selinux contexts, &c.)
> >=20
> > In this case there is still a privileged step during setup.  What about
> > completely unprivileged scenarios like a regular user without root or a
> > rootless container?
>=20
> Oh, I see what you are saying. I suppose we need to investigate
> adjusting the privileges of the sysfs path correctly beforehand to
> allow devices to be created by non-root users. The credentials used on
> creation should be reflected on the vfio endpoint (ie. /dev/fio/<group>).
>=20
> I need to look into that and get back to you.
>=20
> >=20
> >>> 2. Does muser need to be in the kernel (e.g. slower to develop/ship,
> >>>  security reasons)?  A similar library could be implemented in
> >>>  userspace along the lines of the vhost-user protocol.  Although VMMs
> >>>  would then need to use a new libmuser-client library instead of
> >>>  reusing their VFIO code to access the device.
> >>=20
> >> Doing it in userspace was the flow we proposed back in last year's KVM
> >> Forum (Edinburgh), but it got turned down. That's why we procured the
> >> kernel approach, which turned out to have some advantages:
> >> - No changes needed to Qemu
> >> - No Qemu needed at all for userspace drivers
> >> - Device emulation process restart is trivial
> >>  (it therefore makes device code upgrades much easier)
> >>=20
> >> Having said that, nothing stops us from enhancing libmuser to talk
> >> directly to Qemu (for the Qemu case). I envision at least two ways of
> >> doing that:
> >> - Hooking up libmuser with Qemu directly (eg. over a unix socket)
> >> - Hooking Qemu with CUSE and implementing the muser.ko interface
> >>=20
> >> For the latter, libmuser would talk to a character device just like it
> >> talks to the vfio character device. We "just" need to implement that
> >> backend in Qemu. :)
> >=20
> > What about:
> > * libmuser's API stays mostly unchanged but the library speaks a
> >   VFIO-over-UNIX domain sockets protocol instead of talking to
> >   mdev/vfio in the host kernel.
>=20
> As I said above, there are advantages to the kernel model. The key one
> is transparent device emulation restarts. Today, muser.ko keeps the
> "device memory" internally in a prefix tree. Upon restart, a new
> device emulator can recover state (eg. from a state file in /dev/shm
> or similar) and remap the same memory that is already configured to
> the guest via Qemu. We have a pending work item for muser.ko to also
> keep the eventfds so we can recover those, too. Another advantage is
> working with any userspace driver and not requiring a VMM at all.
>=20
> If done entirely in userspace, the device emulator needs to allocate
> the device memory somewhere that remains accessible (eg. tmpfs), with
> the difference that now we may be talking about non-trivial amounts of
> memory. Also, that may not be the kind of content you want lingering
> around the filesystem (for the same reasons Qemu unlinks memory files
> from /dev/hugepages after mmap'ing it).
>=20
> That's why I'd prefer to rephrase what you said to "in addition"
> instead of "instead".
>=20
> > * VMMs can implement this protocol directly for POSIX-portable and
> >   unprivileged operation.
> > * A CUSE VFIO adapter simulates /dev/vfio so that VFIO-only VMMs can
> >   still take advantage of libmuser devices.
>=20
> I'm happy with that.
> We need to think the credential aspect throughout to ensure nodes can
> be created in the right places with the right privileges.
>=20
> >=20
> > Assuming this is feasible, would you lose any important
> > features/advantages of the muser.ko approach?  I don't know enough abou=
t
> > VFIO to identify any blocker or obvious performance problems.
>=20
> That's what I elaborated above. The fact that muser.ko can keep
> various metadata (and other resources) about the device in the kernel
> and grant it back to userspace as needed. There are ways around it,
> but it requires some orchestration with tmpfs and the VMM (only so
> much can be kept in tmpfs; the eventfds need to be retransmitted from
> the machine emulator on request).
>=20
> Restarting is a critical aspect of this. One key use case for the
> project is to be able to emulate various devices from one process (for
> polling). That must be able to restart for upgrades or recovery.
>=20
> >=20
> > Regarding recovery, it seems straightforward to keep state in a tmpfs
> > file that can be reopened when the device is restarted.  I don't think
> > kernel code is necessary?
>=20
> It adds a dependency, but isn't a show stopper. If we can work through
> permission issues, making sure the VMM can reconnect and retransmit
> eventfds and other state, then it should be ok.
>=20
> To be clear: I'm very happy to have a userspace-only option for this,
> I just don't want to ditch the kernel module (yet, anyway). :)

If it doesn't create too large of a burden to support both, then I think
it is very desirable. IIUC, this is saying a kernel based solution as the
optimized/optimal solution, and userspace UNIX socket based option as the
generic "works everywhere" fallback solution.



Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


