Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C7DCC388F9
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 13:34:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCBB52080A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 13:34:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="M1W94WEv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCBB52080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVEGK-0000ww-KU
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 09:34:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60874)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1kVE8m-0008Hy-A3
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 09:26:56 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:49862)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1kVE8j-000470-2Y
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 09:26:55 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09LDOTsV162142;
 Wed, 21 Oct 2020 13:26:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=xhjukGmCPuCvtLYU0I/ZDOlAyAnOkjOmWVwSWu2PNtU=;
 b=M1W94WEveggzGYcVQ3bB/vunDFHSBZHbBBZCisjsd13Gsa6a8kjgvkneprhYRk2FrHNM
 jxv6f3PZro0Std7YcQT01ystacUzRmY8JDSvGLV0lMR9FIUguqLfDCvXOTABZoPAG1VS
 eh+vt40QrvkV/37nzsVmh+Th7vvqGAy5VVjIVEGfqdGAmVL0wukZIV3bRso8DLAOENQQ
 4VAjaMJ1nkE9vhDYGUN4Tj6hRUDEtftXRR61mshM2mJZziC2/dGCWfm5Y2SifUmQlCrR
 HbEUV/VvnepyJe5B882wapOjpNivmn840wx6WDb+cSyQ9MAabo8HVSWWG6lfNt45wDUy 3Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2120.oracle.com with ESMTP id 34ak16gsb4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 21 Oct 2020 13:26:46 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09LDOwkY002676;
 Wed, 21 Oct 2020 13:26:46 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3030.oracle.com with ESMTP id 348ahxkbfm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 21 Oct 2020 13:26:46 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09LDQjJv011280;
 Wed, 21 Oct 2020 13:26:45 GMT
Received: from [10.39.238.185] (/10.39.238.185)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 21 Oct 2020 06:26:45 -0700
Subject: Re: [PATCH 0/1] Do not stop guest when panic event is received
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <1601606494-1154-1-git-send-email-alejandro.j.jimenez@oracle.com>
 <74a8c57d-4f2d-64cd-f2d2-32dc88b64f9b@redhat.com>
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Organization: Oracle Corporation
Message-ID: <1c9cdb1d-5dd5-a783-96e9-8f62a498951a@oracle.com>
Date: Wed, 21 Oct 2020 09:26:43 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <74a8c57d-4f2d-64cd-f2d2-32dc88b64f9b@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9780
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 bulkscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010210102
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9780
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 mlxscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010210102
Received-SPF: pass client-ip=156.151.31.85;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=userp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/21 09:26:49
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 10/20/2020 1:14 PM, Paolo Bonzini wrote:
> On 02/10/20 04:41, Alejandro Jimenez wrote:
>> The fact that the behavior of hv-crash is also affected is why I chose to implement this change as an independent
>> option, as opposed to making it a property of the pvpanic device (e.g. -device pvpanic,no-panicstop).
>>
>> Please let me know if you have any comments or suggestions.
> Hi Alejandro, sorry for the delayed response.
>
> The concept is fine, and I agree this should not be a device property.
>
> On the other hand, we already have many similar options: -no-reboot,
> -no-shutdown, -watchdog-action and now --no-panicstop.
>
> I think it's time to group them into a single option:
>
> * -action reboot=pause|shutdown|none
> * -action shutdown=pause|poweroff|none
> * -action panic=pause|shutdown|none
> * -action watchdog=reset|shutdown|poweroff|pause|debug|none|inject-nmi
>
> where the existing options would translate to the new option, like:
>
> * -no-reboot "-action reboot=shutdown"
> * -no-shutdown "-action shutdown=pause"
>
> The implementation should be relatively easy too; there's already an
> enum WatchdogAction (that can be renamed to e.g. RunstateAction) and a
> parsing function select_watchdog_action that can be changed to just
> return the RunstateAction.
>
> Would you like to take a look at this?
Hi Paolo,

Thank you for your reply and the advice/hints above. I'll take a look 
and try to implement what you propose.

Regards,
Alejandro
>
> Thanks,
>
> Paolo
>


