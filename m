Return-Path: <SRS0=g5aJ=2O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC35C2D0CF
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2019 13:42:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37632206B7
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2019 13:42:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DhLH66xT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37632206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ijkST-0001tT-Co
	for qemu-devel@archiver.kernel.org; Tue, 24 Dec 2019 08:42:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43989)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1ijkRr-0001ST-Up
 for qemu-devel@nongnu.org; Tue, 24 Dec 2019 08:42:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1ijkRn-0000TN-Ma
 for qemu-devel@nongnu.org; Tue, 24 Dec 2019 08:42:05 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:21410
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ijkRn-0000T5-7X
 for qemu-devel@nongnu.org; Tue, 24 Dec 2019 08:42:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577194922;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7aE3jR1fsQH/CecSz1MPb7kd6rUoZaXDF7V4A6iwsdM=;
 b=DhLH66xTy0gWl0SJuCDy99Qu+lB6HwlUo4PKUIVJ071+N2bFVLGiG6RIL3UNFYj2ho3/rL
 PrL91n7t4LlwxmiBb8ep6l3cgo0i7615G4+zx3R5dxgXMtP8IMAngYLnbqauY2UzKb83fL
 qH7MsKojNU7G+KjurLCQKKoS/x9Xkmo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-100-uI0ug7k2PGOVWEWJmG0AVw-1; Tue, 24 Dec 2019 08:41:55 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C183310054E3;
 Tue, 24 Dec 2019 13:41:53 +0000 (UTC)
Received: from redhat.com (ovpn-112-28.ams2.redhat.com [10.36.112.28])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9D6C86609E;
 Tue, 24 Dec 2019 13:41:42 +0000 (UTC)
Date: Tue, 24 Dec 2019 13:41:39 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: Making QEMU easier for management tools and applications
Message-ID: <20191224134139.GD2710539@redhat.com>
References: <CAJSP0QUk=4co-nqk8fv2n-T2_W40rE3r_5OMoxD7otAV993mCA@mail.gmail.com>
 <87h81unja8.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <87h81unja8.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: uI0ug7k2PGOVWEWJmG0AVw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 "Denis V. Lunev" <den@virtuozzo.com>, Cleber Rosa <cleber@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Dominik Csapak <d.csapak@proxmox.com>,
 John Snow <jsnow@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Dec 21, 2019 at 10:02:23AM +0100, Markus Armbruster wrote:
> Stefan Hajnoczi <stefanha@gmail.com> writes:
>=20
> > Hi,
> > QEMU presents a command-line interface and QMP monitor for
> > applications to interact with.  Applications actually need API
> > bindings in their programming language.  Bindings avoid reimplementing
> > code to spawn a QEMU process and interact with QMP.  QEMU is kind of
> > lazy and de facto relies on libvirt for API bindings.
> >
> > Is it time for better QEMU APIs?

> * scripts/qmp/qmp-shell
>=20
>   Half-hearted attempt at a human-friendly wrapper around the JSON
>   syntax.  I have no use for this myself.

I use this fairly often as its a useful debugging / experimentation
/ trouble shooting tool. There's similar ish functionality in
virsh qemu-monitor-command. I think there's scope of a supported
tool here that can talk to libvirt or a UNIX socket for doing
QMP commands, with a friendlier syntax & pretty printing.=20

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
>=20
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

In libvirt we've got this kind of problem already and have two different
approaches to tackling it.

For the really complex cases with lots of conceptual nesting, we would
end up using XML.

For the simpler case where its just a set of flat parameters, we have
something we call "virTypedParameters" which is effectively a poor man's
hash table where the keys are parameter names, and the values are a
union accepting different types.

In the Go APIs for libvirt though we end up mapping both those approaches
into Go structs. The key reason why we are able todo this in Go and not
C, is that we don't promise ABI compat in Go bindings. We'll extend the
structs at will, and some times a struct field gets turned into a nested
struct which is an API break too. With Go apps typically bundle all their
3rd party deps & often lock themselves to a specific release tag, so they
don't need ABI compat in the same way apps want at C level.

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

I think we need to re-think how we're attacking this problem, because
despite heroic efforts in developing QAPI & converting code it use it,
we've still not got the finish line in sight after 10 years.

As I mentioned in my other reply I think we should target the CLI as
something exclusively for humans, with convenient syntax and more
relaxed back compat requirements. ie don't guarantee perfect back
compat for the CLI - just modest effor to not gratuitously break it
without cause. Humans using the CLI can adapt if they hit obscure
quirks.

Our back compat pain with the quirks is because we have mgmt apps using
the CLI which can't tolerate semantic changes without warning. We can't
be more relaxed with CLI back compat without getting mgmt apps away
from using this CLI.  We can get mgmt apps off using the CLI until they
have an alternative they can use.

The hard part is that developing the QAPI alternative is that its impl
might accidentaly cause breakage in existing CLI before mgmt apps can
switch to the QAPI based approach.



I'm wondering if we need to think about a temporary *throwaway* fork of
QEMU. I wasn't involved in the work, but as an outside observer I think
it is interesting to see how the NEMU project fork ultimately led to QEMU
moving forward with a new KConfig approach, and the integration of microvm.
They had the freedom to develop these new approaches with zero regard
to back compat or broader QEMU needs that might otherwise hold back dev.
Once the forked impl was mostly done, "unknown problems" had largely become
"known problems", and the work could be integrated back into QEMU with
much less risk of disruption.


Could such a temporary fork approach help us solve the QAPI-ification
end goal ?  It doesn't have to be a separate project - it could be a
temporary qemu-qapi.git on qemu-project.org or github for experimentation,
but still under umbrealla of QEMU.

It would free us to implement an idealized 100% QAPI-ified config
approach in the shortest possible time, with zero regard to back
compat of the current CLI.

We could develop support for this in libvirt in parallel, letting
us test the combination to gain confidence in the result.

Essentially we'll be aiming to flush out all the "unknown problems"
that hold us back today. As we get confidence we'll be able to merge
it back into QEMU proper with much lower risk of introducing suprising
compat problems.

At some level you can consider each subsys maintainer's branch a fork,
but those branches are really focused on stable code that's ready to
merge. An NEMU like fork is more aggressive than that, as it provided
a focused place for *experimentation* with no regard for immediate
merge to GIT master. The cost of such a fork approach of course is
that of trying to keep up2date with development in QEMU git master.

The benefit of being able to cut the back-compat knot might still
make this a win, allowing completion of QAPI-ification in a faster
timeframe.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


