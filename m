Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF977C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 10:28:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A916A20657
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 10:28:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b+wlD0MA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A916A20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jad0j-0007Ix-SF
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 06:28:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60146)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jaczV-0006sL-Q0
 for qemu-devel@nongnu.org; Mon, 18 May 2020 06:27:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49038
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jaczT-0001bg-W1
 for qemu-devel@nongnu.org; Mon, 18 May 2020 06:27:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589797642;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uVPn2Gd2rYuGHphpqa+HHu9pyh2e/wWmyfn1WRo2Aic=;
 b=b+wlD0MADu4H0smkVWeRi8W4+f/m6PQd3DT+uvMG1Nx5DGtOnF+1X84viTxhmHRpe7UBxw
 a0LmrOGXJhiD+inxK+M600XbhPkuuIykoXwHRil+Kfn7UpyAKOB2L2yeHfyvbqpS/NxPog
 cSbildf+Xr8emYcQI6Rqjfi/GvfPHcg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-344-VW0ZS4jHNbOuqYZEb-wWRQ-1; Mon, 18 May 2020 06:27:02 -0400
X-MC-Unique: VW0ZS4jHNbOuqYZEb-wWRQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4662B800D24
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 10:27:01 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.61])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 78C342E05D;
 Mon, 18 May 2020 10:26:53 +0000 (UTC)
Date: Mon, 18 May 2020 11:26:50 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v2 11/13] audio: deprecate -soundhw pcspk
Message-ID: <20200518102650.GG1430944@redhat.com>
References: <20200515143528.13591-1-kraxel@redhat.com>
 <20200515143528.13591-12-kraxel@redhat.com>
 <20200515150823.GA738369@lpt>
 <20200518101628.3j4d6hwq6pitjfo3@sirius.home.kraxel.org>
MIME-Version: 1.0
In-Reply-To: <20200518101628.3j4d6hwq6pitjfo3@sirius.home.kraxel.org>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/17 22:51:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_EXCESS_BASE64=0.979, RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: libvir-list@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?J=C3=A1n?= Tomko <jtomko@redhat.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 18, 2020 at 12:16:28PM +0200, Gerd Hoffmann wrote:
> On Fri, May 15, 2020 at 05:08:23PM +0200, Ján Tomko wrote:
> > On a Friday in 2020, Gerd Hoffmann wrote:
> > > Add deprecation message to the audio init function.
> > > 
> > > Factor out audio initialization and call that from
> > > both audio init and realize, so setting audiodev via
> > > -global is enough to properly initialize pcspk.
> > > 
> > > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > > ---
> > > hw/audio/pcspk.c | 24 +++++++++++++++++++++---
> > > 1 file changed, 21 insertions(+), 3 deletions(-)
> > > 
> > > @@ -236,9 +245,18 @@ static const TypeInfo pcspk_info = {
> > >     .class_init     = pcspk_class_initfn,
> > > };
> > > 
> > > +static int pcspk_audio_init_soundhw(ISABus *bus)
> > > +{
> > > +    PCSpkState *s = pcspk_state;
> > > +
> > > +    warn_report("'-soundhw pcspk' is deprecated, "
> > > +                "please set a backend using '-global isa-pcspk.audiodev=<name>' instead");
> > > +    return pcspk_audio_init(s);
> > 
> > -soundhw pcspk is the only soundhw device present in libvirt git.
> > 
> > Is there a way to probe for this change via QMP?
> 
> Oops.  I'm surprised libvirt actually supports pcspk.
> 
> There is no way to see that in qmp, and I can't think of an easy way
> to add that.  Does libvirt check for command line switches still?
> So it could see -soundhw going away if that happens?

IIUC, instead of probing for whether -soundhw is deprecated, it should
be suffiicent for us to probe if "isa-pcspk.audiodev" exists. Assuming
we always use isa-pcspk.audiodev if it exists, then we'll trivially
avoid using the -soundhw arg.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


