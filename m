Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36282C5DF64
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 10:37:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1CE220869
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 10:37:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DehgAZnL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1CE220869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSIhC-0001Gc-4w
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 05:37:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46285)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iSIgD-0000hh-FX
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 05:36:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iSIgB-0006ER-1Q
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 05:36:48 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37093
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1iSIgA-0006EM-Tq
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 05:36:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573036606;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3mffYzdA5EeN/uFB565oNLMR5+8vtD68afuo9/425+c=;
 b=DehgAZnLq7gbmhm5NERvknYH8IZ7HkegoijlZLjlzGsei032ts4U8am8l4AfzV22z+9Fty
 ++5yCKvIxBqHbdv5+ALbAmQihge6G1wC/lfXkiPYTgbBe+S66dRZHN2GKC5eyLKyUohYgS
 Zl5GMk7sEFc8AKeiOc84XLsXPc9J44U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-65-9DcXER7iNMSzA3VWERwXjw-1; Wed, 06 Nov 2019 05:36:42 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D2C421800D53;
 Wed,  6 Nov 2019 10:36:40 +0000 (UTC)
Received: from redhat.com (unknown [10.42.16.105])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 25B8F600C4;
 Wed,  6 Nov 2019 10:36:36 +0000 (UTC)
Date: Wed, 6 Nov 2019 10:36:33 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PULL 0/1] Require Python >= 3.5 to build QEMU
Message-ID: <20191106103633.GE91675@redhat.com>
References: <20191025203427.20181-1-ehabkost@redhat.com>
 <CAFEAcA-F0iB2vzi3Z0J9FPAt6JpuMh+V0wsfXWLuAGX5_d69xw@mail.gmail.com>
 <20191105195748.GG3812@habkost.net> <87y2wuhy00.fsf@linaro.org>
MIME-Version: 1.0
In-Reply-To: <87y2wuhy00.fsf@linaro.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 9DcXER7iNMSzA3VWERwXjw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Ed Maste <emaste@freebsd.org>,
 Eduardo Habkost <ehabkost@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Cleber Rosa <crosa@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Nov 05, 2019 at 08:25:03PM +0000, Alex Benn=C3=A9e wrote:
>=20
> Eduardo Habkost <ehabkost@redhat.com> writes:
>=20
> > On Thu, Oct 31, 2019 at 08:12:01AM +0000, Peter Maydell wrote:
> >> On Fri, 25 Oct 2019 at 21:34, Eduardo Habkost <ehabkost@redhat.com> wr=
ote:
> >> >
> >> > The following changes since commit 03bf012e523ecdf047ac56b2057950247=
256064d:
> >> >
> >> >   Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' int=
o staging (2019-10-25 14:59:53 +0100)
> >> >
> >> > are available in the Git repository at:
> >> >
> >> >   git://github.com/ehabkost/qemu.git tags/python-next-pull-request
> >> >
> >> > for you to fetch changes up to d24e417866f85229de1b75bc5c0a1d942451a=
842:
> >> >
> >> >   configure: Require Python >=3D 3.5 (2019-10-25 16:34:57 -0300)
> >> >
> >> > ----------------------------------------------------------------
> >> > Require Python >=3D 3.5 to build QEMU
> >> >
> >> > ----------------------------------------------------------------
> >>
> >> I can't apply this until we've fixed the tests/vm netbsd setup to
> >> not use Python 2.
> >
> > Fixing tests/vm/netbsd is being tricky.  It looks like the
> > configure patch will have to wait until after QEMU 4.2.0.  :(
>=20
> I've posted fixes for the netbsd serial install but there are still
> problems with the tests including what looks like a fairly serious
> failure in the async code.

At what point do we declare that NetBSD CI is broken and is no longer
considered a supported platform from POV of blocking the merging of
PULL requests ? It has been preventing the dropping of python2 for
quite a while now. It isn't the end of the world in this particular
case, as dropping py2 is mostly just a cleanup, but I feel like we
might benefit from setting expectations for ongoing platform maintenance,
otherwise these kind of issues could drag on indefinitely.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


