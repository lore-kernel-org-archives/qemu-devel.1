Return-Path: <SRS0=2u83=X7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D08BDC4360C
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Oct 2019 22:03:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 923202080F
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Oct 2019 22:03:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="CQH24xo/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 923202080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=digitalocean.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHEca-00018X-Nb
	for qemu-devel@archiver.kernel.org; Sun, 06 Oct 2019 18:03:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43744)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <msmarduch@digitalocean.com>) id 1iHEb4-0000Sg-NR
 for qemu-devel@nongnu.org; Sun, 06 Oct 2019 18:01:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <msmarduch@digitalocean.com>) id 1iHEb1-00080b-EK
 for qemu-devel@nongnu.org; Sun, 06 Oct 2019 18:01:45 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:33405)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <msmarduch@digitalocean.com>)
 id 1iHEb0-0007zd-85
 for qemu-devel@nongnu.org; Sun, 06 Oct 2019 18:01:43 -0400
Received: by mail-ot1-x343.google.com with SMTP id 60so9445676otu.0
 for <qemu-devel@nongnu.org>; Sun, 06 Oct 2019 15:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=digitalocean.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=9DFR8yC2x/5u/5qAWy8C41+BwugyFIuapuCKaLIFcSY=;
 b=CQH24xo/dEdJvX6QxaIQ1ZXB482Q//hKKufBtwTAC81oFBmQfx54Ym1xpeMrMSVEOc
 ZWP2OE4RGc7CLZ++NsXGRC2oReDrnapBbQEJzLC2MGYoRxy2JDu+bdKkUb8oGJTjudxA
 MSOhLzhmVEtszK3RfsMdIW9Wbj37oElTZcW5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9DFR8yC2x/5u/5qAWy8C41+BwugyFIuapuCKaLIFcSY=;
 b=lM3RAowiAeg70KJT8na/NCSq6dctg50BtOQ5uUk8hT5qRe32rd3K0O/fc4f3/QNWGH
 bFkomYRi7lGubCblxwbcAPPhMYOdXDz/bakxXGPYpBX1EJ19hXCSIgsGxgYhvKeHaFE1
 cVzv87JowJAs1Hy2xnjCDi5Jf/3zyqtPOODTb1JXqtTP1MEQTiMeF+jyTlrPLzBQjXDs
 uUOxtl2gkuw1vFI/pWjkh7FidhXicCdxm3QE813kTv8gbBUH+QHfsdiPas0xNBPxx/R1
 suIqK1Zm+mICUCdLAs9j3s5w8TOkqQ9eBCtIZ73UITY89OXH6Py737ILOreNUmmdoqtC
 IRbQ==
X-Gm-Message-State: APjAAAXmvqUoYQdfZfZ6pGWwPyudTQDb2BRBIe9Kfyz9+GCN5Q0aP49U
 /k648a4bBqGtAUw/Hg4FJuB1QQ==
X-Google-Smtp-Source: APXvYqw19IkA27esOslvO0Wla1T1BepeOZ0b6ca9J6ipzCRIyCsCmB8hL7bG3dXPxoIEtcpXTmNWSw==
X-Received: by 2002:a05:6830:1292:: with SMTP id
 z18mr19510887otp.7.1570399299419; 
 Sun, 06 Oct 2019 15:01:39 -0700 (PDT)
Received: from ?IPv6:2600:1700:4a30:84c0:a5c5:faec:38bb:f557?
 ([2600:1700:4a30:84c0:a5c5:faec:38bb:f557])
 by smtp.gmail.com with ESMTPSA id a88sm4065197otb.0.2019.10.06.15.01.37
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 06 Oct 2019 15:01:38 -0700 (PDT)
Subject: Re: [PATCH] target/i386: log guest name and memory error type AO, AR
 for MCEs
To: Paolo Bonzini <pbonzini@redhat.com>, mtosatti@redhat.com, armbru@redhat.com
Cc: qemu-devel@nongnu.org, rth@twiddle.net, ehabkost@redhat.com,
 qemu-trivial@nongnu.org
References: <ceb4d639-842a-30bd-5d54-bfacb07b5cc4@digitalocean.com>
 <c78d014f-20f4-d25f-e50a-92c960200d7e@redhat.com>
From: Mario Smarduch <msmarduch@digitalocean.com>
Message-ID: <5032a0a0-afff-a7e6-1adc-996dbe4cf086@digitalocean.com>
Date: Sun, 6 Oct 2019 15:01:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <c78d014f-20f4-d25f-e50a-92c960200d7e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 10/06/2019 09:11 AM, Paolo Bonzini wrote:
> On 05/10/19 01:53, Mario Smarduch wrote:
>> Guest [Droplet-12345678] 2019-08-02T05:00:11.940270Z qemu-system-x86_64:
>> Guest MCE Memory Error at qemu addr 0x7f3c7622f000 and guest 78e42f000
>> addr of type BUS_MCEERR_AR injected
>>
>> with enterprise logging environment we can to take further actions.
>>
>> Signed-off-by: Mario Smarduch <msmarduch@digitalocean.com>
> 
> The guest name part should be a separate patch, controlled by "-msg
> name=on" or something like that.  The MCE parts look good okay.  Can you
> split the patch in two?
> 
> Paolo
> 
Yes will do.

thanks.

