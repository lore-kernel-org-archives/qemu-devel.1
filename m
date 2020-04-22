Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DDCFC5518C
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 12:19:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 754402098B
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 12:19:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 754402098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRELG-0005pH-KJ
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 08:19:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54340)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <farman@linux.ibm.com>) id 1jREJw-00058a-46
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 08:17:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <farman@linux.ibm.com>) id 1jREJu-0005Yw-Mr
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 08:17:39 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:23304)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1jREJu-0005SK-3U; Wed, 22 Apr 2020 08:17:38 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 03MC2DiG060589; Wed, 22 Apr 2020 08:17:32 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 30gmvj1w9j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 22 Apr 2020 08:17:32 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 03MC2Usw062034;
 Wed, 22 Apr 2020 08:17:32 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com
 [169.55.91.170])
 by mx0a-001b2d01.pphosted.com with ESMTP id 30gmvj1w95-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 22 Apr 2020 08:17:32 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
 by ppma02wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 03MCGHMA028501;
 Wed, 22 Apr 2020 12:17:31 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24]) by ppma02wdc.us.ibm.com with ESMTP id 30fs66s3t7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 22 Apr 2020 12:17:31 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com
 [9.57.199.106])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 03MCHUcf49480068
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 22 Apr 2020 12:17:30 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 918942805C;
 Wed, 22 Apr 2020 12:17:30 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1D4852805A;
 Wed, 22 Apr 2020 12:17:29 +0000 (GMT)
Received: from [9.160.108.41] (unknown [9.160.108.41])
 by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
 Wed, 22 Apr 2020 12:17:29 +0000 (GMT)
Subject: Re: [PATCH v3 3/7] vfio-ccw: Add support for the schib region
To: Cornelia Huck <cohuck@redhat.com>
References: <20200417023440.70514-1-farman@linux.ibm.com>
 <20200417023440.70514-4-farman@linux.ibm.com>
 <20200422133600.6fa4d6ac.cohuck@redhat.com>
From: Eric Farman <farman@linux.ibm.com>
Message-ID: <1151dbfb-15cb-b9bc-a484-12aa66ab7a4e@linux.ibm.com>
Date: Wed, 22 Apr 2020 08:17:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200422133600.6fa4d6ac.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.676
 definitions=2020-04-22_03:2020-04-22,
 2020-04-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 clxscore=1015 mlxscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004220093
Received-SPF: pass client-ip=148.163.156.1; envelope-from=farman@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 08:17:33
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
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
Cc: Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Jared Rossi <jrossi@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 4/22/20 7:36 AM, Cornelia Huck wrote:
> On Fri, 17 Apr 2020 04:34:36 +0200
> Eric Farman <farman@linux.ibm.com> wrote:
> 
>> From: Farhan Ali <alifm@linux.ibm.com>
>>
>> The schib region can be used to obtain the latest SCHIB from the host
>> passthrough subchannel. Since the guest SCHIB is virtualized,
>> we currently only update the path related information so that the
>> guest is aware of any path related changes when it issues the
>> 'stsch' instruction.
>>
>> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
>> Signed-off-by: Eric Farman <farman@linux.ibm.com>
>> ---
>>
>> Notes:
>>     v1->v2:
>>      - Remove silly variable intialization, and add a block comment,
>>        to css_do_stsch() [CH]
>>      - Add a TODO statement to s390_ccw_store(), for myself to sort
>>        out while we go over kernel code more closely [CH/EF]
>>      - In vfio_ccw_handle_store(),
>>         - Set schib pointer once region is determined to be non-NULL [CH]
>>         - Return cc=0 if pread() fails, and log an error [CH]
>>     
>>     v0->v1: [EF]
>>      - Change various incarnations of "update chp status" to
>>        "handle_store", to reflect the STSCH instruction that will
>>        drive this code
>>      - Remove temporary variable for casting/testing purposes in
>>        s390_ccw_store(), and add a block comment of WHY its there.
>>      - Add a few comments to vfio_ccw_handle_store()
>>
>>  hw/s390x/css.c              | 13 ++++++--
>>  hw/s390x/s390-ccw.c         | 28 +++++++++++++++++
>>  hw/vfio/ccw.c               | 63 +++++++++++++++++++++++++++++++++++++
>>  include/hw/s390x/css.h      |  3 +-
>>  include/hw/s390x/s390-ccw.h |  1 +
>>  target/s390x/ioinst.c       |  3 +-
>>  6 files changed, 106 insertions(+), 5 deletions(-)
>>
> 
>> +IOInstEnding s390_ccw_store(SubchDev *sch)
>> +{
>> +    S390CCWDeviceClass *cdc = NULL;
>> +    int ret = IOINST_CC_EXPECTED;
>> +
>> +    /*
>> +     * This only applies to passthrough devices, so we can't unconditionally
>> +     * set this variable like we would for halt/clear.
>> +     *
>> +     * TODO from Conny on v1:
>> +     *   "We have a generic ccw_cb in the subchannel structure for ccw
>> +     *    interpretation; would it make sense to add a generic callback
>> +     *    for stsch there as well?
>> +     *
>> +     *   "(This works fine, though. Might want to add the check for
>> +     *    halt/clear as well, but that might be a bit overkill.)"
> 
> Do you plan to look into that for the next version? If not, don't feel
> pressured.

Ah, yes.  Clearly I missed this before v3.

> 
>> +     */
>> +    if (object_dynamic_cast(OBJECT(sch->driver_data), TYPE_S390_CCW)) {
>> +        cdc = S390_CCW_DEVICE_GET_CLASS(sch->driver_data);
>> +    }
>> +
>> +    if (cdc && cdc->handle_store) {
>> +        ret = cdc->handle_store(sch);
>> +    }
>> +
>> +    return ret;
>> +}
>> +
>>  static void s390_ccw_get_dev_info(S390CCWDevice *cdev,
>>                                    char *sysfsdev,
>>                                    Error **errp)
> 
> Generally, looks sane.
> 

