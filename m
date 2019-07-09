Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C667C73C46
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 13:03:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42B5720861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 13:03:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42B5720861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkpm1-0000j9-Fy
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 09:03:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37572)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <laurent@vivier.eu>) id 1hkpjC-00089a-Bl
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 09:00:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1hkpjB-0004Hc-AO
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 09:00:14 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:55213)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hkpjA-0004FO-Vs
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 09:00:13 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue107 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1Mgf8s-1iPOfW3hOu-00h3hs for <qemu-devel@nongnu.org>; Tue, 09 Jul 2019
 15:00:11 +0200
To: qemu-devel@nongnu.org
References: <156262578461.2222.11301272429426949561.malonedeb@wampee.canonical.com>
 <156267456566.20622.9324953237843875366.malone@gac.canonical.com>
From: Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <0aca7712-b18f-6fbf-c8f0-b798070dfb5b@vivier.eu>
Date: Tue, 9 Jul 2019 15:00:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <156267456566.20622.9324953237843875366.malone@gac.canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:AnFfR38nJRZKAri/ehWKoY3LmWlxzRrOI2MjdZRdVRCIm+NSua6
 TE0eYUyP03lTcrXnbL1WNxWe9jc9Pdvsg91KzeKNAZRtm8e84gM1Er9lOe2Hmq9/BOb9oci
 IGz2E9l8HIELOKSEqQPLTNvWZ/yKtM7bG41BsZSAYocjl5rUi/1HEtLuuJTXKT/TIBcLRYe
 i511a2bfZKoRTfp6m5Dgg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MJX8y1BrBuk=:+n/F+7xXaeo5DI8sCYAr6K
 T/5oOHcjH3qghRFxvQRYxMMP/wGJRqTYZaydjOPgwIL1e80rKAgVoiAWqhuQULUEx/B/xxKS9
 dOfStsOAJ9heP91OuLm20cmQX13+gDy7lrKoAWq3E0nwPd+zDI9frwvJCJoza/+k1dyHe4hw7
 K7aqAMGGH0v5BCLVzh3YV288VNs+SCy6SoeWYc0lmfWxuJZpxIpgS16QbISStas+NtTxVLJte
 4tCexL2XA1kb+1Br5F2Wfdr5jo4S6W9mQr8slmxqVgHcSvnLEZJnlRNDPNCZYyFULETfOcTn2
 zNaPClOlVOc5cCySORcHomA9wJQOEbRhr3CYzStGRR0FSDv+8AkMQXQptubBwKdviaAzWXo8W
 AC0oKYwAc8u0R19Wt4jDNbyCKbYfbhoWGI7uAEoTUihAZGTB2QeFacIMKbZmhaREvs0vqFbmD
 jZekzDWrv4PECLObRSXAy8nf4udm1DKHKUgt5+JnvewRpWSYcXuSGU32jDo9QAYezqj7UH9Ki
 KNFK45oi0vwZQxXBTYHN1G50jspEXH3qGkxfKLgHo5a027ddJ8mCD6h1uf8XptrhpmtcNJcH3
 pkf7ihh8DSMktU/Cy4xgSfr85MhSOD5dx2/m+HSL6OubC7VSP/4Fsj99O/uXU6oOoNholGoZF
 0voxQpNOCYuG/lWV8hak6CSyEyh61jUTDFY3XaYXhi7nTbdgDstc9F0TaPf4DmCxZssHYrtjr
 5G5rrjA1ynDxTsYW6W5yiPydd3CtmytDKO8jzgsEpIB07Qt2x3ACiij3uQ0=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.75
Subject: Re: [Qemu-devel] [Bug 1835839] Re: qemu-user: $0 incorrectly always
 reports absolute path
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

Le 09/07/2019 à 14:16, Peter Maydell a écrit :
> Is the proposed patch backwards compatible (ie "old QEMU binary works
> with newer binfmt-misc registration" and "new QEMU binary works with
> older binfmt-misc registration") ? Because binfmt-misc stuff is whole-
> system but QEMU binaries are per-chroot, this kind of thing is awkward
> to change if we don't have back-compat (and typically the kernel
> semantics for these things often don't allow back-compat or any kind of
> migration-path to the new better setup :-( )
> 

If you don't enable the preserve-arg[0] flag, old and new QEMU will work.

If you enable the flag, only new QEMU with -0/QEMU_ARGV0 will work.

The best solution would be to force preserve-arg[0] with open-binary
flag and rely on AT_FDEXEC to detect the binfmt-misc environment, but
this breaks compatibility with existing environment and old QEMU.

Regarding the "binfmt-misc stuff is whole-system" problem, I've proposed
months ago a kernel based solution [1] to have a configuration per
namespace (chroot), but no one seems really interested (I think
maintainer is afraid by potential security issues).

[1] ns: introduce binfmt_misc namespace
    https://patchwork.kernel.org/cover/10634807/

