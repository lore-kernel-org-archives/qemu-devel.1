Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91911C32771
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 08:09:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59A672253D
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 08:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WIh3H4M0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59A672253D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuB4t-0001Ox-20
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 03:09:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44092)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iuB3W-0008Tj-7v
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 03:08:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iuB3U-0007KC-Fm
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 03:08:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28879
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iuB3U-0007Jz-B8
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 03:08:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579680483;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H5hK2ahvlTWZjoA0qHEeWEGLkqAnLHJ+H54RsXOgeXo=;
 b=WIh3H4M0X1OW6zwfCymawG3/bYqnHfGcVKbF7/zujPmBnKEsvq2VjQ1umROWOAq5nzfszm
 AJKBI55IC892sWkJeJkduNC0JWrUVqJ13VcZdtoMyXv/Ul0pXoIAmpAxZCz5g1iKUizt8c
 mY7SZJOLLnlM+WaUwiBjnXhCfCl6B8k=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-96-81XfhTS-NLKiJxi7xIGI5g-1; Wed, 22 Jan 2020 03:07:57 -0500
Received: by mail-wm1-f70.google.com with SMTP id l11so1256123wmi.0
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2020 00:07:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Mk1bRKTzOOm9GAJ9gm/7q17RgkrdHOw7irvGhD8As98=;
 b=r3aCSmgHhxKBq9nGcFz79Zf63aJSLgXeycVf2lc4v+hgomz0oC0/BAk9EhQTC8WyHZ
 2OoocI8ggPBiMaxILSGxTywwe7AqGSSquq+YZHYwBI7NNe8tXWFjehooOh/ZR0wGT9JI
 a1ghDfdCyONDyjafBqhMMOkAMeADnIMAjBWB3t2EkmSmkI2bJG+63is8X58zSjl6wEaS
 lZlLuvMaR7C5i38eQ7SQkft3sDMl7jucUjekUM23tj1U+2vB0YZ7myofn8qwu9qW+u3s
 thBsNmvpEI7xFdAWkSBcGX6hqjFruQVYRZ3eLXPaeafQSuj3srmS/apvriiUN8Nr4l80
 lAKA==
X-Gm-Message-State: APjAAAVMHPnOE9fNEvdgkyx12tLGxQMvES1GpcJ/farVds8BtpQSkZJp
 CQjxHqnXbl6FOU8DZZE/JOKIXRvfUVqouAiTRhQzpgploQ5skx0pSS0wKh34Um1Wr8pnKP64ilx
 SvtGceFWyCWS9Jic=
X-Received: by 2002:a5d:6441:: with SMTP id d1mr9447836wrw.93.1579680475436;
 Wed, 22 Jan 2020 00:07:55 -0800 (PST)
X-Google-Smtp-Source: APXvYqx9DyfR6v47IaU2iNU5AfroMkwyXL0B8e/UoJUi2aYWRxRdb8XqV3Ei+ukFvO75Fb7GkBwQHg==
X-Received: by 2002:a5d:6441:: with SMTP id d1mr9447809wrw.93.1579680475099;
 Wed, 22 Jan 2020 00:07:55 -0800 (PST)
Received: from redhat.com (bzq-79-176-0-156.red.bezeqint.net. [79.176.0.156])
 by smtp.gmail.com with ESMTPSA id
 k82sm2940771wmf.10.2020.01.22.00.07.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2020 00:07:54 -0800 (PST)
Date: Wed, 22 Jan 2020 03:07:52 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PULL v2 00/17] virtio, pc: fixes, features
Message-ID: <20200122030732-mutt-send-email-mst@kernel.org>
References: <20200122064907.512501-1-mst@redhat.com>
 <157967700947.9468.10998353016922296572@f6d1ed32ca6b>
MIME-Version: 1.0
In-Reply-To: <157967700947.9468.10998353016922296572@f6d1ed32ca6b>
X-MC-Unique: 81XfhTS-NLKiJxi7xIGI5g-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jan 21, 2020 at 11:10:10PM -0800, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20200122064907.512501-1-mst@redhat.=
com/
>=20
>=20
>=20
> Hi,
>=20
> This series seems to have some coding style problems. See output below fo=
r
> more information:
>=20
> Type: series
> Message-id: 20200122064907.512501-1-mst@redhat.com
> Subject: [PULL v2 00/17] virtio, pc: fixes, features
>=20
> =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
> #!/bin/bash
> git rev-parse base > /dev/null || exit 0
> git config --local diff.renamelimit 0
> git config --local diff.renames True
> git config --local diff.algorithm histogram
> ./scripts/checkpatch.pl --mailback base..
> =3D=3D=3D TEST SCRIPT END =3D=3D=3D
>=20
> From https://github.com/patchew-project/qemu
>  * [new tag]         patchew/20200122064907.512501-1-mst@redhat.com -> pa=
tchew/20200122064907.512501-1-mst@redhat.com
> Switched to a new branch 'test'
> 920a20e i386:acpi: Remove _HID from the SMBus ACPI entry
> cd87503 vhost: Only align sections for vhost-user
> 9ef0893 vhost: Add names to section rounded warning
> 61681af vhost-vsock: delete vqs in vhost_vsock_unrealize to avoid memleak=
s
> ee96146 virtio-scsi: convert to new virtio_delete_queue
> c221c38 virtio-scsi: delete vqs in unrealize to avoid memleaks
> 4a878a8 virtio-9p-device: convert to new virtio_delete_queue
> addbaec virtio-9p-device: fix memleak in virtio_9p_device_unrealize
> 9a05a8d bios-tables-test: document expected file update
> 0478609 acpi: cpuhp: add CPHP_GET_CPU_ID_CMD command
> 5765438 acpi: cpuhp: spec: add typical usecases
> 23f1ef6 acpi: cpuhp: introduce 'Command data 2' field
> aa3f3fa acpi: cpuhp: spec: clarify store into 'Command data' when 'Comman=
d field' =3D=3D 0
> a245ce7 acpi: cpuhp: spec: fix 'Command data' description
> d310d0d acpi: cpuhp: spec: clarify 'CPU selector' register usage and endi=
anness
> b6b3688 tests: q35: MCH: add default SMBASE SMRAM lock test
> 522df3f q35: implement 128K SMRAM at default SMBASE address
>=20
> =3D=3D=3D OUTPUT BEGIN =3D=3D=3D
> 1/17 Checking commit 522df3f88659 (q35: implement 128K SMRAM at default S=
MBASE address)
> 2/17 Checking commit b6b368876a2f (tests: q35: MCH: add default SMBASE SM=
RAM lock test)
> 3/17 Checking commit d310d0d464eb (acpi: cpuhp: spec: clarify 'CPU select=
or' register usage and endianness)
> 4/17 Checking commit a245ce7de00c (acpi: cpuhp: spec: fix 'Command data' =
description)
> 5/17 Checking commit aa3f3fa5fc4e (acpi: cpuhp: spec: clarify store into =
'Command data' when 'Command field' =3D=3D 0)
> 6/17 Checking commit 23f1ef67a7a0 (acpi: cpuhp: introduce 'Command data 2=
' field)
> 7/17 Checking commit 5765438a9869 (acpi: cpuhp: spec: add typical usecase=
s)
> 8/17 Checking commit 04786095aecf (acpi: cpuhp: add CPHP_GET_CPU_ID_CMD c=
ommand)
> 9/17 Checking commit 9a05a8d4907a (bios-tables-test: document expected fi=
le update)
> WARNING: line over 80 characters
> #23: FILE: tests/qtest/bios-tables-test.c:20:
> + * Contributor or ACPI Maintainer (steps 4-7 need to be redone to resolv=
e conflicts
>=20
> total: 0 errors, 1 warnings, 38 lines checked
>=20
> Patch 9/17 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 10/17 Checking commit addbaecb1d51 (virtio-9p-device: fix memleak in virt=
io_9p_device_unrealize)
> 11/17 Checking commit 4a878a8af35b (virtio-9p-device: convert to new virt=
io_delete_queue)
> 12/17 Checking commit c221c38c4eb0 (virtio-scsi: delete vqs in unrealize =
to avoid memleaks)
> 13/17 Checking commit ee961460de93 (virtio-scsi: convert to new virtio_de=
lete_queue)
> 14/17 Checking commit 61681af92804 (vhost-vsock: delete vqs in vhost_vsoc=
k_unrealize to avoid memleaks)
> 15/17 Checking commit 9ef0893d58b6 (vhost: Add names to section rounded w=
arning)
> 16/17 Checking commit cd875038bb0f (vhost: Only align sections for vhost-=
user)
> ERROR: trailing whitespace
> #49: FILE: hw/virtio/vhost.c:554:
> +    if (dev->vhost_ops->backend_type =3D=3D VHOST_BACKEND_TYPE_USER) {  =
 $
>=20
> WARNING: line over 80 characters
> #64: FILE: hw/virtio/vhost.c:569:
> +        trace_vhost_region_add_section_aligned(section->mr->name, mrs_gp=
a, mrs_size,
>=20
> total: 1 errors, 1 warnings, 43 lines checked
>=20
> Patch 16/17 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
>=20
> 17/17 Checking commit 920a20e6fd35 (i386:acpi: Remove _HID from the SMBus=
 ACPI entry)


This is benighn, will fix with a follow-up patch.

> =3D=3D=3D OUTPUT END =3D=3D=3D
>=20
> Test command exited with code: 1
>=20
>=20
> The full log is available at
> http://patchew.org/logs/20200122064907.512501-1-mst@redhat.com/testing.ch=
eckpatch/?type=3Dmessage.
> ---
> Email generated automatically by Patchew [https://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com


