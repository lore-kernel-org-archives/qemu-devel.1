Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 759A5C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 11:43:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BCE220708
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 11:43:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SB9ouBKO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BCE220708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY6q4-0007iB-CX
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 07:43:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57778)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jY6g2-0005lA-1I
 for qemu-devel@nongnu.org; Mon, 11 May 2020 07:32:54 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:31574
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jY6fz-0007E8-DQ
 for qemu-devel@nongnu.org; Mon, 11 May 2020 07:32:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589196769;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e1jXsjLDgxxDL3WPWWIYZi3LkILVb4BgCfucYuGiTE4=;
 b=SB9ouBKObBoHtxuk8n6SE3vvwSNtQRUMcbJfqfvdkNgGuFT39/GSt6jM4QGKxydRGVr340
 0tihQ6T8otjm9AfsysP1yyxMQXVzs2ToXeFNaq92iDuMbPMVgxArNuFYeD5DPdV0aL05+t
 oTspTjDv1DDF+EjLB61yHXVEjwz0qEs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-BEMZUNZDP3y_QTNtTYRwXg-1; Mon, 11 May 2020 07:32:32 -0400
X-MC-Unique: BEMZUNZDP3y_QTNtTYRwXg-1
Received: by mail-wr1-f72.google.com with SMTP id p2so3197104wrm.6
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 04:32:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=e1jXsjLDgxxDL3WPWWIYZi3LkILVb4BgCfucYuGiTE4=;
 b=OGAaRjQ812YfNwD7B1jynHISejiOmQM45tXgUDoXAGPmXu0R6CjOIbSQCAT1ogjZOV
 AqDiR9hR7YYTIN6kvu0ubum/EE2WDXbpp11ocCJgpzJhdKzoBzvzWDvG0YRrgPuVWQx8
 7Nan4Db3zm9PW7i0/bBWsmD3P0K/eYMSI59oS8nseeQhKUO99DfBjCyhRDC6uDdvyE9J
 CXemJ/3LzPVwtNrFqQOH0qrLPDLN+zl6cy8VbS03cUqk4KhmWsyuV0IRNPWIxbV6Ecp7
 WC9MLYfte1TM+yrElUHKvPTVspNq6TtJiqXSOGEdHIKuQUURtj9B3A6pLzkwgIWfFWBV
 86Lg==
X-Gm-Message-State: AGi0PuY2KIadFrQ7FK6LbZDBcJ8CIAdAxB5HNb1AFcAFwVbI4h8EXexc
 iQ0CafqrjX05WxTGqTVCUZjnXCLD5j1H8hjMBVNdtjZ/sTur7pHsDFjW2q0K2NNoxF5YmcoC65I
 gNlBfgmAE8/UNtl4=
X-Received: by 2002:a5d:6702:: with SMTP id o2mr12408292wru.231.1589196751252; 
 Mon, 11 May 2020 04:32:31 -0700 (PDT)
X-Google-Smtp-Source: APiQypKA9n3K0ELkFktaIlu98BryncK5bEhJy6F4YwSdJ/XxV3R5g1GD3Bw9Uvvc/yh06uG9G61XXw==
X-Received: by 2002:a5d:6702:: with SMTP id o2mr12408253wru.231.1589196750820; 
 Mon, 11 May 2020 04:32:30 -0700 (PDT)
Received: from redhat.com (bzq-79-179-68-225.red.bezeqint.net. [79.179.68.225])
 by smtp.gmail.com with ESMTPSA id s11sm17053819wrp.79.2020.05.11.04.32.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2020 04:32:30 -0700 (PDT)
Date: Mon, 11 May 2020 07:32:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dmitry Sepp <dmitry.sepp@opensynergy.com>
Subject: Re: [virtio-dev] Re: Fwd: Qemu Support for Virtio Video V4L2 driver
Message-ID: <20200511073049-mutt-send-email-mst@kernel.org>
References: <CAK25hWN3kJcW-dcpryFrvZ50t7Y0Z=MZM66-8NMuhwjRpNo2aQ@mail.gmail.com>
 <CAD90Vcb-x1KV++fWrmx+fLV5eNc2DiTtn8=OjQi7aUf7B0ULdA@mail.gmail.com>
 <CAK25hWM-hLdk=MSKgceumOUo9ZNBrrmM8qSe7MvTUAPGmur_HQ@mail.gmail.com>
 <2515515.r9knKAEANn@os-lin-dmo>
MIME-Version: 1.0
In-Reply-To: <2515515.r9knKAEANn@os-lin-dmo>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 03:10:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Samiullah Khawaja <samiullah.khawaja@opensynergy.com>,
 Keiichi Watanabe <keiichiw@chromium.org>, Alex Lau <alexlau@chromium.org>,
 Kiran Pawar <Kiran.Pawar@opensynergy.com>,
 Alexandre Courbot <acourbot@chromium.org>, virtio-dev@lists.oasis-open.org,
 qemu-devel@nongnu.org, Tomasz Figa <tfiga@chromium.org>,
 Saket Sinha <saket.sinha89@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Hans Verkuil <hverkuil@xs4all.nl>, Pawel Osciak <posciak@chromium.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 11, 2020 at 01:25:23PM +0200, Dmitry Sepp wrote:
> Hi Saket,
> 
> On Montag, 11. Mai 2020 13:05:53 CEST Saket Sinha wrote:
> > Hi Keiichi,
> > 
> > I do not support the approach of  QEMU implementation forwarding
> > requests to the host's vicodec module since  this can limit the scope
> > of the virtio-video device only for testing,
> 
> That was my understanding as well.
> 
> > which instead can be used with multiple use cases such as -
> > 
> > 1. VM gets access to paravirtualized  camera devices which shares the
> > video frames input through actual HW camera attached to Host.
> 
> This use-case is out of the scope of virtio-video. Initially I had a plan to 
> support capture-only streams like camera as well, but later the decision was 
> made upstream that camera should be implemented as separate device type. We 
> still plan to implement a simple frame capture capability as a downstream 
> patch though.

You want to spec out what's in the field, spec-wise internal up/down
stream distinctions are not important.

> > 
> > 2. If Host has multiple video devices (especially in ARM SOCs over
> > MIPI interfaces or USB), different VM can be started or hotplugged
> > with selective video streams from actual HW video devices.
> 
> We do support this in our device implementation. But spec in general has no 
> requirements or instructions regarding this. And it is in fact flexible enough 
> to provide abstraction on top of several HW devices.
> 
> > 
> > Also instead of using libraries like Gstreamer in Host userspace, they
> > can also be used inside the VM userspace after getting access to
> > paravirtualized HW camera devices .
> > 
> 
> Regarding the cameras, unfortunately same as above.
> 
> Best regards,
> Dmitry.
> 
> > Regards,
> > Saket Sinha
> > 
> > On Mon, May 11, 2020 at 12:20 PM Keiichi Watanabe <keiichiw@chromium.org> 
> wrote:
> > > Hi Dmitry,
> > > 
> > > On Mon, May 11, 2020 at 6:40 PM Dmitry Sepp <dmitry.sepp@opensynergy.com> 
> wrote:
> > > > Hi Saket and all,
> > > > 
> > > > As we are working with automotive platforms, unfortunately we don't plan
> > > > any Qemu reference implementation so far.
> > > > 
> > > > Of course we are ready to support the community if any help is needed.
> > > > Is
> > > > there interest in support for the FWHT format only for testing purpose
> > > > or you want a full-featured implementation on the QEMU side?
> > > 
> > > I guess we don't need to implement the codec algorithm in QEMU.
> > > Rather, QEMU forwards virtio-video requests to the host video device
> > > or a software library such as GStreamer or ffmpeg.
> > > So, what we need to implement in QEMU is a kind of API translation,
> > > which shouldn't care about actual video formats so much.
> > > 
> > > Regarding the FWHT format discussed in the patch thread [1], in my
> > > understanding, Hans suggested to have QEMU implementation forwarding
> > > requests to the host's vicodec module [2].
> > > Then, we'll be able to test the virtio-video driver on QEMU on Linux
> > > even if the host Linux has no hardware video decoder.
> > > (Please correct me if I'm wrong.)
> > > 
> > > Let me add Hans and Linux media ML in CC.
> > > 
> > > [1]  https://patchwork.linuxtv.org/patch/61717/
> > > [2] https://lwn.net/Articles/760650/
> > > 
> > > Best regards,
> > > Keiichi
> > > 
> > > > Please note that the spec is not finalized yet and a major update is now
> > > > discussed with upstream and the Chrome OS team, which is also interested
> > > > and deeply involved in the process. The update mostly implies some
> > > > rewording and reorganization of data structures, but for sure will
> > > > require a driver rework.
> > > > 
> > > > Best regards,
> > > > Dmitry.
> > > > 
> > > > On Samstag, 9. Mai 2020 16:11:43 CEST Saket Sinha wrote:
> > > > > Hi,
> > > > > 
> > > > > As suggested on #qemu-devel IRC channel, I am including virtio-dev,
> > > > > Gerd and Michael to point in the right direction how to move forward
> > > > > with Qemu support for Virtio Video V4L2 driver
> > > > > posted in [1].
> > > > > 
> > > > > [1]: https://patchwork.linuxtv.org/patch/61717/
> > > > > 
> > > > > Regards,
> > > > > Saket Sinha
> > > > > 
> > > > > On Sat, May 9, 2020 at 1:09 AM Saket Sinha <saket.sinha89@gmail.com> 
> wrote:
> > > > > > Hi ,
> > > > > > 
> > > > > > This is to inquire about Qemu support for Virtio Video V4L2 driver
> > > > > > posted in [1].
> > > > > > I am currently not aware of any upstream effort for Qemu reference
> > > > > > implementation and would like to discuss how to proceed with the
> > > > > > same.
> > > > > > 
> > > > > > [1]: https://patchwork.linuxtv.org/patch/61717/
> > > > > > 
> > > > > > Regards,
> > > > > > Saket Sinha
> > > > 
> > > > ---------------------------------------------------------------------
> > > > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> > > > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> 


