Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17BADC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 08:38:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C8D52087D
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 08:38:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pfk2uSLN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C8D52087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQnuu-0003uD-60
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 04:38:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49896)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kQntV-000348-Q6
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 04:36:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49632)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kQntQ-0006AW-TQ
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 04:36:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602232606;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=wj1s2Wg5BYXcGKEhXgeNL22sPm/S6ED9ugxuEaiwsgE=;
 b=Pfk2uSLNXVSOvqpvxGDOijDQUk8wvYqRjyn5JAn9fcMUblDFhKLfgwKEA0G3uiwVEw8Gyv
 oglcUIjDTaze8XQvKPx9u+sYPNE36h6Z0GPu+4OnElvDDM3aiAs37japTsYKufQt4dW9cX
 /qAu8toWca4z50TdQRyM+8f5ER1ha2M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-96-UxDjt1-QMo20K8EgEcxC_w-1; Fri, 09 Oct 2020 04:36:38 -0400
X-MC-Unique: UxDjt1-QMo20K8EgEcxC_w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5943B18829DA;
 Fri,  9 Oct 2020 08:36:37 +0000 (UTC)
Received: from redhat.com (ovpn-114-251.ams2.redhat.com [10.36.114.251])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4E1BF76647;
 Fri,  9 Oct 2020 08:36:36 +0000 (UTC)
Date: Fri, 9 Oct 2020 09:36:33 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Yonggang Luo <luoyonggang@gmail.com>
Subject: Re: [PATCH 2/2] cirrus: Enable doc build on msys2/mingw
Message-ID: <20201009083633.GA4363@redhat.com>
References: <20201008201353.465-1-luoyonggang@gmail.com>
 <20201008201353.465-3-luoyonggang@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20201008201353.465-3-luoyonggang@gmail.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 02:34:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 09, 2020 at 04:13:53AM +0800, Yonggang Luo wrote:
> Currently rST depends on old version sphinx-2.x.
> Install it by downloading it.
> 
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
>  .cirrus.yml | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/.cirrus.yml b/.cirrus.yml
> index 77cfd99afe..b1725bd0c1 100644
> --- a/.cirrus.yml
> +++ b/.cirrus.yml
> @@ -73,6 +73,7 @@ windows_msys2_task:
>          bitsadmin /transfer msys_download /dynamic /download /priority FOREGROUND https://github.com/msys2/msys2-installer/releases/download/2020-09-03/msys2-base-x86_64-20200903.sfx.exe C:\tools\base.exe
>          Write-Output "Download time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)"
>          C:\tools\base.exe -y
> +        del C:\tools\base.exe
>          ((Get-Content -path C:\tools\msys64\etc\\post-install\\07-pacman-key.post -Raw) -replace '--refresh-keys', '--version') | Set-Content -Path C:\tools\msys64\etc\\post-install\\07-pacman-key.post
>          C:\tools\msys64\usr\bin\bash.exe -lc "sed -i 's/^CheckSpace/#CheckSpace/g' /etc/pacman.conf"
>          C:\tools\msys64\usr\bin\bash.exe -lc "export"
> @@ -112,6 +113,13 @@ windows_msys2_task:
>            mingw-w64-x86_64-gnutls \
>            mingw-w64-x86_64-libnfs \
>            "
> +        bitsadmin /transfer msys_download /dynamic /download /priority FOREGROUND `
> +          https://mirrors.tuna.tsinghua.edu.cn/msys2/mingw/x86_64/mingw-w64-x86_64-python-sphinx-2.3.1-1-any.pkg.tar.xz `

Relying on some random university mirror site is not a nice approach IMHO.
Why isn't this using the official msys2 site like the other packages ?

> +          C:\tools\mingw-w64-x86_64-python-sphinx-2.3.1-1-any.pkg.tar.xz
> +        C:\tools\msys64\usr\bin\bash.exe -lc "pacman --noconfirm -U \
> +          /c/tools/mingw-w64-x86_64-python-sphinx-2.3.1-1-any.pkg.tar.xz
> +          "
> +        del C:\tools\mingw-w64-x86_64-python-sphinx-2.3.1-1-any.pkg.tar.xz
>          C:\tools\msys64\usr\bin\bash.exe -lc "rm -rf /var/cache/pacman/pkg/*"
>          cd C:\tools\msys64
>          echo "Start archive"

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


