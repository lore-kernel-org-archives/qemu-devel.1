Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3835FC352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 16:33:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 055FC20708
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 16:33:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jm3Ai9fR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 055FC20708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1YT6-0004ec-7s
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 11:33:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55766)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1j1YRd-0003UC-T3
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 11:31:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1j1YRc-00049r-LK
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 11:31:29 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:43491
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1j1YRb-00047j-A7
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 11:31:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581438686;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VzqDTjv8gID1rTPuZ8ilL/GJRuvyFRHsVxucRjZiYa8=;
 b=Jm3Ai9fRyEEDiF24HMbF9GnaQqpLP0VJHYLTdGOZGXVhIwO8kTSDW/K1/2zCRzT/msCu7l
 n2jTAoD1igIyMXrue7BhFZ+PLTovfZx7N6UDCTF20dJ72L5ROB2Suc98HrpLltO5mLBib7
 xf9vheEgp9J+yNGSpQc5AX2uCta5bPg=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-221-qIb7C_IqNUqDqzIDyGWpAw-1; Tue, 11 Feb 2020 11:31:23 -0500
Received: by mail-qv1-f70.google.com with SMTP id cn2so7534342qvb.1
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 08:31:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=uDg+yEvCnnWHS+5dlCm8H6KCpzkckiv1ab0dkL5Z9lI=;
 b=mE8vU3QNIBinakEaU+Z8sVMs0V2m+40TDf19vy80XWb1zau47B/a4Jh/aALGkJeZZM
 6ki32S/hdgBsaUWsmOXUyaOXUN73i2/cU2aSwqBAW69XX1za89YJW+8gy3bXJfL0rzwo
 9vByud3eMlL5HA2xGtqD7sEwsEq2U6u2khYI5n0mAXUESD4q3F0kiKcfBBQ5Zu2m1V0g
 ECVvvonMsuC8Y3TIMZ3k7VXUdi37iQFy1vplAPVEED3feCewxPqLFKlW1+u+tpguTF78
 QLdRnzXW5m9kyebY9u4wj2xU0+vNZdwoAD7s3dZJ3fX6J8FCZuFVGWK4GkL3fXBDPXcV
 MHVw==
X-Gm-Message-State: APjAAAW6FvuPRc3m/qQa24BLOGbB9adNgGk3sOnkpB/xQ59OVf/jLiuK
 A9NC52XoTbPhtNfz69YHTn/o4D4m9VpsJbA3gj7vISmhjNBHmrhFs6pIUoSSzc5utVy7bKIUtKW
 KiJZacUeYCzBUNWQ=
X-Received: by 2002:a05:620a:15cf:: with SMTP id
 o15mr6969374qkm.140.1581438683175; 
 Tue, 11 Feb 2020 08:31:23 -0800 (PST)
X-Google-Smtp-Source: APXvYqwmmLJO5CQ2LZhsBmlZl0JYhSHQ8CbDA19ynDHfBNVVMjPkmi7MfzuwaMAyXisMSKTjRMEZtA==
X-Received: by 2002:a05:620a:15cf:: with SMTP id
 o15mr6969334qkm.140.1581438682804; 
 Tue, 11 Feb 2020 08:31:22 -0800 (PST)
Received: from redhat.com (bzq-79-176-41-183.red.bezeqint.net. [79.176.41.183])
 by smtp.gmail.com with ESMTPSA id y26sm2541392qtc.94.2020.02.11.08.31.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2020 08:31:21 -0800 (PST)
Date: Tue, 11 Feb 2020 11:31:17 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v2 2/4] virtio-scsi: default num_queues to -smp N
Message-ID: <20200211113108-mutt-send-email-mst@kernel.org>
References: <20200124100159.736209-1-stefanha@redhat.com>
 <20200124100159.736209-3-stefanha@redhat.com>
 <20200127141031.6e108839.cohuck@redhat.com>
 <20200129154438.GC157595@stefanha-x1.localdomain>
 <bc9680fc-c382-301f-a1fe-21740c918570@redhat.com>
 <20200130105235.GC176651@stefanha-x1.localdomain>
 <20200203102529.3op54zggtquoguuo@dritchie>
 <20200203105744.GD1922177@redhat.com>
 <20200203113949.hnjuqzkrqqwst54e@dritchie>
 <20200211162041.GA432724@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <20200211162041.GA432724@stefanha-x1.localdomain>
X-MC-Unique: qIb7C_IqNUqDqzIDyGWpAw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Sergio Lopez <slp@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Feb 11, 2020 at 04:20:41PM +0000, Stefan Hajnoczi wrote:
> On Mon, Feb 03, 2020 at 12:39:49PM +0100, Sergio Lopez wrote:
> > On Mon, Feb 03, 2020 at 10:57:44AM +0000, Daniel P. Berrang=E9 wrote:
> > > On Mon, Feb 03, 2020 at 11:25:29AM +0100, Sergio Lopez wrote:
> > > > On Thu, Jan 30, 2020 at 10:52:35AM +0000, Stefan Hajnoczi wrote:
> > > > > On Thu, Jan 30, 2020 at 01:29:16AM +0100, Paolo Bonzini wrote:
> > > > > > On 29/01/20 16:44, Stefan Hajnoczi wrote:
> > > > > > > On Mon, Jan 27, 2020 at 02:10:31PM +0100, Cornelia Huck wrote=
:
> > > > > > >> On Fri, 24 Jan 2020 10:01:57 +0000
> > > > > > >> Stefan Hajnoczi <stefanha@redhat.com> wrote:
> > > So I think we need to, at the very least, make a clear statement here
> > > about what tuning approach should be applied vCPU count gets high,
> > > and probably even apply that  as a default out of the box approach.
> >=20
> > In general, I would agree, but in this particular case the
> > optimization has an impact on something outside's QEMU control (host's
> > resources), so we lack the information needed to make a proper guess.
> >=20
> > My main concern here is users upgrading QEMU to hit some kind of crash
> > or performance issue, without having touched their VM config. And
>=20
> I don't think this is an issue since only newly created guests are
> affected.  Existing machine types are unchanged.
>=20
> > let's not forget that Stefan said in the cover that this amounts to a
> > 1-4% improvement on 4k operations on an SSD, and I guess that's with
> > iodepth=3D1. I suspect with a larger block size and/or higher iodepth
> > the improvement will be barely noticeable, which means it'll only have
> > a positive impact on users running DB/OLTP or similar workloads on
> > dedicated, directly attached, low-latency storage.
> >=20
> > But don't get me wrong, this is a *good* optimization. It's just I
> > think we should play safe here.
>=20
> The NVMe card I've been testing has 64 queues.  Let's keep the virtio
> limit roughly the same as real hardware.  That way, multi-queue block
> layer support in QEMU will be able to fully exploit the hardware
> (similar to how we size request queues to be larger than the common 64
> /sys/block/FOO/queue/nr_requests).
>=20
> The point of this change is to improve performance on SMP guests.
> Setting the limit to 4-8 is too low, since it leaves guests that most
> need this optimization with a sub-optimal configuration.
>=20
> I will create a 32 vCPU guest with 100 virtio-blk devices and verify
> that enabling multi-queue is successful.
>=20
> Stefan


and that it's helpful for performance?


