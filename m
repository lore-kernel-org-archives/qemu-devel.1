Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C626C432C3
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 12:15:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08DF92075C
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 12:15:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YepJIJT/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08DF92075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZZkR-0000og-5M
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 07:15:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50016)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iZZjm-0000OR-BR
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 07:14:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iZZjj-0003SY-9D
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 07:14:32 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:25290
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iZZjj-0003Rs-4w
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 07:14:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574770470;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ODQRmH4e73gCnb22Krm046OZAnrWsWskyeHmXfsBuJo=;
 b=YepJIJT/gF6VujYWV40kG7Nr3/KIU8oyyeP/wzWfOVBmGdWaOVqMH9mHhw/+eETB8fvvAi
 JSccOC3geiPhmDuR/MwSLBVLVY4etyC1P7jaUshhJcqCaDEEXnlap5bTRJInEaheFWY0NC
 Zyq/dJs5frcz0OuWkfPRBtrRGHAWQZI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-P9HrIDpQPPSXzoP6-_u1-g-1; Tue, 26 Nov 2019 07:14:26 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D642B1005516
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2019 12:14:25 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.59])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3932A60BEC;
 Tue, 26 Nov 2019 12:14:19 +0000 (UTC)
Date: Tue, 26 Nov 2019 12:14:16 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: virtiofsd: Where should it live?
Message-ID: <20191126121416.GE2928@work-vm>
References: <20191125185021.GB3767@work-vm>
 <20191126102600.GG556568@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191126102600.GG556568@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: P9HrIDpQPPSXzoP6-_u1-g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: mszeredi@redhat.com, marcandre.lureau@redhat.com, qemu-devel@nongnu.org,
 stefanha@redhat.com, vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Daniel P. Berrang=E9 (berrange@redhat.com) wrote:
> On Mon, Nov 25, 2019 at 06:50:21PM +0000, Dr. David Alan Gilbert wrote:
> > Hi,
> >   There's been quite a bit of discussion about where virtiofsd, our
> > implemenation of a virtiofs daemon, should live.  I'd like to get
> > this settled now, because I'd like to tidy it up for the next
> > qemu cycle.
> >=20
> > For reference it's based on qemu's livhost-user+chunks of libfuse.
> > It can't live in libfuse because we change enough of the library
> > to break their ABI.  It's C, and we've got ~100 patches - which
> > we can split into about 3 chunks.
> >=20
> > Some suggestions so far:
> >   a) In contrib
> >      This is my current working assumption; the main objection is it's
> >      a bit big and pulls in a chunk of libfuse.
>=20
> My main objection to 'contrib/' is actually the perceived notions
> about what the contrib directory is for. When I see 'contrib/'
> code in either QEMU, or other open source projects, my general
> impression is that this is largely unsupported code which is just
> there as it might be interesting to someone, and doesn't typically
> get much ongoing dev attention.
>=20
> Parts that are fully supported & actively developed by projects
> usually live elsewhere like a src/ or lib/ or tools/ directory.
>=20
> This has kind of been the case with QEMU historically, with
> the vhost-user-blk, vhost-user-scsi not being real production
> quality implementations. Rather they are just technology demos
> to show what you might do.   vhost-user-gpu/input blurred this
> boundary a bit as they're more supported tools, and so I'd
> argue contrib/ probably wasn't the right place for them either
> in hindsight.
>=20
> virtiofsd is definitely different as it is intended to be a
> fully production quality supported tool with active dev into
> the future IIUC.
>=20
> IOW, if we did decide we want it in QEMU, then instead of
> '$GIT/contrib/virtiofsd', I'd prefer to see '$GIT/virtiofsd'.

I'm not sure it deserves a new top level for such a specific tool.

> >   b) In a submodule
> >=20
> >   c) Just separate
> >=20
> > Your suggestions/ideas please.  My preference is (a).
>=20
> What I'm wondering is just how much sharing / overlap of code and concept=
s
> and community operation there is going otbetween QEMU and virtiofsd. From
> the tech POV, IIUC, the main blocker it would need to be in QEMU is becau=
se
> it links to libvhost-user and we've not declared that to be a stable API
> for 3rd party linking.
>=20
> Personally I'm always biased towards self-contained apps being in their
> own repositories, rather than bundling too much stuff into one repo. You
> can see that in the way we've created independant git repos for any libvi=
rt
> module that didn't need to be part of the main libvirt.git.
>=20
> To me the key benefit this gives is flexibility in approach. ie the app
> doesn't need to blindly follow every precedent that QEMU has set. It
> can instead take the most appropriate path for its needs. For example...
>=20
> It could use meson for its build system already. This would be good as
> builds will be done in a matter of seconds. For contributors it would
> be a much less daunting project to join as it wouldn't be lost in the
> firehose of other non-virtiofsd contributions on qemu-devel.
>=20
> It doesn't have to follow QEMU's 3-times a year release model, with 6
> week long freeze periods. It can be more agile releasing 6 times a year
> with 1 week freezes if desired, I personally think tihs would be quite
> desirable for a young project like virtiofsd which is evolving rapidly
> as it would get new work available to users much more rapidly.

Form virtiofsd's point of view I'm not that worried about the release
cycle;  Given that features have to go through virtio standardisation,
the release ycle is unlikely to be a bottleneck.

> It doesn't have to follow QEMU's API stability & deprecation policies.
> It could be more flexible in taking non-compatible changes, which again
> may be valuable for a young rapidly evolving app.
>=20
>=20
>=20
> Anyway to be clear, I'm not a contributor to virtiofsd, nor likely to
> be one in the future, so just consider this a personal POV. From QEMU's
> POV I don't think it'll matter whether virtiofsd in or out of QEMU git.
> It is more about the impact & burden QEMU's dev process & standards might
> impose on virtiofsd itself.

As a qemu contributor, your opinion is welcome!  No need to sit on the
fence.

> I'm fine with whatever option above is chosen, with the only caveat
> being that if its in qemu.git, I don't think it belongs under contrib/
> it should be a top level dir of its own.
>=20

Dave

> Regards,
> Daniel
> --=20
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


