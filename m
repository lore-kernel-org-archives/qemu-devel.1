Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9AE3C48BD6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 11:06:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE9E3204FD
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 11:06:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE9E3204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgSED-0000tP-VT
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 07:06:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56352)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eric.auger@redhat.com>) id 1hgSA5-0007In-Nh
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 07:02:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1hgS9v-0006Xw-IU
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 07:01:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:11893)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1hgS99-0004hn-Jk; Thu, 27 Jun 2019 07:00:57 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7895A31628EC;
 Thu, 27 Jun 2019 11:00:46 +0000 (UTC)
Received: from [10.36.116.89] (ovpn-116-89.ams2.redhat.com [10.36.116.89])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1B18F60C62;
 Thu, 27 Jun 2019 11:00:28 +0000 (UTC)
To: Andrew Jones <drjones@redhat.com>
References: <20190621163422.6127-1-drjones@redhat.com>
 <20190621163422.6127-8-drjones@redhat.com>
 <ee8ce4a6-09fd-47ab-ef7e-a231df1e9c1b@redhat.com>
 <20190627104638.x4gxsmv7vpww3mra@kamzik.brq.redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <ae98bf94-6826-1f2b-2f2e-a11a3f75cb92@redhat.com>
Date: Thu, 27 Jun 2019 13:00:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190627104638.x4gxsmv7vpww3mra@kamzik.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Thu, 27 Jun 2019 11:00:46 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 07/14] target/arm/cpu64: max cpu:
 Introduce sve<vl-bits> properties
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
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org,
 qemu-devel@nongnu.org, armbru@redhat.com, qemu-arm@nongnu.org,
 imammedo@redhat.com, alex.bennee@linaro.org, Dave.Martin@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

On 6/27/19 12:46 PM, Andrew Jones wrote:
> On Wed, Jun 26, 2019 at 06:56:54PM +0200, Auger Eric wrote:
>>> diff --git a/target/arm/helper.c b/target/arm/helper.c
>>> index f500ccb6d31b..b7b719dba57f 100644
>>> --- a/target/arm/helper.c
>>> +++ b/target/arm/helper.c
>>> @@ -5324,7 +5324,16 @@ static void zcr_write(CPUARMState *env, const ARMCPRegInfo *ri,
>>>  
>>>      /* Bits other than [3:0] are RAZ/WI.  */
>>>      QEMU_BUILD_BUG_ON(ARM_MAX_VQ > 16);
>>> -    raw_write(env, ri, value & 0xf);
>>> +    value &= 0xf;
>>> +
>>> +    if (value) {
>>> +        /* get next vq that is smaller than or equal to value's vq */
>>> +        uint32_t vq = value + 1;
>>> +        vq = arm_cpu_vq_map_next_smaller(cpu, vq + 1);
>>> +        value = vq - 1;
>> spec says:
>>
>> "if an unsupported vector length is requested in ZCR_ELx, the
>> implementation is required to select the largest
>> supported vector length that is less than the requested length. This
>> does not alter the value of ZCR_ELx.LEN.
>> "
>>
>> So I understand the value written in the reg should not be unmodified.
>>
> 
> Sorry, I can't parse what you're trying to tell me here. Here we have
> to write 'value', because that's what the guest is trying to do. As the
> spec says in your quote, we have to pick the length the guest wants, or
> the next smaller valid one, so that's what the code above does. So are
> you just stating that you agree with this hunk of the code?
What we are writing into the reg is arm_cpu_vq_map_next_smaller(cpu, vq
+ 1) -1. Maybe I misunderstand the whole wording but I would have
expected the original unmodified value to be written in the reg instead?

Thanks

Eric
> 
> Thanks,
> drew
> 

