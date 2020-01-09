Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC04C32771
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 12:28:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C03812072A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 12:28:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C03812072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipWv6-0005pk-V3
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 07:28:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54286)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dovgaluk@ispras.ru>) id 1ipWuL-0005Ph-JW
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 07:27:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dovgaluk@ispras.ru>) id 1ipWuK-0001mS-AL
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 07:27:25 -0500
Received: from mail.ispras.ru ([83.149.199.45]:58830)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <dovgaluk@ispras.ru>) id 1ipWuJ-0001f1-VP
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 07:27:24 -0500
Received: from PASHAISP (unknown [85.142.117.226])
 by mail.ispras.ru (Postfix) with ESMTPSA id F4156653;
 Thu,  9 Jan 2020 15:27:17 +0300 (MSK)
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
To: =?utf-8?Q?'Alex_Benn=C3=A9e'?= <alex.bennee@linaro.org>
References: <157709434917.12933.4351155074716553976.stgit@pasha-Precision-3630-Tower>
 <157709445117.12933.4203495154518338251.stgit@pasha-Precision-3630-Tower>
 <87k160izsv.fsf@linaro.org>
In-Reply-To: <87k160izsv.fsf@linaro.org>
Subject: RE: [for-5.0 PATCH 05/11] replay: introduce info hmp/qmp command
Date: Thu, 9 Jan 2020 15:27:17 +0300
Message-ID: <003f01d5c6e8$22570be0$670523a0$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Office Outlook 12.0
Thread-Index: AdXG55slj6u5sKpmRLyS14xljOEQzQAABOiA
Content-Language: ru
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 83.149.199.45
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, pavel.dovgaluk@ispras.ru,
 crosthwaite.peter@gmail.com, ciro.santilli@gmail.com, jasowang@redhat.com,
 quintela@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com,
 maria.klimushenkova@ispras.ru, mst@redhat.com, kraxel@redhat.com,
 boost.lists@gmail.com, thomas.dullien@googlemail.com, pbonzini@redhat.com,
 mreitz@redhat.com, artem.k.pisarenko@gmail.com, dgilbert@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> From: Alex Benn=C3=A9e [mailto:alex.bennee@linaro.org]
> Pavel Dovgalyuk <pavel.dovgaluk@gmail.com> writes:
>=20
> > From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
> >
> > This patch introduces 'info replay' monitor command and
> > corresponding qmp request.
> > These commands request the current record/replay mode, replay log =
file
> > name, and the instruction count (number of recorded/replayed
> > instructions).  The instruction count can be used with the
> > replay_seek/replay_break commands added in the next two patches.
> >
> > Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
> > Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > Acked-by: Markus Armbruster <armbru@redhat.com>
>=20
> diff --git a/replay/Makefile.objs b/replay/Makefile.objs
> index 939be964a9..f847c5c023 100644
> --- a/replay/Makefile.objs
> +++ b/replay/Makefile.objs
> @@ -8,3 +8,4 @@ common-obj-y +=3D replay-snapshot.o
>  common-obj-y +=3D replay-net.o
>  common-obj-y +=3D replay-audio.o
>  common-obj-y +=3D replay-random.o
> +common-obj-y +=3D replay-debugging.o
>=20
> this has a minor merge conflict. I seem to be missing replay-random.

Sorry, forgot about this. random-related patch was pulled yesterday.
It is not meaningful for trying reverse debugging.

All patches are committed into this branch, if you want to try: =
https://github.com/ispras/qemu/tree/rr-191223

Pavel Dovgalyuk


