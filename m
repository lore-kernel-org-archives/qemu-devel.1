Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF45C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 00:09:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97AB520727
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 00:09:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ndufresne-ca.20150623.gappssmtp.com header.i=@ndufresne-ca.20150623.gappssmtp.com header.b="gvv/e0on"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97AB520727
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZNv1-0001Z6-Qw
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 20:09:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39322)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas@ndufresne.ca>)
 id 1jZNRI-0006YR-U7
 for qemu-devel@nongnu.org; Thu, 14 May 2020 19:38:56 -0400
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741]:34677)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nicolas@ndufresne.ca>)
 id 1jZNRH-0007PQ-7T
 for qemu-devel@nongnu.org; Thu, 14 May 2020 19:38:56 -0400
Received: by mail-qk1-x741.google.com with SMTP id 190so793899qki.1
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 16:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ndufresne-ca.20150623.gappssmtp.com; s=20150623;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=jbaw0/cMUjrfO1oPa3pk+E2eiJXTX1fTABBIaC6wiG0=;
 b=gvv/e0onhd4GR/067vRbxkw9u0RX/1J4zBNfS0YVKR0ggPZDdb/p6dM8f3H0bVo4VH
 jeKivWdZdR2xa7nvPk0XFBE5dMy89ktaFA+1ItwD8VWLdGUG94rIOi4q3kKrXwS0oDi+
 2tJWiI2uljSZm4CnIMf3x7HHde1gxR3Rw3QAbfiJGE4/dj2Er+OnDiuPn8KH3EGsbKPt
 6oAe4RRWnECJH3Rb0IT658gGfNf6FSPtjS8iZehOFwrvgdXKRL404ZeqClhqe3j9VQvP
 Qw0BuJy60hbwF2z8XPyAEin3p1Wq63PDsAMsz8CrKXVBzKYoqxugAfzEVNprCYJqTQMC
 McxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=jbaw0/cMUjrfO1oPa3pk+E2eiJXTX1fTABBIaC6wiG0=;
 b=nEZTm0iuuWe18X4Cnj3OQkux77BPbbweQP/QDY5td+fdHxG8grI0bMPyLfrrx9lEQH
 Es746iKsxD4mw6q1W36U5Pr9V2mh1jS3TP5PftWJfr4cx0ht+B2FHKQl7UorIeWml2nQ
 ynknTaF5TkiwHACY0zyqeRfQtt91fvw1Elu2rmghX0OU1ZOUY1NhkoT8PhtVCSY8hjff
 GvsymX9S/27x2Vep4mU8in2ulxxA01ZYnF/PtMSQmjeuJ0eLtN8b01vJmc++5M5wqu/D
 N1liub2sfWx162AQ6LriybkOs6S80ZZ+sxbpXqUauUz4cHGeCXdspGJu7lDqHJ60Zcly
 GpAw==
X-Gm-Message-State: AOAM532aCf/q6j7fsOX6Ps93YsCVvdtjJQQqPmXhrHUSvzH7s+FxQqqQ
 lHVdJ5kd/M0LgQsBLKLIKCu2pQ==
X-Google-Smtp-Source: ABdhPJy+L+4w17J7N+kp96fQxmIlAp+BUXSTQzD0+1cHnNL6jCVgbxsBjQgTpy5Gx9qSx5mYkB9Cww==
X-Received: by 2002:a37:a917:: with SMTP id s23mr797338qke.443.1589499533668; 
 Thu, 14 May 2020 16:38:53 -0700 (PDT)
Received: from nicolas-tpx395 ([192.222.193.21])
 by smtp.gmail.com with ESMTPSA id t130sm327724qka.14.2020.05.14.16.38.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2020 16:38:52 -0700 (PDT)
Message-ID: <67e1ba850c5fbf84b09ec8266ab70dd08a10c2e3.camel@ndufresne.ca>
Subject: Re: [virtio-dev] Re: Fwd: Qemu Support for Virtio Video V4L2 driver
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: Keiichi Watanabe <keiichiw@chromium.org>, Dmitry Sepp
 <dmitry.sepp@opensynergy.com>
Date: Thu, 14 May 2020 19:38:50 -0400
In-Reply-To: <CAD90VcYeF7drbYNDiEioPBHcQcifqDYUia_CKqNLv_5VAMjPKw@mail.gmail.com>
References: <CAK25hWN3kJcW-dcpryFrvZ50t7Y0Z=MZM66-8NMuhwjRpNo2aQ@mail.gmail.com>
 <CAD90Vcb-x1KV++fWrmx+fLV5eNc2DiTtn8=OjQi7aUf7B0ULdA@mail.gmail.com>
 <CAK25hWM-hLdk=MSKgceumOUo9ZNBrrmM8qSe7MvTUAPGmur_HQ@mail.gmail.com>
 <2515515.r9knKAEANn@os-lin-dmo>
 <CAD90VcYeF7drbYNDiEioPBHcQcifqDYUia_CKqNLv_5VAMjPKw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.1 (3.36.1-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::741;
 envelope-from=nicolas@ndufresne.ca; helo=mail-qk1-x741.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 14 May 2020 20:08:40 -0400
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
Cc: Samiullah Khawaja <samiullah.khawaja@opensynergy.com>,
 virtio-dev@lists.oasis-open.org, Alex Lau <alexlau@chromium.org>,
 Kiran Pawar <Kiran.Pawar@opensynergy.com>,
 Alexandre Courbot <acourbot@chromium.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Tomasz Figa <tfiga@chromium.org>, Saket Sinha <saket.sinha89@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Hans Verkuil <hverkuil@xs4all.nl>,
 Emil Velikov <emil.velikov@collabora.com>, Pawel Osciak <posciak@chromium.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le lundi 11 mai 2020 à 20:49 +0900, Keiichi Watanabe a écrit :
> Hi,
> 
> Thanks Saket for your feedback. As Dmitry mentioned, we're focusing on
> video encoding and decoding, not camera. So, my reply was about how to
> implement paravirtualized video codec devices.
> 
> On Mon, May 11, 2020 at 8:25 PM Dmitry Sepp <dmitry.sepp@opensynergy.com>
> wrote:
> > Hi Saket,
> > 
> > On Montag, 11. Mai 2020 13:05:53 CEST Saket Sinha wrote:
> > > Hi Keiichi,
> > > 
> > > I do not support the approach of  QEMU implementation forwarding
> > > requests to the host's vicodec module since  this can limit the scope
> > > of the virtio-video device only for testing,
> > 
> > That was my understanding as well.
> 
> Not really because the API which the vicodec provides is V4L2 stateful
> decoder interface [1], which are also used by other video drivers on
> Linux.
> The difference between vicodec and actual device drivers is that
> vicodec performs decoding in the kernel space without using special
> video devices. In other words, vicodec is a software decoder in kernel
> space which provides the same interface with actual video drivers.
> Thus, if the QEMU implementation can forward virtio-video requests to
> vicodec, it can forward them to the actual V4L2 video decoder devices
> as well and VM gets access to a paravirtualized video device.
> 
> The reason why we discussed vicodec in the previous thread was it'll
> allow us to test the virtio-video driver without hardware requirement.
> 
> [1] https://www.kernel.org/doc/html/latest/media/uapi/v4l/dev-decoder.html
> 
> > > which instead can be used with multiple use cases such as -
> > > 
> > > 1. VM gets access to paravirtualized  camera devices which shares the
> > > video frames input through actual HW camera attached to Host.
> > 
> > This use-case is out of the scope of virtio-video. Initially I had a plan to
> > support capture-only streams like camera as well, but later the decision was
> > made upstream that camera should be implemented as separate device type. We
> > still plan to implement a simple frame capture capability as a downstream
> > patch though.
> > 
> > > 2. If Host has multiple video devices (especially in ARM SOCs over
> > > MIPI interfaces or USB), different VM can be started or hotplugged
> > > with selective video streams from actual HW video devices.
> > 
> > We do support this in our device implementation. But spec in general has no
> > requirements or instructions regarding this. And it is in fact flexible
> > enough
> > to provide abstraction on top of several HW devices.
> > 
> > > Also instead of using libraries like Gstreamer in Host userspace, they
> > > can also be used inside the VM userspace after getting access to
> > > paravirtualized HW camera devices .
> 
> Regarding Gstreamer, I intended this video decoding API [2]. If QEMU
> can translate virtio-video requests to this API, we can easily support
> multiple platforms.
> I'm not sure how feasible it is though, as I have no experience of
> using this API by myself...

Not sure which API you aim exactly, but what one need to remember is that
mapping virtio-video CODEC on top of VAAPI, V4L2 Stateless, NVDEC or other type
of "stateless" CODEC is not trivial and can't be done without userspace. Notably
because we don't want to do bitstream parsing in the kernel on the main CPU as
security would otherwise be very hard to guaranty. The other driver using same
API as virtio-video do bitstream parsing on a dedicated co-processor (through
firmware blobs though).

Having bridges between virtio-video, qemu and some abstraction library like
FFMPEG or GStreamer is certainly the best solution if you want to virtualize any
type of HW accelerated decoder or if you need to virtualized something
proprietary (like NVDEC). Please shout if you need help.

> 
> [2] 
> https://gstreamer.freedesktop.org/documentation/tutorials/playback/hardware-accelerated-video-decoding.html
> 
> Best regards,
> Keiichi
> 
> > 
> > Regarding the cameras, unfortunately same as above.
> > 
> > Best regards,
> > Dmitry.
> > 
> > > Regards,
> > > Saket Sinha
> > > 
> > > On Mon, May 11, 2020 at 12:20 PM Keiichi Watanabe <keiichiw@chromium.org>
> > wrote:
> > > > Hi Dmitry,
> > > > 
> > > > On Mon, May 11, 2020 at 6:40 PM Dmitry Sepp <dmitry.sepp@opensynergy.com
> > > > >
> > wrote:
> > > > > Hi Saket and all,
> > > > > 
> > > > > As we are working with automotive platforms, unfortunately we don't
> > > > > plan
> > > > > any Qemu reference implementation so far.
> > > > > 
> > > > > Of course we are ready to support the community if any help is needed.
> > > > > Is
> > > > > there interest in support for the FWHT format only for testing purpose
> > > > > or you want a full-featured implementation on the QEMU side?
> > > > 
> > > > I guess we don't need to implement the codec algorithm in QEMU.
> > > > Rather, QEMU forwards virtio-video requests to the host video device
> > > > or a software library such as GStreamer or ffmpeg.
> > > > So, what we need to implement in QEMU is a kind of API translation,
> > > > which shouldn't care about actual video formats so much.
> > > > 
> > > > Regarding the FWHT format discussed in the patch thread [1], in my
> > > > understanding, Hans suggested to have QEMU implementation forwarding
> > > > requests to the host's vicodec module [2].
> > > > Then, we'll be able to test the virtio-video driver on QEMU on Linux
> > > > even if the host Linux has no hardware video decoder.
> > > > (Please correct me if I'm wrong.)
> > > > 
> > > > Let me add Hans and Linux media ML in CC.
> > > > 
> > > > [1]  https://patchwork.linuxtv.org/patch/61717/
> > > > [2] https://lwn.net/Articles/760650/
> > > > 
> > > > Best regards,
> > > > Keiichi
> > > > 
> > > > > Please note that the spec is not finalized yet and a major update is
> > > > > now
> > > > > discussed with upstream and the Chrome OS team, which is also
> > > > > interested
> > > > > and deeply involved in the process. The update mostly implies some
> > > > > rewording and reorganization of data structures, but for sure will
> > > > > require a driver rework.
> > > > > 
> > > > > Best regards,
> > > > > Dmitry.
> > > > > 
> > > > > On Samstag, 9. Mai 2020 16:11:43 CEST Saket Sinha wrote:
> > > > > > Hi,
> > > > > > 
> > > > > > As suggested on #qemu-devel IRC channel, I am including virtio-dev,
> > > > > > Gerd and Michael to point in the right direction how to move forward
> > > > > > with Qemu support for Virtio Video V4L2 driver
> > > > > > posted in [1].
> > > > > > 
> > > > > > [1]: https://patchwork.linuxtv.org/patch/61717/
> > > > > > 
> > > > > > Regards,
> > > > > > Saket Sinha
> > > > > > 
> > > > > > On Sat, May 9, 2020 at 1:09 AM Saket Sinha <saket.sinha89@gmail.com>
> > wrote:
> > > > > > > Hi ,
> > > > > > > 
> > > > > > > This is to inquire about Qemu support for Virtio Video V4L2 driver
> > > > > > > posted in [1].
> > > > > > > I am currently not aware of any upstream effort for Qemu reference
> > > > > > > implementation and would like to discuss how to proceed with the
> > > > > > > same.
> > > > > > > 
> > > > > > > [1]: https://patchwork.linuxtv.org/patch/61717/
> > > > > > > 
> > > > > > > Regards,
> > > > > > > Saket Sinha
> > > > > 
> > > > > ---------------------------------------------------------------------
> > > > > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> > > > > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org


