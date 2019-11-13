Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC5AC33C8C
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 16:51:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65A1A206D3
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 16:51:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZqfIhjzT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65A1A206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUvbo-000139-KE
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 11:35:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43582)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1iUvaP-0008Si-A7
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 11:33:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1iUvaM-0003g4-Pf
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 11:33:39 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:38132)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1iUvaM-0003fi-G4
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 11:33:38 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xADGOK2e180167;
 Wed, 13 Nov 2019 16:33:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=VhUfnAv4kTjj2ZaGMjER91lusz/+pawYUIvZ/vkHdkE=;
 b=ZqfIhjzTAjaYUKJQ5y/dWQcG71RkkzdxMk3ZMWqLnFeO9dUM0SvCFN7lqr/mJ3OlQUm9
 1Y6PyZMWYfc9jXriN33hdQX82dk2s7uYso1s+ZLsWCb98d364bVPzb4Bl2IvhmzlWeHx
 Y2I+j3OmaMlj/d39YOZgOEoY/25+OB/DpN0WXcj6mRR2vXCloHRvBqjhfX7VsvUbNxtj
 21unBxZ375KPPulP16CotLFnnO58OXMSDfzVqUz1/Tq/xcDzpVx0KMk1jRwBVLAsTzKe
 ZAvz+/yR7M9NjcpHZuu4/Vv2f+BE75YcT/sPx4lTSBBdnLWHh7w0zUiqWI7ovm20Z63s uw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2120.oracle.com with ESMTP id 2w5p3qwjft-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 13 Nov 2019 16:33:27 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xADGQwfk156001;
 Wed, 13 Nov 2019 16:33:27 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3030.oracle.com with ESMTP id 2w8g17sgs0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 13 Nov 2019 16:33:27 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xADGXOo9019779;
 Wed, 13 Nov 2019 16:33:24 GMT
Received: from [10.152.34.2] (/10.152.34.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 13 Nov 2019 08:33:24 -0800
Subject: Re: [RFC v4 PATCH 45/49] multi-process/mig: Synchronize runstate of
 remote process
To: Stefan Hajnoczi <stefanha@redhat.com>
References: <cover.1571905346.git.jag.raman@oracle.com>
 <5ef7500148d9c15b236f551f6af7b8a4a8d6e81d.1571905346.git.jag.raman@oracle.com>
 <20191111161759.GG402228@stefanha-x1.localdomain>
From: Jag Raman <jag.raman@oracle.com>
Organization: Oracle Corporation
Message-ID: <278b1ff6-1291-ce05-115a-f1904aee3be0@oracle.com>
Date: Wed, 13 Nov 2019 11:33:23 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20191111161759.GG402228@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9440
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1910280000 definitions=main-1911130146
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9440
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1910280000
 definitions=main-1911130146
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.85
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, thuth@redhat.com,
 john.g.johnson@oracle.com, ehabkost@redhat.com, konrad.wilk@oracle.com,
 liran.alon@oracle.com, rth@twiddle.net, quintela@redhat.com,
 qemu-devel@nongnu.org, armbru@redhat.com, ross.lagerwall@citrix.com,
 mst@redhat.com, kraxel@redhat.com, kwolf@redhat.com, pbonzini@redhat.com,
 berrange@redhat.com, mreitz@redhat.com, kanth.ghatraju@oracle.com,
 dgilbert@redhat.com, marcandre.lureau@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 11/11/2019 11:17 AM, Stefan Hajnoczi wrote:
> On Thu, Oct 24, 2019 at 05:09:26AM -0400, Jagannathan Raman wrote:
>> @@ -656,6 +657,19 @@ static void init_proxy(PCIDevice *dev, char *command, bool need_spawn, Error **e
>>       }
>>   }
>>   
>> +static void proxy_vm_state_change(void *opaque, int running, RunState state)
>> +{
>> +    PCIProxyDev *dev = opaque;
>> +    MPQemuMsg msg = { 0 };
>> +
>> +    msg.cmd = RUNSTATE_SET;
>> +    msg.bytestream = 0;
>> +    msg.size = sizeof(msg.data1);
>> +    msg.data1.runstate.state = state;
>> +
>> +    mpqemu_msg_send(dev->mpqemu_link, &msg, dev->mpqemu_link->com);
>> +}
> 
> Changing vm state is a barrier operation - devices must not dirty memory
> afterwards.  This function doesn't have barrier semantics, it sends off
> the message without waiting for the remote process to finish processing
> it.  This means there is a race condition where QEMU has changes the vm
> state but devices could still dirty memory.  Please wait for a reply to
> prevent this.

Got it, thanks! Will do.

--
Jag

> 
> Stefan
> 

