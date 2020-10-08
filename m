Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F296AC4363A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 13:43:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20E0C20782
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 13:43:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="MTCb7Sui"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20E0C20782
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQWCm-0005AC-Rz
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 09:43:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56692)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kQWCD-0004jP-KL
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 09:43:01 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:44827)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kQWCA-0008Qf-L4
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 09:43:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=f7qogRxNdHqLceUz0t/A92FyvSat/2/wZ/PthPITHDw=; b=MTCb7Suid/Mg8ygVA9nQJdH0wV
 eNpbqpNVn0jtc/TRYEuvZ6vo4IOGzicizRb2WaSv10GHmUit0PTTYWTs1GogZtf2yswkELgj27xBA
 tCmAGAy7OFINVlrU4zf0DawgpThYBtdgJ2bsLIKDH/5ovIyeiG6GTeEHcCGLorWNJ6/BtDSz7KqZ/
 QFqH72lvz3/H4wt7hXEpMTlENLNxrwZFuOVrSkKU86JQtzs9D0qR1i1wv1HJvN81NCNoVs7BaO1IO
 4Lcea5nd6K7habKhfwOWpCTAjY30GwivOz0ZdeWcSrElEpfpzT5m6TpVRo/j2nlpswJBtV06tbF/s
 FN1pQ0HA==;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
 Thomas Huth <thuth@redhat.com>, berrange@redhat.com,
 Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH v3 05/11] tests/qtest/qos-test: dump environment variables
 if verbose
Date: Thu, 08 Oct 2020 15:42:55 +0200
Message-ID: <2996442.YqjEYQNFnd@silver>
In-Reply-To: <6d6247ef-94f3-3ee3-b0ad-28e870d8dc05@redhat.com>
References: <cover.1601655308.git.qemu_oss@crudebyte.com>
 <1836979.gfKjIU19vi@silver> <6d6247ef-94f3-3ee3-b0ad-28e870d8dc05@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=91.194.90.13; envelope-from=qemu_oss@crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/08 08:26:30
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

On Donnerstag, 8. Oktober 2020 15:21:54 CEST Paolo Bonzini wrote:
> On 08/10/20 15:09, Christian Schoenebeck wrote:
> >> But doesn't this (and patch 6 as well) break TAP output?  Using
> >> g_test_message + g_test_verbose would be the best of both worlds.
> > 
> > If there was TAP output then yes, patches 4, 5, 6 would probably break it.
> > 
> > How/when is TAP output enabled? I don't see any TAP output by default.
> 
> With "--tap", but with glib 2.62 it will be enabled by default.  For
> example on Fedora 32:
> 
>   $ ./test-mul64
>   # random seed: R02S3efb20d48a41e1897cb761e02393c11b
>   1..2
>   # Start of host-utils tests
>   ok 1 /host-utils/mulu64
>   ok 2 /host-utils/muls64
>   # End of host-utils tests
> 
> I'm okay I guess with using g_test_message on 2.62 or newer, and
> assuming people don't use --tap --verbose on older versions.

Simpler solution: just appending '#' character in front of each printf() line, 
that would be both fine for TAP and regular output:
http://testanything.org/tap-specification.html#diagnostics

Unfortunately 'test_tap_log' is a private variable in glib (gtestutils.c), 
otherwise I could have made that conditionally. There is no getter function in 
the glib API for this (TAP on/off) variable.

I could check the CL for --verbose somewhere, but I think that's probably 
overkill.

Best regards,
Christian Schoenebeck



