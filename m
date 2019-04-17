Return-Path: <SRS0=PAXx=ST=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC40C282DA
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 11:23:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F0A7206BA
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 11:23:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ODx9VhsX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F0A7206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50806 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGifA-0007cM-DS
	for qemu-devel@archiver.kernel.org; Wed, 17 Apr 2019 07:23:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <npiggin@gmail.com>) id 1hGieL-0007FR-GP
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 07:22:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <npiggin@gmail.com>) id 1hGieJ-0001gb-RQ
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 07:22:45 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:34467)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <npiggin@gmail.com>)
	id 1hGieJ-0001fs-HS; Wed, 17 Apr 2019 07:22:43 -0400
Received: by mail-pg1-x543.google.com with SMTP id v12so11888646pgq.1;
	Wed, 17 Apr 2019 04:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:subject:to:cc:references:in-reply-to:mime-version
	:user-agent:message-id:content-transfer-encoding;
	bh=ufbfXG2pjwj89Pe6ZCcwRQy1WbNWN40+3xnLCGcZHrc=;
	b=ODx9VhsX9KJlT3Mj7G+XeLqkZLT8Qjyv9CjPn/AKEO3uS6bw7LZikZqgzKlQdYg5Ag
	hjyeeDfGQMb2jaLilwIPnKw3di1fBRkW+wk14J4JGQE8LXTOuSfYKJtA8Ky3uu+Z8gxd
	1MdUtxnsoPnHrvg3EyN3fCnT4s9ZzYbhoNrRJVVegsjmAXIqnbb+RrdKUnZrblOCgvw5
	ps6S5eks/+1LqE1ZtEM4oFFLeusSbkHWp91yNCwekSE5HI4bQFH9n45XVQ9RNPTnbzjh
	bdPXwvXPtUBHFMBEihW2YNBa8mrzsb/hgC1EXJB14lq2/30QC8kNrCP7wm5TKNuyJvp8
	b2Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
	:mime-version:user-agent:message-id:content-transfer-encoding;
	bh=ufbfXG2pjwj89Pe6ZCcwRQy1WbNWN40+3xnLCGcZHrc=;
	b=JeXjrtBrJ8d9Md8acgO62pwT6LxKshqSBy/UtJLTk3GoRaTuNfAxhHYcKxgfKi9Jn9
	SyA/7K4bLnU1t7CjP5kxua5Qots5war7YBG67Pf4RamwK9lRi8JTaTdFFvPRwCS7ObKo
	N5a4KDM+wC01suLxddaFwXxsxuvIQ4kthYdDthjRUb61Y7HAyB1PRlzEamPz9dyp1b2y
	upMsL2yrXbiy6RerO0VDJX2a/bWgAHHteNA82P2wpaRR1B6XXu+e/avOt9Snqv70OAsZ
	sHs7mCPHEwjFNpgQdZ9t9H8rF2Ny+7Ws22xxOGitz862+en+veMFHxdAdQUrkV0FfJvw
	eVRA==
X-Gm-Message-State: APjAAAWzOMkMNFdo5mxhbr067p2mAoJ9wWvUdv/kBOUIjXw5P+42ANjQ
	Mnu0YNt5r2B5l0nlKNhp2a8=
X-Google-Smtp-Source: APXvYqwoaiAqvm63mADD58U/45Ci8u63Yjl4o9ZFp+Po291aNN6vP7xW7lZ4zDrmw1xvu3Jh5Rfimg==
X-Received: by 2002:a63:3dca:: with SMTP id
	k193mr79986352pga.146.1555500162751; 
	Wed, 17 Apr 2019 04:22:42 -0700 (PDT)
Received: from localhost (61-68-209-100.tpgi.com.au. [61.68.209.100])
	by smtp.gmail.com with ESMTPSA id r27sm5696740pgn.0.2019.04.17.04.22.41
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 17 Apr 2019 04:22:42 -0700 (PDT)
Date: Wed, 17 Apr 2019 21:22:36 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: David Gibson <david@gibson.dropbear.id.au>
References: <20190412093603.18232-1-npiggin@gmail.com>
	<20190415041359.GE32705@umbus.fritz.box>
	<1555302690.7m52mtdllv.astroid@bobo.none>
	<20190417004721.GG32705@umbus.fritz.box>
In-Reply-To: <20190417004721.GG32705@umbus.fritz.box>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1555500026.z0ch7int8l.astroid@bobo.none>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: Re: [Qemu-devel] [PATCH v2] spapr: add splpar hcalls H_JOIN, H_PROD,
 H_CONFER
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
Cc: qemu-ppc@nongnu.org, =?iso-8859-1?q?C=E9dric?= Le Goater <clg@kaod.org>,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190417112236.EtwyAWwVkXYFUPvKRWwB-pE7P8yC1yyOjw9VZB78E5Y@z>

David Gibson's on April 17, 2019 10:47 am:
> On Mon, Apr 15, 2019 at 03:06:43PM +1000, Nicholas Piggin wrote:
>> It needs to be cleared at all vCPU dispatch points to SPEC, not just
>> when calling H_CEDE as Ben's patch had. I think complexity would be
>> significant for questionable benefit. Like the dispatch sequence, it
>> seems like the test is trying to cover some race condition for the
>> client but does not really do it well (and for Linux not necessary).
>>=20
>> prod bit is cleared after vCPU returns from preemption, so it can=20
>> clear at any time and you can't rely on it, unless you look at=20
>> dispatch sequence numbers to decipher if it was reset or not.
>>=20
>> KVM does implement something like the prodded flag as Ben's patch did
>> but that's not to spec AFAIKS.
>=20
> Hm, ok.  Maybe include this rationale in the comment here.

Done (hopefully)

>> > I don't see any sign that H_JOIN is implemented in KVM, although
>> > H_CONFER and H_PROD certainly are.
>>=20
>> H_JOIN is not.
>=20
> Right, so we shouldn't be trying to enable it.  What will happen if we
> use a KVM H_CONFGER and H_PROD along with a userspace H_JOIN?

Yeah good question I'll have to test before sending the H_JOIN
part again.

May have to modify KVM to make that work properly.

Thanks,
Nick
=

