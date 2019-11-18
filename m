Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A35C3C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 15:31:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6791220857
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 15:31:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OYJoe7/s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6791220857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWj0M-0005sv-Ix
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 10:31:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37836)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1iWiyI-0004Mz-CV
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 10:29:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1iWiyH-0002wX-3Z
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 10:29:46 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:33802)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1iWiyG-0002w3-Oo
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 10:29:44 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAIFNhE8063589;
 Mon, 18 Nov 2019 15:29:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=fDY4NLWdohMDrMUachqLYihE5QMPQrKN1b1WHsvSdBI=;
 b=OYJoe7/sILF/En4xUMXdqJcTO2HdF9Z3FebPTyCBi/kfHlsMosbTB853Ml2OP/A/Q8hj
 n424tQ87jp1T7qrwajz0X4dcl2B/oEt3EGWjmysjyuZYqq8bydPi3W4nkjzZ3IKmXwLR
 VWc2cyDKEZ4JBomXYCC08/au2Fo4RtvtU/qxBWDsAZwg7DsDedXeh8/v1ZYwq/fJBDJj
 evz/CRc0bm3WGIHGYPRLbSUupI5KNGxyaGrZH4qLw/V3AGgDrLGQ4Rmkvl361/qJyVNK
 DctAYxGCscUXHvXS5HaJtsPfX29vMVExz9wQD1I/GjYIM5y8jFo7kv60rw80sZATgYPr Gw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2130.oracle.com with ESMTP id 2wa8htgxq1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 18 Nov 2019 15:29:35 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAIFOAkA125461;
 Mon, 18 Nov 2019 15:29:34 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3020.oracle.com with ESMTP id 2wau8ne2dx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 18 Nov 2019 15:29:34 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xAIFTXQH005167;
 Mon, 18 Nov 2019 15:29:33 GMT
Received: from [10.152.34.2] (/10.152.34.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 18 Nov 2019 07:29:32 -0800
Subject: Re: [RFC v4 PATCH 10/49] multi-process: setup a machine object for
 remote device process
To: Stefan Hajnoczi <stefanha@redhat.com>
References: <cover.1571905346.git.jag.raman@oracle.com>
 <6df05bbf3cba4611b462879a7b937f40486cea0a.1571905346.git.jag.raman@oracle.com>
 <20191113162201.GE563983@stefanha-x1.localdomain>
From: Jag Raman <jag.raman@oracle.com>
Organization: Oracle Corporation
Message-ID: <d47faeae-d8fd-58bb-da2a-b19adf2b0ecc@oracle.com>
Date: Mon, 18 Nov 2019 10:29:31 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20191113162201.GE563983@stefanha-x1.localdomain>
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
 quintela@redhat.com, berrange@redhat.com, mst@redhat.com,
 qemu-devel@nongnu.org, armbru@redhat.com, ross.lagerwall@citrix.com,
 kanth.ghatraju@oracle.com, kraxel@redhat.com, kwolf@redhat.com,
 pbonzini@redhat.com, liran.alon@oracle.com, marcandre.lureau@gmail.com,
 mreitz@redhat.com, dgilbert@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 11/13/2019 11:22 AM, Stefan Hajnoczi wrote:
> On Thu, Oct 24, 2019 at 05:08:51AM -0400, Jagannathan Raman wrote:
>> +static NotifierList machine_init_done_notifiers =
>> +    NOTIFIER_LIST_INITIALIZER(machine_init_done_notifiers);
>> +
>> +bool machine_init_done;
>> +
>> +void qemu_add_machine_init_done_notifier(Notifier *notify)
>> +{
>> +    notifier_list_add(&machine_init_done_notifiers, notify);
>> +    if (machine_init_done) {
>> +        notify->notify(notify, NULL);
>> +    }
>> +}
>> +
>> +void qemu_remove_machine_init_done_notifier(Notifier *notify)
>> +{
>> +    notifier_remove(notify);
>> +}
>> +
>> +void qemu_run_machine_init_done_notifiers(void)
>> +{
>> +    machine_init_done = true;
>> +    notifier_list_notify(&machine_init_done_notifiers, NULL);
>> +}
> 
> qemu_add_machine_init_done_notifier() is already defined in vl.c.
> Please share the implementation instead of duplicating it into the
> remote program.
> 
>> +
>> +static void remote_machine_init(Object *obj)
>> +{
>> +    RemMachineState *s = REMOTE_MACHINE(obj);
>> +    RemPCIHost *rem_host;
>> +    MemoryRegion *system_memory, *system_io, *pci_memory;
>> +
>> +    Error *error_abort = NULL;
>> +
>> +    qemu_mutex_init(&ram_list.mutex);
> 
> Please keep global initialization separate from RemMachineState (e.g. do
> it in main() or a function called by main()).  This function should only
> initialize RemMachineState.

OK, will do!

> 
>> +
>> +    object_property_add_child(object_get_root(), "machine", obj, &error_abort);
>> +    if (error_abort) {
>> +        error_report_err(error_abort);
>> +    }
>> +
>> +    memory_map_init();
> 
> This is global init, please move it elsewhere.

Got it, thank you!

> 
>> +
>> +    system_memory = get_system_memory();
>> +    system_io = get_system_io();
>> +
>> +    pci_memory = g_new(MemoryRegion, 1);
>> +    memory_region_init(pci_memory, NULL, "pci", UINT64_MAX);
>> +
>> +    rem_host = REMOTE_HOST_DEVICE(qdev_create(NULL, TYPE_REMOTE_HOST_DEVICE));
>> +
>> +    rem_host->mr_pci_mem = pci_memory;
>> +    rem_host->mr_sys_mem = system_memory;
>> +    rem_host->mr_sys_io = system_io;
>> +
>> +    s->host = rem_host;
> 
> Both s and rem_host are QOM objects.  There should be a child property
> relationship between them here.  It will ensure that rem_host is cleaned
> up when s is cleaned up.  Please use that instead of a regular C
> pointer.

OK, will add a property linking these two as parent-child.

Thank you!
--
Jag

> 

