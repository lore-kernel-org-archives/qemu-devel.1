Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B79A9C432C3
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 15:27:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82A5020857
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 15:27:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gHRoD1G/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82A5020857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWivh-0001ys-MU
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 10:27:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37047)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1iWiv2-0001Xc-OT
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 10:26:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1iWiv1-0001eK-H9
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 10:26:24 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:38832)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1iWiv1-0001dR-7X
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 10:26:23 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAIFNeTE053080;
 Mon, 18 Nov 2019 15:26:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=bgnQ9+oe+Th5wplYR4tOyi0Q3cC+SeiyQdm0LfQ4GgU=;
 b=gHRoD1G/PsqdK7BqZro5tWhYXYiqMrv92C7ykKwUw7g4Ch7/I2and2krRyEiDd1uomhg
 iFbWs6JLpeMbH9ZpXDuKjWMxEgh6+juviDDYzUb4sIFAl1JF3d1ATNtBGKoeBJHzNiHU
 Pye3vhpAKc2yDxsSUOPT5kxn590HNWfTT0T4nhWkl0heyQEgOSC+ydotxf6N/pmhuqWD
 9ri44NLTOx6r+AjCI3/N7vJ1f6DWjLrcmzv7Zp3C9G5mRrNxHYTw0SbyJzBK4eJsQWnv
 rtCMs/MDOFnG515Iq2s/cVQuqeNFOc7niAyQAf8+VpduFGHqHGaNIu+lASYNcBEql9Kd qg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by aserp2120.oracle.com with ESMTP id 2wa92pguwd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 18 Nov 2019 15:26:06 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAIFNaP7149126;
 Mon, 18 Nov 2019 15:26:05 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3030.oracle.com with ESMTP id 2watjxpvst-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 18 Nov 2019 15:26:05 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xAIFQ1vt030808;
 Mon, 18 Nov 2019 15:26:02 GMT
Received: from [10.152.34.2] (/10.152.34.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 18 Nov 2019 07:26:01 -0800
Subject: Re: [RFC v4 PATCH 09/49] multi-process: setup PCI host bridge for
 remote device
To: Stefan Hajnoczi <stefanha@redhat.com>
References: <cover.1571905346.git.jag.raman@oracle.com>
 <21b8d0f06279f177f2daca8779ced48af14139ee.1571905346.git.jag.raman@oracle.com>
 <20191113160737.GD563983@stefanha-x1.localdomain>
From: Jag Raman <jag.raman@oracle.com>
Organization: Oracle Corporation
Message-ID: <e6e01c0c-ffd3-21f6-bf2c-db46258121af@oracle.com>
Date: Mon, 18 Nov 2019 10:25:59 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20191113160737.GD563983@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9445
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911180141
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9445
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911180141
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



On 11/13/2019 11:07 AM, Stefan Hajnoczi wrote:
> On Thu, Oct 24, 2019 at 05:08:50AM -0400, Jagannathan Raman wrote:
>> +static void remote_host_realize(DeviceState *dev, Error **errp)
>> +{
>> +    PCIHostState *pci = PCI_HOST_BRIDGE(dev);
>> +    RemPCIHost *s = REMOTE_HOST_DEVICE(dev);
>> +
>> +    /*
>> +     * TODO: the name of the bus would be provided by QEMU. Use
>> +     * "pcie.0" for now.
>> +     */
>> +    pci->bus = pci_root_bus_new(DEVICE(s), "pcie.0",
>> +                                s->mr_pci_mem, s->mr_sys_io,
>> +                                0, TYPE_PCIE_BUS);
> 
> The PCI bus name could be a property and then whatever instantiates
> RemPCIHost could set it.
> 
> Machine types usually hardcode the name because they assume there is
> only one machine instance.  In the case of mpqemu this is an okay
> starting point, but maybe multiple busses will become necessary if the
> device emulation process handles multiple device instances - especially
> if they are served to multiple guests like in a software-defined network
> switch use case.

Are you referring to a case where a single remote process will emulate
devices from multiple guests?

We haven't thought about that application. But we will certainly add the
ability to specify the name of the bus as a parameter.

Thank you very much!
--
Jag

> 

