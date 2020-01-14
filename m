Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CDD0C33CB1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 09:46:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75B5E24670
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 09:46:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75B5E24670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35453 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irImE-00059x-44
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 04:46:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58874)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dovgaluk@ispras.ru>) id 1irIYh-0004FH-8b
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 04:32:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dovgaluk@ispras.ru>) id 1irIYc-0007bU-D6
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 04:32:22 -0500
Received: from mail.ispras.ru ([83.149.199.45]:56474)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <dovgaluk@ispras.ru>) id 1irIYc-0007bC-5C
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 04:32:18 -0500
Received: from PASHAISP (unknown [85.142.117.226])
 by mail.ispras.ru (Postfix) with ESMTPSA id 5351A725C0;
 Tue, 14 Jan 2020 12:32:15 +0300 (MSK)
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
To: =?UTF-8?Q?'Alex_Benn=C3=A9e'?= <alex.bennee@linaro.org>,
 "'Kevin Wolf'" <kwolf@redhat.com>
References: <157709434917.12933.4351155074716553976.stgit@pasha-Precision-3630-Tower>
 <157709442133.12933.4291167191595240519.stgit@pasha-Precision-3630-Tower>
 <20200109115918.GC9504@linux.fritz.box> <878smbnuxi.fsf@linaro.org>
In-Reply-To: <878smbnuxi.fsf@linaro.org>
Subject: RE: [for-5.0 PATCH 03/11] migration: introduce icount field for
 snapshots
Date: Tue, 14 Jan 2020 12:32:17 +0300
Message-ID: <000801d5cabd$8391fc70$8ab5f550$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Office Outlook 12.0
Thread-Index: AdXKNHLGUODbllp2RcaeR38anzP7iwAiMlGA
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
Cc: peter.maydell@linaro.org, pavel.dovgaluk@ispras.ru,
 crosthwaite.peter@gmail.com, ciro.santilli@gmail.com, jasowang@redhat.com,
 quintela@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com,
 'Pavel Dovgalyuk' <pavel.dovgaluk@gmail.com>, maria.klimushenkova@ispras.ru,
 mst@redhat.com, kraxel@redhat.com, boost.lists@gmail.com,
 thomas.dullien@googlemail.com, pbonzini@redhat.com, mreitz@redhat.com,
 artem.k.pisarenko@gmail.com, dgilbert@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> From: Alex Benn=C3=A9e [mailto:alex.bennee@linaro.org]
> Kevin Wolf <kwolf@redhat.com> writes:
>=20
> > Am 23.12.2019 um 10:47 hat Pavel Dovgalyuk geschrieben:
> >> From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
> >>
> >> Saving icount as a parameters of the snapshot allows navigation =
between
> >> them in the execution replay scenario.
> >> This information can be used for finding a specific snapshot for =
proceeding
> >> the recorded execution to the specific moment of the time.
> >> E.g., 'reverse step' action (introduced in one of the following =
patches)
> >> needs to load the nearest snapshot which is prior to the current =
moment
> >> of time.
> >>
> >> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
> >> Acked-by: Markus Armbruster <armbru@redhat.com>
> >
> > Acked-by: Kevin Wolf <kwolf@redhat.com>
>=20
> Apologies my mailer ignored my replay-all:
>=20
> This commit breaks when of the iotests for me:
>=20
>  git bisect run /bin/sh -c "cd builds/all && make -j4 \
>      && cd tests/qemu-iotests && ./check -qcow2 267"
>=20
>=20
>    List of snapshots present on all disks:
>   -ID        TAG                 VM SIZE                DATE       VM =
CLOCK
>   +ID        TAG               VM SIZE                DATE     VM =
CLOCK     ICOUNT
>=20
> But I've also seen:
>=20
>   =
ERROR:/home/.../qemu.git/replay/replay-events.c:80:replay_flush_events:
>      assertion failed: (replay_mutex_locked())

Thank you, I've updated the code.
I also added a patch for fixing the test output.

Pavel Dovgalyuk


