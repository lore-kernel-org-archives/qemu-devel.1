Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E0EC7618B
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 15:01:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDE462239F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 15:01:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDE462239F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpwIa-0004Df-2w
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 11:01:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39457)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ehabkost@redhat.com>) id 1hpwIJ-0003h0-3m
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 11:01:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1hpwIH-0006Qt-CQ
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 11:01:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46426)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>)
 id 1hpwIG-0006Ou-Ck; Tue, 23 Jul 2019 11:01:33 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BC67CC09AD1D;
 Tue, 23 Jul 2019 15:01:29 +0000 (UTC)
Received: from localhost (ovpn-116-40.gru2.redhat.com [10.97.116.40])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 620911001938;
 Tue, 23 Jul 2019 15:01:28 +0000 (UTC)
Date: Tue, 23 Jul 2019 12:01:26 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Laurent Vivier <laurent@vivier.eu>
Message-ID: <20190723150126.GH11469@habkost.net>
References: <20190712134307.31112-1-sw@weilnetz.de>
 <20190723135324.GG11469@habkost.net>
 <e522847b-7d7a-b114-6e75-ebcd76e37f76@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <e522847b-7d7a-b114-6e75-ebcd76e37f76@vivier.eu>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Tue, 23 Jul 2019 15:01:29 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2] Remove old global variables max_cpus
 and smp_cpus
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
Cc: qemu-trivial@nongnu.org, Stefan Weil <sw@weilnetz.de>,
 qemu-devel@nongnu.org, Like Xu <like.xu@linux.intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 23, 2019 at 03:54:56PM +0200, Laurent Vivier wrote:
> Le 23/07/2019 =E0 15:53, Eduardo Habkost a =E9crit=A0:
> > On Fri, Jul 12, 2019 at 03:43:07PM +0200, Stefan Weil wrote:
> >> Signed-off-by: Stefan Weil <sw@weilnetz.de>
> >> ---
> >> v2: Remove also max_cpus (merci =E0 Laurent Vivier <laurent@vivier.e=
u>)
> >>
> >>  include/sysemu/sysemu.h | 2 --
> >>  1 file changed, 2 deletions(-)
> >>
> >> diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
> >> index 984c439ac9..e70edf7c1c 100644
> >> --- a/include/sysemu/sysemu.h
> >> +++ b/include/sysemu/sysemu.h
> >> @@ -103,8 +103,6 @@ extern const char *keyboard_layout;
> >>  extern int win2k_install_hack;
> >>  extern int alt_grab;
> >>  extern int ctrl_grab;
> >> -extern int smp_cpus;
> >> -extern unsigned int max_cpus;
> >>  extern int cursor_hide;
> >>  extern int graphic_rotate;
> >>  extern int no_quit;
> >> --=20
> >> 2.20.1
> >>
> >=20
> > Queued for 4.2, thanks!
> >=20
>=20
> Hi did you the mail from Peter?
>=20
> "this looks like an inadvertent duplicate of Alex's
> patch from yesterday:
>=20
> https://patchew.org/QEMU/20190711130546.18578-1-alex.bennee@linaro.org/=
"

I did, but I hadn't realized the other patch was older.  I will
replace it.

--=20
Eduardo

