Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51FE6C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 18:31:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E68E20679
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 18:31:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T96Bdefy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E68E20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSmY3-0006oj-V4
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 13:30:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35367)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1iSmX0-00064T-Bb
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 13:29:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1iSmWx-0001lZ-7g
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 13:29:16 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:38321
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1iSmWx-0001ki-3d
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 13:29:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573151354;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KIEr/2Xz1X+YbHl8yLPshQ/EqBiO6Xx+/q/m2LF+avw=;
 b=T96Bdefy0PMBd3zLzB9y6YA6LHkOn41OxdVI14c8P4sFzvWoedc/JhEazV0g2lqnAUyRRf
 x2orlYfyxtimRpFhlv8cyHoNMd37s00pgOPNbXjoqUdpjtqv4Sl+1HCzPuM7v9PXwU6+lP
 vfetq1FF5DSM0pRI6kv6uli6vxoyeWY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-rxS-uO1DMdStR09sui2ObQ-1; Thu, 07 Nov 2019 13:29:10 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5D336800C61;
 Thu,  7 Nov 2019 18:29:09 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-91.gru2.redhat.com
 [10.97.116.91])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D0214608B2;
 Thu,  7 Nov 2019 18:29:04 +0000 (UTC)
Subject: Re: [PATCH 2/3] Acceptance tests: introduce utility method for tags
 unique vals
To: qemu-devel@nongnu.org
References: <20190924194501.9303-1-crosa@redhat.com>
 <20190924194501.9303-3-crosa@redhat.com>
 <53219208-0345-cba4-0482-aea085bca6c0@redhat.com>
 <20191028230259.GA6770@localhost.localdomain>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <9a7e3c76-1b35-1260-d798-280981520f11@redhat.com>
Date: Thu, 7 Nov 2019 16:29:03 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20191028230259.GA6770@localhost.localdomain>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: rxS-uO1DMdStR09sui2ObQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>,
 Willian Rampazzo <wrampazz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 10/28/19 8:02 PM, Cleber Rosa wrote:
> On Thu, Oct 24, 2019 at 06:12:25PM -0300, Wainer dos Santos Moschetta wro=
te:
>> Hi Cleber,
>>
>> On 9/24/19 4:45 PM, Cleber Rosa wrote:
>>> Currently a test can describe the target architecture binary that it
>>> should primarily be run with, be setting a single tag value.
>>>
>>> The same approach is expected to be done with other QEMU aspects to be
>>> tested, for instance, the machine type and accelerator, so let's
>>> generalize the logic into a utility method.
>>>
>>> Signed-off-by: Cleber Rosa <crosa@redhat.com>
>>> ---
>>>    tests/acceptance/avocado_qemu/__init__.py | 19 +++++++++++++------
>>>    1 file changed, 13 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptan=
ce/avocado_qemu/__init__.py
>>> index bd41e0443c..02775bafcf 100644
>>> --- a/tests/acceptance/avocado_qemu/__init__.py
>>> +++ b/tests/acceptance/avocado_qemu/__init__.py
>>> @@ -54,14 +54,21 @@ def pick_default_qemu_bin(arch=3DNone):
>>>    class Test(avocado.Test):
>>> +    def _get_unique_tag_val(self, tag_name):
>>> +        """
>>> +        Gets a tag value, if unique for a key
>>> +        """
>>> +        vals =3D self.tags.get(tag_name, [])
>>> +        if len(vals) =3D=3D 1:
>>
>> An small optimization:
>>
>> if vals:
>>
>>  =A0 return vals.pop()
>>
> IIUC, this would break the idea of uniqueness that this method, for
> now, has.  Read on.
>
>>> +            return vals.pop()
>>> +        return None
>> Does it allows to express a scenario like "I want my test method to run =
on
>> x86_64 and aarch64" using tags? If so, _get_unique_tag_val logic returns
>> None for multi-value tags (e.g. 'tags=3Darch:x86_64,arch:aarch64').
>>
> I thought that initially we should attempt to pick a default arch or
> machine type only of len(vals) =3D=3D 1.  Not because what you describe
> can't be done, but because I would like to go through the tests and
> make sure we run them in all the given tagged arches when we allow
> that.

Ok, understood the rationale now.

Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>

>
> Thanks,
> - Cleber.
>
>> Thanks,
>>
>> Wainer
>>
>>> +
>>>        def setUp(self):
>>>            self._vms =3D {}
>>> -        arches =3D self.tags.get('arch', [])
>>> -        if len(arches) =3D=3D 1:
>>> -            arch =3D arches.pop()
>>> -        else:
>>> -            arch =3D None
>>> -        self.arch =3D self.params.get('arch', default=3Darch)
>>> +
>>> +        self.arch =3D self.params.get('arch',
>>> +                                    default=3Dself._get_unique_tag_val=
('arch'))
>>> +
>>>            default_qemu_bin =3D pick_default_qemu_bin(arch=3Dself.arch)
>>>            self.qemu_bin =3D self.params.get('qemu_bin',
>>>                                            default=3Ddefault_qemu_bin)
>


