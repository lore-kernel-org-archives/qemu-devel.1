Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5140C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 16:26:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23394217BA
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 16:26:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O6aULYkf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23394217BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHrIn-00050t-7J
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 12:26:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57102)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kHr7M-0002ZX-4A
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 12:14:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37521)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kHr7H-0003iI-Ti
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 12:14:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600100045;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+ji4A7/kEC0oz8TPzE+FOJBQcoBaBGnAbl42yimXY3Y=;
 b=O6aULYkfm2I72OgTD3d9QOeAJ8Ae1oZzOgjDh3J8hpmypeQr12hvIuDa+ckHfxNvgFelZu
 qHvAY2i7yRovqkooYU65iW7CLl1uBDyzt0OTO/tI6scnJ479KmDl30M2ZHlJ53YXzMqtCH
 +DqVZ/Gu3Lk5mMGZuq4ra9fFNJ5VoO8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-188-dtTnYhm2NzC-5-wgzK9xbg-1; Mon, 14 Sep 2020 12:13:38 -0400
X-MC-Unique: dtTnYhm2NzC-5-wgzK9xbg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B93491007B00;
 Mon, 14 Sep 2020 16:13:36 +0000 (UTC)
Received: from redhat.com (ovpn-114-99.ams2.redhat.com [10.36.114.99])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 99406805CF;
 Mon, 14 Sep 2020 16:13:33 +0000 (UTC)
Date: Mon, 14 Sep 2020 17:13:30 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Subject: Re: [PATCH v8 13/27] tests: Enable crypto tests under msys2/mingw
Message-ID: <20200914161330.GP1252186@redhat.com>
References: <20200912224431.1428-1-luoyonggang@gmail.com>
 <20200912224431.1428-14-luoyonggang@gmail.com>
 <119be52f-fc8b-dd37-e3d6-04a13109c845@redhat.com>
 <CAE2XoE-Qi1aZhq09QEswq-NFYRYWV+ZM4YZz=pGCynMd5Ova8Q@mail.gmail.com>
 <fb3a1a4f-fb60-00f2-878a-f61241adcfb3@redhat.com>
 <CAE2XoE_SQ9i4RHq9=SDukVag=cYvv6BNo_aQv9PSq3box4keiQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAE2XoE_SQ9i4RHq9=SDukVag=cYvv6BNo_aQv9PSq3box4keiQ@mail.gmail.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 02:55:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.792,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Ed Maste <emaste@freebsd.org>, Qemu-block <qemu-block@nongnu.org>,
 Stefan Weil <sw@weilnetz.de>, Xie Changlong <xiechanglong.d@gmail.com>,
 Peter Lieven <pl@kamp.de>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 qemu-level <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Wen Congyang <wencongyang2@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Sep 14, 2020 at 11:58:24PM +0800, 罗勇刚(Yonggang Luo) wrote:
> On Mon, Sep 14, 2020 at 7:07 PM Thomas Huth <thuth@redhat.com> wrote:
> >
> > On 14/09/2020 10.19, 罗勇刚(Yonggang Luo) wrote:
> > >
> > >
> > > On Mon, Sep 14, 2020 at 3:23 PM Thomas Huth <thuth@redhat.com
> > > <mailto:thuth@redhat.com>> wrote:
> > >>
> > >> On 13/09/2020 00.44, Yonggang Luo wrote:
> > >> > Fixes following tests on msys2/mingw
> > >> >       'test-crypto-tlscredsx509': ['crypto-tls-x509-helpers.c',
> > > 'pkix_asn1_tab.c',
> > >> >                                    tasn1, crypto],
> > >> >       'test-crypto-tlssession': ['crypto-tls-x509-helpers.c',
> > > 'pkix_asn1_tab.c', 'crypto-tls-psk-helpers.c',
> > >> >                                  tasn1, crypto],
> > >> >       'test-io-channel-tls': ['io-channel-helpers.c',
> > > 'crypto-tls-x509-helpers.c', 'pkix_asn1_tab.c',
> > >> >                               tasn1, io, crypto]}
> > >> > These tests are failure with:
> > >> > ERROR test-crypto-tlscredsx509 - missing test plan
> > >> > ERROR test-crypto-tlssession - missing test plan
> > >> > ERROR test-io-channel-tls - missing test plan
> > >> >
> > >> > Because on win32 those test case are all disabled in the header
> > >> >
> > >> > Add qemu_socket_pair for cross platform support, convert file system
> > >> > handling functions to glib
> > >> > Add qemu_link function instead posix only link function.
> > >> > Use send ad recv from qemu that convert Windows Socks error
> > >> > to errno properly.
> > >> >
> > >> > Signed-off-by: Yonggang Luo <luoyonggang@gmail.com
> > > <mailto:luoyonggang@gmail.com>>
> > >> > ---
> > [...]
> > >> Where do you've got this code from? It seems like this has been taken
> > >> from a 3rd party source? E.g.:
> > >>
> > >>  https://blog.csdn.net/wufuhuai/article/details/79761889
> > >>
> > >> What's the license of this new code? ... please clarify such details in
> > >> the commit description.
> > >
> > > The original code have no license information, neither copyleft nor
> > > copyright, what's your suggestion
> > > or rewrite it?
> > >
> >
> > You can not simply copy code without license information and submit this
> > as if it was your own! Please never do that again!
> > With your Signed-off-by line, you basically acknowledge that you've read
> > and followed the Developer Certificate of Origin:
> >
> >  https://developercertificate.org/
> >
> > If you haven't done that yet, please do it now!
> >
> > And for this patch here, I don't think that it is acceptable without
> > proper license information.
> >
> >  Thomas
> >
> See that, How about using
> https://developer.gnome.org/glib/stable/glib-IO-Channels.html#g-io-channel-new-file
> to act as socketpair? and it's cross-platform, I don't need to add
> platform-dependent codes.

That doesn't provide socketpair functionality. QEMU already has its
QIOChannel impl that is more advanced, but again that doesn't have
socketpair either because Windows lacks that.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


