Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A6D5C3815B
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 17:39:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C2202076D
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 17:39:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FxwmlVuk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C2202076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOm0G-000610-Hb
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 13:39:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45563)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jOlzT-0005bD-Lt
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 13:38:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1jOlzS-0006yN-Bc
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 13:38:23 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:53146
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1jOlzS-0006y2-7b
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 13:38:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586972301;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5VHRNHJvkQsflTF/tuuQZSYnbTpvSDxNKy5ZA+ilm1c=;
 b=FxwmlVukrhi/yQBcLrVJuqgRTozyNQN9igY4SbN1Plraa4MQWfUf+geA3CXgnuoc+RRqeO
 L2IFQBqQoDKmbfRjL/l7xqziTqS4eRJhr96Qy8eVLAwcVHGv/+8RaefA6MOhSIL34Nakzf
 fsSPRvgkrPt/9TEuTX+ztn32YfgDzF0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-1HblwctaP46IUtXdgaHElA-1; Wed, 15 Apr 2020 13:38:04 -0400
X-MC-Unique: 1HblwctaP46IUtXdgaHElA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 011A019057AB;
 Wed, 15 Apr 2020 17:38:04 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.30])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 773D210493BD;
 Wed, 15 Apr 2020 17:37:47 +0000 (UTC)
Date: Wed, 15 Apr 2020 18:37:44 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: Supported Build Platforms (Again) (Was Re: Supported Sphinx
 Versions)
Message-ID: <20200415173744.GA9032@redhat.com>
References: <20200411182934.28678-1-peter.maydell@linaro.org>
 <4873c74c-f590-62bf-bd64-dd5ab391c252@redhat.com>
 <CAFEAcA-Nuk8hnbtTrhtmSDroZugoEWheyh1N9E4jcAPikpPx9g@mail.gmail.com>
 <0519cb85-5c86-d202-7649-7928b4696644@redhat.com>
 <87a73ezeni.fsf@dusky.pond.sub.org>
 <30779c3c-f887-6b13-6f08-17f085da4874@redhat.com>
MIME-Version: 1.0
In-Reply-To: <30779c3c-f887-6b13-6f08-17f085da4874@redhat.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Apr 15, 2020 at 12:43:01PM -0400, John Snow wrote:
>=20
>=20
> On 4/14/20 3:53 AM, Markus Armbruster wrote:
> > John Snow <jsnow@redhat.com> writes:
> >=20
>=20
> >> Debian:
> >>     8/Jessie: We don't support this anymore AFAIUI.
> >=20
> > Correct.
> >=20
> > docs/system/build-platforms.rst:
> >=20
> >     For distributions with long-lifetime releases, the project will aim
> >     to support the most recent major version at all times.  Support for
> >     the previous major version will be dropped 2 years after the new
> >     major version is released, or when it reaches "end of life".
> >=20
> > Debian 8 reached end of life in 2018, one year after 9's release.
> >=20
>=20
> Debian 8 has "long-term support" until 2020-06-30. I only bring this
> point up because we still list "Debian" under the "long-lifetime
> releases" section, but are excluding the version of Debian that has
> "Long-term" in the name.
>=20
> Pedantic, yes.
>=20
> Is it worth clarifying that we treat Debian as a "long-lifetime" release
> distro, but we do not count their "long-term" support for purposes of
> calculating EOL?

Yes, the listing of Debian as a LTS section is a mistake I made in the
original drafting, which is overdue to clarify/correct.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


