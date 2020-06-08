Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0190DC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 20:11:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD180206D5
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 20:11:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OZF5zNFA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD180206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiO6w-0000lL-Vf
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 16:11:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38812)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jiO5h-0008Op-7p
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 16:09:53 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:35197)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jiO5g-0007vV-9D
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 16:09:52 -0400
Received: by mail-lj1-x244.google.com with SMTP id j18so9074291lji.2
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 13:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=5FczujPNe9Kld7ZmxtYKr2Nk+YOHmp5w3GbfwtPSEuQ=;
 b=OZF5zNFATyoThEorA1olXzftDXXXYDCxhfh4h2Do2JchYE2rrN+sUb92COpej7AInV
 t2AXVKEKi47sA4kguD6Bs5eRelxFcAJnEv9Vw180+lmRcXodC5gvl9ZZqyk+N+DugvBZ
 KpHb6tHbr244nVxhEoCC9Q9wzL4nrRbGQdRNPl27/2dxnfYzFaPoBihVVj2Js33UK65G
 Cq2kscFeuYDiBySvM+0dOb4cqK7/kTf9kljp8ZIDqMDTOrnagjol9M+NxPoXDcPEhug0
 BD9QwE98wyds2gyTm4pbAuXt/3AirpMsKEcM2ZeFJqgYxv7gro+6hYDro59SeZqQCC8O
 gGRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=5FczujPNe9Kld7ZmxtYKr2Nk+YOHmp5w3GbfwtPSEuQ=;
 b=FE7QsU/yA+tmql72U0grsyswirQRyu7eB/L5fIaalEIj5yIEBWdLD6nqul9+RBam2V
 SR6dm7JirgSdXv/h+HqaBxewyEtF0Oyw7bc58V/UTEE7xcHd6a5eS7LpHHsYeXD+lNtm
 F8h3GzLHL682JdYiM4LxskThBerRxPqqqvYHlYGyIlEPvo6wODgkq03EHxzJ4SWxhltA
 kKJX12+ytHhBaPG0M02UuHctqdxM6rthWB8ZQyWhJNbAnQ5Ph9D4jYlknfZsX1TmHrar
 c6jv+Qmmxa4kZVBecf0nAb4zNjywoAoD+RnAIrxo8ZrUHsmaArC/3s5gWzYzBL3+8dJK
 ILsA==
X-Gm-Message-State: AOAM530OwppU71/qEkXjDK/jAv+y4Re8GeaBUtUxb4KvkFm6WMs0A3Ig
 ppuT4zxOatVQLZ/YH+S3Oml6E5KXVvx8g6mMKkUMJg==
X-Google-Smtp-Source: ABdhPJwwY+SoAXGBlWPpDnk//9yGUyM9BzXyO3LdK2fz+zLbjuolueKVcyQoVpgBI4ZUxFAHWvndzz3jvCn9DY+QG8M=
X-Received: by 2002:a2e:974e:: with SMTP id f14mr11534881ljj.102.1591646989483; 
 Mon, 08 Jun 2020 13:09:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200605173422.1490-1-robert.foley@linaro.org>
 <20200605173422.1490-2-robert.foley@linaro.org> <877dwh7k2v.fsf@linaro.org>
In-Reply-To: <877dwh7k2v.fsf@linaro.org>
From: Robert Foley <robert.foley@linaro.org>
Date: Mon, 8 Jun 2020 16:09:50 -0400
Message-ID: <CAEyhzFsekDugG6XGqTqOzsGhbV9tR_O668DHZRx2i1fGrUn8Kg@mail.gmail.com>
Subject: Re: [PATCH v2 01/13] configure: add --enable-tsan flag + fiber
 annotations for coroutine-ucontext
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::244;
 envelope-from=robert.foley@linaro.org; helo=mail-lj1-x244.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 "Emilio G. Cota" <cota@braap.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Lingfeng Yang <lfy@google.com>, Peter Puhov <peter.puhov@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 8 Jun 2020 at 09:39, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
<snip>
> > -static void finish_switch_fiber(void *fake_stack_save)
> > +/* QEMU_ALWAYS_INLINE only does so if __OPTIMIZE__, so we cannot use i=
t. */
> > +static inline __attribute__((always_inline))
> > +void on_new_fiber(CoroutineUContext *co)
> > +{
>
> We could put a tracepoint here at something like trace_new_fibre() but I
> suspect for following what's going on you could probably just have
> tracepoints in the higher coroutine functions and leave the fibre stuff
> as purely a CONFIG_TSAN detail.
>
> Please we wouldn't have to ague about American vs British spelling for
> the tracepoints ;-)
>
> <snip>
>
> Otherwise without the UC_TRACE verbiage:
>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Thanks for the review.  Sounds good, we will remove the fibre related
traces. :-)

Thanks & Regards,
-Rob
>
> --
> Alex Benn=C3=A9e

