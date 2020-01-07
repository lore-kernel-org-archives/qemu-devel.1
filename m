Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC1FC33C99
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 10:48:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D921E2077B
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 10:48:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U1Ala2Lm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D921E2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iomPj-0008KW-HC
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 05:48:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44345)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iolIV-0005ib-BC
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 04:37:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iolIT-0000HZ-LZ
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 04:37:11 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:28265
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iolIT-0000H3-HC
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 04:37:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578389828;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=41nvUBr59e3WRVw0HYn1zrcTgkUkat8OUGwKC9dTltk=;
 b=U1Ala2LmVohwvle8LbZ/41ph+LPqy5yfybClF0r+vN1GTgfzrxWfPh5lFNVg0mn6/SSwrg
 bSfbkWKqsJANW22UpNExF6we7ZmqFYTb6u8wkIOio/5qYDxOhq9Od5Sul6w8yZRc/iW1hL
 6QhjgHZRx0htwOjfj3OpZSa9BWK8pNw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-9p4IlR6MN6yqTjcpkfJyeQ-1; Tue, 07 Jan 2020 04:37:07 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 49DD4800D41;
 Tue,  7 Jan 2020 09:37:06 +0000 (UTC)
Received: from linux.fritz.box (ovpn-116-78.ams2.redhat.com [10.36.116.78])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 68F2E272A1;
 Tue,  7 Jan 2020 09:36:56 +0000 (UTC)
Date: Tue, 7 Jan 2020 10:36:55 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Michal =?iso-8859-1?B?UHLtdm96bu1r?= <mprivozn@redhat.com>
Subject: Re: Making QEMU easier for management tools and applications
Message-ID: <20200107093655.GF4076@linux.fritz.box>
References: <CAJSP0QUk=4co-nqk8fv2n-T2_W40rE3r_5OMoxD7otAV993mCA@mail.gmail.com>
 <87h81unja8.fsf@dusky.pond.sub.org>
 <c445ecbe-1559-462a-31c2-f44f60e60a8b@redhat.com>
MIME-Version: 1.0
In-Reply-To: <c445ecbe-1559-462a-31c2-f44f60e60a8b@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 9p4IlR6MN6yqTjcpkfJyeQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, Cleber Rosa <cleber@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Dominik Csapak <d.csapak@proxmox.com>,
 John Snow <jsnow@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 23.12.2019 um 16:04 hat Michal Pr=EDvozn=EDk geschrieben:
> On 12/21/19 10:02 AM, Markus Armbruster wrote:
> > Stefan Hajnoczi <stefanha@gmail.com> writes:
> >=20
>=20
>=20
> >> 4. Go and Rust bindings would also be useful.  There is
> >> https://github.com/intel/govmm but I think it makes sense to keep it
> >> in qemu.git and provide an interface similar to our Python modules.
> >=20
> > Mapping QAPI/QMP commands and events to function signatures isn't hard
> > (the QAPI code generator does).  Two problems (at least):
> >=20
> > 1. Leads to some pretty ridiculous functions.  Here's one:
> >=20
> >     void qmp_blockdev_mirror(bool has_job_id, const char *job_id,
> >                              const char *device,
> >                              const char *target,
> >                              bool has_replaces, const char *replaces,
> >                              MirrorSyncMode sync,
> >                              bool has_speed, int64_t speed,
> >                              bool has_granularity, uint32_t granularity=
,
> >                              bool has_buf_size, int64_t buf_size,
> >                              bool has_on_source_error,
> >                              BlockdevOnError on_source_error,
> >                              bool has_on_target_error, BlockdevOnError =
on_target_error,
> >                              bool has_filter_node_name, const char *fil=
ter_node_name,
> >                              bool has_copy_mode, MirrorCopyMode copy_mo=
de,=20
> >                              bool has_auto_finalize, bool auto_finalize=
,
> >                              bool has_auto_dismiss, bool auto_dismiss,
> >                              Error **errp);
> >=20
> >   We commonly use 'boxed': true for such beasts, which results in
> >   functions like this one:
> >=20
> >     void qmp_blockdev_add(BlockdevOptions *arg, Error **errp);
> >=20
> > 2. Many schema changes that are nicely backward compatible in QMP are
> >    anything but in such an "obvious" C API.  Adding optional arguments,
> >    for instance, or changing integer type width.  The former is less of
> >    an issue with 'boxed': true.
> >=20
> > Perhaps less of an issue with dynamic languages.
> >=20
> > I figure a static language would need much more expressive oomph than C
> > to be a good target.  No idea how well Go or Rust bindings can work.
>=20
> This is something that bothered me for a while now. Even though it's not
> as bad as it used to be because we are not adding so much wrappers for
> monitor commands as we used to. I mean, in libvirt the wrapper for a
> monitor command has to be written by hand. Worse, whenever I'm adding a
> wrapper I look at the QMP schema of it and let my muscle memory write
> the wrapper.
>=20
> However, it's not only what Markus already mentioned. Even if we
> generated wrappers by a script, we need to be able to generate wrappers
> for every single supported version of qemu.
>=20
> For instance, if qemu version X has a command that accepts some set of
> arguments and this set changes in version X+1 then libvirt needs both
> wrappers and decides at runtime (depending on what version it is talking
> to) what wrapper to use.
>=20
> Unfortunately, I don't see any easy way out.

The easy way out would be tying libvirt to a specific QEMU version. And
I'm only half joking.

If libvirt didn't exist yet and we needed a management library for QEMU,
what we would build now would probably not look much like libvirt looks
today. We wouldn't try to have basic support for every hypervisor out
there, but integrate it much closer with QEMU and avoid much of the
backwards compatibility requirements that the interface between QEMU and
libvirt has (which requires us to deal with compatibility twice for
everything).

Maybe it would even be part of the QEMU repository, allowing a single
patch series to implement a new feature in the system emulator and
expose it in the API immediately instead of waiting for the next QEMU
release before libvirt can even think about implementing support for it.

So should libvirt move in that direction? Do people actually still make
much use of its multi-hypervisor nature, or would it make sense to split
it into separate libraries for each hypervisor that can be much tighter
integrated with (a specific version of) the respective hypervisor?

Kevin


