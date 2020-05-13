Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29131CA90AF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 08:39:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E264C20740
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 08:39:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=argosnet.com header.i=@argosnet.com header.b="LviBjDdM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E264C20740
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=argosnet.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYmvZ-0004rR-2p
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 04:39:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34582)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <B3r3n@argosnet.com>)
 id 1jYmun-0003jN-Jq; Wed, 13 May 2020 04:38:57 -0400
Received: from mx.argosnet.com ([51.255.124.196]:16607)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <B3r3n@argosnet.com>)
 id 1jYmul-0003PD-Oe; Wed, 13 May 2020 04:38:57 -0400
Received: from mx.argosnet.com (Argosnet [51.255.124.196])
 by mx.argosnet.com (Postfix) with ESMTP id BA33A4769F;
 Wed, 13 May 2020 10:38:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=argosnet.com; h=date:to
 :from:subject:cc:in-reply-to:references:mime-version
 :content-type:content-transfer-encoding; s=mx; bh=mnaGne3jQy8oBx
 C4lu0+KflVJnM=; b=LviBjDdMukzt0WU5WA84nh93qzkZnNRQqwQSkNSYH6diNE
 HoNaMu81sVTyz61XZCj97yDg0k9qmXVMtBu5P3FDBCTbFFjE6j/XxyJdD7oVJbxb
 sZy9Nn3+mWu9VdkYacze6EG29NuoN+jhU0hcjn+Z/9rUDELvEVQKBEGqeYWbQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=argosnet.com; h=date:to:from
 :subject:cc:in-reply-to:references:mime-version:content-type
 :content-transfer-encoding; q=dns; s=mx; b=MaUeplUCvsawXMnX9imCy
 8SZ5lQbn6XGgp0uurUlR1aPR9PL8r4DQd1A0qM19XjR6KlYfGIWC3qRhC81/XTLD
 LM/RAjRy4Zq9gRRgWvZffTm/xUVJpBfZXZHa6dnN3Q9JSSzre4gkeAfPjC/9YhVB
 /4lqK6MpY0i7WjeMHudFzs=
Received: from Osgiliath.argosnet.com
 (lfbn-nic-1-419-246.w90-116.abo.wanadoo.fr [90.116.244.246])
 (Authenticated sender: llevier@pop.argosnet.com)
 by mx.argosnet.com (Postfix) with ESMTPSA id 905134769E;
 Wed, 13 May 2020 10:38:50 +0200 (CEST)
X-Mailer: QUALCOMM Windows Eudora Version 7.1.0.9
Date: Wed, 13 May 2020 10:38:52 +0200
To: Daniel P. =?iso-8859-1?Q?Berrang=C3=A9?= <berrange@redhat.com>
From: B3r3n <B3r3n@argosnet.com>
Subject: Re: Qemu, VNC and non-US keymaps
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=C3=83?= ?
 =?iso-8859-1?Q?=C3=82=C2=A9?= <philmd@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-discuss@nongnu.org
In-Reply-To: <20200512091106.GH1191162@redhat.com>
References: <E1jY9FF-0000Po-2c@lists.gnu.org>
 <af732fbf-fd70-97bc-3ea8-25d66f5895de@redhat.com>
 <20200511151155.GO1135885@redhat.com>
 <20200511152957.6CFA8D1826@zmta04.collab.prod.int.phx2.redhat.com>
 <20200511171930.GS1135885@redhat.com>
 <20200512074530.8729D1892D3@zmta01.collab.prod.int.phx2.redhat.com>
 <20200512091106.GH1191162@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=51.255.124.196; envelope-from=B3r3n@argosnet.com;
 helo=mx.argosnet.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 04:38:53
X-ACL-Warn: Detected OS   = FreeBSD  [generic] [fuzzy]
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_MUA_EUDORA=0.001, MISSING_MID=0.497, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
Message-Id: <E1jYmun-0003jN-Jq@lists.gnu.org>
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello Daniel,

Ok, TigerVNC, added -shared=3D1 to behave the same=20
as TightVNC, works greatly, Thanks !

But funny thing, I saw you were part of exchanges=20
on that topic, noVNC totally fails now.
Despite my keyboard isnt changed, debian VM is=20
just in QWERTY as if noVNC only send keysyms.

If you know how to force noVNC keycodes instead, digging to find the trick=
 :-(

Thanks

Brgrds

At 11:11 12/05/2020, Daniel P. Berrang=C3=A9 wrote:
>On Tue, May 12, 2020 at 09:45:20AM +0200, B3r3n wrote:
> > Hello Daniel, all,
> >
> > I am a bit confused.
> >
> > Ok, RFB protocol should be the solution that solves all, sending=
 scancodes
> > rather than doing keysyms stuff. No pb for me.
> > So I removed my '-k fr' to my Qemu VM start as it was before.
> >
> > However, reading TightVNC & noVNC docs, both are able to perform RFB.
>
>VNC =3D=3D RFB - they're two different terms of the same thing.
>
>The core RFB/VNC protocol only knows about keysyms.
>
>Hardware scancodes is an extension defined by QEMU, and GTK-VNC, and since
>implemented by TigerVNC.
>
>Removing the "-k" arg, merely enables use of the scancode extension.
>This requires a compatible client app that knows the scancode extension.
>If the client doesn't support scancodes, it will continue using keysyms,
>which will then be treated as plain us keymap.
>
>AFAIK,  TightVNC doesn't support the scancode extension, only TigerVNC.
>
> > Since these explanations, I replayed a bit:
> >
> > Under my testing Debian 10, I redefined keyboard to French + No compose=
 key
> > + AltGr as CTRL_R
>
>This is a key example of the problems of VNC's traditional key handling.
>
>QEMU has a single keymap "fr". It has no way of selecting compose key
>on/off, or overriding AltGr to be CtrlR.  So as soon as you do that on
>your local desktop, you make it impossible to QEMU VNC serve to work
>correctly.
>
> >
> > Under noVNC: Ctrl_R works well as alternative but when using AltGr, I
> > received 29+100+7 (AltGr + 6) and keep displaying a minus as with AltGr=
 was
> > not pressed.
> >
> > Under TightVNC (2.7.10) : Ctrl_R displays characters, I am still in=
 QWERTY
> > for letters, weird mapping for other characters, did not checked if
> > compliant with whatever definition.
> > Under TightVNC (last 2.8.27, supposed to be able to RFB): Ctrl_R=
 displays
> > nothing, keys are QWERTY. Seems the same as TightVNC 2.7.10.
> >
> > With the keyboard defining AltGr as AltGr, no change.
> >
> > I realize that AltGr is sending 29+100 (seen via showkey), when CTRL_R=
 only
> > sends 97.
> > When using a remote console (iLo and iDRAC), AltGr only sends 100.
> >
> > I wonder if the issue would not also be the fact AltGr sends 2 codes,=
 still
> > another one to select the character key (6 for example).
> >
> > Is that normal Qemu is transforming AltGr (100) in 29+100 ?
>
>It is hard to say without seeing debuging to see what QEMU received.
>
>Regards,
>Daniel
>--
>|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
>|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
>|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


