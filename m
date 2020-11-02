Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2747BC00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 17:56:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1237221D91
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 17:56:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KdvXIw1b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1237221D91
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZe4U-0001Tj-5J
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 12:56:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35070)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZe3d-0000wR-EN
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 12:55:53 -0500
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c]:39098)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZe3b-0003jy-KK
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 12:55:52 -0500
Received: by mail-ej1-x62c.google.com with SMTP id s25so6165672ejy.6
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 09:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mrqtb4U7+BeErVk3fbKEXg4Tr6WGfztb2QohSFWGHJI=;
 b=KdvXIw1bTgiAkbn0stEzW8Hpah4APlQ7GpNHUzYDyW+0Lc5lcr48LZt6Hc0ZEVY6Ck
 WU5l9NY7AE3TjorpmA5fSidlkdOVhCXB/KpX3Jb8XzdHa5J3bhshBrF0/Qox3kfHZY5j
 JmbW3gydhjbnoP4m0JYtMX+R2BBK2FEmvZI5gONVT3E013xEKk+bIfDF4j0QO1lHFwhV
 KpbtMeVF5xPBDqpbcAto5YyBZaJQzGqnrEwAGVpco1gVXS/HfHefi8OdDgUDWGg8JgmL
 RMaN2pLTgup7Bl0tXhnCM6SNqT0dD/D69vrU++Ufaq8hMjUqhq+lT2/XFN0HENyFSb4E
 /Q3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mrqtb4U7+BeErVk3fbKEXg4Tr6WGfztb2QohSFWGHJI=;
 b=W2vR/3iRZ7gBq6mZaZklc48WQBMLA6wXlLsixBPyzm/M4WOYdD7Gi4as/8/+0BUltf
 HXhfPtrUEzxLbuWkwHLzim+nygaTSTcPssY356mejwvq+06l6yl+KOG8fncdg+urY6NY
 EK/IdnatTImpKyjixkamfic1NtDt2+z8cq47fU9baXiTqt3E56UbPo//rZCs7Lv+D+vI
 RPqsbZo8QwsUwac6AduLRmD5VjdcWb3U6xoR815zH5cVT3uPF0LO+6rPMAvfwDU+38Tl
 j8Ht8EAPR4ps0b/9W5VEFCbp1g7YIVctjMXudsjaqQ3qh21FPD9p6WltDGGr4OMEbg9G
 KqFg==
X-Gm-Message-State: AOAM530O0K/DWAcE/fXaLagwN50K7CxtLha6p+G6AZSjgApbLYDJAMZC
 tdgmWKOjSQx6CqaVTCQ1iSXm4bn+47QG73Z7Y5qGnA==
X-Google-Smtp-Source: ABdhPJw5yKBaMKbRVh1ZG6UJOkBt7QPGv232BwjGmRooTE23H6LJurqddNgMB/YvoZEAZ6YX4jOmdRWr/acace/xTwM=
X-Received: by 2002:a17:907:9e3:: with SMTP id
 ce3mr16656043ejc.4.1604339749887; 
 Mon, 02 Nov 2020 09:55:49 -0800 (PST)
MIME-Version: 1.0
References: <20201023152147.1016281-1-stefanha@redhat.com>
 <20201023152147.1016281-7-stefanha@redhat.com>
In-Reply-To: <20201023152147.1016281-7-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Nov 2020 17:55:38 +0000
Message-ID: <CAFEAcA9uLPuLr9vn8--b=MBo_wCztKbF_Oi2v0st7Qu1aFQtAw@mail.gmail.com>
Subject: Re: [PULL v3 06/28] block/export: vhost-user block device backend
 server
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62c.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 23 Oct 2020 at 16:22, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> From: Coiby Xu <coiby.xu@gmail.com>
>
> By making use of libvhost-user, block device drive can be shared to
> the connected vhost-user client. Only one client can connect to the
> server one time.
>
> Since vhost-user-server needs a block drive to be created first, delay
> the creation of this object.

Hi; Coverity points out a possible bug in this function
(CID 1435956):

> +static int coroutine_fn
> +vu_block_discard_write_zeroes(VuBlockReq *req, struct iovec *iov,
> +                              uint32_t iovcnt, uint32_t type)
> +{
> +    struct virtio_blk_discard_write_zeroes desc;
> +    ssize_t size = iov_to_buf(iov, iovcnt, 0, &desc, sizeof(desc));
> +    if (unlikely(size != sizeof(desc))) {
> +        error_report("Invalid size %zd, expect %zu", size, sizeof(desc));
> +        return -EINVAL;
> +    }
> +
> +    VuBlockDev *vdev_blk = get_vu_block_device_by_server(req->server);
> +    uint64_t range[2] = { le64_to_cpu(desc.sector) << 9,
> +                          le32_to_cpu(desc.num_sectors) << 9 };

Here we get a 32-bit integer from desc.num_sectors, and then the
shift left might make it overflow the 32-bit value before it gets
put into a uint64_t in the range array. Should this be

   (uint64_t)le32_to_cpu(desc.num_sectors) << 9

?

thanks
-- PMM

