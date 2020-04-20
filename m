Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19EF0C3815B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 11:41:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D844921744
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 11:41:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c7M32eSe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D844921744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQUo8-0000sL-2J
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 07:41:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40416 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jQUmz-0000O8-2s
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 07:40:37 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jQUmx-0006ag-Dv
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 07:40:36 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:20742
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jQUmw-0006Zy-Ul
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 07:40:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587382833;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=my80FUwzhPpk1SB485cUkF4jJz0wJGp44Y2BAg+Fb0Y=;
 b=c7M32eSewjQ0baqjPIRK/5/RMRgwKn+k4Oc6d3hKDIMoMoQXfSJmaCYLk9DE/TPa3F88qH
 jWyKYCDc9nev7KpkQ6Sm9s2RQaa/IHDqdSoiEYBZfpsRbKC/trnGh7pQJKz3wE7189JMck
 f83P4yJl/ANbZpDbrf4hRkT7XjoMO1s=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-S7EeUq69O4u3Jmyh32mcIA-1; Mon, 20 Apr 2020 07:40:27 -0400
X-MC-Unique: S7EeUq69O4u3Jmyh32mcIA-1
Received: by mail-ej1-f72.google.com with SMTP id j19so6206740ejs.1
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2020 04:40:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=aLq4XdLuPWsM50dfm026BAXhMI3kRXcvG8TE9CYhfhA=;
 b=MHkLS14LcFPchkGRY1K7CK2FBRNGRq3NWEHByfycxgdVriLSAywRvVad7G8vVxHLi+
 lkmHYFIn7iII8DEv+1QKo4GsHvaB1SQ5WBDCZiXnGQSWRl5RHhxsMwCxczv+C+CX51zc
 LQWUzBjWa9o4fqTNpEqzhcagEICdJ03LigpVK6xAizCUQD2yAP/+dm0XgDWyrw2yLAj0
 UhVwXZWMZIRqq6JDyZj0uRGCG3R9po/m8z2naFqU8kK5WzXY0aCA/7oN2+F0jp1gOyK0
 9IknnpxZqKCRbobET7XvpXtdytIt8eZgQh4cq3csvuUhxP2J2vep+Zeg5aX0IV5JKhbt
 4yhQ==
X-Gm-Message-State: AGi0PuaZuGpAkX3li7DZMsKm2dWk8ZXbzEW7qaTJSjZLffZst1wDXkWV
 kF/AeX3trA0/NwXg16gfskDseh/no2AmOEq5Jlmy1DNc4+r7hvB14aALMdkuSGd19lWKPnSVnBh
 KAzQ36MrlDqY8/PA=
X-Received: by 2002:a17:906:e01:: with SMTP id
 l1mr15234591eji.76.1587382826128; 
 Mon, 20 Apr 2020 04:40:26 -0700 (PDT)
X-Google-Smtp-Source: APiQypJkyufnWVoa8DcHhnDjXAwiUPRuq/BMzjbvXN5kj5zufzCBo/xKbYYMOmJ+iwqb9pLXlX7Ouw==
X-Received: by 2002:a17:906:e01:: with SMTP id
 l1mr15234566eji.76.1587382825884; 
 Mon, 20 Apr 2020 04:40:25 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id b5sm53897edk.72.2020.04.20.04.40.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Apr 2020 04:40:25 -0700 (PDT)
Subject: Re: [PATCH] Add a new PIIX option to control PCI hot unplugging of
 devices on non-root buses
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <1587136411-200885-1-git-send-email-ani.sinha@nutanix.com>
 <20200417112620-mutt-send-email-mst@kernel.org>
 <2A13ACCD-BD24-41FB-B6EA-2804F7C1FF1D@nutanix.com>
 <20200417120732-mutt-send-email-mst@kernel.org>
 <20200420092459.GF346737@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <5182c28e-0a84-8141-89ca-954dacfc0ca7@redhat.com>
Date: Mon, 20 Apr 2020 13:40:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200420092459.GF346737@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs1p.gnu.org: First seen = 2020/04/20
 01:47:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: Ani Sinha <ani.sinha@nutanix.com>, Eduardo Habkost <ehabkost@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/20/20 11:24 AM, Daniel P. Berrang=C3=A9 wrote:
> On Fri, Apr 17, 2020 at 12:09:00PM -0400, Michael S. Tsirkin wrote:
>> On Fri, Apr 17, 2020 at 03:36:14PM +0000, Ani Sinha wrote:
>>>
>>>
>>>> On Apr 17, 2020, at 8:57 PM, Michael S. Tsirkin <mst@redhat.com> wrote=
:
>>>>
>>>> Is there a real reason to do this? Can't we just limit the
>>>> hotplug control to pcie ports? At some point I'd like us to
>>>> start leaving piix alone..
>>>
>>> Yes we really need this feature as want to be able to hot plug devices =
into the guest but prevent customers from hot unplugging them from say Wind=
ows system tray.
>>>
>>> ani
>>
>> Problem is, I think this is not something we can support with pcie or sh=
pc.
>> I'm reluctant to add features that only ACPI can support,
>> we are trying to phase that out.
>=20
>  From the upstream POV, there's been no decision / agreement to phase
> out PIIX, this is purely a RHEL downstream decision & plan. If other
> distros / users have a different POV, and find the feature useful, we
> should accept the patch if it meets the normal QEMU patch requirements.

Remotely related, this thread suggest to rename the current Frankenstein=20
PIIX as 'virt_southbridge' /s
https://www.mail-archive.com/qemu-devel@nongnu.org/msg691232.html

Seriously, apparently thinking to modify PIIX scares various people.
Is there a virt equivalent that could work?
On one hand people want to use Windows guest unmodified (or with=20
digitally signed drivers, which seems impossible to do with virtio=20
package [*]). OTOH we are not sure how the PIIX model works because it=20
is not based on specs, and does not match its datasheet, and do not want=20
to modify it.

[*] If you click on 'How to Release-Sign File System Drivers' on
https://www.linux-kvm.org/page/WindowsGuestDrivers/Download_Drivers
it opens https://www.microsoft.com/whdc/driver/tips/IFS_Signing.mspx
and displays "Your request has been blocked."...

>=20
> Regards,
> Daniel
>=20


