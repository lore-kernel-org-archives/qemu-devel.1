Return-Path: <SRS0=Jz4r=ZX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 666F5C432C0
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2019 16:40:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3188620718
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2019 16:40:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ewfZ9rhF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3188620718
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibSHH-0002Wu-5U
	for qemu-devel@archiver.kernel.org; Sun, 01 Dec 2019 11:40:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42227)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dsahern@gmail.com>) id 1ibSGM-00021q-Ni
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 11:39:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dsahern@gmail.com>) id 1ibSGL-0004nB-M2
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 11:39:58 -0500
Received: from mail-io1-xd36.google.com ([2607:f8b0:4864:20::d36]:36826)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dsahern@gmail.com>) id 1ibSGL-0004mT-HD
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 11:39:57 -0500
Received: by mail-io1-xd36.google.com with SMTP id l17so11333389ioj.3
 for <qemu-devel@nongnu.org>; Sun, 01 Dec 2019 08:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=nrzdauqQjl+Gtu4h2eEhHK1/fwKIUPO8zlYq2SyP7VU=;
 b=ewfZ9rhFb16403kL4WxpLnimNbUG0wY3issAExVqK4oYlk5emArVaen+d8V4glbP4D
 j79zQFiQqDjdtH+m3HqXclV7wgEVsDJ3WmXz+B6Ui9wr3wHE4WCO5boTDLCQSV7luMmg
 PfHyUFtngtYsV3R7I/y2yjx7OZaqwCNQjI+yRaBvHxqJJ0BIvDT5CD+6Xn1Jq+RLBpCp
 J7rPkdgMo66/vwFp0uyU60wwut9eI8vpH/oJ5jGcRQtx8IpsjQ/q6fr1hv+OEVi41eU4
 PHtDcdrowVPLVCdOpyRvMaUJqNgSZKcSTZG1RQ4J8hskjKAgZO3T8LO4Rmnk0vd4DfCI
 cUGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nrzdauqQjl+Gtu4h2eEhHK1/fwKIUPO8zlYq2SyP7VU=;
 b=fIsrqCLwogUDAvZTCGKpganM2mj1NnlTLRi464CCVsg7dr3ZcQnQz1fvkJ5SfGs4at
 OsU2gEIp4rcfD1qNUpBibYvSmyhegUDkyukjqYVl3F12VQXLMWoHqmvZPHbY0BFx5aXd
 2mRpXCINIqws9TK5HUvG/tuJYHq9oz/cIA4kMA51NBusuyUmyw50UxargiilJGbM6bGf
 xIO8JQYGCE+/QDO4f3dKIvKF5zqoGtJU7ieNvT8eDvRrcyETW/JeZcPlN+ubnQWybPiT
 K2tRzAxkzdrZOUhahCgs/9dbcUbFD2INqh4lg1xz7qJUOCGKln/zOumV3BdQsikPyjIA
 zk/w==
X-Gm-Message-State: APjAAAUqVdRod52W217cMooCmbtAo7oVGbszVLZyAW+REw/E23pTUuNL
 V/eVLxAdNXwHB+va8R/eqJk=
X-Google-Smtp-Source: APXvYqzkylSQoi2vRq1vJFxYRl9Rz/plJFEp27CXda6upU9mu10SEPZ9DxmxSQWBQOOEjpdZIFouWA==
X-Received: by 2002:a02:ac0a:: with SMTP id a10mr25083180jao.53.1575218396476; 
 Sun, 01 Dec 2019 08:39:56 -0800 (PST)
Received: from dahern-DO-MB.local ([2601:282:800:fd80:fd6b:fde:b20f:61ed])
 by smtp.googlemail.com with ESMTPSA id 3sm2406097iow.71.2019.12.01.08.39.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Dec 2019 08:39:55 -0800 (PST)
Subject: Re: [RFC net-next 08/18] tun: run offloaded XDP program in Tx path
To: Prashant Bhole <prashantbhole.linux@gmail.com>,
 "David S . Miller" <davem@davemloft.net>,
 "Michael S . Tsirkin" <mst@redhat.com>
References: <20191126100744.5083-1-prashantbhole.linux@gmail.com>
 <20191126100744.5083-9-prashantbhole.linux@gmail.com>
From: David Ahern <dsahern@gmail.com>
Message-ID: <f39536e4-1492-04e6-1293-302cc75e81bf@gmail.com>
Date: Sun, 1 Dec 2019 09:39:54 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191126100744.5083-9-prashantbhole.linux@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d36
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
Cc: Song Liu <songliubraving@fb.com>,
 Jakub Kicinski <jakub.kicinski@netronome.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 Jason Wang <jasowang@redhat.com>, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Yonghong Song <yhs@fb.com>,
 Andrii Nakryiko <andriin@fb.com>, Martin KaFai Lau <kafai@fb.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/26/19 4:07 AM, Prashant Bhole wrote:
> run offloaded XDP program as soon as packet is removed from the ptr
> ring. Since this is XDP in Tx path, the traditional handling of
> XDP actions XDP_TX/REDIRECT isn't valid. For this reason we call
> do_xdp_generic_core instead of do_xdp_generic. do_xdp_generic_core
> just runs the program and leaves the action handling to us.

What happens if an offloaded program returns XDP_REDIRECT?

Below you just drop the packet which is going to be a bad user
experience. A better user experience is to detect XDP return codes a
program uses, catch those that are not supported for this use case and
fail the install of the program.

