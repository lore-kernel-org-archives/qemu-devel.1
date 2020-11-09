Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22AE9C388F7
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 18:53:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F01F2064C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 18:53:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iSpIBHH9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F01F2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kcCHr-0008Lh-Cc
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 13:53:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57256)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kcCH4-0007V6-Em
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 13:52:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57046)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kcCH2-0002tf-7V
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 13:52:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604947935;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K9tsYUIVxVrs9O+zDIhP/cV5Sn/Hqt4qvsIdgQyqBhs=;
 b=iSpIBHH9GwZplzwCvPjnYNM5KiwYlumvtOHji1in78cF84CFgA3fiJl1PSinwzrhGw8i6j
 4NlF2FhugMtRTtJPFSNdUPz/7ezXIkzefzhRl7KTh/nbZ15vyh3XScCosZHGpgx+kv+R+4
 6/SZsU+qKXQNIPWtyOfq38Nd4joDhf8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-595-HKpHLD4tO3Kd9aO6PkYuAg-1; Mon, 09 Nov 2020 13:52:11 -0500
X-MC-Unique: HKpHLD4tO3Kd9aO6PkYuAg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 01A9D809DD8;
 Mon,  9 Nov 2020 18:52:10 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-53.ams2.redhat.com [10.36.112.53])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 28249619B5;
 Mon,  9 Nov 2020 18:52:08 +0000 (UTC)
Subject: Re: [PATCH v4 2/7] configure: cross-compiling with empty cross_prefix
To: Joelle van Dyne <j@getutm.app>, qemu-devel@nongnu.org
References: <20201108052605.45840-1-j@getutm.app>
 <20201108052605.45840-3-j@getutm.app>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <7d6400c3-84b3-a825-1e10-6cc364cd41de@redhat.com>
Date: Mon, 9 Nov 2020 19:52:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201108052605.45840-3-j@getutm.app>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 00:04:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08/11/2020 06.26, Joelle van Dyne wrote:
> The iOS toolchain does not use the host prefix naming convention. So we need
> to enable cross-compile options while allowing the PREFIX to be blank.
> 
> Signed-off-by: Joelle van Dyne <j@getutm.app>
> ---
>  configure | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/configure b/configure
> index 97a879808d..fda7a875f7 100755
> --- a/configure
> +++ b/configure
> @@ -234,6 +234,7 @@ cpu=""
>  iasl="iasl"
>  interp_prefix="/usr/gnemul/qemu-%M"
>  static="no"
> +cross_compile="no"
>  cross_prefix=""
>  audio_drv_list=""
>  block_drv_rw_whitelist=""
> @@ -458,6 +459,7 @@ for opt do
>    optarg=$(expr "x$opt" : 'x[^=]*=\(.*\)')
>    case "$opt" in
>    --cross-prefix=*) cross_prefix="$optarg"
> +                    cross_compile="yes"
>    ;;
>    --cc=*) CC="$optarg"
>    ;;
> @@ -1657,7 +1659,7 @@ $(echo Available targets: $default_target_list | \
>    --target-list-exclude=LIST exclude a set of targets from the default target-list
>  
>  Advanced options (experts only):
> -  --cross-prefix=PREFIX    use PREFIX for compile tools [$cross_prefix]
> +  --cross-prefix=PREFIX    use PREFIX for compile tools, PREFIX can be blank [$cross_prefix]
>    --cc=CC                  use C compiler CC [$cc]
>    --iasl=IASL              use ACPI compiler IASL [$iasl]
>    --host-cc=CC             use C compiler CC [$host_cc] for code run at
> @@ -6933,7 +6935,7 @@ if has $sdl2_config; then
>  fi
>  echo "strip = [$(meson_quote $strip)]" >> $cross
>  echo "windres = [$(meson_quote $windres)]" >> $cross
> -if test -n "$cross_prefix"; then
> +if test "$cross_compile" = "yes"; then
>      cross_arg="--cross-file config-meson.cross"
>      echo "[host_machine]" >> $cross
>      if test "$mingw32" = "yes" ; then
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>


