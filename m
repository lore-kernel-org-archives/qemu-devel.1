Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73D3FC3F2C6
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 18:09:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E32E21D7E
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 18:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EsmQAMHT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E32E21D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBjJU-0004hP-Dk
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 14:09:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53325)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1jBjHL-0001Vi-5h
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 14:06:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1jBjHJ-0002d9-Lr
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 14:06:54 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:45000)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1jBjHJ-00025i-B1
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 14:06:53 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02AI2NSU028550;
 Tue, 10 Mar 2020 18:06:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=8QvUq+Ufv1VOrTlkNTw3FOUYcLjYpcDkpxPgfeSXPXc=;
 b=EsmQAMHTsz2Mv8D1hu1OVeWxANrOYUR+OT5xUbGDH3dgei6piyvF+x1ctluy/Zk3WdP1
 Lxd12KHQGec/eK6BujWeAzFi52mWU5S/5MPbeBSeSLCRfJ5YaYZnrwigG+R1gn0j1HfJ
 nmwDLhhXzsD8TdsdiND2fnsyM1HNxB7QCE9JqOaRKQTE12l/wxUG4nAMDnzRs8i0CKfu
 x0mvpWx4R3OW7e3b5hd8DfxQAEctn+c5QuQmgKmB+WG5/yI3V9EFhTna0EX/pQjrrSyF
 qj6ES/odluLfJfrrvOK7dJueZaI2QbG3sLGrfDcsdfg9BNfD1F8OtZ9CtmTGpX4pvF3R 5g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by aserp2120.oracle.com with ESMTP id 2yp9v629f1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2020 18:06:31 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02AI3YfW054219;
 Tue, 10 Mar 2020 18:04:30 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3030.oracle.com with ESMTP id 2yp8qpku2p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2020 18:04:30 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02AI4QXR021388;
 Tue, 10 Mar 2020 18:04:26 GMT
Received: from [10.152.34.2] (/10.152.34.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 10 Mar 2020 11:04:25 -0700
Subject: Re: [PATCH v5 32/50] multi-process: Use separate MMIO communication
 channel
To: Stefan Hajnoczi <stefanha@redhat.com>
References: <cover.1582576372.git.jag.raman@oracle.com>
 <d776913e1796fe9f929a665c0265eff3978fcc16.1582576372.git.jag.raman@oracle.com>
 <20200306165227.GD1438162@stefanha-x1.localdomain>
From: Jag Raman <jag.raman@oracle.com>
Organization: Oracle Corporation
Message-ID: <520c4a37-2d8a-8d5c-fa12-fc33929a183b@oracle.com>
Date: Tue, 10 Mar 2020 14:04:23 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200306165227.GD1438162@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9556
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0 mlxscore=0
 adultscore=0 suspectscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003100109
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9556
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 spamscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003100109
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 141.146.126.78
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, swapnil.ingle@nutanix.com,
 john.g.johnson@oracle.com, qemu-devel@nongnu.org, kraxel@redhat.com,
 quintela@redhat.com, mst@redhat.com, armbru@redhat.com,
 kanth.ghatraju@oracle.com, felipe@nutanix.com, thuth@redhat.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, dgilbert@redhat.com,
 liran.alon@oracle.com, thanos.makatos@nutanix.com, rth@twiddle.net,
 kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 3/6/2020 11:52 AM, Stefan Hajnoczi wrote:
> This went unanswered in the last revision:
> 
> On Thu, Nov 21, 2019 at 12:31:42PM +0000, Stefan Hajnoczi wrote:
>> On Wed, Nov 13, 2019 at 11:14:50AM -0500, Jag Raman wrote:
>>> On 11/11/2019 11:21 AM, Stefan Hajnoczi wrote:
>>>> On Thu, Oct 24, 2019 at 05:09:13AM -0400, Jagannathan Raman wrote:
>>>>> Using a separate communication channel for MMIO helps
>>>>> with improving Performance
>>>>
>>>> Why?
>>>
>>> Typical initiation of IO operations involves multiple MMIO accesses per
>>> IO operation. In some legacy devices like LSI, the completion of the IO
>>> operations is also accomplished by polling on MMIO registers. Therefore,
>>> MMIO traffic can be hefty in some cases and contribute to Performance.
>>>
>>> Having a dedicated channel for MMIO ensures that it doesn't have to
>>> compete with other messages to the remote process, especially when there
>>> are multiple devices emulated by a single remote process.
>>
>> A vCPU doing a polling read on an MMIO register will cause a BAR_READ
>> message to be sent to the remote process.  The vCPU thread waits for the
>> response to this message.
>>
>> When there are multiple remote devices each has its own socket, so
>> communication with different remote processes does not interfere.
>>
>> The only scenarios I can think of are:
>> 1. Interference within a single device between vCPUs and/or the QEMU
>>     monitor.
>> 2. A single process serving multiple devices that is implemented in a
>>     way such that different devices interfere with each other.
>>
>> It sounds like you are saying the problem is #2, but this is still
>> unclear to me.  If the remote process can be implemented in a way such
>> that there is no interference when each device has a special MMIO
>> socket, then why can't it be implemented in a way such that there is no
>> interference when each device's main socket is used (each device has
>> it's own!).
>>
>> Maybe I've missed the point.  It would be good if you could explain in
>> more detail.

Hi Stefan,

Sorry we missed this comment. We originally added this to enable
separate MMIO channels for each device in the remote process.

Given we are going to add a separate channel for each device in the
remote process based on the recent discussions, we could remove the
separate channel for MMIO.

Thank you very much!
--
Jag

>>
>> Stefan

