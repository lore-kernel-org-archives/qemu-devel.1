Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF27DCA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 13:41:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7103B2054F
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 13:41:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F+d8Clph"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7103B2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNzqN-0005YH-1S
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 09:41:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35707)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iNzo0-0001QH-WD
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 09:39:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iNznz-0004tU-IX
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 09:39:04 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:56558
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iNznz-0004t3-ED
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 09:39:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572010742;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T0dwScUuQPxCgDFvUk10hGTdWF4VqfpY1OvfV0q2gVc=;
 b=F+d8ClphIq89IpmEI0lCYXov7V20kQrLAw2ondR/K4evrDxkBblmpk8XRl8Rv2SGpSXoIC
 9MIri4yhyv3yhIvrwXUTPPMG93kmamXzzkiwxp9pPtCeH1oPbSKwT1W7jv+cozaIs84M4q
 9R9Ty339hqQ0Otfvq/AV1y89NdervQI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-83-zb41F479PEWt4ongl4xs0w-1; Fri, 25 Oct 2019 09:38:56 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4C46E80183D;
 Fri, 25 Oct 2019 13:38:54 +0000 (UTC)
Received: from localhost (ovpn-116-62.gru2.redhat.com [10.97.116.62])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7AC8260126;
 Fri, 25 Oct 2019 13:38:48 +0000 (UTC)
Date: Fri, 25 Oct 2019 10:38:46 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 0/7] i386: Add `machine` parameter to query-cpu-definitions
Message-ID: <20191025133846.GD6744@habkost.net>
References: <20191025022553.25298-1-ehabkost@redhat.com>
 <dbf9e4c1-0acf-9469-84f9-f80c41e2cae0@redhat.com>
MIME-Version: 1.0
In-Reply-To: <dbf9e4c1-0acf-9469-84f9-f80c41e2cae0@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: zb41F479PEWt4ongl4xs0w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Thomas Huth <thuth@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>,
 Janosch Frank <frankja@linux.ibm.com>, libvir-list@redhat.com,
 Cornelia Huck <cohuck@redhat.com>,
 Michal Skrivanek <michal.skrivanek@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Jiri Denemark <jdenemar@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

CCing danpb, libvir-list, mskrivanek.

On Fri, Oct 25, 2019 at 09:17:46AM +0200, David Hildenbrand wrote:
> On 25.10.19 04:25, Eduardo Habkost wrote:
> > We had introduced versioned CPU models in QEMU 4.1, including a
> > method for querying for CPU model versions using
>=20
> Interesting, I was not aware of that.
>=20
> On s390x, we somewhat have versioned CPU models, but we decided against
> giving them explicit names (e.g., z13-v1 or z13-4.1.0), because it didn't
> really seem to be necessary. (and we often implement/add features for old=
er
> CPU models, there is a lot of fluctuation) Actually, you would have had t=
o
> add "z13-z/VM-x.x.x" or "z13-LPAR-x.x.x" or "z13-KVM-x.x.x" to model the
> features you actually see in all the different virtual environments ("wha=
t a
> CPU looks like"). Not to talk about QEMU versions in addition to that. So=
 we
> decided to always model what you would see under LPAR and are able to
> specify for a KVM guest. So you can use "z13" in an up-to-date LPAR
> environment, but not in a z/VM environment (you would have to disable
> features).
>=20
> Each (!base) CPU model has a specific feature set per machine. Libvirt us=
es
> query-cpu-model-expansion() to convert this model+machine to a
> machine-independent representation. That representation is sufficient for
> all use cases we were aware of (esp. "virsh domcapabilities", the host CP=
U
> model, migration).
>=20
> While s390x has versioned CPU models, we have no explicit way of specifyi=
ng
> them for older machines, besides going over query-cpu-model-expansion and
> using expanded "base model + features".
>=20
> I can see that this might make sense on x86-64, where you only have maybe=
 3
> versions of a CPU (e.g., the one Intel messed up first - Haswell, the one
> Intel messed up next - Haswell-noTSX, and the one that Intel eventually d=
id
> right - Haswell-noTSX-IBRS) and you might want to specify "Haswell" vs.
> "Haswell-IBRS" vs. "Haswell-noTSX-IBRS". But actually, you will always wa=
nt
> to go for "Haswell-noTSX-IBRS", because you can expect to run in updated
> environments if I am not wrong, everything else are corner cases.
>=20
> Of course, versioned CPU model are neat to avoid "base model + list of
> features", but at least for expanding the host model on s390x, it is not
> really helpful. When migrating, the model expansion does the trick.
>=20
> I haven't looked into details of "how to specify or model versions". Mayb=
e
> IBM wants to look into creating versions for all the old models we had. B=
ut
> again, not sure if that is of any help for s390x. CCing IBM.

I'm not sure yet if there are the x86-specific goals and
constraints that would make it difficult to follow the same
approach followed by s390x.  I have the impression we do,
but I need to think more carefully about it.

Let's discuss that during KVM Forum?

The two main goals of versioned CPU models in x86 are:
1) Decoupling CPU model updates from machine-types (users should be
   able to update a CPU model definition without changing machine
   type).
2) Letting management software automate CPU model updates.
   Normally this is necessary when bare metal microcode or
   software updates add/remove features from CPUs.  Sometimes the
   Virtual CPU model update needs to be performed before the host
   updates are applied (if features are being removed).

The main constraint that makes it difficult to address the above
without a new API is:
A) Every CPU model in x86 except "host" is already expected to
   be migration-safe (I don't know how this compares to s390x).


>=20
> > query-cpu-definitions.  This only has one problem: fetching CPU
> > alias information for multiple machine types required restarting
> > QEMU for each machine being queried.
> >=20
> > This series adds a new `machine` parameter to
> > query-cpu-definitions, that can be used to query CPU model alias
> > information for multiple machines without restarting QEMU.
> >=20
> > Eduardo Habkost (7):
> >    i386: Use g_autofree at x86_cpu_list_entry()
> >    i386: Add default_version parameter to CPU version functions
> >    i386: Don't use default_cpu_version at "-cpu help"
> >    machine: machine_find_class() function
> >    i386: Remove x86_cpu_set_default_version() function
> >    i386: Don't use default_cpu_version() inside query-cpu-definitions
> >    cpu: Add `machine` parameter to query-cpu-definitions
> >=20
> >   qapi/machine-target.json                   | 14 +++-
> >   include/hw/boards.h                        |  1 +
> >   include/hw/i386/pc.h                       |  5 +-
> >   target/i386/cpu.h                          |  6 --
> >   hw/core/machine.c                          | 16 ++++
> >   hw/i386/pc.c                               |  3 -
> >   target/arm/helper.c                        |  4 +-
> >   target/i386/cpu.c                          | 93 +++++++++++++++------=
-
> >   target/mips/helper.c                       |  4 +-
> >   target/ppc/translate_init.inc.c            |  4 +-
> >   target/s390x/cpu_models.c                  |  4 +-
> >   vl.c                                       | 17 +---
> >   tests/acceptance/x86_cpu_model_versions.py | 42 ++++++++++
> >   13 files changed, 154 insertions(+), 59 deletions(-)
> >=20
>=20
>=20
> --=20
>=20
> Thanks,
>=20
> David / dhildenb

--=20
Eduardo


