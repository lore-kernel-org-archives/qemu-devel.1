Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5747EC4CEC9
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 13:36:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30CD1206B6
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 13:36:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30CD1206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBJ5R-0004Hs-72
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 09:36:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55159)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iBJ26-0001tu-Cu
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 09:33:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iBJ24-0004Yw-Ia
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 09:33:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38664)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>)
 id 1iBJ24-0004YX-9q; Fri, 20 Sep 2019 09:33:08 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8E9018980F6;
 Fri, 20 Sep 2019 13:33:06 +0000 (UTC)
Received: from gondolin (dhcp-192-230.str.redhat.com [10.33.192.230])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A30CC5DD78;
 Fri, 20 Sep 2019 13:32:59 +0000 (UTC)
Date: Fri, 20 Sep 2019 15:32:57 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: David Hildenbrand <david@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>
Subject: Re: [PULL 00/34] s390x update
Message-ID: <20190920153257.0e4302d7.cohuck@redhat.com>
In-Reply-To: <8050fccb-e39f-1745-0728-129e42222ef1@redhat.com>
References: <20190919124115.11510-1-cohuck@redhat.com>
 <CAFEAcA-WLayY+jL9mKV6zrstSZOynja7=k6Cjx4wR9g33jFPQA@mail.gmail.com>
 <20190920130038.4eaad8f0.cohuck@redhat.com>
 <2b470747-b881-d7e6-1c8c-0a446b044fb9@redhat.com>
 <8050fccb-e39f-1745-0728-129e42222ef1@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.67]); Fri, 20 Sep 2019 13:33:06 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: qemu-s390x <qemu-s390x@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 20 Sep 2019 13:59:12 +0200
David Hildenbrand <david@redhat.com> wrote:

> On 20.09.19 13:51, David Hildenbrand wrote:
> > On 20.09.19 13:00, Cornelia Huck wrote:  
> >> On Fri, 20 Sep 2019 11:45:18 +0100
> >> Peter Maydell <peter.maydell@linaro.org> wrote:
> >>  
> >>> On Thu, 19 Sep 2019 at 13:41, Cornelia Huck <cohuck@redhat.com> wrote:  
> >>>>
> >>>> The following changes since commit f8c3db33a5e863291182f8862ddf81618a7c6194:
> >>>>
> >>>>   target/sparc: Switch to do_transaction_failed() hook (2019-09-17 12:01:00 +0100)
> >>>>
> >>>> are available in the Git repository at:
> >>>>
> >>>>   https://github.com/cohuck/qemu tags/s390x-20190919
> >>>>
> >>>> for you to fetch changes up to 37105adebeb28e60da3cb1ef82231d7ed8d23589:
> >>>>
> >>>>   Merge tag 'tags/s390-ccw-bios-2019-09-18' into s390-next-staging (2019-09-19 12:04:01 +0200)
> >>>>
> >>>> ----------------------------------------------------------------
> >>>> - bugfixes in tcg and the ccw bios
> >>>> - gen15a is called z15
> >>>> - officially require a 3.15 kernel or later for kvm
> >>>>
> >>>> ----------------------------------------------------------------    
> >>>
> >>> Hi -- I'm afraid this pullreq results in new warnings from
> >>> the runtime-sanitizer build when 'make check' is run:
> >>> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> >>> QTEST_QEMU_BINARY=s390x-softmmu/qemu-system-s390x
> >>> QTEST_QEMU_IMG=qemu-img tests
> >>> /boot-serial-test -m=quick -k --tap < /dev/null |
> >>> ./scripts/tap-driver.pl --test-name="boot-serial-test"
> >>> /home/petmay01/linaro/qemu-for-merges/target/s390x/mem_helper.c:293:17:
> >>> runtime error: null pointer passed as argument 1, which is declared to
> >>> never be null
> >>> /usr/include/string.h:47:14: note: nonnull attribute specified here
> >>> /home/petmay01/linaro/qemu-for-merges/target/s390x/mem_helper.c:293:32:
> >>> runtime error: null pointer passed as argument 2, which is declared to
> >>> never be null
> >>>
> >>> (and the same warnings for a few other tests).
> >>>
> >>> Looks like you sometimes can pass NULL pointers to the source
> >>> and destination of memmove(). This isn't permitted by the
> >>> standard even in the case where the size argument is zero.
> >>>
> >>> thanks
> >>> -- PMM  
> >>
> >> David, can you take a look?
> >>  
> > 
> > I would have assumed these pointers are ignored in case the length is
> > zero, too (the only way this can happen). Easy to fix.
> >   
> 
> 
> diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
> index e50cec9263..ef8e0c20a7 100644
> --- a/target/s390x/mem_helper.c
> +++ b/target/s390x/mem_helper.c
> @@ -290,17 +290,23 @@ static void access_memmove(CPUS390XState *env, S390Access *desta,
>  
>      if (srca->size1 == desta->size1) {
>          memmove(desta->haddr1, srca->haddr1, srca->size1);
> -        memmove(desta->haddr2, srca->haddr2, srca->size2);
> +        if (likely(srca->size2)) {
> +            memmove(desta->haddr2, srca->haddr2, srca->size2);
> +        }
>      } else if (srca->size1 < desta->size1) {
>          diff = desta->size1 - srca->size1;
>          memmove(desta->haddr1, srca->haddr1, srca->size1);
>          memmove(desta->haddr1 + srca->size1, srca->haddr2, diff);
> -        memmove(desta->haddr2, srca->haddr2 + diff, desta->size2);
> +        if (likely(desta->size2)) {
> +            memmove(desta->haddr2, srca->haddr2 + diff, desta->size2);
> +        }
>      } else {
>          diff = srca->size1 - desta->size1;
>          memmove(desta->haddr1, srca->haddr1, desta->size1);
>          memmove(desta->haddr2, srca->haddr1 + desta->size1, diff);
> -        memmove(desta->haddr2 + diff, srca->haddr2, srca->size2);
> +        if (likely(srca->size2)) {
> +            memmove(desta->haddr2 + diff, srca->haddr2, srca->size2);
> +        }
>      }
>  }
> 
> For "s390x/tcg: Fault-safe memmove" should do the trick. Will test.

Ok, great.

Peter, FYI: I'll be on vacation for two weeks (starting later today),
so David/Thomas/Christian will probably handle any s390x-related things
including pull requests for that time (I don't think I want to put a v2
together in a hurry...)

