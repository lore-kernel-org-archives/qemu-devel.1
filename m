Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49D00C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 09:02:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F66120826
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 09:02:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F66120826
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrHaQ-0005jv-AU
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 05:02:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58842)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1jrHZs-0005KE-3a
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 05:01:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:41886)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1jrHZq-00043D-92
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 05:01:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 8E152AD11;
 Fri,  3 Jul 2020 09:01:44 +0000 (UTC)
Subject: Re: [PULL 04/10] build: fix device module builds
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20200702122048.27798-1-kraxel@redhat.com>
 <20200702122048.27798-5-kraxel@redhat.com>
From: Claudio Fontana <cfontana@suse.de>
Message-ID: <a7af3c56-98ab-16e2-afaf-383757b03720@suse.de>
Date: Fri, 3 Jul 2020 11:01:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200702122048.27798-5-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=195.135.220.15; envelope-from=cfontana@suse.de;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 23:00:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/2/20 2:20 PM, Gerd Hoffmann wrote:
> See comment.  Feels quite hackish.  Better ideas anyone?
> 


A better idea could be to investigate what and why gets into the variable.
I guess at this point we will need to revisit this later on.

CLaudio


> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> Message-id: 20200624131045.14512-5-kraxel@redhat.com
> ---
>  Makefile.target | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Makefile.target b/Makefile.target
> index 8ed1eba95b9c..c70325df5796 100644
> --- a/Makefile.target
> +++ b/Makefile.target
> @@ -179,6 +179,13 @@ endif # CONFIG_SOFTMMU
>  dummy := $(call unnest-vars,,obj-y)
>  all-obj-y := $(obj-y)
>  
> +#
> +# common-obj-m has some crap here, probably as side effect from
> +# filling obj-y.  Clear it.  Fixes suspious dependency errors when
> +# building devices as modules.
> +#
> +common-obj-m :=
> +>  include $(SRC_PATH)/Makefile.objs
>  dummy := $(call unnest-vars,.., \
>                 authz-obj-y \
> 


