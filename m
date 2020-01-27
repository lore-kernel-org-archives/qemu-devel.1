Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 389EBC2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 14:43:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CA0020720
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 14:43:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CA0020720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw5bt-0004AL-78
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 09:43:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37467)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pasic@linux.ibm.com>) id 1iw5aY-0002Ym-80
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 09:42:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pasic@linux.ibm.com>) id 1iw5aW-0002lR-UE
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 09:42:06 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56088)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pasic@linux.ibm.com>) id 1iw5aW-0002hn-MR
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 09:42:04 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 00REfmJS015517
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2020 09:42:01 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2xrfehubej-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2020 09:42:00 -0500
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <pasic@linux.ibm.com>;
 Mon, 27 Jan 2020 14:41:52 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 27 Jan 2020 14:41:47 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 00REfkx014746066
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 27 Jan 2020 14:41:46 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C7D4911C058;
 Mon, 27 Jan 2020 14:41:46 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 75EE611C050;
 Mon, 27 Jan 2020 14:41:46 +0000 (GMT)
Received: from oc2783563651 (unknown [9.152.224.43])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon, 27 Jan 2020 14:41:46 +0000 (GMT)
Date: Mon, 27 Jan 2020 15:41:45 +0100
From: Halil Pasic <pasic@linux.ibm.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH REPOST v3 78/80] hostmem: fix strict bind policy
In-Reply-To: <20200127083925.225859bc@redhat.com>
References: <1579779525-20065-1-git-send-email-imammedo@redhat.com>
 <1579779525-20065-79-git-send-email-imammedo@redhat.com>
 <20200124201748.1882b620.pasic@linux.ibm.com>
 <20200127083925.225859bc@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20012714-0028-0000-0000-000003D4D231
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20012714-0029-0000-0000-000024991671
Message-Id: <20200127154145.42e5a197.pasic@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-01-27_04:2020-01-24,
 2020-01-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0
 spamscore=0 bulkscore=0 clxscore=1015 mlxscore=0 mlxlogscore=999
 suspectscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1911200001 definitions=main-2001270124
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
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
Cc: ehabkost@redhat.com, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 gongsu@us.ibm.com, Stefan Hajnoczi <stefanha@redhat.com>,
 marcandre.lureau@redhat.com, pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 27 Jan 2020 08:39:25 +0100
Igor Mammedov <imammedo@redhat.com> wrote:

> On Fri, 24 Jan 2020 20:17:48 +0100
> Halil Pasic <pasic@linux.ibm.com> wrote:
> 
> > On Thu, 23 Jan 2020 12:38:43 +0100
> > Igor Mammedov <imammedo@redhat.com> wrote:
> > 
> > > With main RAM now converted to hostmem backends, there is no
> > > point in keeping global mem_prealloc around, so alias
> > >  -mem-prealloc to "memory-backend.prealloc=on"
> > > machine compat[*] property and make mem_prealloc a local
> > > variable to only stir registration of compat property.
> > > 
> > > *) currently user accessible -global works only with DEVICE
> > >    based objects and extra work is needed to make it work
> > >    with hostmem backends. But that is convenience option
> > >    and out of scope of this already huge refactoring.
> > >    Hence machine compat properties were used.  
> > 
> > AFAIU because of this something like
> > -global memory-backend-file.share=on
> > (as proposed by
> > https://lists.nongnu.org/archive/html/qemu-devel/2019-12/msg00531.html)
> > can not be used to make the main RAM shared (e.g. for vhost on s390x).
> > Or am I wrong? If not, is -global still the way we want to make this work
> > for non-numa machines, or did I miss updates?
> 
> one should be able to use memory-backend property to make it work
> instead of -m convenience option in s390 case.

Thank you very much for the quick response!

Honestly, I overlooked the memory-backed machine property, but regardless
of that -machine,memory-backend=id *does not seem viable* at the
moment.

My understanding is that one has to do something like:        
-machine type=s390-ccw-virtio,memory-backend=mem \
-object memory-backend-file,id=mem,size=2G,mem-path=/dev/shm/virtiofs.shm,share=on \

I get 
qemu: : Device 'mem' not found
because the 'memory-backend-*' objects are delayed,
i.e. !object_create_initial(), and at the time when
machine_set_property() tries to look the memory-backend up the
memory-backend is not yet created.

For why delayed, object_create_initial()  has a comment:

    /* Memory allocation by backends needs to be done
     * after configure_accelerator() (due to the tcg_enabled()
     * checks at memory_region_init_*()).
     *
     * Also, allocation of large amounts of memory may delay
     * chardev initialization for too long, and trigger timeouts
     * on software that waits for a monitor socket to be created
     * (e.g. libvirt).
     */
    if (g_str_has_prefix(type, "memory-backend-")) {

Or, am I using it wrong?

> 
> As for -global for objects (or more limited variant for memory-backends),
> it needs more work to support objects. (that's mostly policy decision)
> 

I agree.

Regards,
Halil


