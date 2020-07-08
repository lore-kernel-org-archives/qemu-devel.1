Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65550C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:06:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24A78206DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:06:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e/c/NkxW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24A78206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtIDE-0003nZ-Ab
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 18:06:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36312)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jtHik-0001Oa-DJ
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 17:35:14 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:37629
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jtHie-0002xs-IB
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 17:35:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594244107;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Umkob6RtkhJFODn7inBFm0nhzAaOItWyVkQyCqyqNTo=;
 b=e/c/NkxW1nAKKVKpPw5/e3s2CbMR711caRW9LLKWLp/JLYPkREPXqjOc8U2OpyfK8ePqbp
 4lMnmQHjKtQWXRLcuHkTE59/vWIuBEq6swI6fH3FVPdi6a3/DUAq8lrYhhwmh3OBA8Z8t7
 Ok1IvrdPq5JpAyCWmdEHcG0xpD1181U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-391-X_oUJgkuPlegE8LppuAs0Q-1; Wed, 08 Jul 2020 09:32:26 -0400
X-MC-Unique: X_oUJgkuPlegE8LppuAs0Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B4E6E800688;
 Wed,  8 Jul 2020 13:32:24 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.36])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0823278520;
 Wed,  8 Jul 2020 13:32:17 +0000 (UTC)
Date: Wed, 8 Jul 2020 14:32:14 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: Migrating custom qemu.org infrastructure to GitLab
Message-ID: <20200708133214.GJ3229307@redhat.com>
References: <CAJSP0QV3uB4QY6mzw2JFDedr0PJhGkU5FdmLF5PbjMPyxiYSuw@mail.gmail.com>
 <20200708105353.GE3229307@redhat.com>
 <477ce8e8-283e-6f3e-d3ed-c7f758eaebdb@redhat.com>
 <67032ba5-41fc-8890-29b1-44d27d75f313@redhat.com>
MIME-Version: 1.0
In-Reply-To: <67032ba5-41fc-8890-29b1-44d27d75f313@redhat.com>
User-Agent: Mutt/1.14.3 (2020-06-14)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 17:25:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Cleber Rosa <cleber@redhat.com>, Jeff Cody <codyprime@gmail.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 08, 2020 at 03:19:08PM +0200, Philippe Mathieu-Daudé wrote:
> On 7/8/20 1:48 PM, Thomas Huth wrote:
> > On 08/07/2020 12.53, Daniel P. Berrangé wrote:
> >> On Wed, Jul 08, 2020 at 10:52:38AM +0100, Stefan Hajnoczi wrote:
> > [...]
> >>> With this in mind I propose moving qemu.org infrastructure to GitLab
> >>> incrementally. [...]
> > 
> > FWIW, I think moving the QEMU infrastructure zoo to GitLab is a very
> > good idea!
> > 
> > Daniel already mentioned most of the things that I had in mind after
> > reading your mail (well, actually he mentioned way more things that I
> > had in mind), but let me add some sentences below anyway...
> 
> Same comment ;)
> 
> I find sometime confusing the see which GitLab features are restricted
> to the paid version and which are available for open source projects.
> 
> >>> 5. Issue tracking. Launchpad more or less works, but the login always
> >>> bothers me. If we move git repo hosting then it makes sense to do
> >>> issue tracking on GitLab too.
> >>
> >> The big thing that always bothers me about launchpad is how easy it
> >> is to get confused between issues for QEMU upstream and issues for
> >> legacy releases in Ubuntu distro.
> > 
> > +1000 !
> > 
> > I was already thinking of suggesting to move the bug tracker to either
> > gitlab or github or anywhere else during next KVM forum, since it is
> > IMHO a real pain.
> > 
> > I've seen so many bugs that users tried to open against the downstream
> > Ubuntu QEMU package but ended up in the upstream tracker instead. Apart
> > from that, the Launchpad UI is partly really horrible in my eyes (for
> > example you never know which action will trigger an immediate change and
> > which needs to be confirmed by pressing a button). Additional many
> > developers don't have a Launchpad account, so bugs can not be assigned
> > properly and you just have to pray that people see the notification
> > e-mails on the mailing list.
> > 
> >> There is a question of what todo with existing bugs in launchpad.
> >>
> >> Essentially three choices
> >>
> >>  1. Move all the open bugs to gitlab
> >>  2. Move some relevant bugs to gitlab, but close outdated ones
> >>  3. Leave existing launchpad bugs but don't allow new ones filed
> > 
> > I think we could set most (outdated) bugs simply to "incomplete" with a
> > message saying that the reporter should open a new bug on Gitlab if
> > necessary. Then after 60 days, the "incomplete" bugs will expire (i.e.
> > auto-close).
> 
> Some users hide their email on launchpad, so we would be hard to simply
> re-import their bug on gitlab. Now if you ask them to import it, it is
> easier. 60 days seem enough to react.
> 
> Something that always bugged me on launchpad is you can not Cc other
> people on a bug if they don't have a launchpad account. I haven't
> checked if GitLab allows that (Bugzilla does).

GitLab doesn't expose anyone's email address. Any interaction with other
users is exclusively via their GitLab user name. So yes, you need an
account to be added to notifications for an issue.

> We should do some experiments first, because I saw various ways to use
> the GitLab ticket tags, and none convinced me it is practical.

Why is that ?  I find the tagging to be one of the things i really
like coming over from the bugzilla world. It is useful for doing an
initial triage of bugs in particular, to sort them into logical buckets.

I think that's particularly useful with our subsystem maintainer model,
as it will let us direct bugs towards specific maintainers.

In libvirt we had some generic labels for all projects

  https://gitlab.com/groups/libvirt/-/labels

And then further project specific labels

  https://gitlab.com/libvirt/libvirt/-/labels

> Should anyone add any tag? Should we restrict to a set of useful tags?

I believe only admins can define the tags, you can't add arbitrary
tags to a project as a user.

> I suppose tags are hints to maintainers, so keeping something similar to
> the MAINTAINERS file separation could be useful.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


