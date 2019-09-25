Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF377C432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 21:20:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEFD121D79
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 21:20:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEFD121D79
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDEhu-0005cJ-Lj
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 17:20:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41335)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iDEgq-0004dk-Kb
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 17:19:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iDEgW-0007lr-ID
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 17:18:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39718)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iDEgV-0007k6-GD
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 17:18:52 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E878D8AC6F5;
 Wed, 25 Sep 2019 21:18:49 +0000 (UTC)
Received: from [10.3.116.249] (ovpn-116-249.phx2.redhat.com [10.3.116.249])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6E0345C21F;
 Wed, 25 Sep 2019 21:18:47 +0000 (UTC)
Subject: Re: [PATCH v4] qga: add command guest-get-devices for reporting
 VirtIO devices
To: =?UTF-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>,
 qemu-devel@nongnu.org
References: <76c63f3fd5e36dcfdd8fff5158a12c8955130103.1569445431.git.tgolembi@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <e8038579-14f2-76fa-60a7-916f58806442@redhat.com>
Date: Wed, 25 Sep 2019 16:18:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <76c63f3fd5e36dcfdd8fff5158a12c8955130103.1569445431.git.tgolembi@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.69]); Wed, 25 Sep 2019 21:18:50 +0000 (UTC)
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
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/25/19 4:03 PM, Tom=C3=A1=C5=A1 Golembiovsk=C3=BD wrote:
> Add command for reporting devices on Windows guest. The intent is not s=
o
> much to report the devices but more importantly the driver (and its
> version) that is assigned to the device. This gives caller the
> information whether VirtIO drivers are installed and/or whether
> inadequate driver is used on a device (e.g. QXL device with base VGA
> driver).
>=20
> Signed-off-by: Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>
> ---

It's nice to mention here, after the --- separator, how v4 differs from=20
earlier versions, to let reviewers that saw the earlier version check=20
the differences.


> +++ b/qga/qapi-schema.json
> @@ -1242,3 +1242,35 @@
>   ##
>   { 'command': 'guest-get-osinfo',
>     'returns': 'GuestOSInfo' }
> +
> +##
> +# @GuestDeviceInfo:
> +#
> +# @vendor-id: vendor ID
> +# @device-id: device ID
> +# @driver-name: name of the associated driver
> +# @driver-date: driver release date in format YYYY-MM-DD
> +# @driver-version: driver version
> +#
> +# Since: 4.2
> +##
> +{ 'struct': 'GuestDeviceInfo',
> +  'data': {
> +      'vendor-id': 'uint16',
> +      'device-id': 'uint16',
> +      'driver-name': 'str',
> +      'driver-date': 'str',
> +      'driver-version': 'str'
> +      } }
> +
> +##
> +# @guest-get-devices:
> +#
> +# Retrieve information about device drivers in Windows guest
> +#
> +# Returns: @GuestDeviceInfo
> +#
> +# Since: 4.2
> +##
> +{ 'command': 'guest-get-devices',
> +  'returns': ['GuestDeviceInfo'] }
>=20


I'm not spotting any obvious problems with the interface itself, but am=20
not comfortable enough with the rest of the code for a full review.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org

