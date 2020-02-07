Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4797BC04EB5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:12:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AB7F20838
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:12:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UtFpuNR9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AB7F20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j04Mv-0004bq-6d
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 09:12:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46473)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j04M4-0003QR-Op
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:11:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j04M3-0003U4-8J
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:11:36 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:50699
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j04M3-0003Tl-3n
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:11:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581084694;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CMJwCnQMMtDZ2xN1Oam2D6ILQ3ApDnbLf7j2mIL9jBc=;
 b=UtFpuNR9bxf9nvIj70R98miQK5E2vJaR0cktN1xUvtxgTzpIx8TGTKXSgMG2b/1MN5AeTL
 gE+pohkO0pv0nzOTTBQo/pOUPJucoJme54taehMsW/zfm1gdxuSlslZudcEE41N38T1epp
 b9iS38R8PmTnMI5GnMG4bU/tXFOuO5U=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-g30m7cdzPgq4u6j96Kp3Eg-1; Fri, 07 Feb 2020 09:11:27 -0500
Received: by mail-wr1-f71.google.com with SMTP id t3so1268873wrm.23
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 06:11:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=g7nVf2s1/3pbmvfdJ9NFjPcNGW4R6taN5BpO4j8u95s=;
 b=kehDoWog2D8nZX+1ZoAGLXMEVsrg3zxxf5jQVXw/IW+P0/YpQTMNlvk9Sn2WjxFynt
 1ZoMwobC9mcLqidFthtEUPZFThDRDdEvgUqjupyX2UHrEsE2DpQAbWUbrJrUDMR8uOLZ
 zttwQ7qoFYwqrHrLC/i1GzN5Dpzrz+W/1T4XfOWVLWgYSd+jJmSudW+2m6OYym3p2qn0
 1pp+OpaZOqN2i+ftcgZmTJgKjBz5+tLbIubdmbFkM2UEMmAWnIsWrnwcLj/vIy7Gr2xJ
 QB99/MUrzt/7QMkusJtZnPHvWUAfkfXuCE6sk0KQoUmAn2A38JDiTZIK/jykXHNnIHuC
 6JUg==
X-Gm-Message-State: APjAAAUzuo2L+3Egz3L85NuzpUb43zq0Yvr0rVlEVcPS2IsKAf8rRrPH
 2eccA/LGSPZqXaESc29TwVeGl4GaCQriYdWCnLCzBEQYUevqoDRFlGtoQS3X7LU+6iH2eqEMfjo
 jwnOaKxxaESXLRbg=
X-Received: by 2002:a1c:791a:: with SMTP id l26mr4674378wme.58.1581084686046; 
 Fri, 07 Feb 2020 06:11:26 -0800 (PST)
X-Google-Smtp-Source: APXvYqx6Yf/8wBKQyw2Hd94yD1shfnGMoIfuQSZN7ImOLkQ2sNJ3r5yA4gcan9wocWFN+Hb36qyGmQ==
X-Received: by 2002:a1c:791a:: with SMTP id l26mr4674356wme.58.1581084685722; 
 Fri, 07 Feb 2020 06:11:25 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id s16sm3658470wrn.78.2020.02.07.06.11.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Feb 2020 06:11:25 -0800 (PST)
Subject: Re: [PATCH] tests/acceptance/virtio_check_params: Disable test
To: Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-devel@nongnu.org
References: <20200206171715.25041-1-philmd@redhat.com>
 <e940c4ec-2cd8-17d0-5885-bed9823182f4@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2bdad61c-2a1e-e665-6018-76a34b6b7884@redhat.com>
Date: Fri, 7 Feb 2020 15:11:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <e940c4ec-2cd8-17d0-5885-bed9823182f4@redhat.com>
Content-Language: en-US
X-MC-Unique: g30m7cdzPgq4u6j96Kp3Eg-1
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
Cc: Cornelia Huck <cohuck@redhat.com>,
 Denis Plotnikov <dplotnikov@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/7/20 1:53 PM, Wainer dos Santos Moschetta wrote:
>=20
> On 2/6/20 3:17 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>> This test fails on various CI:
>=20
>=20
> What CI(s) you mean?
>=20
> Afaik the acceptance tests are executed only on Travis

AFAIK maintainers doesn't have to have all their tests public, but are=20
encouraged to share them.

Due to patches missing review by other maintainers, and getting merged=20
via other trees, I'm still waiting to post some of them (in particular=20
Cirrus-CI).

I run my tests on Linux (X86/Aarch64 always, PPC/S390X/MIPS often),=20
FreeBSD/OSX (X86).

Before disabling this test, I tried to fix it:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg675074.html
But got no review from the developers during 1 full week.
I am not removing the test, I am simply disabling it, until the=20
interested developers step in to fix it. I think I am being fair.

>=20
>>
>> - Using QEMU 4.0:
>>
>>   =20
>> tests/acceptance/x86_cpu_model_versions.py:X86CPUModelAliases.test_none_=
alias: =20
>> ERROR: 'alias-of' (0.45 s)
>>
>> - On OSX
>>
>> =C2=A0=C2=A0=C2=A0 Unexpected error in object_property_find() at qom/obj=
ect.c:1201:
>> =C2=A0=C2=A0=C2=A0 qemu-system-x86_64: -device virtio-blk-pci,id=3Dscsi0=
,drive=3Ddrive0:=20
>> can't apply global virtio-blk-device.scsi=3Dtrue: Property '.scsi' not=
=20
>> found
>>
>> - When removing unavailable machine:
>>
>> =C2=A0=C2=A0 VirtioMaxSegSettingsCheck.test_machine_types: ERROR:=20
>> list.remove(x): x not in list (0.12 s)
>>
>> - Using Xen:
>>
>> =C2=A0=C2=A0 xencall: error: Could not obtain handle on privileged comma=
nd=20
>> interface: No such file or directory
>> =C2=A0=C2=A0 xen be core: xen be core: can't open xen interface
>>
>> - On PPC:
>>
>> =C2=A0=C2=A0 TestFail: machine type pseries-2.8: No Transactional Memory=
 support=20
>> in TCG, try appending -machine cap-htm=3Doff
>>
>> - On S390X:
>>
>> =C2=A0=C2=A0 ERROR: qemu-system-s390x: -device virtio-scsi-pci,id=3Dscsi=
0:=20
>> 'virtio-scsi-pci' is not a valid device model name
>>
>> Disable it for now.
>>
>> Cc: Denis Plotnikov <dplotnikov@virtuozzo.com>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>> Series fixing the errors:
>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg675074.html
>> ---
>> =C2=A0 tests/acceptance/virtio_check_params.py | 2 ++
>=20
> Sorry, I'm a little lost here. I can't see=20
> tests/acceptance/virtio_check_params.py on master. Are you patching upon=
=20
> another series?

Based on the patches I extracted here:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg677487.html

>=20
> thanks,
>=20
> - Wainer
>=20
>> =C2=A0 1 file changed, 2 insertions(+)
>>
>> diff --git a/tests/acceptance/virtio_check_params.py=20
>> b/tests/acceptance/virtio_check_params.py
>> index d5f345f75e..87e6c839d1 100644
>> --- a/tests/acceptance/virtio_check_params.py
>> +++ b/tests/acceptance/virtio_check_params.py
>> @@ -25,6 +25,7 @@ import logging
>> =C2=A0 sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..=
',=20
>> 'python'))
>> =C2=A0 from qemu.machine import QEMUMachine
>> =C2=A0 from avocado_qemu import Test
>> +from avocado import skip
>> =C2=A0 #list of machine types and virtqueue properties to test
>> =C2=A0 VIRTIO_SCSI_PROPS =3D {'seg_max_adjust': 'seg_max_adjust'}
>> @@ -116,6 +117,7 @@ class VirtioMaxSegSettingsCheck(Test):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 return True
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return False
>> +=C2=A0=C2=A0=C2=A0 @skip("break multi-arch CI")
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 def test_machine_types(self):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # collect all mac=
hine types except 'none', 'isapc', 'microvm'
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 with QEMUMachine(=
self.qemu_bin) as vm:
>=20


