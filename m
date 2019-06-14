Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0033C31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 19:46:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C560217D6
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 19:46:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C560217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54816 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbs99-0005K5-G2
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 15:45:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46289)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <lersek@redhat.com>) id 1hbs7R-0004VN-Q3
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 15:44:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1hbs7Q-0007vy-8K
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 15:44:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50116)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1hbs7O-0007sZ-Kw
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 15:44:12 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 396C430832CC
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 19:44:02 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-116-141.ams2.redhat.com
 [10.36.116.141])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 534C86108A;
 Fri, 14 Jun 2019 19:43:57 +0000 (UTC)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <20190606133110.13754-1-lersek@redhat.com>
 <611d1efd-3052-c98d-e88a-294d07c822ab@redhat.com>
 <50d3c5a3-9f7a-ab7d-7421-9608675f1bf0@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <75a60e82-11e8-5ad8-0c38-ad1b9741d2a6@redhat.com>
Date: Fri, 14 Jun 2019 21:43:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <50d3c5a3-9f7a-ab7d-7421-9608675f1bf0@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Fri, 14 Jun 2019 19:44:07 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 0/6] update edk2 submodule & binaries to
 edk2-stable201905
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
Cc: qemu devel list <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06/13/19 19:41, Philippe Mathieu-Daud=C3=A9 wrote:
> On 6/13/19 5:12 PM, Laszlo Ersek wrote:
>> On 06/06/19 15:31, Laszlo Ersek wrote:
>>> Launchpad: https://bugs.launchpad.net/qemu/+bug/1831477
>>> Repo:      https://github.com/lersek/qemu.git
>>> Branch:    edk2-stable201905-lp-1831477
>>>
>>> edk2-stable201905 has been released today; let's update QEMU's
>>> submodule, and the binaries built thereof. This should be the edk2
>>> release that goes into QEMU 4.1.
>>>
>>> Cc: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>>
>>> Thanks
>>> Laszlo
>>>
>>> Laszlo Ersek (6):
>>>   roms/Makefile.edk2: define edk2-stable201905 network feature test
>>>     macros
>>>   roms/edk2: update submodule from edk2-stable201903 to
>>>     edk2-stable201905
>>>   roms/Makefile.edk2: remove edk2-stable201903 network feature test
>>>     macros
>>>   roms/Makefile.edk2: update input file list for
>>>     "pc-bios/edk2-licenses.txt"
>>>   pc-bios: refresh edk2 build artifacts for edk2-stable201905
>>>   pc-bios: update the README file with edk2-stable201905 information
>>>
>>>  pc-bios/README                         |  14 +-
>>>  pc-bios/edk2-aarch64-code.fd.bz2       | Bin 1177603 -> 1178070 byte=
s
>>>  pc-bios/edk2-arm-code.fd.bz2           | Bin 1173662 -> 1172752 byte=
s
>>>  pc-bios/edk2-i386-code.fd.bz2          | Bin 1688659 -> 1736199 byte=
s
>>>  pc-bios/edk2-i386-secure-code.fd.bz2   | Bin 1881979 -> 1943949 byte=
s
>>>  pc-bios/edk2-licenses.txt              | 752 ++++++++++++++++++--
>>>  pc-bios/edk2-x86_64-code.fd.bz2        | Bin 1669280 -> 1717094 byte=
s
>>>  pc-bios/edk2-x86_64-secure-code.fd.bz2 | Bin 1901210 -> 1958037 byte=
s
>>>  roms/Makefile.edk2                     |  22 +-
>>>  roms/edk2                              |   2 +-
>>>  10 files changed, 714 insertions(+), 76 deletions(-)
>>>
>>
>> Ping :)
>=20
> Oops sorry ...
>=20
> Series:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Thanks! I'll send a pull req soon.

> (Definitively not a series you want to test on your laptop...)

Can you please clarify? I did test the series on my laptop...

Thanks,
Laszlo

