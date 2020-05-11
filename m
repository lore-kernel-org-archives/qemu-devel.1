Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E14DDC54E4A
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 14:10:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99BD8206DB
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 14:10:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99BD8206DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=opensynergy.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY98u-0007Jc-Nm
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 10:10:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56988)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Dmitry.Sepp@opensynergy.com>)
 id 1jY6Yx-0000L9-Qq
 for qemu-devel@nongnu.org; Mon, 11 May 2020 07:25:35 -0400
Received: from plasma4.jpberlin.de ([80.241.57.33]:41649)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Dmitry.Sepp@opensynergy.com>)
 id 1jY6Yw-0004gJ-8G
 for qemu-devel@nongnu.org; Mon, 11 May 2020 07:25:35 -0400
Received: from hefe.heinlein-support.de (hefe.heinlein-support.de
 [91.198.250.172])
 by plasma.jpberlin.de (Postfix) with ESMTP id EACD8BCC98;
 Mon, 11 May 2020 13:25:25 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from plasma.jpberlin.de ([91.198.250.140])
 by hefe.heinlein-support.de (hefe.heinlein-support.de [91.198.250.172])
 (amavisd-new, port 10030)
 with ESMTP id Gde9B_1XPwG2; Mon, 11 May 2020 13:25:24 +0200 (CEST)
Received: from webmail.opensynergy.com (unknown [217.66.60.5])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "webmail.opensynergy.com",
 Issuer "GeoTrust EV RSA CA 2018" (not verified))
 (Authenticated sender: opensynergy@jpberlin.de)
 by plasma.jpberlin.de (Postfix) with ESMTPSA id DD4B9B9C86;
 Mon, 11 May 2020 13:25:23 +0200 (CEST)
Received: from os-lin-dmo.localnet (10.25.255.1) by MXS01.open-synergy.com
 (10.25.10.17) with Microsoft SMTP Server (TLS) id 14.3.487.0; Mon, 11 May
 2020 13:25:23 +0200
From: Dmitry Sepp <dmitry.sepp@opensynergy.com>
To: Saket Sinha <saket.sinha89@gmail.com>
Subject: Re: [virtio-dev] Re: Fwd: Qemu Support for Virtio Video V4L2 driver
Date: Mon, 11 May 2020 13:25:23 +0200
Message-ID: <2515515.r9knKAEANn@os-lin-dmo>
Organization: OpenSynergy
In-Reply-To: <CAK25hWM-hLdk=MSKgceumOUo9ZNBrrmM8qSe7MvTUAPGmur_HQ@mail.gmail.com>
References: <CAK25hWN3kJcW-dcpryFrvZ50t7Y0Z=MZM66-8NMuhwjRpNo2aQ@mail.gmail.com>
 <CAD90Vcb-x1KV++fWrmx+fLV5eNc2DiTtn8=OjQi7aUf7B0ULdA@mail.gmail.com>
 <CAK25hWM-hLdk=MSKgceumOUo9ZNBrrmM8qSe7MvTUAPGmur_HQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [10.25.255.1]
X-Rspamd-Queue-Id: EACD8BCC98
X-Rspamd-Score: -5.33 / 15.00 / 200.00
Received-SPF: none client-ip=80.241.57.33;
 envelope-from=Dmitry.Sepp@opensynergy.com; helo=plasma4.jpberlin.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 05:40:32
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 11 May 2020 10:09:20 -0400
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
 Tomasz Figa <tfiga@chromium.org>, Keiichi Watanabe <keiichiw@chromium.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Hans Verkuil <hverkuil@xs4all.nl>,
 Pawel Osciak <posciak@chromium.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Saket,

On Montag, 11. Mai 2020 13:05:53 CEST Saket Sinha wrote:
> Hi Keiichi,
> 
> I do not support the approach of  QEMU implementation forwarding
> requests to the host's vicodec module since  this can limit the scope
> of the virtio-video device only for testing,

That was my understanding as well.

> which instead can be used with multiple use cases such as -
> 
> 1. VM gets access to paravirtualized  camera devices which shares the
> video frames input through actual HW camera attached to Host.

This use-case is out of the scope of virtio-video. Initially I had a plan to 
support capture-only streams like camera as well, but later the decision was 
made upstream that camera should be implemented as separate device type. We 
still plan to implement a simple frame capture capability as a downstream 
patch though.

> 
> 2. If Host has multiple video devices (especially in ARM SOCs over
> MIPI interfaces or USB), different VM can be started or hotplugged
> with selective video streams from actual HW video devices.

We do support this in our device implementation. But spec in general has no 
requirements or instructions regarding this. And it is in fact flexible enough 
to provide abstraction on top of several HW devices.

> 
> Also instead of using libraries like Gstreamer in Host userspace, they
> can also be used inside the VM userspace after getting access to
> paravirtualized HW camera devices .
> 

Regarding the cameras, unfortunately same as above.

Best regards,
Dmitry.

> Regards,
> Saket Sinha
> 
> On Mon, May 11, 2020 at 12:20 PM Keiichi Watanabe <keiichiw@chromium.org> 
wrote:
> > Hi Dmitry,
> > 
> > On Mon, May 11, 2020 at 6:40 PM Dmitry Sepp <dmitry.sepp@opensynergy.com> 
wrote:
> > > Hi Saket and all,
> > > 
> > > As we are working with automotive platforms, unfortunately we don't plan
> > > any Qemu reference implementation so far.
> > > 
> > > Of course we are ready to support the community if any help is needed.
> > > Is
> > > there interest in support for the FWHT format only for testing purpose
> > > or you want a full-featured implementation on the QEMU side?
> > 
> > I guess we don't need to implement the codec algorithm in QEMU.
> > Rather, QEMU forwards virtio-video requests to the host video device
> > or a software library such as GStreamer or ffmpeg.
> > So, what we need to implement in QEMU is a kind of API translation,
> > which shouldn't care about actual video formats so much.
> > 
> > Regarding the FWHT format discussed in the patch thread [1], in my
> > understanding, Hans suggested to have QEMU implementation forwarding
> > requests to the host's vicodec module [2].
> > Then, we'll be able to test the virtio-video driver on QEMU on Linux
> > even if the host Linux has no hardware video decoder.
> > (Please correct me if I'm wrong.)
> > 
> > Let me add Hans and Linux media ML in CC.
> > 
> > [1]  https://patchwork.linuxtv.org/patch/61717/
> > [2] https://lwn.net/Articles/760650/
> > 
> > Best regards,
> > Keiichi
> > 
> > > Please note that the spec is not finalized yet and a major update is now
> > > discussed with upstream and the Chrome OS team, which is also interested
> > > and deeply involved in the process. The update mostly implies some
> > > rewording and reorganization of data structures, but for sure will
> > > require a driver rework.
> > > 
> > > Best regards,
> > > Dmitry.
> > > 
> > > On Samstag, 9. Mai 2020 16:11:43 CEST Saket Sinha wrote:
> > > > Hi,
> > > > 
> > > > As suggested on #qemu-devel IRC channel, I am including virtio-dev,
> > > > Gerd and Michael to point in the right direction how to move forward
> > > > with Qemu support for Virtio Video V4L2 driver
> > > > posted in [1].
> > > > 
> > > > [1]: https://patchwork.linuxtv.org/patch/61717/
> > > > 
> > > > Regards,
> > > > Saket Sinha
> > > > 
> > > > On Sat, May 9, 2020 at 1:09 AM Saket Sinha <saket.sinha89@gmail.com> 
wrote:
> > > > > Hi ,
> > > > > 
> > > > > This is to inquire about Qemu support for Virtio Video V4L2 driver
> > > > > posted in [1].
> > > > > I am currently not aware of any upstream effort for Qemu reference
> > > > > implementation and would like to discuss how to proceed with the
> > > > > same.
> > > > > 
> > > > > [1]: https://patchwork.linuxtv.org/patch/61717/
> > > > > 
> > > > > Regards,
> > > > > Saket Sinha
> > > 
> > > ---------------------------------------------------------------------
> > > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> > > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org



