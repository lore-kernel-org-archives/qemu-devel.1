Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32671C04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 13:24:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F415420833
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 13:24:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="YORKIrSf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F415420833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48604 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRcql-00034N-5k
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 09:24:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu_oss@crudebyte.com>) id 1hRcpM-0002BB-7n
	for qemu-devel@nongnu.org; Fri, 17 May 2019 09:23:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <qemu_oss@crudebyte.com>) id 1hRcpK-00060B-Mr
	for qemu-devel@nongnu.org; Fri, 17 May 2019 09:23:12 -0400
Received: from kylie.crudebyte.com ([5.189.157.229]:57903)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <qemu_oss@crudebyte.com>)
	id 1hRcpK-0005wW-5i
	for qemu-devel@nongnu.org; Fri, 17 May 2019 09:23:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ZzrHE0i4kD6viiCvYk1mQqz6IEw8tjSauLNmfvunQog=;
	b=YORKIrSfMo6aHxNUUfKOMOFmna
	5MeL7ssWDyoU8FYsuIpkLM8MgdsY2BRUMG6rFoEm01KYEZuT7cis3kByMspuDCcQQ1y48CzQSCO4e
	GuAF4ShidGSaC5+4K3UQtr0PAM7OElusq0YGB+0PVnZOxyasENQtKnnpCnNQZV1sde2VzwVo4ObFW
	GU7Bfs4KdgJjk6NTIAn2eq8G08xEIeBC1ccdEbYzem01CgdjOLVE5bf9BT44yW6HMDnlaehY5DgQk
	TM1y8mRRJ/mLXpGXheHHHvm49Rc4WZvZBRxDANkAUcQImMhBpxPr9p/dxFvoOIPMZDsdPKZmgQRkT
	yBuYVJUthdYWlEP1KgqNyEIAbjRgkNuSHitBuLKdik+G4w0NoR3bcAfwQjBdH4S2GxAiUQhlaxACL
	nRlGtgKrVgW6sbc3ZSdxZaIj5cyw5W8YWZyKty5G2u6gdotPoC9VuLyFRk+uUQJfQsGwNimpEz9tu
	SBYUDQz9AuoAyfKSBenV4m0sgyrjmFsdtZ1IOIB73phgcXH8rlXFEtOuC2k/POFGNppztqfwxu533
	FR7uEKTmgfdeyS01g6ydooFItYXBzTZKNcgzhJKSqDVOSm8xxgw/u+FeFuLrJiGv88yUfsSm5Kj4A
	8qLNUsESI7OHXbV++on0a1AtKMfAnhCbxbNbhNuUw=;
To: qemu-devel@nongnu.org
Date: Fri, 17 May 2019 15:23:01 +0200
Message-ID: <1723391.cvQaRflHa6@silver>
In-Reply-To: <20190517143029.25454663@bahia.lan>
References: <590216e2666653bac21d950aaba98f87d0a53324.1557093245.git.qemu_oss@crudebyte.com>
	<8706106.MIJVTSuNya@silver> <20190517143029.25454663@bahia.lan>
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

On Freitag, 17. Mai 2019 14:30:29 CEST Greg Kurz wrote:
> Then, we come to the bulk problem: how to handle the case where we
> have multiple devices involved in a directory we want to share ?
> Antonios's proposal is a clever way to address the collisions, but
> your work proves it isn't enough...

With the patch set I have right now, things finally bahave smooth.

> Before going forward, I'd like
> to consider another approach.
> 
> What about:
> 
> 1) de-compose the shared directory on a per-device basis,
>    ie. identify all mount points under the shared directory
> 
> 2) expose found mount points separately, each with its onw 9p device
> 
> 3) re-compose the directory tree within the guest using the same topology
>    as the host
> 
> ie. if you want to share /vm/fs and
> 
> /vm/fs on device A
> /vm/fs/shares on device B
> /vm/fs/tmp on device C
> 
> you would start QEMU with
> 
> -fsdev local,path=/vm/fs,id=fsdev0... \
> -device virtio-9p,fsdev=fsdev0,mount_tag=tag0 \
> -fsdev local,path=/vm/fs,id=fsdev1... \
> -device virtio-9p,fsdev=fsdev1,mount_tag=tag1 \
> -fsdev local,path=/vm/fs,id=fsdev2... \
> -device virtio-9p,fsdev=fsdev2,mount_tag=tag2
> 
> and /etc/fstab in the guest:
> 
> tag0    /       9p      nofail,trans=virtio,version=9p2000.L   0 0
> tag1    /shares 9p      nofail,trans=virtio,version=9p2000.L   0 0
> tag2    /tmp    9p      nofail,trans=virtio,version=9p2000.L   0 0
> 
> This involves some more work for the user but it doesn't require
> any changes in QEMU.

So your suggestion is actually: don't fix it.

"Some" more work for the user is a quantity of how many guests you are 
running, multiplied by the nested virtualization levels you might have = 
potentially a lot of work for admins.

> Would this approach solve the issues you've been hitting with Samba ?

No, because that completely neglects runtime changes on a higher level (host), 
plus it completely destroys the fundamental idea about 9p, which is about 
transparency of the higher level(s).

May I ask, do you have concrete reasons why you want to abondon the entire 
patch set? Because that's what it sounds to me.

Best regards,
Christian Schoenebeck

