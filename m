Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 989BBC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 09:50:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6267623600
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 09:50:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i/b5DpHm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6267623600
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpqQd-000498-JX
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 05:50:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50112)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jpqOM-0002eW-CK
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 05:47:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38329
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jpqOI-0002EI-BL
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 05:47:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593424073;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4VYR/fC75ebH1WLdkbpoHJ9ISLpNRjMyBLzd6DN9WL8=;
 b=i/b5DpHmiofxRdHwWLG3dyJ9hd6jU/TI2/DB9EST0gGq/ZBQTJl9hcSJSm3+eJp1DzWwww
 ZUhMf+LjJU2FeCFeRNGAwohR025Lgabf7wlqF1IcoF15vRpjbIxQSvFFiW78jdKp3wv5U0
 ZlCLZ3jOtCDf7HJro3h/4potDornRNs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-288-Kw4AtdkcOeams_KtcKtXnA-1; Mon, 29 Jun 2020 05:47:40 -0400
X-MC-Unique: Kw4AtdkcOeams_KtcKtXnA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2CE54800D5C;
 Mon, 29 Jun 2020 09:47:39 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.60])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C257B1C8;
 Mon, 29 Jun 2020 09:47:24 +0000 (UTC)
Date: Mon, 29 Jun 2020 10:47:21 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Christophe de Dinechin <dinechin@redhat.com>
Subject: Re: [PATCH 04/10] spice: Move all the spice-related code in
 spice-app.so
Message-ID: <20200629094721.GE1298906@redhat.com>
References: <20200626164307.3327380-1-dinechin@redhat.com>
 <20200626164307.3327380-5-dinechin@redhat.com>
 <20200626172003.GL1028934@redhat.com> <lywo3qcjkv.fsf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <lywo3qcjkv.fsf@redhat.com>
User-Agent: Mutt/1.14.3 (2020-06-14)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/29 01:10:03
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 29, 2020 at 11:22:40AM +0200, Christophe de Dinechin wrote:
> 
> On 2020-06-26 at 19:20 CEST, Daniel P. Berrangé wrote...
> > On Fri, Jun 26, 2020 at 06:43:01PM +0200, Christophe de Dinechin wrote:
> >> If we want to build spice as a separately loadable module, we need to
> >> put all the spice code in one loadable module, because the build
> >> system does not know how to deal with dependencies yet.
> >>
> >> Signed-off-by: Christophe de Dinechin <dinechin@redhat.com>
> >> ---
> >>  audio/Makefile.objs   | 2 +-
> >>  chardev/Makefile.objs | 3 +--
> >>  ui/Makefile.objs      | 8 ++++----
> >>  3 files changed, 6 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/audio/Makefile.objs b/audio/Makefile.objs
> >> index b4a4c11f31..298c895ff5 100644
> >> --- a/audio/Makefile.objs
> >> +++ b/audio/Makefile.objs
> >> @@ -1,5 +1,5 @@
> >>  common-obj-y = audio.o audio_legacy.o noaudio.o wavaudio.o mixeng.o
> >> -common-obj-$(CONFIG_SPICE) += spiceaudio.o
> >> +spice-app.mo-objs += ../audio/spiceaudio.o
> >
> > Explicitly showing paths in the variables doesn't look right. The
> > make recipes are supposed to automatically expand bare file names
> > to add the right path. This is usually dealt with by a call to
> > the "unnest-vars" function.
> 
> I agree. I mentioned this in the cover letter:
> 
> > - Adding various non-UI files into spice-app.so, which required a
> >   couple of ../pwd/foo.o references in the makefile. Not very nice,
> >   but I did not want to spend too much time fixing the makefiles.
> 
> I did not find an elegant way to integrate a non-UI file into a .mo that is
> declared in the ui section.
> 
> I considered various solutions:
> 
> a) Having separate load modules for different source directories.
>    This exposes details of the build system into the generated libs.
> 
> b) Moving the source
>    This breaks the logical organization of the sources
> 
> c) Manually managing this specific .o one level up
>    This seems even harder to read / understand

I don't think any of these three should be required. The problem isn't
the structure of the makefiles or layout of the source, rather it is
a matter of expanding paths correctly in the build rules.

> So I thought I would dedicate a bit more time to add that capability to the
> unnest-vars function. I did not want to defer review for that, and vaguely
> hoped that there was an existing correct way to do it that someone more
> experienced in the build system could point me to.

With QEMU's build system, regardless of where the rules are defined,
they should get run in the context of the top level makefile, as all
the sub-dir Makefiles are just includes. The unnest-vars function
takes relative filenames and adds the correct directory prefix to
them.

IIUC, common-obj-m gets  spice-app.mo added. common-obj-m is processed
by unnest-vars, but spice-app.mo-objs is not, so all its .o files are
relative. So we just need to fix the way the *.mo-objs variables are
processed, such that unnest-vars is used to add the directory prefixes.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


