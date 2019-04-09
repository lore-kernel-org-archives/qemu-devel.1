Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D3BC10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 15:27:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 266FA20674
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 15:27:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 266FA20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43516 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDsem-0007WW-C2
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 11:27:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hDsdF-0006Xh-6d
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 11:25:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hDsdE-0006ua-2R
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 11:25:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53778)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1hDsdA-0006pk-AP
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 11:25:50 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BC1E4308623F;
	Tue,  9 Apr 2019 15:25:44 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-120-114.rdu2.redhat.com
	[10.10.120.114])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3B86F619D1;
	Tue,  9 Apr 2019 15:25:35 +0000 (UTC)
To: Peter Maydell <peter.maydell@linaro.org>,
	=?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <20190409134536.15548-1-philmd@redhat.com>
	<CAFEAcA9pc3Dw_X5b74+av0qq5hM7wB4uixSuh_TLwHAm8eGsqA@mail.gmail.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <e89332f2-1673-5192-6ad1-b4ade1b458eb@redhat.com>
Date: Tue, 9 Apr 2019 17:25:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9pc3Dw_X5b74+av0qq5hM7wB4uixSuh_TLwHAm8eGsqA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.42]);
	Tue, 09 Apr 2019 15:25:44 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH for-4.0 v3 0/2] roms: Avoid iPXE/EDK2
 EFIROM variable clash, pass CFLAGS to EDK2 build tools
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
Cc: Olaf Hering <olaf@aepfle.de>, "Michael S . Tsirkin" <mst@redhat.com>,
	QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
	Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190409152535.FJVtc2gMluTbFt8cpz12OQ7qmUxHgmIwH24dv51Lwqc@z>

On 04/09/19 16:00, Peter Maydell wrote:
> On Tue, 9 Apr 2019 at 14:47, Philippe Mathieu-Daud=C3=A9 <philmd@redhat=
.com> wrote:
>>
>> Hi,
>>
>> Two trivial fixes to avoid the latest EDK2 testing series to
>> cause trouble to downstream distributions (in particular if
>> they have PIE enforced).
>>
>> Since v2:
>> - addressed Laszlo's suggestion
>> - reworded patch description
>>
>> v2: https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg01033.htm=
l
>> v1: https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg01006.htm=
l
>> error report: https://lists.gnu.org/archive/html/qemu-devel/2019-04/ms=
g00992.html
>>
>> Regards,
>>
>> Phil.
>>
>> Philippe Mathieu-Daud=C3=A9 (2):
>>   roms: Rename the EFIROM variable to avoid clashing with iPXE
>>   roms: Allow passing configure options to the EDK2 build tools
>>
>>  roms/Makefile | 23 ++++++++++++++++++-----
>>  1 file changed, 18 insertions(+), 5 deletions(-)
>=20
> Thanks. This is one of a handful of remaining bugs we
> should fix for 4.0, so I would ideally like to get this
> in rc3 today (or tomorrow if we have to slip rc3 a day).
> If people wanting to review this series could do so
> promptly I'd definitely appreciate it.
>=20
> -- PMM
>=20

I hope I was quick enough.

Thanks,
Laszlo

