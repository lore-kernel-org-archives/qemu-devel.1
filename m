Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06EFCC35247
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 19:19:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C49322086A
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 19:18:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NJiEiYeX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C49322086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyhFL-00050s-1g
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 14:18:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39719)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1iyhES-0004Z2-2U
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 14:18:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1iyhEP-0007RH-Gb
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 14:18:02 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:26067
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1iyhEP-0007Ml-BM
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 14:18:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580757479;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VLnmFirfaVSu/a117KGvJvlgHymIz/mmfh2GsWlYXjo=;
 b=NJiEiYeX5HMSSjTqQXIHm5C8ep+3Q3bxKukUOZAWnonkHO4puaahbODB8ePr7rmsA91tRW
 RMQDWQPWAK4JmmCZktsHG+/0TVfRmybioNx8Q6+M759uq9oNqXOJrNe/AKtRDhSVR7Z4Lr
 DNE0Lvj2PMcZKI2KxJBMGG0Q5w9RjWo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-242-sfxP3_6HMiitG2oAHnDURg-1; Mon, 03 Feb 2020 14:17:56 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 441B3477;
 Mon,  3 Feb 2020 19:17:55 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-90.gru2.redhat.com
 [10.97.116.90])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EC2E45D9CA;
 Mon,  3 Feb 2020 19:17:50 +0000 (UTC)
Subject: Re: [PATCH v2 03/29] python/qemu: Add binutils::binary_get_version()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org
References: <20200129212345.20547-1-philmd@redhat.com>
 <20200129212345.20547-4-philmd@redhat.com>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <cfec25d9-95c4-18e9-f4e1-d087a7bc5a2e@redhat.com>
Date: Mon, 3 Feb 2020 17:17:49 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200129212345.20547-4-philmd@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: sfxP3_6HMiitG2oAHnDURg-1
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
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 1/29/20 7:23 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Add a helper to query the version of a QEMU binary.
> We simply send the 'query-version' command over a QMP
> socket.
> Introduce the PythonQemuCoreScripts class to test our
> new helper.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>   python/qemu/binutils.py          | 38 ++++++++++++++++++++++++++++++++

I'm not sure about creating the file with that name, it reminds me to=20
GNU Binutils rather than the QEMU binary. :)

Perhaps it could be named qemu_bin.py?

Another suggestion is to encapsulate the methods you propose in this=20
series in an object. For example:

class QEMUBin:
 =C2=A0=C2=A0=C2=A0 def __init__(self, bin_path):
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # Check bin exists.
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.bin_path =3D bin_path

 =C2=A0=C2=A0=C2=A0 def get_version(self):
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # binutils.binary_get_version()=
 goes here.
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pass

 =C2=A0=C2=A0=C2=A0 def get_arch(self):
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # binutils.binary_get_arch() go=
es here.
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pass

 =C2=A0=C2=A0=C2=A0 def list_accel(self):
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # move accel.list_accel() metho=
d to here.
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pass

 =C2=A0=C2=A0=C2=A0 def get_vm(self, args):
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # Return an QEMUMachine object.=
..
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return QEMUMachine(self.bin_pat=
h, *args)

 =C2=A0=C2=A0=C2=A0 def get_build_config_host(self):
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # Detect if self.bin_path is in=
 a build directory,
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # attempt to read the host-conf=
ig.mak and return
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # as hash. Or fail...
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pass


>   tests/acceptance/core_scripts.py | 31 ++++++++++++++++++++++++++
>   2 files changed, 69 insertions(+)
>   create mode 100644 python/qemu/binutils.py
>   create mode 100644 tests/acceptance/core_scripts.py
>
> diff --git a/python/qemu/binutils.py b/python/qemu/binutils.py
> new file mode 100644
> index 0000000000..96b200eef4
> --- /dev/null
> +++ b/python/qemu/binutils.py
> @@ -0,0 +1,38 @@
> +"""
> +QEMU binary utility module:
> +
> +The binary utility module provides helpers to query QEMU binary for
> +build-dependent configuration options at runtime.
> +"""
> +#
> +# Copyright (c) 2020 Red Hat, Inc.
> +#
> +# Author:
> +#  Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2 or lat=
er.
> +# See the COPYING file in the top-level directory.
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +import logging
> +
> +from .machine import QEMUMachine
> +
> +LOG =3D logging.getLogger(__name__)
> +
> +
> +def binary_get_version(qemu_bin):
> +    '''
> +    Get QEMU binary version
> +
> +    @param qemu_bin (str): path to the QEMU binary

It could check that qemu_bin file exists, otherwise raise an exception=20
or return None.

> +    @return binary version (dictionary with major/minor/micro keys)
> +    '''
> +    with QEMUMachine(qemu_bin) as vm:
> +        vm.set_machine('none')
> +        vm.launch()
> +        res =3D vm.command('query-version')
> +        LOG.info(res)
> +        vm.shutdown()

Don't need this, the vm will be shutdown anyway (see QEMUMachine.__exit__()=
)

Thanks!

- Wainer


> +        return res['qemu']
> diff --git a/tests/acceptance/core_scripts.py b/tests/acceptance/core_scr=
ipts.py
> new file mode 100644
> index 0000000000..3f253337cd
> --- /dev/null
> +++ b/tests/acceptance/core_scripts.py
> @@ -0,0 +1,31 @@
> +# Tests covering various python/qemu/ scripts
> +#
> +# Copyright (c) 2020 Red Hat, Inc.
> +#
> +# Author:
> +#  Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2 or lat=
er.
> +# See the COPYING file in the top-level directory.
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +import sys
> +import os
> +import logging
> +
> +sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'pyt=
hon'))
> +from avocado_qemu import Test
> +from qemu.binutils import binary_get_version
> +
> +
> +class PythonQemuCoreScripts(Test):
> +
> +    def test_get_version(self):
> +        logger =3D logging.getLogger('core')
> +        version =3D binary_get_version(self.qemu_bin)
> +        logger.debug('version: {}'.format(version))
> +        # QMP 'query-version' introduced with QEMU v0.14
> +        self.assertGreaterEqual(version['major'], 0)
> +        if version['major'] =3D=3D 0:
> +            self.assertGreaterEqual(version['minor'], 14)


