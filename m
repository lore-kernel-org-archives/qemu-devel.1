Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7563CC33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 14:37:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 407352087F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 14:37:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RXju2+L9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 407352087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iopyl-000270-4R
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 09:37:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36731)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iooQu-0002bb-9d
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 07:58:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iooQs-00031Y-IF
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 07:58:04 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30221
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iooQs-00030I-Di
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 07:58:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578401880;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Lnm4z2DqRHL/fUiTCfd3orJtiQGyrXovNTMmbQzFnPs=;
 b=RXju2+L90UW9MKfmLsLignxR1HsdpDNzOCu5H1mRR0VcgDi95F5VfWUsNpr1SDZ10KR96B
 3cRXMErC4WvvuRKkGEoqOTe9kkm6LPvGbpw2SfjyxMFGknUVK1Z2v+Na8c6iFU28G8Mp+h
 CCXQfKAvuQ+1iZGDQh/9K1nP3AsidXE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-2iS-BO85MQmAObslLaw7Bw-1; Tue, 07 Jan 2020 07:57:58 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 95D78801E72;
 Tue,  7 Jan 2020 12:57:57 +0000 (UTC)
Received: from linux.fritz.box (ovpn-116-78.ams2.redhat.com [10.36.116.78])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B618760BE2;
 Tue,  7 Jan 2020 12:57:46 +0000 (UTC)
Date: Tue, 7 Jan 2020 13:57:45 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Michal Privoznik <mprivozn@redhat.com>
Subject: Re: Making QEMU easier for management tools and applications
Message-ID: <20200107125745.GJ4076@linux.fritz.box>
References: <CAJSP0QUk=4co-nqk8fv2n-T2_W40rE3r_5OMoxD7otAV993mCA@mail.gmail.com>
 <87h81unja8.fsf@dusky.pond.sub.org>
 <c445ecbe-1559-462a-31c2-f44f60e60a8b@redhat.com>
 <20200107093655.GF4076@linux.fritz.box>
 <d18b8c0f-3054-dd63-0d10-dda6d0655175@redhat.com>
MIME-Version: 1.0
In-Reply-To: <d18b8c0f-3054-dd63-0d10-dda6d0655175@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 2iS-BO85MQmAObslLaw7Bw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, Cleber Rosa <cleber@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Dominik Csapak <d.csapak@proxmox.com>,
 John Snow <jsnow@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 07.01.2020 um 11:55 hat Michal Privoznik geschrieben:
> On 1/7/20 10:36 AM, Kevin Wolf wrote:
> > The easy way out would be tying libvirt to a specific QEMU version. And
> > I'm only half joking.
> >=20
> > If libvirt didn't exist yet and we needed a management library for QEMU=
,
> > what we would build now would probably not look much like libvirt looks
> > today. We wouldn't try to have basic support for every hypervisor out
> > there, but integrate it much closer with QEMU and avoid much of the
> > backwards compatibility requirements that the interface between QEMU an=
d
> > libvirt has (which requires us to deal with compatibility twice for
> > everything).
>=20
> By doing this, you would force your consumers to implement compatibility
> layer each on their own. Freshly finished blockdev is a beautiful example=
 -
> OpenStack, oVirt and whatnot - they all are/can use blockdev without even
> noticing, because the API provided by libvirt is stable and provides
> abstraction, i.e. you don't need to change anything in your domain XML to
> use blockdev.

Yes and no.

You could still keep using the same abstraction that libvirt has always
used while doing this. What my imaginary newly written management
library would do differently isn't necessarily the interface between
libvirt and applications, but getting rid of backwards compatibility
requirements in the interface between QEMU and libvirt.

But of course, blockdev isn't even a feature per se. It's getting the
abstraction right so that it's actually abstract enough to represent
everything. As long as libvirt keeps using an abstraction that is based
on simplistic setups, it won't be able to expose the full feature set of
QEMU. This is less than satisfying. In the long run, libvirt will have
to extend its abstraction to make full use of new features either way.

> Of course, you can apply the argument one more time and have mgmt
> application tied to a specific version of qemu. But even that is not
> good enough, because with backports version is just meaningless
> number.

I think this would be too much indeed.

> > Maybe it would even be part of the QEMU repository, allowing a single
> > patch series to implement a new feature in the system emulator and
> > expose it in the API immediately instead of waiting for the next QEMU
> > release before libvirt can even think about implementing support for it=
.
>=20
> Thing is, it's not just qmp that a mgmt application has to master, it's a=
lso
> process managing (and with growing number of helper binaries this is not =
as
> trivial as fork() + exec()). This would need to be the bare minimum your =
API
> layer has to provide to be consumable by anybody.
> But then you have some advanced subsystems to take care of (CGroups,
> SELinux, etc.) which are used heavily by OpenStack. oVirt and friends.

Someone has to do this anyway. Note that here I'm still talking about
the hypothetical case where no libvirt existed yet.

If we cared only about OpenStack, oVirt and friends, this would still
all be QEMU-based, so not a big problem to have it tied to QEMU.

I'm not sure what this looks like in practice in libvirt: Are these
components shared between multiple hypervisor interfaces or is it only
for QEMU anyway?

If multiple hypervisors make use of it, how crazy would it be to imagine
reversing which project consumes which? Instead of having the libvirt
core consume the hypervisor-specific sublibraries, could a QEMU-specific
part live closer to QEMU and consume the libvirt core as an external
library?

I guess much of what I write in this thread is pure heresy. :-)
Maybe most of it isn't even useful. But maybe there is an idea or two in
it that are worth having a closer look at.

> > So should libvirt move in that direction? Do people actually still make
> > much use of its multi-hypervisor nature, or would it make sense to spli=
t
> > it into separate libraries for each hypervisor that can be much tighter
> > integrated with (a specific version of) the respective hypervisor?
>=20
> Truth to be told, I don't think libvirt is held back by its attempts to
> provide hypervisor agnostic APIs. Sure, it leads to some weirdness (e.g.
> different naming in libvirt and qemu), but as a libvirt developer I don't
> remember feeling blocked by this multi-hypervisor nature (not to mention
> that this has saved us couple of times).

I would imagine so, because the problem doesn't become visible in the
daily work, but only in the bigger picture: The other hypervisors are
what prevent libvirt from being more tightly intergrated with QEMU.

This means that there is a boundary between QEMU and libvirt that makes
it really slow to get new features to the user. And both QEMU and
libvirt waste a lot of time for maintaining backwards compatibility in
things that wouldn't necessarily have to be stable interfaces if the
management library were developed in lockstep with QEMU.

> Also, it would be not correct to think that a feature is implemented for =
all
> hypervisors in libvirt. I mean, when implementing a feature I usually
> implement it only for qemu driver and don't even look at other drivers
> (unless I'm doing a change in a core that causes build failures). On the
> other hand, I do sometimes review patches posted by developers from other
> companies which have interest in different hypervisors (e.g. there is a S=
USE
> guy working on LXC driver, and another SUSE guy working on libxenlight
> (basically Xen)), so I do spend some time not working on qemu driver, but
> I'd say it's negligible.

Time spent on non-QEMU isn't really my concern. Time spent maintaining
stable interface between QEMU and libvirt, and time spent waiting for
QEMU releases before libvirt development starts are my concern.

Kevin


