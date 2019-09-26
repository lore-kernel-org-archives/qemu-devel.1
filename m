Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7760C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 12:54:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5B4D222C0
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 12:54:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5B4D222C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDTIF-0005Qi-R3
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 08:54:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44882)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iDTHX-0004wt-4n
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 08:54:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iDTHT-0005ZI-0u
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 08:54:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49736)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iDTHS-0005YM-Mm
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 08:53:58 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 141C02A09CC
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 12:53:54 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id n18so900708wro.11
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 05:53:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9iTm+rI192TuchkNXu4CikMjrl5PPy8NMPPJdfEkY5c=;
 b=RyhFsROKaCbM6mO5KJBPuhMx9SmIIkSX2JfpTQ5d8+JnhPfUhrv11VTgEBIu2HV2bi
 1qJoOzvLOxj45EijLlTDpAAFykDXUc65ulFy1hcTDddt/4Km1szCTyqVr/+4Tlf5rsVQ
 zO9INXtoihRGUqVRoUOg4mrIpe6A+HHOou7Ub7n+Rv4AUxWNzoTwGiSaC78HqbuM0mYd
 2NaCmvItQca9y97bbiM8WLGdxcPhJx91caXuSYv+IjOx+EwrUtiUyCHtFUt181+M7WuC
 tbqGi7mUOVOck/7jIqUFAbDjgMrW1KzoQl3SUFgcBETTnAC0zQUGR4vF6qSF/2jRZpqo
 4Flg==
X-Gm-Message-State: APjAAAVihMcaWpXhTbsYfUOSvYOBwWiBXFJtY3ZGyXliTAWtMUkueKfU
 RLg3R7YKoN3/b1OjX9grgIeqLcOjhJlvrt10qtKy0uCrZ5k0iben5AwMfF8ZvqDiOe9OdAuhKNe
 Zu+ut/cGJpfptxX8=
X-Received: by 2002:a05:6000:14b:: with SMTP id
 r11mr2622913wrx.58.1569502431560; 
 Thu, 26 Sep 2019 05:53:51 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyXzO2NuVvJy8DGj2EBVdmKBZn9Vf4TTtc5O3JGk8+y+BrLzBPvCzqNvfeWgkhH2jdldmFpEQ==
X-Received: by 2002:a05:6000:14b:: with SMTP id
 r11mr2622888wrx.58.1569502431267; 
 Thu, 26 Sep 2019 05:53:51 -0700 (PDT)
Received: from [192.168.1.35] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id a14sm3014604wmm.44.2019.09.26.05.53.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Sep 2019 05:53:50 -0700 (PDT)
Subject: Re: [PATCH 2/2] tests: fix echi/ehci typo
To: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20190926111955.17276-1-marcandre.lureau@redhat.com>
 <20190926111955.17276-3-marcandre.lureau@redhat.com>
 <2283ca7e-15c4-ab3c-9fca-15207985ad64@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <1b5ecf66-d7d1-e8d6-822c-6b0d8866aa0b@redhat.com>
Date: Thu, 26 Sep 2019 14:53:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <2283ca7e-15c4-ab3c-9fca-15207985ad64@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/26/19 1:39 PM, Thomas Huth wrote:
> On 26/09/2019 13.19, Marc-Andr=C3=A9 Lureau wrote:
>> While at it, simplify using $(land).
>>
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>=20
> Fixes: dad5ddcea3b661c6b8ffd83b9bdf0c56001067a2

More than 1 year silently ignored, nice...

>=20
>> ---
>>  tests/Makefile.include | 4 +---
>>  1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/tests/Makefile.include b/tests/Makefile.include
>> index 0595914526..3543451ed3 100644
>> --- a/tests/Makefile.include
>> +++ b/tests/Makefile.include
>> @@ -182,9 +182,7 @@ check-qtest-i386-$(CONFIG_PVPANIC) +=3D tests/pvpa=
nic-test$(EXESUF)
>>  check-qtest-i386-$(CONFIG_I82801B11) +=3D tests/i82801b11-test$(EXESU=
F)
>>  check-qtest-i386-$(CONFIG_IOH3420) +=3D tests/ioh3420-test$(EXESUF)
>>  check-qtest-i386-$(CONFIG_USB_UHCI) +=3D tests/usb-hcd-uhci-test$(EXE=
SUF)
>> -ifeq ($(CONFIG_USB_ECHI)$(CONFIG_USB_UHCI),yy)
>=20
> D'oh!

:)

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>> -check-qtest-i386-y +=3D tests/usb-hcd-ehci-test$(EXESUF)
>> -endif
>> +check-qtest-i386-$(call land,$(CONFIG_USB_EHCI),$(CONFIG_USB_UHCI)) +=
=3D tests/usb-hcd-ehci-test$(EXESUF)
>>  check-qtest-i386-$(CONFIG_USB_XHCI_NEC) +=3D tests/usb-hcd-xhci-test$=
(EXESUF)
>>  check-qtest-i386-y +=3D tests/cpu-plug-test$(EXESUF)
>>  check-qtest-i386-y +=3D tests/q35-test$(EXESUF)
>=20
> Reviewed-by: Thomas Huth <thuth@redhat.com>
>=20

