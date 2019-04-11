Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF3E9C10F14
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 12:59:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BBDD2133D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 12:59:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BBDD2133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48405 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEZIW-00046s-Tr
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 08:59:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36071)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hEZGu-0002uW-T9
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 08:57:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hEZ5S-0001NK-B5
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 08:45:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43612)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hEZ5S-0001N2-37
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 08:45:50 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E96E4300413B;
	Thu, 11 Apr 2019 12:45:48 +0000 (UTC)
Received: from redhat.com (ovpn-112-57.ams2.redhat.com [10.36.112.57])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 0DC3060FB4;
	Thu, 11 Apr 2019 12:45:38 +0000 (UTC)
Date: Thu, 11 Apr 2019 13:45:35 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Message-ID: <20190411124535.GS3641@redhat.com>
References: <1554750276-19230-1-git-send-email-lidong.chen@oracle.com>
	<87mukziv48.fsf@dusky.pond.sub.org>
	<BN6PR2201MB125156A5AB0000731B85E76BC62D0@BN6PR2201MB1251.namprd22.prod.outlook.com>
	<cd833acf-4643-0d3c-78f5-7677d224954e@redhat.com>
	<20190411115216.GN3641@redhat.com>
	<87v9zkzqb8.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <87v9zkzqb8.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.46]);
	Thu, 11 Apr 2019 12:45:49 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] sd: Fix out-of-bounds assertions
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Aleksandar Rikalo <arikalo@wavecomp.com>, Jason Wang <jasowang@redhat.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"f4bug@amsat.org" <f4bug@amsat.org>, Lidong Chen <lidong.chen@oracle.com>,
	"darren.kenny@oracle.com" <darren.kenny@oracle.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
	Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Aurelien Jarno <aurelien@aurel32.net>,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190411124535.RfYgoR4NPGkPJNCQQrynTOJrryccXCryL31y423o9Rc@z>

On Thu, Apr 11, 2019 at 02:20:27PM +0200, Markus Armbruster wrote:
> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>=20
> > On Tue, Apr 09, 2019 at 11:37:44AM +0200, Philippe Mathieu-Daud=C3=A9=
 wrote:
> [...]
> >> I remember this post from Daniel where he suggests sticking to GLib
> >> G_N_ELEMENTS() (which looks similar to your suggestion):
> >> https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg02676.html
> >>=20
> >> $ git grep G_N_ELEMENTS|wc -l
> >> 125
> >> $ git grep ARRAY_SIZE|wc -l
> >> 939
> >>=20
> >> Now it is not obvious to me to understand which GLib API we are
> >> encouraged to use and which ones we shouldn't.
> >
> > We have a bunch of duplication that is essentially a historical
> > artifact from before we used GLib in QEMU. IMHO, if GLib provides
> > something that is equivalent with no functional downside that
> > matters to QEMU, then there's no reason to keep QEMU's duplicate.
> >
> > IOW, I would always prefer GLib unless there's a compelling reason
> > not to in order to minimize what we maintain ourselves
>=20
> Without a tree-wide sweep, we won't ever stop maintaining ARRAY_SIZE().

In this case it is a pretty trivial search & replace to do. The main
hard bit would be syncing with various maintainer trees. Global cleanups
are more work if you need to feed patches in via several different trees,
as opposed to one tree-wide series.

> As long as we maintain it anyway, I'd prefer it over G_N_ELEMENTS()
> myself, because I consider latter name in poor taste: elements of
> *what*?

elements of the variable that you are passing into the macro.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

