Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BDA9C33CA1
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 16:21:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C4C923762
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 16:03:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="X1BJ6tun"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C4C923762
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUv74-0002eC-FK
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 11:03:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39502)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1iUv5F-0001KN-15
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 11:01:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1iUv5C-0007u5-Rt
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 11:01:27 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:41266)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1iUv5C-0007ti-HY
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 11:01:26 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xADFxPG5184711;
 Wed, 13 Nov 2019 16:01:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=UrcrXeFYsAMWyvMKxJQHOi0fyGnqK04kJ29J94/VgLU=;
 b=X1BJ6tunUaIZUu7nFjGnOnCZ8Dro4vhBZnWMajtmeNmcSL2c0DJQp4T+waRA3JCqLDdm
 RGw+Zf0drFnyl345SpBKYK47cQYBOL5QjejndeaeXK5+jUhfb8i266KY5AgsQZ6mr/8M
 ukyxfEfBUvEAXaCsPAJn4maZVENYXLf+dgWfaj/4E6IBpTLisIawabZaYyd9hyspI5wq
 J9bjejnGYr/5v0RtQRo1/SQw4JVrOLQdtKW8BNlRXFgSVTGQJjCezwjIwbGjOOIAzHYi
 2q0bW1zlqzhqn7exyO9DonUQJ5Fz275+C/BuHzq8HuG8vY8ea7CBr6nX8SXpq2PC2RtV 2g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2130.oracle.com with ESMTP id 2w5mvtwfce-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 13 Nov 2019 16:01:12 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xADFxGrA152052;
 Wed, 13 Nov 2019 16:01:12 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3020.oracle.com with ESMTP id 2w7vbd3sqc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 13 Nov 2019 16:01:12 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xADG18Ax006571;
 Wed, 13 Nov 2019 16:01:09 GMT
Received: from [10.152.34.2] (/10.152.34.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 13 Nov 2019 08:01:08 -0800
Subject: Re: [RFC v4 PATCH 30/49] multi-process: send heartbeat messages to
 remote
To: Stefan Hajnoczi <stefanha@redhat.com>
References: <cover.1571905346.git.jag.raman@oracle.com>
 <14c33104778e77fcf2e7f0df2a1dd96fbcaf49d7.1571905346.git.jag.raman@oracle.com>
 <20191111162750.GJ402228@stefanha-x1.localdomain>
From: Jag Raman <jag.raman@oracle.com>
Organization: Oracle Corporation
Message-ID: <6f063381-c842-9c03-280f-1e9652a15881@oracle.com>
Date: Wed, 13 Nov 2019 11:01:07 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20191111162750.GJ402228@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9439
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1910280000 definitions=main-1911130144
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9439
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1910280000
 definitions=main-1911130144
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.86
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



On 11/11/2019 11:27 AM, Stefan Hajnoczi wrote:
> On Thu, Oct 24, 2019 at 05:09:11AM -0400, Jagannathan Raman wrote:
>> +static void broadcast_msg(MPQemuMsg *msg, bool need_reply)
>> +{
>> +    PCIProxyDev *entry;
>> +    unsigned int pid;
>> +    int wait;
>> +
>> +    QLIST_FOREACH(entry, &proxy_dev_list.devices, next) {
>> +        if (need_reply) {
>> +            wait = eventfd(0, EFD_NONBLOCK);
>> +            msg->num_fds = 1;
>> +            msg->fds[0] = wait;
>> +        }
>> +
>> +        mpqemu_msg_send(entry->mpqemu_link, msg, entry->mpqemu_link->com);
>> +        if (need_reply) {
>> +            pid = (uint32_t)wait_for_remote(wait);
> 
> Sometimes QEMU really needs to wait for the remote process before it can
> make progress.  I think this is not one of those cases though.
> 
> Since QEMU is event-driven it's problematic to invoke blocking system
> calls.  The remote process might not respond for a significant amount of
> time.  Other QEMU threads will be held up waiting for the QEMU global
> mutex in the meantime (because we hold it!).

There are places where we wait synchronously for the remote process.
However, these synchronous waits carry a timeout to prevent the hang
situation you described above.

We will add an error recovery in the future. That is, we will respawn
the remote process if the QEMU times out waiting for it.

> 
> Please implement heartbeat/ping asynchronously.  The wait eventfd should
> be read by an event loop fd handler instead.  That way QEMU can continue
> with running the VM while waiting for the remote process.

In the current implementation, the heartbeat/ping is asynchronous.
start_heartbeat_timer() sets up a timer to perform the ping.

Thanks!
--
Jag

> 
> This will also improve guest performance because there will be less
> jitter (random latency because the event loop is held up waiting for
> remote processes for short periods of time).
> 

