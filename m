Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7789C4363C
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 15:49:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08CB121897
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 15:49:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="PabK6MD4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08CB121897
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQYAM-0004gw-Ox
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 11:49:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55580)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kQXzz-0005P0-3q
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 11:38:32 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:54911)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kQXzv-0000iH-1Z
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 11:38:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=Ex5exmGyPALsm1eGtkacdZmeJMniTvLYx8VMxu3dHX4=; b=PabK6MD4647njOjRDenJWkp1ia
 EoVEW+G7EIB0REIMOPbLeLYrehcwGS4oUcj4USRnHNIYmomcmLnPgZZE4z4E6wDqhpHbGwJ2z0qn4
 hiPyVTR+jEejXBOCzfATJgsxYACXLtF9nzE9A+XDHe78It6FMtR4ad3Aetq3s+u4vweryJVQeYmpD
 wHLANe1lU4LbqixjuWglPJQ871tlXICdwSgIN9zOCm1avn0KdXq+UPa4XUF4NBHj9gmM/lq3oTNGm
 CaLHb5LMU0ozE6ETa1ZwBTeUGlr+48BNr53iXLIXGKorggCiRA6QTPQW/U0ZoqPv7U4yAjQa8LiVW
 E/Nfk4gg==;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 berrange@redhat.com, Thomas Huth <thuth@redhat.com>,
 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
 Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH v3 05/11] tests/qtest/qos-test: dump environment variables
 if verbose
Date: Thu, 08 Oct 2020 17:38:23 +0200
Message-ID: <25035671.SGzBP4Y90E@silver>
In-Reply-To: <d7603332-3bad-6fd1-0140-79bdec9fa4f1@redhat.com>
References: <cover.1601655308.git.qemu_oss@crudebyte.com>
 <2996442.YqjEYQNFnd@silver> <d7603332-3bad-6fd1-0140-79bdec9fa4f1@redhat.com>
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

On Donnerstag, 8. Oktober 2020 15:52:08 CEST Paolo Bonzini wrote:
> On 08/10/20 15:42, Christian Schoenebeck wrote:
> >> I'm okay I guess with using g_test_message on 2.62 or newer, and
> >> assuming people don't use --tap --verbose on older versions.
> > 
> > Simpler solution: just appending '#' character in front of each printf()
> > line, that would be both fine for TAP and regular output:
> > http://testanything.org/tap-specification.html#diagnostics
> 
> I'm not sure how it would be simpler than a
> 
> #if !GLIB_CHECK_VERSION(2, 62, 0)
> #define qemu_test_message printf
> #else
> #define qemu_test_message g_test_message
> #endif
> 
> but you choose.
> 
> Paolo

Simple yes, but it would not fix the cluttered output problem of 
g_test_message().

So I'll go with prepending '#' for now, and if one day there will be a public 
glib function to check for TAP mode, it can easily be adjusted.

Best regards,
Christian Schoenebeck



