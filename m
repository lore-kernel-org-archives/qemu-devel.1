Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D98CA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 16:47:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D42AF2086D
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 16:47:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U/pUrc/q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D42AF2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMapw-0005RG-1L
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 12:47:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39920)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iMapF-00051y-Fb
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 12:46:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iMapD-0006tX-Bh
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 12:46:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46473
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1iMapC-0006sH-Tw
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 12:46:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571676389;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jxcAVeDjK8RGEMGztLDfjGqv6UpWVgUd96+0FlM46eI=;
 b=U/pUrc/qt8rFc7Hg8yGB3u5wT88o9OCLoj/GPhnmSJT83xC0+2AVkp+toa8nMYELg3fdh5
 P5JDUhYuYP1qKD6UhCjygGL+jROkfPtqu4v9/zJT/xTR+0FiDVyJBpA3AdIDbFbu9C58Ep
 OdzB+N8MqtHvKW7mABbWltkbeZUss5Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-TJW1OtLhPQusismJ4p6gUw-1; Mon, 21 Oct 2019 12:46:18 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4D58B476;
 Mon, 21 Oct 2019 16:46:17 +0000 (UTC)
Received: from redhat.com (unknown [10.42.16.231])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 658E019C58;
 Mon, 21 Oct 2019 16:46:13 +0000 (UTC)
Date: Mon, 21 Oct 2019 17:46:11 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] tcg/LICENSE: Remove no-longer-true statement that TCG is
 BSD-licensed
Message-ID: <20191021164611.GT4336@redhat.com>
References: <20191021145839.12684-1-peter.maydell@linaro.org>
 <CAFEAcA_PO7vaxGVpfW2bqRvB9XtDA8uk_6Tw7SauwrbHfJOjxw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_PO7vaxGVpfW2bqRvB9XtDA8uk_6Tw7SauwrbHfJOjxw@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: TJW1OtLhPQusismJ4p6gUw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Claudio Fontana <claudio.fontana@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Oct 21, 2019 at 05:36:49PM +0100, Peter Maydell wrote:
> On Mon, 21 Oct 2019 at 15:58, Peter Maydell <peter.maydell@linaro.org> wr=
ote:
> > Since 2008 the tcg/LICENSE file has not changed: it claims that
> > everything under tcg/ is BSD-licensed.
> >
> > This is not true and hasn't been true for years: in 2013 we
> > accepted the tcg/aarch64 target code under a GPLv2-or-later
> > license statement. We don't really consider the tcg
> > subdirectory to be a distinct part of QEMU anyway.
>=20
> This commit message misses the other not-BSD bits of code in tcg/:
> tcg/tci.c is GPL-2-or-later
> tcg/tcg-gvec-desc.h, tcg/tcg-op-gvec.[ch], tcg-op-vec.c are LGPL2.1-or-la=
ter
>=20
> Horse has clearly bolted further from the stable than
> I had first thought.

No matter what text we put in the top LICENSE file is always going to be
rather vague because of the many different licenses scattered across the
codebase.

We really ought to make an effort to add SPDX tags to every file in the
source tree & have checkpatch.pl enforce that all new files come with
SPDX tags too. Identifying licenses for code then becomes a trivial grep.

NB, I'm only suggesting add SPDX /in addition/ to the current license
boilerplate, as removing existing boilerplate license text from a file
can only be done by agreement with the copyright holder(s).

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


