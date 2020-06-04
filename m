Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC9FBC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 14:16:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91D5720663
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 14:16:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91D5720663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgqfr-0004Db-SQ
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 10:16:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37612)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jgqf0-0003mq-Bu
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 10:15:58 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:44605)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jgqey-0005oY-SG
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 10:15:58 -0400
Received: from [192.168.100.43] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.168]) with ESMTPSA (Nemesis) id
 1MRCFw-1jM2Y34AYG-00NA19; Thu, 04 Jun 2020 16:15:48 +0200
Subject: Re: [PULL v2 05/13] accel/tcg: Relax va restrictions on 64-bit guests
References: <20200515144405.20580-1-alex.bennee@linaro.org>
 <20200515144405.20580-6-alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <843d72a9-22a7-b0b5-0a92-edf1dcd290d2@vivier.eu>
Date: Thu, 4 Jun 2020 16:15:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200515144405.20580-6-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:VW8k9MVw41SUXcmp9JXUiYtBrOE6MqZkMpAhQhCpeumhfuts1Oc
 qVfUg9tQiGvveSxW121w25qheusX4+iI72bgaC38uOLPbN/QXezAcUw8yN0pLILnEvCSEmn
 H+zkzQF34TKe9Ovan4lLyt3Cs+YIDsCc1soy3WIV5lVIhi9/czSHLxcYtUAg5HWm3hfYpyD
 syVfN+fQttJezN/6o4Dwg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sfZWit8fPIc=:mTFTeummY+78C44Es8aeZl
 vGQ9qqLW35zIXULsk6G2UIb7EwItG9EqypvPnUZYl1RUhQ030c1rZiUYNcRTFQctjzwiCnsD9
 QD2gKUv5mHVvi280CPcQ1bC8a2suUZraNHBfcniVxwfFJxzq30ivPipAUaumcuRD9nGJIMuXP
 ojjHbxd6jQYcbq4pdgu6sksVvXC5aakNILWNdxzi8fQpP7yD/TPWeZH4FdmUyQQfQWH2hSMle
 JNExR4ly6CbdW9pLLz8eCU4EvfwZWAlMWsPXYU1w4uwY3tOHNAxNf5AUoCAm96a1KNMbYNrmZ
 tXa4wl6j8F9LRj8lFwUhX0ZmevXhesCf8ePx1bRe0m8k7LUdoOI1sJKJgnMS7pvdgarabYQYY
 LMK1B9Ms2GHsVFzs99ojCtbpReNOCZ6Nqo2tQMen9KpNiEOA0dt7G907Y2yatAa5YVRmy1Ttg
 /MR0TR3/z+GXG3TZWx/imvp8Kq6Mb1ES7ImTNzdVjN93F4IkSzAXmJYGcBU7X9hJzxg9mbyAE
 D6Y1CpozrF+h8oY/4CuSZw2/AFsiR61pt5ykDV4HkyxP4G2jr3V5qS59NZVYNeKiPXYuQ22Fs
 xNFo7u8cVSiOCin8lgLUy33C/OLCsyJMsIJ2IqSgxR1ef+jmkqKBY+39NejHCQka1ylcuKEYX
 Fk4kHrc2uI4gx+GjkkQ1UcXIDB77SOHfQJBsbbgOhtHJiFzJQoMY6neVI+2LB38M2SWPObg1C
 AMBh8bb787001vicq9j25OopjaBiwwb05/sjGndX4ZO+4gGsVHETOLs8DMVpnxc4iPLAtlLjV
 5RHwFTX713TySPCCLn9+7Hq/9JxKqK9R9XNHEWlXE3D6xBTvtC9vnAAfG+MC5SZhpXZgfBU
Received-SPF: none client-ip=212.227.126.131; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 10:15:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, Richard Henderson <rth@twiddle.net>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 15/05/2020 16:43, Alex Bennée wrote:
> From: Richard Henderson <richard.henderson@linaro.org>
> 
> We cannot at present limit a 64-bit guest to a virtual address
> space smaller than the host.  It will mostly work to ignore this
> limitation, except if the guest uses high bits of the address
> space for tags.  But it will certainly work better, as presently
> we can wind up failing to allocate the guest stack.
> 
> Widen our user-only page tree to the host or abi pointer width.
> Remove the workaround for this problem from target/alpha.
> Always validate guest addresses vs reserved_va, as there we
> control allocation ourselves.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> Message-Id: <20200513175134.19619-7-alex.bennee@linaro.org>
> 

This patch breaks a test case in LTP with 64bit targets on x86_64 host:

sudo linux-user/mips64el-linux-user/qemu-mips64el \
-L chroot/mips64el/stretch/ \
chroot/mips64el/stretch/opt/ltp/testcases/bin/mmap15

qemu-mips64el: accel/tcg/translate-all.c:2533: page_set_flags: Assertion
`start < end' failed.
qemu:handle_cpu_signal received signal outside vCPU context @
pc=0x7f0015f6e7cb

Could you have a look?

Thanks,
Laurent

