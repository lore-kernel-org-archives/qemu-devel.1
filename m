Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7735DC388F7
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 17:25:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DDBA247F8
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 17:25:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bTdcAyfC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DDBA247F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXpCU-000730-Ae
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 13:25:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41556)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kXokA-0008Df-Vt
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 12:56:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38547)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kXok9-00036A-1g
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 12:56:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603904172;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=q7TZAehIrdCEJ9+4mHgX3xlBDF7paRK7s0Codndu2Vc=;
 b=bTdcAyfCKbjlayChYD07EO++5bg4lTcAbiRXg+xtVyFEarVvjznHZMr4v49ytNQDnLQFvl
 iKX+mmlCijXRcULKfvboF7gEbWqIHJs82UcI7c81qpU+hSsaDc8gi34sMYob5r4nNA2eNZ
 War653go2Z7FZcGorvCWooDzBReGxu0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-LiVxcT87NrO1UQ2bSiDDdQ-1; Wed, 28 Oct 2020 12:56:05 -0400
X-MC-Unique: LiVxcT87NrO1UQ2bSiDDdQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 13B5D8DBCD2
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2020 16:55:42 +0000 (UTC)
Received: from redhat.com (ovpn-114-125.ams2.redhat.com [10.36.114.125])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0861E73661;
 Wed, 28 Oct 2020 16:55:40 +0000 (UTC)
Date: Wed, 28 Oct 2020 16:55:38 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH 04/29] vl: remove bogus check
Message-ID: <20201028165538.GB4208@redhat.com>
References: <20201027182144.3315885-1-pbonzini@redhat.com>
 <20201027182144.3315885-5-pbonzini@redhat.com>
 <20201028174857.59e2242e@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201028174857.59e2242e@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 01:50:00
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Oct 28, 2020 at 05:48:57PM +0100, Igor Mammedov wrote:
> On Tue, 27 Oct 2020 14:21:19 -0400
> Paolo Bonzini <pbonzini@redhat.com> wrote:
> 
> > There is no reason to prevent -preconfig -daemonize.  Of course if
> > no monitor is defined there will be no way to start the VM,
> > but that is a user error.
> 
> it was related to how libvirt starts QEMU but I don't recall why anymore,
> CCing Daniel

Libvirt didn't request this to best of my knowledge.

We don't even use -daemonize, so have no reason to ask to forbid
-preconfig with -daemonize.

> 
> > 
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >  softmmu/vl.c | 6 ------
> >  1 file changed, 6 deletions(-)
> > 
> > diff --git a/softmmu/vl.c b/softmmu/vl.c
> > index 7f39ebdfee..dbb72e621e 100644
> > --- a/softmmu/vl.c
> > +++ b/softmmu/vl.c
> > @@ -4027,12 +4027,6 @@ void qemu_init(int argc, char **argv, char **envp)
> >      }
> >  
> >      if (is_daemonized()) {
> > -        if (!preconfig_exit_requested) {
> > -            error_report("'preconfig' and 'daemonize' options are "
> > -                         "mutually exclusive");
> > -            exit(EXIT_FAILURE);
> > -        }
> > -
> >          /* According to documentation and historically, -nographic redirects
> >           * serial port, parallel port and monitor to stdio, which does not work
> >           * with -daemonize.  We can redirect these to null instead, but since
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


