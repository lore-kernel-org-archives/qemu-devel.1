Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ABA7C282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 17:08:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33B1B208E4
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 17:08:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33B1B208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55608 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYCuy-0005wD-De
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 13:08:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hYCts-0005L2-Sp
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 13:07:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hYCtr-0004Yr-N8
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 13:07:04 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:38493)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hYCtr-0004V8-IH
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 13:07:03 -0400
Received: by mail-qt1-f194.google.com with SMTP id l3so14648489qtj.5
	for <qemu-devel@nongnu.org>; Tue, 04 Jun 2019 10:07:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to;
	bh=laAolIxWEvzr93cRDvn4CwakgubkxX1QjICADAA9WT0=;
	b=paagojnkqYgfcCZptBEFGpIvoRwpcG/hLD7yHVnZxTVDMi9nQp6TEhaMaTBa8QgjSU
	CevJpaJOE1FlLLYxyEvo3S9DKPQTu8asXr0dczl5dFObiZmCj+OM79D2VfnrdI+PTBTD
	haiep0IQyQosxyvf4S5d88QOlTu7NjtSLdXpFgmxrRX2+ADObTe75o41IEwuAH2sUd4a
	RIKFOR2PUxPO2zlGAREoACkZ6qs9jzKBTmviyaau6PRmrQnExVADSon+78JpeGpl8IHA
	kZHkzYTV5+fV7LCfNWjtZNMcz0S4Xj70M1d/AJAyKUOPF8PVsll2iRaeNiNQ9FHaGyE2
	rSeQ==
X-Gm-Message-State: APjAAAWKLex2jAmpnVq/Ga/Ch8B8Ce8Kj8pHEmeYKcdZGAWKHnseu123
	FTv98Uys0Q74fEeP28k7GQAl8A==
X-Google-Smtp-Source: APXvYqy3ca9XNl7j1EtkP6bcku0wPFHAAjpMXex7FnajDJvm22FRbC/FA3ENfhHVFXIjCGrXnRo3IQ==
X-Received: by 2002:ac8:25dd:: with SMTP id f29mr20381519qtf.144.1559668022759;
	Tue, 04 Jun 2019 10:07:02 -0700 (PDT)
Received: from redhat.com (pool-100-0-197-103.bstnma.fios.verizon.net.
	[100.0.197.103]) by smtp.gmail.com with ESMTPSA id
	z123sm9671182qka.7.2019.06.04.10.07.00
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Tue, 04 Jun 2019 10:07:01 -0700 (PDT)
Date: Tue, 4 Jun 2019 13:06:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jens Freimann <jfreimann@redhat.com>
Message-ID: <20190604125037-mutt-send-email-mst@kernel.org>
References: <20190517125820.2885-1-jfreimann@redhat.com>
	<20190517125820.2885-4-jfreimann@redhat.com>
	<20190521094504.GB2915@work-vm>
	<20190530145645.tjwkgi4hae5yblsi@jenstp.localdomain>
	<20190531214748.GN22103@habkost.net>
	<20190603082456.vzpy256kj4o5e5wu@jenstp.localdomain>
	<20190603193648.GQ22103@habkost.net>
	<20190604134321.txlw7wjwe247g5ug@jenstp.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190604134321.txlw7wjwe247g5ug@jenstp.localdomain>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.160.194
Subject: Re: [Qemu-devel] [PATCH 3/4] net/virtio: add failover support
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
Cc: pkrempa@redhat.com, berrange@redhat.com,
	Eduardo Habkost <ehabkost@redhat.com>, aadam@redhat.com,
	qemu-devel@nongnu.org,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>, laine@redhat.com,
	ailan@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 04, 2019 at 03:43:21PM +0200, Jens Freimann wrote:
> On Mon, Jun 03, 2019 at 04:36:48PM -0300, Eduardo Habkost wrote:
> > On Mon, Jun 03, 2019 at 10:24:56AM +0200, Jens Freimann wrote:
> > > On Fri, May 31, 2019 at 06:47:48PM -0300, Eduardo Habkost wrote:
> > > > On Thu, May 30, 2019 at 04:56:45PM +0200, Jens Freimann wrote:
> > > > > On Tue, May 28, 2019 at 11:04:15AM -0400, Michael S. Tsirkin wrote:
> > > > > > On Tue, May 21, 2019 at 10:45:05AM +0100, Dr. David Alan Gilbert wrote:
> > > > > > > * Jens Freimann (jfreimann@redhat.com) wrote:
> > > Why is it bad to fully re-create the device in case of a failed migration?
> > 
> > Bad or not, I thought the whole point of doing it inside QEMU was
> > to do something libvirt wouldn't be able to do (namely,
> > unplugging the device while not freeing resources).  If we are
> > doing something that management software is already capable of
> > doing, what's the point?
> 
> Event though management software seems to be capable of it, a failover
> implementation has never happened. As Michael says network failover is
> a mechanism (there's no good reason not to use a PT device if it is
> available), not a policy. We are now trying to implement it in a
> simple way, contained within QEMU.
> 
> > Quoting a previous message from this thread:
> > 
> > On Thu, May 30, 2019 at 02:09:42PM -0400, Michael S. Tsirkin wrote:
> > | > On Thu, May 30, 2019 at 07:00:23PM +0100, Dr. David Alan Gilbert wrote:
> > | > >  This patch series is very
> > | > > odd precisely because it's trying to do the unplug itself in the
> > | > > migration phase rather than let the management layer do it - so unless
> > | > > it's nailed down how to make sure that's really really bullet proof
> > | > > then we've got to go back and ask the question about whether we should
> > | > > really fix it so it can be done by the management layer.
> > | > >
> > | > > Dave
> > | >
> > | > management already said they can't because files get closed and
> > | > resources freed on unplug and so they might not be able to re-add device
> > | > on migration failure. We do it in migration because that is
> > | > where failures can happen and we can recover.
> 
> This is something that I can work on as well, but it doesn't have to
> be part of this patch set in my opinion. Let's say migration fails and we can't
> re-plug the primary device. We can still use the standby (virtio-net)
> device which would only mean slower networking. How likely is it that
> the primary device is grabbed by another VM between unplugging and
> migration failure anyway?
> 
> regards,
> Jens

I think I agree with Eduardo it's very important to handle this corner
case correctly. Fast networking outside migration is why people use
failover at all.  Someone who can live with a slower virtio would use
just that.

And IIRC this corner case is exactly why libvirt could not
implement it correctly itself and had to push it up the stack
until it fell off the cliff :).

> 
> > 
> > -- 
> > Eduardo

