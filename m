Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C597C004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 09:44:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72CF8204FD
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 09:44:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72CF8204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43442 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNwed-00075W-MP
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 05:44:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hNwdZ-0006XF-73
	for qemu-devel@nongnu.org; Tue, 07 May 2019 05:43:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hNwdX-0000XG-Vr
	for qemu-devel@nongnu.org; Tue, 07 May 2019 05:43:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38404)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hNwdX-0000Wj-PJ
	for qemu-devel@nongnu.org; Tue, 07 May 2019 05:43:47 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 83C15821C3;
	Tue,  7 May 2019 09:43:46 +0000 (UTC)
Received: from redhat.com (ovpn-112-52.ams2.redhat.com [10.36.112.52])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 71F2A277D3;
	Tue,  7 May 2019 09:43:42 +0000 (UTC)
Date: Tue, 7 May 2019 10:43:39 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20190507094339.GH27205@redhat.com>
References: <20190503154613.4192-1-kchamart@redhat.com>
	<20190503154613.4192-2-kchamart@redhat.com>
	<20190503154905.GJ17905@redhat.com> <20190503204757.GF4675@paraplu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190503204757.GF4675@paraplu>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.28]);
	Tue, 07 May 2019 09:43:46 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] VirtIO-RNG: Update default entropy source
 to `/dev/urandom`
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: peter.maydell@linaro.org, armbru@redhat.com, rjones@redhat.com,
	qemu-devel@nongnu.org, amit@kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 03, 2019 at 10:47:57PM +0200, Kashyap Chamarthy wrote:
> On Fri, May 03, 2019 at 04:49:05PM +0100, Daniel P. Berrang=C3=A9 wrote=
:
> > On Fri, May 03, 2019 at 05:46:13PM +0200, Kashyap Chamarthy wrote:
> > > When QEMU exposes a VirtIO-RNG device to the guest, that device nee=
ds a
> > > source of entropy, and that source needs to be "non-blocking", like
> > > `/dev/urandom`.  However, currently QEMU defaults to the problemati=
c
> > > `/dev/random`, which is "blocking" (as in, it waits until sufficien=
t
> > > entropy is available).
> > >=20
> > > So change the entropy source to the recommended `/dev/urandom`.
> > >=20
> > > Related discussion in these[1][2] past threads.
> > >=20
> > > [1] https://lists.nongnu.org/archive/html/qemu-devel/2018-06/msg083=
35.html
> > >     -- "RNG: Any reason QEMU doesn't default to `/dev/urandom`?"
> > > [2] https://lists.nongnu.org/archive/html/qemu-devel/2018-09/msg027=
24.html
> > >     -- "[RFC] Virtio RNG: Consider changing the default entropy sou=
rce to
> > >        /dev/urandom"
> > >=20
> > > Signed-off-by: Kashyap Chamarthy <kchamart@redhat.com>
> > > ---
> > >  backends/rng-random.c | 2 +-
> > >  qemu-options.hx       | 2 +-
> > >  2 files changed, 2 insertions(+), 2 deletions(-)
> >=20
> > Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>=20
> I'm wondering if this needs to be mentioned on a Release Notes wiki
> somewhere -- because we're changing the default.

Release notes need to get updated when pull requests merge to mention
any user relevant changes.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

