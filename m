Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F28C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 09:55:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56878206A1
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 09:55:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56878206A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeFFq-0006wl-J2
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 05:55:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38724)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jeFFF-000682-Pz
 for qemu-devel@nongnu.org; Thu, 28 May 2020 05:54:37 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:56173)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jeFFE-0001pd-I6
 for qemu-devel@nongnu.org; Thu, 28 May 2020 05:54:37 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue010 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1M58vU-1jd9Jd2nDg-001DXb; Thu, 28 May 2020 11:54:33 +0200
Subject: Re: [PATCH 0/2] linux-user: Load a vdso for x86_64
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200519194452.9009-1-richard.henderson@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <f0d538fa-93b6-fdb4-e856-dfee371f1957@vivier.eu>
Date: Thu, 28 May 2020 11:54:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200519194452.9009-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:DsGS05an811Dvoz8/Qp7Qs5Zt5JpxC7pWGVTz2ncO+bQU8+WRxW
 NudTXEiRCyXhY9wBNZdck7nZXvMTdekzrCtyTm9ArUQdSBrIJ4K/DM92Jvqqw8Z9Low1grW
 SrQgRuXYQN9HWp3fGS8wYYgRgDTTQvq4EUZJ37lqNLMpn3xZhfHpE3PiJQQZ6dkJM2TAPAU
 lFStJVl9XV5HjQcxMHJqA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KJQi59s0I2Y=:NbJesUuuUz4I6iCzHUpapa
 zwZOilpas/G9ILIMxNRsvTYgqINXekKDl16ebH1/PTthkwLh4FE+ssym2ujlryoLiobVY8B/E
 2mQTPoW26UeaRwQGZHkXFzHRbsK7yfjSrkxHcDMO/zGhTDi93GCSKI1BL97VZIc5jk/6+PMnm
 EeuHmh/xnXWT1054Q6Qb3uz5BKkdP2H+MDxB3GfQlRJMumU+ov8P121nxW1HlOHJjzfeRdpH4
 Z1OlkJElpN7GwRcTl9QkNJr6j8Bt054mu8RMW4ZxCUtxt8w/5f0vsGQcWU8I2rCPLRXVOzKc9
 rE/N0m5ABM1IgRB/2UngmmD5kTES+91salF8baDC7UqC3cefHCEkCpKsrSrWAWJvwcdsW9R2l
 muTCfr5E9ULT6Ff677n+/C05AY4mHmLFFH4Ayv1Ef970B9ga6zDXxOFT/YVzbz543Znyz8uXl
 ozZoowLbnYkYfNVkpXwF+jcDghB73ulUZmHpVSBzKLp1FcXICzmqkjiFsJZwDghVJ8PvaJi1y
 KIbxsPjdHE1VCLZMVSXRc6w0PKZV7VkJEvt1TRL6lcw9Msy9TpKvdJhcWGPtQVSgO+HlJvgAG
 Ii6wR913bo3PG4PvRdsbn0+1dS5sdwCfacbf2bpGb3a23OB2MLp4iWcCsfMTccsPgzAMKRunK
 QCb16bhSUSEo1kHirBvj3RNnYC/I3hHsiqcnqhIoGJ6cBdgSis6+OZo7EHGBjLCjKDttVwWjm
 F0fwfHdGPkaDYM4EueaIDLNW1VkAwaTFvs8Bkk+0+b/FRYezdKr/UiKFnVM9OpUiNbXvqf0Q9
 T8EVaTdCBlVb2AhcbVYOS3J2czWJgQAGJez4JCqyZXtEjpeMevRoUN6z0mqq/cW/OZXXEgn
Received-SPF: none client-ip=212.227.126.134; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 05:54:34
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 19/05/2020 à 21:44, Richard Henderson a écrit :
> The subject of AT_SYSINFO came up on launchpad recently.
> 
> There is definite room for improvement in all of this:
> 
> (1) We could build the vdso binary into qemu instead of really
>     loading it from the file system.  This would obviate the
>     several problems of locating the .so file.  It would also
>     mean that --static builds continue to create a standalone
>     qemu binary.
> 
> (2) We could use our cross-build system to build the vdso.
>     Though we'd still likely want to keep the image in git
>     along side the other rom images for when cross-build is
>     not available.
> 
> (3) There are some ??? comments where some decisions could be made,
>     and other ??? that are merely commenting on weirdness.
> 
> (4) It shouldn't take too much effort to create vdsos for the
>     other architectures.  But we should get this one as clean
>     as we can first.
> 
> Amusingly, this patch set has just turned 10 years old.
> First posted April 4, 2010.  I don't recall ever seeing
> any review on the several postings over the years.
> 
> 
> r~
> 
> 
> Richard Henderson (2):
>   linux-user: Build vdso for x64.
>   linux-user: Load a VDSO for x86-64.
> 
>  Makefile                  |   4 +-
>  linux-user/elfload.c      | 203 +++++++++++++++++++++++++++++++++++++-
>  pc-bios/Makefile          |   5 +
>  pc-bios/vdso-linux-x64.S  | 115 +++++++++++++++++++++
>  pc-bios/vdso-linux-x64.ld |  81 +++++++++++++++
>  pc-bios/vdso-linux-x64.so | Bin 0 -> 7500 bytes
>  6 files changed, 401 insertions(+), 7 deletions(-)
>  create mode 100644 pc-bios/vdso-linux-x64.S
>  create mode 100644 pc-bios/vdso-linux-x64.ld
>  create mode 100755 pc-bios/vdso-linux-x64.so
> 

Applied to my linux-user branch.

Thanks,
Laurent


