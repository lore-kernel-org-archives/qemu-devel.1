Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A50EC4742C
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 17:34:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90C65208A9
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 17:34:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f5W9esqf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90C65208A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZdig-0004pQ-Qs
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 12:34:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58202)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZdgE-0002rD-64
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 12:31:42 -0500
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631]:34925)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZdgB-0000hB-LB
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 12:31:41 -0500
Received: by mail-ej1-x631.google.com with SMTP id p5so20026398ejj.2
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 09:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=lrY8+fWQOho0yxiRfGKwjlRikfKieG6I4rjyCd+DF9U=;
 b=f5W9esqfsLI82ZXpwXoLTIrYeeB48TJefrQ/mun00b2LAdjeK4MFKOPe8HlkHKlCvh
 VrCZaNXF6y2b88mofb3SSHavj4qHXW+o6Maw6pkoIsQ5HJhw+Obu4Xw6UDxO9Unjm5kB
 +GeYrE74Et41UwHS63NJrPbXIipIA6KuxZVCg9thd+x/YZp8sLXevSl8F5/kc5sU+J+0
 m8fMMg6KZOdwDe6v0D4EbjyiRJIr6Sr/uDV+Iy0H3sje+RXUuOa5Ik/lvMJd8MbgIEIs
 +mOTBqQebgYCNf1oFjNznS2ZawFUQuUDhaOG5UdSrMh3acYhQjFMSE6Z5VrcftSyeGlm
 5f5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=lrY8+fWQOho0yxiRfGKwjlRikfKieG6I4rjyCd+DF9U=;
 b=gIjJ+SGCwiA2++PV9aSTPxx7Fd+o0k4eQeBddkyldZIMiLia7Ey5ubQi9lvHxKkHen
 qsyPnnreaGcYsbVrUOTw5bM7DKLP454HQ/45GefPsxG2TqPZWHTHN+JfLhXLDtqyJ5Qw
 +xnBRMbYtxA6bbXLHNzfL7XM1BFgNOwZ0fPz1J7xXzz6OZRuUiN4JaGExRCYyVra3leL
 0DaXj9wPztU9rK28TAu7nSwWZ5qPPAbDb5wJm72LBVS1MncXUe64iEh9JgonSnp7HUcy
 ElON28VMdNoDJX74jyQTCrCpv/xIfnY6wvGzjUndt+p3YgWcf6nkbIkoZg3O0ibJt4lk
 Bt2Q==
X-Gm-Message-State: AOAM532SCsDonh11fyRipz70egcQe1voBKlVtW935yAYqyFQ6S8UYVUj
 eg6BtJR0tElpAzJCZgc0pxf4zDPzGMVFkmPcGJw5Kg==
X-Google-Smtp-Source: ABdhPJypMh6aN3SICBhYBIyFTaf8ynSo51TiKvcsPcpQNxvcuQIBIPjHN+sbC9mWU8hgbadiv3FN+VAc1V9DkJoyjXg=
X-Received: by 2002:a17:907:9e3:: with SMTP id
 ce3mr16565584ejc.4.1604338297697; 
 Mon, 02 Nov 2020 09:31:37 -0800 (PST)
MIME-Version: 1.0
References: <20201028154004.776760-1-philmd@redhat.com>
In-Reply-To: <20201028154004.776760-1-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Nov 2020 17:31:26 +0000
Message-ID: <CAFEAcA_URCc2LjdrR8GbK-uu+isTVPH39qSce4yWqNV39RkbWg@mail.gmail.com>
Subject: Re: [PATCH-for-5.2] hw/virtio/vhost-vdpa: Fix Coverity CID 1432864
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x631.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Jason Wang <jasowang@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Cindy Lu <lulu@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 28 Oct 2020 at 15:45, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> Fix uninitialized value issues reported by Coverity:
>
>   Field 'msg.reserved' is uninitialized when calling write().
>
> Fixes: a5bd05800f8 ("vhost-vdpa: batch updating IOTLB mappings")
> Reported-by: Coverity (CID 1432864: UNINIT)
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Hi Philippe; thanks for this patch. I don't suppose you
could also write a patch that fixes the same problem in
vhost_kernel_send_device_iotlb_msg() (CID 1432871) ?

thanks
-- PMM

