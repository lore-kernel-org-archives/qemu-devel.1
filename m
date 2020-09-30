Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E55C4727E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 12:51:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8277720674
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 12:51:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8277720674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNbaM-0003qi-Ky
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 08:51:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51924)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>)
 id 1kNbZ9-0002lW-TS; Wed, 30 Sep 2020 08:50:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:54460)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>)
 id 1kNbZ8-0001Mc-4N; Wed, 30 Sep 2020 08:50:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 29CA0AF26;
 Wed, 30 Sep 2020 12:50:35 +0000 (UTC)
Subject: Re: [PATCH v4 02/12] meson: Allow optional target/${ARCH}/Kconfig
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <20200929224355.1224017-1-philmd@redhat.com>
 <20200929224355.1224017-3-philmd@redhat.com>
From: Claudio Fontana <cfontana@suse.de>
Message-ID: <19b1318a-f9be-5808-760b-ba7748d48267@suse.de>
Date: Wed, 30 Sep 2020 14:50:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200929224355.1224017-3-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=195.135.220.15; envelope-from=cfontana@suse.de;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 20:52:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/30/20 12:43 AM, Philippe Mathieu-Daudé wrote:
> Extend the generic Meson script to pass optional target Kconfig
> file to the minikconf script.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
> We could use fs.exists() but is_file() is more specific
> (can not be a directory).
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Claudio Fontana <cfontana@suse.de>
> ---
>  meson.build | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/meson.build b/meson.build
> index d36dd085b5..9ab5d514d7 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -529,6 +529,7 @@ kconfig_external_symbols = [
>  ]
>  ignored = ['TARGET_XML_FILES', 'TARGET_ABI_DIR', 'TARGET_DIRS']
>  
> +fs = import('fs')
>  foreach target : target_dirs
>    config_target = keyval.load(meson.current_build_dir() / target / 'config-target.mak')
>  
> @@ -569,8 +570,13 @@ foreach target : target_dirs
>      endforeach
>  
>      config_devices_mak = target + '-config-devices.mak'
> +    target_kconfig = 'target' / config_target['TARGET_BASE_ARCH'] / 'Kconfig'
> +    minikconf_input = ['default-configs' / target + '.mak', 'Kconfig']
> +    if fs.is_file(target_kconfig)
> +      minikconf_input += [target_kconfig]
> +    endif
>      config_devices_mak = configure_file(
> -      input: ['default-configs' / target + '.mak', 'Kconfig'],
> +      input: minikconf_input,
>        output: config_devices_mak,
>        depfile: config_devices_mak + '.d',
>        capture: true,
> 

I can't say I understand it, but the general idea seems right to me.

Ciao,

Claudio

