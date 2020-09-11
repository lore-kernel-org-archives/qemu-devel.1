Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF179C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 16:23:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 447B0208FE
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 16:23:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CTKq8Pfi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 447B0208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGlpU-0006DO-16
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 12:23:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58228)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kGloQ-00056s-Sj
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 12:22:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24143)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kGloH-0007ix-D4
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 12:22:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599841320;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gUEgMknDIVAqquhf2ZvFNR5UHohM2OwK0ZMa2dlYrzc=;
 b=CTKq8Pfi5GCmXffGQNXungem4xGLsfZf33nAIcUzQx409NAlsERGGb1ymXkHujVYlIsAKu
 JvWqz0u+KogyAmyHHSKwQbKRpnwtzncAbsbXqAL6IJrne4lEV//ZSYVzD+6BGf0QhYP75W
 +a11zmexIXYTX/A7O/xyhzDjB0dPmVY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-4gTNu7zZO12uirZ9vYBL0w-1; Fri, 11 Sep 2020 12:21:52 -0400
X-MC-Unique: 4gTNu7zZO12uirZ9vYBL0w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1919F801AEA;
 Fri, 11 Sep 2020 16:21:51 +0000 (UTC)
Received: from redhat.com (ovpn-113-229.ams2.redhat.com [10.36.113.229])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CA66E805D2;
 Fri, 11 Sep 2020 16:21:41 +0000 (UTC)
Date: Fri, 11 Sep 2020 17:21:38 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>
Subject: Re: PATCH: Increase System Firmware Max Size
Message-ID: <20200911162138.GL1203593@redhat.com>
References: <CS1PR8401MB0327EF9D532330BA44257AFCF3240@CS1PR8401MB0327.NAMPRD84.PROD.OUTLOOK.COM>
 <20c5210f-8199-a9e7-9297-0bea06c4d9ae@redhat.com>
 <20200911083408.GA3310@work-vm>
 <ae2d820e-78c6-da92-2fa6-73c1a7d10333@redhat.com>
 <20200911150602.GH3310@work-vm>
 <20200911152353.GI1203593@redhat.com>
 <d7d0d37e-4bba-ab82-783d-06463d78d9cf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <d7d0d37e-4bba-ab82-783d-06463d78d9cf@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 23:26:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: "mst@redhat.com" <mst@redhat.com>,
 "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "McMillan,
 Erich" <erich.mcmillan@hp.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 11, 2020 at 06:06:27PM +0200, Laszlo Ersek wrote:
> On 09/11/20 17:23, Daniel P. Berrangé wrote:
> 
> > I don't see why we should have this as a hard coded
> > limit that is not runtime configurable.
> > 
> > IOW, why can't we keep our current default and provide a machine type
> > property "firmware_max_size" which users can opt-in to setting if
> > their particular firmware exceeds normal defaults. That won't impact
> > us for migration compat in any way, and lets users have flexibility t
> > do what they want.
> 
> Technically, this is fine, in my opinion.
> 
> My concerns (in distilled form, this time):
> 
> - The change increases maintenance burden.

I think that is so marginal that its lost in the noise compared to
everything else that's done in QEMU. Essentially someone can pick
a value that is so large that it tickles some other problem in QEMU
or their firmware. We're not promising to fix such problems if they
occurs. It'll be perfectly valid to say "dont do that" if someone
sets a value that breaks something else and we don't consider it
worth the time to investigate and fix.

> - The change does not benefit most users of QEMU, as the intended guest
> payload will not available to most of them at all (regardless of
> licensing terms).

I think that's only relevant if the change is imposing a significant
maint burden which needs to be justified. Not the case here IMHO.

> - The existence of the property may entice OVMF users to ask us to
> enlarge the *current* OVMF firmware platform and to pack more stuff in
> it. That is not OK. My counter-proposal ("please contribute a new
> platform DSC/FDF under OvmfPkg, and assume co-reviewership for it")
> would almost certainly not be acted upon.

I don't see this is relevant. If OVMF maintainers want to reject
feature proposals they have the right to do that regardless of what
QEMU sets for max image size. As you say earlier, the existing size
limit is already enourmous compared to what OVMF actually uses, so
if this was a real problem it'd already exist.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


