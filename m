Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11603C4CEC4
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 08:29:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA6C020640
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 08:29:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA6C020640
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAVL3-0000qX-0c
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 04:29:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47512)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sgarzare@redhat.com>) id 1iAVKD-0000Oq-A0
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 04:28:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1iAVKC-00035h-47
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 04:28:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54228)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1iAVKB-00034w-Up
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 04:28:32 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 62ED34E926
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2019 08:28:30 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id a15so1389471wrq.4
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2019 01:28:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=5AiFkSR+jG9zbymZlmVuttvGFZdHdAkDLP8ZlJh9phk=;
 b=VSmiuJeeGYdg3NL9uinpCO9xfCFFToTMTVkbAVYm0DGJ4zTXSkY2OQgZsz9dXLZAmM
 dhrhvmcVWGCLbrM8nhfM8lFlsDh79byKHUoETR+0F0xYAYnrXqjOc+W9Y/pIfCofcn2+
 8t8blY37C/2+mkU/sp53IlavJxzQJKfh59rm0iOvXssCRlFu6rIH5LBE+GAmerKY70sz
 R0wzUL6EUs68rXEiLVpEnZpP9GnEuGFruzbbyxA46cZV+vSq/mKjQQ+eAyi5lPO6jS3f
 ox1dTDR8HPLZUBPd2CFVyaceHyotWaoFb+0WKcoUvuC30ZkHQ5HD9LZT1L9J2vTJ9Fqi
 hoYg==
X-Gm-Message-State: APjAAAUd8BDl6EVq3I7sglc3bYZgJwWC2eVN6kysKNvB4Bx40po1snNq
 rGdXjUjCh34PZ3e7tWwJKypUdiwEebRHbYE2IHxBjfNNeirkk1wXiajSliAT0lZ8C2dH2Fcme/V
 B8m0Vv/nEvQdAHTc=
X-Received: by 2002:a1c:4c12:: with SMTP id z18mr1740460wmf.45.1568795308929; 
 Wed, 18 Sep 2019 01:28:28 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxyFjZ2wQiW9cu/cZKg0dWX+RfVfeje3y9q9jB5BgB6PWXxd8MWI1Sw6eqIsqzKzFph4xBAmA==
X-Received: by 2002:a1c:4c12:: with SMTP id z18mr1740437wmf.45.1568795308590; 
 Wed, 18 Sep 2019 01:28:28 -0700 (PDT)
Received: from steredhat (host170-61-dynamic.36-79-r.retail.telecomitalia.it.
 [79.36.61.170])
 by smtp.gmail.com with ESMTPSA id h17sm2864501wme.6.2019.09.18.01.28.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2019 01:28:28 -0700 (PDT)
Date: Wed, 18 Sep 2019 10:28:25 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190918082825.nnrjqvicqwjg3jq6@steredhat>
References: <CAJSP0QVMjw_zm16MRo25Gq0J9w=9vrKDZtaH=WGwjSJiDAVm9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJSP0QVMjw_zm16MRo25Gq0J9w=9vrKDZtaH=WGwjSJiDAVm9Q@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [libvirt] Call for volunteers: LWN.net articles
 about KVM Forum talks
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
Cc: libvir-list@redhat.com, qemu-devel <qemu-devel@nongnu.org>,
 kvm <kvm@vger.kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 17, 2019 at 02:02:59PM +0100, Stefan Hajnoczi wrote:
> Hi,
> LWN.net is a popular open source news site that covers Linux and other
> open source communities (Python, GNOME, Debian, etc).  It has published
> a few KVM articles in the past too.
> 
> Let's raise awareness of QEMU, KVM, and libvirt by submitting articles covering
> KVM Forum.
> 
> I am looking for ~5 volunteers who are attending KVM Forum to write an article
> about a talk they find interesting.
> 
> Please pick a talk you'd like to cover and reply to this email thread.
> I will then send an email to LWN with a heads-up so they can let us know
> if they are interested in publishing a KVM Forum special.  I will not
> ask LWN.net for money.
> 
> KVM Forum schedule:
> https://events.linuxfoundation.org/events/kvm-forum-2019/program/schedule/
> 
> LWN.net guidelines:
> https://lwn.net/op/AuthorGuide.lwn
> "Our general guideline is for articles to be around 1500 words in
> length, though somewhat longer or shorter can work too. The best
> articles cover a fairly narrow topic completely, without any big
> omissions or any extra padding."
> 
> I volunteer to cover Michael Tsirkin's "VirtIO without the Virt -
> Towards Implementations in Hardware" talk.

I volunteer for "Libvirt: Never too Late to Learn New Tricks" by
Daniel Berrange.

Cheers,
Stefano


