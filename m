Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA4FC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 12:53:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6479420720
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 12:53:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6479420720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtsWu-0006wF-Oa
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 08:53:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44548)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1jtsWQ-0006Vw-68
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 08:52:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:43852)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1jtsWO-0007Xw-CT
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 08:52:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 58EBCACC5;
 Fri, 10 Jul 2020 12:52:55 +0000 (UTC)
Subject: Re: [PULL v2 00/52] Misc patches for QEMU 5.1 soft freeze
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200708172542.25012-1-pbonzini@redhat.com>
 <CAFEAcA8b6sn8fXOKwqOF6MvsKT5oKqS+4jjYDPAPvnXmVimLiQ@mail.gmail.com>
 <9631042d-00e4-2a2e-292b-66ca1b590120@suse.de>
 <CAFEAcA-UbHpj_xSbqjTsaURt8yPZjuYOmd3pe97vg_G7--17Cw@mail.gmail.com>
From: Claudio Fontana <cfontana@suse.de>
Message-ID: <e78820bb-af5f-c2a0-7727-1a0caedfa584@suse.de>
Date: Fri, 10 Jul 2020 14:52:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-UbHpj_xSbqjTsaURt8yPZjuYOmd3pe97vg_G7--17Cw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=195.135.220.15; envelope-from=cfontana@suse.de;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/10 00:07:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/10/20 2:43 PM, Peter Maydell wrote:
> On Fri, 10 Jul 2020 at 13:38, Claudio Fontana <cfontana@suse.de> wrote:
>> I got regular green test reports from cirrus-ci for Mac, seems different compilation options.
> 
> That's odd -- what is cirrus-ci doing differently? Building
> the cocoa UI frontend is the default and is definitely
> something we want to be testing in the CI...
> 
> thanks
> -- PMM
> 

If you can access it,

https://cirrus-ci.com/task/5537514263937024?command=main#L2039

the thing is treated here as a warning, which is in the middle of a large amount of other warnings.

private/var/folders/3y/l0z1x3693dl_8n0qybp4dqwh0000gn/T/cirrus-ci-build/ui/vnc-auth-sasl.c:648:29: warning: 'sasl_errdetail' is deprecated: first deprecated in macOS 10.11 [-Wdeprecated-declarations]
                            sasl_errdetail(vs->sasl.conn));

/* ... lots of similar warnings */

private/var/folders/3y/l0z1x3693dl_8n0qybp4dqwh0000gn/T/cirrus-ci-build/ui/cocoa.m:1478:9: warning: implicit declaration of function 'cpu_throttle_set' is invalid in C99 [-Wimplicit-function-declaration]
        cpu_throttle_set(throttle_pct);
        ^


Apparently the cirrus-ci I am using is not treating this as an error, while what you are using is..

Thanks,

Claudio

