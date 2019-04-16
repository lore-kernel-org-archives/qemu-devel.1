Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30389C10F13
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 08:42:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05F70206BA
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 08:42:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05F70206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33105 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGJfh-0006Vf-8E
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 04:42:29 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hGJeU-0005tU-4D
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 04:41:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hGJeT-0001wR-2u
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 04:41:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47920)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hGJeS-0001w7-QZ
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 04:41:13 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 113173082E6E;
	Tue, 16 Apr 2019 08:41:12 +0000 (UTC)
Received: from redhat.com (ovpn-112-50.ams2.redhat.com [10.36.112.50])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id AE01A60142;
	Tue, 16 Apr 2019 08:41:02 +0000 (UTC)
Date: Tue, 16 Apr 2019 09:40:59 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Bandan Das <bsd@redhat.com>
Message-ID: <20190416084059.GD31311@redhat.com>
References: <20190415154503.6758-1-berrange@redhat.com>
	<jpgk1fvp5wm.fsf@linux.bootlegged.copy>
	<20190415165426.GT5718@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190415165426.GT5718@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.46]);
	Tue, 16 Apr 2019 08:41:12 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 0/3] usb-mtp: fix ObjectInfo request
 handling
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>, Greg Kurz <groug@kaod.org>,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190416084059.3vv_MrXgfr4ewyeHrPOWTpQjdFpMXbFM5HFXDa77h4Y@z>

On Mon, Apr 15, 2019 at 05:54:26PM +0100, Daniel P. Berrang=C3=A9 wrote:
> On Mon, Apr 15, 2019 at 12:52:41PM -0400, Bandan Das wrote:
> > Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
> >=20
> > > Two previous attempts to fix this due to GCC 9 highlighting
> > > unaligned data access. My attempt:
> > >
> > >   https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg07763.ht=
ml
> > >
> > > And a previous one:
> > >
> > >   https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg07923.ht=
ml
> > >   https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg00162.ht=
ml
> > >
> > > There are a number of bugs in the USB MTP usb_mtp_write_metadata
> > > method handling the filename character set conversion.
> > >
> > > The 2nd patch in this series is a security flaw fix since the
> > > code was not correctly validating guest provided data length.
> > >
> > > I've been unable to figure out how to exercise the codepath that
> > > calls usb_mtp_write_metadata. At a guess, it looks like something
> > > that should be called when writing to a file from a guest, but the
> > > GNOME GVFS MTP driver doesn't provide write support. Using the
> > > command line MTP tools "mtp-sendfile" command results in an
> > > protocol error
> > >
> > >     # mtp-sendfile foo eek.txt
> > >     libmtp version: 1.1.14
> > >
> >=20
> > The store is read only by default. Are you trying something like:
> >  -device usb-mtp,rootdir=3D/code/mtpshare,readonly=3Dfalse ?
>=20
> Ah ha, I didn't realize I had to enable write support explicitly. Will
> retry with that.

Even after setting  readonly=3Dfalse, I still can't get "mtp-sendfile"
to succeed in a guest.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

