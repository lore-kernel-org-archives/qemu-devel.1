Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB52EC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 14:44:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7438120704
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 14:44:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TnFuFqGK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7438120704
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iudiJ-0001yj-VQ
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 09:44:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55426)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1iubpm-0007Mt-Ay
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 07:43:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1iubpj-0006Cp-BH
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 07:43:42 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34262
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1iubpj-0006Ce-7W
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 07:43:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579783418;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V/tu+1YyqxXaE7x0X0Gbty/zVcG/b2NSnw9s41hKvac=;
 b=TnFuFqGK+o8Gbxq41pyfOLPUxtSeeUm/YszT9GVO2+y7tBZFANIc8/cYRhyoyr/xISI1Q3
 2Sb9neGmB40fwNjlctqZoYsbfmbcn6ILJ011SMnzbJ4lLVGkpTR4qQIxctbvq5KVL2lpf0
 96Lg+HoKDp+s9Nd8n74G6aPwkmLrr5Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-105-aeE1W7RFOWywdjfsQ24eaw-1; Thu, 23 Jan 2020 07:43:34 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0503818C43C1;
 Thu, 23 Jan 2020 12:43:33 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-27.gru2.redhat.com
 [10.97.116.27])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D15D98643E;
 Thu, 23 Jan 2020 12:43:19 +0000 (UTC)
Subject: Re: [PATCH v5 2/2] tests: add virtio-scsi and virtio-blk
 seg_max_adjust test
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org,
 ehabkost@redhat.com, mst@redhat.com, stefanha@redhat.com,
 Markus Armbruster <armbru@redhat.com>
References: <20191220140905.1718-1-dplotnikov@virtuozzo.com>
 <20191220140905.1718-3-dplotnikov@virtuozzo.com>
 <f36d9b80-68d5-016b-310d-44ae671ae68a@redhat.com>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <6bc3f161-8556-db42-e5b5-c4e2fed0f08d@redhat.com>
Date: Thu, 23 Jan 2020 10:43:17 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <f36d9b80-68d5-016b-310d-44ae671ae68a@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: aeE1W7RFOWywdjfsQ24eaw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
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
Cc: kwolf@redhat.com, fam@euphon.net, Hannes Reinecke <hare@suse.com>,
 den@virtuozzo.com, mreitz@redhat.com, Cleber Rosa <crosa@redhat.com>,
 pbonzini@redhat.com, Christoph Hellwig <hch@lst.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 1/22/20 6:56 PM, Philippe Mathieu-Daud=E9 wrote:
> Hello,
>
> On 12/20/19 3:09 PM, Denis Plotnikov wrote:
>> It tests proper seg_max_adjust settings for all machine types except
>> 'none', 'isapc', 'microvm'
>>
>> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
>> ---
>> =A0 tests/acceptance/virtio_seg_max_adjust.py | 134 ++++++++++++++++++++=
++
>> =A0 1 file changed, 134 insertions(+)
>> =A0 create mode 100755 tests/acceptance/virtio_seg_max_adjust.py
>>
>> diff --git a/tests/acceptance/virtio_seg_max_adjust.py=20
>> b/tests/acceptance/virtio_seg_max_adjust.py
>> new file mode 100755
>> index 0000000000..5458573138
>> --- /dev/null
>> +++ b/tests/acceptance/virtio_seg_max_adjust.py
>> @@ -0,0 +1,134 @@
>> +#!/usr/bin/env python
>> +#
>> +# Test virtio-scsi and virtio-blk queue settings for all machine types
>> +#
>> +# Copyright (c) 2019 Virtuozzo International GmbH
>> +#
>> +# This program is free software; you can redistribute it and/or modify
>> +# it under the terms of the GNU General Public License as published by
>> +# the Free Software Foundation; either version 2 of the License, or
>> +# (at your option) any later version.
>> +#
>> +# This program is distributed in the hope that it will be useful,
>> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
>> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=A0 See the
>> +# GNU General Public License for more details.
>> +#
>> +# You should have received a copy of the GNU General Public License
>> +# along with this program.=A0 If not, see <http://www.gnu.org/licenses/=
>.
>> +#
>> +
>> +import sys
>> +import os
>> +import re
>> +
>> +sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..',=20
>> 'python'))
>> +from qemu.machine import QEMUMachine
>> +from avocado_qemu import Test
>> +
>> +#list of machine types and virtqueue properties to test
>> +VIRTIO_SCSI_PROPS =3D {'seg_max_adjust': 'seg_max_adjust'}
>> +VIRTIO_BLK_PROPS =3D {'seg_max_adjust': 'seg-max-adjust'}
>> +
>> +DEV_TYPES =3D {'virtio-scsi-pci': VIRTIO_SCSI_PROPS,
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 'virtio-blk-pci': VIRTIO_BLK_PROPS=
}
>> +
>> +VM_DEV_PARAMS =3D {'virtio-scsi-pci': ['-device',=20
>> 'virtio-scsi-pci,id=3Dscsi0'],
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 'virtio-blk-pci': ['-d=
evice',
>> + 'virtio-blk-pci,id=3Dscsi0,drive=3Ddrive0',
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 '-drive',
>> + 'driver=3Dnull-co,id=3Ddrive0,if=3Dnone']}
>> +
>> +
>> +class VirtioMaxSegSettingsCheck(Test):
>> +=A0=A0=A0 @staticmethod
>> +=A0=A0=A0 def make_pattern(props):
>> +=A0=A0=A0=A0=A0=A0=A0 pattern_items =3D ['{0} =3D \w+'.format(prop) for=
 prop in props]
>> +=A0=A0=A0=A0=A0=A0=A0 return '|'.join(pattern_items)
>> +
>> +=A0=A0=A0 def query_virtqueue(self, vm, dev_type_name):
>> +=A0=A0=A0=A0=A0=A0=A0 query_ok =3D False
>> +=A0=A0=A0=A0=A0=A0=A0 error =3D None
>> +=A0=A0=A0=A0=A0=A0=A0 props =3D None
>> +
>> +=A0=A0=A0=A0=A0=A0=A0 output =3D vm.command('human-monitor-command',
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 command_line =3D 'info qtree')
>> +=A0=A0=A0=A0=A0=A0=A0 props_list =3D DEV_TYPES[dev_type_name].values();
>> +=A0=A0=A0=A0=A0=A0=A0 pattern =3D self.make_pattern(props_list)
>> +=A0=A0=A0=A0=A0=A0=A0 res =3D re.findall(pattern, output)
>> +
>> +=A0=A0=A0=A0=A0=A0=A0 if len(res) !=3D len(props_list):
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 props_list =3D set(props_list)
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 res =3D set(res)
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 not_found =3D props_list.difference(r=
es)
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 not_found =3D ', '.join(not_found)
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 error =3D '({0}): The following prope=
rties not found: {1}'\
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .format(de=
v_type_name, not_found)
>> +=A0=A0=A0=A0=A0=A0=A0 else:
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 query_ok =3D True
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 props =3D dict()
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 for prop in res:
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 p =3D prop.split(' =3D ')
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 props[p[0]] =3D p[1]
>> +=A0=A0=A0=A0=A0=A0=A0 return query_ok, props, error
>> +
>> +=A0=A0=A0 def check_mt(self, mt, dev_type_name):
>> +=A0=A0=A0=A0=A0=A0=A0 with QEMUMachine(self.qemu_bin) as vm:
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 vm.set_machine(mt["name"])
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 for s in VM_DEV_PARAMS[dev_type_name]=
:
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 vm.add_args(s)
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 vm.launch()
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 query_ok, props, error =3D self.query=
_virtqueue(vm,=20
>> dev_type_name)
>> +
>> +=A0=A0=A0=A0=A0=A0=A0 if not query_ok:
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 self.fail('machine type {0}: {1}'.for=
mat(mt['name'],=20
>> error))
>> +
>> +=A0=A0=A0=A0=A0=A0=A0 for prop_name, prop_val in props.items():
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 expected_val =3D mt[prop_name]
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 self.assertEqual(expected_val, prop_v=
al)
>> +
>> +=A0=A0=A0 @staticmethod
>> +=A0=A0=A0 def seg_max_adjust_enabled(mt):
>> +=A0=A0=A0=A0=A0=A0=A0 # machine types >=3D 5.0 should have seg_max_adju=
st =3D true
>> +=A0=A0=A0=A0=A0=A0=A0 # others seg_max_adjust =3D false
>> +=A0=A0=A0=A0=A0=A0=A0 mt =3D mt.split("-")
>> +
>> +=A0=A0=A0=A0=A0=A0=A0 # machine types with one line name and name like =
pc-x.x
>> +=A0=A0=A0=A0=A0=A0=A0 if len(mt) <=3D 2:
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return False
>> +
>> +=A0=A0=A0=A0=A0=A0=A0 # machine types like pc-<chip_name>-x.x[.x]
>> +=A0=A0=A0=A0=A0=A0=A0 ver =3D mt[2]
>> +=A0=A0=A0=A0=A0=A0=A0 ver =3D ver.split(".");
>> +
>> +=A0=A0=A0=A0=A0=A0=A0 # versions >=3D 5.0 goes with seg_max_adjust enab=
led
>> +=A0=A0=A0=A0=A0=A0=A0 major =3D int(ver[0])
>> +
>> +=A0=A0=A0=A0=A0=A0=A0 if major >=3D 5:
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return True
>> +=A0=A0=A0=A0=A0=A0=A0 return False
>> +
>> +=A0=A0=A0 def test_machine_types(self):
>> +=A0=A0=A0=A0=A0=A0=A0 # collect all machine types except 'none', 'isapc=
', 'microvm'
>> +=A0=A0=A0=A0=A0=A0=A0 with QEMUMachine(self.qemu_bin) as vm:
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 vm.launch()
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 machines =3D [m['name'] for m in=20
>> vm.command('query-machines')]
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 vm.shutdown()
>> +=A0=A0=A0=A0=A0=A0=A0 machines.remove('none')
>> +=A0=A0=A0=A0=A0=A0=A0 machines.remove('isapc')
>> +=A0=A0=A0=A0=A0=A0=A0 machines.remove('microvm')
>> +
>> +=A0=A0=A0=A0=A0=A0=A0 for dev_type in DEV_TYPES:
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 # create the list of machine types an=
d their parameters.
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 mtypes =3D list()
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 for m in machines:
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if self.seg_max_adjust_en=
abled(m):
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 enabled =3D '=
true'
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 else:
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 enabled =3D '=
false'
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 mtypes.append({'name': m,
>> + DEV_TYPES[dev_type]['seg_max_adjust']: enabled})
>> +
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 # test each machine type for a device=
 type
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 for mt in mtypes:
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 self.check_mt(mt, dev_typ=
e)
>
> This test is failing on OSX:

Kind related...

Just yesterday I found a bug on the test case code itself that makes it=20
fail on ppc64le (likely to fail on other arches). I'm working on a fix.

- Wainer

>
> TestFail: machine type pc-i440fx-2.0: <class 'TypeError'>
>
> Looking at my job-results/job-2020-01-22T17.54-92b7fae/job.log:
>
> Unexpected error in object_property_find() at qom/object.c:1201:
> qemu-system-x86_64: -device virtio-blk-pci,id=3Dscsi0,drive=3Ddrive0:=20
> can't apply global virtio-blk-device.scsi=3Dtrue: Property '.scsi' not=20
> found
>
> Which makes sense looking at hw/block/virtio-blk.c:
>
> 1261 static Property virtio_blk_properties[] =3D {
> 1262=A0=A0=A0=A0 DEFINE_BLOCK_PROPERTIES(VirtIOBlock, conf.conf),
> ...
> 1268 #ifdef __linux__
> 1269=A0=A0=A0=A0 DEFINE_PROP_BIT64("scsi", VirtIOBlock, host_features,
> 1270=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 VI=
RTIO_BLK_F_SCSI, false),
> 1271 #endif
>
> Except code moved around, origin is:
>
> $ git show 1063b8b15
> commit 1063b8b15fb49fcf88ffa282b19aaaf7ca9c678c
> Author: Christoph Hellwig <hch@lst.de>
> Date:=A0=A0 Mon Apr 27 10:29:14 2009 +0200
>
> =A0=A0=A0 virtio-blk: add SGI_IO passthru support
>
> =A0=A0=A0 Add support for SG_IO passthru (packet commands) to the virtio-=
blk
> =A0=A0=A0 backend.=A0 Conceptually based on an older patch from Hannes Re=
inecke
> =A0=A0=A0 but largely rewritten to match the code structure and layering =
in
> =A0=A0=A0 virtio-blk.
>
> =A0=A0=A0 Note that currently we issue the hose SG_IO synchronously.=A0 W=
e could
> =A0=A0=A0 easily switch to async I/O, but that would required either bloa=
ting
> =A0=A0=A0 the VirtIOBlockReq by the size of struct sg_io_hdr or an additi=
onal
> =A0=A0=A0 memory allocation for each SG_IO request.
>
> I'm not sure what is the correct way to fix this.
>
> Regards,
>
> Phil.
>
>


