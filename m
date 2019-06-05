Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ABB1C28CC5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 16:32:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 744D7206C3
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 16:32:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 744D7206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46089 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYYqP-0005aY-Ou
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 12:32:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38715)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hYYpA-0004rj-PB
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 12:31:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hYYp9-00031H-8P
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 12:31:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48862)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1hYYp9-0002zq-0e
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 12:31:39 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8911030BC100;
	Wed,  5 Jun 2019 16:31:27 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-116-187.ams2.redhat.com
	[10.36.116.187])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7C99018259;
	Wed,  5 Jun 2019 16:31:19 +0000 (UTC)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
	Olaf Hering <olaf@aepfle.de>, qemu-devel@nongnu.org
References: <20190530192812.17637-1-olaf@aepfle.de>
	<3e79c06b-cffb-977d-1f08-f1bb46dad795@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <33ae1318-9019-62d2-3718-143c9ac5bd9a@redhat.com>
Date: Wed, 5 Jun 2019 18:31:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <3e79c06b-cffb-977d-1f08-f1bb46dad795@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.45]);
	Wed, 05 Jun 2019 16:31:32 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v1] Makefile: remove DESTDIR from firmware
 file content
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
Cc: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>,
	=?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	Gerd Hoffmann <kraxel@redhat.com>,
	=?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06/05/19 16:46, Philippe Mathieu-Daud=C3=A9 wrote:
> [Odd, I'm pretty sure I replied to this last week but can't find it, so
> again]
> Cc'ing Laszlo since he wrote this.
>=20
> On 5/30/19 9:28 PM, Olaf Hering wrote:
>> The resulting firmware files should only contain the runtime path.
>> Fixes commit 26ce90fde5c ("Makefile: install the edk2 firmware images
>> and their descriptors")
>>
>> Signed-off-by: Olaf Hering <olaf@aepfle.de>
>> ---
>>  Makefile | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Makefile b/Makefile
>> index f0be624f47..61267bf1a4 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -844,7 +844,7 @@ ifneq ($(DESCS),)
>>  	$(INSTALL_DIR) "$(DESTDIR)$(qemu_datadir)/firmware"
>>  	set -e; tmpf=3D$$(mktemp); trap 'rm -f -- "$$tmpf"' EXIT; \
>>  	for x in $(DESCS); do \
>> -		sed -e 's,@DATADIR@,$(DESTDIR)$(qemu_datadir),' \
>> +		sed -e 's,@DATADIR@,$(qemu_datadir),' \
>=20
> I'm fine with this patch.
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>=20
> Laszlo, did you use the full path for a particular reason?

Yes. The reason was that I had no idea what DESTDIR stood for. After
grepping the QEMU source tree for DESTDIR, I *still* have no idea what
it stands for.

DESTDIR seems to be an installation prefix that is not controlled through

  ./configre --prefix=3D...

Based on memories from other projects -- with better documentation --
though, DESTDIR looks like an install-time-only pre-prefix. In that
sense, the patch looks correct (and the vague expression "runtime path"
in the commit message starts to make some sense). Presumably DESTDIR is
used in package build scripts... Yup, the RHEL spec files use it too,
for "make install".

So, the patch is correct IMO:

Reviewed-by: Laszlo Ersek <lersek@redhat.com>

Too bad QEMU is chronically under-documented (and the commit message on
the patch doesn't help much in that regard).

Thanks
Laszlo

>>  			"$(SRC_PATH)/pc-bios/descriptors/$$x" > "$$tmpf"; \
>>  		$(INSTALL_DATA) "$$tmpf" \
>>  			"$(DESTDIR)$(qemu_datadir)/firmware/$$x"; \
>>


