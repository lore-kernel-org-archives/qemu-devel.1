Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95214C10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 12:20:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A5352077C
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 12:20:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A5352077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35480 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEvA9-0004yE-D3
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 08:20:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hEv7Q-0003Cg-U5
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:17:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hEv7P-0004oc-1J
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:17:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60556)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1hEv7N-0004nu-9b
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:17:18 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9704E3001A84;
	Fri, 12 Apr 2019 12:17:16 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-120-65.rdu2.redhat.com
	[10.10.120.65])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2C4F25D6A9;
	Fri, 12 Apr 2019 12:17:13 +0000 (UTC)
To: Paolo Bonzini <pbonzini@redhat.com>,
	"Singh, Brijesh" <brijesh.singh@amd.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20190411235456.12918-1-brijesh.singh@amd.com>
	<74d884dd-3f3f-88d4-9f8b-62b696245fbc@redhat.com>
	<0db9a2c4-7153-6fb0-a15a-23e28c81669f@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <65ca8e09-d29d-8704-3a7a-8c6a3e03bd5c@redhat.com>
Date: Fri, 12 Apr 2019 14:17:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <0db9a2c4-7153-6fb0-a15a-23e28c81669f@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.45]);
	Fri, 12 Apr 2019 12:17:16 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2] target/i386: sev: add 'sev-max-guests'
 field to 'query-sev-capabilities'
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
	Markus Armbruster <armbru@redhat.com>, Erik Skultety <eskultet@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190412121713.Yb7zG1xJ8VBkKr0NMWuuLEmz33w7XGQH5xvo8l4ldKM@z>

On 04/12/19 10:05, Paolo Bonzini wrote:
> On 12/04/19 09:58, Laszlo Ersek wrote:
>> On 04/12/19 01:55, Singh, Brijesh wrote:
>>> There are limited numbers of the SEV guests that can be run concurren=
tly.
>>> A management applications may need to know this limit so that it can =
place
>>> SEV VMs on hosts which have suitable resources available.
>>>
>>> Currently, this limit is not exposed to the application. Add a new
>>> 'sev-max-guest' field in the query-sev-capabilities to provide this
>>> information.
>>>
>>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>>> Cc: Markus Armbruster <armbru@redhat.com>
>>> Cc: Eric Blake <eblake@redhat.com>
>>> Cc: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>>> Cc: Laszlo Ersek <lersek@redhat.com>
>>> Cc: Erik Skultety <eskultet@redhat.com>
>>> Cc: Tom Lendacky <Thomas.Lendacky@amd.com>
>>> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
>>> ---
>>>
>>> changes since v1:
>>>  - document the new field and add (since 4.1) annotation.
>>>
>>>  qapi/target.json  | 9 +++++++--
>>>  target/i386/sev.c | 9 +++++++--
>>>  2 files changed, 14 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/qapi/target.json b/qapi/target.json
>>> index 1d4d54b600..8cd4fc7919 100644
>>> --- a/qapi/target.json
>>> +++ b/qapi/target.json
>>> @@ -177,13 +177,17 @@
>>>  # @reduced-phys-bits: Number of physical Address bit reduction when =
SEV is
>>>  #                     enabled
>>>  #
>>> +# @sev-max-guests: maximum number of concurrent SEV guest with SEV-E=
S disabled
>>> +#                  (since 4.1)
>>> +#
>>>  # Since: 2.12
>>>  ##
>>>  { 'struct': 'SevCapability',
>>>    'data': { 'pdh': 'str',
>>>              'cert-chain': 'str',
>>>              'cbitpos': 'int',
>>> -            'reduced-phys-bits': 'int'},
>>> +            'reduced-phys-bits': 'int',
>>> +            'sev-max-guests': 'int'},
>>>    'if': 'defined(TARGET_I386)' }
>>> =20
>>>  ##
>>> @@ -200,7 +204,8 @@
>>>  #
>>>  # -> { "execute": "query-sev-capabilities" }
>>>  # <- { "return": { "pdh": "8CCDD8DDD", "cert-chain": "888CCCDDDEE",
>>> -#                  "cbitpos": 47, "reduced-phys-bits": 5}}
>>> +#                  "cbitpos": 47, "reduced-phys-bits": 5,
>>> +#                  "sev-max-guests" : 15}}
>>
>> There seems to be a superfluous space character before the colon, but =
I
>> don't think it matters much.
>>
>>>  #
>>>  ##
>>>  { 'command': 'query-sev-capabilities', 'returns': 'SevCapability',
>>> diff --git a/target/i386/sev.c b/target/i386/sev.c
>>> index cd77f6b5d4..6829586fbe 100644
>>> --- a/target/i386/sev.c
>>> +++ b/target/i386/sev.c
>>> @@ -488,7 +488,7 @@ sev_get_capabilities(void)
>>>      guchar *pdh_data =3D NULL;
>>>      guchar *cert_chain_data =3D NULL;
>>>      size_t pdh_len =3D 0, cert_chain_len =3D 0;
>>> -    uint32_t ebx;
>>> +    uint32_t ebx, ecx, edx;
>>>      int fd;
>>> =20
>>>      fd =3D open(DEFAULT_SEV_DEVICE, O_RDWR);
>>> @@ -507,7 +507,7 @@ sev_get_capabilities(void)
>>>      cap->pdh =3D g_base64_encode(pdh_data, pdh_len);
>>>      cap->cert_chain =3D g_base64_encode(cert_chain_data, cert_chain_=
len);
>>> =20
>>> -    host_cpuid(0x8000001F, 0, NULL, &ebx, NULL, NULL);
>>> +    host_cpuid(0x8000001F, 0, NULL, &ebx, &ecx, &edx);
>>>      cap->cbitpos =3D ebx & 0x3f;
>>> =20
>>>      /*
>>> @@ -516,6 +516,11 @@ sev_get_capabilities(void)
>>>       */
>>>      cap->reduced_phys_bits =3D 1;
>>> =20
>>> +    /*
>>> +     * The maximum number of SEV guests with SEV-ES disabled that ca=
n run
>>> +     * simultaneously.
>>> +     */
>>> +    cap->sev_max_guests =3D ecx - edx + 1;
>>>  out:
>>>      g_free(pdh_data);
>>>      g_free(cert_chain_data);
>>>
>>
>> Reviewed-by: Laszlo Ersek <lersek@redhat.com>
>=20
> As mentioned in v1, I don't think a management application should need
> to run QEMU in order to figure this out.

Sorry, I didn't mean to ignore your feedback; I hadn't seen it.

Thanks
Laszlo

