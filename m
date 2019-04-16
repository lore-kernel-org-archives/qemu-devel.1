Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C18C10F13
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 08:01:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45EB3206BA
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 08:01:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GCV4hUzw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45EB3206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60908 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGJ1i-00023n-CG
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 04:01:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fengyd81@gmail.com>) id 1hGJ0y-0001h3-44
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 04:00:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fengyd81@gmail.com>) id 1hGJ0s-0001zo-Dm
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 04:00:24 -0400
Received: from mail-it1-x135.google.com ([2607:f8b0:4864:20::135]:55386)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <fengyd81@gmail.com>) id 1hGJ0o-0001wA-Tq
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 04:00:16 -0400
Received: by mail-it1-x135.google.com with SMTP id y134so31518854itc.5
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 01:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to; 
	bh=T6Bxgs8V4wEcS8SORC785Avu0Z5WdvarTUDirrj915w=;
	b=GCV4hUzw8LAdPn4sttoPv9c3YrDzS2bjYVSEFIT5rLFAwD/bbfcKPuHqGXKivCERAE
	pE7bwnsKpsRGljNhJ648vjKgWJDFBW/5wUsvLyispsXL8/cR5tR0DvkDlRG4VWsdEdOh
	QY+grbkB1YtaRHQrzBpW1BRf4zS/JVuHiIX5HIfq+FvJLedGMnkY4qiNHIeHGKexQz6T
	HfKjWb5kcubGW7evY5jLejfmfJRiqwzpXQEa+VAbxUO4c/FthXMTSc3sVVgU2lmpN7k3
	jHFawaGX4cpihvoC5CxqVE3pGWZOLPgk54sze/2PJgVZyVXrFuy5mTTjlEvoRBxT+X0p
	5zkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to;
	bh=T6Bxgs8V4wEcS8SORC785Avu0Z5WdvarTUDirrj915w=;
	b=tF6Hvp4URTtbP6bQQJcRidSajgBFdptTX0RKafutNzANcEDoHHgTVEZIHPA0frzsnW
	x+BFFAUG0bWGft17ihA5ql7dZ0XLnl+wdJpfI1/VVAM1SBp8M5GBoAsf2iloK0y+HQxE
	+TG+FtH1H45Kz2kUHeR1kIH3yAACLItW3ZLtAS7UbhR9yjsp9Z7QeqmPtHWHZOeYfqCe
	/5a7gd5vK9lyeNQRLEIgNGkCOWnM+4r5LAqA89s/Ak5ebo55lhTV7QfiW0vlftcm3ZSW
	04z7+EaOr5KEu25DAzd4ezSL158+sJZjVxoGIpKV/BRxqbDMUNQqFRsZWss60aWupScR
	AAmg==
X-Gm-Message-State: APjAAAW8kwAiPFTYDGeS4zYTJHBy7412IoNTy1YrxE6+1JAUsluo/Z3w
	dVUNeIGY/6IAH0LDIfrKmLl+4uZeq5G4iHOyif8JLA==
X-Google-Smtp-Source: APXvYqzRbuEOhrqYsDSj2cigSjM/UccF4gWa7FtOvgidddLmmmzdr0W+THPI5JRRpr3Pycp1ACKkqlReVwwtPQyV3t8=
X-Received: by 2002:a24:205:: with SMTP id 5mr27056382itu.150.1555401610347;
	Tue, 16 Apr 2019 01:00:10 -0700 (PDT)
MIME-Version: 1.0
References: <CACnvu8YKqaZA7XSD41=SQrUL7h9YafJMgKPe5cJZd3XZ3zrSNw@mail.gmail.com>
	<20190415145358.GA2893@work-vm>
	<CACnvu8a5DjAUhfAGmi6GtpD1V2hfoNLTkKEgbsFuL_6GrRc+pg@mail.gmail.com>
In-Reply-To: <CACnvu8a5DjAUhfAGmi6GtpD1V2hfoNLTkKEgbsFuL_6GrRc+pg@mail.gmail.com>
From: fengyd <fengyd81@gmail.com>
Date: Tue, 16 Apr 2019 15:59:58 +0800
Message-ID:
 <CACnvu8Y9Ub5PAOt18ukzvOoDxmfzwvygWWwOZaT5Q2Eig6YFTw@mail.gmail.com>
To: qemu-devel@nongnu.org
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::135
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: [Qemu-devel] Fwd:  How live migration work for vhost-user
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190416075958.zZP2cP4xfuvFVvwOWuCtU67N6Y_IudQYLaFeGgrE44Q@z>

---------- Forwarded message ---------
From: fengyd <fengyd81@gmail.com>
Date: Tue, 16 Apr 2019 at 09:17
Subject: Re: [Qemu-devel] How live migration work for vhost-user
To: Dr. David Alan Gilbert <dgilbert@redhat.com>


Hi,

Any special feature needs to be supported on guest driver?
Because it's OK for standard Linux VM, but not OK for our VM where virtio
is  implemented by ourself.

And with qemu-kvm-ev-2.6, live migration can work with our VM where virtio
is  implemented by ourself.

Thanks
Yafeng

On Mon, 15 Apr 2019 at 22:54, Dr. David Alan Gilbert <dgilbert@redhat.com>
wrote:

> * fengyd (fengyd81@gmail.com) wrote:
> > Hi,
> >
> > During live migration,  the folloing log can see in nova-compute.log in
> my
> > environment:
> >  ERROR nova.virt.libvirt.driver [req-039a85e1-e7a1-4a63-bc6d-c4b9a044aab6
> > 0cdab20dc79f4bc6ae5790e7b4a898ac 3363c319773549178acc67f32c78310e -
> default
> > default] [instance: 5ec719f4-1865-4afe-a207-3d9fae22c410] Live Migration
> > failure: internal error: qemu unexpectedly closed the monitor:
> > 2019-04-15T02:58:22.213897Z qemu-kvm: VQ 0
> > size 0x100 < last_avail_idx 0x1e - used_idx 0x23
> >
> > It's OK for standard Linux VM, but not OK for our VM where virtio is
> > implemented by ourself.
> > KVM version as follow:
> > qemu-kvm-common-ev-2.12.0-18.el7_6.3.1.x86_64
> > qemu-kvm-ev-2.12.0-18.el7_6.3.1.x86_64
> > libvirt-daemon-kvm-3.9.0-14.2.el7.centos.ncir.8.x86_64
> >
> > Do you know what's the difference between virtio and vhost-user during
> > migration?
> > The function virtio_load in Qemu is called for virtio and vhost-user
> during
> > migration.
> > For virtio,  last_avail_idx  and used_idx are stored in Qemu, Qemu is
> > responsible for updating their values accordingly
> > For vhost-user, last_avail_idx  and used_idx are stored in vhost-user
> app,
> > eg. DPDK, not in Qemu?
> > How does migration work for vhost-user?
>
> I don't know the details, but my understanding is that vhost-user
> tells the vhost-user client about an area of 'log' memory, where the
> vhost-user client must mark pages as dirty.
>
> In the qemu source, see docs/interop/vhost-user.txt and see
> the VHOST_SET_LOG_BASE and VHOST_USER_SET_LOG_FD calls.
>
> If the client correctly marks the areas as dirty, then qemu
> should resend those pages across.
>
>
> Dave
>
> > Thanks in advance
> > Yafeng
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>
