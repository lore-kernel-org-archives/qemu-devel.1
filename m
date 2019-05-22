Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 933F8C072B5
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 00:53:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 612AD2070D
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 00:53:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iMVGVcwI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 612AD2070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33473 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTFVC-0005hp-HS
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 20:53:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mehta.aaru20@gmail.com>) id 1hTFU7-0005FG-QB
	for qemu-devel@nongnu.org; Tue, 21 May 2019 20:52:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mehta.aaru20@gmail.com>) id 1hTFU6-0006hD-MJ
	for qemu-devel@nongnu.org; Tue, 21 May 2019 20:51:59 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:44913)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mehta.aaru20@gmail.com>)
	id 1hTFU6-0006fL-GJ; Tue, 21 May 2019 20:51:58 -0400
Received: by mail-pl1-x642.google.com with SMTP id c5so167043pll.11;
	Tue, 21 May 2019 17:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=message-id:subject:from:to:cc:date:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=C5TvhDVCBld5DhwMM/2/Q2QNi6d4d+qbgzFzH+Au06Q=;
	b=iMVGVcwIBDNuYknrITsGvFLpwPBN5Zlnovuo8ngMj/lUKADnkDUffzXDUzI03TqpQX
	E3jO6DNJTfYia4g130XvAIHN47HK3UeDYfFJzVii75oGvGky7P8ZjSh7F0VG2bNr7uxk
	HVJ3OkIfYH0NGIjIbCcR70Ra3DqPnsfHW7o1t+qnECB52ALgCbQpW98qDcVAswlPfTjI
	afwsOYqTJbX/irMJRcNJ2TsVEXPm36DCfwhx+FjQ59s4L5BIFdHQF7aMUhzKR7yJ84Gs
	0LfWCcH2NvJJmMfeS2qnCAGymYknPQB3gdiif/VdST7LvdXkkjPt92+ISpMatMTy4nuN
	G/rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=C5TvhDVCBld5DhwMM/2/Q2QNi6d4d+qbgzFzH+Au06Q=;
	b=doEe5ExB/qqjKyZjG5pvmPoZj6eg9et56XSHx+0AakyVQ5rxc+5U/cPSstq+x93l99
	98PgBw0dL2bzgbpFS5PIMnUyvjDCdwDHttBtN0Tdtitgi9SwRcaZus6lem+vzfusYAXr
	muv6cxgFozAkNQ5+S6snOI4DyrcMRA7VmSKQhajihYEZ9aZs6lOkTVaftxhqDwGy2Lu6
	KFClRpcI0MjeLTRiqeSF55p1GR9gXNxZR16BDNUcK/WpPTBQyTkXdG7mBYHrtkMBGWj+
	gkKwLcp05Om6HKMgek5PM1Jfl8qCdKfTIBLvkDKqgree74hhuCAGE6qhxkAfe6rPizRj
	IuuQ==
X-Gm-Message-State: APjAAAVJDdEd7gBHmQP2VkkLUcO4VMN/iN7TfP3zJNaZbyNxLd5AXFpH
	VzS1+XGClwW7/tfx5GixePs=
X-Google-Smtp-Source: APXvYqxFiQCyDa5Fc81KNNdwMRFLzp4ilVuhVKpAEMV2GbC4bL6MefDZD3gwSyGb7C6CcGs+OuOvew==
X-Received: by 2002:a17:902:7406:: with SMTP id
	g6mr85179609pll.328.1558486316796; 
	Tue, 21 May 2019 17:51:56 -0700 (PDT)
Received: from am-swift ([120.57.118.207]) by smtp.gmail.com with ESMTPSA id
	c127sm36485624pfb.107.2019.05.21.17.51.53
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 21 May 2019 17:51:55 -0700 (PDT)
Message-ID: <1c277edc76e47fbbaae0ecdd6774e24ac9a94ee5.camel@gmail.com>
From: Aarushi Mehta <mehta.aaru20@gmail.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Date: Wed, 22 May 2019 06:21:51 +0530
In-Reply-To: <d932237b-03bc-5dbb-17dd-bcca5ce121c8@redhat.com>
References: <20190521235215.31341-1-mehta.aaru20@gmail.com>
	<20190521235215.31341-2-mehta.aaru20@gmail.com>
	<d932237b-03bc-5dbb-17dd-bcca5ce121c8@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: Re: [Qemu-devel] [RFC PATCH 1/9] qapi/block-core: add option for
 io_uring
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
Cc: saket.sinha89@gmail.com, Julia Suvorova <jusual@mail.ru>,
	Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2019-05-21 at 19:39 -0500, Eric Blake wrote:
> On 5/21/19 6:52 PM, Aarushi Mehta wrote:
> > Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
> 
> Sparse on the details. The subject line says what, but without a
> 'why'
> for how io_uring is different from existing aio options, it's hard to
> see why I'd want to use it. Do you have any benchmark numbers?

For peak performance, io_uring helps us get to 1.7M 4k IOPS with
polling. aio reaches a performance cliff much lower than that, at 608K.
If we disable polling, io_uring is able to drive about 1.2M IOPS for
the (otherwise) same test case.

More details, and the source for the above is at
http://kernel.dk/io_uring.pdf

> > ---
> >  qapi/block-core.json | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/qapi/block-core.json b/qapi/block-core.json
> > index 7ccbfff9d0..116995810a 100644
> > --- a/qapi/block-core.json
> > +++ b/qapi/block-core.json
> > @@ -2776,11 +2776,12 @@
> >  #
> >  # @threads:     Use qemu's thread pool
> >  # @native:      Use native AIO backend (only Linux and Windows)
> > +# @io_uring:    Use linux io_uring
> 
> Missing a '(since 4.1)' tag.
> 
> >  #
> >  # Since: 2.9
> >  ##
> >  { 'enum': 'BlockdevAioOptions',
> > -  'data': [ 'threads', 'native' ] }
> > +  'data': [ 'threads', 'native','io_uring' ] }
> 
> Missing space after ',' (not essential, but matching style is nice).
> Should the new element be defined conditionally, so that
> introspection
> only sees the new enum member when compiled for Linux?
> 
I'm not sure what would be the benefits of that? We already check for
Linux at configure, and this would reduce readability. We aren't doing
this for native.
> 


