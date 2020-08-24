Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B38BDC433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 09:40:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F72C2075B
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 09:40:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RRD/9U2V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F72C2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kA8xu-0001Kv-P5
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 05:40:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44552)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kA8xJ-0000in-8B
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 05:39:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26335
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kA8xG-0003hg-Ti
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 05:39:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598261992;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ijKyWWKGEqvFzU0U4/PA3+BDVILm7DfOymVz0lFxVJQ=;
 b=RRD/9U2VY/WDbbSsW6Aslh6lK3DoFhlSFlJ09OjSPbLbogKJ6+knuAZ4GeAydxZBqOWs5x
 aspubamufnpV/aM14A8jWEUaVM45l3q4fG/EqR7Y58Vs01bnZ7FHcu7Zem5/Gr3VoBEqWY
 RSTt5OXysxixKSNPqQ3+CJZEKNlN0OI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-219-TfnGYRUAOK-Fh7jF8pf30Q-1; Mon, 24 Aug 2020 05:39:50 -0400
X-MC-Unique: TfnGYRUAOK-Fh7jF8pf30Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 83A2681F006;
 Mon, 24 Aug 2020 09:39:49 +0000 (UTC)
Received: from redhat.com (ovpn-114-223.ams2.redhat.com [10.36.114.223])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B0D495D9DD;
 Mon, 24 Aug 2020 09:39:44 +0000 (UTC)
Date: Mon, 24 Aug 2020 10:39:41 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?B?5byg5L2z6L6w?= <zhangjiachen.jaycee@bytedance.com>
Subject: Re: [External] Re: [PATCH] virtiofsd: add -o
 allow_directio|no_directio option
Message-ID: <20200824093941.GD10011@redhat.com>
References: <20200821034126.8004-1-zhangjiachen.jaycee@bytedance.com>
 <20200821115829.GJ348677@redhat.com>
 <CAFQAk7hqGxNdQJCRn2xsKnyuasPJnHS1hq3azkVc54U2VyDm3Q@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFQAk7hqGxNdQJCRn2xsKnyuasPJnHS1hq3azkVc54U2VyDm3Q@mail.gmail.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/24 05:27:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Yongji Xie <xieyongji@bytedance.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Aug 22, 2020 at 01:51:04AM +0800, 张佳辰 wrote:
> On Fri, Aug 21, 2020 at 7:58 PM Daniel P. Berrangé <berrange@redhat.com>
> wrote:
> 
> > On Fri, Aug 21, 2020 at 11:41:26AM +0800, Jiachen Zhang wrote:
> > > Due to the commit 65da4539803373ec4eec97ffc49ee90083e56efd, the O_DIRECT
> > > open flag of guest applications will be discarded by virtiofsd. While
> > > this behavior makes it consistent with the virtio-9p scheme when guest
> > > applications using direct I/O, we no longer have any chance to bypass
> > > the host page cache.
> > >
> > > Therefore, we add a flag 'allow_directio' to lo_data. If '-o no_directio'
> > > option is added, or none of '-o no_directio' or '-o allow_directio' is
> > > added, the 'allow_directio' will be set to 0, and virtiofsd discards
> > > O_DIRECT as before. If '-o allow_directio' is added to the stariting
> > > command-line, 'allow_directio' will be set to 1, so that the O_DIRECT
> > > flags will be retained and host page cache can be bypassed.
> > >
> > > Signed-off-by: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
> > > ---
> > >  tools/virtiofsd/helper.c         |  4 ++++
> > >  tools/virtiofsd/passthrough_ll.c | 20 ++++++++++++++------
> > >  2 files changed, 18 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/tools/virtiofsd/helper.c b/tools/virtiofsd/helper.c
> > > index 3105b6c23a..534ff52c64 100644
> > > --- a/tools/virtiofsd/helper.c
> > > +++ b/tools/virtiofsd/helper.c
> > > @@ -180,6 +180,10 @@ void fuse_cmdline_help(void)
> > >             "                               (0 leaves rlimit
> > unchanged)\n"
> > >             "                               default: min(1000000,
> > fs.file-max - 16384)\n"
> > >             "                                        if the current
> > rlimit is lower\n"
> > > +           "    -o allow_directio|no_directio\n"
> > > +           "                               retain/discard O_DIRECT
> > flags passed down\n"
> > > +           "                               to virtiofsd from guest
> > applications.\n"
> > > +           "                               default: no_directio\n"
> > >             );
> >
> > The standard naming convention from existing options is to use
> > $OPTNAME and no_$OPTNAME.
> >
> > IOW, don't use the "allow_" prefix. The options should be just
> > "directio" and "no_directio"
> >
> > Thanks, Daniel. I did consider using "directio" instead of "allow_directio"
> before I send out this patch. Although "-o directio" makes it consistent
> with other option names, it may confuse the users of virtiofsd.
> Because currently, virtiofsd will not add an O_DIRECT to the open flag,
> it will just retain or discard the O_DIRECT added by guest applications.
> But "-o direct" may make the users think that virtiofsd will do direct IO
> all
> the time.

Then -o allow_direct_io   and  -o no_allow_direct_io


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


