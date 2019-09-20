Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D505C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 17:38:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52175207FC
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 17:38:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oWu2iaAA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52175207FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBMrt-0004pZ-FQ
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 13:38:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38403)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tcminyard@gmail.com>) id 1iBMq2-0003AU-7w
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 13:36:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tcminyard@gmail.com>) id 1iBMq1-00078S-0T
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 13:36:58 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:32930)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1iBMq0-000781-Rn
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 13:36:56 -0400
Received: by mail-ot1-x341.google.com with SMTP id g25so6907844otl.0
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 10:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:reply-to:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=kVSGwlADvn7uHaPpKz/TZ2c6P00DfPajzzp7HoeRYJY=;
 b=oWu2iaAARDt8vawQpXHTIv2QhPcoXhWymArZpsQRpHbQC+rNlU38zghUBvwZCphg5r
 /Lh+ul0P+7a8e9z3vT/7sa/+UUdOvJEvnV1XxIjqGy62apE5Br8gTDF4Tm6ELwB++m5k
 QvYW1zjRH2eHHzW9Ncj5IMepHbOk4RX350cSGcuLMUZUc6aAXNYOtcw3TQrOQhRZOlPq
 wD0YbQM6DNMh2vHQx+z6WgoGIMwXolrcy3cZrjTPkLdQ2oU5QIxc+HWUiOgR1tETngic
 WUgZ8MZJunYHCddLy7phpRM9j3ndDqdg/mMt/B1WaZcPnHokZiTE/3bECnFHM2iNPIvV
 Syrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :reply-to:references:mime-version:content-disposition:in-reply-to
 :user-agent;
 bh=kVSGwlADvn7uHaPpKz/TZ2c6P00DfPajzzp7HoeRYJY=;
 b=Jcko/MSEcsAjVKZd+hrfXd/Q1Nm0uhUMqNWp23NK3A+ahQT5eUxXEzyHxT4AIbbjd8
 26mUYZx7mURBxEp2mOK4MNVeqAZoh+m0xZkswG2S75PtLIbMgBeytHUhDqx43ePtSP87
 wUnDk7fUczRJNS7d/wR+tqU3f5dSq46sbvU89AGvAgEDG0t6o81L3b09wq7bOtREj+ad
 PaOIgFp/vE12hItzPBA3j83UC6DWB9HEv9lDgA4uUAzVkIxfJW+L2aKeE8ax2HU8O9/o
 SeQbOwGUTikrdQCioA82LAE94YrYAIrI6BJcr3NJhi033KV5Eor+8OxjEzsCSoBKmCj5
 xaiQ==
X-Gm-Message-State: APjAAAX8aub37FobEsL8YUvS0GcIUY6rd1VkGV++WNY9dVU8i74d5MNv
 eYUWQDThaa6l/oJ/omyZ1w==
X-Google-Smtp-Source: APXvYqyRl1/wFaiFDfTaNjLvnciiCwq0fatcfAlnGvhgqefOV34uPkxroukHTo3xgiIcLftxb/ZHoA==
X-Received: by 2002:a9d:51cb:: with SMTP id d11mr7663589oth.112.1569001015684; 
 Fri, 20 Sep 2019 10:36:55 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
 by smtp.gmail.com with ESMTPSA id x16sm681196oie.7.2019.09.20.10.36.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2019 10:36:55 -0700 (PDT)
Received: from t560 (unknown [192.168.27.180])
 by serve.minyard.net (Postfix) with ESMTPSA id 6037B1800CE;
 Fri, 20 Sep 2019 17:36:54 +0000 (UTC)
Date: Fri, 20 Sep 2019 12:36:53 -0500
From: Corey Minyard <minyard@acm.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 00/15] ipmi: Bug fixes, add new interfaces
Message-ID: <20190920173653.GE31565@t560>
References: <20190919213924.31852-1-minyard@acm.org>
 <CAFEAcA-wEcsRDSjs-QD2kWspTx=mHmcY9etO7KgPVcyRh_XxUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA-wEcsRDSjs-QD2kWspTx=mHmcY9etO7KgPVcyRh_XxUw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Reply-To: minyard@acm.org
Cc: Fam Zheng <famz@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 20, 2019 at 01:57:48PM +0100, Peter Maydell wrote:
> On Thu, 19 Sep 2019 at 22:39, <minyard@acm.org> wrote:
> >
> > I haven't gotten a lot of commentary on this, but I assume that means
> > that everything is ok.  It's been posted a few times and the last time
> > I received no issues, just a couple of reviews.  I would like more
> > review.  But I'm not quite sure what to do about that, I've been
> > hanging on to these changes far too long.
> >
> > The following changes since commit a77d20bafcd4cb7684168a9b4c6dc2a321aaeb50:
> >
> >   Merge remote-tracking branch 'remotes/kraxel/tags/ui-20190919-pull-request' into staging (2019-09-19 17:16:07 +0100)
> >
> > are available in the Git repository at:
> >
> >   https://github.com/cminyard/qemu.git tags/ipmi-for-release-2019-09-19
> >
> > for you to fetch changes up to d9b74295c6528fd68cebdea116b283e46543b2a2:
> >
> >   pc: Add an SMB0 ACPI device to q35 (2019-09-19 14:41:58 -0500)
> >
> > ----------------------------------------------------------------
> > ipmi: Some bug fixes and new interfaces
> >
> > Some bug fixes for the watchdog and hopeful the BT tests.
> >
> > Change the IPMI UUID handling to give the user the ability to set it or
> > not have it.
> >
> > Add a PCI interface.
> >
> > Add an SMBus interfaces.
> 
> Hi -- is this intended to be a pull request to be applied to
> master? It's in the form of a pullreq but the subject header
> says "PATCH" and you seem to be asking for more review, so I'm
> not sure...

Dang, it was meant to be a pull request for master.  I would like
more review, and I didn't think I would get any, but it turns out
I have gotten it for the most important parts, so pulling it
should be good, I think.

I can add the reviews and request a pull properly, if you like.

Thanks,

-corey

> 
> thanks
> -- PMM

