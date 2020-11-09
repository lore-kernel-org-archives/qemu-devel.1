Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87283C4741F
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 10:12:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFADB20684
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 10:12:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jGtCaftB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFADB20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc49Y-0008P5-Fn
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 05:12:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38028)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kc48l-0007WV-4d
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 05:11:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44442)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kc48h-0003aV-Aw
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 05:11:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604916664;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=wy+FDgICcpBiQrVX90qd/LCc/kcsv0Xj8kNT1laRa0E=;
 b=jGtCaftBMHeqsodxrxiwoaDSB2TobEy7SK9QLJcOYFa3UM6XqI8MobwHTlDfFQAqhPAwNU
 TQqnFE0cGf2HNWXqn6QiPdv1pqQ13yizp8QoV78d/sP6+rUj44+GxMYGYlHcHe7ApDyhex
 u+zVejb5ZtydVHE2uGgAsIziQqWHL7o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-342-GF3eqN4INNSXAxI8R1ErYg-1; Mon, 09 Nov 2020 05:11:03 -0500
X-MC-Unique: GF3eqN4INNSXAxI8R1ErYg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CF97A1009E20;
 Mon,  9 Nov 2020 10:11:01 +0000 (UTC)
Received: from redhat.com (ovpn-114-194.ams2.redhat.com [10.36.114.194])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 71FCB50B44;
 Mon,  9 Nov 2020 10:10:59 +0000 (UTC)
Date: Mon, 9 Nov 2020 10:10:56 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: Migrating to the gitlab issue tracker
Message-ID: <20201109101056.GC684242@redhat.com>
References: <20201030092324.GC99222@redhat.com>
 <CAFEAcA_8PKkfeninOXCzPdtY7WVHnC7Pkon758zXe7h9MzS+aw@mail.gmail.com>
 <20201030101013.GG99222@redhat.com>
 <CAFEAcA9crYaa8-guWkYFDYgEi8=gH3xaXraD7iWZMHM6vryAtw@mail.gmail.com>
 <c75f91b7-6972-9e48-efa9-49792fc011d2@redhat.com>
 <37a00b98-428b-d1ca-79c2-7846ccfda651@redhat.com>
 <de1d3c49-967b-bc96-220f-3deabc441dfa@redhat.com>
 <20201105155006.GP630142@redhat.com>
 <72985bcf-668d-7472-192f-502963d2b6ad@redhat.com>
 <CAFEAcA_dT_RQ8Pmk_S=zCSu1tUbptuP0+rtrsS55tEg+XD=S2Q@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_dT_RQ8Pmk_S=zCSu1tUbptuP0+rtrsS55tEg+XD=S2Q@mail.gmail.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 01:25:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Thomas Huth <thuth@redhat.com>, John Snow <jsnow@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alistair Francis <alistair23@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Nov 08, 2020 at 11:58:28AM +0000, Peter Maydell wrote:
> On Sun, 8 Nov 2020 at 09:01, Thomas Huth <thuth@redhat.com> wrote:
> > I agree with Daniel. Please let's not clog the new bug tracker right from
> > the start with hundreds of bugs - that only makes it harder to focus on the
> > tickets that are really important. Let's use the migration instead to start
> > as clean as possible again.
> 
> I really don't like doing this kind of thing. It basically
> tells bug reporters "we don't care about your reports".
> We ought to at least triage them. Certainly for arm a
> lot of the reports in LP are real bug reports which we
> shouldn't just drop on the floor.

Mostly it is just a reflection of the reality we find ourselves in where
we have more bug reports than we have willing maintainer time to investigate
and resolve. Regardless of whether the bug are open or closed, there are a
large number we clearly don't consider important, otherwise someone would
have already looked at them.

This isn't a comment on whether the bugs are valid or not, just on whether
the bugs look important/critical enough to be worth spending time on, and
unfortunately most come up short.

If we accept this, then I think bulk closing old bugs is a good solution.
It makes it clear to users sooner than the problem they face is unlikely
to be ever resolved, and so they can stop waiting in vain for something
that will never happen and focus on working around the problem they hit.

We will certainly close many valid bugs in doing this. Some of those may
in fact turn out to be things we will fix, or want to fix but that's OK.
We can still fix them even if the bug is closed. Or if we notice a bug
being closed that's important, we can re-open it.

IMHO on balance it is still better if we blindly auto-close the 261
expired bugs in Thomas' dashboard, and then manually re-open perhaps
15-20 that might have been valid, than to manually triage all 261 bugs.

This will leave more time to spend on the masses of other non-stale bugs
which are more likely to be useful to our current users.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


