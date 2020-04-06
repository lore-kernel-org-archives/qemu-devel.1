Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 364DEC2BA17
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 18:34:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 169A2206C3
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 18:34:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 169A2206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLWaI-0002OH-8J
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 14:34:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44002)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <farman@linux.ibm.com>) id 1jLWNA-0000PG-2r
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 14:21:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <farman@linux.ibm.com>) id 1jLWN8-0002FU-BE
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 14:21:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53154)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <farman@linux.ibm.com>)
 id 1jLWN8-0002EG-1B; Mon, 06 Apr 2020 14:21:22 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 036I4gta040987; Mon, 6 Apr 2020 14:21:20 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3082hfx6uy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Apr 2020 14:21:20 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 036I4hJ9041108;
 Mon, 6 Apr 2020 14:21:20 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.10])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3082hfx6um-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Apr 2020 14:21:20 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
 by ppma02dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 036IKnCn003732;
 Mon, 6 Apr 2020 18:21:19 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25]) by ppma02dal.us.ibm.com with ESMTP id 306hv6pjqq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Apr 2020 18:21:19 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com
 [9.57.199.107])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 036ILI5W45744608
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 6 Apr 2020 18:21:18 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7F9A312405E;
 Mon,  6 Apr 2020 18:21:18 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E1F87124054;
 Mon,  6 Apr 2020 18:21:17 +0000 (GMT)
Received: from [9.160.17.120] (unknown [9.160.17.120])
 by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
 Mon,  6 Apr 2020 18:21:17 +0000 (GMT)
Subject: Re: [RFC PATCH v2 1/7] vfio-ccw: Return IOINST_CC_NOT_OPERATIONAL for
 EIO
To: Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
References: <20200206214509.16434-1-farman@linux.ibm.com>
 <20200206214509.16434-2-farman@linux.ibm.com>
 <20200324180430.3597ca94.cohuck@redhat.com>
 <20200325032428.11dd27a2.pasic@linux.ibm.com>
 <20200401105258.3e885efb.cohuck@redhat.com>
From: Eric Farman <farman@linux.ibm.com>
Message-ID: <06a9fc5c-be2d-f152-de61-e815d7454692@linux.ibm.com>
Date: Mon, 6 Apr 2020 14:21:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200401105258.3e885efb.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.676
 definitions=2020-04-06_08:2020-04-06,
 2020-04-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 clxscore=1011 malwarescore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 mlxscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004060143
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
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
Cc: Jason Herne <jjherne@linux.ibm.com>, qemu-s390x@nongnu.org,
 Jared Rossi <jrossi@linux.ibm.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 4/1/20 4:52 AM, Cornelia Huck wrote:
> On Wed, 25 Mar 2020 03:24:28 +0100
> Halil Pasic <pasic@linux.ibm.com> wrote:
> 
>> On Tue, 24 Mar 2020 18:04:30 +0100
>> Cornelia Huck <cohuck@redhat.com> wrote:
>>
>>> On Thu,  6 Feb 2020 22:45:03 +0100
>>> Eric Farman <farman@linux.ibm.com> wrote:
>>>   
>>>> From: Farhan Ali <alifm@linux.ibm.com>
>>>>
>>>> EIO is returned by vfio-ccw mediated device when the backing
>>>> host subchannel is not operational anymore. So return cc=3
>>>> back to the guest, rather than returning a unit check.
>>>> This way the guest can take appropriate action such as
>>>> issue an 'stsch'.  
>>
>> I believe this is not the only situation when vfio-ccw returns
>> EIO, or?
>>
>>>>
>>>> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
>>>> Signed-off-by: Eric Farman <farman@linux.ibm.com>
>>>> ---
>>>>
>>>> Notes:
>>>>     v1->v2: [EF]
>>>>      - Add s-o-b
>>>>      - [Seems the discussion on v1 centered on the return code
>>>>        set in the kernel, rather than anything that needs to
>>>>        change here, unless I've missed something.]  
>>
>> Does this need to change here? If the kernel is supposed to return ENODEV
>> then this does not need to change.
>>
>>>
>>> I've stared at this and at the kernel code for some time again; and I'm
>>> not sure if "return -EIO == not operational" is even true. That said,
>>> I'm not sure a unit check is the right response, either. The only thing
>>> I'm sure about is that the kernel code needs some review of return
>>> codes and some documentation...  
>>
>> I could not agree more, this is semantically uapi and needs to be
>> properly documented.
>>
>> With regards to "linux error codes: vs "ionist cc's" an where
>> the mapping is different example:
>>
>> """
>> /**                                                                             
>>  * cio_cancel_halt_clear - Cancel running I/O by performing cancel, halt        
>>  * and clear ordinally if subchannel is valid.                                  
>>  * @sch: subchannel on which to perform the cancel_halt_clear operation         
>>  * @iretry: the number of the times remained to retry the next operation        
>>  *                                                                              
>>  * This should be called repeatedly since halt/clear are asynchronous           
>>  * operations. We do one try with cio_cancel, three tries with cio_halt,        
>>  * 255 tries with cio_clear. The caller should initialize @iretry with          
>>  * the value 255 for its first call to this, and keep using the same            
>>  * @iretry in the subsequent calls until it gets a non -EBUSY return.           
>>  *                                                                              
>>  * Returns 0 if device now idle, -ENODEV for device not operational,            
>>  * -EBUSY if an interrupt is expected (either from halt/clear or from a         
>>  * status pending), and -EIO if out of retries.                                 
>>  */                                                                             
>> int cio_cancel_halt_clear(struct subchannel *sch, int *iretry)   
>>
>> """
>> Here -ENODEV is not operational.
> 
> Ok, I went through the kernel code and checked which error may be
> returned in which case (hope I caught all of them). Here's what I
> currently have:

Thanks for doing all this mapping!

> 
> diff --git a/Documentation/s390/vfio-ccw.rst b/Documentation/s390/vfio-ccw.rst
> index fca9c4f5bd9c..43f375a03cce 100644
> --- a/Documentation/s390/vfio-ccw.rst
> +++ b/Documentation/s390/vfio-ccw.rst
> @@ -210,7 +210,36 @@ Subchannel.
>  
>  irb_area stores the I/O result.
>  
> -ret_code stores a return code for each access of the region.
> +ret_code stores a return code for each access of the region. The following
> +values may occur:
> +
> +0
> +  The operation was successful.
> +
> +-EOPNOTSUPP
> +  The orb specified transport mode or an unidentified IDAW format, did not
> +  specify prefetch mode, or the scsw specified a function other than the
> +  start function.
> +
> +-EIO
> +  A request was issued while the device was not in a state ready to accept
> +  requests, or an internal error occurred.
> +
> +-EBUSY
> +  The subchannel was status pending or busy, or a request is already active.
> +
> +-EAGAIN
> +  A request was being processed, and the caller should retry.
> +
> +-EACCES
> +  The channel path(s) used for the I/O were found to be not operational.
> +
> +-ENODEV
> +  The device was found to be not operational.
> +
> +-EINVAL
> +  The orb specified a chain longer than 255 ccws, or an internal error
> +  occurred.
>  
>  This region is always available.
>  
> @@ -231,6 +260,29 @@ This region is exposed via region type VFIO_REGION_SUBTYPE_CCW_ASYNC_CMD.
>  
>  Currently, CLEAR SUBCHANNEL and HALT SUBCHANNEL use this region.
>  
> +command specifies the command to be issued; ret_code stores a return code
> +for each access of the region. The following values may occur:
> +
> +0
> +  The operation was successful.
> +
> +-ENODEV
> +  The device was found to be not operational.
> +
> +-EINVAL
> +  A command other than halt or clear was specified.
> +
> +-EIO
> +  A request was issued while the device was not in a state ready to accept
> +  requests.
> +
> +-EAGAIN
> +  A request was being processed, and the caller should retry.
> +
> +-EBUSY
> +  The subchannel was status pending or busy while processing a halt request.
> +
> +
>  vfio-ccw operation details
>  --------------------------
>  
> Unless we interpret "device in wrong state" as "not operational",
> mapping -EIO to cc 3 is probably not the right thing to do; but
> generating a unit exception probably isn't either. Honestly, I'm unsure
> what the right thing to do here would be...

Me neither. I grepped my qemu logs for the past, ugh, too long for the
error report that would precede these failures ("vfio-ccw: [wirte/write]
I/O region failed with errno=%d"). Excluding the ones that were
obviously the result of half-baked code, all instances were either
-EBUSY or -ENODEV.  Could I trigger one?  Maybe.  Is it likely?  Doesn't
seem to be.

It seems that getting -EIO would indicate we got ourselves out of sync,
and started buttoning up the device again (or never having opened it in
the first place), so a unit exception might be valid as a "hey
something's screwy here" ?

> 
> Another problem is that -EIO might signal "something went wrong in the
> kernel code" - should not happen, but would certainly not be the
> caller's fault, and they can't do anything about it. That "internal
> error" thing might also be signaled by -EINVAL (which is odd), but
> -EINVAL could also mean "the ccw chain is too long", for which
> -EOPNOTSUPP would probably be a better return code, as it's a
> limitation in the code, not the architecture, IIRC. Not sure if we can
> still change that, though (and QEMU handles both in the same way,
> anyway.)
> 
> The other return codes look sane, and the return codes for the async
> region also seem sane (but have the same issue with -EIO == "device in
> wrong state").
> 
> Looking at the QEMU handling, I think the -EIO handling is a bit
> questionable (without an obvious solution), while mapping -EBUSY to cc
> 2 is the only reasonable thing to do given that the interface does not
> differentiate between "busy" and "status pending". The rest seems sane.
> 

So maybe with all this data, and absent a better solution, it's best to
just drop this patch from v3?

