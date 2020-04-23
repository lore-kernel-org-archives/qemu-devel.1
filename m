Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 571FDC54FCB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 16:58:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20D2A20736
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 16:58:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a1zXKZmp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20D2A20736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRe1f-00083C-0h
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 11:44:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56642)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jRe0d-0006Sd-5C
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 11:43:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jRe0c-0006kC-CP
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 11:43:26 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:48542
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jRe0b-0006hF-TK
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 11:43:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587656603;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qeTfP2cM7MCBf5OXy+2ynocPkpCFpQ8COaK1bkjIdTk=;
 b=a1zXKZmpFs4p28IpwT4kmyEfJ5POnOf+mYvmSnNlg8LeBsXIz5kxNNbeKWvOJrT8n8grfl
 U+hc/7/iGJwAjl+s1aqTt7Gl6skseDSZboqfF1x8+aVGE6KUP2n/2Cn2AhU+9yxJ2MM5C6
 jlLl4DiNnkzq8UQegbMc6zplhvgQNhw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-94-4b7SC-qUMw2GSDyBn4ljPw-1; Thu, 23 Apr 2020 11:43:20 -0400
X-MC-Unique: 4b7SC-qUMw2GSDyBn4ljPw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 73F1E835B4F;
 Thu, 23 Apr 2020 15:43:18 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-28.ams2.redhat.com [10.36.114.28])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AD4E25C1BD;
 Thu, 23 Apr 2020 15:43:05 +0000 (UTC)
Date: Thu, 23 Apr 2020 17:43:04 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [RFC 0/3] 64bit block-layer part I
Message-ID: <20200423154304.GD23654@linux.fritz.box>
References: <20200330141818.31294-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <20200330141818.31294-1-vsementsov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 03:23:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: fam@euphon.net, berto@igalia.com, stefanha@redhat.com,
 qemu-block@nongnu.org, dillaman@redhat.com, pavel.dovgaluk@ispras.ru,
 sw@weilnetz.de, pl@kamp.de, qemu-devel@nongnu.org, mreitz@redhat.com,
 jsnow@redhat.com, ronniesahlberg@gmail.com, den@openvz.org,
 pbonzini@redhat.com, ari@tuxera.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 30.03.2020 um 16:18 hat Vladimir Sementsov-Ogievskiy geschrieben:
> Hi all!
>=20
> There is an idea to make NBD protocol extension to support 64bit
> write-zero/discard/block-status commands (commands, which doesn't
> transfer user data). It's needed to increase performance of zeroing
> large ranges (up to the whole image). Zeroing of the whole image is used
> as first step of mirror job, qemu-img convert, it should be also used at
> start of backup actually..
>=20
> We need to support it in block-layer, so we want 64bit write_zeros.
> Currently driver handler now have int bytes parameter.
>=20
> write_zeros path goes through normal pwritev, so we need 64bit write,
> and then we need 64bit read for symmetry, and better, let's make all io
> path work with 64bit bytes parameter.
>=20
> Actually most of block-layer already have 64bit parameters: offset is
> sometimes int64_t and sometimes uint64_t. bytes parameter is one of
> int64_t, uint64_t, int, unsigned int...
>=20
> I think we need one type for all of this, and this one type is int64_t.
> Signed int64_t is a bit better than uint64_t: you can use same variable
> to get some result (including error < 0) and than reuse it as an
> argument without any type conversion.
>=20
> So, I propose, as a first step, convert all uint64_t parameters to
> int64_t.
>=20
> Still, I don't have good idea of how to split this into more than 3
> patches, so, this is an RFC.

I think the split in three patches isn't too bad because it's not a
whole lot of code. But of course, it is little code that has lots of
implications which does make it hard to review. If we think that we
might bisect a bug in the series later, maybe it would be better to
split it into more patches.

write/write_zeroes has to be a single thing, I'm afraid. But I guess
read could be a separate patch, as could be copy_range. Not sure about
discard.

> What's next?
>=20
> Converting write_zero and discard is not as simple: we can't just
> s/int/uint64_t/, as some functions may use some int variables for
> calculations and this will be broken by something larger than int.
>=20
> So, I think the simplest way is to add .bdrv_co_pwritev_zeros64 and
> .bdrv_co_pdiscard64 and update drivers one-by-one. If at some point all
> drivers updated - drop unused 32bit functions, and then drop "64" suffix
> from API. If not - we'll live with both APIs.

We already have too many unfinished conversions in QEMU, let's not add
one more.

Fortunately, we already have a tool that could help us here: Things like
bs->bl.max_pwrite_zeroes. We could make BDRV_REQUEST_MAX_BYTES the
default value and only drivers that override it can get bigger requests.

> Another thing to do is updating default limiting of request (currently
> they are limited to INT_MAX).

As above, I wouldn't update the default, but rather enable drivers to
overload the default with a larger value. This will involve changing
some places where we use MIN() between INT_MAX and the driver's value.

> Then we may move some drivers to 64bit discard/write_zero: I think about
> qcow2, file-posix and nbd (as a proof-of-concept for already proposed
> NBD extension).

Makes sense to me.

Kevin


