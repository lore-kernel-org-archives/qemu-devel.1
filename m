Received: from eggs.gnu.org ([2001:4830:134:3::10]:33597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dBO2J-0002WL-Ag
	for qemu-devel@nongnu.org; Thu, 18 May 2017 12:12:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dBO2F-0005HI-B1
	for qemu-devel@nongnu.org; Thu, 18 May 2017 12:12:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51324)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dBO2F-0005HC-52
	for qemu-devel@nongnu.org; Thu, 18 May 2017 12:12:19 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B9E9B8050D
	for <qemu-devel@nongnu.org>; Thu, 18 May 2017 16:12:17 +0000 (UTC)
Message-ID: <1495123936.627.27.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 18 May 2017 18:12:16 +0200
In-Reply-To: <7d426658-c6ff-5eb0-025a-e421c5773703@redhat.com>
References: <20170512122158.32032-1-kraxel@redhat.com>
	<20170512122158.32032-7-kraxel@redhat.com>
	<a4f99c9b-1fb4-8a0c-ec3b-0cadc7dfd382@redhat.com>
	<728dca25-a9ef-a061-dee7-c5b4309ca8dc@redhat.com>
	<6d9941a5-268c-9bc2-4122-64f023dfaa51@redhat.com>
	<7d426658-c6ff-5eb0-025a-e421c5773703@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PULL 6/6] hw/usb/dev-serial: Do not try to set
 vendorid or productid properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

  Hi,

> >> Feel free to send an additional cleanup patch ... otherwise, I'd say l=
et
> >> it bitrot for another year and we then remove it completely together
> >> with all the other "-usbdevice" functions...
> >=20
> > Well, Coverity reports it so I'd rather keep it clean...

It will be clean once removed, I likewise wouldn't put too much effort
into code which is scheduled for removal anyway, especially for more or
less cosmetic issues like unreachable code.

> Hmm, maybe we should simply remove "-usbdevice serial" right now already
> ... ? The vendorid/productid parameter handling has been broken since
> QEMU v0.14 already and nobody ever complained, so I guess hardly anybody
> is using "-usbdevice serial" anymore ... so I tend to simply remove it
> directly instead of going through the typical "mark-as-deprecated ->
> wait-two-release-cycles -> finally-remove-it" process here...

Hmm, there is little reason to set vendorid + productid, so that alone
is no strong indication that -usbdevice serial is unused.  But
nevertheless I think it usb-serial is one of the rarely used devices, so
we could try ...

Order is probably along these lines:

usb hid devices are used alot (tablet on x86, all on !x86).
usb-storage comes next I guess.
usb-host (aka pass-through) is important too of course.

Everything else (serial, net, bluetooth) is largely unused I guess.

ccid, uas and mtp are new enough to not carry around -usbdevice
compatibility support.

cheers,
  Gerd
