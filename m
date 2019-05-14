Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,T_HK_NAME_DR,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C6ABC04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 15:19:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FFFD2085A
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 15:19:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FFFD2085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49746 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQZD6-0008Pt-BT
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 11:19:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52171)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hQZC7-000865-Gm
	for qemu-devel@nongnu.org; Tue, 14 May 2019 11:18:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hQZC6-0007CK-Ij
	for qemu-devel@nongnu.org; Tue, 14 May 2019 11:18:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37672)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hQZC6-0007Aw-DM
	for qemu-devel@nongnu.org; Tue, 14 May 2019 11:18:18 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B1D0381F0C;
	Tue, 14 May 2019 15:18:17 +0000 (UTC)
Received: from work-vm (ovpn-117-232.ams2.redhat.com [10.36.117.232])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id B22B7608AB;
	Tue, 14 May 2019 15:18:16 +0000 (UTC)
Date: Tue, 14 May 2019 16:18:14 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Wei Yang <richardw.yang@linux.intel.com>
Message-ID: <20190514151813.GL2753@work-vm>
References: <20190424004700.12766-1-richardw.yang@linux.intel.com>
	<20190424004700.12766-3-richardw.yang@linux.intel.com>
	<0eb5e5a5-593e-f4a2-7e2d-a9fed481ab6c@gmail.com>
	<20190426005133.GB25513@richard>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190426005133.GB25513@richard>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Tue, 14 May 2019 15:18:17 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 2/4] migration/savevm: use
 migration_is_blocked to validate
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
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org,
	quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Wei Yang (richardw.yang@linux.intel.com) wrote:
> On Thu, Apr 25, 2019 at 05:55:15PM -0300, Daniel Henrique Barboza wrote=
:
> >
> >
> >On 4/23/19 9:46 PM, Wei Yang wrote:
> >> migration_is_blocked() is used in migrate_prepare() and
> >> save_snapshot(), this is more proper to use this instead of
> >> qemu_savevm_state_blocked() in qemu_loadvm_state().
> >
> >
> >migration_is_blocked() does an additional verification:
> >
> >"if (migration_blockers)"
> >
> >comparing to what was previously done in qemu_loadvm_state.
> >
> >I've checked what migration_blockers does and it is a GList used
> >for callers to block the migration process. This is used via
> >'migration_add_blocker', from migration.c.
> >
> >'migration_add_blocker' is called all over the place, most notably
> >in=A0 _realize() functions=A0 and _open() functions from block.
> >
> >Thus, I am not sure if this change will impact the use of
> >qemu_loadvm_state() from load_snapshot() (i.e. can load_snapshot
> >be called with migration_blockers?). It's better to someone
> >with a better understanding of this code to comment on that.
> >
>=20
> Well, when you look into the source side of migration:
>=20
> qmp_migrate
>   migrate_prepare
>     migration_is_blocked
>=20
> This means if migration_is_blocked fails, the source will not start mig=
ration.
> And it is the same as save_snapshot.
>=20
> From my understanding, when we load a vm, it should check the same
> requirement.

I've been thinking about this, and I think I agree with Daniel on this.
The 'migration_blockers' list tells you that something about the
*current* state of a device means that it can't be migrated - e.g.
a 9pfs with a mounted filesystem can't be migrated.

If we're about to reload the state from a snapshot, then the saved
snapshot's state must have been migratable, so that's OK.

(Whether all the device code is actually OK about being reset in
that state is a different question; but I think it should be).

Dave

> --=20
> Wei Yang
> Help you, Help me
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

