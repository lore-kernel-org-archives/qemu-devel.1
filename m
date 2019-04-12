Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB49C10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 08:07:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB96B20651
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 08:07:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB96B20651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60589 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hErDX-0006mC-6G
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 04:07:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hErBr-0005Hw-OM
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 04:05:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hErBp-0000Sh-Sj
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 04:05:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44022)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hErBk-0000PS-DK
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 04:05:34 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 357EA30842B2;
	Fri, 12 Apr 2019 08:05:31 +0000 (UTC)
Received: from [10.36.112.36] (ovpn-112-36.ams2.redhat.com [10.36.112.36])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 2128D22708;
	Fri, 12 Apr 2019 08:05:25 +0000 (UTC)
To: Laszlo Ersek <lersek@redhat.com>, "Singh, Brijesh"
	<brijesh.singh@amd.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20190411235456.12918-1-brijesh.singh@amd.com>
	<74d884dd-3f3f-88d4-9f8b-62b696245fbc@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=pbonzini@redhat.com; prefer-encrypt=mutual; keydata=
	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
	uUHgL9dKIfvpm+rNXRn9wAwGjk0X/A==
Message-ID: <0db9a2c4-7153-6fb0-a15a-23e28c81669f@redhat.com>
Date: Fri, 12 Apr 2019 10:05:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <74d884dd-3f3f-88d4-9f8b-62b696245fbc@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.40]);
	Fri, 12 Apr 2019 08:05:31 +0000 (UTC)
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
Message-ID: <20190412080523.rg5C8TR-uVPImjX6eYORHPMdR0XzJYwCpc-0AXZ2MV4@z>

On 12/04/19 09:58, Laszlo Ersek wrote:
> On 04/12/19 01:55, Singh, Brijesh wrote:
>> There are limited numbers of the SEV guests that can be run concurrent=
ly.
>> A management applications may need to know this limit so that it can p=
lace
>> SEV VMs on hosts which have suitable resources available.
>>
>> Currently, this limit is not exposed to the application. Add a new
>> 'sev-max-guest' field in the query-sev-capabilities to provide this
>> information.
>>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: Markus Armbruster <armbru@redhat.com>
>> Cc: Eric Blake <eblake@redhat.com>
>> Cc: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>> Cc: Laszlo Ersek <lersek@redhat.com>
>> Cc: Erik Skultety <eskultet@redhat.com>
>> Cc: Tom Lendacky <Thomas.Lendacky@amd.com>
>> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
>> ---
>>
>> changes since v1:
>>  - document the new field and add (since 4.1) annotation.
>>
>>  qapi/target.json  | 9 +++++++--
>>  target/i386/sev.c | 9 +++++++--
>>  2 files changed, 14 insertions(+), 4 deletions(-)
>>
>> diff --git a/qapi/target.json b/qapi/target.json
>> index 1d4d54b600..8cd4fc7919 100644
>> --- a/qapi/target.json
>> +++ b/qapi/target.json
>> @@ -177,13 +177,17 @@
>>  # @reduced-phys-bits: Number of physical Address bit reduction when S=
EV is
>>  #                     enabled
>>  #
>> +# @sev-max-guests: maximum number of concurrent SEV guest with SEV-ES=
 disabled
>> +#                  (since 4.1)
>> +#
>>  # Since: 2.12
>>  ##
>>  { 'struct': 'SevCapability',
>>    'data': { 'pdh': 'str',
>>              'cert-chain': 'str',
>>              'cbitpos': 'int',
>> -            'reduced-phys-bits': 'int'},
>> +            'reduced-phys-bits': 'int',
>> +            'sev-max-guests': 'int'},
>>    'if': 'defined(TARGET_I386)' }
>> =20
>>  ##
>> @@ -200,7 +204,8 @@
>>  #
>>  # -> { "execute": "query-sev-capabilities" }
>>  # <- { "return": { "pdh": "8CCDD8DDD", "cert-chain": "888CCCDDDEE",
>> -#                  "cbitpos": 47, "reduced-phys-bits": 5}}
>> +#                  "cbitpos": 47, "reduced-phys-bits": 5,
>> +#                  "sev-max-guests" : 15}}
>=20
> There seems to be a superfluous space character before the colon, but I
> don't think it matters much.
>=20
>>  #
>>  ##
>>  { 'command': 'query-sev-capabilities', 'returns': 'SevCapability',
>> diff --git a/target/i386/sev.c b/target/i386/sev.c
>> index cd77f6b5d4..6829586fbe 100644
>> --- a/target/i386/sev.c
>> +++ b/target/i386/sev.c
>> @@ -488,7 +488,7 @@ sev_get_capabilities(void)
>>      guchar *pdh_data =3D NULL;
>>      guchar *cert_chain_data =3D NULL;
>>      size_t pdh_len =3D 0, cert_chain_len =3D 0;
>> -    uint32_t ebx;
>> +    uint32_t ebx, ecx, edx;
>>      int fd;
>> =20
>>      fd =3D open(DEFAULT_SEV_DEVICE, O_RDWR);
>> @@ -507,7 +507,7 @@ sev_get_capabilities(void)
>>      cap->pdh =3D g_base64_encode(pdh_data, pdh_len);
>>      cap->cert_chain =3D g_base64_encode(cert_chain_data, cert_chain_l=
en);
>> =20
>> -    host_cpuid(0x8000001F, 0, NULL, &ebx, NULL, NULL);
>> +    host_cpuid(0x8000001F, 0, NULL, &ebx, &ecx, &edx);
>>      cap->cbitpos =3D ebx & 0x3f;
>> =20
>>      /*
>> @@ -516,6 +516,11 @@ sev_get_capabilities(void)
>>       */
>>      cap->reduced_phys_bits =3D 1;
>> =20
>> +    /*
>> +     * The maximum number of SEV guests with SEV-ES disabled that can=
 run
>> +     * simultaneously.
>> +     */
>> +    cap->sev_max_guests =3D ecx - edx + 1;
>>  out:
>>      g_free(pdh_data);
>>      g_free(cert_chain_data);
>>
>=20
> Reviewed-by: Laszlo Ersek <lersek@redhat.com>

As mentioned in v1, I don't think a management application should need
to run QEMU in order to figure this out.

Paolo

