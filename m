Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F96FC06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 12:09:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FB8B2146F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 12:09:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FB8B2146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiHb0-0007eC-Lc
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 08:09:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36475)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <lersek@redhat.com>) id 1hiHLy-0002c8-Og
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 07:53:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1hiHLv-0001AN-7O
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 07:53:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42604)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>)
 id 1hiHLc-0000HJ-Pm; Tue, 02 Jul 2019 07:53:22 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A9B9D307D854;
 Tue,  2 Jul 2019 11:52:39 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-117-172.ams2.redhat.com
 [10.36.117.172])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8FC7E60C67;
 Tue,  2 Jul 2019 11:52:15 +0000 (UTC)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20190702001301.4768-1-philmd@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <0f46b807-1fcc-d5d6-9d62-601cc8dfa692@redhat.com>
Date: Tue, 2 Jul 2019 13:52:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190702001301.4768-1-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Tue, 02 Jul 2019 11:53:00 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 0/9] hw/block/pflash_cfi01: Add
 DeviceReset() handler
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-block@nongnu.org,
 Aleksandar Rikalo <arikalo@wavecomp.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-arm@nongnu.org,
 Alistair Francis <alistair23@gmail.com>, John Snow <jsnow@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Michael Walle <michael@walle.cc>,
 qemu-ppc@nongnu.org, Wei Yang <richardw.yang@linux.intel.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Phil,

On 07/02/19 02:12, Philippe Mathieu-Daud=C3=A9 wrote:
> The pflash device lacks a reset() function.
> When a machine is resetted, the flash might be in an
> inconsistent state, leading to unexpected behavior:
> https://bugzilla.redhat.com/show_bug.cgi?id=3D1678713
> Resolve this issue by adding a DeviceReset() handler.
>=20
> Fix also two minor issues, and clean a bit the codebase.
>=20
> Since v1: https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg0096=
2.html
> - addressed Laszlo review comments
>=20
> Maintainers spam list from:
> ./scripts/get_maintainer.pl -f $(git grep -El '(pflash_cfi01_register|T=
YPE_PFLASH_CFI01)')
>=20
> Regards,
>=20
> Phil.
>=20
> Philippe Mathieu-Daud=C3=A9 (9):
>   hw/block/pflash_cfi01: Removed an unused timer
>   hw/block/pflash_cfi01: Use the correct READ_ARRAY value
>   hw/block/pflash_cfi01: Extract pflash_mode_read_array()
>   hw/block/pflash_cfi01: Start state machine as READY to accept command=
s
>   hw/block/pflash_cfi01: Add the DeviceReset() handler
>   hw/block/pflash_cfi01: Simplify CFI_QUERY processing
>   hw/block/pflash_cfi01: Improve command comments
>   hw/block/pflash_cfi01: Replace DPRINTF by qemu_log_mask(GUEST_ERROR)
>   hw/block/pflash_cfi01: Hold the PRI table offset in a variable
>=20
>  hw/block/pflash_cfi01.c | 140 +++++++++++++++++++++-------------------
>  hw/block/trace-events   |   1 +
>  2 files changed, 74 insertions(+), 67 deletions(-)
>=20

I'll do some regression-tests with this, using OVMF and ArmVirtQemu.

I don't think I can usefully review the patches without getting lost in
the related spec(s), and I don't have capacity for that.

Until I have regression test results, one question: are the changes to
the device model transparent with regard to migration? (You are not
introducing any compat properties.)

Thanks!
Laszlo

