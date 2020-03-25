Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00DF3C1975A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 15:39:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1D582073E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 15:39:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1D582073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH87U-00028w-21
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 11:39:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44641)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <muriloo@linux.ibm.com>) id 1jH84S-0005jJ-My
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 11:35:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <muriloo@linux.ibm.com>) id 1jH84R-0004eV-EX
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 11:35:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52126
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <muriloo@linux.ibm.com>)
 id 1jH84R-0004e2-7F
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 11:35:55 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02PFYbT8017806; Wed, 25 Mar 2020 11:35:47 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2ywbuww8q8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Mar 2020 11:35:47 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 02PFZII5022468;
 Wed, 25 Mar 2020 11:35:46 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com
 [169.53.41.122])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2ywbuww8pd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Mar 2020 11:35:46 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
 by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 02PFZAZd029623;
 Wed, 25 Mar 2020 15:35:45 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26]) by ppma04dal.us.ibm.com with ESMTP id 2ywawg2wmw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Mar 2020 15:35:45 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com
 [9.57.199.109])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 02PFZimZ14549728
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 25 Mar 2020 15:35:44 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C5965112061;
 Wed, 25 Mar 2020 15:35:44 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1F891112062;
 Wed, 25 Mar 2020 15:35:43 +0000 (GMT)
Received: from localhost (unknown [9.85.207.6])
 by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTPS;
 Wed, 25 Mar 2020 15:35:42 +0000 (GMT)
From: Murilo Opsfelder =?ISO-8859-1?Q?Ara=FAjo?= <muriloo@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v4 07/15] util/mmap-alloc: Factor out calculation of the
 pagesize for the guard page
Date: Wed, 25 Mar 2020 12:03:55 -0300
Message-ID: <3833117.a91c8e1GSb@kermit.br.ibm.com>
Organization: IBM
In-Reply-To: <20200305142945.216465-8-david@redhat.com>
References: <20200305142945.216465-1-david@redhat.com>
 <20200305142945.216465-8-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.645
 definitions=2020-03-25_07:2020-03-24,
 2020-03-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 bulkscore=0
 adultscore=0 mlxscore=0 phishscore=0 impostorscore=0 mlxlogscore=999
 suspectscore=1 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003250123
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
 Igor Kotrasinski <i.kotrasinsk@partner.samsung.com>, qemu-devel@nongnu.org,
 Peter Xu <peterx@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Greg Kurz <groug@kaod.org>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thursday, March 5, 2020 11:29:37 AM -03 David Hildenbrand wrote:
> Let's factor out calculating the size of the guard page and rename the
> variable to make it clearer that this pagesize only applies to the
> guard page.
>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
> Cc: Greg Kurz <groug@kaod.org>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---

Acked-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>

>  util/mmap-alloc.c | 31 ++++++++++++++++---------------
>  1 file changed, 16 insertions(+), 15 deletions(-)
>
> diff --git a/util/mmap-alloc.c b/util/mmap-alloc.c
> index 27dcccd8ec..f0277f9fad 100644
> --- a/util/mmap-alloc.c
> +++ b/util/mmap-alloc.c
> @@ -82,17 +82,27 @@ size_t qemu_mempath_getpagesize(const char *mem_path)
>      return qemu_real_host_page_size;
>  }
>
> +static inline size_t mmap_guard_pagesize(int fd)
> +{
> +#if defined(__powerpc64__) && defined(__linux__)
> +    /* Mappings in the same segment must share the same page size */
> +    return qemu_fd_getpagesize(fd);
> +#else
> +    return qemu_real_host_page_size;
> +#endif
> +}
> +
>  void *qemu_ram_mmap(int fd,
>                      size_t size,
>                      size_t align,
>                      bool shared,
>                      bool is_pmem)
>  {
> +    const size_t guard_pagesize = mmap_guard_pagesize(fd);
>      int flags;
>      int map_sync_flags = 0;
>      int guardfd;
>      size_t offset;
> -    size_t pagesize;
>      size_t total;
>      void *guardptr;
>      void *ptr;
> @@ -113,8 +123,7 @@ void *qemu_ram_mmap(int fd,
>       * anonymous memory is OK.
>       */
>      flags = MAP_PRIVATE;
> -    pagesize = qemu_fd_getpagesize(fd);
> -    if (fd == -1 || pagesize == qemu_real_host_page_size) {
> +    if (fd == -1 || guard_pagesize == qemu_real_host_page_size) {
>          guardfd = -1;
>          flags |= MAP_ANONYMOUS;
>      } else {
> @@ -123,7 +132,6 @@ void *qemu_ram_mmap(int fd,
>      }
>  #else
>      guardfd = -1;
> -    pagesize = qemu_real_host_page_size;
>      flags = MAP_PRIVATE | MAP_ANONYMOUS;
>  #endif
>
> @@ -135,7 +143,7 @@ void *qemu_ram_mmap(int fd,
>
>      assert(is_power_of_2(align));
>      /* Always align to host page size */
> -    assert(align >= pagesize);
> +    assert(align >= guard_pagesize);
>
>      flags = MAP_FIXED;
>      flags |= fd == -1 ? MAP_ANONYMOUS : 0;
> @@ -189,8 +197,8 @@ void *qemu_ram_mmap(int fd,
>       * a guard page guarding against potential buffer overflows.
>       */
>      total -= offset;
> -    if (total > size + pagesize) {
> -        munmap(ptr + size + pagesize, total - size - pagesize);
> +    if (total > size + guard_pagesize) {
> +        munmap(ptr + size + guard_pagesize, total - size - guard_pagesize);
> }
>
>      return ptr;
> @@ -198,15 +206,8 @@ void *qemu_ram_mmap(int fd,
>
>  void qemu_ram_munmap(int fd, void *ptr, size_t size)
>  {
> -    size_t pagesize;
> -
>      if (ptr) {
>          /* Unmap both the RAM block and the guard page */
> -#if defined(__powerpc64__) && defined(__linux__)
> -        pagesize = qemu_fd_getpagesize(fd);
> -#else
> -        pagesize = qemu_real_host_page_size;
> -#endif
> -        munmap(ptr, size + pagesize);
> +        munmap(ptr, size + mmap_guard_pagesize(fd));
>      }
>  }


--
Murilo

