Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF62FC4742C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 14:13:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 076FE206DB
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 14:13:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cqvvjl/1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 076FE206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kag0z-00044G-GT
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 09:13:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38230)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kafzr-0002bc-D9
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 09:12:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21617)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kafzp-0006Ws-6T
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 09:12:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604585530;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ORRFFbPdbJuqt4LxCfjo7FFn+HxycvO5n/hvzjrg/bQ=;
 b=cqvvjl/1xrhHovh1rL7BY7u+25DAyeqFjJd7/f6EjMH3FaVpBVBiqjJYwgFlfpcDX0l+a5
 0uJbHqYRMNtwGaxJrigzTx9f+aw3Bl9EqiZ+p6SoBL64dKXoBsKdNdqbv8MonLx0PecVHm
 Ga914Ve66Q/Svif1oQ9/lP7X38pkz8I=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-498-C7CpCdadP_y8Pcik4-JXPw-1; Thu, 05 Nov 2020 09:12:09 -0500
X-MC-Unique: C7CpCdadP_y8Pcik4-JXPw-1
Received: by mail-wm1-f70.google.com with SMTP id 3so661857wms.9
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 06:12:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ORRFFbPdbJuqt4LxCfjo7FFn+HxycvO5n/hvzjrg/bQ=;
 b=X/a54Jjp1xmWIftduZun1y7oyj817wthMI3qOquhO0YtB3r3hW5ykC+tIG68aPGnoO
 4jTtZNHVwQvFnHuRkG6ZoLMuLWEM7wSoIr5p62H2jO+n9uOr3wd3Jn66QRKYFhpxDSaB
 YVrmaA8LqBmwXc4ofpnNaWv2FXaEfN018/7rbXQ3b1OBzf+tW09wamiTxyUdPo3huK5q
 TCawKvSybsN1AEBmPuAyZqezSP5L9wQ2d587YEiXd5oAXZPNfd2MPoeW/0alStSRtiDX
 PA2MjHQA/sGY8EsqZlEwJqljGlz2Ov4Iclt1pMs8CLscgoEHrubhVEOXGJM/K08yFDlc
 Rl/g==
X-Gm-Message-State: AOAM531d94g4hWv3o76GXX1TP+lOsERhX4Rn/qT1RMvu2q9qPjdk0773
 IAv4jPqlkxUisAuLes5T6Z/bGBYYI96lql0Xgwav77DkU6k+6Wj/GaJ/X9xOYrkx5wlig4IDFVR
 hegZ7jkG6oaVft/E=
X-Received: by 2002:a1c:490b:: with SMTP id w11mr2922462wma.101.1604585528070; 
 Thu, 05 Nov 2020 06:12:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzZCK4LFDRETqWa9jXl/oc5Wm5+krib7+wk0SsfiEHmENdgDyegEHleBuwH+/dh0JWCu4zNOw==
X-Received: by 2002:a1c:490b:: with SMTP id w11mr2922427wma.101.1604585527847; 
 Thu, 05 Nov 2020 06:12:07 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id v123sm2884546wme.7.2020.11.05.06.12.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Nov 2020 06:12:06 -0800 (PST)
Subject: Re: [PATCH-for-6.0 0/3] hw/virtio: Allow to disable legacy VIRTIO
To: qemu-devel@nongnu.org
References: <20201105124353.3680057-1-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <02cf2092-0f9a-baf2-590f-d3275f1dcc98@redhat.com>
Date: Thu, 5 Nov 2020 15:12:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201105124353.3680057-1-philmd@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/04 22:46:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>, Fam Zheng <fam@euphon.net>,
 Thomas Huth <thuth@redhat.com>, Jagannathan Raman <jag.raman@oracle.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/5/20 1:43 PM, Philippe Mathieu-Daudé wrote:
> Stefan told me it would help the multi-process QEMU
> series if virtio devices where not arch-specific.
> As it didn't seem too complex, I gave it a try.
> 
> Philippe Mathieu-Daudé (3):
>   hw/virtio: Add configure switch to disable legacy VIRTIO
>   hw/virtio: Build most of virtio devices as arch-independent objects
>   gitlab-ci: Test the --disable-virtio-legacy option

Please disregard this series, as it requires more work.


