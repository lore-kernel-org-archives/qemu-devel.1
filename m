Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A63EBC04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 17:04:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 830D020693
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 17:04:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 830D020693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35377 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYvoe-0004ew-RM
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 13:04:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hYvmX-0003Ye-Bz
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:02:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hYvmT-0000ze-NZ
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:02:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37144)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hYvmR-0000Zo-NI
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:02:25 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EA4F8E3E00;
	Thu,  6 Jun 2019 17:01:54 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-148.ams2.redhat.com
	[10.36.116.148])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C610163F75;
	Thu,  6 Jun 2019 17:01:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 5936C11386A0; Thu,  6 Jun 2019 19:01:49 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Stafford Horne <shorne@gmail.com>
References: <20190529150853.9772-1-armbru@redhat.com>
	<20190529150853.9772-3-armbru@redhat.com>
	<20190531033601.GB3379@lianli.shorne-pla.net>
	<30db7d52-b304-da2d-f84d-42a57dc28135@redhat.com>
	<20190604103349.GD3379@lianli.shorne-pla.net>
Date: Thu, 06 Jun 2019 19:01:49 +0200
In-Reply-To: <20190604103349.GD3379@lianli.shorne-pla.net> (Stafford Horne's
	message of "Tue, 4 Jun 2019 19:33:49 +0900")
Message-ID: <875zpik5qa.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.38]);
	Thu, 06 Jun 2019 17:01:54 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 2/3] MAINTAINERS: Improve section headlines
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
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Stafford Horne <shorne@gmail.com> writes:

> On Mon, Jun 03, 2019 at 10:45:14AM +0200, Philippe Mathieu-Daud=C3=A9 wro=
te:
>> On 5/31/19 5:36 AM, Stafford Horne wrote:
>> > On Wed, May 29, 2019 at 05:08:52PM +0200, Markus Armbruster wrote:
>> >> When scripts/get_maintainer.pl reports something like
>> >>
>> >>     John Doe <jdoe@example.org> (maintainer:Overall)
>> >>
>> >> the user is left to wonder *which* of our three "Overall" sections
>> >> applies.  We have three, one each under "Guest CPU cores (TCG)",
>> >> "Guest CPU Cores (KVM)", and "Overall usermode emulation".
>> >>
>> >> Rename sections under
>> >>
>> >> * "Guest CPU cores (TCG)" from "FOO" to "FOO CPU cores (TCG)"
>> >>
>> >> * "Guest CPU Cores (KVM)" from "FOO" to "FOO CPU cores (KVM)"
>> >>
>> >> * "Guest CPU Cores (Xen)" from "FOO" to "FOO CPU cores (Xen)"
>> >>
>> >> * "Architecture support" from "FOO" to "FOO general architecture
>> >>   support"
>> >>
>> >> * "Tiny Code Generator (TCG)" from "FOO target" to "FOO TCG target"
>> >>
>> >> While there,
>> >>
>> >> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> >> ---
>> >>  MAINTAINERS | 78 ++++++++++++++++++++++++++-------------------------=
--
>> >>  1 file changed, 39 insertions(+), 39 deletions(-)
>> >=20
>> > ...=20
>> >=20
>> >> -OpenRISC
>> >> +OpenRISC CPU cores (TCG)
>> >>  M: Stafford Horne <shorne@gmail.com>
>> >>  S: Odd Fixes
>> >>  F: target/openrisc/
>> >>  F: hw/openrisc/
>> >>  F: tests/tcg/openrisc/
>> >>=20=20
>> >=20
>> > As directories listed there I look over both target/ (TCG?) and hw/.
>> > Would it be better to be 'OpenRISC general architecture'?
>>=20
>> There is a historical separation between target/ and hw/ because they
>> cover different concepts, and have different maintainers/reviewers.
>>=20
>> - target/$arch/ is for TCG/KVM
>> - hw/ is for machines and their devices
>>   (some devices are reused by multiple archs)
>>=20
>> Although the separation is not always clear (some devices are tied to an
>> architecture, some architecture instruction directly access devices) I'd
>> prefer we keep 2 distincts MAINTAINERS sections (keeping you maintainer
>> of both). This will ease developper with specific background/interests
>> to volunteer to a particular section.
>
> Hello,
>
> Thanks for the explaination.  I think it makes sense to have 2 different
> maintainer sections.  In that case should this patch be amended to move t=
he
> 'F: hw/openrisc/' etc out to a different section with the different heade=
r?

This patch merely improves headlines.  Splitting up the OpenRISC section
above should be separate.  Care to send the patch?

