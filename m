Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B2DC28CC6
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 09:29:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F2B0260CC
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 09:29:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="Y26A+Eq0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F2B0260CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60373 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXjH8-0005wk-Dp
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 05:29:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50562)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu_oss@crudebyte.com>) id 1hXj5x-0005XG-5Y
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 05:17:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <qemu_oss@crudebyte.com>) id 1hXj5v-0000en-Gz
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 05:17:33 -0400
Received: from kylie.crudebyte.com ([5.189.157.229]:54157)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <qemu_oss@crudebyte.com>)
	id 1hXj5t-0000Xr-Dm
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 05:17:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=v/pCLjJLLbOV3hDeIlmz8c7aRMzQnaCIFZjKj7uOQRA=;
	b=Y26A+Eq0bH+Rd+0KtrfVSLQ0zp
	JbB2iAFo/rZABq5MwlaJlzYAuSZwixEGgLGAJNc1z/Dw4Nv0hqAc75cL3v5HU0UheTw+jxwm0/P2+
	/2LoYXudvdbIcdMgs7x1T8LKCxCQDeHROQRCmABEQEDmoqgRSq/VYAukcf8Bpmzn6//GfVnrZQxag
	4gh5KtD0vXLRhdMKGPfOuv0/uA/CkOSk5Ig6XnBEZfhXOSQWdet8HtPBhK5Rhw0UrTTmUXYynbAeO
	vzjquEVEfhbksHVU1jRKtSe1f119h/7VM/BV40Worx+zsAIBULqch3fl2Lw0TY7te0BHNqejuHmGf
	4Jn8TIuq0dXmT0/Gc930rrZBmgZI/Wyw7uZlWnT3ynBfAyHNokpLaxqzg+gl6JityVHpCNx0IIpBj
	KCgAu/KWAgVLWcYfAtkxwwkRSFWJ/atWg01CZQv34xeHjMcV1aR2DNU7m/rbuWHqFWXVCRghgvW8H
	SeCbQucEpC+sIFjR+QZek4bFRri7cRsEE/MQGsY7qV4TXpybbQpBj+ftnOXtVCLxT9DzJqjkj0Hgk
	9vRVMliw0cpCta46X0MveQW6LMzV7xxYSIX4O15Bykm5snDTH7DCCwYupi0L4AHeS8fF18Gt9TZ7+
	EAj+H2RQ5gq1yXQftlR9p15yNSBtFI366LMgkl/W4=;
To: qemu-devel@nongnu.org
Date: Mon, 03 Jun 2019 11:17:22 +0200
Message-ID: <1575139.mHQbk1htSj@silver>
In-Reply-To: <20190603085715.6e737b0e@bahia.lab.toulouse-stg.fr.ibm.com>
References: <590216e2666653bac21d950aaba98f87d0a53324.1557093245.git.qemu_oss@crudebyte.com>
	<3878644.JKHuFhRL4E@silver>
	<20190603085715.6e737b0e@bahia.lab.toulouse-stg.fr.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.189.157.229
Subject: Re: [Qemu-devel] [libvirt patch] qemu: adds support for virtfs 9p
 argument 'vii'
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
From: Christian Schoenebeck via Qemu-devel <qemu-devel@nongnu.org>
Reply-To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc: Daniel =?ISO-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
	Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>,
	Antonios Motakis <antonios.motakis@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Montag, 3. Juni 2019 08:57:15 CEST Greg Kurz wrote:
> > Ok, I will extend Antonios' patch to log that error on host. I thought
> > about limiting that error message to once per session (for not flooding
> > the logs), but it is probably not worth it, so if you don't veto then I
> > will just log that error simply on every file access.
> 
> Please use error_report_once().

I will.

> > > Please repost a series, possibly based on some of Antonios's patches
> > > that
> > > allows to avoid the QID collision, returns an error to the client
> > > instead
> > > and possibly printing out some useful messages in the QEMU log. Then, on
> > > top of that, you can start introducing hashing and variable prefix
> > > length.
> > 
> > So you want that as its own patch series first, or can I continue with my
> > suggestion to deliver the hash patch and variable suffix length patch as
> > last patches within the same series?
> 
> Same series is okay.

Ok.

I'm currently busy with other work; I will probably send a new patch set 
approximately next week.

Best regards,
Christian Schoenebeck

