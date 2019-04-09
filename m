Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE9BC10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 12:54:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99A1121841
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 12:54:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z880BDbY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99A1121841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40689 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDqGg-0008DW-JM
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 08:54:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hDqFj-0007n8-3z
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 08:53:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hDqFi-0005J2-2m
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 08:53:27 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:40056)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hDqFh-0005HL-N3
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 08:53:26 -0400
Received: by mail-oi1-x244.google.com with SMTP id 3so13422441oir.7
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 05:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=hDOJGGusuLAxIzean0hKzTQx13ucrodKwx59vNIRnJg=;
	b=z880BDbYBODIMemUylTIXBYeq7Wld7cLcCdeExlEHWhHxVWu73UWNPcpdeyae1VJ4C
	wsVL8OMKOYJ/dhetQgOaZObKdPvFEi5hBp3niFoZ/mlwj+gjbw0JhDb728yILacYvPHk
	JmMhPRk+GzCcxllx1Hcxcyp+/xhp6zA15qarb8fLDtGTKofmv22IONoLNKdb9T8nlN+G
	45gkhYyr3uYhWzNiriE5Q8VbzCWCm6xYuBBxngwPlRegSNMO/1L4Ds0HodoLjS+nZwi6
	GLgcB0X7mNjTY9B36In/2iz2J1XghTkgTeo5U8vjHYtEH9cpON2xMyngGAErmyrhxR4i
	jrEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=hDOJGGusuLAxIzean0hKzTQx13ucrodKwx59vNIRnJg=;
	b=UFydNwOw2GOWObyU3vYSlF7ayTgA4GVsLQpUZvxIcNzkexeliIVxp7DMNxUrCq1Ji1
	HV5ufhA0uBMJHVe+o176ZMGVLONjJnlEZ3Hy6l/00++fMAgDRmpjTp5B1VO8YlA23JgD
	ueGW+4x4y4iH72AUcdPpKLmYpbz8/zQuaRAOQkzK9+0WFHCLqKpYP5HCY51tFQqazr6k
	d1EzEeH7JGM1h1iBWxJZbIkMlbk5Q4odySsNQzdi/f11OSg3bRJAkmGpkxHim5ZkY1D1
	8xgFXeXxIG3W0Zz1JFyqUjzB5ULplcSIbN4CeyimeKmECzwTemDgFTK+RkjhR20NQ1Sw
	yq5A==
X-Gm-Message-State: APjAAAVI8Fz2ElTCg6XDvjPaHJhrU8cUvpH207YG/KaCUvkKRBQMWGbv
	B1OfjY9++FP7lLRlGxYL1ZF637wRPKMTUjpzh/Dq+A==
X-Google-Smtp-Source: APXvYqyw5TmdQJxcW1NKsY9+LQ9q+n4n277F57V9urqiYXvVw+VOuGCqtSbtzQjIFVj/SaLVmWOIKqdeJZiU/Dl0mCE=
X-Received: by 2002:aca:4c88:: with SMTP id
	z130mr19883313oia.170.1554814404476; 
	Tue, 09 Apr 2019 05:53:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190325174706.6741-1-quintela@redhat.com>
	<20190325174706.6741-6-quintela@redhat.com>
	<CAFEAcA8J2cKVf+v+pkK-QFy3b4uPoS9ZaA43ATQyBjtPC9WyoQ@mail.gmail.com>
In-Reply-To: <CAFEAcA8J2cKVf+v+pkK-QFy3b4uPoS9ZaA43ATQyBjtPC9WyoQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Apr 2019 13:53:13 +0100
Message-ID:
 <CAFEAcA_r9dhtdnr0ZK9vy=ucbJ3jfJ1ofDt7WiAdqD6Udkoskg@mail.gmail.com>
To: Juan Quintela <quintela@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::244
Subject: Re: [Qemu-devel] [PULL 05/15] multifd: Be flexible about packet size
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: zhanghailiang <zhang.zhanghailiang@huawei.com>,
	QEMU Developers <qemu-devel@nongnu.org>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>,
	Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190409125313.CzkPxNqTmLly5eQ9BBkv2qFxj04ComGYtDV-oaWomOU@z>

On Tue, 26 Mar 2019 at 12:26, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Mon, 25 Mar 2019 at 18:13, Juan Quintela <quintela@redhat.com> wrote:
> >
> > This way we can change the packet size in the future and everything
> > will work.  We choose an arbitrary big number (100 times configured
> > size) as a limit about how big we will reallocate.
> >
> > Signed-off-by: Juan Quintela <quintela@redhat.com>
> > Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > Signed-off-by: Juan Quintela <quintela@redhat.com>
> > --
>
> Hi; Coverity reports a use-after-free in this code
> (CID 1400442):

Ping? Have we got a fix for this yet ?

thanks
-- PMM

>
> > @@ -832,12 +832,24 @@ static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
> >      p->flags = be32_to_cpu(packet->flags);
> >
> >      packet->pages_alloc = be32_to_cpu(packet->pages_alloc);
> > -    if (packet->pages_alloc > page_count) {
> > +    /*
> > +     * If we recevied a packet that is 100 times bigger than expected
> > +     * just stop migration.  It is a magic number.
> > +     */
> > +    if (packet->pages_alloc > pages_max * 100) {
> >          error_setg(errp, "multifd: received packet "
> > -                   "with size %d and expected maximum size %d",
> > -                   packet->pages_alloc, page_count) ;
> > +                   "with size %d and expected a maximum size of %d",
> > +                   packet->pages_alloc, pages_max * 100) ;
> >          return -1;
> >      }
> > +    /*
> > +     * We received a packet that is bigger than expected but inside
> > +     * reasonable limits (see previous comment).  Just reallocate.
> > +     */
> > +    if (packet->pages_alloc > p->pages->allocated) {
> > +        multifd_pages_clear(p->pages);
>
> multifd_pages_clear() calls g_free() on the pointer it is passed...
>
> > +        multifd_pages_init(packet->pages_alloc);
> > +    }
> >
> >      p->pages->used = be32_to_cpu(packet->pages_used);
>
> ...but here we fall through and dereference p->pages, which
> we might have just freed.
>
> >      if (p->pages->used > packet->pages_alloc) {
> > --
> > 2.20.1
>
> thanks
> -- PMM

