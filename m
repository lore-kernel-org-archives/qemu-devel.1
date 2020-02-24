Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 740F3C11D2F
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 14:17:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B7862072D
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 14:17:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B7862072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6EXu-0003Zd-Dl
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 09:17:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47728)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <muriloo@linux.ibm.com>) id 1j6EX7-00035V-MC
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 09:16:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <muriloo@linux.ibm.com>) id 1j6EX5-0004QK-Ph
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 09:16:29 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:4472
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <muriloo@linux.ibm.com>)
 id 1j6EX5-0004Py-KI
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 09:16:27 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 01OEFep8106815; Mon, 24 Feb 2020 09:16:24 -0500
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2yb161ts8p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Feb 2020 09:16:24 -0500
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 01OEGA51110429;
 Mon, 24 Feb 2020 09:16:23 -0500
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com
 [169.53.41.122])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2yb161ts7x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Feb 2020 09:16:23 -0500
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
 by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 01OEC3kT017577;
 Mon, 24 Feb 2020 14:16:22 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by ppma04dal.us.ibm.com with ESMTP id 2yaux6h365-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Feb 2020 14:16:22 +0000
Received: from b03ledav005.gho.boulder.ibm.com
 (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 01OEGKQH59244958
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Feb 2020 14:16:21 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CC8A0BE054;
 Mon, 24 Feb 2020 14:16:20 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AC3B6BE05A;
 Mon, 24 Feb 2020 14:16:19 +0000 (GMT)
Received: from localhost (unknown [9.85.197.149])
 by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTPS;
 Mon, 24 Feb 2020 14:16:19 +0000 (GMT)
From: Murilo Opsfelder =?ISO-8859-1?Q?Ara=FAjo?= <muriloo@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2 fixed 08/16] util/mmap-alloc: Factor out calculation of
 pagesize to mmap_pagesize()
Date: Mon, 24 Feb 2020 11:16:16 -0300
Message-ID: <3378805.CNlBlhNnSm@kermit.br.ibm.com>
Organization: IBM
In-Reply-To: <7252629e-6290-5709-ea3c-d215622975ed@redhat.com>
References: <20200212134254.11073-1-david@redhat.com>
 <94b76367-4730-33a8-59ba-6b1c978ec2ea@redhat.com>
 <7252629e-6290-5709-ea3c-d215622975ed@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-02-24_04:2020-02-21,
 2020-02-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1011
 bulkscore=0 impostorscore=0 adultscore=0 phishscore=0 malwarescore=0
 mlxscore=0 suspectscore=1 mlxlogscore=999 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002240118
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Kotrasinski <i.kotrasinsk@partner.samsung.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Peter Xu <peterx@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Greg Kurz <groug@kaod.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Monday, February 24, 2020 7:57:03 AM -03 David Hildenbrand wrote:
> On 24.02.20 11:50, David Hildenbrand wrote:
> > On 19.02.20 23:46, Peter Xu wrote:
> >> On Wed, Feb 12, 2020 at 02:42:46PM +0100, David Hildenbrand wrote:
> >>> Factor it out and add a comment.
> >>>
> >>> Reviewed-by: Igor Kotrasinski <i.kotrasinsk@partner.samsung.com>
> >>> Acked-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
> >>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> >>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> >>> Cc: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
> >>> Cc: Greg Kurz <groug@kaod.org>
> >>> Cc: Eduardo Habkost <ehabkost@redhat.com>
> >>> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> >>> Cc: Igor Mammedov <imammedo@redhat.com>
> >>> Signed-off-by: David Hildenbrand <david@redhat.com>
> >>> ---
> >>>
> >>>  util/mmap-alloc.c | 21 ++++++++++++---------
> >>>  1 file changed, 12 insertions(+), 9 deletions(-)
> >>>
> >>> diff --git a/util/mmap-alloc.c b/util/mmap-alloc.c
> >>> index 27dcccd8ec..82f02a2cec 100644
> >>> --- a/util/mmap-alloc.c
> >>> +++ b/util/mmap-alloc.c
> >>> @@ -82,17 +82,27 @@ size_t qemu_mempath_getpagesize(const char
> >>> *mem_path)
> >>>
> >>>      return qemu_real_host_page_size;
> >>>
> >>>  }
> >>>
> >>> +static inline size_t mmap_pagesize(int fd)
> >>> +{
> >>> +#if defined(__powerpc64__) && defined(__linux__)
> >>> +    /* Mappings in the same segment must share the same page size */
> >>> +    return qemu_fd_getpagesize(fd);
> >>> +#else
> >>> +    return qemu_real_host_page_size;
> >>> +#endif
> >>> +}
> >>
> >> Pure question: This will return 4K even for huge pages on x86, is this
> >> what we want?
> >
> > (was asking myself the same question) I *think* it's intended. It's
> > mainly only used to allocate one additional guard page. The callers of
> > qemu_ram_mmap() make sure that the size is properly aligned (e.g., to
> > huge pages).
> >
> > Of course, a 4k guard page is sufficient - unless we can't use that
> > (special case for ppc64 here).
> >
> > Thanks!
>
> We could rename the function to mmap_guard_pagesize(), thoughts?

The existing qemu_fd_getpagesize() already returns qemu_real_host_page_size for
non-anonymous mappings (when fd == -1).  I think this new mmap_pagesize() could
be dropped in favor of qemu_fd_getpagesize().

A side effect of this change would be guard page using a bit more memory for
non-anonymous mapping.  Could that be a problem?

What do you think?

--
Murilo

