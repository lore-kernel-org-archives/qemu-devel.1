Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57572C35247
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 00:30:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DF5D2064C
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 00:30:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DF5D2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izrWy-0007vi-DX
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 19:30:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59733)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <muriloo@linux.ibm.com>) id 1izrWQ-0007X8-0E
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 19:29:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <muriloo@linux.ibm.com>) id 1izrWO-0004z1-Fb
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 19:29:25 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32958)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <muriloo@linux.ibm.com>)
 id 1izrWO-0004yx-7I
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 19:29:24 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 01706fNb064939; Thu, 6 Feb 2020 19:29:14 -0500
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2y0n7gqy9t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 06 Feb 2020 19:29:14 -0500
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0170TDUk133794;
 Thu, 6 Feb 2020 19:29:13 -0500
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com
 [169.53.41.122])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2y0n7gqy9m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 06 Feb 2020 19:29:13 -0500
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
 by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 0170RKJf018092;
 Fri, 7 Feb 2020 00:29:12 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by ppma04dal.us.ibm.com with ESMTP id 2xykc9wh3s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 07 Feb 2020 00:29:12 +0000
Received: from b03ledav004.gho.boulder.ibm.com
 (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 0170TBSX59834826
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 7 Feb 2020 00:29:11 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7C5577805F;
 Fri,  7 Feb 2020 00:29:11 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 44C5A78069;
 Fri,  7 Feb 2020 00:29:10 +0000 (GMT)
Received: from localhost (unknown [9.85.203.48])
 by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTPS;
 Fri,  7 Feb 2020 00:29:09 +0000 (GMT)
From: Murilo Opsfelder =?ISO-8859-1?Q?Ara=FAjo?= <muriloo@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v1 09/13] util/mmap-alloc: Implement resizable mmaps
Date: Thu, 06 Feb 2020 21:29:07 -0300
Message-ID: <5327048.DvuYhMxLoT@kermit.br.ibm.com>
Organization: IBM
In-Reply-To: <20200203183125.164879-10-david@redhat.com>
References: <20200203183125.164879-1-david@redhat.com>
 <20200203183125.164879-10-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-02-06_04:2020-02-06,
 2020-02-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0
 adultscore=0 suspectscore=1 priorityscore=1501 malwarescore=0 phishscore=0
 mlxscore=0 clxscore=1015 spamscore=0 mlxlogscore=999 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002060173
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
 "Michael S . Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Greg Kurz <groug@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello, David.

On Monday, February 3, 2020 3:31:21 PM -03 David Hildenbrand wrote:
> Implement resizable mmaps. For now, the actual resizing is not wired up.
> Introduce qemu_ram_mmap_resizable() and qemu_ram_mmap_resize(). Make
> qemu_ram_mmap() a wrapper of qemu_ram_mmap_resizable().
>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Greg Kurz <groug@kaod.org>
> Cc: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  include/qemu/mmap-alloc.h | 21 ++++++++++++-------
>  util/mmap-alloc.c         | 44 ++++++++++++++++++++++++++++-----------
>  2 files changed, 45 insertions(+), 20 deletions(-)
>
> diff --git a/include/qemu/mmap-alloc.h b/include/qemu/mmap-alloc.h
> index e786266b92..70bc8e9637 100644
> --- a/include/qemu/mmap-alloc.h
> +++ b/include/qemu/mmap-alloc.h
> @@ -7,11 +7,13 @@ size_t qemu_fd_getpagesize(int fd);
>  size_t qemu_mempath_getpagesize(const char *mem_path);
>
>  /**
> - * qemu_ram_mmap: mmap the specified file or device.
> + * qemu_ram_mmap_resizable: reserve a memory region of @max_size to mmap
> the + *                          specified file or device and mmap @size of
> it. *
>   * Parameters:
>   *  @fd: the file or the device to mmap
>   *  @size: the number of bytes to be mmaped
> + *  @max_size: the number of bytes to be reserved
>   *  @align: if not zero, specify the alignment of the starting mapping
> address; *          otherwise, the alignment in use will be determined by
> QEMU. *  @shared: map has RAM_SHARED flag.
> @@ -21,12 +23,15 @@ size_t qemu_mempath_getpagesize(const char *mem_path);
>   *  On success, return a pointer to the mapped area.
>   *  On failure, return MAP_FAILED.
>   */
> -void *qemu_ram_mmap(int fd,
> -                    size_t size,
> -                    size_t align,
> -                    bool shared,
> -                    bool is_pmem);
> -
> -void qemu_ram_munmap(int fd, void *ptr, size_t size);
> +void *qemu_ram_mmap_resizable(int fd, size_t size, size_t max_size,
> +                              size_t align, bool shared, bool is_pmem);
> +void *qemu_ram_mmap_resize(void *ptr, int fd, size_t old_size, size_t
> new_size, +                           bool shared, bool is_pmem);
> +static inline void *qemu_ram_mmap(int fd, size_t size, size_t align,
> +                                  bool shared, bool is_pmem)
> +{
> +    return qemu_ram_mmap_resizable(fd, size, size, align, shared, is_pmem);
> +}
> +void qemu_ram_munmap(int fd, void *ptr, size_t max_size);
>
>  #endif
> diff --git a/util/mmap-alloc.c b/util/mmap-alloc.c
> index 63ad6893b7..2d562145e9 100644
> --- a/util/mmap-alloc.c
> +++ b/util/mmap-alloc.c
> @@ -172,11 +172,8 @@ static inline size_t mmap_pagesize(int fd)
>  #endif
>  }
>
> -void *qemu_ram_mmap(int fd,
> -                    size_t size,
> -                    size_t align,
> -                    bool shared,
> -                    bool is_pmem)
> +void *qemu_ram_mmap_resizable(int fd, size_t size, size_t max_size,
> +                              size_t align, bool shared, bool is_pmem)
>  {
>      const size_t pagesize = mmap_pagesize(fd);
>      size_t offset, total;
> @@ -184,12 +181,14 @@ void *qemu_ram_mmap(int fd,
>
>      /* we can only map whole pages */
>      size = QEMU_ALIGN_UP(size, pagesize);
> +    max_size = QEMU_ALIGN_UP(max_size, pagesize);
>
>      /*
>       * Note: this always allocates at least one extra page of virtual
> address -     * space, even if size is already aligned.
> +     * space, even if the size is already aligned. We will reserve an area
> of +     * at least max_size, but only populate the requested part of it.
> */
> -    total = size + align;
> +    total = max_size + align;
>
>      guardptr = mmap_reserve(0, total, fd);
>      if (guardptr == MAP_FAILED) {
> @@ -217,22 +216,43 @@ void *qemu_ram_mmap(int fd,
>       * a guard page guarding against potential buffer overflows.
>       */
>      total -= offset;
> -    if (total > size + pagesize) {
> -        munmap(ptr + size + pagesize, total - size - pagesize);
> +    if (total > max_size + pagesize) {
> +        munmap(ptr + max_size + pagesize, total - max_size - pagesize);
>      }
>
>      return ptr;
>  }
>
> -void qemu_ram_munmap(int fd, void *ptr, size_t size)
> +void *qemu_ram_mmap_resize(void *ptr, int fd, size_t old_size, size_t
> new_size, +                           bool shared, bool is_pmem)
>  {
>      const size_t pagesize = mmap_pagesize(fd);
>
>      /* we can only map whole pages */
> -    size = QEMU_ALIGN_UP(size, pagesize);
> +    old_size = QEMU_ALIGN_UP(old_size, pagesize);
> +    new_size = QEMU_ALIGN_UP(new_size, pagesize);

Shouldn't we just assert old_size and new_size are aligned with
pagesize?

> +
> +    /* we support actually resizable memory regions only on Linux */
> +    if (old_size < new_size) {
> +        /* populate the missing piece into the reserved area */
> +        ptr = mmap_populate(ptr + old_size, new_size - old_size, fd,
> old_size, +                            shared, is_pmem);
> +    } else if (old_size > new_size) {
> +        /* discard this piece, keeping the area reserved (should never
> fail) */ +        ptr = mmap_reserve(ptr + new_size, old_size - new_size,
> fd); +    }

I find the behaviour of this function somewhat confusing.  Perhaps I'm
missing something and need your help to clarify.  Please bear with me.

For the case where we want to grow in size, it returns a populated area
(PROT_READ | PROT_WRITE flags).

And for the case where we want to shrink in size, it returns a reserved
area (PROT_NONE flag), requiring the caller to call mmap_populate()
again to be able to use that memory.

I believe the behaviour should be consistent regardless if we want to
grow or shrink in size.  Either return a reserved or an already
populated area.  Not both.

Would "old_size == new_size" situation be possible?  In this case, ptr
would be returned without changing protection flags of the mapping.

Shouldn't we also assert that new_size <= max_size?

> +    return ptr;
> +}
> +
> +void qemu_ram_munmap(int fd, void *ptr, size_t max_size)
> +{
> +    const size_t pagesize = mmap_pagesize(fd);
> +
> +    /* we can only map whole pages */
> +    max_size = QEMU_ALIGN_UP(max_size, pagesize);

Shouldn't we just assert this and leave the alignment to the caller?

>
>      if (ptr) {
>          /* Unmap both the RAM block and the guard page */
> -        munmap(ptr, size + pagesize);
> +        munmap(ptr, max_size + pagesize);
>      }
>  }

--
Murilo

