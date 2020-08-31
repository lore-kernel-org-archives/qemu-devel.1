Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34217C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 08:40:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F31542073A
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 08:40:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X4cszuZb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F31542073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCfMa-000511-07
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 04:40:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42334)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kCfDk-0006cH-LP
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 04:31:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40100
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kCfDi-0006R6-Dl
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 04:31:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598862677;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zzvu7/pgzqLcyy5LAcO+OUpo2Nh1UTmeVD02zii4t0E=;
 b=X4cszuZbK/Db+x8XXz8JqFvo+zv3uLR4UFRIPwsf7jyH6udW79toPbSOpRwBKnwDV90nZm
 8EuWwfLmK7g/z/8yxnpehsQNDdFBLyfgnI/wH6NZMKKPSBAtS8sE80E9Q/6z2WNsuBcPO3
 8hUjWYnq+c744/s+TRiLoSRND6zPcso=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-100-_s9oHOUVMtydbIkaouu4hA-1; Mon, 31 Aug 2020 04:31:15 -0400
X-MC-Unique: _s9oHOUVMtydbIkaouu4hA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 15B7E10ABDA3;
 Mon, 31 Aug 2020 08:31:14 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-174.ams2.redhat.com [10.36.112.174])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 395CA2616B;
 Mon, 31 Aug 2020 08:31:13 +0000 (UTC)
Subject: Re: [PATCH] block: always link with zlib
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20200828173248.24556-1-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <755a6eb4-782d-09ec-c83c-c7f7bb164db1@redhat.com>
Date: Mon, 31 Aug 2020 10:31:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200828173248.24556-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 02:13:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.207, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 28/08/2020 19.32, Paolo Bonzini wrote:
> The qcow2 driver needs the zlib dependency.  While emulators
> provided it through the migration code, this is not true of
> the tools.  Move the dependency from the qcow1 rule directly
> into block_ss so that it is included unconditionally.
> 
> Fixes build with --disable-qcow1.
> 
> Reported-by: Thomas Huth <thuth@redhat.com>
> Cc: qemu-block@nongnu.org
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  block/meson.build | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/block/meson.build b/block/meson.build
> index 4dbbfe60b4..a3e56b7cd1 100644
> --- a/block/meson.build
> +++ b/block/meson.build
> @@ -40,9 +40,9 @@ block_ss.add(files(
>    'vmdk.c',
>    'vpc.c',
>    'write-threshold.c',
> -), zstd)
> +), zstd, zlib)
>  
> -block_ss.add(when: [zlib, 'CONFIG_QCOW1'], if_true: files('qcow.c'))
> +block_ss.add(when: 'CONFIG_QCOW1', if_true: files('qcow.c'))
>  block_ss.add(when: 'CONFIG_VDI', if_true: files('vdi.c'))
>  block_ss.add(when: 'CONFIG_CLOOP', if_true: files('cloop.c'))
>  block_ss.add(when: 'CONFIG_BOCHS', if_true: files('bochs.c'))

Reviewed-by: Thomas Huth <thuth@redhat.com>


