Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89034C282DE
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 06:36:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C5A42083E
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 06:36:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C5A42083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36372 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYPWv-0004w1-3K
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 02:36:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hYPVz-0004UM-Rc
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 02:35:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hYPVy-00037G-17
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 02:35:15 -0400
Received: from mail.ilande.co.uk ([46.43.2.167]:55480
	helo=mail.default.ilande.uk0.bigv.io)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1hYPVu-00030G-Eh; Wed, 05 Jun 2019 02:35:10 -0400
Received: from host81-158-188-206.range81-158.btcentralplus.com
	([81.158.188.206] helo=[192.168.1.65])
	by mail.default.ilande.uk0.bigv.io with esmtpsa
	(TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.89)
	(envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1hYPSo-00038H-BG; Wed, 05 Jun 2019 07:31:58 +0100
To: Laurent Vivier <lvivier@redhat.com>,
	David Gibson <david@gibson.dropbear.id.au>, peter.maydell@linaro.org
References: <20190108224600.23125-1-david@gibson.dropbear.id.au>
	<20190108224600.23125-10-david@gibson.dropbear.id.au>
	<759cdab3-6cf9-bb83-54f2-12d60063b15c@redhat.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Openpgp: preference=signencrypt
Autocrypt: addr=mark.cave-ayland@ilande.co.uk; keydata=
	mQENBFQJuzwBCADAYvxrwUh1p/PvUlNFwKosVtVHHplgWi5p29t58QlOUkceZG0DBYSNqk93
	3JzBTbtd4JfFcSupo6MNNOrCzdCbCjZ64ik8ycaUOSzK2tKbeQLEXzXoaDL1Y7vuVO7nL9bG
	E5Ru3wkhCFc7SkoypIoAUqz8EtiB6T89/D9TDEyjdXUacc53R5gu8wEWiMg5MQQuGwzbQy9n
	PFI+mXC7AaEUqBVc2lBQVpAYXkN0EyqNNT12UfDLdxaxaFpUAE2pCa2LTyo5vn5hEW+i3VdN
	PkmjyPvL6DdY03fvC01PyY8zaw+UI94QqjlrDisHpUH40IUPpC/NB0LwzL2aQOMkzT2NABEB
	AAG0ME1hcmsgQ2F2ZS1BeWxhbmQgPG1hcmsuY2F2ZS1heWxhbmRAaWxhbmRlLmNvLnVrPokB
	OAQTAQIAIgUCVAm7PAIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQW8LFb64PMh9f
	NAgAuc3ObOEY8NbZko72AGrg2tWKdybcMVITxmcor4hb9155o/OWcA4IDbeATR6cfiDL/oxU
	mcmtXVgPqOwtW3NYAKr5g/FrZZ3uluQ2mtNYAyTFeALy8YF7N3yhs7LOcpbFP7tEbkSzoXNG
	z8iYMiYtKwttt40WaheWuRs0ZOLbs6yoczZBDhna3Nj0LA3GpeJKlaV03O4umjKJgACP1c/q
	T2Pkg+FCBHHFP454+waqojHp4OCBo6HyK+8I4wJRa9Z0EFqXIu8lTDYoggeX0Xd6bWeCFHK3
	DhD0/Xi/kegSW33unsp8oVcM4kcFxTkpBgj39dB4KwAUznhTJR0zUHf63LkBDQRUCbs8AQgA
	y7kyevA4bpetM/EjtuqQX4U05MBhEz/2SFkX6IaGtTG2NNw5wbcAfhOIuNNBYbw6ExuaJ3um
	2uLseHnudmvN4VSJ5Hfbd8rhqoMmmO71szgT/ZD9MEe2KHzBdmhmhxJdp+zQNivy215j6H27
	14mbC2dia7ktwP1rxPIX1OOfQwPuqlkmYPuVwZP19S4EYnCELOrnJ0m56tZLn5Zj+1jZX9Co
	YbNLMa28qsktYJ4oU4jtn6V79H+/zpERZAHmH40IRXdR3hA+Ye7iC/ZpWzT2VSDlPbGY9Yja
	Sp7w2347L5G+LLbAfaVoejHlfy/msPeehUcuKjAdBLoEhSPYzzdvEQARAQABiQEfBBgBAgAJ
	BQJUCbs8AhsMAAoJEFvCxW+uDzIfabYIAJXmBepHJpvCPiMNEQJNJ2ZSzSjhic84LTMWMbJ+
	opQgr5cb8SPQyyb508fc8b4uD8ejlF/cdbbBNktp3BXsHlO5BrmcABgxSP8HYYNsX0n9kERv
	NMToU0oiBuAaX7O/0K9+BW+3+PGMwiu5ml0cwDqljxfVN0dUBZnQ8kZpLsY+WDrIHmQWjtH+
	Ir6VauZs5Gp25XLrL6bh/SL8aK0BX6y79m5nhfKI1/6qtzHAjtMAjqy8ChPvOqVVVqmGUzFg
	KPsrrIoklWcYHXPyMLj9afispPVR8e0tMKvxzFBWzrWX1mzljbBlnV2n8BIwVXWNbgwpHSsj
	imgcU9TTGC5qd9g=
Message-ID: <6d1c8b12-0e27-b3f3-9e0e-ad68c5572ed7@ilande.co.uk>
Date: Wed, 5 Jun 2019 07:32:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <759cdab3-6cf9-bb83-54f2-12d60063b15c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 81.158.188.206
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.43.2.167
Subject: Re: [Qemu-devel] [Qemu-ppc] [PULL 09/29] target/ppc: introduce
 get_cpu_vsr{l, h}() and set_cpu_vsr{l, h}() helpers for VSR register access
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-ppc@nongnu.org, clg@kaod.org,
	Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org, groug@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 04/06/2019 22:23, Laurent Vivier wrote:

> This patch breaks something in the libcrypto.
> 
> I've been able to reproduce the problem with Fedora 29:
> 
> dnf install 'dnf-command(download)'
> dnf download --source coreutils-single
> rpm --verify coreutils-8.30-7.fc29.src.rpm
> error: coreutils-8.30-7.fc29.src.rpm: Header V3 RSA/SHA256 Signature, key ID 429476b4: BAD
> error: coreutils-8.30-7.fc29.src.rpm: Header SHA256 digest: BAD (Expected fa042669e74ac435bd5defaa8c2e4efe779a0329c24f2b6377591c53b38aa280 != d6e22527412fafc4aa12882432d0d157e5427097710eeb2d5fce8fbc52a47be6)
> error: coreutils-8.30-7.fc29.src.rpm: not an rpm package (or package manifest)
> 
> See https://bugzilla.redhat.com/show_bug.cgi?id=1715017
> 
> I've tested with origin/master (47fbad45d47af8af784bb12a5719489edcd89b4c) and all the 
> merged fixes for this patch don't fix this problem.
> 
> We should be able to reproduce it on Debian Sid too: it breaks ssh (this is one of the rare binaries using libcrypto on debian).
> 
> I've been able to reproduce it with qemu linux-user if I enable PPC_FEATURE2_VEC_CRYPTO in linux-user/elfload.c
> (git clone -b linux-user-ppc64-hwcap git@github.com:vivier/qemu.git).
> 
> To ease debugging, you can install a Fedora 29 chroot with something like:
> 
> curl -o container.tar.xz http://download-ib01.fedoraproject.org/pub/fedora-secondary/releases/29/Container/ppc64le/images/Fedora-Container-Base-29-1.2.ppc64le.tar.xz
> tar Jxvf container.tar.xz '*/layer.tar'
> mkdir -p chroot/ppc64le/29
> cd chroot/ppc64le/29
> tar xf $OLDPWD/*/layer.tar
> cd -
> cp ~/qemu/ppc64le-linux-user/qemu-ppc64le chroot/ppc64le/29/
> [use "configure --target-list=ppc64le-linux-user --static --disable-tools" and don't forget to run scripts/qemu-binfmt-conf.sh]

One of Anton's VSX patches hasn't landed in master yet and is still queued in
ppc-for-4.1: "target/ppc: Fix lxvw4x, lxvh8x and lxvb16x".

Can you try David's ppc-for-4.1 branch first and let me know if that solves the
issue? If not, I'll take a look at it later in the week when I have a bit more time.


ATB,

Mark.

