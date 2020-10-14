Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4472BC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 15:29:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33AE621582
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 15:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="bYgpSf3R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33AE621582
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSii9-0007xn-37
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 11:29:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50290)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kSiet-0005GH-EJ
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 11:25:43 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:46745)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kSier-00052T-6T
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 11:25:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=aydBnhPzJxfh+fOA+6t+/ZszA2wvzaDt8J1YQsgsZAA=; b=bYgpSf3R+FSC3Ce04MspOQf+aN
 AmiEJ1oKVu/whm+iJe0hU0/EfUeXM3a1rcNlt3EYqg+OnKzBc5d44IbEG/GaZgBlFoT/f8rrGCoxJ
 vYUuOmyb/sxWsMUSI06kQU6Lub7oHtIC8K/724bHvPm028T0vDG1mRCOaFTES4EiNssIJj7fiYh1D
 8gZ2eXgigfZDE1kWJJNpn1OCMSd62wUTDig845/2RKoPi77drbgl0R9mXdp9z7dqvcnt5ErN2HCUQ
 a44jsO/CdrQUedx818gPUvdATFSnB9KhptsC0ZWnTx8WO58sDHam9+/lrQzouWikkM20cFI0kHIwh
 gKx4kzOQ==;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
 Greg Kurz <groug@kaod.org>,
 Daniel =?ISO-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH v4 08/12] tests/9pfs: change qtest name prefix to synth
Date: Wed, 14 Oct 2020 17:25:35 +0200
Message-ID: <2321140.ujbB6vKeRS@silver>
In-Reply-To: <e04e75acb849b085c6d6320b2433a15fa935bcff.1602182956.git.qemu_oss@crudebyte.com>
References: <cover.1602182956.git.qemu_oss@crudebyte.com>
 <e04e75acb849b085c6d6320b2433a15fa935bcff.1602182956.git.qemu_oss@crudebyte.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=91.194.90.13; envelope-from=qemu_oss@crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 11:25:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

On Donnerstag, 8. Oktober 2020 20:34:56 CEST Christian Schoenebeck wrote:
> All existing 9pfs test cases are using the 'synth' fs driver so far, which
> means they are not accessing real files, but a purely simulated (in RAM
> only) file system.
> 
> Let's make this clear by changing the prefix of the individual qtest case
> names from 'fs/' to 'synth/'. That way they'll be easily distinguishable
> from upcoming new 9pfs test cases supposed to be using a different fs
> driver.
> 
> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> ---
>  tests/qtest/virtio-9p-test.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)

Queued patches 8 .. 12 on 9p.next:

https://github.com/cschoenebeck/qemu/commits/9p.next

Best regards,
Christian Schoenebeck



