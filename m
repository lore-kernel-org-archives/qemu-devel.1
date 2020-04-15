Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11774C2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 13:31:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0D5420775
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 13:31:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hWxaxneb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0D5420775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOi8i-000252-Vu
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 09:31:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36496)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <j.abraham1776@gmail.com>) id 1jOX83-0002mZ-V9
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 21:46:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <j.abraham1776@gmail.com>) id 1jOX82-0001RM-Ox
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 21:46:15 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d]:35761)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <j.abraham1776@gmail.com>)
 id 1jOX82-0001R0-JG
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 21:46:14 -0400
Received: by mail-ed1-x52d.google.com with SMTP id c7so2394581edl.2
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2020 18:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=aZ9w9EwowxrFW1JSOXQ19LccGqemigHZasrO9J5U490=;
 b=hWxaxnebT9wZnWCNyJ2ty6eEysZCJ7SDFjcmeEgQCNx92mLsU/l/nDG4I7dXYDhjBU
 ivKlJMv5O15Jp9OmTkvf725trXWH2YCfuw/IArhScAwjmA3O1Beqq/t0gK758ckzRyES
 WHJOrao3IhuiYuRsorEBwHcvhHSRhUGylUsQwRkzhNtekkpk7miAaHf+ZGyW4vJ3nUhU
 lL23/5stMnwKSl345xLZvoGqAOJF+zQlW+IHK5gCYQ0VUMBi/i0vW4KNv4hL8+s8Fy3L
 zCOTC6AS5LO/oKrVN+//9116NAb/FfrZaLRbdHoZ8ocHGJg8NrbDSOAnThZet7DnGSKW
 DdVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=aZ9w9EwowxrFW1JSOXQ19LccGqemigHZasrO9J5U490=;
 b=sRmbaQ9rLwqey6wZTJW6E9KkY8IdlL/D7uzHOURwd9ADgoB0rMQVF94i1Lb8y+botC
 GXV2UAgs3U8LE921M+L5HPE+M+kAcGTb4oiEssjTF3Gd7SRsDIJ0OMdkhFEP60pN92Gy
 Ke84Qat2PDcJ/dgPfuAToxUc5hJxObnAegzWulZNK68H4X7iJInNJ3GaG7Ah90I83qdl
 reGVv6GB/FnHB/SICh4ZYWGUba6hDvTv/mksN9yTUBB6CNb38LWK7RmOlCxzpM0yIWsC
 Nbb7JRVOce9D/U+PiARE1uDuxeX8CHwjmyHLJA0n2+mM0UT9mKFHSS0FaW0CRj72f5I2
 rc9A==
X-Gm-Message-State: AGi0PuZHoakzwSbJhmxMrGf29zB8QJJc97HqJLTGywS1VgEpIAZHnhn1
 StNU3Km98YbFGoJtNYv0qcWs9bmsuYXBqktCgmtPxoDPOIY=
X-Google-Smtp-Source: APiQypI/cBg5rn0Z1qlQwQw6QEDA8sueWonjReS1HhmnuDHMR/v+4fOPMd7kxof5JpUGk0hzgld6id9hByPXlpdZE5w=
X-Received: by 2002:a17:906:5601:: with SMTP id
 f1mr2795641ejq.152.1586915172316; 
 Tue, 14 Apr 2020 18:46:12 -0700 (PDT)
MIME-Version: 1.0
From: Joshua Abraham <j.abraham1776@gmail.com>
Date: Tue, 14 Apr 2020 21:46:00 -0400
Message-ID: <CAMmOe3R6_Q7929+GOrk+G3_2+uj2BSs4jKP6h9VYD6FXcEOCwA@mail.gmail.com>
Subject: AF_UNIX Monitor Device
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::52d
X-Mailman-Approved-At: Wed, 15 Apr 2020 09:30:42 -0400
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
Cc: stefanha@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello Stefan,

This blog post [0] talks about the AF_VSOCK monitoring device
(vsockmon) Stefan upstreamed into Linux a few years ago. It seems to
me the same rationale for enabling packet captures for AF_VSOCK
traffic applies to UNIX domain sockets as well. What do you think? I
have a proof of concept patch for Linux for a unixmon capture device
if you think this is a good idea.

[0] https://blog.vmsplice.net/2017/07/packet-capture-coming-to-afvsock.html
-- 
Respectfully,
Josh Abraham

