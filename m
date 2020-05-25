Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B9F0C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 11:04:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C57EC207CB
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 11:04:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SPIdQw7E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C57EC207CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdAu1-0006gB-0k
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 07:04:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56134)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jdAsu-0005h2-JB
 for qemu-devel@nongnu.org; Mon, 25 May 2020 07:03:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22437
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jdAst-0005sg-I9
 for qemu-devel@nongnu.org; Mon, 25 May 2020 07:03:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590404585;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R6aqatswcZgMVTag2iZhLDJk0xwe2ske6jemKPVaR44=;
 b=SPIdQw7EAz/LNTF2pL4xO/KvEVka7hUYq1+zHVeCt2UU/O0huc1k3xBI9/SjBKa9y5kDw3
 x+zIk9LJtStFg4FQdRaHQnDmy5sPFpAPvlUfWnnCB0FSHX2LaLbRW/EVofKjCBQkq4JNPw
 3dLiFyk2knXx9nJb7FZQ1jxaYtLsNqA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-154-_3pz70_HOiGhggznXkkwZg-1; Mon, 25 May 2020 07:03:03 -0400
X-MC-Unique: _3pz70_HOiGhggznXkkwZg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 923AA461;
 Mon, 25 May 2020 11:03:02 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-50.ams2.redhat.com
 [10.36.113.50])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0799F6EDAB;
 Mon, 25 May 2020 11:02:57 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id CF3C11753B; Mon, 25 May 2020 13:02:54 +0200 (CEST)
Date: Mon, 25 May 2020 13:02:54 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v3 01/22] microvm: name qboot binary qboot.bin
Message-ID: <20200525110254.ikq6anobblj4uo5a@sirius.home.kraxel.org>
References: <20200520132003.9492-1-kraxel@redhat.com>
 <20200520132003.9492-2-kraxel@redhat.com>
 <2a9e8f07-a1eb-9c3b-5070-51d5a87d76d5@redhat.com>
MIME-Version: 1.0
In-Reply-To: <2a9e8f07-a1eb-9c3b-5070-51d5a87d76d5@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/25 01:44:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, May 20, 2020 at 03:25:53PM +0200, Philippe Mathieu-Daudé wrote:
> Hi Gerd,
> 
> On 5/20/20 3:19 PM, Gerd Hoffmann wrote:
> > qboot isn't a bios and shouldnt be named that way.
> 
> Still it resides in a directory named pc-bios =)

Yep, that should be named "firmware" but changing that is beyond the
scope of this patch ;)

> It is used later in x86_bios_rom_init() as:
> 
>     bios = g_malloc(sizeof(*bios));
>     memory_region_init_ram(bios, NULL, "pc.bios", bios_size, &error_fatal);
>     if (!isapc_ram_fw) {
>         memory_region_set_readonly(bios, true);
>     }
>     ret = rom_add_file_fixed(bios_name, (uint32_t)(-bios_size), -1);
>     if (ret != 0) {
>     bios_error:
>         fprintf(stderr, "qemu: could not load PC BIOS '%s'\n", bios_name);
>         exit(1);
>     }
>     g_free(filename);
> 
> Many 'bios' occurrences.
> 
> Should it be called 'qboot.rom' instead?

I don't care much, I only want bios*.bin for seabios which actually is a
complete bios implementation ...

take care,
  Gerd


