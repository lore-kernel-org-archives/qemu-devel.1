Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6772ACA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 17:27:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEDC920700
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 17:27:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEDC920700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMxvx-0003Q7-SP
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 13:27:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47568)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iMxls-0001Lt-Qo
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 13:16:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iMxlq-0000GP-Sx
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 13:16:36 -0400
Received: from 8.mo69.mail-out.ovh.net ([46.105.56.233]:52975)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iMxlp-0000Ez-Ew
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 13:16:34 -0400
Received: from player738.ha.ovh.net (unknown [10.108.57.140])
 by mo69.mail-out.ovh.net (Postfix) with ESMTP id 0C8026CFDC
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 19:16:28 +0200 (CEST)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player738.ha.ovh.net (Postfix) with ESMTPSA id 0E711B65F0EB;
 Tue, 22 Oct 2019 17:16:17 +0000 (UTC)
Subject: Re: [PATCH] aspeed: Add an AST2600 eval board
To: Peter Maydell <peter.maydell@linaro.org>, Joel Stanley <joel@jms.id.au>
References: <20191016090745.15334-1-clg@kaod.org>
 <CACPK8XdT0_JCxzfxd4dCafK0Ae9+18ZWcusuXV+d4eEmwwBnkA@mail.gmail.com>
 <CAFEAcA_6yxaanT2N6Twos_FxjJNgvVKShwgq=pR4fqmcZUsQFA@mail.gmail.com>
 <CAFEAcA8py1obBXc1o02wTRkXms9NwCnCT6Q9ZZ-4W=NzNocLrQ@mail.gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <a0b2779c-bcd5-0fe9-ff3f-d4254aba8805@kaod.org>
Date: Tue, 22 Oct 2019 19:16:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8py1obBXc1o02wTRkXms9NwCnCT6Q9ZZ-4W=NzNocLrQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 4137682159691664192
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrkeejgdduudduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.56.233
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
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22/10/2019 18:43, Peter Maydell wrote:
> On Thu, 17 Oct 2019 at 14:54, Peter Maydell <peter.maydell@linaro.org> =
wrote:
>>
>> On Thu, 17 Oct 2019 at 07:33, Joel Stanley <joel@jms.id.au> wrote:
>>>
>>> On Wed, 16 Oct 2019 at 09:08, C=C3=A9dric Le Goater <clg@kaod.org> wr=
ote:
>>>>
>>>> Define the board with 1 GiB of RAM but some boards can have up to 2
>>>> GiB.
>>>>
>>>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>>>> Reviewed-by: Joel Stanley <joel@jms.id.au>
>>>> ---
>>>>
>>>>  Changes since AST2600 patchset:
>>>>
>>>>  - lowered the RAM size to 1 GiB as it was breaking the tests on som=
e
>>>>    hosts.
>>>
>>> Peter,
>>>
>>> After chatting with C=C3=A9dric I agree we should merge this patch.
>>>
>>> As it turns out the EVBs have differing amounts of RAM; his has 1GB
>>> while mine has 2GB. So we are not being inaccurate by setting 1GB as
>>> the default here.
>>
>> That's convenient, means we don't have to figure out how to
>> special-case the test infrastructure for it :-)
>=20
> This is now OK on the 32-bit boxes, but still fails 'make check'
> on my OSX system:
>=20
> manooth$ QTEST_QEMU_BINARY=3Daarch64-softmmu/qemu-system-aarch64
> tests/qom-test -p /aarch64/qom/ast2600-evb
> /aarch64/qom/ast2600-evb: Broken pipe
> /Users/pm215/src/qemu-for-merges/tests/libqtest.c:149: kill_qemu()
> detected QEMU death from signal 6 (Abort trap: 6)
> Abort trap: 6
>=20
> Dropping from the pullreq again :-(

It will be back !


Is it time for me to install an OSX system for dev and tests or is there=20
a way to reproduce the issue ? no errors spotted in valgrind.

Thanks,

C.

