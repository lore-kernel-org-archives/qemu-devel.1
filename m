Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93AF0C10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 19:02:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60E3C2146F
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 19:02:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60E3C2146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53561 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEey5-0007ps-SI
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 15:02:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hEexD-0007Ye-E9
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 15:01:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hEexC-0007Xr-Da
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 15:01:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39754)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1hEexC-0007X0-6D
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 15:01:42 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D28383076C63;
	Thu, 11 Apr 2019 19:01:40 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-126-53.rdu2.redhat.com
	[10.10.126.53])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5BD4817A78;
	Thu, 11 Apr 2019 19:01:39 +0000 (UTC)
From: Laszlo Ersek <lersek@redhat.com>
To: "Singh, Brijesh" <brijesh.singh@amd.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20190411175931.29235-1-brijesh.singh@amd.com>
	<61c415de-ac47-9818-2b06-b9e46445833f@redhat.com>
Message-ID: <33d5a129-52d6-e9d6-6211-59e97aff975e@redhat.com>
Date: Thu, 11 Apr 2019 21:01:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <61c415de-ac47-9818-2b06-b9e46445833f@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.48]);
	Thu, 11 Apr 2019 19:01:40 +0000 (UTC)
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
	Erik Skultety <eskultet@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190411190138.7t73VywmRXqSl2lBrF0oqfyONUPCzh-o4lqVV3cy_5I@z>

On 04/11/19 20:10, Laszlo Ersek wrote:
> On 04/11/19 19:59, Singh, Brijesh wrote:
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
>> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
>> ---
>>  qapi/target.json  | 6 ++++--
>>  target/i386/sev.c | 6 ++++--
>>  2 files changed, 8 insertions(+), 4 deletions(-)
>>
>> diff --git a/qapi/target.json b/qapi/target.json
>> index 1d4d54b600..b45121d30b 100644
>> --- a/qapi/target.json
>> +++ b/qapi/target.json
>> @@ -183,7 +183,8 @@
>>    'data': { 'pdh': 'str',
>>              'cert-chain': 'str',
>>              'cbitpos': 'int',
>> -            'reduced-phys-bits': 'int'},
>> +            'reduced-phys-bits': 'int',
>> +            'sev-max-guests': 'int'},
>=20
> Would it be useful to make this new field optional? E.g. if it was
> missing, libvirtd could assume "no limit".
>=20
> Again, not sure if that's useful, but it's not hard to introduce the
> field as optional now. Removing mandatory fields later is impossible.

On second thought, if we're sure the hardware / encryption engine will
always have this kind of limitation, then mandatory looks fine.

Thanks
Laszlo

