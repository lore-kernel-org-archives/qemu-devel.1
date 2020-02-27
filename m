Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61496C4BA2D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 13:30:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D1CD2469D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 13:30:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iyNjlY7E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D1CD2469D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7JEz-0002yq-6s
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 08:30:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33019)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1j7JDi-00019q-8w
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 08:28:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1j7JDg-0005Qt-Ui
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 08:28:54 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47500
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1j7JDg-0005Oe-Ri
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 08:28:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582810131;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7cil+S2TI0XenfpWIIHgW3zIl7wCogwPVlPkS1oJPDY=;
 b=iyNjlY7EoBq/ma+A+6Qodz2rf7LPyd73dnecPArgJGyrtrN01uVa8OF/FCr1acHchdAdG3
 1Vue+XxbrjcuooTlfA1aS8YVFR5J5Djz5u2/VY5oTLVfjGgufkYz989uvvQIV1b6Pvx+5q
 oTq65sDWmisNd59lhT0+nejvzgvm5H0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-zNUZT7qdM0-riHPe5Z7GWA-1; Thu, 27 Feb 2020 08:28:44 -0500
X-MC-Unique: zNUZT7qdM0-riHPe5Z7GWA-1
Received: by mail-wm1-f69.google.com with SMTP id m4so1004229wmi.5
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2020 05:28:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fD0MNpuWhab4G9SMLJRbIrZoxFLbb/kORsNGxaBYd4A=;
 b=gwjf6nVeoHSOuyp4nDclLOBkvgHRexvwqdqxgkMpKAWxpnhZYVwNuke9hHmd9sePa2
 AK8a4iZvCeh91k3aYXcmjw+SP/iOZOfqNb/Wi3HtnhN6GNni9GoqXymGu+SatcHH9L3j
 D9FcDt0UW5deyJ0bmdWCrdLcMF6HdxChz8IA5NFyOqRVrH1D0gdWaP6c4J0jvAvJCSpP
 tncVwyFQWmakh2lIfWTUS9TlgXsVuEAbD1K2uQ0kxD/gBcDfGkgAWXSigd43hLV+hu+b
 aDoM8F0kFMgHNSHzRgvLkUvLDO9uAwJUiIznRKSxQgTsgS2bEYYRJM50whCFqdMFGPlG
 p0LQ==
X-Gm-Message-State: APjAAAVNbfC79Jhby1krFXrPuTYkDfYC24otyAN92Sld5O5wNxsUjFDo
 FVZe5mNh3irptN/PWQDhF3YrhvkMbXuYDz32rxFlzcY4zeNXZK66+Vtbh7q3tB+ueFunKR1/bF5
 pbvGFBn17qe48gpM=
X-Received: by 2002:a05:600c:2c06:: with SMTP id
 q6mr5577722wmg.154.1582810123068; 
 Thu, 27 Feb 2020 05:28:43 -0800 (PST)
X-Google-Smtp-Source: APXvYqxX9vFksVNpjyfpvF+15trhX7hg8u9UM2U82hQyws3i3YOmakD1qZEDxeGYMrxyXo5pOq/jow==
X-Received: by 2002:a05:600c:2c06:: with SMTP id
 q6mr5577674wmg.154.1582810122767; 
 Thu, 27 Feb 2020 05:28:42 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:30cb:d037:e500:2b47?
 ([2001:b07:6468:f312:30cb:d037:e500:2b47])
 by smtp.gmail.com with ESMTPSA id z1sm7450624wmf.42.2020.02.27.05.28.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Feb 2020 05:28:42 -0800 (PST)
Subject: Re: [PATCH 00/20] hw: Clean up hw/i386 headers (and few alpha/hppa)
To: Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 QEMU Trivial <qemu-trivial@nongnu.org>
References: <20191014142246.4538-1-philmd@redhat.com>
 <dacba192-0a1e-9801-3e6f-02583bd8b994@redhat.com>
 <fe8ef9e8-d8d2-e92c-cde3-13a11fa1a5bf@vivier.eu>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <18164a90-1ad2-28d1-f6e2-cc7741532f72@redhat.com>
Date: Thu, 27 Feb 2020 14:28:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <fe8ef9e8-d8d2-e92c-cde3-13a11fa1a5bf@vivier.eu>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Paul Durrant <paul@xen.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>,
 qemu-block@nongnu.org, Helge Deller <deller@gmx.de>,
 David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Eduardo Habkost <ehabkost@redhat.com>,
 Xie Changlong <xiechanglong.d@gmail.com>, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Kevin Wolf <kwolf@redhat.com>, Wen Congyang <wencongyang2@huawei.com>,
 Cornelia Huck <cohuck@redhat.com>, Max Reitz <mreitz@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 26/10/19 15:32, Laurent Vivier wrote:
> Le 26/10/2019 =C3=A0 14:20, Philippe Mathieu-Daud=C3=A9 a =C3=A9crit=C2=
=A0:
>> Hi,
>>
>> On 10/14/19 4:22 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>>> This is a follow-up of Markus's cleanup series:
>>> Tame a few "touch this, recompile the world"
>>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg635748.html
>>>
>>> This part is mostly restricted to X86, but since some file from the
>>> Alpha/PA-RISC machines include "hw/i386/pc.h" I had to fix them
>>> too.
>>>
>>> Eventually I'll succeed at removing hw/i386/ dependency on non-X86
>>> platforms (Quest I started 2 years ago...).
>>>
>>> Regards,
>>>
>>> Phil.
>>>
>>> Philippe Mathieu-Daud=C3=A9 (20):
>>> =C2=A0=C2=A0 vl: Add missing "hw/boards.h" include
>>> =C2=A0=C2=A0 hw/southbridge/ich9: Removed unused headers
>>> =C2=A0=C2=A0 hw/input/pckbd: Remove unused "hw/i386/pc.h" header
>>> =C2=A0=C2=A0 hw/i386/ioapic_internal: Remove unused "hw/i386/ioapic.h" =
header
>>> =C2=A0=C2=A0 hw/timer: Remove unused "ui/console.h" header
>>> =C2=A0=C2=A0 hw/usb/dev-storage: Remove unused "ui/console.h" header
>>> =C2=A0=C2=A0 hw/i386/intel_iommu: Remove unused includes
>>> =C2=A0=C2=A0 hw/xen/xen_pt_load_rom: Remove unused includes
>>> =C2=A0=C2=A0 hw/alpha/alpha_sys: Remove unused "hw/ide.h" header
>>> =C2=A0=C2=A0 hw/alpha/dp264: Include "net/net.h"
>>> =C2=A0=C2=A0 hw/hppa/machine: Include "net/net.h"
>>> =C2=A0=C2=A0 hw/acpi/cpu_hotplug: Include "hw/pci/pci.h"
>>> =C2=A0=C2=A0 hw/timer/hpet: Include "exec/address-spaces.h"
>>> =C2=A0=C2=A0 hw/pci-host/q35: Include "qemu/range.h"
>>> =C2=A0=C2=A0 hw/i2c/smbus_ich9: Include "qemu/range.h"
>>> =C2=A0=C2=A0 hw/pci-host/piix: Include "qemu/range.h"
>>> =C2=A0=C2=A0 hw/acpi: Include "hw/mem/nvdimm.h"
>>> =C2=A0=C2=A0 hw/i386: Include "hw/mem/nvdimm.h"
>>> =C2=A0=C2=A0 hw/pci-host/q35: Remove unused includes
>>> =C2=A0=C2=A0 hw/i386/pc: Clean up includes
>> Laurent, since this series is fully reviewed, can it go via
>> your qemu-trivial tree?
>=20
> I'll try but I'm not sure to have the time to do that before the softfree=
ze.

Ping :)

Paolo


