Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 972C9C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 14:36:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56F9A2071E
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 14:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W3MdtR9q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56F9A2071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kADa1-0001Dk-IP
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 10:36:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43068)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kADTm-0008A3-18
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 10:29:46 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:60036
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kADTj-0002fh-7S
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 10:29:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598279381;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9huEos/IfgSN0RJlNMqmnZizozLzFqo0KF6hx/tMf9U=;
 b=W3MdtR9q/zhdkxLl/rUtS6ehbP+Kt6DlC4TpmKOlcOp3ejuLdUXuMk37j1EsMNLcEJ4m6G
 JnPnSJblc2lqimrHB5NPHwaFiVtbijj1NYPPqdFENxXAx6MbCSh/0g/lR98NwKe4A8G2d6
 Ho/cxEt4+bCp1DnsjYm8F3jHDlsc49s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-557-yOW1o1CiP6aF_Eow_8-QlQ-1; Mon, 24 Aug 2020 10:29:29 -0400
X-MC-Unique: yOW1o1CiP6aF_Eow_8-QlQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 736F389CCC0
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2020 14:29:28 +0000 (UTC)
Received: from [10.3.112.126] (ovpn-112-126.phx2.redhat.com [10.3.112.126])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D5E7A7D8AC;
 Mon, 24 Aug 2020 14:29:22 +0000 (UTC)
Subject: Re: [PATCH] meson: Build qemu-nbd on macOS again
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20200823083215.14952-1-thuth@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <cc6c11a1-18af-b887-b597-6f2df431e872@redhat.com>
Date: Mon, 24 Aug 2020 09:29:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200823083215.14952-1-thuth@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/24 05:21:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -52
X-Spam_score: -5.3
X-Spam_bar: -----
X-Spam_report: (-5.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.956,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.25, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/23/20 3:32 AM, Thomas Huth wrote:
> Before switching to the meson build system, we used to compile qemu-nbd
> for macOS, too, which is especially important for running the iotests
> there. Commit b7c70bf2c5 disabled it by accident, since it did not take
> into consideration that the $bsd variable in the configure script was
> also set to "yes" on macOS. Fix it by enabling qemu-nbd on all systems
> but Windows now instead (which was likely the original intention of the
> old code in the configure script).
> 
> Fixes: b7c70bf2c5 ("meson: qemu-{img,io,nbd}")
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   meson.build | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

I can queue this through my NBD tree, although if there is a batch of 
meson fixes going in sooner than that, I don't mind if it goes there.

Acked-by: Eric Blake <eblake@redhat.com>

> 
> diff --git a/meson.build b/meson.build
> index df5bf728b5..d79f849768 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1075,7 +1075,7 @@ if have_tools
>     qemu_io = executable('qemu-io', files('qemu-io.c'),
>                dependencies: [block, qemuutil], install: true)
>     qemu_block_tools += [qemu_img, qemu_io]
> -  if targetos == 'linux' or targetos == 'sunos' or targetos.endswith('bsd')
> +  if targetos != 'windows'
>       qemu_nbd = executable('qemu-nbd', files('qemu-nbd.c'),
>                  dependencies: [block, qemuutil], install: true)
>       qemu_block_tools += [qemu_nbd]
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


