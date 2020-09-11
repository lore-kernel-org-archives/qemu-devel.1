Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF333C43461
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 17:34:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEF2D221E7
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 17:34:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="CPrx2pxK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEF2D221E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGmw6-0000NR-MP
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 13:34:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45962)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kGmvY-0008NS-I8
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 13:33:36 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:36919)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kGmvW-0001U4-QQ
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 13:33:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=xeUe8KjjdOtPuokBdtou/svC2+Jk5JkZdOa8PyAKLxE=; b=CPrx2pxKri/bIluOo1l7QU6p7J
 FKa3NccSFLLtx8RTl6qIp4frABESarOqq/qf3K3fXU7+4MGUaGhff1TGwLZs6hfVu9AthdKc+VBSa
 +t7AcQ+yQ07CD1m4f6134UPDi07AoKMIGlHxT62E6BXta7+dfYmHNvryooctOeISu6OCI65OZ1EQF
 GRmpJz33grO870UBeVN6WNIQxnDTEZ0V7sOJO+1mobkyhydb4d5+F+gzBOEa0lJVmUE1eqAONEFSW
 mBDrCII96x14WBBNDliIahMhzUSgfavt1RbgK0rwRz3Ywm5yT+RZM4bmagAq0Xl65JASXFOqWhLMn
 60STFkNw==;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Daniel =?ISO-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Liviu Ionescu <ilg@livius.net>, G 3 <programmingkidx@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Richard Henderson <rth@twiddle.net>
Subject: Re: [RFC] QEMU as Xcode project on macOS
Date: Fri, 11 Sep 2020 19:33:28 +0200
Message-ID: <2921188.XSTMq4hUFX@silver>
In-Reply-To: <0b0b02e9-7925-b112-4056-c17e067a5278@redhat.com>
References: <2764135.D4k31Gy3CM@silver> <5694401.8H58FrkmUv@silver>
 <0b0b02e9-7925-b112-4056-c17e067a5278@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=91.194.90.13; envelope-from=qemu_oss@crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/11 13:33:31
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

On Freitag, 11. September 2020 19:19:05 CEST Paolo Bonzini wrote:
> On 10/09/20 16:40, Christian Schoenebeck wrote:
> > If it turns out to work fine, then maybe I just push a branch of QEMU for
> > Mac developers somewhere for a while, as I think it would lower the entry
> > level for new developers on Mac tremendously. Apparently there is still
> > more changes with Meson ahead anyway (getting rid of the Makefiles or
> > whatever else is planned). So we'll see ...
> 
> If there are no submodule dependencies (capstone/libfdt/slirp),
> effectively you can already behave as if the Makefiles did not exist and
> build QEMU with ninja and "meson test".  So you could build your scripts
> from there.
> 
> Paolo

Good to know, thanks!

Best regards,
Christian Schoenebeck



