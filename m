Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C16CC74A54
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 13:57:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14A5720872
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 13:57:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14A5720872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlZZe-0001Rd-Cw
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 09:57:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51989)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <berrange@redhat.com>) id 1hlZYq-0000Zm-98
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 09:56:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1hlZYn-0006ro-V5
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 09:56:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56648)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>)
 id 1hlZYl-0006np-3d; Thu, 11 Jul 2019 09:56:31 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 09DFE85550;
 Thu, 11 Jul 2019 13:56:30 +0000 (UTC)
Received: from redhat.com (unknown [10.42.17.95])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1AA7860633;
 Thu, 11 Jul 2019 13:56:26 +0000 (UTC)
Date: Thu, 11 Jul 2019 14:56:24 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eric Blake <eblake@redhat.com>
Message-ID: <20190711135624.GN11930@redhat.com>
References: <20190710170349.1548-1-mlevitsk@redhat.com>
 <84232589-627a-8151-a3d5-84c053d9a257@redhat.com>
 <3e82ff24-6f84-9de8-d3ab-c34966f875f0@redhat.com>
 <096a8bcf57997c594e1d5d7ea9606029909b81fc.camel@redhat.com>
 <1bdb9136-ae97-7bf3-762e-0774b0980160@redhat.com>
 <45b56973-cc6c-2968-e758-7e10734b75bf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <45b56973-cc6c-2968-e758-7e10734b75bf@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Thu, 11 Jul 2019 13:56:30 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] LUKS: support preallocation in qemu-img
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
Cc: Kevin Wolf <kwolf@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 11, 2019 at 08:50:56AM -0500, Eric Blake wrote:
> On 7/11/19 7:24 AM, Max Reitz wrote:
>=20
> >>> So it isn=E2=80=99t just me who expects these to pre-initialize the=
 image to 0.
> >>>  Hm, although...  I suppose @falloc technically does not specify wh=
ether
> >>> the data reads as zeroes.  I kind of find it to be implied, but, we=
ll...
> >>
> >> I personally don't really think that zeros are important, but rather=
 the level of allocation.
> >> posix_fallocate probably won't write the data blocks but rather only=
 the inode metadata / used block bitmap/etc.
> >>
> >> On the other hand writing zeros (or anything else) will force the bl=
ock layer to actually write to the underlying
> >> storage which could trigger lower layer allocation if the underlying=
 storage is thin-provisioned.
> >>
> >> In fact IMHO, instead of writing zeros, it would be better to write =
random garbage instead (or have that as an even 'fuller'
> >> preallocation mode), since underlying storage might 'compress' the z=
eros.=20
> >=20
> > Which is actually an argument why you should just write zeroes on the
> > LUKS layer, because this will then turn into quasi-random data on the
> > protocol layer.
>=20
> We want preallocation to be fast (insofar as possible). Writing zeroes
> in LUKS is not fast, because it forces random data on the protocol
> layer; while writing zeroes on the protocol layer can be fast, even if
> it reads back as random on the LUKS layer. If you WANT to guarantee
> reading zeroes, that's image scrubbing, not preallocation.  I think thi=
s
> patch is taking the right approach, of letting the underlying layer
> allocate data efficiently (but the burden is then on the underlying
> layer to actually allocate data, and not optimize by compressing zeroes
> into non-allocated storage).

On the topic of scrubbing, it would actually be nice to have a
"secure delete" for QEMU block driver formats that can do some
level of scrubbing in software and/or calling out to hardware support.

Similarly to prealloc a choice of 'metadata' or 'full'. Wwith LUKS
you can do well by just scrubbing the image header (which kills the
master decryption key rendering payload useless).

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

