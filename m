Return-Path: <SRS0=rO5d=BF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D4BC433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2020 20:49:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2D332065F
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2020 20:49:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2D332065F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jznan-0003u5-1n
	for qemu-devel@archiver.kernel.org; Sun, 26 Jul 2020 16:49:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54466)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <whitebox@nefkom.net>)
 id 1jznaC-0003SR-Rf
 for qemu-devel@nongnu.org; Sun, 26 Jul 2020 16:49:20 -0400
Received: from mail-out.m-online.net ([2001:a60:0:28:0:1:25:1]:60390)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <whitebox@nefkom.net>)
 id 1jznaA-0007vm-Fe
 for qemu-devel@nongnu.org; Sun, 26 Jul 2020 16:49:20 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
 by mail-out.m-online.net (Postfix) with ESMTP id 4BFFRF3BZMz1rsXY;
 Sun, 26 Jul 2020 22:49:13 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
 by mail.m-online.net (Postfix) with ESMTP id 4BFFRF2Fgtz1qtwM;
 Sun, 26 Jul 2020 22:49:13 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new,
 port 10024)
 with ESMTP id vZSO0eb7yhLC; Sun, 26 Jul 2020 22:49:12 +0200 (CEST)
X-Auth-Info: uLZ9SzCbZdnfluL1gmmc21Z8q4tlnA5gZrDOw3QwjvDaaqXYayethF5qpu9heYCs
Received: from igel.home (ppp-46-244-174-182.dynamic.mnet-online.de
 [46.244.174.182])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.mnet-online.de (Postfix) with ESMTPSA;
 Sun, 26 Jul 2020 22:49:12 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
 id DB7322C0CB6; Sun, 26 Jul 2020 22:49:11 +0200 (CEST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH for 5.1] docs: fix trace docs build with sphinx 3.1.1
References: <20200714162659.1017432-1-berrange@redhat.com>
X-Yow: ..Are we having FUN yet...?
Date: Sun, 26 Jul 2020 22:49:11 +0200
In-Reply-To: <20200714162659.1017432-1-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Tue, 14 Jul 2020 17:26:59
 +0100")
Message-ID: <87blk257eg.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:a60:0:28:0:1:25:1;
 envelope-from=whitebox@nefkom.net; helo=mail-out.m-online.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/26 16:49:13
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Jul 14 2020, Daniel P. Berrangé wrote:

> In Fedora 33 rawhide, we now have sphinx 3.1.1, as opposed
> to previous 2.2.2. This new version generates a warning on
> the source:
>
> docs/qemu-option-trace.rst.inc:4:Malformed option description
>   '[enable=]PATTERN', should look like "opt", "-opt args",
>   "--opt args", "/opt args" or "+opt args"
>
> This turns into an error when QEMU passes -W to sphinx-build
>
> Strangely the previous 2.2.2 code has the exact same logic
> for checking the syntax, but it is not being triggered. While
> it is only complaining about the first option, I changed all
> the options to give consistency.
>
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>

Running Sphinx v1.7.6
[...]
Warning, treated as error:
../qemu-5.0.0/docs/qemu-option-trace.rst.inc:21:Duplicate explicit target name: "cmdoption-qemu-img-trace".

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."

