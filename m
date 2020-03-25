Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F0AEC54FCF
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 15:40:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DF0D20774
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 15:40:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DF0D20774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH88P-0003o4-Jm
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 11:40:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44608)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <muriloo@linux.ibm.com>) id 1jH84M-0005Yh-JH
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 11:35:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <muriloo@linux.ibm.com>) id 1jH84L-0004bq-1x
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 11:35:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36826)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <muriloo@linux.ibm.com>)
 id 1jH84K-0004bV-Od
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 11:35:48 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02PFXOV0085914; Wed, 25 Mar 2020 11:35:38 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ywfe9xt72-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Mar 2020 11:35:38 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 02PFXbqH087480;
 Wed, 25 Mar 2020 11:35:37 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com
 [169.55.91.170])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ywfe9xt67-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Mar 2020 11:35:37 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
 by ppma02wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 02PFZAIU030118;
 Wed, 25 Mar 2020 15:35:35 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by ppma02wdc.us.ibm.com with ESMTP id 2ywawk29uw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Mar 2020 15:35:35 +0000
Received: from b03ledav004.gho.boulder.ibm.com
 (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 02PFZYAG38666740
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 25 Mar 2020 15:35:34 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D3F7E78066;
 Wed, 25 Mar 2020 15:35:34 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6AEDD7805E;
 Wed, 25 Mar 2020 15:35:33 +0000 (GMT)
Received: from localhost (unknown [9.85.207.6])
 by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTPS;
 Wed, 25 Mar 2020 15:35:33 +0000 (GMT)
From: Murilo Opsfelder =?ISO-8859-1?Q?Ara=FAjo?= <muriloo@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v4 11/15] util/mmap-alloc: Implement resizeable mmaps
Date: Wed, 25 Mar 2020 12:14:18 -0300
Message-ID: <1980751.AR6ZJhPLDG@kermit.br.ibm.com>
Organization: IBM
In-Reply-To: <20200305142945.216465-12-david@redhat.com>
References: <20200305142945.216465-1-david@redhat.com>
 <20200305142945.216465-12-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.645
 definitions=2020-03-25_08:2020-03-24,
 2020-03-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0
 suspectscore=1 malwarescore=0 adultscore=0 mlxlogscore=999 clxscore=1015
 bulkscore=0 mlxscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003250124
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

On Thursday, March 5, 2020 11:29:41 AM -03 David Hildenbrand wrote:
> Implement resizeable mmaps. For now, the actual resizing is not wired up.
> Introduce qemu_ram_mmap_resizeable() and qemu_ram_mmap_resize(). Make
> qemu_ram_mmap() a wrapper of qemu_ram_mmap_resizeable().
>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Igor Kotrasinski <i.kotrasinsk@partner.samsung.com>
> Cc: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Greg Kurz <groug@kaod.org>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---

Acked-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>

>  include/qemu/mmap-alloc.h | 21 +++++++++++--------
>  util/mmap-alloc.c         | 43 ++++++++++++++++++++++++++++-----------
>  2 files changed, 44 insertions(+), 20 deletions(-)
>
> diff --git a/include/qemu/mmap-alloc.h b/include/qemu/mmap-alloc.h
> index e786266b92..ca8f7edf70 100644
> --- a/include/qemu/mmap-alloc.h
> +++ b/include/qemu/mmap-alloc.h
> @@ -7,11 +7,13 @@ size_t qemu_fd_getpagesize(int fd);
>  size_t qemu_mempath_getpagesize(const char *mem_path);
>
>  /**
> - * qemu_ram_mmap: mmap the specified file or device.
> + * qemu_ram_mmap_resizeable: reserve a memory region of @max_size to mmap
> the + *                           specified file or device and mmap @size
> of it. *
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
> +void *qemu_ram_mmap_resizeable(int fd, size_t size, size_t max_size,
> +                              size_t align, bool shared, bool is_pmem);
> +bool qemu_ram_mmap_resize(void *ptr, int fd, size_t old_size, size_t
> new_size, +                          bool shared, bool is_pmem);
> +static inline void *qemu_ram_mmap(int fd, size_t size, size_t align,
> +                                  bool shared, bool is_pmem)
> +{
> +    return qemu_ram_mmap_resizeable(fd, size, size, align, shared,
> is_pmem); +}
> +void qemu_ram_munmap(int fd, void *ptr, size_t max_size);
>
>  #endif
> diff --git a/util/mmap-alloc.c b/util/mmap-alloc.c
> index 2767caa33b..7ed85f16d3 100644
> --- a/util/mmap-alloc.c
> +++ b/util/mmap-alloc.c
> @@ -174,11 +174,8 @@ static inline size_t mmap_guard_pagesize(int fd)
>  #endif
>  }
>
> -void *qemu_ram_mmap(int fd,
> -                    size_t size,
> -                    size_t align,
> -                    bool shared,
> -                    bool is_pmem)
> +void *qemu_ram_mmap_resizeable(int fd, size_t size, size_t max_size,
> +                               size_t align, bool shared, bool is_pmem)
>  {
>      const size_t guard_pagesize = mmap_guard_pagesize(fd);
>      const size_t pagesize = qemu_fd_getpagesize(fd);
> @@ -186,12 +183,14 @@ void *qemu_ram_mmap(int fd,
>      void *ptr, *guardptr;
>
>      g_assert(QEMU_IS_ALIGNED(size, pagesize));
> +    g_assert(QEMU_IS_ALIGNED(max_size, pagesize));
>
>      /*
>       * Note: this always allocates at least one extra page of virtual
> address -     * space, even if size is already aligned.
> +     * space, even if the size is already aligned. We will reserve an area
> of +     * at least max_size, but only activate the requested part of it.
> */
> -    total = size + align;
> +    total = max_size + align;
>
>      guardptr = mmap_reserve(NULL, total, fd);
>      if (guardptr == MAP_FAILED) {
> @@ -219,21 +218,41 @@ void *qemu_ram_mmap(int fd,
>       * a guard page guarding against potential buffer overflows.
>       */
>      total -= offset;
> -    if (total > size + guard_pagesize) {
> -        munmap(ptr + size + guard_pagesize, total - size - guard_pagesize);
> +    if (total > max_size + guard_pagesize) {
> +        munmap(ptr + max_size + guard_pagesize,
> +               total - max_size - guard_pagesize);
>      }
>
>      return ptr;
>  }
>
> -void qemu_ram_munmap(int fd, void *ptr, size_t size)
> +bool qemu_ram_mmap_resize(void *ptr, int fd, size_t old_size, size_t
> new_size, +                          bool shared, bool is_pmem)
>  {
>      const size_t pagesize = qemu_fd_getpagesize(fd);
>
> -    g_assert(QEMU_IS_ALIGNED(size, pagesize));
> +    g_assert(QEMU_IS_ALIGNED(old_size, pagesize));
> +    g_assert(QEMU_IS_ALIGNED(new_size, pagesize));
> +
> +    if (old_size < new_size) {
> +        /* activate the missing piece in the reserved area */
> +        ptr = mmap_activate(ptr + old_size, new_size - old_size, fd,
> old_size, +                            shared, is_pmem);
> +    } else if (old_size > new_size) {
> +        /* discard this piece, marking it reserved */
> +        ptr = mmap_reserve(ptr + new_size, old_size - new_size, fd);
> +    }
> +    return ptr != MAP_FAILED;
> +}
> +
> +void qemu_ram_munmap(int fd, void *ptr, size_t max_size)
> +{
> +    const size_t pagesize = qemu_fd_getpagesize(fd);
> +
> +    g_assert(QEMU_IS_ALIGNED(max_size, pagesize));
>
>      if (ptr) {
>          /* Unmap both the RAM block and the guard page */
> -        munmap(ptr, size + mmap_guard_pagesize(fd));
> +        munmap(ptr, max_size + mmap_guard_pagesize(fd));
>      }
>  }


--
Murilo

