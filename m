Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B1B0C433E1
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 10:40:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AAD820723
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 10:40:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i4nzz3mP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AAD820723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrJ7g-0004IB-Ha
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 06:40:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36462)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jrJ6u-0003Rz-CF
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 06:40:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36764
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jrJ6s-0005Jn-Dm
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 06:40:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593772797;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=40ZPFA07EbyFWzh+hlWWEZrgFMyYGKruSuZz8RDC9Jg=;
 b=i4nzz3mP5JLxKkCp2nBBmt70o7hZ7pdRruIKqP2XBMevCXqtUE0yB0A9lm1V+ORpLTR32r
 ktx/6X7eOC0NLhjv4tXM3X8j3EJpsZbRVhPyr0Zs5mzDvPdHlUqCBBFYpeQf4nA6x7b/3x
 /rMn+Mz9aU1hiabz00N8SsjTwkHVGcc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-zggKlGpqOB-CNzZ8efc_kA-1; Fri, 03 Jul 2020 06:39:55 -0400
X-MC-Unique: zggKlGpqOB-CNzZ8efc_kA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A7CCF107ACCA;
 Fri,  3 Jul 2020 10:39:54 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-62.ams2.redhat.com
 [10.36.112.62])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 92E0C19D7B;
 Fri,  3 Jul 2020 10:39:51 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 7894416E16; Fri,  3 Jul 2020 12:39:49 +0200 (CEST)
Date: Fri, 3 Jul 2020 12:39:49 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 00/10] Modules 20200702 patches
Message-ID: <20200703103949.7vz3dmy4br55rh4b@sirius.home.kraxel.org>
References: <20200702122048.27798-1-kraxel@redhat.com>
 <CAFEAcA9PVnKo8S7=bSggS2FpS5YoBexZD7nM54XFHto333_OhQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9PVnKo8S7=bSggS2FpS5YoBexZD7nM54XFHto333_OhQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 02:53:25
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
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 03, 2020 at 09:54:13AM +0100, Peter Maydell wrote:
> On Thu, 2 Jul 2020 at 13:23, Gerd Hoffmann <kraxel@redhat.com> wrote:
> >
> > The following changes since commit fc1bff958998910ec8d25db86cd2f53ff125f7ab:
> >
> >   hw/misc/pca9552: Add missing TypeInfo::class_size field (2020-06-29 21:16:10 +0100)
> >
> > are available in the Git repository at:
> >
> >   git://git.kraxel.org/qemu tags/modules-20200702-pull-request
> >
> > for you to fetch changes up to 474a5d66036d18ee5ccaa88364660d05bf32127b:
> >
> >   chardev: enable modules, use for braille (2020-07-01 21:08:11 +0200)
> >
> > ----------------------------------------------------------------
> > qom: add support for qom objects in modules.
> > build some devices (qxl, virtio-gpu, ccid, usb-redir) as modules.
> > build braille chardev as module.
> >
> > note: qemu doesn't rebuild objects on cflags changes (specifically
> >       -fPIC being added when code is switched from builtin to module).
> >       Workaround for resulting build errors: "make clean", rebuild.
> >
> > ----------------------------------------------------------------
> >
> > Gerd Hoffmann (10):
> >   module: qom module support
> >   object: qom module support
> >   qdev: device module support
> >   build: fix device module builds
> >   ccid: build smartcard as module
> >   usb: build usb-redir as module
> >   vga: build qxl as module
> >   vga: build virtio-gpu only once
> >   vga: build virtio-gpu as module
> >   chardev: enable modules, use for braille
> 
> No code review at all? :-(

Well, there have been 5 revisions on the list, partly due to bugs being
fixed, partly with changes as response to review comments.  So it got
some review (not much though) even though the v5 series (posted on June
22th, so there was more than a week time) didn't got any acks so far.

> In particular the "build: fix device module
> builds" commit (as you note in your commit message) does not look at
> all right.

I think this stop-gap will do fine as long as we don't have any
target-specific modules.

take care,
  Gerd


