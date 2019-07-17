Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94043C76186
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 12:24:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CFC920880
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 12:24:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CFC920880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hniyz-0008PA-RB
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 08:24:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58070)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <lersek@redhat.com>) id 1hniyp-0007wg-8O
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 08:24:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1hniyn-0000yx-VZ
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 08:24:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53182)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>)
 id 1hniyl-0000wf-55; Wed, 17 Jul 2019 08:24:15 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 21973300CB05;
 Wed, 17 Jul 2019 12:24:13 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-117-5.ams2.redhat.com
 [10.36.117.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 353A65D71D;
 Wed, 17 Jul 2019 12:24:06 +0000 (UTC)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20190716221555.11145-1-philmd@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <7f45fc26-4063-5b8d-d103-a0ac6e873bef@redhat.com>
Date: Wed, 17 Jul 2019 14:24:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190716221555.11145-1-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Wed, 17 Jul 2019 12:24:13 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH-for-4.1 v6 0/5] hw/block/pflash_cfi01: Add
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Alistair Francis <alistair.francis@wdc.com>,
 John Snow <jsnow@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Phil,

On 07/17/19 00:15, Philippe Mathieu-Daud=C3=A9 wrote:
> Hello it's me again, insisting with this series because there are at
> least 2 different report of guests bricked on reset due to the bug
> fixed by patch #5:
> https://bugzilla.redhat.com/show_bug.cgi?id=3D1678713
> https://bugzilla.redhat.com/show_bug.cgi?id=3D1704584
>=20
> Patches missing review: 2 and 3
>=20
> The pflash device lacks a reset() function.
> When a machine is resetted, the flash might be in an
> inconsistent state, leading to unexpected behavior.
> Resolve this issue by adding a DeviceReset() handler.
>=20
> Since v1: https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg0096=
2.html
> - addressed Laszlo review comments
>=20
> Since v2: https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg0039=
5.html
> - consider migration (Laszlo, Peter)
>=20
> Since v3: https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg0166=
8.html
> - more reliable migration (Dave)
> - dropped patches 6-9 not required for next release
>=20
> Since v4: https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg0278=
5.html
> - document why using READ_ARRAY value 0x00 for migration is safe
>=20
> Since v5: https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg0336=
6.html
> - avoid trying to be spec-compliant and messing with migration. KISS.
>   review/test tags reset, sorry.

I have a number of questions / requests.


(1) The last I recall from the v5 discussion is Markus asking about some
risky cases (corner cases?) related to migration.

So what is the new avenue taken in v6? What does "continue ignoring spec
compliance" mean, with regard to migration?

My vague understanding is that we're not trying to answer Markus's
questions; instead, we're side-stepping them, by doing something else.
That works for me, but can we please summarize in a bit more detail?
Like, "in v6, we're not mapping 0x00 vs. 0xff across migration because...=
"

Yes, I could inter-diff v5 vs. v6, but I know way too little about
pflash. I'd miss how our *dropping* of the special 0xff mapping impacts
our conformance to the data sheet.

I'm not asking for commit message updates, just a bit more explanation
in this free-form discussion. (I looked for it under v5, and couldn't
find it.)


(2) Has someone regression-tested v6 for migration specifically?

Or, is v6 not "risky" wrt. migration any longer?


(3) I'm fine regression testing v6 too (without migration, again).
Please ping me separately once the reviews have converged and the series
is otherwise ready for merging.

Thanks!
Laszlo


> $ git backport-diff -u v5
> Key:
> [----] : patches are identical
> [####] : number of functional differences between upstream/downstream p=
atch
> [down] : patch is downstream-only
> The flags [FC] indicate (F)unctional and (C)ontextual differences, resp=
ectively
>=20
> 001/5:[----] [-C] 'hw/block/pflash_cfi01: Removed an unused timer'
> 002/5:[down] 'hw/block/pflash_cfi01: Document use of non-CFI compliant =
command '0x00''
> 003/5:[0031] [FC] 'hw/block/pflash_cfi01: Extract pflash_mode_read_arra=
y()'
> 004/5:[down] 'hw/block/pflash_cfi01: Rename 'reset_flash' label as 'mod=
e_read_array''
> 005/5:[----] [--] 'hw/block/pflash_cfi01: Add the DeviceReset() handler=
'
>=20
> Regards,
>=20
> Phil.
>=20
> Philippe Mathieu-Daud=C3=A9 (5):
>   hw/block/pflash_cfi01: Removed an unused timer
>   hw/block/pflash_cfi01: Document use of non-CFI compliant command
>     '0x00'
>   hw/block/pflash_cfi01: Extract pflash_mode_read_array()
>   hw/block/pflash_cfi01: Rename 'reset_flash' label as 'mode_read_array=
'
>   hw/block/pflash_cfi01: Add the DeviceReset() handler
>=20
>  hw/block/pflash_cfi01.c | 77 +++++++++++++++++++++--------------------
>  hw/block/trace-events   |  1 +
>  2 files changed, 41 insertions(+), 37 deletions(-)
>=20


