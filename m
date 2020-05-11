Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75999C54E4B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 20:28:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48996206E6
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 20:28:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=argosnet.com header.i=@argosnet.com header.b="JhPyTxF1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48996206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=argosnet.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYF2B-0002bq-GM
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 16:28:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42322)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <B3r3n@argosnet.com>)
 id 1jYANP-00066g-4e; Mon, 11 May 2020 11:29:55 -0400
Received: from mx.argosnet.com ([51.255.124.196]:36735)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <B3r3n@argosnet.com>)
 id 1jYANN-0005CI-9K; Mon, 11 May 2020 11:29:54 -0400
Received: from mx.argosnet.com (Argosnet [51.255.124.196])
 by mx.argosnet.com (Postfix) with ESMTP id 879BB3B422;
 Mon, 11 May 2020 17:29:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=argosnet.com; h=date:to
 :from:subject:cc:in-reply-to:references:mime-version
 :content-type; s=mx; bh=mw+EfNiMyMHb0xwdYmKl7xgxEzo=; b=JhPyTxF1
 TE2/xXNQHVki6nsMZyW9cK+ZgdK04112DtyXYxI9J3mi+rY7Luh4yCRpKiPi9eg5
 2Vw/R+EVD/oErxqyJEgnHewo0/d3npqkTw+u53S+KnVZESawT9YZQdaXPl6a22rx
 8NOYQCNHsJPq/XqTYvKlIgK9UXuESLO6jes=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=argosnet.com; h=date:to:from
 :subject:cc:in-reply-to:references:mime-version:content-type; q=
 dns; s=mx; b=MWhBYlQSaDlnuIru3hV504tLtMSAPw72v7KR/RLT5z2+XH1aabA
 R82SCzgoQqgtb4ySURxo9Pj8hO3CnnzVNIPsdXcqJmqj+nK9QTtH7IMwZCIIQSB7
 tfOn4oNyXx7HwfdwVgoF2SqzUTL8aBy/vy4bdcg+dW9NEbn+M8sVD2Q4=
Received: from Osgiliath.argosnet.com
 (lfbn-nic-1-419-246.w90-116.abo.wanadoo.fr [90.116.244.246])
 (Authenticated sender: llevier@pop.argosnet.com)
 by mx.argosnet.com (Postfix) with ESMTPSA id 5347D3B421;
 Mon, 11 May 2020 17:29:49 +0200 (CEST)
X-Mailer: QUALCOMM Windows Eudora Version 7.1.0.9
Date: Mon, 11 May 2020 17:29:48 +0200
To: Daniel P. =?iso-8859-1?Q?Berrang=C3=A9?= <berrange@redhat.com>
From: B3r3n <B3r3n@argosnet.com>
Subject: Re: Qemu, VNC and non-US keymaps
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, B3r3n <B3r3n@argosnet.com>,Gerd 
 Hoffmann <kraxel@redhat.com>, qemu-discuss@nongnu.org
In-Reply-To: <20200511151155.GO1135885@redhat.com>
References: <E1jY9FF-0000Po-2c@lists.gnu.org>
 <af732fbf-fd70-97bc-3ea8-25d66f5895de@redhat.com>
 <20200511151155.GO1135885@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Received-SPF: pass client-ip=51.255.124.196; envelope-from=B3r3n@argosnet.com;
 helo=mx.argosnet.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 10:17:20
X-ACL-Warn: Detected OS   = FreeBSD  [generic] [fuzzy]
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_MUA_EUDORA=0.001, MISSING_MID=0.497, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
Message-Id: <E1jYANP-00066g-4e@lists.gnu.org>
X-Mailman-Approved-At: Mon, 11 May 2020 16:23:47 -0400
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

>There is no mention here of what VNC client program is being used, which
>is quite important, as key handling is a big mess in VNC.
I tested with TightVNC & noVNC through Apache. Both behaves the same. 
I did not tested Ultr@VNC.


>The default VNC protocol passes X11 keysyms over the wire.
>
>The remote desktop gets hardware scancodes and turns them into keysyms,
>which the VNC client sees. The VNC client passes them to the VNC server
>in QEMU, which then has to turn them back into hardware scancodes. This
>reverse mapping relies on knowledge of the keyboard mapping, and is what
>the "-k fr" argument tells QEMU.
>
>For this to work at all, the keymap used by the remote desktop must
>match the keymap used by QEMU, which must match the keymap used by
>the guest OS.  Even this is not sufficient though, because the act
>of translating hardware scancodes into keysyms is *lossy*. There is
>no way to reliably go back to hardware scancodes, which is precisely
>what QEMU tries to do - some reverse mappings will be ambiguous.
Yes, I saw that topic passing by. Looks messy with all these interferences...

>Due to this mess, years ago (over a decade) QEMU introduced a VNC
>protocol extension that allows for passing hardware scancodes over
>the wire.
I guess I also crossed something about this on Internet.
Are you talking of the RFB protocol ?

>With this extension, the VNC client gets the hardware scancode
>from the remote desktop, and passes it straight to the VNC server,
>which passes it straight to the guest OS, which then applies the
>localized keyboard mapping.   This is good because the localized
>keyboard mapping conversion is now only done once, in the guest
>OS.
>
>To make use of this protocol extension to VNC, you must *NOT*
>pass any "-k" arg to QEMU, and must use a VNC client that has
>support for this protocol extension.  The GTK-VNC widget supports
>this and is used by virt-viewer, remote-viewer, virt-manager,
>GNOME Boxes, Vinagre client applications.  The TigerVNC client
>also supports this extension.
So if I read you, if the client "enforce" this protocol (supposed 
RFB), Qemu will automatically uses it as well ?
Removing -k option is great to me if it works, since user will have 
its own mapping and these are international :-)

>To summarize, my recommendation is to remove the "-k" arg entirely,
>and pick a VNC client that supports the scancode extension.
For now I am using TightVNC & noVNC. noVNC is precious since it 
widens the user world, removing any client software constraint.

>It is possible there might be a genuine bug in QEMU's 'fr' keymap
>that can be fixed to deal with AltGr problems. Personally though I
>don't spend time investigating these problems, as the broad reverse
>keymapping problem is unfixable. The only sensible option is to take
>the route of using the VNC hardware scancode extension. It is notable
>that SPICE learnt from VNC's mistake and used hardware scancodes from
>the very start.

This was another path I intend to follow : using SPICE and a 
"noSPICE" client if VNC was too painful.
If I understand you, using SPICE could also solve the issue ?

Many thanks for your inputs...

Brgrds



>Regards,
>Daniel
>--
>|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
>|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
>|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


