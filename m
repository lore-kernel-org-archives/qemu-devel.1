Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D61C4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 17:48:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5407D207F7
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 17:48:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rfQTHgqf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5407D207F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNJk0-0007L4-SS
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 13:48:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52218)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcminyard@gmail.com>)
 id 1kNJiF-0006ig-FJ
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 13:46:51 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:35742)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tcminyard@gmail.com>)
 id 1kNJiD-0007SK-R8
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 13:46:51 -0400
Received: by mail-oi1-x244.google.com with SMTP id w16so6401840oia.2
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 10:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:reply-to:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=bZP3LWX30hqzwtE+yAjH7hbK7GkTw2dhTd2Z4ZhRr6w=;
 b=rfQTHgqfOwUjlGuQI7tySQQaGUjiLNxUfTYzvu/F7w9shsVH7lhjmPMLemlqK2hvnp
 BqQ3HvvRximPFXRD+84n/LwURApH/Nts9uGwI4l/s4WRm4sh7yy+OO3vGhbAxMu9cQdg
 l/AmsDTdXjVvJhFEcNCNEKqrPoffy8Angy2HEI2ycsAxEma5P0xY4EVvLjECSZ/+xBZo
 Yp1otPzo5cFTkExXwT1VDt5ituNGWvnCIOIvdfuSHp+MbdffIKoRcJEIIxLFAhqJAY7P
 wNxuYq4C/XUy3Kxz6NT0U8+DcgD8v7AnjRWazDIFG0SGHMrNlVhAbh08SvHYG1+K7ALn
 /Luw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :reply-to:references:mime-version:content-disposition:in-reply-to
 :user-agent;
 bh=bZP3LWX30hqzwtE+yAjH7hbK7GkTw2dhTd2Z4ZhRr6w=;
 b=krTGt4lmILeqgURjwAd7ncXm+AEzHOaGU1jAMlUOfTbc6/eLlxbath/QbBliWGBzWg
 BAfKjgEuewhOY0KMIyyRC6cMSKUGN1i79yPvtqVf09AKMUcuLdFCXyzJTRGKWY4yeEqR
 if3rApYMCbWdHnIYRDXgiBNT4h7W0c1tNd5j2ONb4ewU6sZOACheODIEtuRK9ZCbO+6y
 XhpLLybkcGIU2GRr1+TkKZWqD6usNt4RAAjqXxGsS8zzktjA8GdwMMHbg7FuTz4ZFC96
 E8hyYsekqb6eh7oFpLxHkA7KhIahejq6RV5FmEFnAA9AdwYuVim7b5cTLxa2V0kfWlJh
 XKSA==
X-Gm-Message-State: AOAM530ww5HBmrBpFlGEwl/4HCcWRh0tVb/TMAcg1eJC0E8b2ECQIb8F
 605GGWLJeq7b1LsMZmglVw==
X-Google-Smtp-Source: ABdhPJy/ev2zt14RzeQQzLC36UdCWprl4ZmPxaDUfAhksKKqzb4phfY3PR6W1pCz+/ImWOEGPgSkRw==
X-Received: by 2002:aca:1a09:: with SMTP id a9mr3182513oia.164.1601401607975; 
 Tue, 29 Sep 2020 10:46:47 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
 by smtp.gmail.com with ESMTPSA id l23sm1145920otk.79.2020.09.29.10.46.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 10:46:46 -0700 (PDT)
Received: from minyard.net (unknown
 [IPv6:2001:470:b8f6:1b:ad7b:1513:3f4c:af82])
 by serve.minyard.net (Postfix) with ESMTPSA id 8420518003B;
 Tue, 29 Sep 2020 17:46:45 +0000 (UTC)
Date: Tue, 29 Sep 2020 12:46:44 -0500
From: Corey Minyard <minyard@acm.org>
To: Havard Skinnemoen <hskinnemoen@google.com>
Subject: Re: [RFC 0/3] QEMU as IPMI BMC emulator
Message-ID: <20200929174644.GW3674@minyard.net>
References: <20200929003916.4183696-1-hskinnemoen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929003916.4183696-1-hskinnemoen@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Received-SPF: pass client-ip=2607:f8b0:4864:20::244;
 envelope-from=tcminyard@gmail.com; helo=mail-oi1-x244.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.199,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: minyard@acm.org
Cc: Avi.Fishman@nuvoton.com, venture@google.com, qemu-devel@nongnu.org,
 wuhaotsh@google.com, kfting@nuvoton.com, clg@kaod.org, joel@jms.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Sep 28, 2020 at 05:39:13PM -0700, Havard Skinnemoen via wrote:
> This series briefly documents the existing IPMI device support for main
> processor emulation, and goes on to propose a similar device structure to
> emulate IPMI responder devices in BMC machines. This would allow a qemu
> instance running BMC firmware to serve as an external BMC for a qemu instance
> running server software.
> 
> RFC only at this point because the series does not include actual code to
> implement this. I'd appreciate some initial feedback on
> 
> 1. Whether anyone else is interested in something like this.

Though I've had this idea once or twice, I'm not working on real BMCs,
so I didn't really pursue anything.  It's a good idea, I think, for the
BMC developers, and possibly for system developers trying to do
integration testing between BMCs and system software.

You will need to tie in to more emulation than just the BMC side of the
system interface registers.  You will also need to tie into GPIOs or
whatnot for things like host reset.

Power handling is going to be a bit weird.  The OpenIPMI emulator
starts/stops qemu based upon power control.  It might be possible to do
the same thing in this sort of emulator.

You may need extensions to the protocol, and that's fine.  I can't think
of any at the moment, but you never know.

> 2. Completeness (i.e. anything that could be explained in more detail in the
>    docs).

It's certainly a good start.  The second patch would be useful right
now.  There are more details, of course, but I think that's covered in
the man page under the various devices.

Thanks,

-corey

> 3. Naming, and whether 'specs' is the right place to put this.
> 4. Whether it's OK to enable the blockdiag sphinx extension (if not, I'll just
>    toss the block diagrams and turn the docs into walls of text).
> 
> If this seems reasonable, I'll start working with one of my team mates on
> implementing the common part, as well as the Nuvoton-specific responder device.
> Possibly also an Aspeed device.
> 
> Havard Skinnemoen (3):
>   docs: enable sphinx blockdiag extension
>   docs/specs: IPMI device emulation: main processor
>   docs/specs: IPMI device emulation: BMC
> 
>  docs/conf.py         |   5 +-
>  docs/specs/index.rst |   1 +
>  docs/specs/ipmi.rst  | 183 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 188 insertions(+), 1 deletion(-)
>  create mode 100644 docs/specs/ipmi.rst
> 
> -- 
> 2.28.0.709.gb0816b6eb0-goog
> 
> 

