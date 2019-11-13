Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65FCFC432C3
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 16:52:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D642C206D3
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 16:52:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Nbn/TQt7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D642C206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUvd4-0002L1-3w
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 11:36:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43817)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1iUvbu-0001KF-M5
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 11:35:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1iUvbs-00040n-K8
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 11:35:14 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:40186)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1iUvbq-0003zm-Ia
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 11:35:12 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xADGOTH7180257;
 Wed, 13 Nov 2019 16:35:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=V/dTZw0gWV8ji4lwJwg/OugmlNP4UkDg2a9CtzarUPo=;
 b=Nbn/TQt7BmpU3DMAbE6UtztVskhgGT0lSPYv5fhwcs4Lez7povoL4HB3YlSbys1Bz9Hw
 P4chbZPhHT+Kq1JX/U/CE2NaESnK/xA9fixcbRxV041rBfpHV7BfSlVSI8mKFFUgN2Tc
 mzC0zhxoZi1+y6tOwFzHmOu1aBHPrh3n+7l0o9MrPLpkFTiEiqm38KfJKV0QssykE6xQ
 WBag+nBsn7i9hnv/q02y1HhLzt+AX3XrefgKLZIwAI1XHLhuyTAFwwNf0GRR6kLGwFVE
 qk4Yckhh4YImiKO1VAu4WP09vW8Tn3+bSFPnstjoVPJLtjJ+xgZkM8prBEhCZOcnfhTm 1w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2120.oracle.com with ESMTP id 2w5p3qwjw3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 13 Nov 2019 16:35:03 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xADGR01d156170;
 Wed, 13 Nov 2019 16:35:02 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3030.oracle.com with ESMTP id 2w8g17smwg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 13 Nov 2019 16:35:02 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xADGYodZ017055;
 Wed, 13 Nov 2019 16:34:50 GMT
Received: from [10.152.34.2] (/10.152.34.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 13 Nov 2019 08:34:50 -0800
Subject: Re: [RFC v4 PATCH 11/49] multi-process: setup memory manager for
 remote device
To: Stefan Hajnoczi <stefanha@redhat.com>
References: <cover.1571905346.git.jag.raman@oracle.com>
 <5bfab4fa2f7f12137d0030e08a494d9ac3e11f04.1571905346.git.jag.raman@oracle.com>
 <20191113163300.GF563983@stefanha-x1.localdomain>
From: Jag Raman <jag.raman@oracle.com>
Organization: Oracle Corporation
Message-ID: <2dcd1375-881d-4c53-1599-21ccf154e085@oracle.com>
Date: Wed, 13 Nov 2019 11:34:49 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20191113163300.GF563983@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9440
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1910280000 definitions=main-1911130146
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9440
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
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
 quintela@redhat.com, berrange@redhat.com, mst@redhat.com,
 qemu-devel@nongnu.org, armbru@redhat.com, ross.lagerwall@citrix.com,
 kanth.ghatraju@oracle.com, kraxel@redhat.com, kwolf@redhat.com,
 pbonzini@redhat.com, liran.alon@oracle.com, marcandre.lureau@gmail.com,
 mreitz@redhat.com, dgilbert@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 11/13/2019 11:33 AM, Stefan Hajnoczi wrote:
> On Thu, Oct 24, 2019 at 05:08:52AM -0400, Jagannathan Raman wrote:
>> +static void remote_ram_destructor(MemoryRegion *mr)
>> +{
>> +    qemu_ram_free(mr->ram_block);
>> +}
>> +
>> +static void remote_ram_init_from_fd(MemoryRegion *mr, int fd, uint64_t size,
>> +                                    ram_addr_t offset, Error **errp)
>> +{
>> +    char *name = g_strdup_printf("%d", fd);
>> +
>> +    memory_region_init(mr, NULL, name, size);
>> +    mr->ram = true;
>> +    mr->terminates = true;
>> +    mr->destructor = NULL;
>> +    mr->align = 0;
>> +    mr->ram_block = qemu_ram_alloc_from_fd(size, mr, RAM_SHARED, fd, offset,
>> +                                           errp);
>> +    mr->dirty_log_mask = tcg_enabled() ? (1 << DIRTY_MEMORY_CODE) : 0;
>> +
>> +    g_free(name);
>> +}
> 
> This is not specific to remote/memory.c and could be shared in case
> something else in QEMU wants to initialize from an fd.
> 
>> +
>> +void remote_sysmem_reconfig(MPQemuMsg *msg, Error **errp)
>> +{
>> +    sync_sysmem_msg_t *sysmem_info = &msg->data1.sync_sysmem;
> 
> A possible security issue with MPQemuMsg: was the message size
> validatedb before we access msg->data1.sync_sysmem?
> 
> If not, then we might access uninitialized data.  I didn't see if there
> is a single place in the code that always zeroes msg, but I think the
> answer is no.  Accessing uninitialized data could expose the old
> contents of the stack/heap to the other process.  Information leaks like
> this can be used to defeat address-space randomization because the other
> process may learn about our memory layout if there are memory addresses
> in the uninitialized data.

Thanks for the feedback. Will do.

--
Jag

> 

