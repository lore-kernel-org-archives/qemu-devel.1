Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42750C4BA2D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 13:10:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DA812469C
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 13:10:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J0dX418f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DA812469C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7IwJ-0006Q7-5O
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 08:10:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52970)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1j7IuQ-0004U5-QN
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 08:08:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1j7IuP-0001ke-Qx
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 08:08:58 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40196
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1j7IuP-0001jr-NU
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 08:08:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582808936;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Je91nyd2a3rTsgXlqeTOZvkG9c/YBgf2FFxVG5dup6I=;
 b=J0dX418fqqJSdoCcUpRQ+KbauaNbaZzyX4t7y5P02pdttoZ3Paoe2FLT7oburzBOkg/4uc
 bN0syl9QUMkKOXCGUm9GSpcIoS2/Xuz5d97FVafQl9xTaS5mgrF57+F3UexmXJLsD6B0HY
 wEf3Yj4SOcWVF3ai2SRa5Lq+9wXTbBU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-89-6vSFEM_sMx-m0GVUq-7gAA-1; Thu, 27 Feb 2020 08:08:55 -0500
X-MC-Unique: 6vSFEM_sMx-m0GVUq-7gAA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 01C03107ACC5;
 Thu, 27 Feb 2020 13:08:54 +0000 (UTC)
Received: from [10.3.116.57] (ovpn-116-57.phx2.redhat.com [10.3.116.57])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F1A5A5D9CD;
 Thu, 27 Feb 2020 13:08:50 +0000 (UTC)
Subject: Re: [PATCH v2 1/3] iotests: Specify explicit backing format where
 sensible
To: =?UTF-8?Q?J=c3=a1n_Tomko?= <jtomko@redhat.com>
References: <20200227023928.1021959-1-eblake@redhat.com>
 <20200227023928.1021959-2-eblake@redhat.com> <20200227091955.GD2262365@lpt>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <acef142b-4554-488b-10a7-75209a91b919@redhat.com>
Date: Thu, 27 Feb 2020 07:08:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200227091955.GD2262365@lpt>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
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
Cc: Kevin Wolf <kwolf@redhat.com>, pkrempa@redhat.com, qemu-block@nongnu.org,
 libvir-list@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/27/20 3:19 AM, J=E1n Tomko wrote:
> On a Wednesday in 2020, Eric Blake wrote:
>> There are many existing qcow2 images that specify a backing file but
>> no format.=A0 This has been the source of CVEs in the past, but has
>> become more prominent of a problem now that libvirt has switched to
>> -blockdev.=A0 With older -drive, at least the probing was always done by
>> qemu (so the only risk of a changed format between successive boots of
>> a guest was if qemu was upgraded and probed differently).=A0 But with
>> newer -blockdev, libvirt must specify a format; if libvirt guesses raw
>> where the image was formatted, this results in data corruption visible
>> to the guest; conversely, if libvirt guesses qcow2 where qemu was
>> using raw, this can result in potential security holes, so modern
>> libvirt instead refuses to use images without explicit backing format.
>>
>> The change in libvirt to reject images without explicit backing format
>> has pointed out that a number of tools have been far too reliant on
>> probing in the past.=A0 It's time to set a better example in our own
>> iotests of properly setting this parameter.
>>
>> iotest calls to create, rebase, convert, and amend are all impacted to
>> some degree.=A0 It's a bit annoying that we are inconsistent on command
>> line - while all of those accept -o backing_file=3D...,backing_fmt=3D...=
,
>> the shortcuts are different: create and rebase have -b and -F, convert
>> has -B but no -F, and amend has no shortcuts.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---
>=20
> [...]
>=20
> Test #225 still uses -b without a format:
>=20
> ./check -vmdk 225

Oh, good catch (I only ran ./check -qcow2, -nbd, and -raw).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


