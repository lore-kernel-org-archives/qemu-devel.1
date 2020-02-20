Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C66FDC11D20
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 21:08:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93D4C206F4
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 21:08:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U+tsK2PS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93D4C206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4t3N-0002En-NE
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 16:08:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45805)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1j4t2W-0001lx-3G
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 16:07:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1j4t2U-0005BS-27
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 16:07:19 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31228
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1j4t2T-0005Au-UB
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 16:07:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582232836;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uCY2b+4NQFP+jzCgTZm8keO/eWvNOK2cvIZRJmSJjsw=;
 b=U+tsK2PSqUXOSHl4aikOgBkXWn/CZ0dVaCZ6bQlhTOIPBlnhTKVozTMthCv5v7NKlV99E7
 8fZkDIC8FqDdsslJ3CLgsk6pro1NYUSD32Y7hkYnLXX7WuIQW67tW8gF6iAp3zNyxM43V2
 bbWKMi3rWnQhwcWldw0wEq3i687/1L4=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161-YsmhvJtKOLGYTE6OShv2tA-1; Thu, 20 Feb 2020 16:07:15 -0500
Received: by mail-qv1-f70.google.com with SMTP id cn2so3503441qvb.1
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2020 13:07:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=UiSEWZYjvJjknuXZ10zDeSeue9slcM5dhVkJ1FqAFSw=;
 b=DpdKW4f/eVCcq9IUS4y3yXXYsomBlkRwOaGRmrYWQlhu1z5mRy9QbyPu3b7sRuABL+
 pxO6pqYcVqlp5BGCuGUMHpWXy4SqtadwzT4tA/bnWdLA9XsD8bFaiKnG/IRrhw6oqRjz
 q0UJbo58OS1g9K/j0wCmKvVREzH7Rhe9YNShb2TMXYckNgqa6+MAgbX6a3SIIWV6sd8s
 A7Y6gyUNjffBkWDKheMx4QbXA1vYCCG7jHPku6h6aggRmpbM4Jsg1t2Hw53GiJGw+0Oo
 17C66l4LQnXs5gGPQ90wzJM64wJrkL3Z1NVWBVodNy5R1ogtmmj3zs9LzfFoeuNCgc4M
 nqrg==
X-Gm-Message-State: APjAAAVmqREeMAt1IP1xFElRjla3x4U63xUFJTeBlr+H/PONLjHKjt10
 Bd6ptZMgcqR5I6FnQScEtYtErUl7YPKTuEoAFv7t87dpBeKdkUzNrcvuRhfp9sAomt9LSxJ2N3/
 iZWBOKoQEOC9n4uM=
X-Received: by 2002:a37:9d7:: with SMTP id 206mr27088293qkj.416.1582232834525; 
 Thu, 20 Feb 2020 13:07:14 -0800 (PST)
X-Google-Smtp-Source: APXvYqxCPm1AqqQ5Pa14KugGC7VDKOTSHewsckf8BgUXkcP8zeTV0YRNGdq8od0NipQxi8Rha/4HQg==
X-Received: by 2002:a37:9d7:: with SMTP id 206mr27088261qkj.416.1582232834071; 
 Thu, 20 Feb 2020 13:07:14 -0800 (PST)
Received: from xz-x1 ([104.156.64.75])
 by smtp.gmail.com with ESMTPSA id k16sm410174qkh.55.2020.02.20.13.07.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2020 13:07:13 -0800 (PST)
Date: Thu, 20 Feb 2020 16:07:12 -0500
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v1 13/13] migrate/ram: Tolerate partially changed
 mappings in postcopy code
Message-ID: <20200220210712.GA18283@xz-x1>
References: <20200219161725.115218-1-david@redhat.com>
 <20200219161725.115218-14-david@redhat.com>
 <9887ef65-12b1-37d5-cbf3-fda0b7d7fda7@redhat.com>
MIME-Version: 1.0
In-Reply-To: <9887ef65-12b1-37d5-cbf3-fda0b7d7fda7@redhat.com>
X-MC-Unique: YsmhvJtKOLGYTE6OShv2tA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Andrea Arcangeli <aarcange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Feb 20, 2020 at 12:24:42PM +0100, David Hildenbrand wrote:
> On 19.02.20 17:17, David Hildenbrand wrote:
> > When we partially change mappings (e.g., mmap over parts of an existing
> > mmap) where we have a userfaultfd handler registered, the handler will
> > implicitly be unregistered from the parts that changed. This is e.g., t=
he
> > case when doing a qemu_ram_remap(), but is also a preparation for RAM
> > blocks with resizable allocations and we're shrinking RAM blocks.
> >=20
> > When the mapping is changed and the handler is removed, any waiters are
> > woken up. Trying to place pages will fail. We can simply ignore erors
> > due to that when placing pages - as the mapping changed on the migratio=
n
> > destination, also the content is stale. E.g., after shrinking a RAM
> > block, nobody should be using that memory. After doing a
> > qemu_ram_remap(), the old memory is expected to have vanished.
> >=20
> > Let's tolerate such errors (but still warn for now) when placing pages.
> > Also, add a comment why unregistering will continue to work even though
> > the mapping might have changed.
> >=20
> > Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > Cc: Juan Quintela <quintela@redhat.com>
> > Cc: Peter Xu <peterx@redhat.com>
> > Cc: Andrea Arcangeli <aarcange@redhat.com>
> > Signed-off-by: David Hildenbrand <david@redhat.com>
> > ---
> >  migration/postcopy-ram.c | 43 ++++++++++++++++++++++++++++++++++------
> >  1 file changed, 37 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> > index c68caf4e42..df9d27c004 100644
> > --- a/migration/postcopy-ram.c
> > +++ b/migration/postcopy-ram.c
> > @@ -506,6 +506,13 @@ static int cleanup_range(RAMBlock *rb, void *opaqu=
e)
> >      range_struct.start =3D (uintptr_t)host_addr;
> >      range_struct.len =3D length;
> > =20
> > +    /*
> > +     * In case the mapping was partially changed since we enabled user=
fault
> > +     * (esp. when whrinking RAM blocks and we have resizable allocatio=
ns, or
> > +     * via qemu_ram_remap()), the userfaultfd handler was already remo=
ved for
> > +     * the mappings that changed. Unregistering will, however, still w=
ork and
> > +     * ignore mappings without a registered handler.
> > +     */
> >      if (ioctl(mis->userfault_fd, UFFDIO_UNREGISTER, &range_struct)) {
> >          error_report("%s: userfault unregister %s", __func__, strerror=
(errno));
> > =20
> > @@ -1239,10 +1246,28 @@ int postcopy_place_page(MigrationIncomingState =
*mis, void *host, void *from,
> >       */
> >      if (qemu_ufd_copy_ioctl(mis->userfault_fd, host, from, pagesize, r=
b)) {
> >          int e =3D errno;
> > -        error_report("%s: %s copy host: %p from: %p (size: %zd)",
> > -                     __func__, strerror(e), host, from, pagesize);
> > =20
> > -        return -e;
> > +        /*
> > +         * When the mapping gets partially changed before we try to pl=
ace a page
> > +         * (esp. when whrinking RAM blocks and we have resizable alloc=
ations, or
> > +         * via qemu_ram_remap()), the userfaultfd handler will be remo=
ved and
> > +         * placing pages will fail. In that case, any waiter was alrea=
dy woken
> > +         * up when the mapping was changed. We can safely ignore this,=
 as
> > +         * mappings that change once we're running on the destination =
imply
> > +         * that memory of these mappings vanishes. Let's still print a=
 warning
> > +         * for now.
> > +         *
>=20
> After talking to Andrea, on mapping changes, no waiter will be woken up
> automatically. We have to do an UFFDIO_WAKE, which even works when there
> is no longer a handler registered for that reason. Interesting stuff :)

Yes actually it makes sense. :)

Though I do think it should hardly happen, otherwise even if it's
waked up it'll still try to access that GPA and KVM will be confused
on that and exit because no memslot was setup for that.  Then I think
it's a fatal VM error.  In other words, I feel like the resizing
should be blocked somehow by that stall vcpu too (e.g., even if we
want to reboot a Linux guest, it'll sync between vcpus, and same to
bootstraping).

Btw, I feel like we cannot always depend on the fact that userfaultfd
will dissapear itself if the VMA is unmapped, because even it's true
it'll only be true for shrinking of memories.  How about extending
memory in the future?  So IIUC if we want to really fix this, we
probably need to take care of uffd register and unregister of changed
memory regions, which AFAIUI can be done inside your newly introduced
resize hook...

We probably need to take care of other things that might be related to
ramblock resizing too in the same notifier.  One I can think of is to
realloc the ramblock.receivedmap otherwise we could have some bit
cleared forever for shrinking memories (which logically when migration
finishes that bitmap should be all set).

Thanks,

--=20
Peter Xu


