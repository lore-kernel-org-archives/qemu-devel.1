Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5EFFC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:19:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56BAD206DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:19:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ORyP20i0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56BAD206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtIPm-0006N9-K4
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 18:19:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41368)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jtI2c-0001Nc-25
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 17:55:46 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:29760
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jtI2Z-0005cY-Mg
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 17:55:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594245343;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b9YJ5mlmZ6yzT0b1ld8553tjQVL+K1ONjOdx34H2D2M=;
 b=ORyP20i0okdM8O5/IOnnL6GKTo4WC3MVtpyAcHvcbz3ypoiBDpDPiXEU7I44hObdWHFqdo
 yvyS9nmpzg/02jezqcXz9iZOuYYI/5AdmxxwlnnUcejgkSZ/ClBwddITZ2o5L+diLb/z8Q
 L4xbyZUqVPAuFw51uKCvQvopQAUDt/w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204-QjF7WcrtMvawwj1dfChnjQ-1; Wed, 08 Jul 2020 06:54:08 -0400
X-MC-Unique: QjF7WcrtMvawwj1dfChnjQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EDD781902EB0;
 Wed,  8 Jul 2020 10:54:06 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.36])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 257FD1001268;
 Wed,  8 Jul 2020 10:53:55 +0000 (UTC)
Date: Wed, 8 Jul 2020 11:53:53 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: Migrating custom qemu.org infrastructure to GitLab
Message-ID: <20200708105353.GE3229307@redhat.com>
References: <CAJSP0QV3uB4QY6mzw2JFDedr0PJhGkU5FdmLF5PbjMPyxiYSuw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJSP0QV3uB4QY6mzw2JFDedr0PJhGkU5FdmLF5PbjMPyxiYSuw@mail.gmail.com>
User-Agent: Mutt/1.14.3 (2020-06-14)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 08, 2020 at 10:52:38AM +0100, Stefan Hajnoczi wrote:
> Dear QEMU community,
> QEMU currently has a static website, wiki, git repo hosting, and
> special-purpose cronjobs/containers running in VMs. There is currently
> no system administrator looking after our infrastructure so the most
> urgent tasks fall onto me, the remainder are ignored/postponed. The
> current situation exposes qemu.org to the risk of downtime and
> security issues.

I would further say that maintaining infrastructure is not a good use
of our contributors' time. It is better to have our contributors spend
time delivering features that are beneficial to our users, rather than
playing at sysadmin.

> Another limitation is that each piece of infrastructure is managed
> separately and one-time contributors cannot easily propose changes
> because they do not have access. It would be much better to use our
> existing code review process so that anyone can make changes to
> infrastructure by sending a patch.

When I was thinking about this for libvirt I came to better understand
the appeal of the gitforge for project infrastructure. I've written
about it in detail for libvirt:

   https://www.redhat.com/archives/libvir-list/2020-March/msg00009.html

The distributed SCM model of git democratized access to source control
features across contributors. Drive-by contributors have the same level
of SCM features as the main project contributors, instead of being
second class citizens as they are with a non-distributed SCM.

With the hosted Git forges, this concept covers all aspects of project
infrastructure. If your project is using GitLab for all its infra
needs, then when a user forks the repo they get access to all the
same features as the main project. The fork is no longer a second
class citizen lacking access to certain parts of the infra. I find
this is especially compelling in the area of CI, containers and web
hosting.

Consider if qemu-web.git is hosted on gitlab, using GitLab CI to
generate the static site content, and GitLab pages to host the
website. If a user wants to contribute to qemu-web, they can fork
the repo and be confident that the CI jobs in their fork are going
to work in the exact same way as in the master repo. They can use
GitLab Pages to browse the generated content for their fork to
see exactly how it will look.

This eliminates the big pain point in qemu-web contribution. Many
times I was tripped up with the problem of qemu-web.git requiring
a version of Jekyll that is incompatible with the version that
ships on my distro.

> GitLab's Continuous Integration (CI) system provides a powerful way to
> perform actions defined in yaml files in qemu.git. This includes
> running scripts, builds, publishing build artifacts, etc. We have
> already begun using it for automated builds and tests:
> https://gitlab.com/qemu-project/qemu/-/blob/master/.gitlab-ci.yml

The CI integration has probably been the single best thing about
libvirt's switch to GitLab.

> GitLab also offers git repo hosting, wikis, issue tracking, and other
> features. It is possible to log in using GitHub, Google, or Twitter
> single sign-on if you do not want to create another account. As more
> open source projects use GitLab it becomes easier for one-time
> contributors who will already be familiar with the tools from other
> projects.

> Here is a full list of GitLab's features:
> https://about.gitlab.com/features/
>=20
> GitLab offers the gold/ultimate tier for free to open source projects:
> https://about.gitlab.com/solutions/open-source/
>=20
> GitLab itself is open source and can be self-hosted if we decide to
> leave in the future.

NB self-hosting would reduce features compared to gitlab.com unless
you paid for the enterprise edition. You'd also have to bring your
own infra for running CI jobs which quickly gets very expensive
as freedesktop.org admins have learnt the hard way. The CI resources
provided by gitlab.com are incredibly generous.

> With this in mind I propose moving qemu.org infrastructure to GitLab
> incrementally. This needs to be done carefully to avoid disruption and
> only where GitLab meets the requirements. The QEMU project will
> continue to have access to cloud hosting for running custom
> infrastructure or adding runners to GitLab CI to improve CI
> performance.
>=20
> The following infrastructure components can be considered for GitLab migr=
ation:
>=20
> 1. qemu-web.git static site generation. GitLab CI/CD can build the
> static website on each qemu-web.git commit and publish the HTML
> artifacts.

This is an easy win. it should be especially simple for qemu, compared to
libvirt, since qemu.org already used separate sub-domains for other content
like git & downloads.

> 2. wiki.qemu.org is a MediaWiki instance. Account creation is a hurdle
> to one-time or new contributors. It is unclear whether GitLab's wiki
> is expressive enough for a lossless conversion of the existing QEMU
> wiki. Any volunteers interested in evaluating the wiki migration would
> be appreciated.

Yeah, this is a potentially big piece of work. We didn't finish this
in libvirt either. Looking at the libvirt mediawiki though, I decided
not todo a straight export/import of all content.

A bunch of content was horribly out of date and needed deleting as
it was irrelevant to anyone, or outright misleading wrt current state
of the world.

A lot of content on the wiki really only existed in the wiki, because
contributing to our libvirt.org website was harder than it needed to
be. We switched the main website over to use RST instead of HTML so
authoring content is much closer to what you'd experience with the
wiki markup. The wiki became a burden for contributors as due to
spam attacks we can't allow anonymous access, and need manual account
creation as with QEMU wiki.

Every page on the main website now has a link "edit this page"
that takes you straight to the source file in the gitlab.com UI,
where you can interactively edit the text in your fork and then
submit a merge request with the result.

The wiki also suffered from the content not having any level of review.
While the intentions of many contributors were good, the results often
left alot to be desired.=20

So overall we decided that while GitLab does offer a wiki, we are not
intending to use it. Instead we're going to aim to turn the subset of
wiki content that is genuinely useful into pages on the main website.

IOW, I'd encourage whoever tackles the wiki to look at the content
with a critical eye and decide whether it really belongs in the wiki
at all. Considering:

  https://wiki.qemu.org/index.php?title=3DSpecial:AllPages

The Planning / Changes pages for each release are probably reasonable
as wiki pages.

The Interships/ProjectIdeas pages would possibly be better off as
GitLab Issue tickets, tagged with a "interships" label. That way
when a project starts you can have the issue to track the work
right from the start.

The Documentation/Platforms content arguably should be part of
the main qemu.git docs.

Many of the feature pages are probably better as part of the formal
QEMU documentation too.

> 3. Git repo hosting is a core feature of GitLab and we already have a
> qemu.git mirror. Hosting the repos on GitLab reduces the need for
> qemu.org ssh access.

With libvirt we had long used both gitlab.com/libvirt and github.com/libvir=
t
as read-only mirrors of the master libvirt.org/git/ repos.  When we formall=
y
adopted gitlab as primary infrastructure, we simply flipped the mirroring
processes around. So now libvirt.org/git is a read-only mirror, and gitlab
is the master.  Gitlab has built-in support to push to github.com as a
mirror which is useful.

So turning git.qemu.org into a readonly mirror would ease the transition
to avoid breaking any scripts / workflows relying on that URL in the short
term.

> 4. The QEMU release process can be moved to CI/CD so that publishing
> stable releases and release candidates is less dependent on one
> committer's machine or scripts.
>=20
> 5. Issue tracking. Launchpad more or less works, but the login always
> bothers me. If we move git repo hosting then it makes sense to do
> issue tracking on GitLab too.

The big thing that always bothers me about launchpad is how easy it
is to get confused between issues for QEMU upstream and issues for
legacy releases in Ubuntu distro. This is the curse of using a distro
issue tracker - libvirt had the same problem with its use of Red Hat
bugzilla.

Integrated issue tracking alongside the primary git repo makes a lot
of sense. Once you declare gitlab.com the primary repo, contributors
will immediately look to gitlab for the issue tracking too whether
you tell them to or not.=20

The gitlab issue tracker is fairly simple especially compared to the
complexity horror of red hat bugzilla, so it was a massive win for
libvirt to switch away from bugzilla for issues. Probably not such
a big difference compared to launchpad in terms of complexity. The
little things though like magic git commit messages to close issues
are nice though.

There is a question of what todo with existing bugs in launchpad.

Essentially three choices

 1. Move all the open bugs to gitlab
 2. Move some relevant bugs to gitlab, but close outdated ones
 3. Leave existing launchpad bugs but don't allow new ones filed

So far for libvirt we did option 3 there, with a little bit of
option 2.

> There is a snowball effect where the experience is improved the more
> GitLab features we use, so I hope that most of these migrations will
> be possible.
>=20
> Next steps:
>  * If you have an interest in one or more of these infrastructure
> components, please join the discussion.
>  * If there are no volunteers for an infrastructure component I'll
> slowly work my way through evaluating GitLab and propose migrations

The experiance of moving infra to gitlab.com has been quite positive
for libvirt, and me in particular as the single point of failure for
much of libvirt's old infrastructure. I think it will be beneficial
for QEMU too, for many of the reasons I mention above and in the
email link I quoted.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


