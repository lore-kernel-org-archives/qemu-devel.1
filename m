Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 944D0C433E5
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 23:34:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 947B2205ED
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 23:34:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PhRAfSxq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 947B2205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZ0tH-0003pR-Io
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 19:34:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49658)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1jZ0sl-0003J0-6T
 for qemu-devel@nongnu.org; Wed, 13 May 2020 19:33:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:32954)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1jZ0sk-0006E1-9w
 for qemu-devel@nongnu.org; Wed, 13 May 2020 19:33:46 -0400
Received: from localhost (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id F35BB205ED;
 Wed, 13 May 2020 23:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1589412825;
 bh=TcJ3zY0gPufgFjam3YpGCUkqpNC2j+10Ko2ZjTOb6gs=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=PhRAfSxqRy9oT4YlpFdFx5y8P3uhDFE45miKpr200BZ0PqDkEMdThs01c1dQ5j0uU
 883M+Pc9XAAq2iOs/Z8VKXLBuINna2SmUU04V++4dmWtQ+qICNAnoWXarlDDL4KUpk
 IKjwJVo6mzs7iF68V9dQcZX0MkypG07jPAM/N7Ho=
Date: Wed, 13 May 2020 16:33:44 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 0/2] 9pfs: regression init_in_iov_from_pdu truncating size
In-Reply-To: <20200514010713.492e0c82@bahia.lan>
Message-ID: <alpine.DEB.2.21.2005131633150.26167@sstabellini-ThinkPad-T480s>
References: <cover.1589132512.git.qemu_oss@crudebyte.com>
 <20200512113823.3c292c27@bahia.lan> <20200514010713.492e0c82@bahia.lan>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=198.145.29.99;
 envelope-from=sstabellini@kernel.org; helo=mail.kernel.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 19:31:31
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Anthony Perard <anthony.perard@citrix.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org,
 Paul Durrant <paul@xen.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 14 May 2020, Greg Kurz wrote:
> On Tue, 12 May 2020 11:38:23 +0200
> Greg Kurz <groug@kaod.org> wrote:
> 
> > On Sun, 10 May 2020 19:41:52 +0200
> > Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:
> > 
> > > Stefano, looks like your original patch needs some more fine tuning:
> > > 
> > > https://bugs.launchpad.net/bugs/1877688
> > > 
> > > Please check if the assumptions I made about Xen are correct, and please
> > > also test whether these changes still work for you with Xen as intended by
> > > you.
> > > 
> > > Christian Schoenebeck (2):
> > >   xen-9pfs: Fix log messages of reply errors
> > >   9pfs: fix init_in_iov_from_pdu truncating size
> > > 
> > >  hw/9pfs/virtio-9p-device.c | 35 ++++++++++++++++++++++++--------
> > >  hw/9pfs/xen-9p-backend.c   | 41 ++++++++++++++++++++++++++++----------
> > >  2 files changed, 58 insertions(+), 18 deletions(-)
> > > 
> > 
> > Sorry, I'm off this week, not sure I'll have time to review.
> > So I've only applied patch 1 for now and I'll let Stefano
> > and you sort out what should be done for patch 2.
> > 
> 
> IIUC this requires more thinking and may end up in a complete rewrite of
> the truncating logic. I intend to send a PR soon : is it worth keeping
> patch 1 anyway ? 

Patch 1 is fine. For patch 2 we might need a little more time.

