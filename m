Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B060C282DC
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 00:40:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69E0D27A40
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 00:40:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69E0D27A40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54952 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXb1g-0002xZ-MA
	for qemu-devel@archiver.kernel.org; Sun, 02 Jun 2019 20:40:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hXb0o-0002a6-Iq
	for qemu-devel@nongnu.org; Sun, 02 Jun 2019 20:39:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hXb0n-0008Fh-D7
	for qemu-devel@nongnu.org; Sun, 02 Jun 2019 20:39:42 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:38885)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hXb0m-0008F7-1V
	for qemu-devel@nongnu.org; Sun, 02 Jun 2019 20:39:41 -0400
Received: by mail-qk1-f196.google.com with SMTP id a27so9995421qkk.5
	for <qemu-devel@nongnu.org>; Sun, 02 Jun 2019 17:39:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to;
	bh=nzXjzqvA6w+3WhjNxDS9AT1Thyri0HC300zxq0jynfU=;
	b=KThNw23hX+2qDfFpMuUFaOSnAHscxB8TpWE8BNimeUEQVEoJbFOnRfZE9Drz6Jx4hP
	n+I/6MecV6/mfeVjiU+ufHFNR2WkFLegAJYzo44a5Og269DVGSQ+8g6bnAOp4fC9XkRh
	A8Fjks7PJGrxa7nTBeuNIKS5e81eHmUELOf8HgcvDSrdQRFOecqg2rB8ysby0QnVFqWF
	SLgsV+y/PUmLu1YAAxtY6aCWdteTqUsNetFHqD/HechxRFiIksAM/i3oAR/d9YyBOEiH
	l2UDr5q0zx0cHRi6FNqYBB9nDcKeI9t5pAme1HJZNODGuhRaUfyCUcNRzt8q4CgAsKKM
	WZGw==
X-Gm-Message-State: APjAAAUk9Ff804bhSsKjCnX8D2sT2vsmi+YrUxt66l+rWv3mQz459G8O
	Nze62FOo+i4zMhzd8p88l5EYvg==
X-Google-Smtp-Source: APXvYqyVP9mJjsXE0Q9aRftPHi0ZsGCG5QTDZmlLKLq/WNHaJXTvgE53Lpds/KLN+ZmJd5ad/oDQkA==
X-Received: by 2002:ae9:e642:: with SMTP id x2mr631509qkl.181.1559522379414;
	Sun, 02 Jun 2019 17:39:39 -0700 (PDT)
Received: from redhat.com (pool-100-0-197-103.bstnma.fios.verizon.net.
	[100.0.197.103]) by smtp.gmail.com with ESMTPSA id
	y19sm2722911qto.30.2019.06.02.17.39.37
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Sun, 02 Jun 2019 17:39:38 -0700 (PDT)
Date: Sun, 2 Jun 2019 20:39:36 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Liran Alon <liran.alon@oracle.com>
Message-ID: <20190602203905-mutt-send-email-mst@kernel.org>
References: <20190416125912.44001-1-liran.alon@oracle.com>
	<20190418094101.GA23876@stefanha-x1.localdomain>
	<17635C1F-A477-4C0F-B052-2948D853E6CD@oracle.com>
	<20190425083819.GE30231@stefanha-x1.localdomain>
	<20190425135319-mutt-send-email-mst@kernel.org>
	<4E3C459B-630A-4636-A660-11756467A011@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4E3C459B-630A-4636-A660-11756467A011@oracle.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.222.196
Subject: Re: [Qemu-devel] [PATCH v2 0/3] vhost-scsi: Support migration
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
Cc: ehabkost@redhat.com, Stefan Hajnoczi <stefanha@gmail.com>,
	mtosatti@redhat.com, qemu-devel@nongnu.org,
	bijan.mottahedeh@oracle.com, pbonzini@redhat.com,
	nir.weiner@oracle.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 03, 2019 at 02:40:04AM +0300, Liran Alon wrote:
> Any news on when this patch-series is expected to be merged to upstream QEMU?
> It was accepted 2 months ago.
> 
> Thanks,
> -Liran 
> 
> > On 25 Apr 2019, at 20:53, Michael S. Tsirkin <mst@redhat.com> wrote:
> > 
> > On Thu, Apr 25, 2019 at 09:38:19AM +0100, Stefan Hajnoczi wrote:
> >> On Wed, Apr 24, 2019 at 07:38:57PM +0300, Liran Alon wrote:
> >>> 
> >>> 
> >>>> On 18 Apr 2019, at 12:41, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> >>>> 
> >>>> On Tue, Apr 16, 2019 at 03:59:09PM +0300, Liran Alon wrote:
> >>>>> Hi,
> >>>>> 
> >>>>> This patch series aims to add supprot to migrate a VM with a vhost-scsi device.
> >>>>> 
> >>>>> The 1st patch fixes a bug of mistakenly not stopping vhost-scsi backend when a
> >>>>> VM is stopped (As happens on migratino pre-copy completion).
> >>>>> 
> >>>>> The 2nd patch adds ability to save/load vhost-scsi device state in VMState.
> >>>>> 
> >>>>> The 3rd and final paqtch adds a flag to vhost-scsi which allows admin to specify
> >>>>> it's setup supports vhost-scsi migratino. For more detailed information on why
> >>>>> this is valid, see commit message of specific patch.
> >>>>> 
> >>>>> Regards,
> >>>>> -Liran
> >>>> 
> >>>> Looks fine for vhost_scsi.ko.  I have not checked how this interacts
> >>>> with vhost-user-scsi.
> >>>> 
> >>>> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> >>> 
> >>> Gentle Ping.
> >> 
> >> This should go either through Michael's virtio/vhost tree or Paolo's
> >> SCSI tree.
> >> 
> >> Stefan
> > 
> > OK I'll queue it.

Sorry dropped it by mistake after queueing and was not cc'd
so forgot to reapply. Queued now.

-- 
MST

