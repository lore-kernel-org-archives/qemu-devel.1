Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 831ABC3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 15:11:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C51322CED
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 15:11:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C51322CED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2zbJ-0003w3-CC
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 11:11:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38673)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1i2zaS-0003QJ-Lb
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 11:10:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1i2zaM-0000MG-HG
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 11:10:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34098)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1i2zaM-0000Jp-90
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 11:10:10 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EC9493084037;
 Wed, 28 Aug 2019 15:10:08 +0000 (UTC)
Received: from redhat.com (unknown [10.42.17.64])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2CC124388;
 Wed, 28 Aug 2019 15:10:08 +0000 (UTC)
Date: Wed, 28 Aug 2019 16:10:05 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Message-ID: <20190828151005.GL2991@redhat.com>
References: <20190823163931.7442-1-berrange@redhat.com>
 <20190823163931.7442-3-berrange@redhat.com>
 <3345a7e9-c0de-78d8-4656-0255fa1e34fd@redhat.com>
 <87a7bt5nyr.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87a7bt5nyr.fsf@linaro.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Wed, 28 Aug 2019 15:10:08 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 2/4] docs: merge HACKING.md contents into
 CODING_STYLE.md
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Aug 28, 2019 at 04:06:20PM +0100, Alex Benn=C3=A9e wrote:
>=20
> Eric Blake <eblake@redhat.com> writes:
>=20
> > On 8/23/19 11:39 AM, Daniel P. Berrang=C3=A9 wrote:
> >> The split of information between the two docs is rather arbitary and
> >> unclear. It is simpler for contributors if all the information is in
> >> one file.
> >>
> >> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> >> ---
> >>  CODING_STYLE.md | 262 +++++++++++++++++++++++++++++++++++++++++++++=
++
> >>  HACKING.md      | 263 ---------------------------------------------=
---
> >>  README          |   2 +-
> >>  3 files changed, 263 insertions(+), 264 deletions(-)
> >>  delete mode 100644 HACKING.md
> >
> > Is it worth trying to group related sections as part of the combinati=
on?
> >  (Your solution of just concatenating at the end is obviously the
> > fastest, but may result in odd ordering where similar things are
> > mentioned twice but in different parts of the file).
>=20
> It is a bit all over the place, but just moving trace-events and
> automatic memory de-allocation we could group it like this:
>=20
> Formatting and style:
>=20
>   * [Whitespace](#whitespace)
>     + [Multiline Indent](#multiline-indent)
>   * [Line width](#line-width)
>   * [Naming](#naming)
>   * [Block structure](#block-structure)
>   * [Declarations](#declarations)
>   * [Conditional statements](#conditional-statements)
>   * [Comment style](#comment-style)
>=20
> Language usage:
>=20
>   * [Preprocessor](#preprocessor)
>     + [Variadic macros](#variadic-macros)
>     + [Include directives](#include-directives)
>   * [C types](#c-types)
>     + [Scalars](#scalars)
>     + [Pointers](#pointers)
>     + [Typedefs](#typedefs)
>     + [Reserved namespaces in C and POSIX](#reserved-namespaces-in-c-an=
d-posix)
>   * [Low level memory management](#low-level-memory-management)
>   * [String manipulation](#string-manipulation)
>   * [Printf-style functions](#printf-style-functions)
>   * [C standard, implementation defined and undefined
>     behaviors](#c-standard--implementation-defined-and-undefined-behavi=
ors)
>   * [Automatic memory deallocation](#automatic-memory-deallocation)
>=20
> QEMU Specific Idioms
>=20
>   * [trace-events style](#trace-events-style)
>     + [0x prefix](#0x-prefix)
>     + ['#' printf flag](#----printf-flag)
>   * [Error handling and reporting](#error-handling-and-reporting)
>     + [Reporting errors to the human user](#reporting-errors-to-the-hum=
an-user)
>     + [Propagating errors](#propagating-errors)
>     + [Handling errors](#handling-errors)


Sure, I'm fine doing this.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

