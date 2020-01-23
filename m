Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C6BC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 15:58:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3568A214AF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 15:58:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hO5frbCx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3568A214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iues7-0003Ar-R9
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 10:58:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48637)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1iucff-0005Ii-23
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:37:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1iucfc-0005WU-5F
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:37:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51770
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1iucfc-0005VM-1b
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:37:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579786635;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Mw7nZvFaWzDhHjWjW/hXLGY3g9G/m+tWwELCpw0u4oQ=;
 b=hO5frbCxIwSf/MgRyb7sT/uXt15/5eD3OQNUGNTHPG2Yr246qkQaKZ+2mB/oxFdXPIImAP
 xyQd48P2nx8T7O23wCV//NeX765xJVPWntFizQShrbQP25O0gXMpeU0jQfhf5ccE0ftURt
 1pi0aK4B8p/Vafr+1zTfPetd3EkuEn8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-79-nr7D_SI_Ns60twGKVpL-fw-1; Thu, 23 Jan 2020 08:37:13 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 90ED68017CC;
 Thu, 23 Jan 2020 13:37:12 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-27.gru2.redhat.com
 [10.97.116.27])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6B77A5D9E2;
 Thu, 23 Jan 2020 13:36:58 +0000 (UTC)
Subject: Re: [PATCH 5/6] tests/acceptance/virtio_seg_max_adjust: Restrict to
 X86 architecture
To: Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <20200122223247.30419-1-philmd@redhat.com>
 <20200122223247.30419-6-philmd@redhat.com>
 <20200123124844.32e2aa09.cohuck@redhat.com>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <814cb9da-696c-0716-c1fe-247fd4e6cb05@redhat.com>
Date: Thu, 23 Jan 2020 11:36:55 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200123124844.32e2aa09.cohuck@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: nr7D_SI_Ns60twGKVpL-fw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Denis Plotnikov <dplotnikov@virtuozzo.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 1/23/20 9:48 AM, Cornelia Huck wrote:
> On Wed, 22 Jan 2020 23:32:46 +0100
> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:
>
>> Running on mainstream KVM architectures, we get:
>>
>> - Aarch64
>>
>>    Timeout.
>>
>>    job.log:
>>    -------
>>    No machine specified, and there is no default
>>    Use -machine help to list supported machines
> The code probably needs to be made more clever to find the machines to
> run?
>
>> - MIPS:
>>
>>     (1/1) VirtioMaxSegSettingsCheck.test_machine_types: ERROR: argument =
of type 'NoneType' is not iterable (0.14 s)
>>
>>    job.log:
>>    -------
>>    Could not load MIPS bios 'mipsel_bios.bin', and no -kernel argument w=
as specified
> Probably needs some hint from mips folks how this can be set up.
>
>> - PowerPC
>>
>>     (1/1) VirtioMaxSegSettingsCheck.test_machine_types: ERROR: invalid l=
iteral for int() with base 10: 'sxxm' (0.16 s)
>>
>>    job.log:
>>    -------
>>    >>> {'execute': 'query-machines'}
>>    <<< {'return': [{'hotpluggable-cpus': True, 'name': 'pseries-2.12-sxx=
m', 'numa-mem-supported': True, 'default-cpu-type': 'power8_v2.0-powerpc64-=
cpu', 'cpu-max': 1024, 'deprecated': False}, ...
> This seems to be because the machine type parsing code cannot deal with
> the format used here.


Indeed, looking at the comments in code the parser was meant for PC types.

Is there a way to obtain the machine type version other than parsing its=20
name? If not, wouldn't be useful for management apps have that=20
information returned with 'query-machines'?

- Wainer

>> - S390X:
>>
>>     (1/1) VirtioMaxSegSettingsCheck.test_machine_types: ERROR: invalid l=
iteral for int() with base 10: 'virtio' (0.14 s)
>>
>>    job.log:
>>    -------
>>    Traceback (most recent call last):
>>      File "virtio_seg_max_adjust.py", line 139, in test_machine_types
>>        if self.seg_max_adjust_enabled(m):
>>      File "virtio_seg_max_adjust.py", line 113, in seg_max_adjust_enable=
d
>>        major =3D int(ver[0])
>>    ValueError: invalid literal for int() with base 10: 'virtio'
>>    >>> {'execute': 'query-machines'}
>>    <<< {'return': [{'hotpluggable-cpus': True, 'name': 's390-ccw-virtio-=
4.0', 'numa-mem-supported': False, 'default-cpu-type': 'qemu-s390x-cpu', 'c=
pu-max': 248, 'deprecated': False}, ...
> Same here.
>
>> Assuming this test is only expected to run on the X86 architecture,
>> restrict the test to this particular architecture.
>>
>> When this test is run on other architecture, the tests will be skipped.
>>
>> Examples:
>>
>> - running on S390X:
>>
>>   (1/1) tests/acceptance/virtio_seg_max_adjust.py:VirtioMaxSegSettingsCh=
eck.test_machine_types: SKIP: Architecture 's390' unsupported
>>
>> - running on Aarch64 setting the QEMU binary path:
>>
>>    $ uname -m && avocado --show=3Dapp run -p qemu_bin=3Dx86_64-softmmu/q=
emu-system-x86_64 tests/acceptance/virtio_seg_max_adjust.py
>>    aarch64
>>    JOB ID     : 92b7fae8868920aada0cb143f9571dffdf60931d
>>    JOB LOG    : job-results/job-2020-01-22T17.54-92b7fae/job.log
>>     (1/1) tests/acceptance/virtio_seg_max_adjust.py:VirtioMaxSegSettings=
Check.test_machine_types: PASS (25.99 s)
>>    RESULTS    : PASS 1 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT =
0 | CANCEL 0
>>    JOB TIME   : 26.13 s
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>>   tests/acceptance/virtio_seg_max_adjust.py | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/tests/acceptance/virtio_seg_max_adjust.py b/tests/acceptanc=
e/virtio_seg_max_adjust.py
>> index ad736bcda3..2fc6bfcbd8 100755
>> --- a/tests/acceptance/virtio_seg_max_adjust.py
>> +++ b/tests/acceptance/virtio_seg_max_adjust.py
>> @@ -26,6 +26,7 @@ import logging
>>   sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'p=
ython'))
>>   from qemu.machine import QEMUMachine
>>   from avocado_qemu import Test
>> +from avocado.core.exceptions import TestSkipError
>>  =20
>>   #list of machine types and virtqueue properties to test
>>   VIRTIO_SCSI_PROPS =3D {'seg_max_adjust': 'seg_max_adjust'}
>> @@ -117,12 +118,22 @@ class VirtioMaxSegSettingsCheck(Test):
>>           return False
>>  =20
>>       def test_machine_types(self):
>> +        """
>> +        :avocado: tags=3Darch:i386
>> +        :avocado: tags=3Darch:x86_64
>> +        """
>>           EXCLUDED_MACHINES =3D ['none', 'isapc', 'microvm']
>>           if os.geteuid() !=3D 0:
>>               EXCLUDED_MACHINES +=3D ['xenfv', 'xenpv']
>>           # collect all machine types except the ones in EXCLUDED_MACHIN=
ES
>>           with QEMUMachine(self.qemu_bin) as vm:
>>               vm.launch()
>> +            # Skip test if target is not X86
>> +            # TODO: Move this check to Avocado (based on the test tags)
>> +            target_arch =3D vm.command('query-target')['arch']
>> +            if target_arch not in ['i386', 'x86_64']:
>> +                errmsg =3D "Architecture '%s' unsupported" % target_arc=
h
>> +                raise TestSkipError(errmsg)
> I think we should rather fix the machine parsing code, and only then
> exclude architectures out of the box. (Sorry, my python-fu is lacking,
> or I would try it myself.)
>
> There does not seem to be anything that is really architecture specific
> in there. Just explicitly requesting the -pci versions of virtio-blk
> and virtio-scsi seems wrong, though, as this looks like a generic
> property, and should work on -ccw as well. (And probably also for
> virtio-mmio devices.) If not, I'd like to know :)
>
>>               machines =3D [m['name'] for m in vm.command('query-machine=
s')]
>>               vm.shutdown()
>>           for m in EXCLUDED_MACHINES:
>


