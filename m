Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E87C3F2CD
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 10:47:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66AE320836
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 10:47:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DbeqRp0f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66AE320836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45253 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j955B-0001nF-IC
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 05:47:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58637)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1j954L-0000sV-F9
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 05:46:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1j954K-0002YY-5d
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 05:46:33 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54546
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1j954K-0002YM-1W
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 05:46:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583232391;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QHrFqrOTptBWVQhAXTwiXRdaMbqdHcJbIK7j8dckjvs=;
 b=DbeqRp0fdEcz1vhZjl/jdgTxrn4EopHB2Jffvj2oCg73GIAXN63K+vtd9wVIv4twS5Uw/P
 Hl/ggglLVz6lzRhw8AOnYZiqxYhz6umaXEmFnYEv9wlAWOjZ/bd7mOxGTYR0exzMT3nJuP
 ORI3TeYGpj1fSno1Kkxx53stQOQOJrI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-53-Uo7eYJnLOUSwK__c_VtnzA-1; Tue, 03 Mar 2020 05:46:29 -0500
X-MC-Unique: Uo7eYJnLOUSwK__c_VtnzA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C4D5A10CE782;
 Tue,  3 Mar 2020 10:46:28 +0000 (UTC)
Received: from redhat.com (ovpn-112-56.ams2.redhat.com [10.36.112.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BAB2548;
 Tue,  3 Mar 2020 10:46:27 +0000 (UTC)
Date: Tue, 3 Mar 2020 10:46:24 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thorsten Glaser <t.glaser@tarent.de>
Subject: Re: qemu-system-x86_64: warning: Unknown X11 keycode mapping '<null>'.
Message-ID: <20200303104624.GC1773352@redhat.com>
References: <alpine.DEB.2.22.394.2003020002570.23029@tglase.lan.tarent.de>
 <20200302102841.GD1679990@redhat.com>
 <alpine.DEB.2.22.394.2003021336010.14371@tglase.lan.tarent.de>
 <20200302130353.GL1679990@redhat.com>
 <alpine.DEB.2.22.394.2003021901160.14371@tglase.lan.tarent.de>
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2003021901160.14371@tglase.lan.tarent.de>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Mar 02, 2020 at 07:19:04PM +0100, Thorsten Glaser wrote:
> On Mon, 2 Mar 2020, Daniel P. Berrang=C3=A9 wrote:
>=20
> > There's two translations happening
> >=20
> >  * The scancode emitted by the kernel and/or hardware device,
> >    and then translated/mangled by X11 and reported as the
> >    hardware keycode
> >=20
> >  * The keysym which is the mapping from the hardware keycode
> >    done by XKB and/or Xmodmap
>=20
> Yes, sure.
>=20
> > We're dealing with the first point in QEMU, taking the hardware
> > keycode and trying to undo the X11 mangling that was performed.
>=20
> That=E2=80=99s where VNC often fails, generally, anyway=E2=80=A6 (asd oft=
en get
> translated back as adf).
>=20
> > > But if I can do anything to help debugging this, sure.
> >=20
> > Can you launch 'xev' inside your VNC session and press the 'Page Up'
> > button and let me know what it reports the keycode and keysym.
>=20
> Sure.
>=20
> > Specifically I'm interested in this line of text:
> >=20
> >     state 0x0, keycode 112 (keysym 0xff55, Prior), same_screen YES,
> >=20
> > On evdev it reports 112 as hardware code which is 0x70 hex, while with
> > 'kbd' it reports 99 which is 0x63 hex. These are the only two scenarios
> > QEMU knows how to cope with.
>=20
> Then we=E2=80=99re somewhat out of luck:
>=20
> KeyPress event, serial 35, synthetic NO, window 0x1000001,
>     root 0x25, subw 0x0, time 2624181177, (244,533), root:(250,560),
>     state 0x0, keycode 71 (keysym 0xff55, Prior), same_screen YES,
>     XLookupString gives 0 bytes:
>     XmbLookupString gives 0 bytes:
>     XFilterEvent returns: False

This is all rather unfortunate, as I can't determine the well known
scancode set that this matches so far. So I'll definitely have to
investigate the source to understand what's going on.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


