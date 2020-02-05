Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BAB1C35247
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 21:03:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F3CC20720
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 21:03:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F3CC20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izRpN-0005by-Cj
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 16:03:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40978)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <muriloo@linux.ibm.com>) id 1izQmp-00086Y-Mi
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 14:56:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <muriloo@linux.ibm.com>) id 1izQml-0000bG-O7
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 14:56:35 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33646)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <muriloo@linux.ibm.com>)
 id 1izQmj-0000XT-UD
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 14:56:30 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 015Jtktn144982; Wed, 5 Feb 2020 14:56:21 -0500
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2xyhmy1dwx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 05 Feb 2020 14:56:20 -0500
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 015Jtk6e145022;
 Wed, 5 Feb 2020 14:56:20 -0500
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.11])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2xyhmy1dwk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 05 Feb 2020 14:56:20 -0500
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
 by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 015JntR0004368;
 Wed, 5 Feb 2020 19:56:19 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by ppma03dal.us.ibm.com with ESMTP id 2xykc9h239-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 05 Feb 2020 19:56:19 +0000
Received: from b03ledav006.gho.boulder.ibm.com
 (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 015JuISA46203296
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 5 Feb 2020 19:56:18 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4C0B8C6057;
 Wed,  5 Feb 2020 19:56:18 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2BBC2C6055;
 Wed,  5 Feb 2020 19:56:16 +0000 (GMT)
Received: from kermit.br.ibm.com (unknown [9.85.196.245])
 by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTPS;
 Wed,  5 Feb 2020 19:56:15 +0000 (GMT)
Subject: Re: [PATCH v1 07/13] util/mmap-alloc: Factor out populating of memory
 to mmap_populate()
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20200203183125.164879-1-david@redhat.com>
 <20200203183125.164879-8-david@redhat.com>
From: =?UTF-8?Q?Murilo_Opsfelder_Ara=c3=bajo?= <muriloo@linux.ibm.com>
Organization: IBM
Message-ID: <b387180c-762e-8bd5-a466-342e3451f574@linux.ibm.com>
Date: Wed, 5 Feb 2020 16:56:13 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200203183125.164879-8-david@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-02-05_06:2020-02-04,
 2020-02-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxscore=0
 spamscore=0 priorityscore=1501 mlxlogscore=999 phishscore=0
 impostorscore=0 malwarescore=0 suspectscore=2 adultscore=0
 lowpriorityscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2001150001 definitions=main-2002050151
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
X-Mailman-Approved-At: Wed, 05 Feb 2020 16:02:17 -0500
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
Reply-To: muriloo@linux.ibm.com
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Greg Kurz <groug@kaod.org>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello, David.

On 2/3/20 3:31 PM, David Hildenbrand wrote:
> We want to populate memory within a reserved memory region. Let's factor
> that out.
>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Greg Kurz <groug@kaod.org>
> Cc: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---

Acked-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>

A minor comment below.

>   util/mmap-alloc.c | 89 +++++++++++++++++++++++++----------------------
>   1 file changed, 47 insertions(+), 42 deletions(-)
>
> diff --git a/util/mmap-alloc.c b/util/mmap-alloc.c
> index 43a26f38a8..f043ccb0ab 100644
> --- a/util/mmap-alloc.c
> +++ b/util/mmap-alloc.c
> @@ -114,6 +114,50 @@ static void *mmap_reserve(size_t size, int fd)
>       return mmap(0, size, PROT_NONE, flags, fd, 0);
>   }
>
> +/*
> + * Populate memory in a reserved region from the given fd (if any).
> + */
> +static void *mmap_populate(void *ptr, size_t size, int fd, bool shared,
> +                           bool is_pmem)
> +{
> +    int map_sync_flags = 0;
> +    int flags = MAP_FIXED;
> +    void *new_ptr;

Do you think another name would be welcome here, e.g.: "populated_ptr" or
"populated_memptr" or just "populated"?

> +
> +    flags |= fd == -1 ? MAP_ANONYMOUS : 0;
> +    flags |= shared ? MAP_SHARED : MAP_PRIVATE;
> +    if (shared && is_pmem) {
> +        map_sync_flags = MAP_SYNC | MAP_SHARED_VALIDATE;
> +    }
> +
> +    new_ptr = mmap(ptr, size, PROT_READ | PROT_WRITE, flags | map_sync_flags,
> +                   fd, 0);
> +    if (new_ptr == MAP_FAILED && map_sync_flags) {
> +        if (errno == ENOTSUP) {
> +            char *proc_link = g_strdup_printf("/proc/self/fd/%d", fd);
> +            char *file_name = g_malloc0(PATH_MAX);
> +            int len = readlink(proc_link, file_name, PATH_MAX - 1);
> +
> +            if (len < 0) {
> +                len = 0;
> +            }
> +            file_name[len] = '\0';
> +            fprintf(stderr, "Warning: requesting persistence across crashes "
> +                    "for backend file %s failed. Proceeding without "
> +                    "persistence, data might become corrupted in case of host "
> +                    "crash.\n", file_name);
> +            g_free(proc_link);
> +            g_free(file_name);
> +        }
> +        /*
> +         * If mmap failed with MAP_SHARED_VALIDATE | MAP_SYNC, we will try
> +         * again without these flags to handle backwards compatibility.
> +         */
> +        new_ptr = mmap(ptr, size, PROT_READ | PROT_WRITE, flags, fd, 0);
> +    }
> +    return new_ptr;
> +}
> +
>   static inline size_t mmap_pagesize(int fd)
>   {
>   #if defined(__powerpc64__) && defined(__linux__)
> @@ -131,12 +175,8 @@ void *qemu_ram_mmap(int fd,
>                       bool is_pmem)
>   {
>       const size_t pagesize = mmap_pagesize(fd);
> -    int flags;
> -    int map_sync_flags = 0;
> -    size_t offset;
> -    size_t total;
> -    void *guardptr;
> -    void *ptr;
> +    size_t offset, total;
> +    void *ptr, *guardptr;
>
>       /*
>        * Note: this always allocates at least one extra page of virtual address
> @@ -153,44 +193,9 @@ void *qemu_ram_mmap(int fd,
>       /* Always align to host page size */
>       assert(align >= pagesize);
>
> -    flags = MAP_FIXED;
> -    flags |= fd == -1 ? MAP_ANONYMOUS : 0;
> -    flags |= shared ? MAP_SHARED : MAP_PRIVATE;
> -    if (shared && is_pmem) {
> -        map_sync_flags = MAP_SYNC | MAP_SHARED_VALIDATE;
> -    }
> -
>       offset = QEMU_ALIGN_UP((uintptr_t)guardptr, align) - (uintptr_t)guardptr;
>
> -    ptr = mmap(guardptr + offset, size, PROT_READ | PROT_WRITE,
> -               flags | map_sync_flags, fd, 0);
> -
> -    if (ptr == MAP_FAILED && map_sync_flags) {
> -        if (errno == ENOTSUP) {
> -            char *proc_link, *file_name;
> -            int len;
> -            proc_link = g_strdup_printf("/proc/self/fd/%d", fd);
> -            file_name = g_malloc0(PATH_MAX);
> -            len = readlink(proc_link, file_name, PATH_MAX - 1);
> -            if (len < 0) {
> -                len = 0;
> -            }
> -            file_name[len] = '\0';
> -            fprintf(stderr, "Warning: requesting persistence across crashes "
> -                    "for backend file %s failed. Proceeding without "
> -                    "persistence, data might become corrupted in case of host "
> -                    "crash.\n", file_name);
> -            g_free(proc_link);
> -            g_free(file_name);
> -        }
> -        /*
> -         * if map failed with MAP_SHARED_VALIDATE | MAP_SYNC,
> -         * we will remove these flags to handle compatibility.
> -         */
> -        ptr = mmap(guardptr + offset, size, PROT_READ | PROT_WRITE,
> -                   flags, fd, 0);
> -    }
> -
> +    ptr = mmap_populate(guardptr + offset, size, fd, shared, is_pmem);
>       if (ptr == MAP_FAILED) {
>           munmap(guardptr, total);
>           return MAP_FAILED;
>
--
Murilo

