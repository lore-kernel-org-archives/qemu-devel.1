Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB0ADCA9EB5
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 08:15:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7C392089C
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 08:15:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qiu9RSB0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7C392089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMSqo-0006jv-Uh
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 04:15:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52376)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iMSq7-00069R-GR
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 04:14:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iMSq6-0007pN-4A
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 04:14:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21202
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iMSq5-0007p9-WC
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 04:14:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571645692;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OzK/4nctRAaV+syYjU5OYtfFvO5YBSSukT3jt6s2JGk=;
 b=Qiu9RSB0htmRDYhcuHxLndEMekHCXfX7nKRaGRa/CCHZVYWmT0oYCsfMnTSwtegMqxIhqz
 dbYqoNairn6LlKOcnBH2N9zVppsXa+aEzAw7eCRiHhnhoO7z+vInQhDWsPnvSCmE54CQ51
 HQDDENFRqd/7NhIWCs5Ee4nj953Dod0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-IXdYZ8AkNwaj_RtvKMXHMg-1; Mon, 21 Oct 2019 04:14:50 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 094A41800D79;
 Mon, 21 Oct 2019 08:14:49 +0000 (UTC)
Received: from work-vm (ovpn-117-232.ams2.redhat.com [10.36.117.232])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 866B4196AE;
 Mon, 21 Oct 2019 08:14:47 +0000 (UTC)
Date: Mon, 21 Oct 2019 09:14:44 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v2 2/2] migration: savevm_state_handler_insert:
 constant-time element insertion
Message-ID: <20191021081444.GA2934@work-vm>
References: <20191017205953.13122-1-cheloha@linux.vnet.ibm.com>
 <20191017205953.13122-3-cheloha@linux.vnet.ibm.com>
 <20191018081625.GA2990@work-vm>
 <351dca8e-e77c-c450-845b-d78ba621156a@redhat.com>
 <20191018094352.GC2990@work-vm>
 <20191019101223.GD1960@umbus.fritz.box>
MIME-Version: 1.0
In-Reply-To: <20191019101223.GD1960@umbus.fritz.box>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: IXdYZ8AkNwaj_RtvKMXHMg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Scott Cheloha <cheloha@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* David Gibson (david@gibson.dropbear.id.au) wrote:
> On Fri, Oct 18, 2019 at 10:43:52AM +0100, Dr. David Alan Gilbert wrote:
> > * Laurent Vivier (lvivier@redhat.com) wrote:
> > > On 18/10/2019 10:16, Dr. David Alan Gilbert wrote:
> > > > * Scott Cheloha (cheloha@linux.vnet.ibm.com) wrote:
> > > >> savevm_state's SaveStateEntry TAILQ is a priority queue.  Priority
> > > >> sorting is maintained by searching from head to tail for a suitabl=
e
> > > >> insertion spot.  Insertion is thus an O(n) operation.
> > > >>
> > > >> If we instead keep track of the head of each priority's subqueue
> > > >> within that larger queue we can reduce this operation to O(1) time=
.
> > > >>
> > > >> savevm_state_handler_remove() becomes slightly more complex to
> > > >> accomodate these gains: we need to replace the head of a priority'=
s
> > > >> subqueue when removing it.
> > > >>
> > > >> With O(1) insertion, booting VMs with many SaveStateEntry objects =
is
> > > >> more plausible.  For example, a ppc64 VM with maxmem=3D8T has 4000=
0 such
> > > >> objects to insert.
> > > >=20
> > > > Separate from reviewing this patch, I'd like to understand why you'=
ve
> > > > got 40000 objects.  This feels very very wrong and is likely to cau=
se
> > > > problems to random other bits of qemu as well.
> > >=20
> > > I think the 40000 objects are the "dr-connectors" that are used to pl=
ug
> > > peripherals (memory, pci card, cpus, ...).
> >=20
> > Yes, Scott confirmed that in the reply to the previous version.
> > IMHO nothing in qemu is designed to deal with that many devices/objects
> > - I'm sure that something other than the migration code is going to
> > get upset.
>=20
> It kind of did.  Particularly when there was n^2 and n^3 cubed
> behaviour in the property stuff we had some ludicrously long startup
> times (hours) with large maxmem values.
>=20
> Fwiw, the DRCs for PCI slots, DRCs and PHBs aren't really a problem.
> The problem is the memory DRCs, there's one for each LMB - each 256MiB
> chunk of memory (or possible memory).
>=20
> > Is perhaps the structure wrong somewhere - should there be a single DRC
> > device that knows about all DRCs?
>=20
> Maybe.  The tricky bit is how to get there from here without breaking
> migration or something else along the way.

Switch on the next machine type version - it doesn't matter if migration
is incompatible then.

Without knowing anything about the innards of DRCs, I suggest a=20
DRCMulti that takes a parameter and represents 'n' DRCs at consecutive
chunks of memory.  Then use one DRCMulti for each RAMBlock or DIMM or
other convenient sized thing.

Dave

> --=20
> David Gibson=09=09=09| I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au=09| minimalist, thank you.  NOT _the_ _oth=
er_
> =09=09=09=09| _way_ _around_!
> http://www.ozlabs.org/~dgibson


--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


