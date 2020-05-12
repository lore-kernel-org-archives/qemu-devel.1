Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50FAAC54E8B
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 09:12:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BE2820575
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 09:12:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MrTxPPnX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BE2820575
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYQxc-0002Kl-BW
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 05:12:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39000)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jYQwh-0001Jy-3R
 for qemu-devel@nongnu.org; Tue, 12 May 2020 05:11:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33765
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jYQwf-0000Pt-J3
 for qemu-devel@nongnu.org; Tue, 12 May 2020 05:11:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589274684;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=pMP7I/1R0L55u1c0yv3qSpupFSWsTlv5QrX9/Tv38OM=;
 b=MrTxPPnXn1WVmQJzDl5H6grq4eomMZ3rep6rL71Xuu5QdGsAuraEoeh3K/MuOVlRRujajp
 mgxeazIDmjbfpkqlh9cB/HxKi3OSUjW06lGBEi6++tyeqyMnVOJkjeiHM7H/qDvpZd7gRr
 6Ndt86RlvgqKp7c6xseZBATroloC3uw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-OFVVd0_vM4mGOZsh6xuP-w-1; Tue, 12 May 2020 05:11:23 -0400
X-MC-Unique: OFVVd0_vM4mGOZsh6xuP-w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DAC9E107ACCA;
 Tue, 12 May 2020 09:11:21 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.71])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CF8A35D9E2;
 Tue, 12 May 2020 09:11:13 +0000 (UTC)
Date: Tue, 12 May 2020 10:11:06 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: B3r3n <B3r3n@argosnet.com>
Subject: Re: Qemu, VNC and non-US keymaps
Message-ID: <20200512091106.GH1191162@redhat.com>
References: <E1jY9FF-0000Po-2c@lists.gnu.org>
 <af732fbf-fd70-97bc-3ea8-25d66f5895de@redhat.com>
 <20200511151155.GO1135885@redhat.com>
 <20200511152957.6CFA8D1826@zmta04.collab.prod.int.phx2.redhat.com>
 <20200511171930.GS1135885@redhat.com>
 <20200512074530.8729D1892D3@zmta01.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200512074530.8729D1892D3@zmta01.collab.prod.int.phx2.redhat.com>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 02:20:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
 Philippe =?utf-8?B?TWF0aGlldS1EYXVkw4M/w4LCqQ==?= <philmd@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 12, 2020 at 09:45:20AM +0200, B3r3n wrote:
> Hello Daniel, all,
> 
> I am a bit confused.
> 
> Ok, RFB protocol should be the solution that solves all, sending scancodes
> rather than doing keysyms stuff. No pb for me.
> So I removed my '-k fr' to my Qemu VM start as it was before.
> 
> However, reading TightVNC & noVNC docs, both are able to perform RFB.

VNC == RFB - they're two different terms of the same thing.

The core RFB/VNC protocol only knows about keysyms.

Hardware scancodes is an extension defined by QEMU, and GTK-VNC, and since
implemented by TigerVNC.

Removing the "-k" arg, merely enables use of the scancode extension.
This requires a compatible client app that knows the scancode extension.
If the client doesn't support scancodes, it will continue using keysyms,
which will then be treated as plain us keymap.

AFAIK,  TightVNC doesn't support the scancode extension, only TigerVNC.

> Since these explanations, I replayed a bit:
> 
> Under my testing Debian 10, I redefined keyboard to French + No compose key
> + AltGr as CTRL_R

This is a key example of the problems of VNC's traditional key handling.

QEMU has a single keymap "fr". It has no way of selecting compose key
on/off, or overriding AltGr to be CtrlR.  So as soon as you do that on
your local desktop, you make it impossible to QEMU VNC serve to work
correctly.

> 
> Under noVNC: Ctrl_R works well as alternative but when using AltGr, I
> received 29+100+7 (AltGr + 6) and keep displaying a minus as with AltGr was
> not pressed.
> 
> Under TightVNC (2.7.10) : Ctrl_R displays characters, I am still in QWERTY
> for letters, weird mapping for other characters, did not checked if
> compliant with whatever definition.
> Under TightVNC (last 2.8.27, supposed to be able to RFB): Ctrl_R displays
> nothing, keys are QWERTY. Seems the same as TightVNC 2.7.10.
> 
> With the keyboard defining AltGr as AltGr, no change.
> 
> I realize that AltGr is sending 29+100 (seen via showkey), when CTRL_R only
> sends 97.
> When using a remote console (iLo and iDRAC), AltGr only sends 100.
> 
> I wonder if the issue would not also be the fact AltGr sends 2 codes, still
> another one to select the character key (6 for example).
> 
> Is that normal Qemu is transforming AltGr (100) in 29+100 ?

It is hard to say without seeing debuging to see what QEMU received.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


