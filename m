Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B917C48BD5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 18:13:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7854E2080C
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 18:13:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7854E2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34488 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfpx5-0001ft-P6
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 14:13:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46876)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ehabkost@redhat.com>) id 1hfpuv-0000Jg-2a
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 14:11:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1hfpus-0003NN-64
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 14:11:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:9481)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hfpuo-00039m-Bz
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 14:11:35 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AC29F309266D;
 Tue, 25 Jun 2019 18:11:07 +0000 (UTC)
Received: from localhost (ovpn-116-76.gru2.redhat.com [10.97.116.76])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2F40A6085B;
 Tue, 25 Jun 2019 18:11:05 +0000 (UTC)
Date: Tue, 25 Jun 2019 15:11:03 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Message-ID: <20190625181103.GV1862@habkost.net>
References: <20190625050008.12789-1-ehabkost@redhat.com>
 <20190625161357.GI3139@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190625161357.GI3139@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Tue, 25 Jun 2019 18:11:11 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 0/6] x86 CPU model versioning
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
Cc: Pavel Hrdina <phrdina@redhat.com>, Tao Xu <tao3.xu@intel.com>, "Hu,
 Robert" <robert.hu@intel.com>, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Jiri Denemark <jdenemar@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 25, 2019 at 05:13:57PM +0100, Daniel P. Berrang=E9 wrote:
> On Tue, Jun 25, 2019 at 02:00:02AM -0300, Eduardo Habkost wrote:
> > This series implements basic infrastructure for CPU model
> > versioning, as discussed before[1][2][3].  This will finally
> > allow us to update CPU models in ways that introduce new software
> > or hardware requirements.
> >=20
> > My original plan was to use "query-cpu-model-expansion
> > mode=3Dstatic" to resolve aliases, but I dropped that plan because
> > it would increase complexity for management software a lot.
> > static CPU models are documented as not being affected by the
> > machine type and accelerator at all, which would make the
> > versioned CPU models very inconvenient to use in the command
> > line.  e.g.: users would be forced to replace:
> >=20
> >   -cpu Haswell
> >=20
> > with:
> >=20
> >   -cpu Haswell-4.1,+2apic,+monitor,+kvmclock,+kvm-nopiodelay,+kvm-asy=
ncpf,+kvm-steal-time,+kvm-pv-eoi,+kvmclock-stable-bit,+x2apic,-acpi,-moni=
tor,-svm
> >=20
> > In the end, making the versioned CPU models static is not a
> > requirement at all: what we really need is to drop the
> > runnability guarantees from unversioned CPU model names, and
> > require management software to resolve the unversioned alias
> > before saving the VM configuration.
> >=20
> > Guest ABI compatibility and live migration guarantees are going
> > to be kept: unversioned CPU models will still be usable with live
> > migration.  Only runnability guarantees when updating the machine
> > type will be dropped.  This means unversioned CPU models are
> > still reported as migration-safe in query-cpu-definitions.
>=20
> I'm having a little bit of a hard time parsing the overall behaviour
> from the above description. Let me outline the examples so you can
> confirm if I've got it right.
>=20
> Lets assume there is a VM configured using "Haswell"
>=20
> Today a mgmt app would pass the CPU model name in to QEMU as is,
> and thus we get
>=20
>   $QEMU -machine pc-i440fx-4.0 -cpu Haswell ...more args...
>=20
> The semantics of "Haswell" here is going to vary according to
> what the machine type pc-i440fx-4.0 customizes wrt Haswell.
>=20
> If the config later has the machine type changed to pc-i440fx-4.1
> the semantics of Haswell might change in an arbitrary way. It
> might even become unrunnable on the current hardware.

If we follow our deprecation policy, this shouldn't happen until
pc-*-4.3.  On pc-*-4.1 and pc-*-4.2, I expect "-cpu Haswell" to
stay runnable if it's already runnable with pc-*-4.0.  This will
give libvirt and other management software some time to adapt.

CPU model changes that don't affect runnability, though, are
already allowed and will still be allowed.


>=20
> With the new versioned machine types, the VM config of "Haswell"
> would be resolved into some arbitrary versioned machine type
> "Haswell-NNN" and thus the mgmt app would launch
>=20
>   $QEMU -machine pc-i440fx-4.0 -cpu Haswell-NNN ...more args...
>=20
> The semantics of "Haswell-NNN" will never change no matter what
> the machine type does.

Exactly.

>=20
> The end user has the option to explicitly give "Haswell-NNN" to
> the mgmt app if they know they want that particular variant, and
> in this case the mgmt app won't need to resolve anything (or at
> least the process of trying to resolve it won't change it).

Yes.  Management software should see that "Haswell-NNN" has no
"alias-of" field, so it doesn't need to be changed.

--=20
Eduardo

