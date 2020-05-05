Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65847C47254
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 16:40:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BBD720746
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 16:40:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IUR0R4HG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BBD720746
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jW0cR-0007MG-BP
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 12:40:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59946)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jW0bW-0006LD-QT; Tue, 05 May 2020 12:39:34 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:44621)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jW0bV-00034z-DO; Tue, 05 May 2020 12:39:34 -0400
Received: by mail-io1-xd43.google.com with SMTP id z2so2605128iol.11;
 Tue, 05 May 2020 09:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=WIRaXa5uWOFOqTJW7emtu3GQdvnFhLb8E2Xsvd+NElk=;
 b=IUR0R4HG4AqMmEagj5njddYP3Wdx8hlZEHWI12mbGHjXO3ryP18h+y5CxKpca7z21Q
 Qi9jONRsmR3M+j5El4o9i47YuygRmIylTCt0PggKUgN3RHXpnu/wM8WGD/J3ZzgVKjH2
 knUgRiduFB068AkBc158Huew9rAWgxZi7qfHyQ+6t38R6H2COZ/7XJHiqEv8piIdVQHq
 JCgxioLh/rWGdS0vGYcaJb75I7FyhNfExWMasoOKa5fRAXYpF23kT9pEjQqFoBdDVRBV
 xhVTBX5X6DWxK7qH01B8Y67mYZGvfUJzUJXJeUWD3I0N3QwFTKJykccBX3SlTrZjN0Uf
 91HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WIRaXa5uWOFOqTJW7emtu3GQdvnFhLb8E2Xsvd+NElk=;
 b=HD/iDAY8Bdy8zWMq21OwAzeL6hUB4THsh7lNB9KePXwIOoiG7BEBx5Cgdp3vkKHXKT
 yPz78Ek6isuvQ854qvmo8o7YGrAFqvB4GexGkbu+I0b2Vhtt18AKABarlsUxW2WVqnui
 xiNuLi3x1MrpCmXFGjPl33vTslJJwoYhNapKPHXnL9WUN4shPVPCEAIcoEY80aKNmIhr
 ILhkOSKdFMCarnMBVLVZS+8UGXKAWKmVCm4PYMtf1DcWsaI+88JF+1EEwmJraIB7HBIp
 RS+r321ojOQ8ZKqX1Ri8CrofWN3T72DFgT42zxPHNI5zeUD+KXJ3ODi91i0GU3xAqZr1
 2fiQ==
X-Gm-Message-State: AGi0PuYa3l+OhQUJz04RFE8N0YPzBoM1d3uYC6+tApDf6Zv8lPJSpj10
 f5cwq7W10cInRET8vS6XZuq+AVlu5KQ3in40poY=
X-Google-Smtp-Source: APiQypJ679JoZdHtd3el0Lvqe5jCQzHdw/OzBsksQwfQPrUJzVMCdf2aYxvWOk+3Kma/Zm2bJdJkPo+D8HyizHGPvJw=
X-Received: by 2002:a02:b60e:: with SMTP id h14mr4362061jam.91.1588696772028; 
 Tue, 05 May 2020 09:39:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200430162439.2659-1-edgar.iglesias@gmail.com>
 <20200430162439.2659-4-edgar.iglesias@gmail.com>
In-Reply-To: <20200430162439.2659-4-edgar.iglesias@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 5 May 2020 09:30:50 -0700
Message-ID: <CAKmqyKMyAT9+z7MscVi870O5ssDGsn5qvZc4QbFgounk60WL6A@mail.gmail.com>
Subject: Re: [PATCH v1 3/9] hw/net/xilinx_axienet: Remove unncessary cast
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d43;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd43.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Edgar Iglesias <edgar.iglesias@xilinx.com>,
 Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>,
 Francisco Iglesias <frasse.iglesias@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Stefano Stabellini <sstabellini@kernel.org>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Luc Michel <luc.michel@greensocs.com>, figlesia@xilinx.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Apr 30, 2020 at 9:28 AM Edgar E. Iglesias
<edgar.iglesias@gmail.com> wrote:
>
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
>
> Remove unncessary cast, buf is already uint8_t *.
> No functional change.
>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/net/xilinx_axienet.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/net/xilinx_axienet.c b/hw/net/xilinx_axienet.c
> index 84073753d7..c8dfcda3ee 100644
> --- a/hw/net/xilinx_axienet.c
> +++ b/hw/net/xilinx_axienet.c
> @@ -918,7 +918,7 @@ xilinx_axienet_data_stream_push(StreamSlave *obj, uint8_t *buf, size_t size)
>          uint16_t csum;
>
>          tmp_csum = net_checksum_add(size - start_off,
> -                                    (uint8_t *)buf + start_off);
> +                                    buf + start_off);
>          /* Accumulate the seed.  */
>          tmp_csum += s->hdr[2] & 0xffff;
>
> --
> 2.20.1
>
>

