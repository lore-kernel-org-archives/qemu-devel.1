Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B0AC48BD5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 18:02:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 754F320883
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 18:02:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 754F320883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34404 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfpln-0003AI-2X
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 14:02:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43334)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ehabkost@redhat.com>) id 1hfpjd-00029e-11
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 14:00:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1hfpjb-0000Dg-U4
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 14:00:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58468)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hfpjb-0000Cp-Kp
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 13:59:59 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A88F2300DA2B;
 Tue, 25 Jun 2019 17:59:58 +0000 (UTC)
Received: from localhost (ovpn-116-76.gru2.redhat.com [10.97.116.76])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 241C46013B;
 Tue, 25 Jun 2019 17:59:57 +0000 (UTC)
Date: Tue, 25 Jun 2019 14:59:56 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Message-ID: <20190625175956.GT1862@habkost.net>
References: <20190625050008.12789-1-ehabkost@redhat.com>
 <20190625050008.12789-5-ehabkost@redhat.com>
 <20190625162603.GK3139@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190625162603.GK3139@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Tue, 25 Jun 2019 17:59:58 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 4/6] i386: Infrastructure for versioned CPU
 models
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
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Jiri Denemark <jdenemar@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 25, 2019 at 05:26:03PM +0100, Daniel P. Berrang=E9 wrote:
> On Tue, Jun 25, 2019 at 02:00:06AM -0300, Eduardo Habkost wrote:
> > Base code for versioned CPU models.  This will register a "-4.1"
> > version of all existing CPU models, and make the unversioned CPU
> > models be an alias for the -4.1 versions on the pc-*-4.1 machine
> > types.
> >=20
> > On older machine types, the unversioned CPU models will keep the
> > old behavior.  This way, management software can use old machine
> > types while resolving aliases if compatibility with older QEMU
> > versions is required.
> >=20
> > Using "-machine none", the unversioned CPU models will be aliases
> > to the latest CPU model version.
> >=20
> > Includes a test case to ensure that:
> > old machine types won't report any alias to versioned CPU models;
> > "pc-*-4.1" will return aliases to -4.1 CPU models;
> > and "-machine none" will report aliases to some versioned CPU model.
>=20
> I'm wondering about the of tieing CPU versions to the release version
> number and whether its a good idea or not ?
>=20
> Could there be a reason for us to introduce 2 or more variants
> of a CPU in the same release & would that be a problem if we needed
> todo it ?

I don't see a problem, we can use 3-digit versions that won't be
enabled by any machine type by default.

>=20
> Consider if we did not have a Broadwell CPU model defined yet
> and we were adding it at the same time as Spectre came out. We
> might have needed to add "Broadwell-NN" and "Broadwell-MM" one
> with "spec-ctrl" and one without, in order to ensure runability
> on hosts with & without the microcode upgrade.  "Broadwell" alias
> would resolve to either the NN or MM variant according to what
> the current host supported.
>=20
> One way to cope with that would have been to add a 3rd digit
> after the version number. eg a Broadwell-4.1.1 and Broadwell-4.1.2

That's exactly what I did for Cascadelake-Server, see patch 6/6.

>=20
> An alternative could consider using a plain counter for the CPU
> versions eg Broadwell-1, Broadwell-2, etc.... ?

This is possible too.  It would require a more complex mapping
between machine types and CPU model versions, though.  Maybe this
is worth the extra complexity because it would make the external
interfaces simpler.

>=20
>=20
> If we want to backport the newly added CPU model variants to
> exist branches, plain counters don't have the unsightly mismatch.
> eg we'd backport Broadwell-3 to QEMU 3.1, not Broadwell-4.1 to
> QEMU 3.1.  This isn't a functional problem, just something looking
> a bit odd.

I think I'm liking this approach.  If we're untying CPU models
from machine types, let's do it all the way.

--=20
Eduardo

