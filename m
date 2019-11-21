Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4479BC432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 14:30:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DD91206CB
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 14:30:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CZHVMLmQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DD91206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXnTj-0004zN-PL
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 09:30:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40090)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1iXnS6-0003hy-7n
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 09:28:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1iXnS4-0008Ra-56
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 09:28:57 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:30163
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1iXnS4-0008R5-1w
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 09:28:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574346534;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G4/UECpkhjBsvzdQHbTPdU9vc1x881p5VsyVrky1jQs=;
 b=CZHVMLmQkH8Oxeo4Ivyb+R4HIY2ajlqJ/0QccdcITOeKG6in9D7t0y1t69EkJ/MZVbzUQX
 3azzCdDiQs8EiSHDMJMLZEbXH8/WP3lNKiegHAml4E2Wg+1TV0josnk4mhM6WtKamgKzo/
 jdrJLg98jcIc6mLNKEHSY1QchlEF9ME=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-lXfZFGh3P0WlYPIGkhThBA-1; Thu, 21 Nov 2019 09:28:51 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6794C18B5FA0;
 Thu, 21 Nov 2019 14:28:50 +0000 (UTC)
Received: from [10.36.117.163] (ovpn-117-163.ams2.redhat.com [10.36.117.163])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D45B1107A43C;
 Thu, 21 Nov 2019 14:28:48 +0000 (UTC)
Subject: Re: [PATCH 06/15] s390x: protvirt: Support unpack facility
To: Janosch Frank <frankja@linux.ibm.com>, qemu-devel@nongnu.org
References: <20191120114334.2287-1-frankja@linux.ibm.com>
 <20191120114334.2287-7-frankja@linux.ibm.com>
 <8669fc89-c8a9-641d-d9aa-ee4aa011ac26@redhat.com>
 <7df881fe-46ec-2522-143e-929f4e3d2421@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <e194768b-54f7-3c50-0a30-782bd5c9448d@redhat.com>
Date: Thu, 21 Nov 2019 15:28:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <7df881fe-46ec-2522-143e-929f4e3d2421@linux.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: lXfZFGh3P0WlYPIGkhThBA-1
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
Cc: thuth@redhat.com, pmorel@linux.ibm.com, cohuck@redhat.com,
 borntraeger@de.ibm.com, qemu-s390x@nongnu.org, mihajlov@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21.11.19 15:25, Janosch Frank wrote:
> On 11/21/19 12:27 PM, David Hildenbrand wrote:
>> On 20.11.19 12:43, Janosch Frank wrote:
>=20
>>> @@ -357,6 +353,35 @@ static void s390_machine_reset(MachineState *machi=
ne)
>>>            run_on_cpu(cs, s390_do_cpu_initial_reset, RUN_ON_CPU_NULL);
>>>            run_on_cpu(cs, s390_do_cpu_load_normal, RUN_ON_CPU_NULL);
>>>            break;
>>> +    case S390_RESET_EXTERNAL:
>>> +    case S390_RESET_REIPL: /* Subcode 4 */
>>> +        qemu_devices_reset();
>>> +        s390_crypto_reset();
>>> +        /* configure and start the ipl CPU only */
>>> +        run_on_cpu(cs, s390_do_cpu_ipl, RUN_ON_CPU_NULL);
>>> +        break;
>>
>> Is there a way to modify this patch to not change unrelated code that
>> heavily? Makes it harder to review.
>=20
> https://github.com/frankjaa/qemu/commit/8c53d5c8a6bbcc53496c7a2877c7cbffc=
435b708
>=20
> And please trim your emails.
>=20

If you use Thunderbird I suggest QuoteCollapse ... because nobody got=20
time for that ;)


--=20

Thanks,

David / dhildenb


