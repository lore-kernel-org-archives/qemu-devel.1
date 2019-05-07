Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5DBEC004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 13:25:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86CAB2053B
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 13:25:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86CAB2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46791 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hO05g-0005IX-0B
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 09:25:04 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nmavrogi@redhat.com>) id 1hNwsa-0004Ak-BC
	for qemu-devel@nongnu.org; Tue, 07 May 2019 05:59:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nmavrogi@redhat.com>) id 1hNwsZ-0002iB-1i
	for qemu-devel@nongnu.org; Tue, 07 May 2019 05:59:20 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:32906)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <nmavrogi@redhat.com>) id 1hNwsY-0002hj-SB
	for qemu-devel@nongnu.org; Tue, 07 May 2019 05:59:18 -0400
Received: by mail-wm1-f66.google.com with SMTP id s18so7172361wmh.0
	for <qemu-devel@nongnu.org>; Tue, 07 May 2019 02:59:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=EfV8mmeqmHCPvrq7B2/a8CABgRb2+D9FcS4WqpXtkHI=;
	b=bQwMxexKf3SlkbuM6M3SgwF0D6CtWj6BjBCRdpxA3daKvwUJS9K9B/Czb/edogKB8k
	8F+ApvEH0xkhXcCpIKD8L/NIinz9sNgMnfTR4WSzcDcoS4u6vFbPUvmaq6adJaARNsPm
	MR1cCekRCw25FGitu0tyn/v81lvFVBgDoSYLIV8m/8clGixHC9U7c3+qDYbrYsd/Smyb
	gDPkuz93IikmsS2wOSjaJFq+gT0sLSfUHqqUiHHgEBq1YuIhbDX3CT7yLjQHkucFF6No
	b3xRF4GbE4XCQ1111W8TbRW/71WwkEOrlsVZ5gxzGoOE2fAfiDBlT3EnH6hEPeaFwtSp
	Kx3g==
X-Gm-Message-State: APjAAAVDFWZsdutghxrIYP+TaO9gnMILChWUYwqTP+utTSMNyGPR6g6K
	JTeKjX5+bg+6Xkystr2R0GCcJ7hsk4vXAnqghW+Kst5bLHw=
X-Google-Smtp-Source: APXvYqxR8kBccxGJe5mzQiAlOxB3MDbLdD0IdooEVdhdr4I3Az4oFHZCCXRNAhiPOfQd/FEI2GS3C++Xoy3mh0qucek=
X-Received: by 2002:a7b:c353:: with SMTP id l19mr19352224wmj.12.1557223156571; 
	Tue, 07 May 2019 02:59:16 -0700 (PDT)
MIME-Version: 1.0
References: <20180921154323.GS28120@paraplu> <20190502180201.GA31376@paraplu>
In-Reply-To: <20190502180201.GA31376@paraplu>
From: Nikos Mavrogiannopoulos <nmav@redhat.com>
Date: Tue, 7 May 2019 11:59:05 +0200
Message-ID: <CADh2w8TEVZt3KMDiiT8c7Ez+80=gaTB6=8azJQt0Ni58L7e0WQ@mail.gmail.com>
To: Kashyap Chamarthy <kchamart@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.66
X-Mailman-Approved-At: Tue, 07 May 2019 09:24:00 -0400
Subject: Re: [Qemu-devel] [RFC] Virtio RNG: Consider changing the default
 entropy source to /dev/urandom?
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
Cc: Markus Armbruster <armbru@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
	qemu-devel@nongnu.org, "Richard W.M. Jones" <rjones@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In terms of RHEL what is preferred is (1) use a crypto lib, and (2) if
that's not possible use getrandom(). That is summarized in this
article:

https://www.redhat.com/en/blog/understanding-red-hat-enterprise-linux-random-number-generator-interface

On Thu, May 2, 2019 at 8:02 PM Kashyap Chamarthy <kchamart@redhat.com> wrote:
>
> [Reviving this old thread as I don't think we came to a conclusion on
> this.]
>
> On Fri, Sep 21, 2018 at 05:43:23PM +0200, Kashyap Chamarthy wrote:
> > Hi folks,
> >
> > As Markus pointed out in this 'qemu-devel' thread[1],
> > backends/rng-random.c uses '/dev/random' in TYPE_RNG_RANDOM's
> > instance_init() method:
> >
> >     [...]
> >     static void rng_random_init(Object *obj)
> >     {
> >         RngRandom *s = RNG_RANDOM(obj);
> >
> >         object_property_add_str(obj, "filename",
> >                                 rng_random_get_filename,
> >                                 rng_random_set_filename,
> >                                 NULL);
> >
> >         s->filename = g_strdup("/dev/random");
> >         s->fd = -1;
> >     }
> >     [...]
> >
> > And I've looked at hw/virtio/virtio-rng.c:
> >
> >     [...]
> >     static void virtio_rng_device_realize(DeviceState *dev, Error **errp)
> >     {
> >     [...]
> >
> >         if (vrng->conf.rng == NULL) {
> >             vrng->conf.default_backend = RNG_RANDOM(object_new(TYPE_RNG_RANDOM));
> >     [...]
> >
> > From the above, I'm assuming QEMU uses `/dev/random` as the _default_
> > entropy source for a 'virtio-rng-pci' device.  If my assumption is
> > correct, any reason why not to change the default entropy source for
> > 'virtio-rng-pci' devices to `/dev/urandom` (which is the preferred[2]
> > source of entropy)?
> >
> > And I understand (thanks: Eric Blake for correcting my confusion) that
> > there are two cases to distinguish:
> >
> > (a) When QEMU needs a random number, the entropy source it chooses.
> >     IIUC, the answer is: QEMU defers to GnuTLS by default, which uses
> >     getrandom(2), which in turn uses '/dev/urandom' as its entropy
> >     source; if getrandom(2) isn't available, GnuTLS uses `/dev/urandom`
> >     anyway.  (Thanks: Nikos for clarifying this.)
> >
> >     If QEMU is built with GnuTLS _disabled_, which I'm not sure if any
> >     Linux distribution does, then it uses libgcrypt, which in turn uses
> >     the undesired and legacy `/dev/random` as the default entropy
> >     source.
> >
> > (b) When QEMU exposes a Virtio RNG device to the guest, that device
> >     needs a source of entropy, and IIUC, that source needs to be
> >     "non-blocking" (i.e. `/dev/urandom`).  However, currently QEMU
> >     defaults to the problematic `/dev/random`.
> >
> > I'd like to get some more clarity on case (b).
> >
> >
> > [1] https://lists.nongnu.org/archive/html/qemu-devel/2018-06/msg08335.html
> >     -- RNG: Any reason QEMU doesn't default to `/dev/urandom`
> >
> > [2] http://man7.org/linux/man-pages/man4/urandom.4.html
> >
> >
> > --
> > /kashyap
> >
>
> --
> /kashyap

