Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14DC5C4741F
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 09:57:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2C8C2084C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 09:57:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2C8C2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc3vr-0006nz-JO
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 04:57:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35196)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1kc3ud-0005Y5-H9
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 04:56:35 -0500
Received: from mx2.suse.de ([195.135.220.15]:57380)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1kc3uZ-0006uJ-DB
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 04:56:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 76D70ABCC;
 Mon,  9 Nov 2020 09:56:29 +0000 (UTC)
Subject: Re: [PATCH 2/3] accel/stubs: Restrict system-mode emulation stubs
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20201109094547.2456385-1-f4bug@amsat.org>
 <20201109094547.2456385-3-f4bug@amsat.org>
From: Claudio Fontana <cfontana@suse.de>
Message-ID: <552db7b0-78da-7f5c-065f-c82b6a296852@suse.de>
Date: Mon, 9 Nov 2020 10:56:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201109094547.2456385-3-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=195.135.220.15; envelope-from=cfontana@suse.de;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/08 21:17:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 kvm@vger.kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/9/20 10:45 AM, Philippe Mathieu-Daudé wrote:
> This system-mode emulation stubs are not require

nit: s,require,required,

> in user-mode binaries. Restrict them to system-mode
> binaries.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  accel/stubs/meson.build | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/accel/stubs/meson.build b/accel/stubs/meson.build
> index 12dd1539afa..a83408bc0a7 100644
> --- a/accel/stubs/meson.build
> +++ b/accel/stubs/meson.build
> @@ -1,4 +1,8 @@
> -specific_ss.add(when: 'CONFIG_HAX', if_false: files('hax-stub.c'))
> -specific_ss.add(when: 'CONFIG_XEN', if_false: files('xen-stub.c'))
> -specific_ss.add(when: 'CONFIG_KVM', if_false: files('kvm-stub.c'))
> -specific_ss.add(when: 'CONFIG_TCG', if_false: files('tcg-stub.c'))
> +accel_stubs_ss = ss.source_set()
> +
> +accel_stubs_ss.add(when: 'CONFIG_HAX', if_false: files('hax-stub.c'))
> +accel_stubs_ss.add(when: 'CONFIG_XEN', if_false: files('xen-stub.c'))
> +accel_stubs_ss.add(when: 'CONFIG_KVM', if_false: files('kvm-stub.c'))
> +accel_stubs_ss.add(when: 'CONFIG_TCG', if_false: files('tcg-stub.c'))
> +
> +specific_ss.add_all(when: ['CONFIG_SOFTMMU'], if_true: accel_stubs_ss)
> 


