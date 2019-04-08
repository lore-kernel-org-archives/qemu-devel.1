Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78AA5C282CE
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 09:34:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46DF620880
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 09:34:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46DF620880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50076 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDQfS-0008D1-Ij
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 05:34:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hDQXx-0002C5-0m
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 05:26:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hDQJj-0007Ow-UR
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 05:11:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48910)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1hDQJj-0007OZ-LX
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 05:11:51 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A387715567;
	Mon,  8 Apr 2019 09:04:15 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-121-29.rdu2.redhat.com
	[10.10.121.29])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6F1AB600D4;
	Mon,  8 Apr 2019 09:04:10 +0000 (UTC)
To: Olaf Hering <olaf@aepfle.de>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
	<philmd@redhat.com>
References: <20190405123928.70da87e2.olaf@aepfle.de>
	<1cec1873-9962-f258-a052-167efec620e9@redhat.com>
	<20190405125918.462c6ae4.olaf@aepfle.de>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <9a4ea235-29ce-2a98-a723-0a61be55433f@redhat.com>
Date: Mon, 8 Apr 2019 11:04:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190405125918.462c6ae4.olaf@aepfle.de>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.29]);
	Mon, 08 Apr 2019 09:04:15 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] edk2 fails to compile in v4.0.0-rc2
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
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190408090409.t2oXQjuA7va6VTBvABXACi5kERrzJEiLF0vUoijYuH0@z>

On 04/05/19 12:59, Olaf Hering wrote:
> Am Fri, 5 Apr 2019 12:49:15 +0200
> schrieb Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>:
>=20
>> The EDK2 submodule was added for UEFI testing, you don't need to compi=
le
>> it to build/use QEMU.
>>
>> How did you end up compiling it?
>=20
> The qemu.spec file has this since a very long time:
> make -C roms efirom ${unrelated_settings}
>=20
> This used to work still in January with c9d18c1c150c84e7a976df989ad04dd=
f01083f46.

This is not a QEMU build failure, but an issue in the downstream
packaging that not only tries to build QEMU, but performs a maintainer
build on binary artifacts.

I responded in more detail under Phil's thread

[PATCH for-4.0 v2 0/2] roms: Rename the EFIROM variable and let it be
overridable

Thanks
Laszlo

