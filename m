Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF27C3A5A2
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 00:50:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B94C922CF8
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 00:50:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XZ2Xtctf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B94C922CF8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5JVd-0007qA-HU
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 20:50:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58647)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1i5JUs-0007Kb-0t
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 20:50:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1i5JUq-0007Cy-9Q
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 20:50:05 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:44070)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1i5JUp-0007Bb-RG
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 20:50:04 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x840nSrx059394;
 Wed, 4 Sep 2019 00:49:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=KO+71rJCKmc/vYCZrWhHj76wP62oBCWWFSMRZzdpIo0=;
 b=XZ2Xtctf3fu6ebAoua212Hg3dpLUjfJWydmMJd4R7RiciOSHqCr5t4pKmnsHX2gZLtvB
 Ygo9H/7rBypi3qyR+/Y0WILu246n7G391N3HLl+gOn6atybk9mdtK99gINk8Dw3qzn5w
 K/I0rGO7jP82MRfQNAFAxKjJbm9kueFSx8bbjMHCn7aZy/cgL2sHa72j9O2Qb/MjEC1y
 9A2gUuZCrbWqF1FXnJSnuGDUqDt7Yz6oHOl9uDdzUUGllecqrzAX7UOEWl8MN7LwMtZA
 3waf72/owzAAP9ahx56XyWfV6kCg1XO/SuYimROwn7qj1hUPYqfyMdMqt9kif7y9uSUZ SQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2120.oracle.com with ESMTP id 2ut32bg06c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 04 Sep 2019 00:49:59 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x83L8OvD174155;
 Tue, 3 Sep 2019 21:16:31 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3030.oracle.com with ESMTP id 2usu51vmrb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 03 Sep 2019 21:16:31 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x83LGUQr018018;
 Tue, 3 Sep 2019 21:16:30 GMT
Received: from [10.152.34.2] (/10.152.34.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 03 Sep 2019 14:16:29 -0700
To: Gerd Hoffmann <kraxel@redhat.com>, elena.ufimtseva@oracle.com
References: <20190617181459.29139-1-elena.ufimtseva@oracle.com>
 <20190618051227.fic3k5ihwwj4zji7@sirius.home.kraxel.org>
From: Jag Raman <jag.raman@oracle.com>
Organization: Oracle Corporation
Message-ID: <fbb4a8fa-9d6c-c21d-7224-8e8af1fb1601@oracle.com>
Date: Tue, 3 Sep 2019 17:16:28 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190618051227.fic3k5ihwwj4zji7@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9369
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909030213
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9369
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909040005
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.85
Subject: Re: [Qemu-devel] [RFC PATCH v2 01/35] multi-process: memory: alloc
 RAM from file at offset
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
Cc: john.g.johnson@oracle.com, konrad.wilk@oracle.com, qemu-devel@nongnu.org,
 ross.lagerwall@citrix.com, liran.alon@oracle.com, stefanha@redhat.com,
 pbonzini@redhat.com, kanth.ghatraju@oracle.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 6/18/2019 1:12 AM, Gerd Hoffmann wrote:
> On Mon, Jun 17, 2019 at 11:14:59AM -0700, elena.ufimtseva@oracle.com wrote:
>> From: Jagannathan Raman <jag.raman@oracle.com>
>>
>> Allow RAM MemoryRegion to be created from an offset in a file, instead
>> of allocating at offset of 0 by default. This is needed to synchronize
>> RAM between QEMU & remote process.
>> This will be needed for the following patches.
> 
> Details please.   vhost-user works fine without this ...

Hi Gerd,

Sorry for the delayed response.

vhost-user doesn't use qemu_ram_alloc_from_fd(), it directly calls
mmap() to map the RAM onto the remote process.

Secondly, vhost-user uses its own functions (like vu_gpa_to_va()) for
address translation, whereas multi-process uses QEMU's existing
functions (address_space_rw()). Therefore, multi-process needs to use
qemu_ram_alloc_from_fd().

Lastly, updates to the system memory (received via MemoryListener) are
often in segments and not contiguous. Therefore, mapping these segments
in the remote process is possible only if we are able to allocate a
MemoryRegion at an offset in the memory backend.

Thanks!
--
Jag

> 
> cheers,
>    Gerd
> 
> 

