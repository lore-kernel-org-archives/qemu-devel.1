Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB6CC55178
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 09:11:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28BB024182
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 09:11:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eRF2S3Nv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28BB024182
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVt6J-0003wi-5W
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 05:11:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53896)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kVt5Y-0003QZ-89
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 05:10:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48294)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kVt5V-0003h3-C5
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 05:10:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603444216;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=kNWJFvti+E2Sp53qmFb7O2/SOBXYqQ1LluWT5hG2YUA=;
 b=eRF2S3NvqSKyqib64CpoE4s4Nv6Mlh9GH6ZOjtBB6hrcyQDYQ01I506dszp5Inrc83LgY/
 iW3kj21MItRJrmbq7L+iq0m9MqPs/6xuEUxWSV2Qvw+uegAdeZhPUTYTC/OfrniuLWFu5k
 lHPDqJYWIvpQoGIppeNJQaGw4hGFFNM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-1jpC6GFFPT2I5hyaXjwCVg-1; Fri, 23 Oct 2020 05:10:12 -0400
X-MC-Unique: 1jpC6GFFPT2I5hyaXjwCVg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8050A804B92;
 Fri, 23 Oct 2020 09:10:10 +0000 (UTC)
Received: from redhat.com (ovpn-114-187.ams2.redhat.com [10.36.114.187])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 74E4226335;
 Fri, 23 Oct 2020 09:10:01 +0000 (UTC)
Date: Fri, 23 Oct 2020 10:09:58 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: Migrate Wiki to Gitlab? (was: Migrating custom qemu.org
 infrastructure to GitLab)
Message-ID: <20201023090958.GD445638@redhat.com>
References: <CAJSP0QV3uB4QY6mzw2JFDedr0PJhGkU5FdmLF5PbjMPyxiYSuw@mail.gmail.com>
 <20200708105353.GE3229307@redhat.com>
 <20200709101602.lc2uipjlxobjvjn3@sirius.home.kraxel.org>
 <3dacddaa-c739-445b-a24a-02f9e51b9b0e@redhat.com>
 <436a85e3-a6af-b344-fe04-26acf1dbcb38@redhat.com>
MIME-Version: 1.0
In-Reply-To: <436a85e3-a6af-b344-fe04-26acf1dbcb38@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 01:44:00
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Cleber Rosa <cleber@redhat.com>,
 Jeff Cody <codyprime@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 23, 2020 at 07:59:00AM +0200, Thomas Huth wrote:
> On 09/07/2020 12.22, Thomas Huth wrote:
> > On 09/07/2020 12.16, Gerd Hoffmann wrote:
> >>   Hi,
> >>
> >>>> 2. wiki.qemu.org is a MediaWiki instance. Account creation is a hurdle
> >>>> to one-time or new contributors. It is unclear whether GitLab's wiki
> >>>> is expressive enough for a lossless conversion of the existing QEMU
> >>>> wiki. Any volunteers interested in evaluating the wiki migration would
> >>>> be appreciated.
> >>>
> >>> Yeah, this is a potentially big piece of work. We didn't finish this
> >>> in libvirt either. Looking at the libvirt mediawiki though, I decided
> >>> not todo a straight export/import of all content.
> >>
> >> FYI: gitlab wiki is basically just a git repo with markdown pages +
> >> renderer + gui editor.  You can also update the wiki using git clone +
> >> edit + git commit + git push.
> > 
> > FWIW, seems like we could use the "pandoc" tool to convert Mediawiki
> > (our old Wiki) to Markdown (Gitlab wiki). I've done a quick test and
> > converted https://wiki.qemu.org/Contribute/MailingLists into
> > https://gitlab.com/huth/qemu/-/wikis/Contribute/MailingLists with some
> > few clicks.
> 
> Revisiting this topic after a couple of weeks, I think there is one more
> thing to consider: If I've got that right, your account has to be a member
> of the corresponding project to be able to edit a page in the Wiki in
> gitlab. So unless we want to add lots of persons to the qemu-project as
> members (which we likely do not really want, do we?), it's maybe better to
> keep the separate MediaWiki instance with the separate user accounts, I guess?

Yep, manual says it requires "Developer" permissions which is certainly
not something we want to give out widely, as it grants way too much
privilege.

I'd still suggest we look at folding the wiki into either the website or
the main repo documentation as appropriate for the docs in question.
Having 3 separate sources of documentation just feels wrong to me, and
we largely lost the "drive by" contributor for the wiki since we had
to lock new account creation - only a handful of people actually ask us
to create accounts for them.

The qemu-web.git could be made fairly low overhead for contributors by
accepting contributions via merge requests, which would let people just
interatively edit the web pages and submit the changes all from the web
UI. Not quite as seemless as a wiki, but not far off.

We could even demarcate a subset of the website with a /wiki URL and just
stuff all current wiki content in there as RST. Then have a much looser
review policy for merging changes in that subtree. Basically allow anything
as long as it is well formatted and not grossly incorrect. Could even 100%
automate approval under that subdir if you want the true wiki experiance
of having no content review.


The main downside with the main qemu.git documentation is that it takes
a long time to get docs through the contribution workflow and you have
to deal with the qemu-devel firehose. Use of RST has improved the authoring
part, but review/merge is still a bit tedious. There is no single docs
maintainer, and parts of docs are completely lacking maintainer entries.
So it can be pot-luck whether your docs contribution gets reviewed and
merged in reasonable time.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


