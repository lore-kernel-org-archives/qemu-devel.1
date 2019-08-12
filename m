Return-Path: <SRS0=mi2X=WI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED02EC433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 08:21:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3EE6206C2
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 08:21:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VoW01PO8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3EE6206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hx5a9-0006Gb-Vq
	for qemu-devel@archiver.kernel.org; Mon, 12 Aug 2019 04:21:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56667)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dmitry.fleytman@gmail.com>) id 1hx5Zm-0005qr-Kx
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 04:21:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dmitry.fleytman@gmail.com>) id 1hx5Zl-00071i-LX
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 04:21:10 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:38371)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dmitry.fleytman@gmail.com>)
 id 1hx5Zl-0006zt-FQ
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 04:21:09 -0400
Received: by mail-wm1-x342.google.com with SMTP id m125so6904657wmm.3
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2019 01:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
 :references; bh=3GcH5ohuaoO3NLbAVA0s2EptUaeA8I4VSv+FHZx05wE=;
 b=VoW01PO8PRthawPHPJcfetUGcL484ktsKLyuKV0qAx1JpWFIYMUcGCr5IIAmX9yyH3
 7dmrKjCZ9PFIfI+vfynbO90T5/cEjSdgUZ+0JQ5RyfcOBQpnewKFoSLT5dYlDheHvWPu
 RvD45yc/Sa27frBmmt+sXWxEG+c9E3IRYjvHCgm/h9qJKi95SfcE955rzObReECoX46b
 4C2AUfs7B/kNMMAmZY5Pb4+U1NUp1maSzckI1qi9KT3bSPzkMiMjgaokSPv6eKv4x5Mg
 pMlUxk1LuxDqL0nl9kdMS5pESOJBOIpqs68Bp+rQQ/jMWq5c2h6HKwiLaujS87l3xKkC
 mltA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:message-id:mime-version:subject:date
 :in-reply-to:cc:to:references;
 bh=3GcH5ohuaoO3NLbAVA0s2EptUaeA8I4VSv+FHZx05wE=;
 b=Ep8eiN2MGq5cnhloK7Bn8iBfpKkFOFOGK40BRXXHqmfPW1I4UJk4SryxO4tYT3Jzm1
 +KNK9jgyhn0p0iDy/Rs1t0q0maUaNNrD+NIkEMil51tycrvo9f21n8pJYm2oIcU2sVp2
 YDv9YU5upwW0/eyY5NHGBa5ADTkJvOKNYjS8aWZfG5q8njPbfmkDTHwzHDfeJIW8+HuM
 8X3ofpvqsYPCPwyl5xbpQdNyBsxQJL+CzCKCUR+BkVF3qnYZLyCG/M9g9DlE3EBQzEZk
 GAimKyQJts5sP9wJCk2XGPnw8aC5gVCGDnmXX0Im2cin66TugAuhd+WPgT17q+9h70le
 N1FQ==
X-Gm-Message-State: APjAAAVEqJRUMfXcRKmYwFbwnPuGueC4GKLPNNW5fNAzEVr0ZxCxB6Em
 g9gvYC2/Iv3AnVyQjBbQ97M=
X-Google-Smtp-Source: APXvYqyBzfliw5IRmJ/Xg+cF8HXPn2bVm58wX+H36r83rg77mtsNNyvhsSKGMe1HmsIt3zUpleDuzA==
X-Received: by 2002:a7b:c1c1:: with SMTP id a1mr27449072wmj.31.1565598067838; 
 Mon, 12 Aug 2019 01:21:07 -0700 (PDT)
Received: from [10.0.1.19] ([141.226.29.227])
 by smtp.gmail.com with ESMTPSA id a142sm10972233wme.2.2019.08.12.01.21.06
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 12 Aug 2019 01:21:07 -0700 (PDT)
From: Dmitry Fleytman <dmitry.fleytman@gmail.com>
Message-Id: <EFCF7A78-EB8F-4492-89D2-6B36FB30B3A7@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Date: Mon, 12 Aug 2019 11:21:04 +0300
In-Reply-To: <20190808143457.14111-1-philmd@redhat.com>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@redhat.com>
References: <20190808143457.14111-1-philmd@redhat.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH 0/6] net/eth: Remove duplicated tcp/udp_hdr
 structures
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
Cc: Zhang Chen <chen.zhang@intel.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org, Li Zhijian <lizhijian@cn.fujitsu.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Dmitry Fleytman <dmitry.fleytman@gmail.com>

> On 8 Aug 2019, at 17:34, Philippe Mathieu-Daud=C3=A9 =
<philmd@redhat.com> wrote:
>=20
> This is a preparatory cleanup series.
>=20
> Commit 75020a70215 introduced 4 very equivalent structures:
> - tcp_header and tcp_hdr,
> - udp_header and udp_hdr.
>=20
> Choose the most widely use in the codebase, which happens to
> provide convenient bitfields manipulation macros and is not
> endian-specific.
>=20
> Philippe Mathieu-Daud=C3=A9 (6):
>  hw/net/virtio-net: Use TCP_HEADER_FLAGS/TCP_HEADER_DATA_OFFSET macros
>  net/colo-compare: Use the tcp_header structure
>  net/filter-rewriter: Use the tcp_header structure
>  hw/net/vmxnet3: Use the tcp_header structure
>  net/eth: Remove the unused tcp_hdr structure
>  net/eth: Remove the single use of udp_hdr structure
>=20
> hw/net/net_rx_pkt.c   |  2 +-
> hw/net/net_tx_pkt.c   |  9 +++++----
> hw/net/virtio-net.c   |  9 ++-------
> include/net/eth.h     | 47 ++++++++-----------------------------------
> net/colo-compare.c    | 14 ++++++-------
> net/filter-rewriter.c | 37 +++++++++++++++++++---------------
> 6 files changed, 44 insertions(+), 74 deletions(-)
>=20
> --=20
> 2.20.1
>=20

