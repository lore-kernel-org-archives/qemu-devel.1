Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6829BC2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 21:36:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32F16206F0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 21:36:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ak3GIV5Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32F16206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwv0y-0001VW-At
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 16:36:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32781)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iwut5-0004uX-Ul
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 16:28:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iwut4-0003Wk-J6
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 16:28:39 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46309
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iwut4-0003T8-FT
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 16:28:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580333315;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/8QEsl6aIUhefusCUl3GpMoCCJ/WNN/epQ+XSf42Hm8=;
 b=ak3GIV5Z3dySLQVVoZqnxvNsAfHJDA7vsEvtQWGHam3CXepNAa0RjY4LG8YAkZ0Sx12yli
 GZzspecNRtDIs69IX4VlBvYsVLdTRPNIHMtseq+R6fWDb55hvNr96z+DjeS6jOoms3NENq
 P4l9ac5dSbo5YhmrDY+0MatCwLwHSd8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-LQVW8F8WPpmrHiTgXHcaOw-1; Wed, 29 Jan 2020 16:28:32 -0500
Received: by mail-wr1-f71.google.com with SMTP id t3so596184wrm.23
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2020 13:28:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=K9djQyb+r/KuqaRMfW8f//SvoftIz69PyYuc+SutlTY=;
 b=gsGNVZYQhMINB3nS4t6bImewErR+Jg13+HmO1EnORMLS036hZKdH4P0W06m3iqXduu
 bUOKqTU7TQd26SK5tsYtYepzXgCFrvn4jCrc6hUj0xNs57AeuHdW7NC/SPkeREQlmTWK
 6mYI/xmTZkPS6l2D4JWBpTbIXV/1nFHXkS3AcyKM27xNZ97UxXWEyW/eeLnLzlO0a6B+
 LNLTXTtN6BQvkKJgSZESJsT6xz8U+tL0WT/iam1QOl677pNw7kExz/6m8T1CL6sc3Iep
 YqNSUl1we1yspJrbWGkgHmzP+vFFU5ogMgBN42/TseQvSMfHyXfhuU6eozU6/jNloDuz
 H6XA==
X-Gm-Message-State: APjAAAURBGh+mo0TUnws2vxvFsaLYRWQ9qaFZAPy6//2Yqgrx+FnYATW
 dKG+BMZizikjxe6C5lPcg3qCHRNzMEYABpBJrdowLYR/hQuYJ44q7OdNLfr8eyayzXHph+eGucK
 fMX+S4BLSnPyTgqs=
X-Received: by 2002:a1c:4857:: with SMTP id v84mr1224354wma.8.1580333311298;
 Wed, 29 Jan 2020 13:28:31 -0800 (PST)
X-Google-Smtp-Source: APXvYqz8e3pDIY4pyl42tIDS1aude53r24B1ZAws3kWfFlfTcofqo2vtz1MWKYKrtIZEA0F4knx3dA==
X-Received: by 2002:a1c:4857:: with SMTP id v84mr1224335wma.8.1580333311004;
 Wed, 29 Jan 2020 13:28:31 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id r15sm3675877wmh.21.2020.01.29.13.28.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jan 2020 13:28:30 -0800 (PST)
Subject: Re: [PATCH v2 00/29] tests/acceptance/virtio_seg_max_adjust: Restrict
 it to Linux/X86
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org
References: <20200129212345.20547-1-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <5ac6b999-29d9-631a-7f1b-464dc15eed59@redhat.com>
Date: Wed, 29 Jan 2020 22:28:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200129212345.20547-1-philmd@redhat.com>
Content-Language: en-US
X-MC-Unique: LQVW8F8WPpmrHiTgXHcaOw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Cornelia Huck <cohuck@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Wrong subject... should be:

   "Improve multi-arch/OS support of acceptance tests"

On 1/29/20 10:23 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Currently our CI is mostly restricted to Linux/X86.
> We want to have more, but until there we have to run these tests
> manually, which is why we didn't noticed earlier this test was
> failing on OSX.
>=20
> This series contains the patches I used to debug why the
> virtio_seg_max_adjust had broken the OSX CI, but then I
> kept testing on other archs, thus added more patches...
>=20
> Currently our CI is mostly restricted to Linux/X86.
> We want to have more, but until there we have to run these tests
> manually, which is why we didn't noticed earlier some tests are
> failing (on OSX, using --without-default-devices, ...).
>=20
> Tested on Linux/FreeBSD/OSX, X86/Aarch64.
>=20
> Regards,
>=20
> Phil.
>=20
> Supersedes: <20200122223247.30419-1-philmd@redhat.com>
> "tests/acceptance/virtio_seg_max_adjust: Restrict it to Linux/X86"
>=20
> Denis Plotnikov (1):
>    tests: rename virtio_seg_max_adjust to virtio_check_params
>=20
> Philippe Mathieu-Daud=C3=A9 (28):
>    hw/core: Allow setting 'virtio-blk-device.scsi' property on OSX host
>    accel/accel: Make TYPE_ACCEL abstract
>    python/qemu: Add binutils::binary_get_version()
>    tests/acceptance: Use 'version-min' tag to verify QEMU binary version
>    tests/acceptance: Restrict X86CPUModelAliases test to QEMU >=3D 4.1
>    python/qemu: Add binutils::binary_get_arch()
>    tests/acceptance: Use the 'arch' tag to verify QEMU binary target
>    python/qemu: Add binutils::binary_get_machines()
>    tests/acceptance: Use 'machine' tag to check if available in QEMU
>      binary
>    python/qemu: Add binutils::binary_get_qom_implementations()
>    python/qemu: Add binutils::binary_get_accels()
>    python/qemu/accel: Use binutils::binary_get_accels()
>    python/qemu: Add binutils::binary_get_devices()
>    tests/acceptance: Use 'device' tags to check availability in QEMU
>      binary
>    tests/acceptance/virtio_check_params: Only remove listed machines
>    tests/acceptance/virtio_check_params: Improve exception logging
>    tests/acceptance/virtio_check_params: List machine being tested
>    tests/acceptance/virtio_check_params: Only test Xen as superuser
>    tests/acceptance/virtio_check_params: Skip test if arch is not
>      supported
>    tests/acceptance/virtio_check_params: Kludge to skip tests on MIPS
>    tests/acceptance/virtio_check_params: Support the s390x architecture
>    tests/acceptance/virtio_check_params: Support the ppc architecture
>    tests/acceptance/virtio_check_params: Default to -nodefaults
>    tests/acceptance/virtio_check_params: Require a virtio-scsi-pci device
>    tests/acceptance/boot_linux_console: Do not use VGA on Clipper machine
>    tests/acceptance/migration: Default to -nodefaults
>    tests/acceptance/version: Default to -nodefaults
>    MAINTAINERS: Add Acceptance tests reviewers
>=20
>   accel/accel.c                                 |   1 +
>   hw/core/machine.c                             |   3 +-
>   MAINTAINERS                                   |   6 +
>   python/qemu/accel.py                          |  26 +----
>   python/qemu/binutils.py                       | 107 ++++++++++++++++++
>   tests/acceptance/avocado_qemu/__init__.py     |  51 ++++++++-
>   tests/acceptance/boot_linux_console.py        |   2 +-
>   tests/acceptance/core_scripts.py              |  79 +++++++++++++
>   tests/acceptance/migration.py                 |   4 +-
>   tests/acceptance/version.py                   |   1 +
>   ...g_max_adjust.py =3D> virtio_check_params.py} |  70 +++++++++---
>   tests/acceptance/x86_cpu_model_versions.py    |   1 +
>   12 files changed, 306 insertions(+), 45 deletions(-)
>   create mode 100644 python/qemu/binutils.py
>   create mode 100644 tests/acceptance/core_scripts.py
>   rename tests/acceptance/{virtio_seg_max_adjust.py =3D> virtio_check_par=
ams.py} (64%)
>=20


