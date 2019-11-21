Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 302FCC432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 13:14:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBBA020731
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 13:14:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZcBMUAeu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBBA020731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXmHz-0003hC-3U
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 08:14:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55135)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iXmG9-0002fm-80
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 08:12:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iXmG7-0002ke-30
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 08:12:32 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:38372
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iXmG6-0002kK-T6
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 08:12:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574341950;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fWgQBR+ahmQqQNr9WbxlVV8UsNchhmdqigeJ0RscuU8=;
 b=ZcBMUAeuLs1PR0UGar7MenJPlPkN0jirvWchWmQSWv3LkHz8ti/YglT5pEAs8eCN0N0z27
 Iu0AitP3liUuSaNYDAxFzeR+MKWC87r/E7TKvSdBOoQrsjoBqEyqF/ruUxPdwNoiJJFXuU
 rnOwuzpI+Yd7fAAqwEgYbyNCUfxAvmw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-404-v8KWSAlPOsCRvX5BAeNfwg-1; Thu, 21 Nov 2019 08:12:27 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AA57D802692;
 Thu, 21 Nov 2019 13:12:25 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-86.ams2.redhat.com
 [10.36.116.86])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 95010692B1;
 Thu, 21 Nov 2019 13:12:21 +0000 (UTC)
Subject: Re: [PATCH 02/15] s390x: Beautify diag308 handling
To: David Hildenbrand <david@redhat.com>,
 Janosch Frank <frankja@linux.ibm.com>, qemu-devel@nongnu.org
References: <20191120114334.2287-1-frankja@linux.ibm.com>
 <20191120114334.2287-3-frankja@linux.ibm.com>
 <f4eca3d1-f5ac-8d5a-5b30-4a15a5987358@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <4eab8861-904b-10c6-9ed9-9819c2bc3a37@redhat.com>
Date: Thu, 21 Nov 2019 14:12:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <f4eca3d1-f5ac-8d5a-5b30-4a15a5987358@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: v8KWSAlPOsCRvX5BAeNfwg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, mihajlov@linux.ibm.com,
 pmorel@linux.ibm.com, cohuck@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21/11/2019 12.21, David Hildenbrand wrote:
> On 20.11.19 12:43, Janosch Frank wrote:
>> Let's improve readability by:
>> * Using constants for the subcodes
>> * Moving parameter checking into a function
>> * Removing subcode > 6 check as the default case catches that
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>> =A0 target/s390x/diag.c | 54 +++++++++++++++++++++++++++----------------=
--
>> =A0 1 file changed, 32 insertions(+), 22 deletions(-)
>>
>> diff --git a/target/s390x/diag.c b/target/s390x/diag.c
>> index 53c2f81f2a..067c667ba7 100644
>> --- a/target/s390x/diag.c
>> +++ b/target/s390x/diag.c
>> @@ -53,6 +53,29 @@ int handle_diag_288(CPUS390XState *env, uint64_t
>> r1, uint64_t r3)
>> =A0 #define DIAG_308_RC_NO_CONF=A0=A0=A0=A0=A0=A0=A0=A0 0x0102
>> =A0 #define DIAG_308_RC_INVALID=A0=A0=A0=A0=A0=A0=A0=A0 0x0402
>> =A0 +#define DIAG308_RES_MOD_CLR=A0=A0=A0=A0=A0=A0=A0 0
>> +#define DIAG308_RES_LOAD_NORM=A0=A0=A0=A0=A0=A0=A0 1
>> +#define DIAG308_LOAD_CLEAR=A0=A0=A0=A0=A0=A0=A0 3
>> +#define DIAG308_LOAD_NORMAL_DUMP=A0=A0=A0 4
>> +#define DIAG308_SET=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 5
>> +#define DIAG308_STORE=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 6
>> +
>> +static int diag308_parm_check(CPUS390XState *env, uint64_t r1,
>> uint64_t addr,
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 uintptr_t ra, bool write)
>> +{
>> +=A0=A0=A0 if ((r1 & 1) || (addr & ~TARGET_PAGE_MASK)) {
>> +=A0=A0=A0=A0=A0=A0=A0 s390_program_interrupt(env, PGM_SPECIFICATION, ra=
);
>> +=A0=A0=A0=A0=A0=A0=A0 return -EINVAL;
>> +=A0=A0=A0 }
>> +=A0=A0=A0 if (!address_space_access_valid(&address_space_memory, addr,
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 sizeof(IplParameterBlock), write,
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MEMTXATTRS_UNSPECIFIED)) {
>> +=A0=A0=A0=A0=A0=A0=A0 s390_program_interrupt(env, PGM_ADDRESSING, ra);
>> +=A0=A0=A0=A0=A0=A0=A0 return -EINVAL;
>> +=A0=A0=A0 }
>> +=A0=A0=A0 return 0;
>> +}
>> +
>> =A0 void handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3,
>> uintptr_t ra)
>> =A0 {
>> =A0=A0=A0=A0=A0 CPUState *cs =3D env_cpu(env);
>> @@ -65,30 +88,24 @@ void handle_diag_308(CPUS390XState *env, uint64_t
>> r1, uint64_t r3, uintptr_t ra)
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 return;
>> =A0=A0=A0=A0=A0 }
>> =A0 -=A0=A0=A0 if ((subcode & ~0x0ffffULL) || (subcode > 6)) {
>> +=A0=A0=A0 if (subcode & ~0x0ffffULL) {
>=20
> Strange, the default case in the switch was basically dead code.

Not really, case 2 and case 4 are not handled there. We even had a funny
bug some months ago, where a guest could terminate QEMU with one of
these codes, see commit 37dbd1f4d4805edcd18d94eb202bb3461b3cd52d.

 Thomas


