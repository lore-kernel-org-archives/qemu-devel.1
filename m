Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5EE0C41514
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 11:26:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E60E22DCC
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 11:26:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E60E22DCC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i56xI-0005vd-G7
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 07:26:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52232)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1i56wd-0005X6-Nb
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 07:25:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1i56wc-0006ik-Bx
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 07:25:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45410)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1i56wc-0006hl-3z
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 07:25:54 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 358714E4E6;
 Tue,  3 Sep 2019 11:25:53 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.29])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5A9D25D6C8;
 Tue,  3 Sep 2019 11:25:51 +0000 (UTC)
Date: Tue, 3 Sep 2019 12:25:48 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Eric Blake <eblake@redhat.com>
Message-ID: <20190903112548.GF2744@work-vm>
References: <20190827120221.15725-1-yury-kotov@yandex-team.ru>
 <20190827120221.15725-2-yury-kotov@yandex-team.ru>
 <fb324ab9-b7a2-d56e-a0d1-9f4ae86791ce@redhat.com>
 <1097381566920178@vla1-6bb9290e4d68.qloud-c.yandex.net>
 <ff0428a4-6600-7b41-e246-7858e58e5507@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <ff0428a4-6600-7b41-e246-7858e58e5507@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Tue, 03 Sep 2019 11:25:53 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 1/3] migration: Add x-validate-uuid
 capability
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Yury Kotov <yury-kotov@yandex-team.ru>,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Eric Blake (eblake@redhat.com) wrote:
> On 8/27/19 10:36 AM, Yury Kotov wrote:
> > 27.08.2019, 17:02, "Eric Blake" <eblake@redhat.com>:
> >> On 8/27/19 7:02 AM, Yury Kotov wrote:
> >>> =A0This capability realizes simple source validation by UUID.
> >>> =A0It's useful for live migration between hosts.
> >>>
>=20
> >>
> >> Any reason why this is marked experimental? It seems useful enough t=
hat
> >> we could probably just add it as a fully-supported feature (dropping=
 the
> >> x- prefix) - but I'll leave that up to the migration maintainers.
> >>
> >=20
> > I thought that all new capabilities have x- prefix... May be it's rea=
lly
> > unnecessary here, I'm not sure.
>=20
> New features that need some testing or possible changes to behavior nee=
d
> x- to mark them as experimental, so we can make those changes without
> worrying about breaking back-compat.  But new features that are outrigh=
t
> useful and presumably in their final form, with no further
> experimentation needed, can skip going through an x- phase.
>=20
> >=20
> >> In fact, do we even need this to be a tunable feature? Why not just
> >> always enable it? As long as the UUID is sent in a way that new->old
> >> doesn't break the old qemu from receiving the migration stream, and =
that
> >> old->new copes with UUID being absent, then new->new will always ben=
efit
> >> from the additional safety check.
> >>
> >=20
> > In such case we couldn't migrate from e.g. 4.2 to 3.1
>=20
> I don't know the migration format enough to know if there is a way for
> 4.2 to unconditionally send a UUID as a subsection such that a receivin=
g
> 3.1 will ignore the unknown subsection. If so, then you don't need a
> knob; if not, then you need something to say whether sending the
> subsection is safe (perhaps default on in new machine types, but defaul=
t
> off for machine types that might still be migrated back to 3.1).  That'=
s
> where I'm hoping the migration experts will chime in.

Right; the migration format can't ignore chunks of data; so it does need
to know somehow; the choice is either a capability or wiring it to the
machine type;  my preference is to wire it to the machine type; the
arguments are:
    a) Machine type
       Pro: libvirt doesn't need to do anything
       Con: It doesn't protect old machine types
            It's not really part of the guest state

    b) Capability
       Pro: Works on all machine types
       Con: Libvirt needs to enable it

So, no strong preference but I think I prefer (a).

Dave

> --=20
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3226
> Virtualization:  qemu.org | libvirt.org
>=20



--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

