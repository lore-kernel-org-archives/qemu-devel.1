Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E32BCC10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 07:45:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADB652064A
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 07:45:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADB652064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60353 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEqsA-0004X7-0q
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 03:45:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36180)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hEqrM-0004AD-Pe
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 03:44:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hEqrL-0004QU-Pp
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 03:44:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37120)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1hEqrL-0004QG-It
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 03:44:27 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E12803007C2A;
	Fri, 12 Apr 2019 07:44:26 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-120-65.rdu2.redhat.com
	[10.10.120.65])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 864A05D6A6;
	Fri, 12 Apr 2019 07:44:23 +0000 (UTC)
To: "Singh, Brijesh" <brijesh.singh@amd.com>,
	Erik Skultety <eskultet@redhat.com>
References: <20190411175931.29235-1-brijesh.singh@amd.com>
	<61c415de-ac47-9818-2b06-b9e46445833f@redhat.com>
	<7d449ae2-6762-97c2-4930-358f34f3ef4b@amd.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <dbfe34c7-ef89-5d79-8a26-4483c9bf6ee7@redhat.com>
Date: Fri, 12 Apr 2019 09:44:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <7d449ae2-6762-97c2-4930-358f34f3ef4b@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.40]);
	Fri, 12 Apr 2019 07:44:26 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] target/i386: sev: add 'sev-max-guests'
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190412074422.ZZ4F2jKTJmbWtrbtY6XmJkwOe93N3fGYb8H7oaCmITc@z>

On 04/11/19 21:02, Singh, Brijesh wrote:
>=20
>=20
> On 4/11/19 1:10 PM, Laszlo Ersek wrote:
>> On 04/11/19 19:59, Singh, Brijesh wrote:
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
>>> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
>>> ---
>>>   qapi/target.json  | 6 ++++--
>>>   target/i386/sev.c | 6 ++++--
>>>   2 files changed, 8 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/qapi/target.json b/qapi/target.json
>>> index 1d4d54b600..b45121d30b 100644
>>> --- a/qapi/target.json
>>> +++ b/qapi/target.json
>>> @@ -183,7 +183,8 @@
>>>     'data': { 'pdh': 'str',
>>>               'cert-chain': 'str',
>>>               'cbitpos': 'int',
>>> -            'reduced-phys-bits': 'int'},
>>> +            'reduced-phys-bits': 'int',
>>> +            'sev-max-guests': 'int'},
>>
>> Would it be useful to make this new field optional? E.g. if it was
>> missing, libvirtd could assume "no limit".
>>
>=20
> I am not sure if we need to make this field optional - mainly because
> in SEV context hardware will always have some limits (at least in
> foreseeable future). The architecture provides us a CPUID to query
> this capabilities so I am assuming that future CPUs will populate
> some values in it.

Yup, sounds reasonable. Please resubmit with Daniel's request addressed
and I'll be happy to R-b.

Erik: can you please ACK too?

Thanks!
Laszlo

>> Again, not sure if that's useful, but it's not hard to introduce the
>> field as optional now. Removing mandatory fields later is impossible.
>>
>=20


