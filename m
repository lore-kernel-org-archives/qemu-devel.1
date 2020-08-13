Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E979C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 14:02:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 081F420771
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 14:02:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XtrvMbrB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 081F420771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6Doj-0007uB-5b
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 10:02:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43094)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbuono@linux.vnet.ibm.com>)
 id 1k6Dn3-0006vd-1z
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 10:01:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:29968)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbuono@linux.vnet.ibm.com>)
 id 1k6Dmx-0007CF-RY
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 10:01:08 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 07DDX3On108579; Thu, 13 Aug 2020 10:00:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=6UuYb3ct/enaqFbhrGpOhCAW4oDJNullj1YGkUA4O6g=;
 b=XtrvMbrBTf6cnje0VSWKwJIEsy+j+Ssjy10YrK49PEV+3DGhD5Qb3LEYJn387Fbapldd
 be1eX1J3lbsZEQx/N9Mtgosv5QWQEGtzSQqQNVRQwTnTRNhRy/5TMA0vpeatQ2T8WyM0
 qTaRHSa9sTHCneQnOWdVOxxg/0Kfw84pCD1cg3Ii75XDQS+V23frr0ZalLxKwbv+19TI
 jUzxNeGyv8311w/TzXHySOeGcEJwT70GvVlHk7UN+d7tF2t7+VOyLupUXCScH7B02UqQ
 UKPlrLowPFk/ZaZHo4POyvyt0Ub54rKA71udUf6r26Rv/trJDy8F7YBvaoJ6MUExPPs6 TQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 32w0pykmgk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Aug 2020 10:00:40 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07DDwLSa049304;
 Thu, 13 Aug 2020 10:00:40 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com
 [169.55.91.170])
 by mx0a-001b2d01.pphosted.com with ESMTP id 32w0pykmg2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Aug 2020 10:00:40 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
 by ppma02wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07DE01iE005654;
 Thu, 13 Aug 2020 14:00:39 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by ppma02wdc.us.ibm.com with ESMTP id 32skp9jebp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Aug 2020 14:00:39 +0000
Received: from b03ledav003.gho.boulder.ibm.com
 (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 07DE0crn1245806
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 13 Aug 2020 14:00:38 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3D23F6A047;
 Thu, 13 Aug 2020 14:00:38 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B08296A057;
 Thu, 13 Aug 2020 14:00:37 +0000 (GMT)
Received: from [9.160.48.164] (unknown [9.160.48.164])
 by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
 Thu, 13 Aug 2020 14:00:37 +0000 (GMT)
Subject: Re: [PATCH 2/2] configure: add support for Control-Flow Integrity
To: Alexander Bulekov <alxndr@bu.edu>, Paolo Bonzini <pbonzini@redhat.com>
References: <20200702054948.10257-1-dbuono@linux.vnet.ibm.com>
 <20200702054948.10257-3-dbuono@linux.vnet.ibm.com>
 <20200702095252.GF1888119@redhat.com>
 <0ed44c55-1f5d-6866-9555-82134ef628fb@linux.vnet.ibm.com>
 <c81befdd-979c-6060-c0a3-15ea1b142d25@redhat.com>
 <20200702133830.f3mlqli2bxtvk2z4@mozz.bu.edu>
 <f3cf9017-3da5-d6d4-f463-3864ab1f43c6@linux.vnet.ibm.com>
 <b2fc75ef-f6ae-d776-bead-4e6e6de10207@linux.vnet.ibm.com>
 <5c4add59-86c9-453c-3804-e27fc731ae6c@redhat.com>
 <20200810211958.vyhkl3d4cxpu75ni@mozz.bu.edu>
From: Daniele Buono <dbuono@linux.vnet.ibm.com>
Message-ID: <8da7805e-7728-5109-564d-d26389efee68@linux.vnet.ibm.com>
Date: Thu, 13 Aug 2020 10:00:36 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200810211958.vyhkl3d4cxpu75ni@mozz.bu.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-08-13_10:2020-08-13,
 2020-08-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 clxscore=1015
 adultscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008130102
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=dbuono@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 10:00:42
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Yes, Something like that, probably with a small python script.

On 8/10/2020 5:33 PM, Alexander Bulekov wrote:
> On 200810 2139, Paolo Bonzini wrote:
>> On 10/08/20 21:01, Daniele Buono wrote:
>>> So I'm thinking of adding a check in configure. If gold is the linker,
>>> automatically create (somehow, still working on it) the full link script
>>> by obtaining the default bfd script and add the required parts. Would
>>> that work for you?
>>
>> Maybe even do it unconditionally?
> 
> I agree.
> 
> I can try a respin of my compiler-rt/libFuzzer patches to add a built-in
> fork-server to libFuzzer, so we can avoid the linker-script madness
> altogether. Don't know how soon I can get to this, but I do think it is
> worth another try.
> 
> TIL about these differences between ld.bfd and ld.gold.
> So the idea is to use something like:
> "ld --verbose | grep -n ".*:" | grep -A1 "\s.data\s" | tail -n1"
> and insert the existing linker-script before that line?
> Thanks
> -Alex
> 
>> Paolo
>>
> 

