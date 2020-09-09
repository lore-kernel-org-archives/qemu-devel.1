Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 167DAC43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 13:41:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 537472087C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 13:41:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OPiceX/T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 537472087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG0Lc-0003PN-8s
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 09:41:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36830)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kG0Kk-0002kf-64
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 09:40:22 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:28038
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kG0Ki-0006hN-2I
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 09:40:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599658818;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=Uez884UPLu8dpxRcZIdIWU4tVpdnb0TRbrLRKfvkSFk=;
 b=OPiceX/TS7FdR54Z4QJtGY9C70sAw/KgLv35C41N2138JBFoe9+jcUsmWcaNdFlLx936Z7
 2aNpF8VHRHifgUniNZ9iip7Z7p2s+Pc8qR0xta2vVKj3hTSu4MtVWIdjt5MJj3I4DFszO4
 KoNKQ5YSa1kBCNEMX/RSvGZHCW2FeDo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-366-FImcDje8OpmqmNBdYkCmlw-1; Wed, 09 Sep 2020 09:40:17 -0400
X-MC-Unique: FImcDje8OpmqmNBdYkCmlw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DDE5E801FDF;
 Wed,  9 Sep 2020 13:40:15 +0000 (UTC)
Received: from redhat.com (ovpn-113-81.ams2.redhat.com [10.36.113.81])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B491A5D9EF;
 Wed,  9 Sep 2020 13:40:07 +0000 (UTC)
Date: Wed, 9 Sep 2020 14:40:05 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [RFC] QEMU as Xcode project on macOS
Message-ID: <20200909134005.GN1011023@redhat.com>
References: <2764135.D4k31Gy3CM@silver>
MIME-Version: 1.0
In-Reply-To: <2764135.D4k31Gy3CM@silver>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 03:20:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org, programmingkidx@gmail.com,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 09, 2020 at 02:56:46PM +0200, Christian Schoenebeck wrote:
> I've recently been thinking about how feasible a stripped down Xcode project 
> for QEMU would be, i.e. you just get the QEMU sources, click on 
> qemu.xcodeproj, Cmd + B, done. No extra installation, no configure, nothing.
> 
> I've done this before for gtk(mm), which you might know, depends on approx. 24 
> individual libraries (glib, jpeg, png, pixman, atk, gdk, cairo, pixman, 
> graphene, sigcpp, ... gtk, gtkmm) that you would usually all need to download 
> and
> 
> 	./configure && make & make install
> 
> each individually on macOS. Or right, you could alternatively "just install" 
> them from Homebrew, MacPorts, Fink. But no matter which solution you choose, 
> it easily ends up in a mess (conflicts, misbehaviours) on macOS to install 
> libs and apps globally. And I think that's the problem why there are currently 
> relatively little contribution for QEMU coming from devs on macOS. Because you 
> don't want to install things globally on a macOS system, it's simply not 
> working well there as it does with Linux distros.
> 
> And the other thing is: I've tested the waters with Apple and filed a QEMU 
> related macOS bug with them. The response was like expected; they basically 
> said 'if there's no Xcode project, then we don't investigate it'.
> 
> The question is, and I don't have the big picture of QEMU yet to judge that, 
> how much is auto generated for QEMU i.e. with custom scripts that would 
> probably destroy this plan? There are these trace calls that are auto 
> generated, is there more like the TCG part for instance?
> 
> What I could imagine: a hand crafted Xcode project as a starting point, and if  
> that works out, switching to auto generating that Xcode project from the Meson 
> inftrastructure to avoid multiplication of maintenance effort.

The current way we generate a makefile from ninja output is not our
long term desired approach. Eventually the intent is that we should
be able to use  meson + ninja exclusively.

The ninja -> make convertor we currently rely on introduces maint
problems of its own. So I don't think we want to introduce a
ninja -> Xcode converter, as that is still effectively giving us
1 + 1/2 different build systems, so is a new maint burden.

Ideally any xcode setup would just invoke whatever our standard
build tools are IMHO, so it has zero possibility of introducing
new build problems.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


