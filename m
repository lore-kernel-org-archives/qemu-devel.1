Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 346D9C43218
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 17:54:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2157206A3
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 17:54:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2157206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33201 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJiZn-0007f2-6G
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 13:54:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hJiYv-0007Lp-Kb
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 13:53:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hJiYu-0002Kc-Hw
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 13:53:33 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36061)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hJiYu-0002K8-DV
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 13:53:32 -0400
Received: by mail-qt1-f193.google.com with SMTP id c35so1118005qtk.3
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 10:53:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to;
	bh=DKn2uPVXeHM2vv0uUlHLUnK8FQZ23RMKA1cT8lFwGAk=;
	b=Z7Q9ToF8SKmPJs0LnwGHVkB46KHLqhwSJVEADx35gfq0z51LUqz60fQ1/fUWaPRCz1
	XPDillr3K3Pl3ZkN7o+dBm7P/Rk+/gwuYarNakgvRjCml+tfwtKV8SqayQjU1tG/+IOD
	cdnW0tmNZjWNKzSirZwvv2nq0K/YwS11u+Kg92Hp0r04FLKNf6LbDqMF2CytnViBDnzA
	7+RxAUTXi4mpFqBd0/L7lpmPNeDR5bWmbV5zCghnRb1glHzjJFV2DheyKcmrlQSGZrtC
	ObEAQxyr5PscZBzEp87h2G9weLR5hqutIVqyeWbFzbQgS5ot9noC6H66cnbT/31i6BZ1
	GPmA==
X-Gm-Message-State: APjAAAWFuj9AgZ3N14tJZbXNjz0wpsvC3r8noUpJXr/uYuglljwyI+aB
	9X5sSz+HWTAKuOVQUM7rK0sM3Q==
X-Google-Smtp-Source: APXvYqzJArLl8HGj0G/0LgJOk+WUiKxuKOIFvQpCFnZvJhqpHGAhuq/8UR+TZwluK/jV6cG9rPf8Fw==
X-Received: by 2002:a0c:b24e:: with SMTP id k14mr19269412qve.180.1556214811085;
	Thu, 25 Apr 2019 10:53:31 -0700 (PDT)
Received: from redhat.com (pool-173-76-105-71.bstnma.fios.verizon.net.
	[173.76.105.71]) by smtp.gmail.com with ESMTPSA id
	y18sm12763782qty.78.2019.04.25.10.53.29
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 25 Apr 2019 10:53:30 -0700 (PDT)
Date: Thu, 25 Apr 2019 13:53:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190425135319-mutt-send-email-mst@kernel.org>
References: <20190416125912.44001-1-liran.alon@oracle.com>
	<20190418094101.GA23876@stefanha-x1.localdomain>
	<17635C1F-A477-4C0F-B052-2948D853E6CD@oracle.com>
	<20190425083819.GE30231@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190425083819.GE30231@stefanha-x1.localdomain>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.160.193
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
Cc: ehabkost@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org,
	bijan.mottahedeh@oracle.com, Liran Alon <liran.alon@oracle.com>,
	pbonzini@redhat.com, nir.weiner@oracle.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190425175328.o59WFzfQHg8Isr1sDCHjrGCwh01tivF2JLlndZGXxoI@z>

On Thu, Apr 25, 2019 at 09:38:19AM +0100, Stefan Hajnoczi wrote:
> On Wed, Apr 24, 2019 at 07:38:57PM +0300, Liran Alon wrote:
> > 
> > 
> > > On 18 Apr 2019, at 12:41, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> > > 
> > > On Tue, Apr 16, 2019 at 03:59:09PM +0300, Liran Alon wrote:
> > >> Hi,
> > >> 
> > >> This patch series aims to add supprot to migrate a VM with a vhost-scsi device.
> > >> 
> > >> The 1st patch fixes a bug of mistakenly not stopping vhost-scsi backend when a
> > >> VM is stopped (As happens on migratino pre-copy completion).
> > >> 
> > >> The 2nd patch adds ability to save/load vhost-scsi device state in VMState.
> > >> 
> > >> The 3rd and final paqtch adds a flag to vhost-scsi which allows admin to specify
> > >> it's setup supports vhost-scsi migratino. For more detailed information on why
> > >> this is valid, see commit message of specific patch.
> > >> 
> > >> Regards,
> > >> -Liran
> > > 
> > > Looks fine for vhost_scsi.ko.  I have not checked how this interacts
> > > with vhost-user-scsi.
> > > 
> > > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > 
> > Gentle Ping.
> 
> This should go either through Michael's virtio/vhost tree or Paolo's
> SCSI tree.
> 
> Stefan

OK I'll queue it.

