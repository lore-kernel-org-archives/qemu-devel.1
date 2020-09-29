Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 818C3C4346E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 08:46:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4F402067D
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 08:46:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ErwESZ09"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4F402067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNBHE-0002qy-Nx
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 04:46:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50604)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kNBGD-0002GV-61
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 04:45:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27520)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kNBGA-00072s-LZ
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 04:45:20 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601369116;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gJT94RFjjTerUS0cHGXAH9GZfG7CGrnvrYu/TxUf4Wk=;
 b=ErwESZ09I1pZaWDYkZwMeL+aSFPtrr7k35/YdI0MF+f8ye1iHYOUOFwcD3Dcfk8aV1SNCt
 sna+9yK0xiYyycO8KuXZ2irAg0WgUpq2iyRGOVCeynMfAdOdc5BkImqegI9iMxmiDMoYLr
 69yphNxgni2BvIQYkAZT4MgPnSXDJaM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-mbSychWlMPOAHytcP0gp0g-1; Tue, 29 Sep 2020 04:45:12 -0400
X-MC-Unique: mbSychWlMPOAHytcP0gp0g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B298D18A2249;
 Tue, 29 Sep 2020 08:45:11 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-101.ams2.redhat.com
 [10.36.112.101])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8305360C84;
 Tue, 29 Sep 2020 08:45:11 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0B4F0113864A; Tue, 29 Sep 2020 10:45:10 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v6 13/21] meson.build: Move SPHINX_ARGS to top level
 meson.build file
References: <20200925162316.21205-1-peter.maydell@linaro.org>
 <20200925162316.21205-14-peter.maydell@linaro.org>
Date: Tue, 29 Sep 2020 10:45:10 +0200
In-Reply-To: <20200925162316.21205-14-peter.maydell@linaro.org> (Peter
 Maydell's message of "Fri, 25 Sep 2020 17:23:08 +0100")
Message-ID: <87blhpyns9.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 22:47:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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
Cc: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> We're going to want to use SPHINX_ARGS in both docs/meson.build
> and tests/qapi-schema/meson.build. Move the definition up to the
> top level file so it is available to both subdirectories.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  docs/meson.build | 8 --------
>  meson.build      | 8 ++++++++
>  2 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/docs/meson.build b/docs/meson.build
> index 69097e2ca07..99da609e813 100644
> --- a/docs/meson.build
> +++ b/docs/meson.build
> @@ -1,11 +1,3 @@
> -SPHINX_ARGS = [config_host['SPHINX_BUILD'],
> -               '-Dversion=' + meson.project_version(),
> -               '-Drelease=' + config_host['PKGVERSION']]
> -
> -if get_option('werror')
> -  SPHINX_ARGS += [ '-W' ]
> -endif
> -
>  if build_docs
>    configure_file(output: 'index.html',
>                   input: files('index.html.in'),
> diff --git a/meson.build b/meson.build
> index 73d675ca834..6408ad442ea 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -671,6 +671,14 @@ foreach d : hx_headers
>  endforeach
>  genh += hxdep
>  
> +SPHINX_ARGS = [config_host['SPHINX_BUILD'],
> +               '-Dversion=' + meson.project_version(),
> +               '-Drelease=' + config_host['PKGVERSION']]
> +
> +if get_option('werror')
> +  SPHINX_ARGS += [ '-W' ]
> +endif
> +
>  # Collect sourcesets.
>  
>  util_ss = ss.source_set()

I double-checked we still pass SPHINX_ARGS to sphinx.

Reviewed-by: Markus Armbruster <armbru@redhat.com>


