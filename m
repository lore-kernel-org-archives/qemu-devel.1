Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39CF9C54E8D
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 17:21:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08F67206D7
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 17:21:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BW9+Qzxx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08F67206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYC7D-00053b-3O
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 13:21:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33716)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jYC5i-0003KR-8o
 for qemu-devel@nongnu.org; Mon, 11 May 2020 13:19:46 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:48184
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jYC5g-0003Gg-DF
 for qemu-devel@nongnu.org; Mon, 11 May 2020 13:19:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589217582;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=ytChMxuyZk8sUO244ZoYR/VaCGgs8delvAwvozv+58o=;
 b=BW9+Qzxx4IIPCjKlKwmGk/F2zmeJPDzpBTKkHXiMdF6hgEIj8gcO8L7cqE9VKEPjKwXRKc
 3tmM9FnOqC/T7wzdP4+xYjHTKgsKE7eB4ZbsDktJe8k3+MEuEAhcrTpurNuMU/Czb+A6yx
 PcOxsDZmilIpiH3uDhovQuhRmEXo2/Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-aEXkpEQfNyWwSbZeQDZAgA-1; Mon, 11 May 2020 13:19:40 -0400
X-MC-Unique: aEXkpEQfNyWwSbZeQDZAgA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CF61A1005510;
 Mon, 11 May 2020 17:19:39 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.62])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2AE7C341FF;
 Mon, 11 May 2020 17:19:33 +0000 (UTC)
Date: Mon, 11 May 2020 18:19:30 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: B3r3n <B3r3n@argosnet.com>
Subject: Re: Qemu, VNC and non-US keymaps
Message-ID: <20200511171930.GS1135885@redhat.com>
References: <E1jY9FF-0000Po-2c@lists.gnu.org>
 <af732fbf-fd70-97bc-3ea8-25d66f5895de@redhat.com>
 <20200511151155.GO1135885@redhat.com>
 <20200511152957.6CFA8D1826@zmta04.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200511152957.6CFA8D1826@zmta04.collab.prod.int.phx2.redhat.com>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 03:10:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_EXCESS_BASE64=0.979, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: qemu-discuss@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=83=C2=A9?= <philmd@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 11, 2020 at 05:29:48PM +0200, B3r3n wrote:
> Hello Daniel,
> 
> > There is no mention here of what VNC client program is being used, which
> > is quite important, as key handling is a big mess in VNC.
> I tested with TightVNC & noVNC through Apache. Both behaves the same. I did
> not tested Ultr@VNC.

AFAIK, neithe TightVNC nor Ultra@VNC support the scancode extension.

noVNC does, for most modern browsers, so it might work if you remove
the -k arg from QEMU.

> > The default VNC protocol passes X11 keysyms over the wire.
> > 
> > The remote desktop gets hardware scancodes and turns them into keysyms,
> > which the VNC client sees. The VNC client passes them to the VNC server
> > in QEMU, which then has to turn them back into hardware scancodes. This
> > reverse mapping relies on knowledge of the keyboard mapping, and is what
> > the "-k fr" argument tells QEMU.
> > 
> > For this to work at all, the keymap used by the remote desktop must
> > match the keymap used by QEMU, which must match the keymap used by
> > the guest OS.  Even this is not sufficient though, because the act
> > of translating hardware scancodes into keysyms is *lossy*. There is
> > no way to reliably go back to hardware scancodes, which is precisely
> > what QEMU tries to do - some reverse mappings will be ambiguous.
> Yes, I saw that topic passing by. Looks messy with all these interferences...
> 
> > Due to this mess, years ago (over a decade) QEMU introduced a VNC
> > protocol extension that allows for passing hardware scancodes over
> > the wire.
> I guess I also crossed something about this on Internet.
> Are you talking of the RFB protocol ?

Yes, RFB protocol is the technical name for the VNC wire protocol.

> > With this extension, the VNC client gets the hardware scancode
> > from the remote desktop, and passes it straight to the VNC server,
> > which passes it straight to the guest OS, which then applies the
> > localized keyboard mapping.   This is good because the localized
> > keyboard mapping conversion is now only done once, in the guest
> > OS.
> > 
> > To make use of this protocol extension to VNC, you must *NOT*
> > pass any "-k" arg to QEMU, and must use a VNC client that has
> > support for this protocol extension.  The GTK-VNC widget supports
> > this and is used by virt-viewer, remote-viewer, virt-manager,
> > GNOME Boxes, Vinagre client applications.  The TigerVNC client
> > also supports this extension.
> So if I read you, if the client "enforce" this protocol (supposed RFB), Qemu
> will automatically uses it as well ?

The client should automatically activate the extension if QEMU advertizes
it, and QEMU advertizes it if you remove the -k arg.

> Removing -k option is great to me if it works, since user will have its own
> mapping and these are international :-)



> > To summarize, my recommendation is to remove the "-k" arg entirely,
> > and pick a VNC client that supports the scancode extension.
> For now I am using TightVNC & noVNC. noVNC is precious since it widens the
> user world, removing any client software constraint.

As above, noVNC ought to support the extension.

> 
> > It is possible there might be a genuine bug in QEMU's 'fr' keymap
> > that can be fixed to deal with AltGr problems. Personally though I
> > don't spend time investigating these problems, as the broad reverse
> > keymapping problem is unfixable. The only sensible option is to take
> > the route of using the VNC hardware scancode extension. It is notable
> > that SPICE learnt from VNC's mistake and used hardware scancodes from
> > the very start.
> 
> This was another path I intend to follow : using SPICE and a "noSPICE"
> client if VNC was too painful.
> If I understand you, using SPICE could also solve the issue ?
> 
> Many thanks for your inputs...

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


