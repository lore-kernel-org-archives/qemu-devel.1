Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2472FC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 11:34:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E484C20720
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 11:34:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tkp+OQow"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E484C20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k95Ja-0005HN-4l
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 07:34:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34384)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1k94KM-0007x2-9Q
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 06:31:18 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:21311
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1k94KJ-0002vD-VD
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 06:31:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598005874;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fa3ZE2viBRz5vzvmvDpSQbVXv8jRGMA4oktFM+AV9fA=;
 b=Tkp+OQowXKj++M6slVxqV80umsCw5YMY/9ormoVd6qTWunJboXadBhxqtfSB7+Lh3gE35k
 8dg8k271YywZRlkT2yVHKBH7b7Rt66sMPgrxW4FcuQp6oWFnoiSDI9uF0WOsYwCCg+2HjD
 txOJP930N8sc0revCRAYMjJoHOyuUeQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-HH_2FoxNO-GhaIJyEpN2NA-1; Fri, 21 Aug 2020 06:31:11 -0400
X-MC-Unique: HH_2FoxNO-GhaIJyEpN2NA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2E1EA80733A;
 Fri, 21 Aug 2020 10:31:10 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 43F027A431;
 Fri, 21 Aug 2020 10:31:08 +0000 (UTC)
Date: Fri, 21 Aug 2020 11:31:05 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v2] configure: add support for pseudo-"in source tree"
 builds
Message-ID: <20200821103105.GI251583@redhat.com>
References: <20200820173124.243984-1-berrange@redhat.com>
 <20200821101753.GC5153@linux.fritz.box>
MIME-Version: 1.0
In-Reply-To: <20200821101753.GC5153@linux.fritz.box>
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 05:15:56
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Aug 21, 2020 at 12:17:53PM +0200, Kevin Wolf wrote:
> Am 20.08.2020 um 19:31 hat Daniel P. BerrangÃÂ© geschrieben:
> > Meson requires the build dir to be separate from the source tree. Many
> > people are used to just running "./configure && make" though and the
> > meson conversion breaks that.
> > 
> > This introduces some backcompat support to make it appear as if an
> > "in source tree" build is being done, but with the the results in the
> > "build/" directory. This allows "./configure && make" to work as it
> > did historically, albeit with the output binaries staying under build/.
> > 
> > Signed-off-by: Daniel P. BerrangÃÂ© <berrange@redhat.com>
> > ---
> > 
> > This is a simple integration of Eric's proposal from
> > 
> >   https://lists.gnu.org/archive/html/qemu-devel/2020-03/msg07290.html
> > 
> > with a bit of configure magic. It is enough to enable
> > 
> >    ./configure
> >    make
> >    make check
> > 
> > I've not tested it beyond that. Note it blows away the "build/"
> > dir each time ./configure is run so it is pristine each time.
> 
> I guess "make install" is the only other one that normal users would
> care about. We shoud make sure that it works (I don't see why it
> wouldn't, but worth testing anyway).

I've just tested  "make instal DESTDIR=`pwd`/vroot" in order to
validate that variables are passed through too, and it appears to
be succesful.

$  make install DESTDIR=`pwd`/vroot
...snip...
$ find vroot/ | head -30
vroot/
vroot/usr
vroot/usr/local
vroot/usr/local/bin
vroot/usr/local/bin/qemu-nbd
vroot/usr/local/bin/qemu-keymap
vroot/usr/local/bin/qemu-pr-helper
vroot/usr/local/bin/qemu-storage-daemon
vroot/usr/local/bin/elf2dmp
vroot/usr/local/bin/qemu-img
vroot/usr/local/bin/qemu-edid
vroot/usr/local/bin/qemu-system-x86_64
vroot/usr/local/bin/qemu-ga
vroot/usr/local/bin/qemu-io
vroot/usr/local/var
vroot/usr/local/var/run
vroot/usr/local/libexec
vroot/usr/local/libexec/vhost-user-gpu
vroot/usr/local/libexec/qemu-bridge-helper
vroot/usr/local/libexec/virtfs-proxy-helper
vroot/usr/local/libexec/virtiofsd
vroot/usr/local/share
vroot/usr/local/share/icons
vroot/usr/local/share/icons/hicolor
vroot/usr/local/share/icons/hicolor/256x256
vroot/usr/local/share/icons/hicolor/256x256/apps
vroot/usr/local/share/icons/hicolor/256x256/apps/qemu.png
vroot/usr/local/share/icons/hicolor/48x48
vroot/usr/local/share/icons/hicolor/48x48/apps
vroot/usr/local/share/icons/hicolor/48x48/apps/qemu.png
...snip...

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


