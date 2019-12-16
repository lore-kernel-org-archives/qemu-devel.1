Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B47C2D0BF
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 12:08:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02F7A2146E
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 12:08:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IfwGDYeZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02F7A2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igpBE-0005lC-1G
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 07:08:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46887)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1igpAd-0005JC-F1
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 07:08:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1igpAc-0006YR-5q
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 07:08:15 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:58179
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1igpAb-0006Xw-Uu
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 07:08:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576498093;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=lLH/xjKlSNQHkzyH70SKIGKH/biMfSm1ZwSXefNPlnw=;
 b=IfwGDYeZnoaw8zCscWb3PGdWEHwJArEGRhf+CWfMmg7ix9Yjx4uvwqpw/Lb+Wjc+0P3s3h
 lCSUf60fvvpeh15qQVuARh1T8O7utPlBvxZ0JiFLkH39hzP3RADLW1wiTXaCwyo6I2ZsXs
 NH+hFe3W1gEcqhn+lziE/RXbEtV91cQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-219-woecDqupNAWpdSjJ6EEttg-1; Mon, 16 Dec 2019 07:08:12 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0D1CB1800D63;
 Mon, 16 Dec 2019 12:08:11 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-117-164.ams2.redhat.com [10.36.117.164])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7AC955C1D6;
 Mon, 16 Dec 2019 12:08:04 +0000 (UTC)
Subject: Re: [PULL 00/10] Bluetooth removal, and qtest & misc patches
To: Peter Maydell <peter.maydell@linaro.org>
References: <20191212185424.4675-1-thuth@redhat.com>
 <CAFEAcA_RQC8yswF4X8h9ya_CGLNAsJYZPZGyiqzG6sPq0bSLSQ@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <32967af9-3c78-0088-6e42-6ec4fa80eadc@redhat.com>
Date: Mon, 16 Dec 2019 13:08:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_RQC8yswF4X8h9ya_CGLNAsJYZPZGyiqzG6sPq0bSLSQ@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: woecDqupNAWpdSjJ6EEttg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 16/12/2019 11.27, Peter Maydell wrote:
> On Thu, 12 Dec 2019 at 18:54, Thomas Huth <thuth@redhat.com> wrote:
>>
>>  Hi,
>>
>> the following changes since commit 52901abf94477b400cf88c1f70bb305e690ba=
2de:
>>
>>   Update version for v4.2.0-rc5 release (2019-12-10 17:15:21 +0000)
>>
>> are available in the Git repository at:
>>
>>   https://gitlab.com/huth/qemu.git tags/pull-request-2019-12-12
>>
>> for you to fetch changes up to e38f04c4db40a9219cc0c516a6c68b9ca0a783d0:
>>
>>   tests: use g_test_rand_int (2019-12-12 08:16:24 +0100)
>>
>> ----------------------------------------------------------------
>> - Removal of the deprecated bluetooth code
>> - Some qtest and misc patches
>> ----------------------------------------------------------------
>=20
> Hi; this fails to build on some of my build hosts:
>=20
> OSX:
> [...]
>   GEN     target/sparc/trace.c
>   GEN     util/trace.c
>   GEN     hw/core/trace.c
>   CC      qga/main.o
>   CC      qemu-nbd.o
>   CC      qemu-img.o
> make: *** No rule to make target `config-all-devices.mak', needed by
> `aarch64-softmmu/all'.  Stop.
> make: *** Waiting for unfinished jobs....

I unfortunately can't reproduce the issue, but if you've got some spare
minutes, could you please check whether this patch helps:

diff --git a/Makefile b/Makefile
index b437a346d7..23aae1437b 100644
--- a/Makefile
+++ b/Makefile
@@ -365,7 +365,8 @@ ifeq ($(SUBDIR_DEVICES_MAK),)
 config-all-devices.mak: config-host.mak
        $(call quiet-command,echo '# no devices' > $@,"GEN","$@")
 else
-config-all-devices.mak: $(SUBDIR_DEVICES_MAK) config-host.mak
+config-all-devices.mak: $(SUBDIR_DEVICES_MAK) config-host.mak \
+                       $(SRC_PATH)/hw/Kconfig
        $(call quiet-command, sed -n \
              's|^\([^=3D]*\)=3D\(.*\)$$|\1:=3D$$(findstring y,$$(\1)\2)|p'=
 \
              $(SUBDIR_DEVICES_MAK) | sort -u > $@, \

?

> ppc64 linux:
>   CC      chardev/char-mux.o
>   CC      chardev/char-null.o
>   CC      chardev/char-parallel.o
>   CC      chardev/char-pipe.o
>   CC      chardev/char-pty.o
>   CC      chardev/char-ringbuf.o
>   CC      chardev/char-serial.o
>   CC      chardev/char-socket.o
>   CC      chardev/char-stdio.o
> make: *** No rule to make target `/home/pm215/qemu/hw/bt/Kconfig',
> needed by `aarch64-softmmu/config-devices.mak'.  Stop.
> make: *** Waiting for unfinished jobs....
>   CC      chardev/char-udp.o
> make: Leaving directory `/home/pm215/qemu/build/all'
>=20
>=20
> windows crossbuilds:
>   CC      chardev/char-serial.o
>   CC      chardev/char-socket.o
>   CC      chardev/char-stdio.o
>   CC      chardev/char-udp.o
>   CC      chardev/char-win.o
> make: *** No rule to make target
> '/home/petmay01/qemu-for-merges/hw/bt/Kconfig', needed by
> 'aarch64-softmmu/config-devices.mak'.  Stop.
> make: *** Waiting for unfinished jobs....
>   CC      chardev/char-win-stdio.o

These ones are really surprising to me ... *-softmmu/config-devices.mak
should have a proper dependency on hw/Kconfig so they should get
properly rebuild as far as I can tell. Could you please check the
*-softmmu/config-devices.mak.d dependency files whether the dependency
on hw/Kconfig is really there? Hmm, maybe "make" also tries to check the
old dependency to hw/bt/Kconfig first, before regenerating the files ...
not sure how to fix this properly, maybe leave an empty hw/bt/Kconfig
around for a while 'til all build systems have regenerated the
dependency files?

 Thomas


