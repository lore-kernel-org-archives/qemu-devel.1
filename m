Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1140C54FCC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 23:32:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA5272070B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 23:32:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UEPVVx2N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA5272070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQftj-0003eK-OS
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 19:32:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35184)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jQfsp-0003FI-74
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 19:31:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jQfsn-0006A7-MY
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 19:31:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24971
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jQfsn-00069B-5J
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 19:31:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587425479;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DdDaVg73uo3ruBN3ozINHtmiR6b5dXLmLty8zqenxP4=;
 b=UEPVVx2Nk9w+4n9NVbUPBjHR0H1mgs4MceaEvZVWd/Tc1t+b/RcPTHAbopYIEPi/59WlVf
 vagWckfW8efEsZhzVAkn2qpEuEr2aXDK3dszABnuwRshsVmSDBFZkyljSVsPYUtzWEJ8cO
 OcI7iRYWkF3j2Yw6pXWiJLKmPV5vJLM=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-366-W7lenXXJO-2tTpEExITUUA-1; Mon, 20 Apr 2020 19:31:18 -0400
X-MC-Unique: W7lenXXJO-2tTpEExITUUA-1
Received: by mail-qt1-f200.google.com with SMTP id u13so12935968qtk.5
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2020 16:31:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=FkW32XyDlDe0ksRB5mJvsDKxEM5B5CSQ3QVt3TzHoDU=;
 b=hhYjR139i5D4+uEj7QghNPKUv3M5pYl6oWJXVC7iAxTWvEjYvLjUjs6oMbfAwaMbTV
 r2ELX3Jl3cq7JTvxmKP7X7iUinZOt+EAxeGYJhp0XrCOhm/akn75l3ypcN39Xoc2MUzL
 PVeQN26XAmYftcVWyk2I+A1YDM1DrBWuALmj1SqwJuMFIDwdWrCAdyojSUjvELju0dBZ
 uBgD0i2V8GR29+6QMmZWTcHGbbG5JtRkaXQeMsC8IuobOdvOI4pBfSIWvHGi9ZEt/tRf
 d2SlsgiCA8svROp5JaKFSB0U3WT2rqJGbngShv7Ue6lI3t7TgX6Mv9KmrT8xuy4ok6L6
 dr+A==
X-Gm-Message-State: AGi0PuYfs1QAkZDAHqGyHQ0/4NUxq+bSBjmq3oR8lzCARz1ZXXUbdIXc
 pSvzp2DJiyAVsicjB+1IsnHh1FZgZkjyPECUYuSOH3ySG8Z1vcPs5ejYJWWDfG39U9V2FlKHk59
 tFcg2P6ouTa8E88s=
X-Received: by 2002:ac8:568b:: with SMTP id h11mr19029901qta.197.1587425477643; 
 Mon, 20 Apr 2020 16:31:17 -0700 (PDT)
X-Google-Smtp-Source: APiQypK55ALiHWZi8DgfzKdRRefFIcKNicrwHdy3KWdHEtvtWw0FkPFJs/g/lq4l++2WwsJZ0+emEg==
X-Received: by 2002:ac8:568b:: with SMTP id h11mr19029873qta.197.1587425477354; 
 Mon, 20 Apr 2020 16:31:17 -0700 (PDT)
Received: from xz-x1 (CPEf81d0fb19163-CMf81d0fb19160.cpe.net.fido.ca.
 [72.137.123.47])
 by smtp.gmail.com with ESMTPSA id j92sm571745qtd.58.2020.04.20.16.31.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2020 16:31:16 -0700 (PDT)
Date: Mon, 20 Apr 2020 19:31:15 -0400
From: Peter Xu <peterx@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: Question on memory commit during MR finalize()
Message-ID: <20200420233115.GB420399@xz-x1>
References: <20200420210049.GA420399@xz-x1>
 <fe73a74b-2324-68a5-a37f-530a6bb03ebc@redhat.com>
MIME-Version: 1.0
In-Reply-To: <fe73a74b-2324-68a5-a37f-530a6bb03ebc@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=peterx@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/20 19:31:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Markus Armbruster <armbru@redhat.com>,
 QEMU Devel Mailing List <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Apr 20, 2020 at 11:44:11PM +0200, Paolo Bonzini wrote:
> On 20/04/20 23:00, Peter Xu wrote:
> >=20
> > I'm still uncertain how the dirty ring branch can easily trigger this, =
however
> > the backtrace looks really odd to me in that we're going to do memory c=
ommit
> > and even sending KVM ioctls during finalize(), especially in the RCU th=
read...
> > I never expected that.
>=20
> Short answer: it is really hard to not trigger finalize() from an RCU
> callback, and it's the reason why the RCU thread takes the big QEMU lock.
>=20
> However, instead of memory_region_transaction_commit,
> memory_region_finalize probably should do something like
>=20
>     --memory_region_transaction_depth;
>     assert (memory_region_transaction_depth ||
> =09    (!memory_region_update_pending &&
>              !ioeventfd_update_pending));

Ah I see; this makes sense.

And finally I found the problem, which is indeed the bug in my own tree - I
forgot to remove the previous changes to flush the dirty ring during mem
removal (basically that's run_on_cpu() called during a memory commit, that =
will
wrongly release the BQL without being noticed).

Besides above assert, I'm thinking maybe we can also assert on something li=
ke:

  !(memory_region_transaction_depth || memory_region_update_pending ||
    ioeventfd_update_pending)

When releasing BQL (unlock, or qemu_cond_wait() on BQL, which should cover
run_on_cpu()), so that we can identify misuse of BQL easier like this.

Let me know if you like these sanity checks. I can write up a small series =
if
you think that's a good idea.

Thanks,

--=20
Peter Xu


