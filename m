Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B84B4C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 05:12:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 826212070C
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 05:12:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b="H9n9/xag"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 826212070C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aurel32.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqrW8-00089W-Lw
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 01:12:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37370)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aurelien@aurel32.net>)
 id 1jqrTM-0007Cc-SY
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 01:09:21 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:44804)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aurelien@aurel32.net>)
 id 1jqrTK-0003m2-AK
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 01:09:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
 ; s=202004.hall;
 h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Content-Transfer-Encoding:From:Reply-To:
 Subject:Content-ID:Content-Description:X-Debbugs-Cc;
 bh=tjlmlD/VtuM92KEa6IzwAle1cIcFTW66B9uhyU6Da0c=; b=H9n9/xagUlHiRqzoo88X2OKL0W
 f/UCrMlnwV0EldBmC3t60jLw23X0F5BFpeS7coM3iTouNLsMPpd7Fags2OdACS8XsJpmyqW2IO+9J
 BGfjj82aONMR7VuNVfGRS4tj4dv78d2jIpkimimUfV+3vTFIdoE5I5bUY7AULHqJIKYqz27oHlEz3
 5GIJpQ8NHhGeTU7/pHX0wtL0farE4FKBFP9itgJvY3wdMtU1Q7ZkaRZCiJn4/V9N6zQhLSsTLvY3F
 tQKP4n/JGU+uUfYZXg/tjKXmgymXwLEWjaXOT9mbE9xo0dsyFvFsypHo1287KyYrsELPNNpTmP1/B
 OyWtsMIA==;
Received: from [2a01:e35:2fdd:a4e1:fe91:fc89:bc43:b814] (helo=ohm.rr44.fr)
 by hall.aurel32.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <aurelien@aurel32.net>)
 id 1jqrTE-0007Ia-O0; Thu, 02 Jul 2020 07:09:12 +0200
Received: from aurel32 by ohm.rr44.fr with local (Exim 4.94)
 (envelope-from <aurelien@aurel32.net>)
 id 1jqrTE-004jIj-1N; Thu, 02 Jul 2020 07:09:12 +0200
Date: Thu, 2 Jul 2020 07:09:12 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Subject: Re: [PATCH v3 2/2] MAINTAINERS: Adjust MIPS maintainership
Message-ID: <20200702050912.GA1126181@aurel32.net>
References: <20200701182559.28841-1-aleksandar.qemu.devel@gmail.com>
 <20200701182559.28841-3-aleksandar.qemu.devel@gmail.com>
 <20200701185530.GB1090525@aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200701185530.GB1090525@aurel32.net>
User-Agent: Mutt/1.14.0 (2020-05-02)
Received-SPF: none client-ip=2001:bc8:30d7:100::1;
 envelope-from=aurelien@aurel32.net; helo=hall.aurel32.net
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_NONE=0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, aleksandar.rikalo@syrmia.com,
 Paul Burton <paulburton@kernel.org>, qemu-devel@nongnu.org,
 Huacai Chen <chenhc@lemote.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2020-07-01 20:55, Aurelien Jarno wrote:
> NACK

This NACK was because I find inacceptable to claim that you got not
answer from Paul or from myself after very few time.

Now about the content of the patch, QEMU used to be a fun ride, but it
happens that interactions are now hurtful, especially on the MIPS side.
It's time for me to leave this community and say goodbye.

So as far as removing me goes:

  Acked-by: Aurelien Jarno <aurelien@aurel32.net> 

Regards,
Aurelien

> On 2020-07-01 20:25, Aleksandar Markovic wrote:
> > Paul Burton and Aurelien Jarno removed for not being present.
> > A polite email was sent to them with question whether they
> > intend to actively participate, but there was no response.
> 
> I indeed received a polite email, but it was sent less than 12 hours ago
> (Peter Maydell was Cc:ed and can confirm). I didn't even got time to
> answer it, I am still processing my emails after coming back from paid
> work.
> 
> I don't understand this sudden need to rush things in adjusting the
> MIPS maintainership.
> 
> Regards,
> Aurelien
> 
> -- 
> Aurelien Jarno                          GPG: 4096R/1DDD8C9B
> aurelien@aurel32.net                 http://www.aurel32.net

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net

