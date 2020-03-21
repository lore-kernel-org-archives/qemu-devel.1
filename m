Return-Path: <SRS0=wc0w=5G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D40C4C4332D
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 17:39:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A08D620732
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 17:39:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A08D620732
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFi6I-0001Lu-Sk
	for qemu-devel@archiver.kernel.org; Sat, 21 Mar 2020 13:39:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56688)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jFi5B-0000Z8-O6
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 13:38:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jFi5A-0006E6-2S
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 13:38:49 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:40863)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jFi59-0006DI-5g
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 13:38:48 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1N6bsG-1jKlGk2yTO-017zjf; Sat, 21 Mar 2020 18:38:44 +0100
Subject: Re: In tree configure errors since 6116aea9
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
References: <alpine.BSF.2.22.395.2003211825370.55214@zero.eik.bme.hu>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <67cff836-d895-3a1c-1ead-13a0e14507d6@vivier.eu>
Date: Sat, 21 Mar 2020 18:38:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.22.395.2003211825370.55214@zero.eik.bme.hu>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:8QYxH+4oAzNX7i8eFucqZE/K1zCorHdZLE1TDGEgXyTK+iRaeJx
 tVxxr/TMXTZgWj8DLC0NquQmn4F8xiYtly+mznKwOTtY5WyM6iNN5RdsZ/IomALjnw4ipfZ
 H476FpMl3WKtM5UUTU6F8TVpQzMuTUkVcU01MLPAYpBOEnqsuOqp9UOs8kq6gehFhAaR6Om
 1JVFsu/xWMvtBPJx1iOuA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HdQld5RirXs=:JXKftks+lewZ4E2ic51bD5
 dj2YFK1cGYEfZ6U6nByc51PXxRUG+Q/vVAle/qSxaouSB1QTmNi+8L3VyWCSKgC4I8ly4BfDL
 FRd94rpuLlsGB/2APCIw/NGvFmIFdpPr2hxT/mPv9IiET5NKBXETYufkioEGSEW/4n89MPV1B
 KIHWpRj5MpLWWJEdgnQjTeP+YWUzR0z3+8HXQ21f1xkPuyRzkyR8Ll1KZKfS83u1seGcoH+PP
 zss+9VZ3Tw4q2hqetIG5ysaZirT/Z0u/CtdWJnorrZeYXAiavpXW/58Mjoel2rU5m+mowNJTr
 mRGA7ilGVbbWX8WKBXd3ZuEHttC2MC5VSisUmzCePu8LSjDg+GiC1+61M1NmNYflMAk7KNGWN
 qC8p9yoE2FjNHVT3UI4rE1m6epDDAwMZeV6YIM1nHnHWdhh6QY8Ey926454jaZO6mn5+2Q8lY
 Nhdh5E4+dLNCPVXu8EcUeol4bf8XV43PObT/EAWSPdCUxU/y9QBQHRcAovbfrhjDcEMHSkZ9l
 dUkMlWAm7+yHvxTPBxuKU3drohSsUHMtcbsB8pfIKfzllvzzPseXXeuz+2zCtwKQyTuZAOcQH
 5wKEdwMi7FwPkq3Eg69aOQwTEnaO65L+rE7A2a2NbfzyhqfRNCFuhQKLxpMHKGODpqJiqySaC
 ZBbxghk3wJUgFWJB7OrC5Pwds4usFcu3TtvGOGck0fNGoG3shwhzw+0q9f2ieEeje72VNrFem
 opLLPB0FcBnS4O/6qTTAGkBseJwb8y9o8qMOllmDof33+SWLiM6fikbRVWnw9jBdexVUBp39D
 NrN57oC7ajfORt8QIbeOsa+IbhTHICsvykY//iExZM3OCcprrXlCMXQyqO1BM7ZZu+jaitd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.75
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

Le 21/03/2020 à 18:29, BALATON Zoltan a écrit :
> Hello,
> 
> Since 6116aea99, or actually 4d6a835d (linux-user: introduce parameters
> to generate syscall_nr.h) but only next commit starts to enable it I get
> these errors when running configure in source tree:
> 
> grep: ./.gitlab-ci.d: Is a directory
> grep: ./scripts/qemu-guest-agent/fsfreeze-hook.d: Is a directory
> 
> for each entry in that loop over arches. Could this be silenced?

I didn't see that because I always do an out-of-tree build.

Could you try this?

--- a/configure
+++ b/configure
@@ -1911,6 +1911,7 @@ for arch in alpha hppa m68k xtensa sh4 microblaze
arm ppc s390x sparc sparc64 \
     rm -f "${source_path}/linux-user/${arch}/syscall_nr.h"
     # remove the dependency files
     find . -name "*.d" \
+           -type f \
            -exec grep -q
"${source_path}/linux-user/${arch}/syscall_nr.h" {} \; \
            -exec rm {} \;
 done


Thanks,
Laurent

