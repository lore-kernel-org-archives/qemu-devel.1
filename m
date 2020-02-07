Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B83E7C352A2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 12:54:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 852C320838
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 12:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H4Jq2NsE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 852C320838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j039e-0001fq-Nj
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 07:54:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50743)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1j0392-0001EZ-0S
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 07:54:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1j038w-0003Gu-V9
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 07:54:03 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52582
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1j038w-0003Gc-RE
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 07:53:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581080038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+GBhiUX+g/xkKHT5O1klCArSTKWKyROuvgH3VpSSfY8=;
 b=H4Jq2NsE1q2lSecMYfWVjuzf8cq1DENwDP8dxghn368UJPcrxoYptn/Z349zThIShDQjOV
 4n7KQxhnnp1jXM/kUsU/0HEe6AV8eSWmitzoepylexQCghNZMTFcWRgW5QqOUBFqRYQ7qt
 V+3fpcE7k3UbfRtSrBLxizpcilT3pEU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-0fbX81_bPmKRrM5BA7AjzQ-1; Fri, 07 Feb 2020 07:53:54 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8EA07101FC60;
 Fri,  7 Feb 2020 12:53:53 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-96.gru2.redhat.com
 [10.97.116.96])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 031A860BEC;
 Fri,  7 Feb 2020 12:53:47 +0000 (UTC)
Subject: Re: [PATCH] tests/acceptance/virtio_check_params: Disable test
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200206171715.25041-1-philmd@redhat.com>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <e940c4ec-2cd8-17d0-5885-bed9823182f4@redhat.com>
Date: Fri, 7 Feb 2020 10:53:44 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200206171715.25041-1-philmd@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 0fbX81_bPmKRrM5BA7AjzQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: Cornelia Huck <cohuck@redhat.com>,
 Denis Plotnikov <dplotnikov@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2/6/20 3:17 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> This test fails on various CI:


What CI(s) you mean?

Afaik the acceptance tests are executed only on Travis


>
> - Using QEMU 4.0:
>
>    tests/acceptance/x86_cpu_model_versions.py:X86CPUModelAliases.test_non=
e_alias:  ERROR: 'alias-of' (0.45 s)
>
> - On OSX
>
>     Unexpected error in object_property_find() at qom/object.c:1201:
>     qemu-system-x86_64: -device virtio-blk-pci,id=3Dscsi0,drive=3Ddrive0:=
 can't apply global virtio-blk-device.scsi=3Dtrue: Property '.scsi' not fou=
nd
>
> - When removing unavailable machine:
>
>    VirtioMaxSegSettingsCheck.test_machine_types: ERROR: list.remove(x): x=
 not in list (0.12 s)
>
> - Using Xen:
>
>    xencall: error: Could not obtain handle on privileged command interfac=
e: No such file or directory
>    xen be core: xen be core: can't open xen interface
>
> - On PPC:
>
>    TestFail: machine type pseries-2.8: No Transactional Memory support in=
 TCG, try appending -machine cap-htm=3Doff
>
> - On S390X:
>
>    ERROR: qemu-system-s390x: -device virtio-scsi-pci,id=3Dscsi0: 'virtio-=
scsi-pci' is not a valid device model name
>
> Disable it for now.
>
> Cc: Denis Plotnikov <dplotnikov@virtuozzo.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> Series fixing the errors:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg675074.html
> ---
>   tests/acceptance/virtio_check_params.py | 2 ++

Sorry, I'm a little lost here. I can't see=20
tests/acceptance/virtio_check_params.py on master. Are you patching upon=20
another series?

thanks,

- Wainer

>   1 file changed, 2 insertions(+)
>
> diff --git a/tests/acceptance/virtio_check_params.py b/tests/acceptance/v=
irtio_check_params.py
> index d5f345f75e..87e6c839d1 100644
> --- a/tests/acceptance/virtio_check_params.py
> +++ b/tests/acceptance/virtio_check_params.py
> @@ -25,6 +25,7 @@ import logging
>   sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'py=
thon'))
>   from qemu.machine import QEMUMachine
>   from avocado_qemu import Test
> +from avocado import skip
>  =20
>   #list of machine types and virtqueue properties to test
>   VIRTIO_SCSI_PROPS =3D {'seg_max_adjust': 'seg_max_adjust'}
> @@ -116,6 +117,7 @@ class VirtioMaxSegSettingsCheck(Test):
>               return True
>           return False
>  =20
> +    @skip("break multi-arch CI")
>       def test_machine_types(self):
>           # collect all machine types except 'none', 'isapc', 'microvm'
>           with QEMUMachine(self.qemu_bin) as vm:


