Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D69C3F2CD
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 15:04:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33DCB20848
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 15:04:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bIl+IyPA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33DCB20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9s2j-000267-8Z
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 10:04:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42192)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1j9s0F-00015N-Er
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 10:01:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1j9s0D-0001dQ-2T
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 10:01:34 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37303
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1j9s0C-0001d3-Uf
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 10:01:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583420492;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o4x3+2HVduoV5LvQcyZhKCpkD5Jw62Jja240veAukng=;
 b=bIl+IyPADo+1TD4S0ACa9uuwEcFhkVOgc9z9RilTM7voy9eaf6GuRGlvWKCeuBwOXKsprL
 cpShlxx4V3ajybOs7V2W1JRe4FX1PclUCBz7ASakN/kduziD1UgurpU6VsWA+UoXdAlCxH
 0vnAa8GCs2uBbEGmgsTwII6x7oH0OHo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-cwJR9mMMOQeJFo6A0mI-_w-1; Thu, 05 Mar 2020 10:01:30 -0500
X-MC-Unique: cwJR9mMMOQeJFo6A0mI-_w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AAE5A800D4E
 for <qemu-devel@nongnu.org>; Thu,  5 Mar 2020 15:01:29 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-117-216.ams2.redhat.com
 [10.36.117.216])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A2CD59CA3;
 Thu,  5 Mar 2020 15:01:25 +0000 (UTC)
Subject: Re: [PULL 1/1] qxl: introduce hardware revision 5
To: Yuri Benditovich <ybendito@redhat.com>
References: <20200213090627.2181-1-kraxel@redhat.com>
 <20200213090627.2181-2-kraxel@redhat.com>
 <bb1f9cbb-7f98-e955-c55d-abc36e788902@redhat.com>
 <1472901155.11933269.1583395037984.JavaMail.zimbra@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <e69ea9ab-9fc1-ca12-c7ab-50e094c1c782@redhat.com>
Date: Thu, 5 Mar 2020 16:01:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1472901155.11933269.1583395037984.JavaMail.zimbra@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
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
Cc: Yan Vugenfirer <yvugenfi@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03/05/20 08:57, Yuri Benditovich wrote:
> ----- Original Message -----
>
>> From: "Laszlo Ersek" <lersek@redhat.com>
>> To: "Gerd Hoffmann" <kraxel@redhat.com>
>> Cc: qemu-devel@nongnu.org, "Eduardo Habkost" <ehabkost@redhat.com>,
>> "Yuri Benditovich" <ybendito@redhat.com>, "Yan Vugenfirer"
>> <yvugenfi@redhat.com>
>> Sent: Thursday, March 5, 2020 1:28:23 AM
>> Subject: Re: [PULL 1/1] qxl: introduce hardware revision 5
>
>> this patch -- commit ed71c09ffd6f -- disables ACPI S3 in the Windows
>> 10 guest for me, using OVMF and QXL.
>
>> The "Sleep" menu entry disappears from the power button icon/menu at
>> the login screen, and "psshutdown -d -t 3" (from the pstools package)
>> also stops working (it reports that the computer does not support
>> S3).
>
>> At the parent commit (e18e5501d8ac), S3 suspend/resume works.
>

[...]

>> OVMF is built at current edk2 master: e63d54db9526.
>
>> In the Windows 10 guest, the installed driver has the following
>> properties (per Device Manager):
>
>> - driver date: 7/28/2015
>> - driver version: 22.33.46.473

> This is not what I would expect from any qxl driver for Win10
> What is the name of display adapter?

"Red Hat QXL controller"

> The driver provider is 'Red Hat'?

In the "Red Hat QXL controller Properties" dialog:

- on the General tab, Manufacturer is "Red Hat, Inc."

- on the Driver tab, both the "Driver Provider" and the "Digital Signer"
  fields are "Red Hat, Inc."

This driver comes from "qxlwddm-0.1-12" (buildID=449635), in Brew.

In retrospect it looks like this driver was meant for Windows 8 only,
but it happened to install under, and work OK for, Windows 10 too.

> Does your guest run with secure boot?

Yes, it does. (Double-checked it with "confirm-SecureBootUEFI" in
PowerShell.)

> I do not see such an effect with 'Sleep' with latest qemu master +
> OVMF + qxl + Win10, the sleep button does not disappear.

I'm happy to try other driver versions. Hopefully Windows 10 will
actually see them as upgrading the currently installed driver. (Or
should I uninstall first?)

Thanks!
Laszlo


