Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEEDBC04AA7
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 14:22:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFE1C2084F
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 14:22:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFE1C2084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58160 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQBqo-0005Ab-SL
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 10:22:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36696)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hQBlJ-0000f5-1f
	for qemu-devel@nongnu.org; Mon, 13 May 2019 10:17:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hQBeg-00087u-5o
	for qemu-devel@nongnu.org; Mon, 13 May 2019 10:10:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47642)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hQBef-00087Z-WD
	for qemu-devel@nongnu.org; Mon, 13 May 2019 10:10:14 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 334EF85363
	for <qemu-devel@nongnu.org>; Mon, 13 May 2019 14:10:13 +0000 (UTC)
Received: from redhat.com (unknown [10.42.22.189])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A056663F84;
	Mon, 13 May 2019 14:10:09 +0000 (UTC)
Date: Mon, 13 May 2019 15:10:07 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Message-ID: <20190513141007.GK15029@redhat.com>
References: <20190430131919.GN6818@redhat.com> <20190430144546.GA3065@work-vm>
	<20190430150556.GA2423@redhat.com>
	<87sgtqejn9.fsf@dusky.pond.sub.org>
	<20190507093954.GG27205@redhat.com>
	<875zql3ylk.fsf@dusky.pond.sub.org>
	<20190513120856.GH15029@redhat.com>
	<87ef525uls.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87ef525uls.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.25]);
	Mon, 13 May 2019 14:10:13 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] QMP; unsigned 64-bit ints;
 JSON standards compliance
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: libvir-list@redhat.com, =?utf-8?Q?J=C3=A1n?= Tomko <jtomko@redhat.com>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 13, 2019 at 03:53:19PM +0200, Markus Armbruster wrote:
> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>=20
> > On Wed, May 08, 2019 at 02:44:07PM +0200, Markus Armbruster wrote:
> [...]
> >> Double-checking: do you propose to encode *all* numbers as strings, =
or
> >> just certain "problematic" numbers?
> >>=20
> >> If the latter, I guess your idea of "problematic" is "not representa=
ble
> >> exactly as double precision floating-point".
> >
> > We have a few options
> >
> >  1. Use string format for values > 2^53-1, int format below that
> >  2. Use string format for all fields which are 64-bit ints whether
> >     signed or unsigned
> >  3. Use string format for all fields which are integers, even 32-bit
> >     ones
> >
> > I would probably suggest option 2. It would make the QEMU impl quite
> > easy IIUC, we we'd just change the QAPI visitor's impl for the int64
> > and uint64 fields to use string format (when the right capability is
> > negotiated by QMP).
> >
> > I include 3 only for completeness - I don't think there's a hugely
> > compelling reason to mess with 32-bit ints.
>=20
> Agree.
>=20
> > Option 1 is the bare minimum needed to ensure precision, but to me
> > it feels a bit dirty to say a given field will have different encodin=
g
> > depending on the value. If apps need to deal with string encoding, th=
ey
> > might as well just use it for all values in a given field.
>=20
> I guess that depends on what this interoperability capability does for
> QMP *input*.
>=20
> For *output*, QEMU has to encode a number either as JSON number or as
> JSON string
>=20
> For *input*, QEMU could accept either.  Or it could accept only the
> encoding it produces on output.
>=20
> Got a preference?

IMHO if a mgmt app enables the (hypothetically named) "int64-as-string"
capability, then we should be strict and require string format on both
input & output. If QEMU accepted either, it would silently hide bugs
where the app has mistakenly not used string formatting.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

