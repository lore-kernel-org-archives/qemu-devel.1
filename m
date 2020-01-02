Return-Path: <SRS0=Q/S9=2X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E58C2D0DC
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 15:06:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABC8C2072C
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 15:06:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YN0+R3pW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABC8C2072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1in23G-0001o0-Ph
	for qemu-devel@archiver.kernel.org; Thu, 02 Jan 2020 10:06:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45506)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1in22S-0001It-IS
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 10:05:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1in22P-0004aw-AZ
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 10:05:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26577
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1in22P-0004ad-6C
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 10:05:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577977524;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2SnbmVEEWXucxVrFPi4M/ATQ0/plF6s4BvW4GbJlxSs=;
 b=YN0+R3pWVTgInpC/eI4TOkwdI1gdNZKlOeco+AEOqzG6UgefT6c4G1NYhk+1QvwZQAI/pz
 YtH2Tc3iC84P824gU4IHUT9Ccd76X5kM/x9BOaseEw40LEkhBce7Pu5ZciTHXg3n1oT/rR
 sWlsuQly2uFspSCVjyZiZG0LtI9JsNI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-139-fxk7Z4Z5NUuNnlTCSpNt_g-1; Thu, 02 Jan 2020 10:05:18 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0BBD0803084;
 Thu,  2 Jan 2020 15:05:17 +0000 (UTC)
Received: from work-vm (ovpn-117-17.ams2.redhat.com [10.36.117.17])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3B0185D9C9;
 Thu,  2 Jan 2020 15:05:04 +0000 (UTC)
Date: Thu, 2 Jan 2020 15:05:01 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: Making QEMU easier for management tools and applications
Message-ID: <20200102150501.GA2973@work-vm>
References: <CAJSP0QUk=4co-nqk8fv2n-T2_W40rE3r_5OMoxD7otAV993mCA@mail.gmail.com>
 <87h81unja8.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <87h81unja8.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: fxk7Z4Z5NUuNnlTCSpNt_g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, Cleber Rosa <cleber@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Dominik Csapak <d.csapak@proxmox.com>,
 John Snow <jsnow@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Markus Armbruster (armbru@redhat.com) wrote:
> Stefan Hajnoczi <stefanha@gmail.com> writes:
> > 4. Go and Rust bindings would also be useful.  There is
> > https://github.com/intel/govmm but I think it makes sense to keep it
> > in qemu.git and provide an interface similar to our Python modules.
>=20
> Mapping QAPI/QMP commands and events to function signatures isn't hard
> (the QAPI code generator does).  Two problems (at least):
>=20
> 1. Leads to some pretty ridiculous functions.  Here's one:
>=20
>     void qmp_blockdev_mirror(bool has_job_id, const char *job_id,
>                              const char *device,
>                              const char *target,
>                              bool has_replaces, const char *replaces,
>                              MirrorSyncMode sync,
>                              bool has_speed, int64_t speed,
>                              bool has_granularity, uint32_t granularity,
>                              bool has_buf_size, int64_t buf_size,
>                              bool has_on_source_error,
>                              BlockdevOnError on_source_error,
>                              bool has_on_target_error, BlockdevOnError on=
_target_error,
>                              bool has_filter_node_name, const char *filte=
r_node_name,
>                              bool has_copy_mode, MirrorCopyMode copy_mode=
,=20
>                              bool has_auto_finalize, bool auto_finalize,
>                              bool has_auto_dismiss, bool auto_dismiss,
>                              Error **errp);

Those might not be as bad when mapped to other languages, all the
bool/value pairs would become Option<...>  so that removes that doubling.
The Error ** mechanism should somehow map onto functions returning a
normal Rust Result<> type.

Dave

>   We commonly use 'boxed': true for such beasts, which results in
>   functions like this one:
>=20
>     void qmp_blockdev_add(BlockdevOptions *arg, Error **errp);
>=20
> 2. Many schema changes that are nicely backward compatible in QMP are
>    anything but in such an "obvious" C API.  Adding optional arguments,
>    for instance, or changing integer type width.  The former is less of
>    an issue with 'boxed': true.
>=20
> Perhaps less of an issue with dynamic languages.
>=20
> I figure a static language would need much more expressive oomph than C
> to be a good target.  No idea how well Go or Rust bindings can work.
>=20
> > 5. A jailer is needed to isolate the QEMU process and vhost-user
> > device backends using seccomp, Linux namespaces, and maybe
> > SELinux/AppArmor.  We used to be able to rely on libvirt for QEMU
> > security, but it's becoming a common task for any device backend and
> > IMO should be its own launcher tool.
>=20
> Perhaps the libvirt refactoring effort can give us one.
>=20
> > 6. A configuration file format is sorely needed so that guest
> > configuration can be persisted and easily launched.  Today you have to
> > create a shell script that executes a QEMU command-line, but this is
> > suboptimal because sharing executable scripts is dangerous from a
> > security perspective and is hard to parse or modify programmatically.
>=20
> No argument.  There is -readconfig, but it falls way short.
>=20
> With command line QAPIfication, a real configuration file will be quite
> feasible.
>=20
> The main reason for the lack of progress there is our dedication to
> backward compatibility.  A functional replacement of our CLI is a huge
> task already.  Throwing in backward compatibility makes it a daunting
> one.  Not least because nobody fully understands all the quirks.
>=20
> > In many of these areas we already have a partial solution.  It just
> > needs more work.  I think it would be worth the effort and the mental
> > shift to really providing APIs that are easy to use by applications.
> >
> > What do you think?
> >
> > Have I missed things that are needed?
> >
> > Have I included things that are unnecessary?
>=20
> I feel we need to make up our minds what kind of interface(s) we want to
> provide.
>=20
> We provide a low-level interface for management applications.  I feel we
> need to nail this one.  Its QMP part is okay, I think, the CLI part is
> not.
>=20
> We also try to provide friendlier interfaces for human users.  Not only
> do we suck at it, we're also prone to create liabilities for later: much
> of the compatibility woes that have been holding us back are rooted in
> "convenience" features.  And don't get me started on the folly of us
> dabbling in GUI.
>=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


