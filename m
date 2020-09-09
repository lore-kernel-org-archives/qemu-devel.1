Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E37F1C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 19:27:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A6CD21D43
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 19:27:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="m6RIlgbU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A6CD21D43
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG5kr-0002iq-1B
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 15:27:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40150)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kG5kC-0002EU-EB
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 15:27:00 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:36757)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kG5kA-0005Tx-DV
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 15:27:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=EmHKEnRGDcDVKMwjlyhFaxHm3WqqXi0Bq250lBTchD8=; b=m6RIlgbUD3FytyH6vVTMLmT0G2
 hxf/W28QMItZaYWThw1oejP8wGYY1N+uhj5rEkmS7knWZQ07R1y6NGZRpmLOSULMw5QeCp59tWPe6
 ai791lOWbXVfgKwxZX1NHxjgtRfokSjebZNC+oS5nqR5ECpGjCJwBpSjcUas5MSyy/HST7YZ4n8e6
 r10nDoHVba5l6U+BBZC5erWIb32OMVynm2HE2hkQNICiJTCuo287FkFTObOGH5RPgzcsnmqYRQFOx
 Zaht9RRJrDsks48e3otIMq3Om8+iOQCjHCl2HPUs6ubLqdonEMQyT9oOJNK0L6DhsnpRQQABrHZ+Z
 PpmqEBeA==;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Liviu Ionescu <ilg@livius.net>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Daniel =?ISO-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 G 3 <programmingkidx@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Subject: Re: [RFC] QEMU as Xcode project on macOS
Date: Wed, 09 Sep 2020 21:26:54 +0200
Message-ID: <1998444.vInk89c8k9@silver>
In-Reply-To: <508327A7-58A6-42FC-8BDC-F1D4FE1F43C6@livius.net>
References: <2764135.D4k31Gy3CM@silver> <1695914.5EixHECA2G@silver>
 <508327A7-58A6-42FC-8BDC-F1D4FE1F43C6@livius.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=91.194.90.13; envelope-from=qemu_oss@crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 13:32:25
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

On Mittwoch, 9. September 2020 21:03:32 CEST Liviu Ionescu wrote:
> > On 9 Sep 2020, at 21:56, Christian Schoenebeck <qemu_oss@crudebyte.com>
> > wrote:
> > 
> > ... However you would
> > still be opted out from (4.) all those Xcode IDE features that make
> > development such efficient.
> 
> Could you elaborate?
> 
> I thought that a standalone meson can be used with any environment, it just
> reduces the dependency on Python and possibly other system libraries,
> otherwise it provides the same functionality. You unpack the archive
> anywhere, place that location in the path and use it as usual.
> 
> Why would it be opted out for Xcode?

You would still not have a .xcodeproj file, which is a separate thing, as 
that's the only binding point for really making use of Xcode in an efficient 
way. Otherwise it does not have any knowledge about which source files belong 
to the project, what are the compiler flags, what preprocessor statements have 
to be applied and in which order. So you could still open source files in 
Xcode of course, but it would just be an ordinary plain text editor.

So this is about having or not having features like: auto completion, 
refactoring, one-click auto fixes of trivial issues, click to jump to 
definition/declaration (which might be in an external lib), built-in debugger, 
graphical static analysis, graphical sanitizers and much more ...

Best regards,
Christian Schoenebeck



