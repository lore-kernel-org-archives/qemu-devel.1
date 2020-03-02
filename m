Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23346C3F2CD
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 19:29:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7BED2084E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 19:29:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="w1OjYAb/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7BED2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8qkz-0007zX-4u
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 14:29:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56289)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1j8qk5-00073B-G0
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 14:28:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1j8qk4-0005dz-6w
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 14:28:41 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:57526)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1j8qk3-0005dg-A4
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 14:28:39 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 022JRhjO085627;
 Mon, 2 Mar 2020 19:28:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=mime-version :
 message-id : date : from : to : cc : subject : references : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=My0Q+sKRdsArqWE1LbmddvVncOmMVglIqNKwUhi23HE=;
 b=w1OjYAb/a2IG6ab5Q2QY6Nz2V6t9eBIAgTUvRbl6wwPzf8AqqiMO0lo3HMkmYquX2HTZ
 StPNTgtxRp2GveXN6Wq4V/I0kF128SSE5nEjWmGFNCu580pblYSduoBieg8vzzbSlRVs
 Q44p6ylpSI1mamKmVcq04ceA1LiTj2oURQDq+9OfB3kZ94WCUwVTzKxPKpSRnM1wwUQt
 Xv6UbQaebCXcKIAQbEhUx9MsHXdxo38E+37mOPcmILUzrxVppxLec5mQwyNPj8WcfEp+
 Mwn1RiUV4QKdXlexUOxzGX1xm095WeweI5Ak1wwQXFOM6RJAH0RF47kUAzJFwmJPWw7i 1A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2130.oracle.com with ESMTP id 2yffcua0f9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 02 Mar 2020 19:28:27 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 022JSPkd032247;
 Mon, 2 Mar 2020 19:28:26 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3020.oracle.com with ESMTP id 2yg1p2g66f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 02 Mar 2020 19:28:26 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 022JSClR019702;
 Mon, 2 Mar 2020 19:28:12 GMT
Received: from [10.152.34.2] (/10.152.34.2) by default (Oracle Beehive Gateway
 v4.0) with ESMTP ; Mon, 02 Mar 2020 11:28:06 -0800
ORGANIZATION: Oracle Corporation
USER-AGENT: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Content-Language: en-US
MIME-Version: 1.0
Message-ID: <6f32987b-4d27-5a4d-ee91-fc9e021b0644@oracle.com>
Date: Mon, 2 Mar 2020 11:28:04 -0800 (PST)
From: Jag Raman <jag.raman@oracle.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v5 47/50] multi-process: Enable support for multiple
 devices in remote
References: <cover.1582576372.git.jag.raman@oracle.com>
 <cf33de60b827e0cdd3d5fce48eb038cb056dc304.1582576372.git.jag.raman@oracle.com>
 <20200228164403.GA332098@stefanha-x1.localdomain>
In-Reply-To: <20200228164403.GA332098@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9548
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003020126
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9548
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxscore=0 bulkscore=0
 adultscore=0 suspectscore=0 spamscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003020126
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, swapnil.ingle@nutanix.com,
 john.g.johnson@oracle.com, qemu-devel@nongnu.org, kraxel@redhat.com,
 quintela@redhat.com, mst@redhat.com, armbru@redhat.com,
 kanth.ghatraju@oracle.com, felipe@nutanix.com, thuth@redhat.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, dgilbert@redhat.com,
 liran.alon@oracle.com, pbonzini@redhat.com, rth@twiddle.net, kwolf@redhat.com,
 berrange@redhat.com, mreitz@redhat.com, ross.lagerwall@citrix.com,
 marcandre.lureau@gmail.com, thanos.makatos@nutanix.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2/28/2020 11:44 AM, Stefan Hajnoczi wrote:
> On Mon, Feb 24, 2020 at 03:55:38PM -0500, Jagannathan Raman wrote:
>> From: Elena Ufimtseva <elena.ufimtseva@oracle.com>
>>
>> Add support to allow multiple devices to be configured in the
>> remote process
> 
> This patch allows multiple devices to be addressed over a single UNIX
> domain socket.  This could be a scalability/performance bottleneck
> because an SMP guest can only talk to 1 device at a time.
> 
> This approach doesn't address the qemu-storage-daemon use case where one
> device emulation process provides devices to multiple guests.  Multiple
> UNIX domain sockets are needed for that.
> 
> Is multiplexing multiple devices over a single connection is a desirable
> feature?  The alternative of one UNIX domain socket per device instance
> seems more practical to me because it should perform better and solves
> the qemu-storage-daemon use case.

Hi Stefan,

We will implement a separate communication channel for each device in
the remote process, in the next series.

Thanks!
--
Jag

> 

