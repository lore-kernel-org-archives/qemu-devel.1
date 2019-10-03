Return-Path: <SRS0=VLgg=X4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87CFFC10F14
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 13:13:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 594EE2133F
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 13:13:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 594EE2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iG0uh-0007XN-Bd
	for qemu-devel@archiver.kernel.org; Thu, 03 Oct 2019 09:12:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50570)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iG0tx-000708-3g
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 09:12:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iG0tq-0003ck-T9
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 09:12:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41356)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iG0tq-0003cC-Nf
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 09:12:06 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DE4A17FDCD;
 Thu,  3 Oct 2019 13:12:05 +0000 (UTC)
Received: from [10.3.117.6] (ovpn-117-6.phx2.redhat.com [10.3.117.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6656019C69;
 Thu,  3 Oct 2019 13:11:55 +0000 (UTC)
Subject: Re: [PATCH v5 01/10] hw/virtio: Factorize virtio-mmio headers
To: Sergio Lopez <slp@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@redhat.com>
References: <20191002113103.45023-1-slp@redhat.com>
 <20191002113103.45023-2-slp@redhat.com>
 <96ff1ae1-fc3f-af56-08bd-a8b821385572@redhat.com> <87ftkahxyo.fsf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <099a33d3-c1ab-f1c9-65e1-7dbd396a4817@redhat.com>
Date: Thu, 3 Oct 2019 08:11:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <87ftkahxyo.fsf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Thu, 03 Oct 2019 13:12:06 +0000 (UTC)
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
Cc: Peter Maydell <peter.maydell@linaro.org>, ehabkost@redhat.com,
 mst@redhat.com, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 kraxel@redhat.com, imammedo@redhat.com, pbonzini@redhat.com, rth@twiddle.net,
 lersek@redhat.com, sgarzare@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/3/19 6:26 AM, Sergio Lopez wrote:
>=20
> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
>=20
>> On 10/2/19 1:30 PM, Sergio Lopez wrote:
>>> Put QOM and main struct definition in a separate header file, so it
>>> can be accessed from other components.
>>>
>>> Signed-off-by: Sergio Lopez <slp@redhat.com>

>>> +
>>> +#ifndef QEMU_VIRTIO_MMIO_H
>>> +#define QEMU_VIRTIO_MMIO_H
>>
>> I'd rather use HW_VIRTIO_MMIO_H
>=20
> Looks like there isn't a consensus in this regard:
>=20
> $ grep "ifndef" *

>=20
> Do we have an actual policy written somewhere?

Past history shows several cleanups near commit fe2611b016, including=20
commit c0a9956b which mentions scripts/clean-header-guards specifically=20
for this purpose.  So yes, we have a policy, although it is not always=20
enforced in a timely manner.


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org

