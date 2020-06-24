Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 006B1C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 09:06:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C310E206FA
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 09:06:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a4gdlR6Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C310E206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo1MT-0007GJ-2p
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 05:06:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57654)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jo1Lq-0006jy-O5
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 05:05:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51008
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jo1Lo-0008Ar-RP
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 05:05:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592989547;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=LvZFqnF0CBJgWHdp/9a36x96b7U4p9xJKxthLbquip8=;
 b=a4gdlR6Z1HAIEeyhrBE46mQBOy4s02tIXgXmM9fb0PHlGemuzrYvGnhBuGzSsFGOjsjDeu
 D/Vy9zro88ktvig37BK6YgpHDGYDJCnIA3Ce4SjUD/Lwlhny6WZlIH8lG/Tva5ORjdLzwL
 nE/mYSK8Nzl/3Z1Eb+4pI8RK/i02nKc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-481-t6qzifhjNZuffi56tpu49g-1; Wed, 24 Jun 2020 05:05:45 -0400
X-MC-Unique: t6qzifhjNZuffi56tpu49g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C267C107ACF2
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 09:05:44 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.66])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4E352282FE;
 Wed, 24 Jun 2020 09:05:40 +0000 (UTC)
Date: Wed, 24 Jun 2020 10:05:37 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: -enablefips
Message-ID: <20200624090537.GF774096@redhat.com>
References: <7816f22f-2872-06ef-f7ef-40add5a34040@redhat.com>
MIME-Version: 1.0
In-Reply-To: <7816f22f-2872-06ef-f7ef-40add5a34040@redhat.com>
User-Agent: Mutt/1.14.0 (2020-05-02)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 02:33:25
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
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 23, 2020 at 11:51:09PM -0400, John Snow wrote:
> I never knew what this option did, but the answer is ... strange!
> 
> It's only defined for linux, in os-posix.c. When called, it calls
> fips_set_state(true), located in osdep.c.
> 
> This will read /proc/sys/crypto/fips_enabled and set the static global
> 'fips_enabled' to true if this setting is on.
> 
> (Tangent: what does *this* setting actually control? Should QEMU
> meaningfully change its behavior when it's set?)
> 
> This static global is exposed via the getter fips_get_state(). This
> function is called only by vnc.c, and appears to disable the use of the
> password option for -vnc.
> 
> This seems very high-level and abstract for something that ultimately
> only disables VNC password authentication. Is this misleadingly abstract?
> 
> The docs state:
> "enable FIPS 140-2 compliance"
> 
> Like hell it does.

It prevents the use of non-FIPS crypto in QEMU, so it isn't that
inaccurate.

> Can we deprecate this? It was added in 2012 and never seemed to pursue
> the mission laid out in the help file. If we do still want it, the
> documentation should be changed dramatically to reflect what it actually
> does.
> 
> This is so at risk of bit-rot, and a misleading crypto flag is certainly
> worse than no crypto flag. I think it should just go.

I think it can go.

FIPS support in QEMU is only needed if using our own crypto code which
lacks FIPS compliance, which essentially means our Single DES impl.

Anyone who cares about FIPS should be building QEMU with crypto provided
by libgcrypt. This will take care of FIPS compliance automatically,
so there's nothing QEMU needs do itself.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


