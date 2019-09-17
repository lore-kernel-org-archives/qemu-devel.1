Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E509C4CECD
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 13:06:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC85D2053B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 13:06:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AmO82Fmc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC85D2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iADB9-0007Jt-NU
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 09:05:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41431)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1iAD8W-0005ur-4b
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 09:03:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1iAD8R-00019Z-VY
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 09:03:15 -0400
Received: from mail-qk1-x72e.google.com ([2607:f8b0:4864:20::72e]:38144)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1iAD8R-00019N-SR
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 09:03:11 -0400
Received: by mail-qk1-x72e.google.com with SMTP id u186so3871884qkc.5
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 06:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=7dAUWfhUoIBj1hlfF3BwUwkqcp7qdwL0VJEwP0TnIsg=;
 b=AmO82FmcZRfp+bZCHkIY+lx3GumvNxBfF8Bv3oP1tzxeBUEdD71V0QTzh58uIzqINW
 rm0GSe7jw19TpxEyFsTErJmafzZzEuDY50VoKO4/e8cLvy6pJAR+QrDkWTb56hDqsOSG
 PF1J7kM1Iap9HeByf/0ET204jFrbOFHqsIPtVYkjv26ccy4YDX86U+roX2W/PwTxEBBF
 e31FpqgWgexFDRZsMthdLwFE7Yq5M5PoHMHEp08HJgSG9U835fe8sL680Zix5w7Vo4OI
 I1NZQ78zj5tfcgAD/g3Sxtg+jwZN1lwpEKIEnpQFsjKiz3XNYteL2ocm5ZxJFor0Z3s7
 QYvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=7dAUWfhUoIBj1hlfF3BwUwkqcp7qdwL0VJEwP0TnIsg=;
 b=bMr23MCBvvDEeokYKzjKqNaBASurqjamInSkoWUCp6R/NtzCfiXCRac69aXFagfbpL
 rrPzXDZElqgkrfrOiyywKVi/XatUr1PazYOqsEHbWabJ12SMG+bR1XjZY4NCd9VdTZT7
 d2tkUQlnED78p791ORCBUK3ZnEXA8p6s04tVpPpNOIkuWG9qUNIl8LF6l2VGntMDld7f
 vK4oKVJyT4e10GEUPbpEh9KEkCV2jDfpqAeuw4HoEhm2Hy88rv4ezeV5uY+2p2iXARxz
 hjEeD58qqWdASY7ementlyZj2Wkjmy8QA/7Aw/+5eVFv9TPWRg4gteOJlcOPgiZ22XbV
 kapA==
X-Gm-Message-State: APjAAAVAVA7ErvDxj9uen9uf5B1pdPnsLVht22oAa69d/LTieCKegD7Y
 K5Kzr2oTED2y1Dkb/UDebLKBC9lwr9bIK+FWPJh9LvKSDcc=
X-Google-Smtp-Source: APXvYqw8NROJkvXZrQc9RuQmaVt/Ez4mooLnAqCz9TWLcCKPAno6YnnnEFu9xUYo0WpaonzL9l1NgbUUYk0T66eh7bw=
X-Received: by 2002:a37:5c06:: with SMTP id q6mr3535076qkb.236.1568725390998; 
 Tue, 17 Sep 2019 06:03:10 -0700 (PDT)
MIME-Version: 1.0
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 17 Sep 2019 14:02:59 +0100
Message-ID: <CAJSP0QVMjw_zm16MRo25Gq0J9w=9vrKDZtaH=WGwjSJiDAVm9Q@mail.gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, libvir-list@redhat.com, 
 kvm <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::72e
Subject: [Qemu-devel] Call for volunteers: LWN.net articles about KVM Forum
 talks
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
LWN.net is a popular open source news site that covers Linux and other
open source communities (Python, GNOME, Debian, etc).  It has published
a few KVM articles in the past too.

Let's raise awareness of QEMU, KVM, and libvirt by submitting articles covering
KVM Forum.

I am looking for ~5 volunteers who are attending KVM Forum to write an article
about a talk they find interesting.

Please pick a talk you'd like to cover and reply to this email thread.
I will then send an email to LWN with a heads-up so they can let us know
if they are interested in publishing a KVM Forum special.  I will not
ask LWN.net for money.

KVM Forum schedule:
https://events.linuxfoundation.org/events/kvm-forum-2019/program/schedule/

LWN.net guidelines:
https://lwn.net/op/AuthorGuide.lwn
"Our general guideline is for articles to be around 1500 words in
length, though somewhat longer or shorter can work too. The best
articles cover a fairly narrow topic completely, without any big
omissions or any extra padding."

I volunteer to cover Michael Tsirkin's "VirtIO without the Virt -
Towards Implementations in Hardware" talk.

Thanks,
Stefan

