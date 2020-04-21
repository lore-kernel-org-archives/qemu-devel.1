Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B0BC54FC9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 13:07:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6FBA206F4
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 13:07:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6FBA206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQscs-0000BZ-SG
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 09:07:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45462)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <farman@linux.ibm.com>) id 1jQsaE-000442-VR
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 09:05:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <farman@linux.ibm.com>) id 1jQsaD-0004HB-HR
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 09:05:02 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:26048
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1jQsaD-0004Dy-2A; Tue, 21 Apr 2020 09:05:01 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 03LD4KWw017839; Tue, 21 Apr 2020 09:04:58 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 30hycnbu61-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Apr 2020 09:04:58 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 03LD4ds7019784;
 Tue, 21 Apr 2020 09:04:57 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.10])
 by mx0b-001b2d01.pphosted.com with ESMTP id 30hycnbu4s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Apr 2020 09:04:57 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
 by ppma02dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 03LD4m34031970;
 Tue, 21 Apr 2020 13:04:55 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by ppma02dal.us.ibm.com with ESMTP id 30fs66qmdv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Apr 2020 13:04:55 +0000
Received: from b03ledav006.gho.boulder.ibm.com
 (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 03LD4sAF50659690
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Apr 2020 13:04:54 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F4001C6059;
 Tue, 21 Apr 2020 13:04:53 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 03C72C605B;
 Tue, 21 Apr 2020 13:04:52 +0000 (GMT)
Received: from [9.65.251.67] (unknown [9.65.251.67])
 by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
 Tue, 21 Apr 2020 13:04:52 +0000 (GMT)
Subject: Re: [PATCH v3 6/7] s390x/css: Refactor the css_queue_crw() routine
To: Cornelia Huck <cohuck@redhat.com>
References: <20200417023440.70514-1-farman@linux.ibm.com>
 <20200417023440.70514-7-farman@linux.ibm.com>
 <20200421142834.16f5ea16.cohuck@redhat.com>
From: Eric Farman <farman@linux.ibm.com>
Message-ID: <ecd45274-0116-72b4-44f5-818032e14ebf@linux.ibm.com>
Date: Tue, 21 Apr 2020 09:04:52 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200421142834.16f5ea16.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.676
 definitions=2020-04-21_05:2020-04-20,
 2020-04-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0
 spamscore=0 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0
 malwarescore=0 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004210100
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/21 09:04:58
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Received-From: 148.163.158.5
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
Cc: Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Jared Rossi <jrossi@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 4/21/20 8:28 AM, Cornelia Huck wrote:
> On Fri, 17 Apr 2020 04:34:39 +0200
> Eric Farman <farman@linux.ibm.com> wrote:
> 
>> We have a use case (vfio-ccw) where a CRW is already built and
>> ready to use.  Rather than teasing out the components just to
>> reassemble it later, let's rework this code so we can queue a
>> fully-qualified CRW directly.
>>
>> Signed-off-by: Eric Farman <farman@linux.ibm.com>
>> ---
>>  hw/s390x/css.c         | 44 ++++++++++++++++++++++++++++--------------
>>  include/hw/s390x/css.h |  1 +
>>  2 files changed, 30 insertions(+), 15 deletions(-)
>>
>> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
>> index a44faa3549..a72c09adbe 100644
>> --- a/hw/s390x/css.c
>> +++ b/hw/s390x/css.c
>> @@ -2170,30 +2170,23 @@ void css_subch_assign(uint8_t cssid, uint8_t ssid, uint16_t schid,
>>      }
>>  }
>>  
>> -void css_queue_crw(uint8_t rsc, uint8_t erc, int solicited,
>> -                   int chain, uint16_t rsid)
>> +void css_queue_crw_cont(CRW crw)
> 
> Don't really like this name, as it makes me think of 'continuation'
> instead of 'container'.
> 
> css_queue_crw_container?
> css_crw_add_to_queue?
> 
> Naming is hard :(

Yeah, I don't like it either.  Just took it from the variable "crw_cont"
in the original code, but it does seem more like a continuation.  Since
the "container" is something built in that routine, maybe the
"add_to_queue" variant fits better.

> 
>>  {
>>      CrwContainer *crw_cont;
>>  
>> -    trace_css_crw(rsc, erc, rsid, chain ? "(chained)" : "");
>> +    trace_css_crw((crw.flags & CRW_FLAGS_MASK_RSC) >> 8,
>> +                  crw.flags & CRW_FLAGS_MASK_ERC,
>> +                  crw.rsid,
>> +                  (crw.flags & CRW_FLAGS_MASK_C) ? "(chained)" : "");
>> +
>>      /* TODO: Maybe use a static crw pool? */
>>      crw_cont = g_try_new0(CrwContainer, 1);
>>      if (!crw_cont) {
>>          channel_subsys.crws_lost = true;
>>          return;
> 
> Now that we actually pass something in, do we want to inform the caller
> whether the crw was queued or not?

Hrm...  Well I guess we could use it to break out of our loop in patch
7.  But for the existing callers of css_queue_crw(), it doesn't provide
much value to anyone but css_generate_css_crws().  I'll poke at this a bit.

> 
>>      }
>> -    crw_cont->crw.flags = (rsc << 8) | erc;
>> -    if (solicited) {
>> -        crw_cont->crw.flags |= CRW_FLAGS_MASK_S;
>> -    }
>> -    if (chain) {
>> -        crw_cont->crw.flags |= CRW_FLAGS_MASK_C;
>> -    }
>> -    crw_cont->crw.rsid = rsid;
>> -    if (channel_subsys.crws_lost) {
>> -        crw_cont->crw.flags |= CRW_FLAGS_MASK_R;
>> -        channel_subsys.crws_lost = false;
>> -    }
>> +
>> +    crw_cont->crw = crw;
>>  
>>      QTAILQ_INSERT_TAIL(&channel_subsys.pending_crws, crw_cont, sibling);
>>  
> 
> Generally, looks sane to me.
> 

