Return-Path: <SRS0=rHaa=U4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63FD6C4321A
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Jun 2019 11:04:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13E74214AF
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Jun 2019 11:04:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="CjOH5Wt2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13E74214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhB9Q-00026e-T4
	for qemu-devel@archiver.kernel.org; Sat, 29 Jun 2019 07:04:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51898)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <qemu_oss@crudebyte.com>) id 1hhB75-0001DD-6W
 for qemu-devel@nongnu.org; Sat, 29 Jun 2019 07:01:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <qemu_oss@crudebyte.com>) id 1hhB73-0001li-0J
 for qemu-devel@nongnu.org; Sat, 29 Jun 2019 07:01:47 -0400
Received: from kylie.crudebyte.com ([5.189.157.229]:53901)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <qemu_oss@crudebyte.com>)
 id 1hhB70-0001PO-Ty
 for qemu-devel@nongnu.org; Sat, 29 Jun 2019 07:01:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2Cno7n/o/WKhIeosje8lQP2VTN8SeTOI5EvYkHsyk5k=; b=CjOH5Wt2FIXgEnkf5A8hxL8mD5
 zENYWIXt/cOwnaE8YDC6A9C43Yr3DZO8/49V9ylMsZ3PILlLtADhrxDnVqBcUNAqUvdCEbtAn9lXF
 1urNhuunemzXtU4/po6ynE5nKcfX8Im/hpbsPoZ2E3htP27AA8ug3XwTXNUD0b5JFqQQQlCYDnenX
 ssp0puzQJ/oxvRLIwWlwfnEob68lxSj+RA2vqWOdR+ca7T1FU914/Wyieninp9UM5VCgs366t+ZtG
 yFGCXpkbDQT7L8W8H4D2MZBnncgvLQC81n7DwTWti08ogOANxMDi5ea+YyvQjlTUuMbRhSM/ywDG9
 rjRb93W+Iz1OddcIIqFKUqFnO579oVLdr6QWFMdfNmycV9a+YYVTDxq3lmZEjp1AUsdYrIdW/ryIy
 hJxfIH4FsbrPe+bZkajXiwKAqc/BHthj7YU/TFsf03uU7FhcaUziI6FS5zYQLMAUHNS6TFRC1vQkM
 bRzGXniqIBduZNBLq9ec6T6FEbkp1JPKc0OHBe1fwnkKm71KIPz30HACI/CdQdfAWk7X1ecJbqead
 YaPOMUcbbvOcM5lvGNmAJSMJERVXv9np/v3+KZvLhhzguNZblQH2iT2KLoRRlplgNYmllUuQosHvX
 NOjEQDRDuwBAy9kWQ73nLOJjtQO0ni1YrppqvCPbY=;
To: qemu-devel@nongnu.org, Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Sat, 29 Jun 2019 13:01:06 +0200
Message-ID: <25192199.NfpnE9g0sd@silver>
In-Reply-To: <3262111.WzMCRFa3dF@silver>
References: <cover.1561575449.git.qemu_oss@crudebyte.com>
 <20190628135015.2d1618cf@bahia.lan> <3262111.WzMCRFa3dF@silver>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.189.157.229
Subject: Re: [Qemu-devel] [PATCH v4 5/5] 9p: Use variable length suffixes
 for inode remapping
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
From: Christian Schoenebeck via Qemu-devel <qemu-devel@nongnu.org>
Reply-To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc: Daniel =?ISO-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Greg Kurz <groug@kaod.org>, Antonios Motakis <antonios.motakis@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Freitag, 28. Juni 2019 16:56:15 CEST Christian Schoenebeck via Qemu-devel 
> > > + */
> > > +#define EXP_GOLOMB_K    0
> > > +
> > > +# if !EXP_GOLOMB_K
> > > +
> > > +/** @brief Exponential Golomb algorithm limited to the case k=0.
> > > + *
> > 
> > This doesn't really help to have a special implementation for k=0. The
> > resulting function is nearly identical to the general case. It is likely
> > that the compiler can optimize it and generate the same code.
> 
> I don't think the compiler's optimizer would really drop all the
> instructions automatically of the generalized variant of that particular
> function. Does it matter in practice? No, I actually just provided that
> optimized variant for the special case k=0 because I think k=0 will be the
> default value for that parameter and because you were already picky about a
> simple
> 
> 	if (pdu->s->dev_id == 0)
> 
> to be optimized. In practice users won't feel the runtime difference either
> one of the two optimization scenarios.

I just checked my assmption made here with a simple C test unit:

	// Use manually optimized function for case k=0.
	VariLenAffix implK0(uint64_t n) {
	    return expGolombEncodeK0(n);
	}

	// Rely on compiler to optimize generalized function for k=0
	VariLenAffix implGenK(uint64_t n) {
	    return expGolombEncode(n, 0);
	}

And :   gcc -S -O3 -ffast-math k.c

Like expected the generated 2 functions are almost identical, except that the 
manually optimized variant saves the following 3 instructions:

	movl	$0, %eax
	...
	testl	%edx, %edx
	cmovns	%edx, %eax

But like I said, it is a tiny difference of course. Not really relevant in 
practice.

Best regards,
Christian Schoenebeck

