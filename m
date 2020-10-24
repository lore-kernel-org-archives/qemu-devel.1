Return-Path: <SRS0=SOuJ=D7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7AEDC2D0A3
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 10:58:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0907824248
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 10:58:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="jSwII/pI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0907824248
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWHFd-0007bl-VW
	for qemu-devel@archiver.kernel.org; Sat, 24 Oct 2020 06:58:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35182)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kWHEo-0007BI-PZ
 for qemu-devel@nongnu.org; Sat, 24 Oct 2020 06:57:31 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:50821)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kWHEn-0004zU-1R
 for qemu-devel@nongnu.org; Sat, 24 Oct 2020 06:57:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=gC8Ex5UlfQMZaeYKNGLV2dnbPWlh5aGiZIOv66GCSbQ=; b=jSwII/pIZBKhs+yImdc3A8500k
 YVu4E/C/2efkHt5XcY30dq3sMtO/rX9HJSR+J8Giwyq2ABQ0nNla7kgwNOSoG1AP2R4YSXxUjunK0
 n8sEQoAo6wOYqORpka0wEAnyXs2rDbaO4522lnP8EPqmJvMj+l+cRkSLKYYeb19vUBIpUj0i9EEjd
 OIuCKK35M7H6omPOMZrQ9MhmGGClxSAtsVhdHAgoRMDkO025QLOaDXwyociJF2K4/xHpeez56nv2G
 aMX/NbAlS1kSS1P2hjFJ3InYvKcTb9ncmCt7QJc8sTeWFIcrASxNU8ti4R6tmePukoVXWioav3RGD
 IiAFZLwg==;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?ISO-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
 Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH v4 06/12] tests/qtest/qos-test: dump environment variables
 if verbose
Date: Sat, 24 Oct 2020 12:57:24 +0200
Message-ID: <2424005.3xPeN8Jrzi@silver>
In-Reply-To: <348b9b3c-33a5-1503-5db2-9956c0a2f9eb@redhat.com>
References: <cover.1602182956.git.qemu_oss@crudebyte.com>
 <a35f491b087eafd4f07a14094ef3db1cc94581d9.1602182956.git.qemu_oss@crudebyte.com>
 <348b9b3c-33a5-1503-5db2-9956c0a2f9eb@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=91.194.90.13; envelope-from=qemu_oss@crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/24 06:39:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Samstag, 24. Oktober 2020 07:56:10 CEST Thomas Huth wrote:
> On 08/10/2020 20.34, Christian Schoenebeck wrote:
> > If qtests are run in verbose mode (i.e. if --verbose CL argument
> > was provided) then print all environment variables to stdout
> > before running the individual tests.
> 
> Why? ... you should provide some rationale in the patch description here, at
> least to me this is not obvious why it is needed / desired.
> 
>  Thomas

In my particular case I wanted to know whether there is already some config 
vector for 'please use this test directory for file tests'. As I didn't find 
one in any API, I also looked for environment variables to be sure. Especially 
as there are a bunch of qtest related environment variables already.

In general though it is common nowadays, at least being able to output all 
config vectors in a build chain, especially if it is required to investigate 
build- and test-issues on foreign/remote machines, which includes environment 
variables.

Staying in the context of writing test cases: there are a bunch of other use 
cases that would come to my mind from the PoV of a test case author:
"Is there an option for short vs. long tests?", "Is there a desired size 
limitation for large file tests?", "Is there a deadline for the runtime of 
tests?", ...

Best regards,
Christian Schoenebeck



