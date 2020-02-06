Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C59DEC2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 12:32:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95170214AF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 12:32:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95170214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izgL2-0006sv-Qk
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 07:32:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45820)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <muriloo@linux.ibm.com>) id 1izgJy-0006Oh-DL
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 07:31:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <muriloo@linux.ibm.com>) id 1izgJw-0003bY-Np
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 07:31:50 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:18174)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <muriloo@linux.ibm.com>)
 id 1izgJw-0003X2-FH
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 07:31:48 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 016CPb0v011137; Thu, 6 Feb 2020 07:31:45 -0500
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2xyphxgsqb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 06 Feb 2020 07:31:45 -0500
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 016CSMpk023799;
 Thu, 6 Feb 2020 07:31:44 -0500
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com
 [169.63.214.131])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2xyphxgspg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 06 Feb 2020 07:31:44 -0500
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
 by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 016CV4bQ017693;
 Thu, 6 Feb 2020 12:31:43 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27]) by ppma01dal.us.ibm.com with ESMTP id 2xykc981w2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 06 Feb 2020 12:31:43 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com
 [9.57.199.110])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 016CVgkh28377510
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 6 Feb 2020 12:31:42 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 233F0AE060;
 Thu,  6 Feb 2020 12:31:42 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AA126AE05F;
 Thu,  6 Feb 2020 12:31:41 +0000 (GMT)
Received: from localhost (unknown [9.18.235.214])
 by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTPS;
 Thu,  6 Feb 2020 12:31:41 +0000 (GMT)
From: Murilo Opsfelder =?ISO-8859-1?Q?Ara=FAjo?= <muriloo@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v1 08/13] util/mmap-alloc: Prepare for resizable mmaps
Date: Thu, 06 Feb 2020 09:31:40 -0300
Message-ID: <6458667.Kg4MDSSyM0@kermit.br.ibm.com>
Organization: IBM
In-Reply-To: <5c261bcd-44df-b4a0-451d-83ec6ac48059@redhat.com>
References: <20200203183125.164879-1-david@redhat.com>
 <2036195.sfUKtyktLc@kermit.br.ibm.com>
 <5c261bcd-44df-b4a0-451d-83ec6ac48059@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-02-06_01:2020-02-06,
 2020-02-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0
 priorityscore=1501 mlxscore=0 clxscore=1015 suspectscore=1 phishscore=0
 mlxlogscore=977 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002060094
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

On Thursday, February 6, 2020 5:52:26 AM -03 David Hildenbrand wrote:
> On 06.02.20 00:00, Murilo Opsfelder Ara=FAjo wrote:
> > Hello, David.
> >
> > On Monday, February 3, 2020 3:31:20 PM -03 David Hildenbrand wrote:
> >> When shrinking a mmap we want to re-reserve the already populated area.
> >> When growing a memory region, we want to populate starting with a given
> >> fd_offset. Prepare by allowing to pass these parameters.
> >>
> >> Also, let's make sure we always process full pages, to avoid
> >> unmapping/remapping pages that are already in use when
> >> growing/shrinking. (existing callers seem to guarantee this, but that's
> >> not obvious)
> >>
> >> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> >> Cc: Greg Kurz <groug@kaod.org>
> >> Cc: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
> >> Cc: Eduardo Habkost <ehabkost@redhat.com>
> >> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> >> Signed-off-by: David Hildenbrand <david@redhat.com>
> >> ---
> >>
> >>  util/mmap-alloc.c | 32 +++++++++++++++++++++-----------
> >>  1 file changed, 21 insertions(+), 11 deletions(-)
> >>
> >> diff --git a/util/mmap-alloc.c b/util/mmap-alloc.c
> >> index f043ccb0ab..63ad6893b7 100644
> >> --- a/util/mmap-alloc.c
> >> +++ b/util/mmap-alloc.c
> >> @@ -83,12 +83,12 @@ size_t qemu_mempath_getpagesize(const char *mem_pa=
th)
> >>
> >>  }
> >>
> >>  /*
> >>
> >> - * Reserve a new memory region of the requested size to be used for
> >> mapping - * from the given fd (if any).
> >> + * Reserve a new memory region of the requested size or re-reserve pa=
rts
> >> + * of an existing region to be used for mapping from the given fd (if
> >> any). */
> >> -static void *mmap_reserve(size_t size, int fd)
> >> +static void *mmap_reserve(void *ptr, size_t size, int fd)
> >>
> >>  {
> >>
> >> -    int flags =3D MAP_PRIVATE;
> >> +    int flags =3D MAP_PRIVATE | (ptr ? MAP_FIXED : 0);
> >>
> >>  #if defined(__powerpc64__) && defined(__linux__)
> >>
> >>      /*
> >>
> >> @@ -111,19 +111,23 @@ static void *mmap_reserve(size_t size, int fd)
> >>
> >>      flags |=3D MAP_ANONYMOUS;
> >>
> >>  #endif
> >>
> >> -    return mmap(0, size, PROT_NONE, flags, fd, 0);
> >> +    return mmap(ptr, size, PROT_NONE, flags, fd, 0);
> >>
> >>  }
> >>
> >>  /*
> >>
> >>   * Populate memory in a reserved region from the given fd (if any).
> >>   */
> >>
> >> -static void *mmap_populate(void *ptr, size_t size, int fd, bool share=
d,
> >> -                           bool is_pmem)
> >> +static void *mmap_populate(void *ptr, size_t size, int fd, size_t
> >> fd_offset, +                           bool shared, bool is_pmem)
> >>
> >>  {
> >>
> >>      int map_sync_flags =3D 0;
> >>      int flags =3D MAP_FIXED;
> >>      void *new_ptr;
> >>
> >> +    if (fd =3D=3D -1) {
> >> +        fd_offset =3D 0;
> >> +    }
> >> +
> >>
> >>      flags |=3D fd =3D=3D -1 ? MAP_ANONYMOUS : 0;
> >>      flags |=3D shared ? MAP_SHARED : MAP_PRIVATE;
> >>      if (shared && is_pmem) {
> >>
> >> @@ -131,7 +135,7 @@ static void *mmap_populate(void *ptr, size_t size,
> >> int
> >> fd, bool shared, }
> >>
> >>      new_ptr =3D mmap(ptr, size, PROT_READ | PROT_WRITE, flags |
> >>
> >> map_sync_flags, -                   fd, 0);
> >> +                   fd, fd_offset);
> >>
> >>      if (new_ptr =3D=3D MAP_FAILED && map_sync_flags) {
> >>
> >>          if (errno =3D=3D ENOTSUP) {
> >>
> >>              char *proc_link =3D g_strdup_printf("/proc/self/fd/%d", f=
d);
> >>
> >> @@ -153,7 +157,7 @@ static void *mmap_populate(void *ptr, size_t size,
> >> int
> >> fd, bool shared, * If mmap failed with MAP_SHARED_VALIDATE | MAP_SYNC,=
 we
> >> will try * again without these flags to handle backwards compatibility.
> >> */
> >> -        new_ptr =3D mmap(ptr, size, PROT_READ | PROT_WRITE, flags, fd=
, 0);
> >> +        new_ptr =3D mmap(ptr, size, PROT_READ | PROT_WRITE, flags, fd,
> >> fd_offset); }
> >>
> >>      return new_ptr;
> >>
> >>  }
> >>
> >> @@ -178,13 +182,16 @@ void *qemu_ram_mmap(int fd,
> >>
> >>      size_t offset, total;
> >>      void *ptr, *guardptr;
> >>
> >> +    /* we can only map whole pages */
> >> +    size =3D QEMU_ALIGN_UP(size, pagesize);
> >> +
> >
> > Caller already rounds up size to block->page_size.
> >
> > Why this QEMU_ALIGN_UP is necessary?
>
> Thanks for having a look
>
> I guess you read the patch description, right? :)
>
> "(existing callers seem to guarantee this, but that's
>   not obvious)"
>
> Do you prefer a g_assert(IS_ALIGNED()) instead?

I guess you mean QEMU_IS_ALIGNED().  But yes, I think we could just check
alignments here, so callers do the alignments first.

We could have, for example, a new helper function mmap_align(int size) that
returned size already aligned.

>
> Thanks!

=2D-
Murilo

