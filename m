Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D2FC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 15:52:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 779FC20720
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 15:52:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KM98t7I5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 779FC20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtvK1-00042A-Mz
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 11:52:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34698)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jtvFH-0006dp-VX
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 11:47:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54723
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jtvFF-0008TK-Cm
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 11:47:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594396044;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BsLZb1+ZnK5IwPxSC5iY7m2RmAP3bgsknV5rSozsrAU=;
 b=KM98t7I5fDqndqRujawosylDZRFzC1KP+3bH8EFD609ZUgD3cxqux09WN0hDW2SFSEYP3A
 ysVb2Ko4gicHeCaNI2lAumgeTAOO6bADPh2Of7QzoEYtTKyAC2TOmfwPTPphaY2BnfhUc0
 UZ16KYYzaDo03g4tOcGkMSkV9z3XTls=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-I06VZLcYNourDj8z1LJTlw-1; Fri, 10 Jul 2020 11:47:12 -0400
X-MC-Unique: I06VZLcYNourDj8z1LJTlw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 61B64193F560;
 Fri, 10 Jul 2020 15:47:11 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.42])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BAD5F74F5E;
 Fri, 10 Jul 2020 15:47:09 +0000 (UTC)
Date: Fri, 10 Jul 2020 16:47:06 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL v2 00/52] Misc patches for QEMU 5.1 soft freeze
Message-ID: <20200710154706.GC4034168@redhat.com>
References: <9631042d-00e4-2a2e-292b-66ca1b590120@suse.de>
 <CAFEAcA-UbHpj_xSbqjTsaURt8yPZjuYOmd3pe97vg_G7--17Cw@mail.gmail.com>
 <e78820bb-af5f-c2a0-7727-1a0caedfa584@suse.de>
 <CAFEAcA-raDJ2pSUG-OYHcJi_LnQwxMHvcyjsD7+=WxGYcrSz3w@mail.gmail.com>
 <a8113ed1-c508-0502-4f88-77f875d1a739@redhat.com>
 <40f4c566-8a5b-c27e-22a7-2a112a0cd77d@suse.de>
 <c6e3336f-38b8-a8fa-4862-58e6f094711d@redhat.com>
 <CAFEAcA80XK4voLDj+8kVFcHJb35HT9HL+Qh8kGb3_Qe5Em9ouw@mail.gmail.com>
 <adeb1f02-c712-e256-6840-649795fdc3b5@redhat.com>
 <CAFEAcA9f0tadztJP7Ki0potF6=E+GaG8a_X_5HTyH2yw2T7goA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9f0tadztJP7Ki0potF6=E+GaG8a_X_5HTyH2yw2T7goA@mail.gmail.com>
User-Agent: Mutt/1.14.3 (2020-06-14)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/10 04:36:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Claudio Fontana <cfontana@suse.de>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 10, 2020 at 04:42:11PM +0100, Peter Maydell wrote:
> On Fri, 10 Jul 2020 at 16:31, Max Reitz <mreitz@redhat.com> wrote:
> >
> > On 10.07.20 17:18, Peter Maydell wrote:
> > > readarray only arrived sometime in bash 4, and the OSX system
> > > bash is 3.2.57, so it won't have that builtin.
> >
> > It arrived with 4.0, actually, which was released 11 years ago.
> > I had assumed that would be sufficiently mature.
> >
> > So, um, 11 years isn’t sufficiently mature then and I’ll have to work
> > around not having readarray for macOS?
> 
> It's the usual Apple-vs-GPL3 issue.
> 
> I note that the iotests do seem to regularly run into
> non-portable constructs: Kevin's latest pullreq has
> just failed due to a use of 'truncate' that doesn't
> work on the BSDs.

Since we already depend on homebrew for the build environment, we can
pull in the newer bash from homebrew, and ignore the ancient version
from macOS stock install.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


