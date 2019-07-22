Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF5F1C76190
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 16:52:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BBDB21738
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 16:52:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BBDB21738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpbXg-0004Cc-Oo
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 12:52:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42625)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <lersek@redhat.com>) id 1hpbXW-0003mB-VC
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 12:51:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1hpbXV-0006tq-O7
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 12:51:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33614)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>)
 id 1hpbXT-0006pY-5j; Mon, 22 Jul 2019 12:51:51 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2781581F0D;
 Mon, 22 Jul 2019 16:51:47 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-117-23.ams2.redhat.com
 [10.36.117.23])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2A6FC5B681;
 Mon, 22 Jul 2019 16:51:35 +0000 (UTC)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20190718104837.13905-1-philmd@redhat.com>
 <20190718104837.13905-2-philmd@redhat.com>
 <5e6b8a67-8f8a-3e3b-4f42-db2a31c03ad1@redhat.com>
 <d4d20337-b504-0610-8aaf-c8b0b13f0953@redhat.com>
 <053eeafe-4e93-aa96-f544-ea0606e244b6@redhat.com>
 <689b75f8-ae47-621f-44a5-f3ad07fe2661@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <63ff0471-aa50-f60d-417b-c42d315e02e3@redhat.com>
Date: Mon, 22 Jul 2019 18:51:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <689b75f8-ae47-621f-44a5-f3ad07fe2661@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Mon, 22 Jul 2019 16:51:47 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH-for-4.1 v7 1/1] hw/block/pflash_cfi01: Add
 missing DeviceReset() handler
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
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/19/19 18:19, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Laszlo,
>=20
> On 7/18/19 9:35 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 7/18/19 8:38 PM, Laszlo Ersek wrote:
>>> On 07/18/19 17:03, Laszlo Ersek wrote:
>>>> On 07/18/19 12:48, Philippe Mathieu-Daud=C3=A9 wrote:
>>>>> To avoid incoherent states when the machine resets (see but report
> [...]>>> (3) Using OVMF IA32X64 (including the edk2 SMM stack), I've
>>>> regression-tested this patch, on top of v4.1.0-rc1, with KVM. As fol=
lows:
>>>>
>>>> (3a) Normal reboot from the UEFI shell ("reset -c" command)
>>>>
>>>> (3b) Normal reboot from the Linux guest prompt ("reboot" command)
>>>>
>>>> (3c1) Reset as part of ACPI S3 suspend/resume
>>>> (3c2) then use "efibootmgr -n / -N" to write to pflash (by virtue of
>>>> setting / deleting the standardized BootNext UEFI variable)
>>>>
>>>> (3d1) Boot to setup TUI with SB enabled
>>>> (3d2) erase Platform Key in setup TUI (disables SB)
>>>> (3d3) reboot from within setup TUI
>>>> (3d4) proceed to UEFI shell
>>>> (3d5) enable SB with EnrollDefaultKeys.efi
>>>> (3d6) reboot from UEFI shell
>>>> (3d7) proceeed to Linux guest
>>>> (3d8) verify SB enablement (dmesg, "mokutil --sb-state")
>>>>
>>>> (As an added exercise, step (3d4) triggered an "FTW" (fault tolerant
>>>> write) "reclaim" (basically a defragmentation of the journaled
>>>> "filesystem" that the firmware keeps in the flash, as a logical "mid=
dle
>>>> layer"), and that worked fine too.)
>>>>
>>>> Regression-tested-by: Laszlo Ersek <lersek@redhat.com>
>>>>
>>>>
>>>> (4) I plan to provide R-t-b in the evening from aarch64 KVM too, usi=
ng
>>>> the edk2 ArmVirtQemu firmware. Only the first two steps from (3) wil=
l be
>>>> covered (no ACPI S3, no SB).
>>>
>>> Regression-tested-by: Laszlo Ersek <lersek@redhat.com>
>=20
> Patchwork doesn't recognize your R-t-b tag:
>=20
> https://patchwork.ozlabs.org/patch/1133671/
>=20
> Should I change it for a Tested-by, or add as it?

Please pick it up manually, as it is, if that's possible.

I prefer to dedicate "Tested-by" to cases where my before-after
comparison highlights a difference (i.e., bug disappears, or feature
appears). I dedicate "R-t-b" to cases where nothing observable changes
(in accordance with my expectation).

Thanks!
Laszlo

>> Thank you a lot again for all your testing, I also noted your steps an=
d
>> will try to automate them.
>>
>> Best regards,
>>
>> Phil.
>>


