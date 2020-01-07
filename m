Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 905B7C33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 13:06:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A9632080A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 13:06:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="g0fJ/NEr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A9632080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iooZ5-0007c3-CK
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 08:06:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56812)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <qemu_oss@crudebyte.com>) id 1ionyT-0000gT-El
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 07:28:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <qemu_oss@crudebyte.com>) id 1ionyS-0001lx-DH
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 07:28:41 -0500
Received: from kylie.crudebyte.com ([5.189.157.229]:50639)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <qemu_oss@crudebyte.com>)
 id 1ionyS-0001la-5U
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 07:28:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=II/zaNf6+3BT4ugKHJuLlX/NNoq75sw/GJNFhgy6VL4=; b=g0fJ/NEraAwvVP8m3eg5QpDYpS
 lkNsBKCgjCem9cI6Rom/toFg2KhwwfnBywzQ9/SmwpjkYXC1xChAOZumKL7Y/NAfr4QhL5IoB6erX
 JqLdJV51I8ErDUUvcfeX0gHiMsM4TpqdH2jVnNgGRtoaFJTWePzH4EMSiptKiAxuPpWDjPw8upuWP
 jkI4mu/yKeiMbxE1Uxh219Phv5moqNN2qhYX2lqd9lykQiIB37i6IirxiaFq0jXHLYQNTz3AoCyaf
 w/5v7yBM1Yiky/T26BjGUnQAGZ/EU8vBdcUschmBdOSnBGEuXE9a7S9DYPvww7YBLalnPlmX9//9E
 tOY1zQLjZnfsv4zQLOh0Hg9Wi9y39olFx8Y+7owDBWJX2xWfGPB/YEOITJLMO1/CEnJ+A69QIfXWO
 dTHLKejvy8mZmBOrYIxNR2MPRjj0715Ggwmlpf18vfLxgnnp7eyeF9kL+s94PlCDrBcHgS8P0gsNx
 fMGH5wb1XHqRbdHXEqtV4cRXXI/AM7AJck3YVgR0zPeGEvN2tJBT5ib1KXq6t2j7UCeqaWkdV7Kbk
 CvcHqgsQjRP+T5jrGbcdV47LNHkADxqt2MKDeWhUJluJzuVC4Be6E43GAb+EFJrW9sgzYmr1uyCrH
 t/u68jYH1dtrELWoL6nNStg6NuTPoOlgv/uHXgsvY=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>, Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [PATCH v2 5/9] tests/virtio-9p: check file names of R_readdir
 response
Date: Tue, 07 Jan 2020 13:28:38 +0100
Message-ID: <2640807.KD2hu4yizk@silver>
In-Reply-To: <20200106180711.3a665d11@bahia.lan>
References: <cover.1576678644.git.qemu_oss@crudebyte.com>
 <2a40095340d9536575af8fd214a7ac647b4603c9.1576678644.git.qemu_oss@crudebyte.com>
 <20200106180711.3a665d11@bahia.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 5.189.157.229
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Montag, 6. Januar 2020 18:07:11 CET Greg Kurz wrote:
> On Wed, 18 Dec 2019 14:35:56 +0100
> 
> Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:
> > Additionally to the already existing check for expected amount
> > of directory entries returned by R_readdir response, also check
> > whether all directory entries have the expected file names (as
> > created on 9pfs synth driver side), ignoring their precise order
> > in result list though.
> > 
> > Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> > ---
> 
> LGTM and trivial enough that it can be folded in the previous
> patch.

So you want that patch to be squashed. Np.

Best regards,
Christian Schoenebeck



