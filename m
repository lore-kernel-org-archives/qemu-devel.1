Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0884FC43467
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 10:03:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EF512083B
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 10:03:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FXKkPM55"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EF512083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQSm9-0004pE-6n
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 06:03:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59400)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kQSjm-0003KH-B4
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 06:01:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24771)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kQSjf-0001Y0-23
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 06:01:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602151277;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kLqG2GgsSnQGXbqTi8xXLTyjK/Okiuo0hLG/fQaFKBw=;
 b=FXKkPM55HO7XP+ZoC3sffjWIVfflK5DgJAUqzscmp222CZBSCKUwqHGagZiAizZpdS81SB
 Mw6F6qsrwH+5XeSciWhbR03P1RCT4oEoawJE574g2O/0nbeomk9uuH7uEPG+ZyDo86b3/8
 q8vvCukMeFFva71YGOUFLbwiVUz+8hY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-HdHA793_MWmn8zcELEe1LQ-1; Thu, 08 Oct 2020 06:01:13 -0400
X-MC-Unique: HdHA793_MWmn8zcELEe1LQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C806A81F011;
 Thu,  8 Oct 2020 09:55:11 +0000 (UTC)
Received: from work-vm (ovpn-114-212.ams2.redhat.com [10.36.114.212])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1BB0C7369C;
 Thu,  8 Oct 2020 09:55:07 +0000 (UTC)
Date: Thu, 8 Oct 2020 10:55:05 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: "misono.tomohiro@fujitsu.com" <misono.tomohiro@fujitsu.com>
Subject: Re: [Virtio-fs] [PATCH] configure: add option for virtiofsd
Message-ID: <20201008095505.GA2962@work-vm>
References: <20201007092913.1524199-1-misono.tomohiro@jp.fujitsu.com>
 <15796673-2daf-70a8-4b20-b861d4c22e62@redhat.com>
 <OSBPR01MB45820C38F613E3D38A565CCEE50B0@OSBPR01MB4582.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <OSBPR01MB45820C38F613E3D38A565CCEE50B0@OSBPR01MB4582.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/08 01:56:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.742,
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
Cc: "virtio-fs@redhat.com" <virtio-fs@redhat.com>,
 'Paolo Bonzini' <pbonzini@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* misono.tomohiro@fujitsu.com (misono.tomohiro@fujitsu.com) wrote:
> > On 07/10/20 11:29, Misono Tomohiro wrote:
> > > Currently it is unknown whether virtiofsd will be built at
> > > configuration time. It will be automatically built when dependency is
> > > met. Also, required libraries are not clear.
> > >
> > > To make this clear, add configure option --{enable,disable}-virtiofsd.
> > > The default is the same as current (enabled if available) like many
> > > other options. When --enable-virtiofsd is given and dependency is not
> > > met, we get:
> > >
> > >   ERROR: virtiofsd requires libcap-ng devel, seccomp devel, vhost user
> > > and tools support
> > >
> > > In addition, configuration summary now includes virtiofsd entry:
> > >
> > >   build virtiofs daemon: YES/NO
> > >
> > > Sidenote: this patch defines CONFIG_VIRTIOFSD for config-host.mak to
> > > avoid duplicate dependency check in tools/meson.build.
> > >
> > > Signed-off-by: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
> > 
> > Hi Misono,
> > 
> > can you please handle the option via meson_options.txt?  That is, just pass the value (auto/enabled/disabled) through
> > from configure to meson, and handle the default in tools/meson.build.  The logic will be something like this:
> > 
> > have_virtiofsd = (targetos == 'linux' and
> >     'CONFIG_SECCOMP' in config_host and
> >     'CONFIG_LIBCAP_NG' in config_host)
> > 
> > if get_option('virtiofsd').enabled()
> >   if not have_virtiofsd
> >     if targetos != 'linux'
> >       error('virtiofsd requires Linux')
> >     else
> >       error('virtiofsd requires libcap-ng-devel and seccomp-devel')
> >     endif
> >   endif
> > elif get_option('virtiofsd').disabled() or not have_tools or \
> >      not 'CONFIG_VHOST_USER' in config_host
> >   have_virtiofsd = false
> > endif
> > 
> > if have_virtiofsd
> >   subdir('virtiofsd')
> > endif
> > 
> > This is because, when adding the option, there are some conditions that should disable virtiofsd by default but can be
> > overridden with --enable-virtiofsd.
> > 
> > More information on how to create a new Meson option can be found in docs/devel/build-system.rst.
> 
> Hi Paolo
> 
> Thanks a lot for the clear explanation. I will update the patch to follow the meson style.
> I realized virtiofsd actually needs tools (i.e. "--disable-tools --enable-virtiofsd"
> does not work with above meson.build) since virtiofsd requires libvhost_user which will
> be built ony when tools are built. So, I will keep the current dependency check (except 'have_system').
> 
> BTW, while testing the updated patch, I noticed current master branch (as of 10/08) fails to execute virtiofsd.
> backtrace from coredump shows:
> #0  get_relocated_path (dir=0x560f4d2f2ef0 "/usr/local/var/run/virtiofsd") at ../util/cutils.c:924
> #1  0x0000560f4baab6da in qemu_get_local_state_pathname (relative_pathname=relative_pathname@entry=0x560f4bac6cf1 "run/virtiofsd")
>     at ../util/oslib-posix.c:345
> #2  0x0000560f4baa1b09 in fv_socket_lock (se=0x560f4d2f2f20) at ../tools/virtiofsd/fuse_virtio.c:865
> #3  fv_create_listen_socket (se=0x560f4d2f2f20) at ../tools/virtiofsd/fuse_virtio.c:906
> #4  virtio_session_mount (se=0x560f4d2f2f20) at ../tools/virtiofsd/fuse_virtio.c:968
> #5  0x0000560f4ba99725 in main (argc=<optimized out>, argv=<optimized out>) at ../tools/virtiofsd/passthrough_ll.c:2947
> 
> So, this is related to: https://github.com/qemu/qemu/commit/f4f5ed2cbde65acaa1bd88d00cc23fa8bf6b5ed9#diff-ae9b732998587b609c0854bae40b2fe6R924
> 
> Adding  "qemu_init_exec_dir(argv[0]);" in virtiofs's main() seems solve the problem, 
> but is it correct fix?

Yes, I've already posted the fix for that,
   https://lists.gnu.org/archive/html/qemu-devel/2020-10/msg01852.html

Dave

> Regards,
> Misono
> 
> > 
> > Thanks,
> > 
> > Paolo
> > 
> > > -have_virtiofsd = (have_system and
> > > -    have_tools and
> > > -    'CONFIG_LINUX' in config_host and
> > > -    'CONFIG_SECCOMP' in config_host and
> > > -    'CONFIG_LIBCAP_NG' in config_host and
> > > -    'CONFIG_VHOST_USER' in config_host)
> > > -
> > > -if have_virtiofsd
> > > +if 'CONFIG_VIRTIOFSD' in config_host
> > >    subdir('virtiofsd')
> > >  endif
> > >
> 
> 
> _______________________________________________
> Virtio-fs mailing list
> Virtio-fs@redhat.com
> https://www.redhat.com/mailman/listinfo/virtio-fs
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


