Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CE7DC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 13:51:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0906822256
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 13:51:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VnukzAUQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0906822256
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT3fP-0001jr-Os
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 09:51:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54478)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kT3dt-0008QB-9h
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 09:50:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34519)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kT3dr-0001it-Fe
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 09:50:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602769801;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3rBXTahQwKZkjMt1VLqEIXggHfTizMTxWJ69zAX84Ac=;
 b=VnukzAUQgYQQpzdZZgeJilRt8OMNbIl9bnrA9JlNewk0OKeZ29RspW2uzoz4bmsUgsJ9ug
 1yxcprzihK1Lrs+Ox/Ae92cADUF2M4Ami1KaKnQ5f2ibGeOxtpoOmsk6YSCm0avDk7sP31
 mdm883TBRzF9Ln1BB/zjylSzoOUdC7I=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-224-rhf6umS7OPKV5S00BiGfhw-1; Thu, 15 Oct 2020 09:49:58 -0400
X-MC-Unique: rhf6umS7OPKV5S00BiGfhw-1
Received: by mail-wr1-f71.google.com with SMTP id a15so1960187wrx.9
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2020 06:49:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3rBXTahQwKZkjMt1VLqEIXggHfTizMTxWJ69zAX84Ac=;
 b=eEGotL8y+QpyZh3emO1WVe9hTydl3K/OSDuEWRImqivwmTje+LsfN0437Kg+ih4F8W
 J2tK/i0H9LJTqX7NStqC1i9/2SCJ38IB1aZF1H0IOAmP4L2lqpT9OGjujFhGojHPRSnP
 qGkoIENLZSElHvn4Fupr6I5Eps7uTYN+yqVnDX4KOOOt/F4bs1enZA72AZNiLVM6nBQr
 aKECipxNE2DXtbYJnKN+a/skIg8VIY954h78C/yk3Z5QLSnP/RoeaV5UU5x4nfurE2BK
 G97cQ5FH1qfz5jXFrCrZNBflPquZ59/yWjPfA5Vim8om1rHeWbGds91VTIM3urwoeJpG
 gUgQ==
X-Gm-Message-State: AOAM530O+nD4F4B0j/fJdNDSkxS+dPUVBomA4bNa2VWt84xB2vQXkoF8
 E0ANDi2wT+4Gd/cwfy6AIhspN/p6MHePrm/0LMTFlYMPSsY9nwGJWqJOIOztR4LHcIjcf8Fe8Ih
 8MP1EXlyM3QLx1H8=
X-Received: by 2002:adf:fac4:: with SMTP id a4mr4841529wrs.172.1602769796841; 
 Thu, 15 Oct 2020 06:49:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzg8Vqdm85/L6jvDJHpSTY+3PXiCtigfowRmz1AYQVf/SM8kgTw98PG0stgSX7TNYssk32avQ==
X-Received: by 2002:adf:fac4:: with SMTP id a4mr4841513wrs.172.1602769796653; 
 Thu, 15 Oct 2020 06:49:56 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id v9sm4364581wmh.23.2020.10.15.06.49.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Oct 2020 06:49:55 -0700 (PDT)
Subject: Re: [RFC 0/5] NVMe passthrough: Support 64kB page host
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, stefanha@redhat.com,
 fam@euphon.net, alex.williamson@redhat.com
References: <20201015115252.15582-1-eric.auger@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <0a1ae4dd-064b-49c5-0669-04219646f616@redhat.com>
Date: Thu, 15 Oct 2020 15:49:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201015115252.15582-1-eric.auger@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 02:10:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.019, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: kwolf@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/15/20 1:52 PM, Eric Auger wrote:
> This series allows NVMe passthrough on aarch64 with 64kB page host.
> Addresses and sizes of buffers which are VFIO DMA mapped are
> aligned with the host page size.
> 
> nvme_register_buf() path is taken care of in this series
> but it does not seem to prevent the use case from working.
> 
> Best Regards
> 
> Eric
> 
> This series can be found at:
> https://github.com/eauger/qemu/tree/nvme_64k_rfc
> 
> This was tested on ARM only.
> 
> Eric Auger (5):
>    block/nvme: use some NVME_CAP_* macros
>    block/nvme: Change size and alignment of IDENTIFY response buffer
>    block/nvme: Change size and alignment of queue
>    block/nvme: Change size and alignment of prp_list_pages
>    block/nvme: Align iov's va and size on host page size

Since it is easier for me to rebase on top of your series,
I'm including it in my work (fixing the checkpatch errors)
and will repost block/nvme/ patches altogether.

Regards,

Phil.


