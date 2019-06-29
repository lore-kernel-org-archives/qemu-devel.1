Return-Path: <SRS0=rHaa=U4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EBDFC4321A
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Jun 2019 10:22:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BDD9214AF
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Jun 2019 10:22:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="bNyUfn6Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BDD9214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhAUe-0001NW-Ut
	for qemu-devel@archiver.kernel.org; Sat, 29 Jun 2019 06:22:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44447)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <qemu_oss@crudebyte.com>) id 1hhATc-0000ls-9P
 for qemu-devel@nongnu.org; Sat, 29 Jun 2019 06:21:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <qemu_oss@crudebyte.com>) id 1hhATb-0005Gg-8E
 for qemu-devel@nongnu.org; Sat, 29 Jun 2019 06:21:00 -0400
Received: from kylie.crudebyte.com ([5.189.157.229]:41875)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <qemu_oss@crudebyte.com>)
 id 1hhATa-0005DH-Nn
 for qemu-devel@nongnu.org; Sat, 29 Jun 2019 06:20:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XPc9tVsZC9+q0LC9Nw2tscTqstUx0oDgtuFZBuVC8co=; b=bNyUfn6ZIsVmnwGL5DJVR/HBxH
 VNWfosGuyuAOaTJIHJ60GzZ1EyqqXxPYWkRah9F6DXWn8YhSENPbSY4wX+72K1GAZgTBo2N4FUR78
 NOX0GqpkmDwgqstq1qXiDQMwk+pXw3ni7kZ2OWROv/rMG0800WKhWWnGTvrwhpDpr5NooFvdJ7mm3
 WeSaVy58ImknWKEaE5jLFsDF73WddQ4D6xKK/JCx5+4dxHVO0Oef1/JPuNJt5B2202p9kj0AH4BPU
 qDn+MFghg4kawPe6XmyTSL1UTv1s8BpMFHPnykySqXL+R2GuJC9yAWF4gUogNBcZK+3um66rVOIZ+
 pSS3bSaO1KBT3G0yMBPCy02pnd8me7PaF/xrrIXVT7HWso1lFwUfytkHrnqierxxT4AhXlm1wtHYL
 fPL3eHuvsoILKNgNqoUNvZOKgmK4MidjNkjdaPdgdYmMNEmytL+GjBlu2SfMqzpIou1gRO9bcynpe
 qF6rJIUOFjXqR0JYVArwolyrV5ZZU5N66GXtFIOjr5XPQS9XYNzCjfEgrYpv33OViyLK1MoTuPiA4
 Dju0Y8zH+DTVLfGfHfpVL1oTwAK8il5dBDPqYXfdE3XEl0vP67GKrvoKVB/vSTgMoTj1CDlWdHXtt
 vofH79qawOC1bEsfd3fqwcrzpwwV0BxCgh5Y3cpy8=;
To: qemu-devel@nongnu.org
Date: Sat, 29 Jun 2019 12:20:49 +0200
Message-ID: <10483682.05G6IJrOKK@silver>
In-Reply-To: <20190628162308.40ec742c@bahia.lan>
References: <cover.1561575449.git.qemu_oss@crudebyte.com>
 <4068711.1y5nem0Q7a@silver> <20190628162308.40ec742c@bahia.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.189.157.229
Subject: Re: [Qemu-devel] [PATCH v4 3/5] 9p: Added virtfs option
 "remap_inodes"
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
From: Christian Schoenebeck via Qemu-devel <qemu-devel@nongnu.org>
Reply-To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc: Daniel =?ISO-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>,
 Antonios Motakis <antonios.motakis@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Freitag, 28. Juni 2019 16:23:08 CEST Greg Kurz wrote:
> > > This feature applies to all backends IIUC. We don't really care for the
> > > synth backend since it generates non-colliding inode numbers by design,
> > > but the proxy backend has the same issue as local. So...
> > 
> > Yeah, I was not sure about these, because I did not even know what these
> > two were for exactly. :)  [ lazyness disclaimer end]
> 
> "proxy" is a backend where all I/O accesses are performed by a separate
> process running the virtfs-proxy-helper command. It runs with root
> privileges, which provides the same level of functionality as "local"
> with security_model=passthrough. It also chroot() into the shared
> folder for extra security. But it is slower since it all requests
> still go through the virtio-9p device in QEMU. This would call
> for a vhost-9p implementation, but it's yet another story.
> 
> "synth" is a software pseudo-backend, currently used to test 9pfs
> with QTest (see tests/virtio-9p-test.c).

Thanks for the clarification!

So the proxy backend sounds like an idea that has not been implemented fully 
to its end. I guess it is not really used in production environments, right? 
What is the actual motivation for this proxy backend?

And now that I look at it, I am a bit surprised that there is this pure Unix 
pipe socket based proxy variant, but no TCPIP network socket variant. I mean 
the latter is AFAIK the original idea behind the 9p protocol and IMO might be 
interesting to physical separate pure storage backends that way.

Best regards,
Christian Schoenebeck

