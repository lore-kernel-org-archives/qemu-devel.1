Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CB05C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 05:59:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 373A6218AC
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 05:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TvC52MOa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 373A6218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXI1P-00028V-15
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 01:59:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59092)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kXI0a-0001Zn-BB
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 01:59:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52764)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kXI0U-0005zj-R6
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 01:58:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603778312;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xhzMnM4FFw+DP9+iN1uD3Dk91pI3fvhjy2sU9/x50KI=;
 b=TvC52MOaWRGvmZm/jeYsULKeRoezjC4+h08B3uT/L/2V81hhAYVMPJQ1GhHFA6XJwG0Hxq
 bb3nbs4E1CoiRzIT86WZG3oWVIsFubGcVjcP2QM+uY1QGdz2XahHqUJqZo22iTtVTunS0d
 5FRIZ6pmUyiL3etdtYPV+JJhx0rDPbU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-445-cEOFlKKeMziYIPRS7PfaRA-1; Tue, 27 Oct 2020 01:58:29 -0400
X-MC-Unique: cEOFlKKeMziYIPRS7PfaRA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B7736186DD35;
 Tue, 27 Oct 2020 05:58:28 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2BA7E6EF56;
 Tue, 27 Oct 2020 05:58:25 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 56F3A9D0D; Tue, 27 Oct 2020 06:58:24 +0100 (CET)
Date: Tue, 27 Oct 2020 06:58:24 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Bruce Rogers <brogers@suse.com>
Subject: Re: [PATCH 00/14] ui: build spice and opengl as module.
Message-ID: <20201027055824.whfjf7hd7kv5fqnm@sirius.home.kraxel.org>
References: <20201019075224.14803-1-kraxel@redhat.com>
 <af8fc74d3c228fbb51933089dc5bce15524a009b.camel@suse.com>
MIME-Version: 1.0
In-Reply-To: <af8fc74d3c228fbb51933089dc5bce15524a009b.camel@suse.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Oct 26, 2020 at 10:27:54AM -0600, Bruce Rogers wrote:
> On Mon, 2020-10-19 at 09:52 +0200, Gerd Hoffmann wrote:
> > - Add QemuSpiceOps, reorganize spice stubs.
> > - Add support for module dependencies.
> > - Build spice-core modular, and make the existing spice
> >   modules (audio, chardev, qxl) depend on spice-core.
> > - Build egl-headless display and opengl helpers modular
> >   (pretty easy thanks to module dependencies).
> 
> Hi Gerd, others,

Cc'ing John Snow who looks at qmp/qapi too right now.

> I am happy to see the work you are doing with modularizing
> qemu, but I think there also needs to be corresponding work
> with libvirt's ability to properly detect qemu functionality
> in light of this modularization.

I've tried to not change qemu behavior, but there are limits to this as
modularization brings some new constellations.

> Right now the QMP interface for probing "spice support" is
> quite a big hammer, and doesn't allow for any nuance.

Yep.  Specifically the CONFIG_SPICE=y and spice modules not installed at
runtime is problematic I think.

> As I've looked into other aspects of how libvirt detects qemu
> functionality, it seems there is a lot of room for improvement in how
> qemu advertises it's functionality - which goes well beyond the issues
> of modularization.

Well, everything which involves qom objects should work just fine, even
with modules.  You can see objects supported by qemu via qapi
introspection, and that should work just fine with objects being
implemented in modules.

> If you have any pointers to and discussion or plans in this regard, I'd
> appreciate it. Otherwise I'll look into doing something in this space
> myself.

For -audiodev and -display we could turn stuff into objects (simliar to
-chardev) and just use the object class registry instead of having a
private registry.  That would make things also visible in qom
introspection.

The spice problem has been discussed in the past, but IIRC we didn't end
up with a plan.  We could have spice register a dummy qom object
(say 'feature-spice').  Not sure this is a good idea though.

take care,
  Gerd


