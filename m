Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D811C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 13:28:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0E692065F
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 13:28:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f7Va8/Xa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0E692065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jafoz-0001hB-39
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 09:28:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32778)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jafoG-00018I-Tc
 for qemu-devel@nongnu.org; Mon, 18 May 2020 09:28:00 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:33148
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jafoF-0000vn-BD
 for qemu-devel@nongnu.org; Mon, 18 May 2020 09:27:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589808477;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5e/Uoa4EUenUmfbfyQ/lZl/0Y5LUMhi6DBvEt6hq/YQ=;
 b=f7Va8/XausQ4URNauuW/GpaXNSgmUqSxUnx4aIP8sEwueojjbVx0Vebwohxcudxuno7wdq
 JnR/sxppbZ8fQTPkNs/bIiePWtOjKVvWQzvW1p5L+g9rNJX/RdtPtTNv6vXwZpnjS7c4v9
 fLAc/fG2RUgCxRYEHQ/AhUuxJKR0MrA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-465-rvzhoQpdM5C6Hyo9QKTrCg-1; Mon, 18 May 2020 09:27:50 -0400
X-MC-Unique: rvzhoQpdM5C6Hyo9QKTrCg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9B7EE8015CF
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 13:27:49 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-50.ams2.redhat.com
 [10.36.113.50])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 763AC707B1;
 Mon, 18 May 2020 13:27:46 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 90ED717444; Mon, 18 May 2020 15:27:45 +0200 (CEST)
Date: Mon, 18 May 2020 15:27:45 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 11/13] audio: deprecate -soundhw pcspk
Message-ID: <20200518132745.yo2k67yau2nzhl54@sirius.home.kraxel.org>
References: <20200515143528.13591-1-kraxel@redhat.com>
 <20200515143528.13591-12-kraxel@redhat.com>
 <20200515150823.GA738369@lpt>
 <20200518101628.3j4d6hwq6pitjfo3@sirius.home.kraxel.org>
 <20200518102650.GG1430944@redhat.com>
 <20200518112448.7lwjol4elj4d76bq@sirius.home.kraxel.org>
 <20200518125935.zwrpaqwh7dwd3p4p@sirius.home.kraxel.org>
 <87mu659ydh.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <87mu659ydh.fsf@dusky.pond.sub.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/17 22:52:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: =?utf-8?Q?J=C3=A1n?= Tomko <jtomko@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, libvir-list@redhat.com,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  Hi,

> >> Initialization order looks tricky though.  I'd have to create pcspk
> >> early, simliar to flash, in pc_machine_initfn().  Problem is I don't
> >> have a isa bus yet at that point (flash is sysbus and doesn't have this
> >> problem).  I'm open to suggestions hiow do deal with that best.
> >
> > Seems I've found a way to deal with that: "ISADevice *pcspk =
> > object_new(TYPE_PC_SPEAKER);" can be done before the isa bus exists
> > & we can fixup things later using qdev_set_parent_bus().
> 
> You'll want to watch out for the series I hope to post shortly: it'll be
> dev = qdev_new(TYPE_PC_SPEAKER); qdev_realize(dev, bus, errp) then.  No
> need for qdev_set_parent_bus().

Ah, cool, that shows that I'm on the right path with my idea ;)
Sneak preview:
	https://git.kraxel.org/cgit/qemu/log/?h=sirius/soundhw

Suggestions for a good name?  I've used "pc.pcspk" for now,
but maybe "pc.audiodev0" or "pc.sound0" is better?

take care,
  Gerd


