Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33065C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 08:59:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1B0F20836
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 08:59:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d468l7Cz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1B0F20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo1FZ-0002re-8V
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 04:59:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55362)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jo1Et-0002Ri-TP
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 04:58:39 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:41066
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jo1Er-0006Kl-8g
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 04:58:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592989115;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=Ws0cKvx+ZZhLonsmlyac0VC0fSrznCwCDeUK39xqTgE=;
 b=d468l7CzpPBl0LQKTk6A4IwVMZFi8zew2Xfm74Xy0mfc3A4cmObrO+Icb4MeRHoZARsIU5
 A8aScaU9TUEicXMxdbR9gremtqbqq5NinOoBVCfpaYz6gu/ZveG7KlHBjkTR2RxOY3eFoC
 zEFyV+pJSYAtvfejCAzJiNesq+8vI/A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-wn7540NzOL65nXqAbkkPIA-1; Wed, 24 Jun 2020 04:58:33 -0400
X-MC-Unique: wn7540NzOL65nXqAbkkPIA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 05E18800C60
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 08:58:33 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.66])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BFA4B7E59A;
 Wed, 24 Jun 2020 08:58:28 +0000 (UTC)
Date: Wed, 24 Jun 2020 09:58:25 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: -enablefips
Message-ID: <20200624085825.GD774096@redhat.com>
References: <7816f22f-2872-06ef-f7ef-40add5a34040@redhat.com>
 <20200624064954.jmkqonjbqfhso5dr@sirius.home.kraxel.org>
MIME-Version: 1.0
In-Reply-To: <20200624064954.jmkqonjbqfhso5dr@sirius.home.kraxel.org>
User-Agent: Mutt/1.14.0 (2020-05-02)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 00:34:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: John Snow <jsnow@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 24, 2020 at 08:49:54AM +0200, Gerd Hoffmann wrote:
> On Tue, Jun 23, 2020 at 11:51:09PM -0400, John Snow wrote:
> > I never knew what this option did, but the answer is ... strange!
> > 
> > It's only defined for linux, in os-posix.c. When called, it calls
> > fips_set_state(true), located in osdep.c.
> > 
> > This will read /proc/sys/crypto/fips_enabled and set the static global
> > 'fips_enabled' to true if this setting is on.
> 
> IIRC the idea is to have a global switch to enable fips compilance for
> the whole distro.  RH specific.  rhel-7 kernel has it.  rhel-8 kernel
> too, so it probably isn't obsolete.  Not present in mainline kernels.
> 
> I'm wondering what the point of the -enablefips switch is.  Shouldn't
> qemu check /proc/sys/crypto/fips_enabled unconditionally instead?

Yes, but IIRC, there was a bit of a philisophical debate about the
value of FIPS and whether QEMU was going to accept it at all upstream.
I think the -enablefips switch was a compromise to get something
upstream.

> > (Tangent: what does *this* setting actually control? Should QEMU
> > meaningfully change its behavior when it's set?)
> 
> fips is a security policy ...
> 
> > This static global is exposed via the getter fips_get_state(). This
> > function is called only by vnc.c, and appears to disable the use of the
> > password option for -vnc.
> 
> ... yes, "no passwords" is one of the rules.  There are probably more.

It isn't so much "no passwords", rather in the VNC case the rule
we fal on is "no single DES" encryption algorithm !

Back when we added FIPS in QEMU, VNC was using the built-in DES
impl, and hence we needed to block this explicitly ourselves.

These days a sensible QEMU build will link to a crypto library
and get DES from there.  This crypto library will in turn block
our use of single DES when in FIPS mode, so QEMU won't have to
worry about it.

> > (If we really do want to keep it, it should probably go under -global
> > somewhere instead to help reduce flag clutter, but we'd need to have a
> > chat about what fips compliance means for literally every other spot in
> > QEMU that is capable of using or receiving a cleartext password.)
> 
> Yep.  IIRC for spice this is handled in libspice-server.  We need to
> look at blockdev encryption I guess.  Any other places where qemu uses
> passwords directly?  I think we don't have to worry about indirect usage
> (sasl).

I don't think it is about passwords. Encryption algorithms were the
really key thing AFAIK, and the intent is that by using a common crypto
library you get the FIPS support for free.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


