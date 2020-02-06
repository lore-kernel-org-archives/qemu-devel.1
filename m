Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A87C33CAC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 18:04:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12F6421741
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 18:04:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HWtOiIxM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12F6421741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izlVS-0001Z8-8c
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 13:04:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53458)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1izlUq-0001Ac-4q
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 13:03:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1izlUl-00061f-34
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 13:03:20 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:50697
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1izlUk-0005tC-MU
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 13:03:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581012197;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ehpupSTSlY2Bz1X1+tXxl5gti4mSOdHrmwd9pkSNB70=;
 b=HWtOiIxMj9hbMsSFDdvqK3mNMTTZSjA/nmts90AbcDmocrx8/UijQsXhRxejekrDIW8c+i
 0DN95+HV4Ke25zi9erjtbQESLrOHONyWpROq5FzCw18AFbizenZWMXLsUDMOaKcWpKeLIM
 kNjTMkaKVEYDYMHpFcgEJ31RyOCmy5Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-l8xH47JrO9WJKtbhwW7DVA-1; Thu, 06 Feb 2020 13:03:01 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F1BE25A09B;
 Thu,  6 Feb 2020 18:02:59 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.75])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AFC6C19C69;
 Thu,  6 Feb 2020 18:02:49 +0000 (UTC)
Date: Thu, 6 Feb 2020 18:02:47 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: qmp-shell for GSoC/Outreachy?
Message-ID: <20200206180247.GJ3655@work-vm>
References: <20200127143505.GD5669@linux.fritz.box>
 <20200127202925.GE3419@work-vm>
 <20200128105932.GC6431@linux.fritz.box>
 <20200205130946.GC5768@dhcp-200-226.str.redhat.com>
 <a45df5ab-3cad-0fbe-901f-4bc1ba28d38e@redhat.com>
 <20200205194944.GP3210@work-vm> <877e10xdd6.fsf@dusky.pond.sub.org>
 <20200206100920.GD2391707@redhat.com>
 <8736bnx6cx.fsf@dusky.pond.sub.org>
 <20200206121528.GG2391707@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200206121528.GG2391707@redhat.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: l8xH47JrO9WJKtbhwW7DVA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 "Denis V. Lunev" <den@virtuozzo.com>, Cleber Rosa <cleber@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Dominik Csapak <d.csapak@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Daniel P. Berrang=E9 (berrange@redhat.com) wrote:
> On Thu, Feb 06, 2020 at 01:11:58PM +0100, Markus Armbruster wrote:
> > Daniel P. Berrang=E9 <berrange@redhat.com> writes:
> >=20
> > > On Thu, Feb 06, 2020 at 10:40:37AM +0100, Markus Armbruster wrote:
> > >> > If the user screwsup, it should give an error that prompts the use=
r
> > >> > to the parameter they got wrong.
> > >> >
> > >> > Output from commands should normally be pretty formatted (with an =
option
> > >> > to display raw json for those needing it).
> > >> >   e.g. that 'query-version' should give either just the package
> > >> >   version (as info version currently does) or:
> > >> >       4.2.50  Package: v4.2.0-1188-gd95a3885a9
> > >> >
> > >> > We shouldn't lose any HMP commands that some people find useful
> > >> >   Ditching HMP isn't an option until we've got almost all of it
> > >> >   covered.
> > >>=20
> > >> In particular, we currently use HMP for debugging and monitoring
> > >> purposes, where we don't need or want QMP's rigor, neither its rigor=
ous
> > >> interface stability, nor its structured I/O.  We want the "whipuptit=
ude"
> > >> we get from monitor_printf().  This is actually a point David has ma=
de
> > >> several times.
> > >
> > > I'd like to argue that this decision to keep these debugging/monitori=
ng
> > > things in HMP only was a mistake, because it ensures that QEMU intern=
als
> > > need to keep HMP related code forever.
> > >
> > > What we actually need is a part of QMP that does not have the long te=
rm
> > > stability requirement, nor need for fully structured data. In fact th=
is
> > > pretty much already exists - we have declared the 'x-' prefix as a wa=
y
> > > to model QMP commands which are experimental / suboptimal / subject
> > > to change.
> > >
> > > I suggest that every HMP command which does not have a QMP equivalent
> > > should be turned into a QMP command with an "x-" prefix, with no
> > > extra modelling applied
> >=20
> > Makes sense (see my point about "allowing some [whipuptitude] in QMP"),
> > except I disagree with your example:
> >=20
> > > Take "info block"
> > >
> > > (hmp) info block
> > > ide1-cd0: [not inserted]
> > >     Attached to:      /machine/unattached/device[23]
> > >     Removable device: not locked, tray closed
> > >
> > > floppy0: [not inserted]
> > >     Attached to:      /machine/unattached/device[16]
> > >     Removable device: not locked, tray closed
> > >
> > > sd0: [not inserted]
> > >     Removable device: not locked, tray closed
> > >
> > >
> > > I suggest we support it as "x-query-block"
> > >
> > > (qmp) x-query-block
> > > {
> > >     "return": {
> > >         "info": "ide1-cd0: [not inserted]
> > >     Attached to:      /machine/unattached/device[23]
> > >     Removable device: not locked, tray closed
> > >
> > > floppy0: [not inserted]
> > >     Attached to:      /machine/unattached/device[16]
> > >     Removable device: not locked, tray closed
> > >
> > > sd0: [not inserted]
> > >     Removable device: not locked, tray closed"
> > >     }
> > > }
> >=20
> > This commmand does have a QMP equivalent: query-block.
>=20
> Doh, I should have actually checked before picking a random
> example :-)
>=20
> >=20
> > Hmm, no more.  It actually wraps around both query-block and
> > query-named-block-nodes now.  I think that makes it an example of "go
> > beyond 1:1".
> >=20
> > A better example for "allowing whipuptitude" would be "info registers".
>=20
> Yep, that's a classic that would be horribly painful to try to represent
> as a fully structured set of arrays & dicts for all architectures.

'info registers' is a challenge for JSON since it's all 64bit unsigned
int's;  you really want the result to be in hex, and definitely not to
have been randomly sign extended or truncated, or converted to float or
whatever other evils a json processor might do.  So the user wants
a nice consistent format.

'info qtree' and 'info mtree' are other interesting cases that I use
very frequently.

Dave



>=20
> Regards,
> Daniel
> --=20
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


