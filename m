Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 948ACC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 08:02:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 677A32078B
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 08:02:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 677A32078B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jndt8-00011I-Mq
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 04:02:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47694)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1jndsB-00088R-86
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 04:01:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:34614)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1jnds8-0007ur-RS
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 04:01:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id DE9FBAD12;
 Tue, 23 Jun 2020 08:01:33 +0000 (UTC)
Subject: Re: [PATCH v9 04/10] configure: Generate rule to calculate the base
 architecture of a target
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200618123342.10693-1-philmd@redhat.com>
 <20200618123342.10693-5-philmd@redhat.com>
From: Claudio Fontana <cfontana@suse.de>
Message-ID: <08f176aa-56a1-3bd0-5889-806f383bca8b@suse.de>
Date: Tue, 23 Jun 2020 10:01:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200618123342.10693-5-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=195.135.220.15; envelope-from=cfontana@suse.de;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 00:36:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Philippe, Alex,

On 6/18/20 2:33 PM, Philippe Mathieu-Daudé wrote:
> From: Alex Bennée <alex.bennee@linaro.org>
> 
> As we encode the base architecture in configure.sh, we can emit
> the base-arch() function into config-host.mak.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>

I found this change a bit strange, but maybe I am missing some context.

Would it not be easier to read the information from the
config-target.mak files as it is already emitted there?

Ciao,

Claudio


> ---
>  configure | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/configure b/configure
> index ba88fd1824..c0d7fbc30e 100755
> --- a/configure
> +++ b/configure
> @@ -7927,6 +7927,8 @@ if test "$linux" = "yes" ; then
>      fi
>  fi
>  
> +target_to_base_map=""
> +
>  for target in $target_list; do
>  target_dir="$target"
>  config_target_mak=$target_dir/config-target.mak
> @@ -8155,6 +8157,7 @@ target_arch_name="$(upper $TARGET_ARCH)"
>  echo "TARGET_$target_arch_name=y" >> $config_target_mak
>  echo "TARGET_NAME=$target_name" >> $config_target_mak
>  echo "TARGET_BASE_ARCH=$TARGET_BASE_ARCH" >> $config_target_mak
> +target_to_base_map="$target_dir,$TARGET_BASE_ARCH $target_to_base_map"
>  if [ "$TARGET_ABI_DIR" = "" ]; then
>    TARGET_ABI_DIR=$TARGET_ARCH
>  fi
> @@ -8370,6 +8373,22 @@ if test "$ccache_cpp2" = "yes"; then
>    echo "export CCACHE_CPP2=y" >> $config_host_mak
>  fi
>  
> +# Export a rule for calculating base arch from target_dir for use by
> +# the Kconfig generator
> +echo "# Usage: \$(call base-arch, target-dir)" >> $config_host_mak
> +echo "# Return the base architecture for a target." >> $config_host_mak
> +echo "# e.g \$(call base-arch, aarch64-linux-user) returns 'arm'" >> $config_host_mak
> +echo "base-arch = \$(strip \\" >> $config_host_mak
> +close_braces=""
> +for pairs in $target_to_base_map
> +do
> +    dir="${pairs%%,*}"
> +    base="${pairs#*,}"
> +    echo "\$(if \$(findstring $dir,\$1),$base, \\" >> $config_host_mak
> +    close_braces="$close_braces )"
> +done
> +echo "$close_braces )" >> $config_host_mak
> +
>  # If we're using a separate build tree, set it up now.
>  # DIRS are directories which we simply mkdir in the build tree;
>  # LINKS are things to symlink back into the source tree
> 


