Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 459E5C1975A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 15:40:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 224E62073E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 15:40:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 224E62073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH89B-0004tb-9P
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 11:40:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44732)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <muriloo@linux.ibm.com>) id 1jH84q-0006LS-2A
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 11:36:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <muriloo@linux.ibm.com>) id 1jH84o-0004rN-K7
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 11:36:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:29222)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <muriloo@linux.ibm.com>)
 id 1jH84o-0004qq-AP
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 11:36:18 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02PFXIHH056741; Wed, 25 Mar 2020 11:36:09 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ywejxqtk0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Mar 2020 11:36:09 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 02PFXTeT057144;
 Wed, 25 Mar 2020 11:35:58 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.27])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ywejxqtcf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Mar 2020 11:35:58 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
 by ppma05wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 02PFZCAs025042;
 Wed, 25 Mar 2020 15:35:41 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by ppma05wdc.us.ibm.com with ESMTP id 2ywawfj9rc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Mar 2020 15:35:41 +0000
Received: from b03ledav006.gho.boulder.ibm.com
 (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 02PFZeT826149156
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 25 Mar 2020 15:35:40 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BFDDDC605A;
 Wed, 25 Mar 2020 15:35:40 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8E93CC605F;
 Wed, 25 Mar 2020 15:35:37 +0000 (GMT)
Received: from localhost (unknown [9.85.207.6])
 by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTPS;
 Wed, 25 Mar 2020 15:35:37 +0000 (GMT)
From: Murilo Opsfelder =?ISO-8859-1?Q?Ara=FAjo?= <muriloo@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v4 10/15] util/mmap-alloc: Prepare for resizeable mmaps
Date: Wed, 25 Mar 2020 12:09:12 -0300
Message-ID: <5052501.7tvaipRbP1@kermit.br.ibm.com>
Organization: IBM
In-Reply-To: <20200305142945.216465-11-david@redhat.com>
References: <20200305142945.216465-1-david@redhat.com>
 <20200305142945.216465-11-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.645
 definitions=2020-03-25_08:2020-03-24,
 2020-03-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015
 suspectscore=1 spamscore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003250124
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Kotrasinski <i.kotrasinsk@partner.samsung.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Peter Xu <peterx@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Greg Kurz <groug@kaod.org>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thursday, March 5, 2020 11:29:40 AM -03 David Hildenbrand wrote:
> When shrinking a mmap we want to re-reserve the already activated area.
> When growing a memory region, we want to activate starting with a given
> fd_offset. Prepare by allowing to pass these parameters.
>
> Also, let's make sure we always process full pages, to avoid
> unmapping/remapping pages that are already in use when
> growing/shrinking. Add some asserts.
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Cc: Igor Kotrasinski <i.kotrasinsk@partner.samsung.com>
> Cc: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Greg Kurz <groug@kaod.org>
> Cc: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---

Acked-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>

>  util/mmap-alloc.c | 34 +++++++++++++++++++++++-----------
>  1 file changed, 23 insertions(+), 11 deletions(-)
>
> diff --git a/util/mmap-alloc.c b/util/mmap-alloc.c
> index 8f40ef4fed..2767caa33b 100644
> --- a/util/mmap-alloc.c
> +++ b/util/mmap-alloc.c
> @@ -83,12 +83,12 @@ size_t qemu_mempath_getpagesize(const char *mem_path)
>  }
>
>  /*
> - * Reserve a new memory region of the requested size to be used for mapping
> - * from the given fd (if any).
> + * Reserve a new memory region of the requested size or re-reserve parts
> + * of an activated region to be used for mapping from the given fd (if
> any). */
> -static void *mmap_reserve(size_t size, int fd)
> +static void *mmap_reserve(void *ptr, size_t size, int fd)
>  {
> -    int flags = MAP_PRIVATE;
> +    int flags = MAP_PRIVATE | (ptr ? MAP_FIXED : 0);
>
>  #if defined(__powerpc64__) && defined(__linux__)
>      /*
> @@ -111,20 +111,24 @@ static void *mmap_reserve(size_t size, int fd)
>      flags |= MAP_ANONYMOUS;
>  #endif
>
> -    return mmap(0, size, PROT_NONE, flags, fd, 0);
> +    return mmap(ptr, size, PROT_NONE, flags, fd, 0);
>  }
>
>  /*
>   * Activate memory in a reserved region from the given fd (if any), to make
> * it accessible.
>   */
> -static void *mmap_activate(void *ptr, size_t size, int fd, bool shared,
> -                           bool is_pmem)
> +static void *mmap_activate(void *ptr, size_t size, int fd, size_t
> fd_offset, +                           bool shared, bool is_pmem)
>  {
>      int map_sync_flags = 0;
>      int flags = MAP_FIXED;
>      void *activated_ptr;
>
> +    if (fd == -1) {
> +        fd_offset = 0;
> +    }
> +
>      flags |= fd == -1 ? MAP_ANONYMOUS : 0;
>      flags |= shared ? MAP_SHARED : MAP_PRIVATE;
>      if (shared && is_pmem) {
> @@ -132,7 +136,7 @@ static void *mmap_activate(void *ptr, size_t size, int
> fd, bool shared, }
>
>      activated_ptr = mmap(ptr, size, PROT_READ | PROT_WRITE,
> -                         flags | map_sync_flags, fd, 0);
> +                         flags | map_sync_flags, fd, fd_offset);
>      if (activated_ptr == MAP_FAILED && map_sync_flags) {
>          if (errno == ENOTSUP) {
>              char *proc_link = g_strdup_printf("/proc/self/fd/%d", fd);
> @@ -154,7 +158,8 @@ static void *mmap_activate(void *ptr, size_t size, int
> fd, bool shared, * If mmap failed with MAP_SHARED_VALIDATE | MAP_SYNC, we
> will try * again without these flags to handle backwards compatibility. */
> -        activated_ptr = mmap(ptr, size, PROT_READ | PROT_WRITE, flags, fd,
> 0); +        activated_ptr = mmap(ptr, size, PROT_READ | PROT_WRITE, flags,
> fd, +                             fd_offset);
>      }
>      return activated_ptr;
>  }
> @@ -176,16 +181,19 @@ void *qemu_ram_mmap(int fd,
>                      bool is_pmem)
>  {
>      const size_t guard_pagesize = mmap_guard_pagesize(fd);
> +    const size_t pagesize = qemu_fd_getpagesize(fd);
>      size_t offset, total;
>      void *ptr, *guardptr;
>
> +    g_assert(QEMU_IS_ALIGNED(size, pagesize));
> +
>      /*
>       * Note: this always allocates at least one extra page of virtual
> address * space, even if size is already aligned.
>       */
>      total = size + align;
>
> -    guardptr = mmap_reserve(total, fd);
> +    guardptr = mmap_reserve(NULL, total, fd);
>      if (guardptr == MAP_FAILED) {
>          return MAP_FAILED;
>      }
> @@ -196,7 +204,7 @@ void *qemu_ram_mmap(int fd,
>
>      offset = QEMU_ALIGN_UP((uintptr_t)guardptr, align) -
> (uintptr_t)guardptr;
>
> -    ptr = mmap_activate(guardptr + offset, size, fd, shared, is_pmem);
> +    ptr = mmap_activate(guardptr + offset, size, fd, 0, shared, is_pmem);
>      if (ptr == MAP_FAILED) {
>          munmap(guardptr, total);
>          return MAP_FAILED;
> @@ -220,6 +228,10 @@ void *qemu_ram_mmap(int fd,
>
>  void qemu_ram_munmap(int fd, void *ptr, size_t size)
>  {
> +    const size_t pagesize = qemu_fd_getpagesize(fd);
> +
> +    g_assert(QEMU_IS_ALIGNED(size, pagesize));
> +
>      if (ptr) {
>          /* Unmap both the RAM block and the guard page */
>          munmap(ptr, size + mmap_guard_pagesize(fd));


--
Murilo

