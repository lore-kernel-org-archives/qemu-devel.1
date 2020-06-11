Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77774C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 17:55:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43616206A4
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 17:55:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YbL/Zkhu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43616206A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjRQD-00073z-DS
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 13:55:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52026)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcminyard@gmail.com>)
 id 1jjRPM-0006L0-Qp
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 13:54:32 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:38591)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tcminyard@gmail.com>)
 id 1jjRPK-00019Y-S2
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 13:54:32 -0400
Received: by mail-ot1-x341.google.com with SMTP id n70so5230257ota.5
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2020 10:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:reply-to:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=AlTrP1T/nxu/5ooSpXgTYjpR3tnbJE/gG+kaCaId/IE=;
 b=YbL/ZkhuVtLVPo2i3l0a0fBG85HXCOKDTIlGOsz+Kh19glOmxZIvZClnS37Iv+zuMz
 TdKDm9722Vgg/5or4tBKRcrIaGkiLg4p4h9iH9TVyZEtJbPKVoliaRzRXdocqMcEH0g0
 87PSLXRPLDjEY1k1S60fXB1kyI3nHn51HvsAGzX0Hvtz85HcPTXR1NrZ5mA15SYq+J7x
 22oWfNdy5Di43oY4Er70OI9rWOrD3dco3Q+ePUeUdmO3oDrlm+5n4VBakthH27y0m4EW
 CBDRyrDehrFUdltRUePWmN/t/hBPITFzzoMq4VOa60heYTnH/LASIJfD99ncgYB1vbTT
 sPYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :reply-to:references:mime-version:content-disposition
 :content-transfer-encoding:in-reply-to:user-agent;
 bh=AlTrP1T/nxu/5ooSpXgTYjpR3tnbJE/gG+kaCaId/IE=;
 b=MvS3Wgkio5FtvJNWEoNPbO92/XDryTtu4kYbJrqlqSr1ZfcACBlWcA6+9hOGWtQnfi
 hkYXhE7+bnkc5eJ4batC7Er3BfemwWyw67XBlotT1gsSM3OzsUI0GeLc+xavExUJCfdQ
 uOgNfnLNulYR4MBeYqw/o3nkakCrKAE4OAd1pPkRWkUM/OpbJqpP36yeNQwtg0qM4r5X
 SCSVEOAL53fpxBDXquy7sPxi3g5PEyu2HGzhFJvGF2flGEb45wVC+jZCj6SZ8RylCtmq
 Zq6lBG5LLqmJ055NY5Tkd7XnZvFhSxsCxCS9Ce2ChOoB4ld7nb7bEg7bem4COSxtuvBp
 kNDw==
X-Gm-Message-State: AOAM532ddSOISKYCaOg1eqaZkPHnwE863u6Y4ah19o+gRxWopJB/9u/3
 UDekSZ6aeVjYjGBn1QXtQ3wZngs=
X-Google-Smtp-Source: ABdhPJwvyQOsPsvwORI1PgCboIMISyUTX079cmpJaLVhbuO3ABcsw67fnMvsbKYGesncnNrbi4dF6A==
X-Received: by 2002:a9d:7cc2:: with SMTP id r2mr7824385otn.25.1591898062959;
 Thu, 11 Jun 2020 10:54:22 -0700 (PDT)
Received: from serve.minyard.net ([47.184.146.204])
 by smtp.gmail.com with ESMTPSA id s69sm806370otb.4.2020.06.11.10.54.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2020 10:54:21 -0700 (PDT)
Received: from minyard.net (unknown
 [IPv6:2001:470:b8f6:1b:c5ac:32fc:806b:ddff])
 by serve.minyard.net (Postfix) with ESMTPSA id 042A1180050;
 Thu, 11 Jun 2020 17:54:21 +0000 (UTC)
Date: Thu, 11 Jun 2020 12:54:19 -0500
From: Corey Minyard <minyard@acm.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v7 2/5] softmmu/vl: Let -fw_cfg option take a 'gen_id'
 argument
Message-ID: <20200611175419.GB7037@minyard.net>
References: <20200528173141.17495-1-philmd@redhat.com>
 <20200528173141.17495-3-philmd@redhat.com>
 <f3f6154e-bbc1-98bd-0f44-77b28c74915f@redhat.com>
 <20200609155050.GT2880@minyard.net>
 <6e4b9540-7d5b-0951-2870-bada03e29d83@redhat.com>
 <8b7e8fab-9b2a-e953-b0eb-3c96d77832f6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8b7e8fab-9b2a-e953-b0eb-3c96d77832f6@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=tcminyard@gmail.com; helo=mail-ot1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 11, 2020 at 01:49:31PM +0200, Philippe Mathieu-Daudé wrote:
> On 6/11/20 1:31 PM, Laszlo Ersek wrote:
> > On 06/09/20 17:50, Corey Minyard wrote:
> >> On Fri, May 29, 2020 at 11:50:24AM +0200, Laszlo Ersek wrote:
> >>> Gerd, Corey: there's a question for you near the end, please.
> >>>
> >>> On 05/28/20 19:31, Philippe Mathieu-Daudé wrote:
> >>
> >> snip...
> >>
> >>>
> >>>
> >>> (3) I've noticed another *potential* issue, from looking at the larger
> >>> context. I apologize for missing it in v6.
> >>>
> >>> See commit bab47d9a75a3 ("Sort the fw_cfg file list", 2016-04-07). (I'm
> >>> copying Corey; Gerd is already copied.) From that commit, we have, at
> >>> the end of this function:
> >>>
> >>>     /* For legacy, keep user files in a specific global order. */
> >>>     fw_cfg_set_order_override(fw_cfg, FW_CFG_ORDER_OVERRIDE_USER);
> >>>     fw_cfg_add_file(fw_cfg, name, buf, size);
> >>>     fw_cfg_reset_order_override(fw_cfg);
> >>>
> >>> This takes effect for "file" and "string", but not for "gen_id". Should
> >>> we apply it to "gen_id" as well? (Sorry, I really don't understand what
> >>> commit bab47d9a75a3 is about!)
> >>
> >> I can explain the rationale for that change, but I'm not sure of the
> >> answer to your question.  That changes makes sure that the fw_cfg data
> >> remains exactly the same even on newer versions of qemu if the machine
> >> is set the same.  This way you can do migrations to newer qemu versions
> >> and anything using fw_cfg won't get confused because the data changes.
> >>
> >> The reason that change was so complex was preserving the order for
> >> migrating from older versions.
> >>
> >> This is only about migration.  I'm not sure what gen_id is, but if it's
> >> migrated, it better be future proof.
> > 
> > Whenever introducing a new fw_cfg file (*any* new named file), how do we
> > decide whether we need fw_cfg_set_order_override()?
> 
> Good idea to ask, so we can document the answer in the fw_cfg API doc.

fw_cfg_set_order_override() is only needed in cases where you are loading
data for devices (VGA, NICs, and other devices) and when loading a
user-specified file.  So basically, anything that is not a named entry
in fw_config_order[].  If it has a name in fw_config_order[], then you
shouldn't use an override.  Otherwise you should.

I'm not aware of anything that wouldn't fall into the existing cases,
so I don't see a reason to add a new call.  Assuming that device
initialization order and such all stays the same, order should be
preserved, and I don't know of another category you would add.  Am I
missing something?

-corey

> 
> > 
> > Thanks
> > Laszlo
> > 
> > 
> >>
> >> -corey
> >>
> >>>
> >>> *IF* we want to apply the same logic to "gen_id", then we should
> >>> *perhaps* do, on the "nonempty_str(gen_id)" branch:
> >>>
> >>>         size_t fw_cfg_size;
> >>>
> >>>         fw_cfg_set_order_override(fw_cfg, FW_CFG_ORDER_OVERRIDE_USER);
> >>>         fw_cfg_size = fw_cfg_add_from_generator(fw_cfg, name, gen_id, errp);
> >>>         fw_cfg_reset_order_override(fw_cfg);
> >>>         return (fw_cfg_size > 0) ? 0 : -1;
> >>>
> >>> I think???
> >>>
> >>> Or maybe even use FW_CFG_ORDER_OVERRIDE_DEVICE rather than
> >>> FW_CFG_ORDER_OVERRIDE_USER? I don't have the slightest clue.
> >>>
> >>> (I guess if I understood what commit bab47d9a75a3 was about, I'd be less
> >>> in doubt now. But that commit only hints at "avoid[ing] any future
> >>> issues of moving the file creation" -- I don't know what those issues
> >>> were in the first place!)
> >>>
> >>> With (1) optionally fixed, and (2) fixed, I'd be willing to R-b this
> >>> patch; but I'm really thrown off by (3).
> >>>
> >>> Thanks,
> >>> Laszlo
> >>>
> >>>
> >>>>      } else {
> >>>>          GError *err = NULL;
> >>>>          if (!g_file_get_contents(file, &buf, &size, &err)) {
> >>>>
> >>>
> >>
> > 
> 

