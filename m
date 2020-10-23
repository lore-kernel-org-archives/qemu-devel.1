Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 382EFC388F9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 11:57:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82E9420EDD
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 11:57:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YL1sK+tE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82E9420EDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVvhV-00026r-Hn
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 07:57:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59548)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kVvgD-0008Tz-Gk
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 07:56:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31297)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kVvg9-00063O-06
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 07:56:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603454175;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PValZSJz+pbvAsu76RCcHzI8lNJb3EnQ/4TlaO2/WAo=;
 b=YL1sK+tEtUu5l6aGadQoe/LwMGh9AOYDU9n7aXYjO4hB2kK1VAIQ99wHTuLhSz1KCTlzsP
 /F71iMrZyXRpMha7cfggR3puMpohZNkxBRrH5+SboUPZGwADtVktf5wGPLm0liGoAhyz39
 LQp18l83au/5EfdxGLQIAUTpHjLF2bs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-70-3J7WhlJROnyb1h9H6PxuMw-1; Fri, 23 Oct 2020 07:56:12 -0400
X-MC-Unique: 3J7WhlJROnyb1h9H6PxuMw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C56A41007465;
 Fri, 23 Oct 2020 11:56:11 +0000 (UTC)
Received: from merkur.fritz.box (ovpn-113-206.ams2.redhat.com [10.36.113.206])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 01EE55D9CC;
 Fri, 23 Oct 2020 11:56:06 +0000 (UTC)
Date: Fri, 23 Oct 2020 13:56:05 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH 0/6] qemu-storage-daemon: QAPIfy --chardev
Message-ID: <20201023115605.GB4793@merkur.fritz.box>
References: <20201023101222.250147-1-kwolf@redhat.com>
 <20201023103603.GG445638@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201023103603.GG445638@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 02:46:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: marcandre.lureau@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 23.10.2020 um 12:36 hat Daniel P. Berrangé geschrieben:
> On Fri, Oct 23, 2020 at 12:12:16PM +0200, Kevin Wolf wrote:
> > While the qemu-storage-daemon command line is still considered unstable,
> > let's change --chardev from the old QemuOpts-based parser to QAPI, so
> > that it becomes a simple mapping of chardev-add to the command line and
> > will fit in a future fully QAPIfied command line without later
> > incompatible changes or additional compatibility glue.
> 
> NB, I am *not* objecting to this series in what I'm about to write,
> but I want to point out that I don't think we should assume that
> this proposed QAPIified CLI is neccessarily the long term end point.
> Below I outline potential incompatible changes that would end up
> turning -chardev into legacy / deprecated syntax.

Well, when do we have an end point for anything anyway? Things will
always evolve.

> The chardev QAPI-ification is a good example of the gap between QOM
> and QAPI.
> 
> The chardev backends are QOM classes, but they lack the "user
> creatable" interface.

They aren't really proper QOM classes at this point. Technically they
are, but they are pretty boring QOM classes that don't have any
properties. Instead, they use ChardevBackend QAPI objects in the custom
ChardevClass.open method.

So they are in some weird in-between state.

> IOW, if we're considering our ideal long term configuration goals
> for QEMU, then I think we should be looking at a solution to bridge
> the gap, so that we can get the best of both worlds, and have a single
> way todo things.
> 
> IMHO, ideally none of -netdev, -chardev, -device, etc would exist
> in any "modern" CLI, they would just be considered legacy syntax.
> Essentially everything would be created using the same -object arg
> and object_add  commands.

I think we need to distinguish legacy options and convenience options
(and this applies much more broadly than just here, and it's probably
more important in other places).

Even if we eventually make -object capable of configuring chardev and
netdev backends, -chardev could still be more convenient to use for a
human user.

This equation of "legacy" and "convenience" is also on of the problems I
have with the suggestion of having two binaries for "legacy" and
"modern" interfaces. Humans are not legacy, and having a command line
that is unfriendly for human users doesn't make it modern.

We have a lot of legacy stuff in the command line, and the goal for it
is to get rid of it and replace it with something modern (the goal is
_not_ keeping it around for human users because compatibility with this
legacy stuff often blocks us from moving forward).

But convenience options for human users aren't bad at all, as long as
they are based on a modern model of how things work. We'll always want
to have some.

Sorry for going on a tangent... Back to chardev: In the end, the
preferred command line interface doesn't matter that much. The required
structure will be the same.

> What I think this means is that we need to use QAPI to represent
> the properties of an object, and auto-generate the QOM code to
> register properties, provider setters/getters, constructors, etc.

Yes, I agree with this one.

I expect we'll discuss this more when I send the first step for
object-add (which is QMP, so for everything, not just
qemu-storage-daemon), which will duplicate the QOM properties in the
QAPI schema for user creatable objects. Generating QOM code from the
schema should be the next step then.

> For existing user creatable objects this would largely involve
> deleting lots of existing code and defining some simple QAPI
> schemas. This is probably quite easy, if tedious.
> 
> For the chardev/netdev/etc objects we already have the QAPI schema,
> but would need to add code genration parts to turn them into full
> user creatable object classes. This is likely harder more involved
> work, especially to keep backcompat working well.

The challenging part is probably not keeping compatibility (there's no
reason to break it if it represents everything well), but that these are
union types in the QAPI schema that map to different QOM classes.

It's not entirely obvious to me yet how we would deal with this, but the
good thing is that this is all about internal interfaces which we can
change relatively freely.

Kevin


