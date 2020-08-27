Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 014D2C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 18:07:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B339B2087C
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 18:07:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UdC6uuKO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B339B2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBMJR-00069i-RZ
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 14:07:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40128)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kBMIk-0005ie-9t
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 14:07:06 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:54509
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kBMIi-0006KW-8d
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 14:07:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598551622;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YDW514PGt1u/OTwAWR45L7h7wxExUwh3C0wPlgQUGrk=;
 b=UdC6uuKOA7TJe2YINUV1czJNgig+RL7L0Fr6GBqsvoXTxIumxu9mnUTvIQEftLPPvJ4l5J
 5hb3BTZsb0QJPWYa5eYN2ji0LCVTRH9/MkO0TkgM4TProtTtmirRdIpvQdsAcjqFQk6Q/u
 GyGIbzHkfiSmueq3QDctAoxKoUYvYmQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-sIY8NYajNmaVCuVvV9E3Ew-1; Thu, 27 Aug 2020 14:06:58 -0400
X-MC-Unique: sIY8NYajNmaVCuVvV9E3Ew-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E3186107464F;
 Thu, 27 Aug 2020 18:06:57 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-56.ams2.redhat.com [10.36.112.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CB65A757E6;
 Thu, 27 Aug 2020 18:06:53 +0000 (UTC)
Subject: Re: [PULL 02/17] meson: Build qemu-nbd on macOS again
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20200827165956.12925-1-pbonzini@redhat.com>
 <20200827165956.12925-3-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <8daf0562-3a9d-e9db-44ce-d95352ff2328@redhat.com>
Date: Thu, 27 Aug 2020 20:06:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200827165956.12925-3-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.61; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 07:16:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.782, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 27/08/2020 18.59, Paolo Bonzini wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
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
> Acked-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  meson.build | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/meson.build b/meson.build
> index f2aa5a7700..38d0abc0ea 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1081,7 +1081,7 @@ if have_tools
>    qemu_io = executable('qemu-io', files('qemu-io.c'),
>               dependencies: [block, qemuutil], install: true)
>    qemu_block_tools += [qemu_img, qemu_io]
> -  if targetos == 'linux' or targetos == 'sunos' or targetos.endswith('bsd')
> +  if targetos != 'windows'
>      qemu_nbd = executable('qemu-nbd', files('qemu-nbd.c'),
>                 dependencies: [block, qemuutil], install: true)
>      qemu_block_tools += [qemu_nbd]
> 

 Hi Paolo!

Daniel posted some better patches that even enable qemu-nbd on Windows
(see the "nbd: build qemu-nbd on Windows" v2 patch series)... in case
you have to respin this pull request, please use his patches instead!

 Thanks,
  Thomas


