Received: from eggs.gnu.org ([2001:4830:134:3::10]:55071)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1db21D-0001hH-44
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 05:57:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1db21A-00013q-HY
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 05:57:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53886)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1db21A-00013D-CI
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 05:57:12 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0C00AC050302
	for <qemu-devel@nongnu.org>; Fri, 28 Jul 2017 09:57:11 +0000 (UTC)
Message-ID: <1501235829.10943.11.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 28 Jul 2017 11:57:09 +0200
In-Reply-To: <20170728082826.GE31495@redhat.com>
References: <20170727140025.392-1-kraxel@redhat.com>
	<20170727140025.392-5-kraxel@redhat.com>
	<20170727174522.GA29600@redhat.com>
	<1501222909.10943.1.camel@redhat.com>
	<20170728082826.GE31495@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 4/7] ui: add multimedia keys
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>

  Hi,

> > > Missing Q_KEY_CODE_MEDIASELECT entry - presumably it was supposed
> > > to map to=C2=A0=C2=A0KEY_MEDIA
> >=20
> > There is KEY_SELECT too, but not KEY_MEDIASELECT.=C2=A0=C2=A0Hmm.
>=20
> I found a keyboard with a key labelled "Media"=C2=A0=C2=A0and when pres=
sed
> it generates Linux key 171=C2=A0=C2=A0/ AT set1=C2=A0=C2=A00xe0 0x01 wh=
ich is KEY_CONFIG
> and GNOME pops up the control panel when pressed !

Oh joy!

I guess we should just leave that unmapped for 2.10 and sort it later
when switching to keycodemapdb ...

> Would be interested to know results of "showkey" and "showkey -s" for
> any other keyboards with a key labelled "Media", since I don't
> entirely
> trust this particular one to be representative of general usage.

I don't have any.   Seems those multimedia keyboards with lots of extra
keys are out-of-fashion these days, with only a few keys (like volume)
still being in use.

cheers,
  Gerd
