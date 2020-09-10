Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1884CC43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 11:21:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72D3420684
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 11:21:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fM1zfOo0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72D3420684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGKe5-0003BM-CD
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 07:21:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33352)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kGKdY-0002gu-Tj
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 07:21:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32555
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kGKdX-0000t2-5N
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 07:21:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599736866;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6rWv251ScEfhgfPY6zZhFWbej1k+8/ldak2QWUr7jQE=;
 b=fM1zfOo02HM9NhSNEtrZS2I7jwerzF/6qTOzLz3XgMFuAtrNQw45Vk+H15a2wt0F0Ofawa
 6gsrXpi7HZhBgjzMeL1z0MT3WpSpCPmb/dfluEiccLxziiHGZS5Vefp4+gKb1wqkWD8KXV
 33nPDuh+DjywTpSNgR8AfRMtoeqveBA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-183-T-2WD9v1Ol-5qmoF0Lt7Zg-1; Thu, 10 Sep 2020 07:21:02 -0400
X-MC-Unique: T-2WD9v1Ol-5qmoF0Lt7Zg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 499D68030A9;
 Thu, 10 Sep 2020 11:21:00 +0000 (UTC)
Received: from thuth.remote.csb (unknown [10.40.194.173])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AEFAA83565;
 Thu, 10 Sep 2020 11:20:53 +0000 (UTC)
Subject: Re: [PATCH v7 15/25] meson: remove empty else and duplicated gio deps
To: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org
References: <20200910103059.987-1-luoyonggang@gmail.com>
 <20200910103059.987-16-luoyonggang@gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <438fb7da-72b0-f3cf-0680-3a69367993ab@redhat.com>
Date: Thu, 10 Sep 2020 13:20:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200910103059.987-16-luoyonggang@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 03:02:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.576, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, QEMU Trivial <qemu-trivial@nongnu.org>,
 Stefan Weil <sw@weilnetz.de>, Xie Changlong <xiechanglong.d@gmail.com>,
 Peter Lieven <pl@kamp.de>, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/09/2020 12.30, Yonggang Luo wrote:
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  meson.build | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/meson.build b/meson.build
> index 5421eca66a..0b1741557d 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -317,7 +317,6 @@ opengl = not_found
>  if 'CONFIG_OPENGL' in config_host
>    opengl = declare_dependency(compile_args: config_host['OPENGL_CFLAGS'].split(),
>                                link_args: config_host['OPENGL_LIBS'].split())
> -else
>  endif
>  gtk = not_found
>  if 'CONFIG_GTK' in config_host
> @@ -344,11 +343,6 @@ if 'CONFIG_ICONV' in config_host
>    iconv = declare_dependency(compile_args: config_host['ICONV_CFLAGS'].split(),
>                               link_args: config_host['ICONV_LIBS'].split())
>  endif
> -gio = not_found
> -if 'CONFIG_GIO' in config_host
> -  gio = declare_dependency(compile_args: config_host['GIO_CFLAGS'].split(),
> -                           link_args: config_host['GIO_LIBS'].split())
> -endif
>  vnc = not_found
>  png = not_found
>  jpeg = not_found
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>


