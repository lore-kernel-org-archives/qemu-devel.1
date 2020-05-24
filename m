Return-Path: <SRS0=Dt9u=7G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4931CC433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2020 14:11:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E1302067B
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2020 14:11:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=braap-org.20150623.gappssmtp.com header.i=@braap-org.20150623.gappssmtp.com header.b="bWzal6lh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E1302067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=braap.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcrM1-0000YP-6w
	for qemu-devel@archiver.kernel.org; Sun, 24 May 2020 10:11:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42586)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cota@braap.org>) id 1jcrLG-00087O-1R
 for qemu-devel@nongnu.org; Sun, 24 May 2020 10:11:06 -0400
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741]:34945)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cota@braap.org>) id 1jcrLE-00045t-II
 for qemu-devel@nongnu.org; Sun, 24 May 2020 10:11:05 -0400
Received: by mail-qk1-x741.google.com with SMTP id n141so2986605qke.2
 for <qemu-devel@nongnu.org>; Sun, 24 May 2020 07:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=braap-org.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=Ytk7quFo58cMrJur5o+xy7bbN0umGTMN+8yfmvBA3rQ=;
 b=bWzal6lhDIgUegBPw+hI4+61dIyUGCtw3kk3JuShjsLrmjKAwKVpTzkCc+hAA5jrx4
 LSDMup3yXRcYlJ4eK+yojGmtttyaSpSAvCe5ez/nYE4oH14nnyxgBsoNH70CZj3fvznm
 O7W1yrrFNXQtj7Br5G19TRBSsb8ELLKzsT8ygcpFiYIGqZnDPRiFhRCOsgHkO7n42M8O
 4kXX9uFbY3QViiP55hhSFkX59fpUT702NAoQc58WeNOoOdqb99RRv68QIa12Bca6ziXM
 P2ABCj9aKWM42Xv5oUCh/H1SMnnpqSL3ruMbrYntOYlMSMkhx9eaXziFpre81okSu10k
 uNhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=Ytk7quFo58cMrJur5o+xy7bbN0umGTMN+8yfmvBA3rQ=;
 b=BWw6nqCzK+uEaTpVTL4EQKWAR9ngxPI43G2VaniJ7n4CNVqpydIF7Im8aE9K+b42uh
 /7mtYTtJkrlsa/YGfgrXnSsn91CexPJ6wrwLkUmw2VtFXKczOi11WCdtNAdL3EN2SJJi
 SdLu/rLt2A3aVwjrQEQX+3M8GMvIQNLrCDIrdueC/HXXqUonSKIP5vjt4jaSKSF2MM/0
 AvZs9/GzFDk/kRDb7d6TXn8XCSuIf6KKyfCuSan4gbQ0VjCiXyAnT/6D6au2I3rkDvH8
 CpYAhO0PRPY/aPIxj8eMrtNgU4ANxxt30wjOcL6+UeM7L2rBLFgCHNy9/Vaxyehl94vK
 QvtQ==
X-Gm-Message-State: AOAM533B0/nCtjM93aJGIiVuKZaQEophANF6SyyMGOk5kYCKIOECUiig
 OeSE2QVKHSOYGpm1PR87CHMSnb1XFAw=
X-Google-Smtp-Source: ABdhPJyapAYdrtHyS24iP+f34fPkCeRqnic4HCieZ9pId9k0ReKMUI8UzJ3MrYVlmIEKAOZMb38VTQ==
X-Received: by 2002:a05:620a:22c5:: with SMTP id
 o5mr4817005qki.421.1590329462974; 
 Sun, 24 May 2020 07:11:02 -0700 (PDT)
Received: from localhost ([70.19.54.161])
 by smtp.gmail.com with ESMTPSA id p38sm13668537qtp.60.2020.05.24.07.11.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 May 2020 07:11:02 -0700 (PDT)
Date: Sun, 24 May 2020 10:11:01 -0400
From: "Emilio G. Cota" <cota@braap.org>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH 3/3] plugins: avoid failing plugin when CPU is inited
 several times
Message-ID: <20200524141101.GA863143@sff>
References: <CAEme+7FPF+inSJSXQPmuv8Up3Eam0N7fT03zqM-RvcvKsxjfVQ@mail.gmail.com>
 <f4feb648-7dc5-ac54-bc0b-db650dd176f1@vivier.eu>
 <CAEme+7EtF6B2+2U_yF2dd-g2m+=S3P5=DL1oLmHfmWw2S7PYAw@mail.gmail.com>
 <20200509230016.GA109593@sff>
 <CAEme+7H82A2RNk5g09rmhThxW4=6sqWP5o65OCsJ8zf1L-nb+w@mail.gmail.com>
 <20200512005521.GA198983@sff> <87zhacewvx.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87zhacewvx.fsf@linaro.org>
Received-SPF: softfail client-ip=2607:f8b0:4864:20::741;
 envelope-from=cota@braap.org; helo=mail-qk1-x741.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_SOFTFAIL=0.665,
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
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 riku.voipio@iki.fi, Laurent Vivier <laurent@vivier.eu>,
 Nikolay Igotti <igotti@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Alex,

On Tue, May 12, 2020 at 21:11:46 +0100, Alex Bennée wrote:
> 
> Emilio G. Cota <cota@braap.org> writes:
> 
> > On Mon, May 11, 2020 at 18:53:19 +0300, Nikolay Igotti wrote:
> >> Attached to the mail counter.c when running with attached test.c compiled
> >> to Linux standalone binary shows failing assert, unless the patch is
> >> applied.
> >
> > I didn't get the attachment. Can you paste the code at the end of your
> > reply?
> 
> So the problem is we are recycling cpu_index:
> 
>   21:01:54 [alex@zen:~/l/q/b/all.plugin] plugins/next|●2✚3…(+8 insertions(+)) 127 + ./x86_64-linux-user/qemu-x86_64 ./tests/tcg/x86_64-linux-user/threadcount
>   cpu_list_add: 0x5605598579f0
>   cpu_get_free_index: 0
>   cpu_list_add: 0x5605598c6010
>   cpu_get_free_index: 1
>   cpu_list_add: 0x5605598ec330
>   cpu_get_free_index: 2
>   cpu_list_add: 0x560559912a30
>   cpu_get_free_index: 3
>   cpu_list_add: 0x560559939130
>   cpu_get_free_index: 4
>   cpu_list_add: 0x56055995d360
>   cpu_get_free_index: 1
>   **
>   ERROR:/home/alex/lsrc/qemu.git/plugins/core.c:205:qemu_plugin_vcpu_init_hook: assertion failed: (success)
>   qemu:handle_cpu_signal received signal outside vCPU context @ pc=0x7fa29c702613
> 
> However I'm confused as to how. The cpu_index is really just a function
> of the number of CPUs in the cpus list and I can't see where we free
> them up. We never call cpu_common_unrealizefn so the list should never
> shrink. We should just end up with a slowly growing list of now dead CPU
> states.
> 
> I'm giving up for now but will have a look again in the morning if no
> one else has figured out what is going on by then.

I just got this fixed, only to realise that you already fixed it weeks ago :-)
(I didn't see your fixes because I'm not subscribed to the list.)

My changes are here https://github.com/cota/qemu/tree/cpu_index
Please feel free to take anything from there that you find valuable, e.g.
the use of a bitmap for tracking cpu_index'es and the addition of a unit test
(note that the test is fixed in the last commit).

Thanks,

		Emilio

