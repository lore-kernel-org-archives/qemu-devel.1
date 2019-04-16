Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CACD9C10F13
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 16:53:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F207206B6
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 16:53:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F207206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39664 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGRKf-0003wW-RF
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 12:53:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58486)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hGRJt-0003fj-Eb
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 12:52:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hGRJs-0005sg-8I
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 12:52:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58088)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hGRJr-0005sA-Uh
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 12:52:28 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F048830ADBB9;
	Tue, 16 Apr 2019 16:52:26 +0000 (UTC)
Received: from redhat.com (ovpn-112-50.ams2.redhat.com [10.36.112.50])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C811160143;
	Tue, 16 Apr 2019 16:52:20 +0000 (UTC)
Date: Tue, 16 Apr 2019 17:52:17 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Bandan Das <bsd@redhat.com>
Message-ID: <20190416165217.GV31311@redhat.com>
References: <20190415154503.6758-1-berrange@redhat.com>
	<jpgk1fvp5wm.fsf@linux.bootlegged.copy>
	<20190415165426.GT5718@redhat.com>
	<20190416084059.GD31311@redhat.com>
	<jpglg0a3p93.fsf@linux.bootlegged.copy>
	<20190416161242.GU31311@redhat.com>
	<jpgwojtoq5r.fsf@linux.bootlegged.copy>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <jpgwojtoq5r.fsf@linux.bootlegged.copy>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.47]);
	Tue, 16 Apr 2019 16:52:27 +0000 (UTC)
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
	Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org,
	Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190416165217.1S7ArD-MTwwEH2GptHOH2703JGOC2gP1xMIUj58vTLE@z>

On Tue, Apr 16, 2019 at 12:45:04PM -0400, Bandan Das wrote:
> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>=20
> > On Tue, Apr 16, 2019 at 12:10:16PM -0400, Bandan Das wrote:
> >> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
> >> ...
> >> >> > The store is read only by default. Are you trying something lik=
e:
> >> >> >  -device usb-mtp,rootdir=3D/code/mtpshare,readonly=3Dfalse ?
> >> >>=20
> >> >> Ah ha, I didn't realize I had to enable write support explicitly.=
 Will
> >> >> retry with that.
> >> >
> >> > Even after setting  readonly=3Dfalse, I still can't get "mtp-sendf=
ile"
> >> > to succeed in a guest.
> >> >
> >> I posted a patch for a bug introduced by a recent commit that made s=
maller
> >> file sizes return back with a incomplete file transfer.
> >>=20
> >> https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg02552.html
> >
> > Yes, I applied that and didn't see any difference in behaviour
> >
>=20
> Just noticed the error message you posted:
>=20
>     Error sending file.
>     Error 2: PTP Layer error 02ff: send_file_object_info(): Could not s=
end object info.
>     Error 2: Error 02ff: PTP I/O Error
>     ERROR: Could not close session!
>=20
> I can't find usb-mtp sending a "I/O error" on an error condition
> for the objectinfo phase. It might be libmtp or even the command itself
> failing for some reason. For incomplete transfer, I just checked, it's
> spitting out the error message correctly as INCOMPLETE_FILE_TRANSFER.
>=20
> With libmtp version 1.13 on a FC24 guest, here's the output:
>=20
> $ mtp-sendfile test.txt test.img
> libmtp version: 1.1.13
>=20
> Device 0 (VID=3D46f4 and PID=3D0004) is UNKNOWN in libmtp v1.1.13.
> Please report this VID/PID and the device model to the libmtp developme=
nt team
> ignoring libusb_claim_interface() =3D -6PTP_ERROR_IO: failed to open se=
ssion, trying again after resetting USB interface
> LIBMTP libusb: Attempt to reset device
> Sending test.txt to test.img
> type: txt, 44
> Sending file...
> Progress: 322 of 322 (100%)
> New file ID: 7
>=20
> What guest is this ? I can try to reproduce.

This was Fedora 26, so technically it is end of life, but then so
is your F24 guest :-)

Should really check with a modern guest like Fedora 29 or rawhide.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

