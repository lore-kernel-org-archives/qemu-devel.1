Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94857C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 18:06:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F243206A4
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 18:06:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F243206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jejOx-0007VZ-3N
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 14:06:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50388)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tobin@linux.vnet.ibm.com>)
 id 1jejMz-0006KB-GB
 for qemu-devel@nongnu.org; Fri, 29 May 2020 14:04:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:22418)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tobin@linux.vnet.ibm.com>)
 id 1jejMy-0007IG-6b
 for qemu-devel@nongnu.org; Fri, 29 May 2020 14:04:36 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 04TI3cLw107172
 for <qemu-devel@nongnu.org>; Fri, 29 May 2020 14:04:34 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31as1eskv4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 29 May 2020 14:04:33 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04TI3sk9108432
 for <qemu-devel@nongnu.org>; Fri, 29 May 2020 14:04:33 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.26])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31as1eskum-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 29 May 2020 14:04:33 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
 by ppma04wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 04TI0khh018071;
 Fri, 29 May 2020 18:04:32 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by ppma04wdc.us.ibm.com with ESMTP id 316ufa4war-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 29 May 2020 18:04:32 +0000
Received: from b03ledav001.gho.boulder.ibm.com
 (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 04TI4Tw223855504
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 29 May 2020 18:04:29 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9AB5D6E050;
 Fri, 29 May 2020 18:04:30 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6CA226E058;
 Fri, 29 May 2020 18:04:30 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.16.170.189])
 by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
 Fri, 29 May 2020 18:04:30 +0000 (GMT)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Fri, 29 May 2020 14:04:30 -0400
From: tobin <tobin@linux.vnet.ibm.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH 1/2] sev: add sev-inject-launch-secret
In-Reply-To: <1f13641f-c4d9-3414-2afc-f89df39e7967@redhat.com>
References: <20200528205114.42078-1-tobin@linux.vnet.ibm.com>
 <20200528205114.42078-2-tobin@linux.vnet.ibm.com>
 <1f13641f-c4d9-3414-2afc-f89df39e7967@redhat.com>
Message-ID: <91d8e56e915987ee5585e7d33c1df3b1@linux.vnet.ibm.com>
X-Sender: tobin@linux.vnet.ibm.com
User-Agent: Roundcube Webmail/1.0.1
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-05-29_09:2020-05-28,
 2020-05-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 cotscore=-2147483648 malwarescore=0 clxscore=1015 mlxscore=0
 impostorscore=0 adultscore=0 spamscore=0 suspectscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 priorityscore=1501 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005290136
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=tobin@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/29 14:04:34
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: jejb@linux.ibm.com, tobin@ibm.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2020-05-28 17:42, Eric Blake wrote:
> On 5/28/20 3:51 PM, Tobin Feldman-Fitzthum wrote:
>> From: Tobin Feldman-Fitzthum <tobin@ibm.com>
>> 
>> AMD SEV allows a guest owner to inject a secret blob
>> into the memory of a virtual machine. The secret is
>> encrypted with the SEV Transport Encryption Key and
>> integrity is guaranteed with the Transport Integrity
>> Key. Although QEMU faciliates the injection of the
>> launch secret, it cannot access the secret.
>> 
>> Signed-off-by: Tobin Feldman-Fitzthum <tobin@linux.vnet.ibm.com>
>> ---
> 
>> +++ b/qapi/misc-target.json
>> @@ -200,6 +200,26 @@
>>   { 'command': 'query-sev-capabilities', 'returns': 'SevCapability',
>>     'if': 'defined(TARGET_I386)' }
>>   +##
>> +# @sev-inject-launch-secret:
>> +#
>> +# This command injects a secret blob into memory of SEV guest.
>> +#
>> +# @packet-header: the launch secret packet header encoded in base64
>> +#
>> +# @secret: the launch secret data to be injected encoded in base64
>> +#
>> +# @gpa: the guest physical address where secret will be injected.
>> +        GPA provided here will be ignored if guest ROM specifies
>> +        the a launch secret GPA.
> 
> Missing # on the wrapped lines.
> 
>> +#
>> +# Since: 5.0.0
> 
> You've missed 5.0, and more sites tend to use x.y instead of x.y.z
> (although we aren't consistent); this should be 'Since: 5.1'
> 
>> +#
>> +##
>> +{ 'command': 'sev-inject-launch-secret',
>> +  'data': { 'packet_hdr': 'str', 'secret': 'str', 'gpa': 'uint64' },
> 
> This does not match your documentation above, which named it
> 'packet-header'.  Should 'gpa' be optional, to account for the case
> where ROM specifies it?

My bad on the syntax issues. I think making GPA optional makes sense.
In the first patch we can have it be required and in the second
we add the option to scan the ROM.

