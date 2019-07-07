Return-Path: <SRS0=qwNR=VE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00715C5B578
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jul 2019 01:20:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFA3120836
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jul 2019 01:20:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X7ShMRw9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFA3120836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjvqk-0006CT-N5
	for qemu-devel@archiver.kernel.org; Sat, 06 Jul 2019 21:20:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60122)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jidong.xiao@gmail.com>) id 1hjvq0-0005kX-F8
 for qemu-devel@nongnu.org; Sat, 06 Jul 2019 21:19:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jidong.xiao@gmail.com>) id 1hjvpy-0002ux-VA
 for qemu-devel@nongnu.org; Sat, 06 Jul 2019 21:19:32 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:41509)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jidong.xiao@gmail.com>)
 id 1hjvpy-0002s5-L6
 for qemu-devel@nongnu.org; Sat, 06 Jul 2019 21:19:30 -0400
Received: by mail-wr1-x42e.google.com with SMTP id c2so13379775wrm.8
 for <qemu-devel@nongnu.org>; Sat, 06 Jul 2019 18:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=mHGaMIkIHgR5W5GBE4MbBOlXpjzscLPMPDa9lxC5WZ0=;
 b=X7ShMRw9E11Qqa0KY7/Efwg1OYn5A5SFM9xhQ4zfzva+zdqj49Ma7wcqV7mIhLmZ9R
 suQMn3NgaY8SVs2PR/uhI+/lfhYFnUQM+1EFf2aPw8BrRfI0NS5uzNo7CRtI2arkC/R3
 f8PJwPdZbKMcEVFVbOfhZWy9iDkj5LI+7Ol/0bi+yER+3NZUTjOYezEqACSxZ5JPCWRE
 GtXQBN3LOs22oPQDDnhs78jkc8TbWehbrIkfl1eCB9gRBoqN2Yrep4Lyha4ctZ16xR17
 cYf5PP/WaTSVPoI1uFdcEK0XodseFdK4NcarXxLqrdEWTICduEwGTR+kR71GVSe8HJVB
 qwpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=mHGaMIkIHgR5W5GBE4MbBOlXpjzscLPMPDa9lxC5WZ0=;
 b=PNdjfASDQ202XOWMyr/26oGSeZ5GKWq0SAKtPSsHQs7drq4Y8+cDS3RLgCxQeuyAoq
 94Kl/Grsy9vIJ9SoklX3Ajkz8HJ7IUCuc0zo9FuMMV0IsujOvCxn9TdAbgQgXu+WD1Mq
 5JkTRiTagDf44WOcE/rNuiHv1AiKtMPmTwdTBZpuwPn8uHjTOnGedi1P83a41dsZVCLc
 HKde+od9wNvrN53QhEbJIvcCmEPlTUqSUBx4iCqTe2JVbKtG6JBle+VP/AR48vMcHpHN
 TZ/JRi5eaQBeTxEID42dOTFWHAPdWefQPS82FGLywGyFbwsHUJ1YIFp+JNycmMyUSJyh
 LXlA==
X-Gm-Message-State: APjAAAX9f5bIRX+7EZyrgbqZKHilpkga2P8ExE0+bydCQi45EC+OtecR
 HLrpQhHvtTyUXWw8q16LTT1p35o/meHte5Y9eBs=
X-Google-Smtp-Source: APXvYqy5h3w+hBaWCn9KCSqxcfKxtt4AW/rylPotZEwuHbVmm89HPZpyuhfCP22l2POX7oWEIiylFzQWffqdgtcE5j8=
X-Received: by 2002:adf:db12:: with SMTP id s18mr10235515wri.335.1562462368644; 
 Sat, 06 Jul 2019 18:19:28 -0700 (PDT)
MIME-Version: 1.0
From: Jidong Xiao <jidong.xiao@gmail.com>
Date: Sat, 6 Jul 2019 19:20:31 -0600
Message-ID: <CAG4AFWag_Q44SetzaZBpD8963NG-H9ajc8GHq07zVv_xaE9WKA@mail.gmail.com>
To: KVM <kvm@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42e
Subject: [Qemu-devel] Nested virtual machine introspection
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

Hi,

We are working on a project where we need to explore the virtual
machine introspection technique in a nested environment. More
specifically, we want to know if from L0, we can reconstruct the
process list of L2. And to begin with, we just want to explore a
relatively simple case, i.e., only one virtual machine at L1, and only
one virtual machine at L2.

Several studies have shown that from L0, people can reconstruct the
process list of L1. For example, in the context of Qemu/KVM, the
process linked list of L1 basically is existing in the L1's kernel
space. And in Qemu, the function cpu_memory_rw_debug() allows us to
access the virtual memory of L1. With the help of this function, we
will be able to scan L1's kernel space thus reconstruct the process
linked list.

Now considering there is L2, can we still use cpu_memory_rw_debug() to
scan somewhere and find out L2's process linked list? We have tried,
but it doesn't work. Any hints on this? Like where exactly shall we
search?

We have been stuck in here for quite a while, any suggestions would be
truly appreciated.

Thanks!

-Jidong

