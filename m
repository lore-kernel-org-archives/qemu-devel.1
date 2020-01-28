Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13BFBC33C9E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 10:42:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D43522467E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 10:42:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QleiOTHn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D43522467E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwOJm-0003qZ-4H
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 05:42:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49267)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iwOHy-0000QB-7V
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 05:40:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iwOHw-0002mY-W2
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 05:40:10 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29548
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iwOHw-0002mJ-Ra
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 05:40:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580208008;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UvEH43SRCWad+s2by8ERmczOsieaoKG/DjhsXrp0vns=;
 b=QleiOTHna8joeQAMoXweds4fwavTrAgklEPWKAuWgyyA59NiPNRzQfDLNyy44CfLWx0BaQ
 cPNWpSuFURkUBm2CBdwfEQs1YpdUph6hxJeUeMqBxHSrfytmB3uIsRnKWo2gDaNkzimarC
 4xOqrIwNA9vs9E86ZdUwc5E1/CLa7zc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-127-Jfx_wHs-NvSDRXipNXGxqQ-1; Tue, 28 Jan 2020 05:39:59 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 82BC618C43C2;
 Tue, 28 Jan 2020 10:39:58 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-106.ams2.redhat.com [10.36.117.106])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0C2D960BE0;
 Tue, 28 Jan 2020 10:39:48 +0000 (UTC)
Date: Tue, 28 Jan 2020 11:39:47 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: Making QEMU easier for management tools and applications
Message-ID: <20200128103947.GB6431@linux.fritz.box>
References: <20200123190145.GI657556@redhat.com>
 <2561a069-ce5f-3c30-b04e-db7cd2fcdc85@redhat.com>
 <871rrp474i.fsf@dusky.pond.sub.org>
 <20200124102743.GB824327@redhat.com>
 <20200124143841.GG4732@dhcp-200-226.str.redhat.com>
 <87sgk3x2im.fsf@dusky.pond.sub.org>
 <20200127115606.GA5669@linux.fritz.box>
 <1c65b678-7bb4-a4cc-5fa6-03d6d27cf381@redhat.com>
 <CABgObfZNHP68i4xLEYhBw=cRFgXcKnUKnqEk_7LFseoeKizB=Q@mail.gmail.com>
 <20200128101622.GG1446339@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200128101622.GG1446339@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: Jfx_wHs-NvSDRXipNXGxqQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
 "Denis V. Lunev" <den@virtuozzo.com>, Cleber Rosa <cleber@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Dominik Csapak <d.csapak@proxmox.com>,
 John Snow <jsnow@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 28.01.2020 um 11:16 hat Daniel P. Berrang=E9 geschrieben:
> On Mon, Jan 27, 2020 at 11:38:49PM +0100, Paolo Bonzini wrote:
> > Il lun 27 gen 2020, 21:11 John Snow <jsnow@redhat.com> ha scritto:
> >=20
> > >
> > > > ./qemu-core <<EOF
> > > {
> > >     "machine": "Q35",
> > >     "memory": "2GiB",
> > >     "accel": "kvm"
> > > }
> > > EOF
> > >
> >=20
> > And now you have to keep all the syntactic sugar that is in vl.c. I don=
't
> > think a redesign of -readconfig should accept anything less verbose tha=
n
> >=20
> > - machine:
> >     type: q35
> >     ram:
> >        type: memory-backend-hostmem
> >        size: 2G
> > - accel:
> >   - type: kvm
> >=20
> > And this is not even taking into account disks.
> >=20
> > I like the idea of refactoring all the syntactic sugar into a pre-pass =
on
> > command line options. This is not an entirely new idea, see
> > https://www.mail-archive.com/qemu-devel@nongnu.org/msg35024.html.
> >=20
> > I am afraid that this thread is derailing a bit, with lots of pipe drea=
ms
> > and no actionable items. How do we get it back in track?
>=20
> To me the one thing that is clear. No matter what approach we want to
> take to QEMU configuration/interaction/CLI/etc, one critical bit of
> work is a pre-requisite...
>=20
> ...we must finish[1] the QAPI modelling of QEMU's features in some
> short, finite timeframe. We can't let it drag on for another 5 years
> or more. I'd say we need a timeframe that is 2 years max, preferrably
> 1 year.
>=20
> I don't think we can achieve this by leaving the task up to to the
> QAPI maintainers alone. It is unreasonable to put such a burden to
> on a small number of people to both implement & review it all. We
> need to consider it a project wide priority item so that we can get
> broader involvement across all maintainers, in closing the gaps.
>=20
> I'm not sure if we have any clear list of where our known gaps exist ?

I don't know about a full list, but I've been discussing command line
QAPIfication a bit with Markus recently because we had the idea of using
qemu-storage-daemon as a guinea pig for it.

The big one seems to be QOM (and qdev). object-add and device-add are
both not defined in terms of QAPI. One of them uses an "any" type (which
results in QObjects with arbitrary content being passed), the other one
"gen": false (which avoids generating anything from the schema).

I know that some more options exist that have unusual syntax and are
hard to convert to QAPI while maintaining command line compatibility.
Maybe that should be solved by just designing new options and
deprecating the old ones.

Kevin


