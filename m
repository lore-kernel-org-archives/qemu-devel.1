Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3255CC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 13:13:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFDB9208E4
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 13:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SCnffhK+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFDB9208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrLVk-0006Ks-8x
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 09:13:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43216)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrLUi-00056b-F1
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 09:12:44 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:42632)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrLUf-0007TX-3U
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 09:12:44 -0400
Received: by mail-ot1-x344.google.com with SMTP id g37so2909130otb.9
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 06:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=XKrdn12lhrltbi09jkg6wHhyxKxeQa1qK5VOw6LxYlg=;
 b=SCnffhK+rC5HhwzPXEsbdqoaBjY4hNr01ZgDb/bYKhxhnwPRQfFJPjtVM9FuVK3Bm+
 neiRtdVov6boeOCjdGHB0QRvW+N4XbplGclIHRGGDe4s/8FYYQcjr0EqTtUBAjXKwEVZ
 WrftSt0SCLeyuIckB3zRUn9aYeqVFHI1Y/KISfiD3qRa9BJ8OUhVHwnoGfojyk6h7ohq
 Ec+bponpsCBcA2ijPSjL3p24x2/ZDT76tOSC1E6UlGDelqKCkFCvxllCbP5tWR/b5RdW
 63sB33K/MUU+t9PbmJQn0VD8X9BuvOepcvFIDSUTfyWY06lbj0TB/NnvIz+fU31lk3X6
 DcYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=XKrdn12lhrltbi09jkg6wHhyxKxeQa1qK5VOw6LxYlg=;
 b=bXnA1OaK+wPJISA++tlgZ79kRw+DkmFUI0jNeHSSLsnsPBIr1A56OfkTgye4sn3ZXd
 kSs6F8fzJP4P9+CB3fQwctfej0KxCHmzetdK9dGWKd74TeFSAblsBIzeG2r/HMHLupYJ
 uw7nZWmU5l6M3zcsp2SSQrMc3z3pPKjJ/oZqF0d25mmjpO/iYXgB1TN3GiQKFRgY3S2J
 SDehaw5hgyl2zEP6vet45BuHmodrddnrMomi3PWAJ1IkjOwEksPf7x49usobbAQ2Bp+h
 w+qAAFyvXseg1U2g0PkfdvqwMs48MROjM0tbUftE4WSrdLiiK1Cn5M6/REOqPrW50VYc
 TZZQ==
X-Gm-Message-State: AOAM530LLRkof8jyxFqW5YfhYy4kwFzPmO6y3Mq/q/l9YShaP+IUqnGr
 XfrmRjJEiYvi5A3+uCnVDaSjDJBDElil8vVelA0o4g==
X-Google-Smtp-Source: ABdhPJyeXXepq2khSSz78Kb74Rn6uRu8qdjd17Y8JeLiYwftZfFx3QHycPCF2+PiUMEaKYytMYU1Be8xjHM/uMEj+3A=
X-Received: by 2002:a05:6830:10ce:: with SMTP id
 z14mr23134520oto.135.1593781959921; 
 Fri, 03 Jul 2020 06:12:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200630133912.9428-1-f4bug@amsat.org>
 <20200630133912.9428-6-f4bug@amsat.org>
In-Reply-To: <20200630133912.9428-6-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Jul 2020 14:12:28 +0100
Message-ID: <CAFEAcA_DwcQrN7+=brMvxz0z0WEXi7cw2wzXmmdLyYK6-F70Wg@mail.gmail.com>
Subject: Re: [PATCH v7 05/17] hw/sd/sdcard: Do not switch to ReceivingData if
 address is invalid
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Alexander Bulekov <alxndr@bu.edu>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>,
 Prasad J Pandit <pjp@fedoraproject.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 30 Jun 2020 at 14:39, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> Only move the state machine to ReceivingData if there is no
> pending error. This avoids later OOB access while processing
> commands queued.
>
>   "SD Specifications Part 1 Physical Layer Simplified Spec. v3.01"
>
>   4.3.3 Data Read
>
>   Read command is rejected if BLOCK_LEN_ERROR or ADDRESS_ERROR
>   occurred and no data transfer is performed.
>
>   4.3.4 Data Write
>
>   Write command is rejected if BLOCK_LEN_ERROR or ADDRESS_ERROR
>   occurred and no data transfer is performed.
>
> WP_VIOLATION errors are not modified: the error bit is set, we
> stay in receive-data state, wait for a stop command. All further
> data transfer is ignored. See the check on sd->card_status at the
> beginning of sd_read_data() and sd_write_data().
>
> Fixes: CVE-2020-13253
> Cc: Prasad J Pandit <pjp@fedoraproject.org>
> Reported-by: Alexander Bulekov <alxndr@bu.edu>
> Buglink: https://bugs.launchpad.net/qemu/+bug/1880822
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> v4: Only modify ADDRESS_ERROR, not WP_VIOLATION (pm215)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

