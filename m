Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D76AC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 15:52:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24A082072F
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 15:52:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lJ7zlLMN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24A082072F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jigYA-0004Em-E2
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 11:52:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40080)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcminyard@gmail.com>)
 id 1jigWe-0002hd-MV
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 11:50:56 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:37125)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tcminyard@gmail.com>)
 id 1jigWd-00012h-BC
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 11:50:56 -0400
Received: by mail-oi1-x242.google.com with SMTP id a3so7199632oid.4
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 08:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:reply-to:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=RajArREu1UnINA6Y1HfdHrvLyhVKE9EFkFF48FlUQgI=;
 b=lJ7zlLMNzzaV3C0ekIoQJm8MfLtCeVYz62sVJSWMVWYJaK09W4a6m4Ubu2AwNfzFJz
 lhc0YtoABdRhA3kjY7OD4K/8OxoRKEaJu19HWdPFq06k1TLnaX6xw6bKtxuGF6YgFkpn
 sq0xNvaxwBkOzohQ5ca6A8IECXWovCYgRSKCM7jFuI7B8oYKgkbWyMlDmm2h2Tp5lDEf
 5O1FvhmaOTgnAb8rVZdFRpyqBP3DmOu5aVuXSBicTAFpbSG8qkrEz9CKlOdwLGsV8TaB
 Pet2wBvug54EjMkb2J0pk2o2EeFOvWOveVimeq1mwd3aRpqgmg9DURyVfbhv28F9x790
 whNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :reply-to:references:mime-version:content-disposition
 :content-transfer-encoding:in-reply-to:user-agent;
 bh=RajArREu1UnINA6Y1HfdHrvLyhVKE9EFkFF48FlUQgI=;
 b=cjxeJuy+N30Hyq08BW+WZ6EFgcLKU9FWlmm2hA4eSuyekJXJC5n0GiD05NObxvbV34
 nbm0RDv8yfYUpn0MvTlt442HVhJwqyLzmupj/XjNCw/nrUkbDwRtvMSpuz4FeP7pvdh2
 l98o1JIw3jiUWmsWsswS/4dB+MV8bQ1+kvHXpvh4w4/2/Ix//qrzxB/OLPhCHbpzisHJ
 2SqHq2SnWeNvnHEtNAFcsMwH325d5meOPx36c/0oGZPWzM09F0C6kujolDfmJXPOPTsY
 wzy23rfO7gaxfc2mp56v1n/UBi7ZwRSOtgFpvvLfxPIS+60yu26wnDW/XXC/VJGlNeHb
 joUw==
X-Gm-Message-State: AOAM533Oc3JlcVMrobZHs0Y3xKC5KHqTq16Tj4TWcon/vDBDN60IkfIr
 0IpXvbTY06QwyJl67QkgXnhVlTE=
X-Google-Smtp-Source: ABdhPJz3NjhgVznmH7A1GANWWpCOI8nr9g+yjpgmlYeeXpfuuaHXR9d4WotvxfGxTj6M/Z6zYHjIEw==
X-Received: by 2002:aca:3a08:: with SMTP id h8mr3956284oia.53.1591717852894;
 Tue, 09 Jun 2020 08:50:52 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
 by smtp.gmail.com with ESMTPSA id g4sm1975853otp.5.2020.06.09.08.50.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 08:50:52 -0700 (PDT)
Received: from minyard.net (unknown
 [IPv6:2001:470:b8f6:1b:fc6b:eb5f:1e23:4ea5])
 by serve.minyard.net (Postfix) with ESMTPSA id 32DCD180050;
 Tue,  9 Jun 2020 15:50:51 +0000 (UTC)
Date: Tue, 9 Jun 2020 10:50:50 -0500
From: Corey Minyard <minyard@acm.org>
To: Laszlo Ersek <lersek@redhat.com>
Subject: Re: [PATCH v7 2/5] softmmu/vl: Let -fw_cfg option take a 'gen_id'
 argument
Message-ID: <20200609155050.GT2880@minyard.net>
References: <20200528173141.17495-1-philmd@redhat.com>
 <20200528173141.17495-3-philmd@redhat.com>
 <f3f6154e-bbc1-98bd-0f44-77b28c74915f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f3f6154e-bbc1-98bd-0f44-77b28c74915f@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Received-SPF: pass client-ip=2607:f8b0:4864:20::242;
 envelope-from=tcminyard@gmail.com; helo=mail-oi1-x242.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 29, 2020 at 11:50:24AM +0200, Laszlo Ersek wrote:
> Gerd, Corey: there's a question for you near the end, please.
> 
> On 05/28/20 19:31, Philippe Mathieu-Daudé wrote:

snip...

> 
> 
> (3) I've noticed another *potential* issue, from looking at the larger
> context. I apologize for missing it in v6.
> 
> See commit bab47d9a75a3 ("Sort the fw_cfg file list", 2016-04-07). (I'm
> copying Corey; Gerd is already copied.) From that commit, we have, at
> the end of this function:
> 
>     /* For legacy, keep user files in a specific global order. */
>     fw_cfg_set_order_override(fw_cfg, FW_CFG_ORDER_OVERRIDE_USER);
>     fw_cfg_add_file(fw_cfg, name, buf, size);
>     fw_cfg_reset_order_override(fw_cfg);
> 
> This takes effect for "file" and "string", but not for "gen_id". Should
> we apply it to "gen_id" as well? (Sorry, I really don't understand what
> commit bab47d9a75a3 is about!)

I can explain the rationale for that change, but I'm not sure of the
answer to your question.  That changes makes sure that the fw_cfg data
remains exactly the same even on newer versions of qemu if the machine
is set the same.  This way you can do migrations to newer qemu versions
and anything using fw_cfg won't get confused because the data changes.

The reason that change was so complex was preserving the order for
migrating from older versions.

This is only about migration.  I'm not sure what gen_id is, but if it's
migrated, it better be future proof.

-corey

> 
> *IF* we want to apply the same logic to "gen_id", then we should
> *perhaps* do, on the "nonempty_str(gen_id)" branch:
> 
>         size_t fw_cfg_size;
> 
>         fw_cfg_set_order_override(fw_cfg, FW_CFG_ORDER_OVERRIDE_USER);
>         fw_cfg_size = fw_cfg_add_from_generator(fw_cfg, name, gen_id, errp);
>         fw_cfg_reset_order_override(fw_cfg);
>         return (fw_cfg_size > 0) ? 0 : -1;
> 
> I think???
> 
> Or maybe even use FW_CFG_ORDER_OVERRIDE_DEVICE rather than
> FW_CFG_ORDER_OVERRIDE_USER? I don't have the slightest clue.
> 
> (I guess if I understood what commit bab47d9a75a3 was about, I'd be less
> in doubt now. But that commit only hints at "avoid[ing] any future
> issues of moving the file creation" -- I don't know what those issues
> were in the first place!)
> 
> With (1) optionally fixed, and (2) fixed, I'd be willing to R-b this
> patch; but I'm really thrown off by (3).
> 
> Thanks,
> Laszlo
> 
> 
> >      } else {
> >          GError *err = NULL;
> >          if (!g_file_get_contents(file, &buf, &size, &err)) {
> >
> 

