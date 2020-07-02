Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB10C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 19:11:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1736720737
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 19:11:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aEwGvz7l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1736720737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr4cT-0003sF-DS
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 15:11:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44444)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1jr4bu-0003Sb-4h
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 15:11:02 -0400
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:41153)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1jr4bs-0002Qn-Fa
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 15:11:01 -0400
Received: by mail-lf1-x143.google.com with SMTP id c11so16865404lfh.8
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2020 12:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ICZwy9qJVtdnbHrVeUy3Jc9JfgJVlWIpaa4ZaBShfmA=;
 b=aEwGvz7lxPNQPt3FrIgnz+bNPkEf4MWAUXRV/FNMsPxkBcRqiMcVwKFlm2Oo3AwLx7
 MCb1b3mmtp3/kjZTf2Ozx3Ez9pl3aJaGYon3p0VXeUf8o0Al/+Dxici3jmKKUTN1UGiL
 PZINFCwDw+6+yrAiA2a2jcBr1Fkj/tketrYTdwHze8U11l0B4tNiquuwm8t12CjNMsxc
 uwvgpcVRPB00ZEskMsfcMZshVab2N51MmUPCN8lNDg6sgIf7YvJJ8wEdb7pN9jVmsvNk
 flge/jnrdN8ERxcxfMzBgYgXQcmhOPteFvH+Yt0fnKgtMdQr9sRAoKKkc8QlD3kBgk6i
 3QEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ICZwy9qJVtdnbHrVeUy3Jc9JfgJVlWIpaa4ZaBShfmA=;
 b=lczIkttxVYvHkTr8POtaglN/YDGqKFn9kZl0YHJkEpfkGlzfI0PCDOwvX8BFgHV3am
 k29ZNZximbOtZWCoIaAZrfI5x62ZQxCuddeiltoHMiOoQYjwwLZGyIu9R5do44S6mLl8
 uHGr6P9U9fbr/DOJFaUAWU7KCLwuD6sJR3z30rOrDV1+3+L4iqBo01jcO+lvqtX5RIDO
 tFSQ45DGUJbSrROVh7Yzpq6LCQxLbADXVKvLNNZP9w4GLtORDwzEM3v8mbTWwgmCrP80
 ZCtlWqbrMm2TMR0+zTJTN+bsh5PPHKG98dtLUfyJ9aavv98zvioy/+SGwN+6fsfpWJET
 K0Hw==
X-Gm-Message-State: AOAM533qpubE2NtdWDs7oB8wVZzjjvFZZAe/aakIcmEVBGQflBDsyPA4
 W+C+UNULM8iMJlYXKudmFfRP7kmdwVWFDCSzWJo=
X-Google-Smtp-Source: ABdhPJydrHCYa4ZMd2x195ETeQMrFKDRw9rlmVsHUlSUcLGLo0P0C2TpI4wlhua7lh3vWRS4LLLIjvtbXi2eNepYqIo=
X-Received: by 2002:a05:6512:54d:: with SMTP id
 h13mr19312367lfl.8.1593717058019; 
 Thu, 02 Jul 2020 12:10:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200702142942.4887-1-ahmedkhaledkaraman@gmail.com>
 <20200702142942.4887-2-ahmedkhaledkaraman@gmail.com>
 <CAHiYmc65CbVoQrMTmK9hxjaC4ESBMQjSP8EO=HaqCKCMv9=ZKA@mail.gmail.com>
In-Reply-To: <CAHiYmc65CbVoQrMTmK9hxjaC4ESBMQjSP8EO=HaqCKCMv9=ZKA@mail.gmail.com>
From: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
Date: Thu, 2 Jul 2020 21:10:22 +0200
Message-ID: <CALTWKrVVTGcaXPpaken519jGgUX9z00PNtvRedqVOUc9msL8-w@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] scripts/performance: Add dissect.py script
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::143;
 envelope-from=ahmedkhaledkaraman@gmail.com; helo=mail-lf1-x143.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Cc: "ldoktor@redhat.com" <ldoktor@redhat.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "crosa@redhat.com" <crosa@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 2, 2020 at 5:45 PM Aleksandar Markovic
<aleksandar.qemu.devel@gmail.com> wrote:
>
>
> A very good script! Hopefully there will be some script in near future that will, for example, list all hepers used in the test program.
>
> Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
>
>
Thanks Mr. Aleksandar. I Will start working on it.

Best regards,
Ahmed Karaman

