Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9AA4C00A89
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 11:23:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D252E20759
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 11:23:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XIDHhaRL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D252E20759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kadMD-0002PL-8p
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 06:23:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60658)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcascell@redhat.com>)
 id 1kadL9-0001wT-GD
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 06:22:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48223)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mcascell@redhat.com>)
 id 1kadL5-0005mF-5g
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 06:22:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604575317;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HrJVlRtPU+pC/qVDxaylreQOEfay9Ut9zIUjz/Melj0=;
 b=XIDHhaRLwTnAqYSDgiDLLEQI1P0LGYNu1/VsxiZUjUaFDCggsn4j0F6dl/D8R9MFXSy31u
 bPQrkRhySsYM5XMnkLaA+hIO5hIhVt+GjPBvWsYg9kZRyYkK1lVUxCnZtYrJM2aB7dtorY
 W7c32/zxmW9A+FDAFLar11p6W8cizEA=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-509-yMaI29JuNlGeItZZ6a0hzA-1; Thu, 05 Nov 2020 06:21:55 -0500
X-MC-Unique: yMaI29JuNlGeItZZ6a0hzA-1
Received: by mail-ej1-f69.google.com with SMTP id e9so453456ejb.16
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 03:21:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HrJVlRtPU+pC/qVDxaylreQOEfay9Ut9zIUjz/Melj0=;
 b=YSMv8XdorQ88OtMJdpKK3q7xySbo9beqDR5VDBtoskjXYirFqpnpvnH22AAp/RxT+o
 0YUPi36uit5ywQbNjbbkY46NoiAfaijcaC9ORyEXLGi7eT/x/iIoVaAtTLi6v1zh9wpv
 uRwc78LyuKU9AD8mWSc1zsXb2kBuYPUjEiYJ7OtQyUgjazQ7MjVjtHpF5MbUYq2E99kV
 gsWIs0ZVUMVZH9KQXmILc61IwePCWMFAKg2qn1oSqewWugbrJ57g/vTCiyZnGJ6nTpqr
 GHV4uwc4A1iN5xB6UGYXnLCqleXSCSvhn33FFFIH5hObS/sqctsDbsDGOPRDMHr5G4m1
 DWkA==
X-Gm-Message-State: AOAM531dOJs4NDli12qCkRnlutlaSCoPvzI933aT4KuajkPI1K/ZaYLX
 ZZ0QgH1TkNS8gjx8kLv3GgKEM8UQue903liqylW1QCJ8ENd3VLFnl4jGi5mjw6jw6VHXgwk3fbS
 SctLaiZO36Om59bbt+2nj2Ua56mx+nQQ=
X-Received: by 2002:a17:906:a385:: with SMTP id
 k5mr1759988ejz.492.1604575314127; 
 Thu, 05 Nov 2020 03:21:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwdVb6GKe5Z0OpRrqHjbZofwNLGUk5LZglroFrs4rQ/1t5G0AE85ndN38RSTgMsBXhGPzjo/8/ehJzRNZZQ6MY=
X-Received: by 2002:a17:906:a385:: with SMTP id
 k5mr1759971ejz.492.1604575313926; 
 Thu, 05 Nov 2020 03:21:53 -0800 (PST)
MIME-Version: 1.0
References: <20201105105616.327593-1-mcascell@redhat.com>
In-Reply-To: <20201105105616.327593-1-mcascell@redhat.com>
From: Mauro Matteo Cascella <mcascell@redhat.com>
Date: Thu, 5 Nov 2020 12:21:43 +0100
Message-ID: <CAA8xKjV_6uApTe7nhrS5N8pUPj3CXVWPm_txA_5DVdf2fFwO-w@mail.gmail.com>
Subject: Re: [PATCH] net/e1000e_core: make sure RDH never exceeds RDT in
 e1000e_ring_advance()
To: QEMU Developers <qemu-devel@nongnu.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mcascell@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mcascell@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/05 01:14:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: gaoning.pgn@antgroup.com, Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, lersek@redhat.com,
 330cjfdn@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Nov 5, 2020 at 11:56 AM Mauro Matteo Cascella
<mcascell@redhat.com> wrote:
>
> The e1000e_write_packet_to_guest() function iterates over a set of
> receive descriptors by advancing rx descriptor head register (RDH) from
> its initial value to rx descriptor tail register (RDT). The check in
> e1000e_ring_empty() is responsible for detecting whether RDH has reached
> RDT, terminating the loop if that's the case. Additional checks have
> been added in the past to deal with bogus values submitted by the guest
> to prevent possible infinite loop. This is done by "wrapping around" RDH
> at some point and detecting whether it assumes the original value during
> the loop.
>
> However, when e1000e is configured to use the packet split feature, RDH is
> incremented by two instead of one, as the packet split descriptors are
> 32 bytes while regular descriptors are 16 bytes. A malicious or buggy
> guest may set RDT to an odd value and transmit only null RX descriptors.
> This corner case would prevent RDH from ever matching RDT, leading to an
> infinite loop. This patch adds a check in e1000e_ring_advance() to make
> sure RDH does never exceed RDT.
>
> This issue was independently reported by Gaoning Pan (Zhejiang University)
> and Cheolwoo Myung.
>
> Signed-off-by: Mauro Matteo Cascella <mcascell@redhat.com>
> Reported-by: Gaoning Pan <gaoning.pgn@antgroup.com>
> Reported-by: Cheolwoo Myung <330cjfdn@gmail.com>
> ---
> References:
> https://git.qemu.org/?p=qemu.git;a=commit;h=dd793a74882477ca38d49e191110c17dfe
> https://git.qemu.org/?p=qemu.git;a=commit;h=4154c7e03fa55b4cf52509a83d50d6c09d743b7
> http://www.intel.com/content/dam/doc/datasheet/82574l-gbe-controller-datasheet.pdf
>
>  hw/net/e1000e_core.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
> index bcd186cac5..4c4d14b6ed 100644
> --- a/hw/net/e1000e_core.c
> +++ b/hw/net/e1000e_core.c
> @@ -831,6 +831,10 @@ e1000e_ring_advance(E1000ECore *core, const E1000E_RingInfo *r, uint32_t count)
>  {
>      core->mac[r->dh] += count;
>
> +    if (core->mac[r->dh] > core->mac[r->dt]) {
> +        core->mac[r->dh] = core->mac[r->dt];
> +    }
> +
>      if (core->mac[r->dh] * E1000_RING_DESC_LEN >= core->mac[r->dlen]) {
>          core->mac[r->dh] = 0;
>      }
> --
> 2.26.2
>

Here is a simple PoC to reproduce the aforementioned issue via qtest:

cat << EOF | ./qemu-system-x86_64 -device e1000e -trace e1000e\*
-display none -qtest stdio -accel qtest
outl 0xcf8 0x80002010
outl 0xcfc 0xe0000000
outl 0xcf8 0x80002004
outw 0xcfc 0x7
write 0xe0003800 0x4 0x10001000
write 0xe0003808 0x4 0x00080000
write 0xe0000400 0x4 0xfa000400
write 0xe0002808 0x4 0x00080000
write 0xe0002818 0x4 0x7f000000       <== set RDT to 127
write 0xe0005008 0x4 0xfbffa3fa
write 0xe0000100 0x4 0x5a840000
write 0x100018 0x2 0x6705
write 0x10001b 0x1 0x01
write 0xe0003818 0x4 0x04000000
EOF

--
Mauro Matteo Cascella
Red Hat Product Security
PGP-Key ID: BB3410B0


