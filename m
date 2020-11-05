Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA4F3C4741F
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 15:51:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F232A20782
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 15:51:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b1mEjw7H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F232A20782
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kahY8-00084w-VG
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 10:51:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34786)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kahWy-00077j-7Z
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 10:50:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34990)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kahWv-0007nt-Rj
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 10:50:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604591426;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cjn1G/08z0BmZ1BmAF/nrYKbYyCuErXqpu9jkQUIhf0=;
 b=b1mEjw7HU95GgjCR/Am+M/GLz1HDffBs+t9rT92bsZ8vVYyxuafOXUXL3Aoo+hd0SGOFC8
 tum+nRitl77FIWFVTka5kWkZkMPDpVQwFC3Qdh4R/0W3XkTCOyKua3kOBE+oxV+xspxsns
 X1oEpZ1XNLTAEoO8CGs6CIXi/6am2Jo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-84-Rbxp_bjBM9mZujC6J4DCvQ-1; Thu, 05 Nov 2020 10:50:13 -0500
X-MC-Unique: Rbxp_bjBM9mZujC6J4DCvQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8A6CA11BD345;
 Thu,  5 Nov 2020 15:50:12 +0000 (UTC)
Received: from redhat.com (ovpn-115-13.ams2.redhat.com [10.36.115.13])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 71CE855794;
 Thu,  5 Nov 2020 15:50:10 +0000 (UTC)
Date: Thu, 5 Nov 2020 15:50:06 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: Migrating to the gitlab issue tracker
Message-ID: <20201105155006.GP630142@redhat.com>
References: <3713093e-bf3b-bf23-a8d0-70fe429032ba@redhat.com>
 <c7308133-cf29-8668-f781-6d025eb16722@redhat.com>
 <3d9b264a-5e1f-b936-8455-bafc6b89ebe5@redhat.com>
 <20201030092324.GC99222@redhat.com>
 <CAFEAcA_8PKkfeninOXCzPdtY7WVHnC7Pkon758zXe7h9MzS+aw@mail.gmail.com>
 <20201030101013.GG99222@redhat.com>
 <CAFEAcA9crYaa8-guWkYFDYgEi8=gH3xaXraD7iWZMHM6vryAtw@mail.gmail.com>
 <c75f91b7-6972-9e48-efa9-49792fc011d2@redhat.com>
 <37a00b98-428b-d1ca-79c2-7846ccfda651@redhat.com>
 <de1d3c49-967b-bc96-220f-3deabc441dfa@redhat.com>
MIME-Version: 1.0
In-Reply-To: <de1d3c49-967b-bc96-220f-3deabc441dfa@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/04 22:46:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <alistair23@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Nov 05, 2020 at 10:44:42AM -0500, John Snow wrote:
> On 11/5/20 1:14 AM, Thomas Huth wrote:
> > On 05/11/2020 01.06, John Snow wrote:
> > > On 10/30/20 6:57 AM, Peter Maydell wrote:
> > > > On Fri, 30 Oct 2020 at 10:10, Daniel P. Berrangé <berrange@redhat.com> wrote:
> > > > > This
> > > > > makes it more appealing to leave existing bugs in the LP tracker until
> > > > > they are resolved, auto-closed, or there is a compelling reason to move
> > > > > to gitlab.
> > > > 
> > > > The compelling reason is that there is no way that I want to
> > > > have to consult two entirely separate bug tracking systems
> > > > to see what our reported bugs are. We must have an entry
> > > > in the new BTS for every 'live' bug, whether it was originally
> > > > reported to LP or to gitlab.
> > [...]
> > > OK. I will try to investigate using the Launchpad API to pull our
> > > existing information, and then using the Gitlab API to re-create them.
> > 
> > Before we migrate hundreds of bugs around, I think we should first check
> > which ones are stale, and which are still valid. So for all bugs that are in
> > "New" state and older than, let's say 2 years, I think we should add a
> > message a la:
> > 
> >   The QEMU project is currently considering to move its bug tracking to
> > another system. For this we need to know which bugs are still valid and
> > which could be closed already. Thus we are setting all older bugs to
> > "Incomplete" now. If you still think this bug report here is valid, then
> > please switch the state back to "New" within the next 60 days, otherwise
> > this report will be marked as "Expired". Thank you and sorry for the
> > inconvenience.
> > 
> 
> One reason to NOT do this is that if the bug does wind up being legitimate
> -- perhaps it is still a top google hit for searching a particular error
> string -- once we have migrated, there will be no recourse for the hapless
> googler.

AFAIK, Google will index closed bugs, so they'll still appear in the
search results.

If we really want to, we could put a comment in the bugs we're about
to close, telling people that we're using gitlab now, and to re-file
their bug there if they care about it. I'm not sure that's needed
though, since it is no different a situation to what we have already
with the 1000's of bugs we've closed over the years.

> We can leave a generic forwarder to the new tracker once we migrate, but
> there's no way to "re-open" the issue. If someone re-files on the new
> tracker, they won't be able to update the bug to leave a new breadcrumb.
> 
> However, if we migrate the bug first, we can leave breadcrumbs on the old
> tracker pointing to the new one, and then if the bug winds up being
> legitimate, googlers can follow the breadcrumb to the gitlab issue and
> either update that bug, reopen it, etc.

IMHO they can just file a fresh bug in GitLab from scratch easily
enough by just copy+pasting the existin bug description. I don't
see a benefit in creating 100's of bugs in GitLab that we will
immediately close as being stale.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


