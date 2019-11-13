Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 551C8C432C3
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 16:22:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F80D21A49
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 16:22:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LoFjasAu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F80D21A49
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUvPD-0002vM-73
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 11:22:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42080)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1iUvOW-0002SU-H0
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 11:21:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1iUvOV-0006wD-9H
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 11:21:24 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:51004)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1iUvOV-0006vP-1N
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 11:21:23 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xADGEQg1170265;
 Wed, 13 Nov 2019 16:21:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=GN+LIruyivakxoQC/wssjeaIwXQLXJ08uM6Tz3LXFeE=;
 b=LoFjasAur1uThKBex2lz2cIkI+8I0Ux8rBn9s1UIFjBA7f4Wz3KrEcV1FZ9s3lhq9SuB
 3qTUC7paxQzNsHf1W3gyn9Sim8aufT3lr+1yZgW72APXX82c5nJEpQJy1/nBq8m0DsnA
 fPSdLNYY0m/m80QlTofiQMHpMPV3odPzf5TpBef9uuhm9R5gmtJg+fJxb2Lznrm6iyon
 oMITmZHjBW3h9AwkjkxgXtMg8l8TXVyA1e+czJIOGACL3JySNITzGCOf4guqg6TZKK+U
 /TgsoA3INzXr6kNSRmQd0Dt93fYc+0MgsB+zn+Fja5hxOhyuXoRionzLLnHO7EOOU5dn 5Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2120.oracle.com with ESMTP id 2w5p3qwfu9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 13 Nov 2019 16:21:13 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xADGIV8S075023;
 Wed, 13 Nov 2019 16:21:13 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3020.oracle.com with ESMTP id 2w7j0829j1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 13 Nov 2019 16:21:12 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xADGLALY008075;
 Wed, 13 Nov 2019 16:21:10 GMT
Received: from [10.152.34.2] (/10.152.34.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 13 Nov 2019 08:21:10 -0800
Subject: Re: [RFC v4 PATCH 47/49] multi-process: Enable support for multiple
 devices in remote
To: Stefan Hajnoczi <stefanha@redhat.com>
References: <cover.1571905346.git.jag.raman@oracle.com>
 <c67656abcd0e41278710460d2920036254ecffb7.1571905346.git.jag.raman@oracle.com>
 <20191111161542.GF402228@stefanha-x1.localdomain>
From: Jag Raman <jag.raman@oracle.com>
Organization: Oracle Corporation
Message-ID: <9529c2b2-7faf-1b1c-cb6e-a147930e24fb@oracle.com>
Date: Wed, 13 Nov 2019 11:21:08 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20191111161542.GF402228@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9439
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1910280000 definitions=main-1911130145
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9439
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1910280000
 definitions=main-1911130145
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



On 11/11/2019 11:15 AM, Stefan Hajnoczi wrote:
> On Thu, Oct 24, 2019 at 05:09:28AM -0400, Jagannathan Raman wrote:
>> @@ -93,7 +94,8 @@ static void process_config_write(MPQemuMsg *msg)
>>       struct conf_data_msg *conf = (struct conf_data_msg *)msg->data2;
>>   
>>       qemu_mutex_lock_iothread();
>> -    pci_default_write_config(remote_pci_dev, conf->addr, conf->val, conf->l);
>> +    pci_default_write_config(remote_pci_devs[msg->id], conf->addr, conf->val,
>> +                             conf->l);
>>       qemu_mutex_unlock_iothread();
>>   }
>>   
>> @@ -106,7 +108,8 @@ static void process_config_read(MPQemuMsg *msg)
>>       wait = msg->fds[0];
>>   
>>       qemu_mutex_lock_iothread();
>> -    val = pci_default_read_config(remote_pci_dev, conf->addr, conf->l);
>> +    val = pci_default_read_config(remote_pci_devs[msg->id], conf->addr,
>> +                                  conf->l);
>>       qemu_mutex_unlock_iothread();
>>   
>>       notify_proxy(wait, val);
> 
> msg->id was read from a socket and hasn't been validated before indexing
> into remote_pci_devs[].

We see the common thread, w.r.t your concerns about security. Thanks for
pointing them out.

We will fix this and other similar issues in the future.

Thank you very much!
--
Jag

> 

