Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F01D6C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 12:12:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6E412467D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 12:12:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GofxBo69"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6E412467D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBdkl-0006GZ-0A
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 08:12:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53229)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jBdjw-0005ak-Jz
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 08:12:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1jBdjv-0005pN-AX
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 08:12:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29350
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1jBdjv-0005jg-5q
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 08:12:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583842321;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FzC93OPPr1WY7OjgIekilNVM+YLGWNqOdOR7/NdCoAo=;
 b=GofxBo692eq/6q3UsgFkXt6MpA0+xw2iuuLsB4qqrSRINGCqNU1WKCqyFhVrRMmt/EcJBH
 XQ7YvjmtJbOt3SzvjxbdTtQYUA7hKtI1+7rFcrQrmpK9ir9kdThT3hn3/Zwi2hMR6bDqnc
 ypL0xpCYCpaEeZcgJDUs2EKzzbT0qt4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-188-phlM-FQZMeKHXN36KeSXYg-1; Tue, 10 Mar 2020 08:11:56 -0400
X-MC-Unique: phlM-FQZMeKHXN36KeSXYg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C2C791005509;
 Tue, 10 Mar 2020 12:11:53 +0000 (UTC)
Received: from redhat.com (ovpn-112-62.ams2.redhat.com [10.36.112.62])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 60E161001B3F;
 Tue, 10 Mar 2020 12:11:37 +0000 (UTC)
Date: Tue, 10 Mar 2020 12:11:34 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PULL 00/33] Trivial branch patches
Message-ID: <20200310121134.GG3234052@redhat.com>
References: <20200309150837.3193387-1-laurent@vivier.eu>
 <20200309151621-mutt-send-email-mst@kernel.org>
 <8db36062-b45d-6c2e-c7d8-98dd2b9db06f@redhat.com>
 <0bb2eac1-74ab-bee8-e8d0-bac542562cdd@vivier.eu>
 <20200310114548.GA6926@linux.fritz.box>
 <ced636a7-dbda-9247-5dd7-37e8c2ccabce@redhat.com>
MIME-Version: 1.0
In-Reply-To: <ced636a7-dbda-9247-5dd7-37e8c2ccabce@redhat.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-block@nongnu.org,
 qemu-trivial@nongnu.org, Helge Deller <deller@gmx.de>,
 Eduardo Habkost <ehabkost@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Alistair Francis <alistair@alistair23.me>, Greg Kurz <groug@kaod.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-arm@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Kevin Wolf <kwolf@redhat.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>, Max Reitz <mreitz@redhat.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Mar 10, 2020 at 01:00:12PM +0100, Philippe Mathieu-Daud=C3=A9 wrote=
:
> On 3/10/20 12:45 PM, Kevin Wolf wrote:
> > Am 10.03.2020 um 09:02 hat Laurent Vivier geschrieben:
> > > Le 09/03/2020 =C3=A0 20:30, Philippe Mathieu-Daud=C3=A9 a =C3=A9crit=
=C2=A0:
> > > > On 3/9/20 8:17 PM, Michael S. Tsirkin wrote:
> > > > > On Mon, Mar 09, 2020 at 04:08:04PM +0100, Laurent Vivier wrote:
> > > > > > The following changes since commit
> > > > > > 7a5853cec479a448edae0fb2aaf4e2f78c9c774d:
> > > > > >=20
> > > > > >  =C2=A0=C2=A0 Merge remote-tracking branch 'remotes/mst/tags/fo=
r_upstream' into
> > > > > > staging (2020-03-09 10:32:53 +0000)
> > > > > >=20
> > > > > > are available in the Git repository at:
> > > > > >=20
> > > > > >  =C2=A0=C2=A0 git://github.com/vivier/qemu.git tags/trivial-bra=
nch-pull-request
> > > > > >=20
> > > > > > for you to fetch changes up to 916c92503bd5348a33e561db600d8894=
bde636bb:
> > > > > >=20
> > > > > >  =C2=A0=C2=A0 monitor/hmp-cmds: Remove redundant statement in
> > > > > > hmp_rocker_of_dpa_groups() (2020-03-09 15:59:31 +0100)
> > > > >=20
> > > > >=20
> > > > > Could you avoid CC everyone involved on the whole PULL req?
> > > > > I was involved in a patch or two and don't really need to see
> > > > > the whole series. Just the cover and the relevant patches
> > > > > would be enough - if I do want it there's always lore.
> > > >=20
> > > > I suppose Laurent used git-publish, which has this limitation.
> > > >=20
> > >=20
> > > Yes, I use git publish and CC are automatically added.
> > >=20
> > > Philippe, you told me some time ago you have a patch to fix this
> > > behaviour and only CC people on a patch base. Is it available?
>=20
> I guess you mean https://github.com/philmd/git-publish/commit/5bab6e2cc77=
, I
> haven't improved it but plan to spend time on it during my next holidays.
>=20
> > Actually, I don't think it's even necessary to CC anyone at all (except
> > the relevant lists) for pull requests. These patches were already
> > reviewed.
>=20
> Well as a contributor I find useful to get notified when patches are merg=
ed.

Yeah, I tend to agree with that - it is good to know when something is
merged, more so if you are an infrequent contributor to an area of code
or QEMU in general.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


