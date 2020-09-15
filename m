Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B614C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 15:59:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79B8B2074B
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 15:59:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79B8B2074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIDMM-0006Xx-DJ
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 11:59:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53622)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kIDLV-00067V-NN
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 11:58:17 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:39027)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kIDLT-0007uc-SH
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 11:58:17 -0400
Received: from [192.168.100.1] ([82.252.129.222]) by mrelayeu.kundenserver.de
 (mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MPXpU-1k5W2j0TFy-00MZvm; Tue, 15 Sep 2020 17:58:11 +0200
Subject: Re: [PATCH v2 1/8] linux-user: test, don't assert addr != test in
 pgb_reserved_va
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200915134317.11110-1-alex.bennee@linaro.org>
 <20200915134317.11110-2-alex.bennee@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <46a30317-1779-9e92-f3ce-779ca89d9b44@vivier.eu>
Date: Tue, 15 Sep 2020 17:58:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200915134317.11110-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:E9ZrO3le9ofk0h7rIfIQWP5LGBg9OmXbKCfAApRJ8CuIv5+4Yok
 eqDJEfWRwfXPNQLRI1XGqymhLsWmBLyrYyMYlK8/ROYvtfsMB+VKUI/0AfzPhAcaYWtyctg
 b/FMYy4qKuwjR81k2P8Bv2VOFWa2N4J0fHwvLE8BBrogvtvLDaIbZj3/3flGu74BpdPH70h
 idHX1NWakTcAa1r5jIz1A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0qJU61Pfwio=:+nH4qdM9GHxhsIFXnhBFWb
 ZuSqyALyanQX70KoC6PxYZ0FJTxMiEYT8v3SLAyxDl5Cs88k2tF/HGzwmF8Rz0VXpbOX8zwot
 nFBG9HkU3CIhPP7Kc3Bz8sh9cGXGrNPlHBKsY2vBW5TLtEelDWOdlgHdmFNgO3aWyC9C2rftQ
 3WwJ6m46AC4DEjSPtyxm+BqiOj7KPklkvzV3bnBVV+Rf1IRPTZl4X1b7ZO4IvZ9ePx35PLuB/
 3b5UzwWOCVeluDqO6qOd0ph5STHHQkTcPCBXVk7p8wwys2E+1YLFAmqLsWTvaakIZEeZAjjbE
 x5pGrVFrW5Virm7XvxzxjjkLjNBfwwsoukJg2mN02+lFrhv6c/c9pWSnwqA6hhfZsASS5Dmdt
 4Nt4B8LFPSte/zrrp7QY1GkEXhj4SEOHR8JVhnQgc3+++wyWt+jgPEThLdMOy5RaXVyNmU3nA
 3xwvxQtKS5fFdcmXsBHUgPcSo/GHVFOzPg2kHoEd399jMVPHZxMzxsIp8npqipGKc74vD7l+3
 3zTypSvo+re6C88PaTRCp3BobHGjgLsBPPUEvxoSKX+LY8HNjO5MCRmkgCUcexBJCPdiJCk2h
 YadYR8tupVio/kS8evdFjIvro5xYYJao/8mdytt/gj+nsSrNB+uLvSrIo9zeeCRx5j6eb12ni
 a2rs2WEhslhSXY5RuWCQUBwqtEDV/X4c9pBC9d4of2APFA/hmzzXe6+uiRbYbq09s5PvBF7Pu
 xcRpWuIyB6sejC4FUtRLMKESd7n928VDvx6vx4fwDPKMCBjGwLRcHeyjywdCi/7GmI5wbL5A4
 jB4rFO8kk1L++cAtLgtp/Wuc1htaJUIKXx8+dXbuGzQ0UrxS4OKIws7vbq6XUcQvjHcRaZs
Received-SPF: none client-ip=217.72.192.74; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 11:58:12
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Bug 1895080 <1895080@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 15/09/2020 à 15:43, Alex Bennée a écrit :
> On older kernels which don't implement MAP_FIXED_NOREPLACE the kernel
> may still fail to give us the address we asked for despite having
> already probed the map for a valid hole. Asserting isn't particularly
> useful to the user so let us move the check up and expand the
> error_report a little to give them a fighting chance of working around
> the problem.
> 
> Ameliorates: ee94743034
> Cc: Bug 1895080 <1895080@bugs.launchpad.net>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  linux-user/elfload.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index 4961e6119e24..f6022fd70493 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -2331,14 +2331,13 @@ static void pgb_reserved_va(const char *image_name, abi_ulong guest_loaddr,
>      assert(guest_base != 0);
>      test = g2h(0);
>      addr = mmap(test, reserved_va, PROT_NONE, flags, -1, 0);
> -    if (addr == MAP_FAILED) {
> +    if (addr == MAP_FAILED || addr != test) {
>          error_report("Unable to reserve 0x%lx bytes of virtual address "
> -                     "space (%s) for use as guest address space (check your "
> -                     "virtual memory ulimit setting or reserve less "
> -                     "using -R option)", reserved_va, strerror(errno));
> +                     "space at %p (%s) for use as guest address space (check your"
> +                     "virtual memory ulimit setting, min_mmap_addr or reserve less "
> +                     "using -R option)", reserved_va, test, strerror(errno));
>          exit(EXIT_FAILURE);
>      }
> -    assert(addr == test);
>  }
>  
>  void probe_guest_base(const char *image_name, abi_ulong guest_loaddr,
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

