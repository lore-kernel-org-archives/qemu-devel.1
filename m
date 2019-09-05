Return-Path: <SRS0=/Jg5=XA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F99DC43331
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 15:26:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 041D2206B8
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 15:26:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ocKY6gPu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 041D2206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5teZ-0005Fr-Ea
	for qemu-devel@archiver.kernel.org; Thu, 05 Sep 2019 11:26:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43451)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1i5tcr-0003dN-SJ
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 11:24:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1i5tcq-0008Vx-Qm
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 11:24:45 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:36136)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1i5tcq-0008Vl-HW
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 11:24:44 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x85FNvIX100632;
 Thu, 5 Sep 2019 15:24:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=QQq9muQwxeiGHA+WWYgdYpz59782dGR3cMzanP+69F8=;
 b=ocKY6gPuZj6vu6rhFqgxkZLTmmV4AXezVAPvQ7QqkSaGnTnIukQIdrvnZUAfOK2LmCKH
 s/Svk2dmiZDDgFVv8r2S4Fp/DKqWHxEpHIZCW5NOHGgy70p/cBGl4i/dGsx49u3jJeum
 r2A9NCCoTlHUJpHTVdDwQkPRZiJcKnbNcVZlZWk6wrdomNKGE9JvMYffb90+anf+NmWT
 PBUyNJpSN1qigpEB3a6goKHlPaVP4I40e3BFNU5g3j6JmFjFdb8DQ/sE1hMLj5GF4Q73
 seTCT08OCJVY27SlFPodcOKwIw37oLCUc0wDcWj8Egy85+/9dirGJjxOkzaIFLK/7s7M DA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2120.oracle.com with ESMTP id 2uu4rxg34d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 05 Sep 2019 15:24:35 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x85FAc7p025082;
 Thu, 5 Sep 2019 15:22:35 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3020.oracle.com with ESMTP id 2utvr3ryyp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 05 Sep 2019 15:22:34 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x85FMXRB025232;
 Thu, 5 Sep 2019 15:22:33 GMT
Received: from [10.152.34.2] (/10.152.34.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 05 Sep 2019 08:22:33 -0700
To: Gerd Hoffmann <kraxel@redhat.com>
References: <cover.1567534653.git.jag.raman@oracle.com>
 <4c59e3b3d38d1e269be889cc31859ea97c15b2ff.1567534653.git.jag.raman@oracle.com>
 <20190905102234.ut5vrfr7uixnzwvq@sirius.home.kraxel.org>
From: Jag Raman <jag.raman@oracle.com>
Organization: Oracle Corporation
Message-ID: <0298aef6-8c17-9fa0-191c-bc53a0cd7c0b@oracle.com>
Date: Thu, 5 Sep 2019 11:22:31 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190905102234.ut5vrfr7uixnzwvq@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9371
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909050144
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9371
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909050144
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.85
Subject: Re: [Qemu-devel] [RFC v3 PATCH 19/45] multi-process: Add LSI device
 proxy object
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
 mst@redhat.com, quintela@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com,
 ross.lagerwall@citrix.com, mreitz@redhat.com, kanth.ghatraju@oracle.com,
 berrange@redhat.com, stefanha@redhat.com, pbonzini@redhat.com,
 liran.alon@oracle.com, marcandre.lureau@gmail.com, kwolf@redhat.com,
 dgilbert@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 9/5/2019 6:22 AM, Gerd Hoffmann wrote:
>    Hi,
> 
>> +static uint64_t proxy_lsi_io_read(void *opaque, hwaddr addr, unsigned size)
>> +{
>> +    ProxyLSIState *s = opaque;
>> +
>> +    return proxy_default_bar_read(PCI_PROXY_DEV(s), &s->io_io, addr, size,
>> +                                  false);
>> +}
>> +
>> +static void proxy_lsi_io_write(void *opaque, hwaddr addr, uint64_t val,
>> +                               unsigned size)
>> +{
>> +    ProxyLSIState *s = opaque;
>> +
>> +    proxy_default_bar_write(PCI_PROXY_DEV(s), &s->io_io, addr, val, size,
>> +                            false);
>> +}
>> +
>> +static const MemoryRegionOps proxy_lsi_io_ops = {
>> +    .read = proxy_lsi_io_read,
>> +    .write = proxy_lsi_io_write,
>> +    .endianness = DEVICE_NATIVE_ENDIAN,
>> +    .impl = {
>> +        .min_access_size = 1,
>> +        .max_access_size = 1,
>> +    },
>> +};
> 
> Hmm, as more devices get proxy support there will be alot of simliar
> boilerplate.
> 
> I think it would be useful to have a
> 
> struct pci_device_description {
> 	u16 vendor_id,
> 	u16 device_id,
> 	[ ... ]
> 	struct {
> 		[ ... ]
> 	} bar[6];
> };
> 
>> +    proxy_class->realize = proxy_lsi_realize;
>> +    proxy_class->command = g_strdup("qemu-scsi-dev");
> 
> Hook that up here (proxy_class->description = &lsi_description),
> then have the pci proxy realize function setup everything.  All pci
> bar access is just forwarded to the proxy, that should be doable
> without duplicating the code for each proxied pci device ...
> 
> At least parts of the pci_device_description can probably also used for
> non-proxy device setup (should work for pci config space, probably
> would not work for memory regions as they are very device specific).

Sounds great. We'll move similar boilerplate code to the pci proxy
class in the next rev.

Thanks!
--
Jag

> 
> cheers,
>    Gerd
> 
> 

