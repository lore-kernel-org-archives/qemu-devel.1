Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B01DC43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 08:12:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44FAC20663
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 08:12:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GXdXTncV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44FAC20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieact-0002q1-DD
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 03:12:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52991)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1ieac2-0001nr-PT
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 03:11:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1ieabz-0007G9-DE
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 03:11:16 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30147
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ieaby-0007Fh-Rf
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 03:11:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575965473;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=wpJp9GxvE4AZ0U0VI8De+FAzYlKAiWeZswt8iaQVdJE=;
 b=GXdXTncVxvKAKIkALoAt9/D3q07qQFk24EzZDr7NmwJXv1E7vl5Ado/qluiE6UrJli3qDt
 WkUD6AsT2oA3WH+JhYJZlMtFytqFpH7tkKVVobL61Xm6E8S31vDbA98JqpreH68a/wnrJt
 d1CMLJHOiJ/cTqnFkYR2Y/StIzCinlI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-399-P9R_3xjWNCW-lTZYTamqoQ-1; Tue, 10 Dec 2019 03:11:12 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A13078024CD
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2019 08:11:11 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-158.ams2.redhat.com [10.36.116.158])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7695A6E41E;
 Tue, 10 Dec 2019 08:11:05 +0000 (UTC)
Subject: Re: [PATCH] hw/usb: Introduce Kconfig switches for the CCID card
 devices
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20191210072048.15603-1-thuth@redhat.com>
 <c402f822-bbbc-7ece-2fb4-1a37484be05e@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <ab65b73a-0c09-925f-054b-c8ddea8b5476@redhat.com>
Date: Tue, 10 Dec 2019 09:11:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <c402f822-bbbc-7ece-2fb4-1a37484be05e@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: P9R_3xjWNCW-lTZYTamqoQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/12/2019 08.43, Philippe Mathieu-Daud=C3=A9 wrote:
> On 12/10/19 8:20 AM, Thomas Huth wrote:
>> In our downstream distribution of QEMU, we need more fine-grained
>> control on the set of CCID card devices that we want to include.
>> So let's introduce some proper Kconfig switches that it is easier
>> to disable them without modifying the corresponding Makefile.objs.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>> =C2=A0 hw/usb/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 10 +++++++++=
+
>> =C2=A0 hw/usb/Makefile.objs |=C2=A0 7 +++++--
>> =C2=A0 2 files changed, 15 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/usb/Kconfig b/hw/usb/Kconfig
>> index 555e09377b..1358847eba 100644
>> --- a/hw/usb/Kconfig
>> +++ b/hw/usb/Kconfig
>> @@ -96,3 +96,13 @@ config USB_STORAGE_MTP
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default y
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 depends on USB
>> +
>> +config CCID_PASSTHRU
>> +=C2=A0=C2=A0=C2=A0 bool
>> +=C2=A0=C2=A0=C2=A0 default y
>> +=C2=A0=C2=A0=C2=A0 depends on USB_SMARTCARD
>> +
>> +config CCID_EMULATED
>> +=C2=A0=C2=A0=C2=A0 bool
>> +=C2=A0=C2=A0=C2=A0 default y
>> +=C2=A0=C2=A0=C2=A0 depends on USB_SMARTCARD
>> diff --git a/hw/usb/Makefile.objs b/hw/usb/Makefile.objs
>> index 303ac084a0..ebe103fb3d 100644
>> --- a/hw/usb/Makefile.objs
>> +++ b/hw/usb/Makefile.objs
>> @@ -29,11 +29,14 @@ common-obj-$(CONFIG_USB_BLUETOOTH)=C2=A0=C2=A0=C2=A0=
 +=3D
>> dev-bluetooth.o
>> =C2=A0 =C2=A0 ifeq ($(CONFIG_USB_SMARTCARD),y)
>> =C2=A0 common-obj-y=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 +=3D dev-smartcard-reader.o
>> -common-obj-$(CONFIG_SMARTCARD)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 +=3D smartcard.mo
>> -smartcard.mo-objs :=3D ccid-card-passthru.o ccid-card-emulated.o
>> +ifeq ($(CONFIG_SMARTCARD),y)
>=20
> We don't need the 'ifeq ($(CONFIG_SMARTCARD),y)' ... endif anymore.

I think we do. Both files #include <libcacard.h> thus can only be
compiled if CONFIG_SMARTCARD has been set.
Don't mix CONFIG_SMARTCARD up with CONFIG_USB_SMARTCARD - these are two
different switches!

 Thomas


>> +common-obj-$(call
>> lor,$(CONFIG_CCID_PASSTHRU),$(CONFIG_CCID_EMULATED)) +=3D smartcard.mo
>> +smartcard.mo-objs :=3D $(call
>> lif,$(CONFIG_CCID_PASSTHRU),ccid-card-passthru.o) \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $(call
>> lif,$(CONFIG_CCID_EMULATED),ccid-card-emulated.o)
>> =C2=A0 smartcard.mo-cflags :=3D $(SMARTCARD_CFLAGS)
>> =C2=A0 smartcard.mo-libs :=3D $(SMARTCARD_LIBS)
>> =C2=A0 endif
>> +endif
>> =C2=A0 =C2=A0 ifeq ($(CONFIG_POSIX),y)
>> =C2=A0 common-obj-$(CONFIG_USB_STORAGE_MTP)=C2=A0 +=3D dev-mtp.o
>>
>=20


