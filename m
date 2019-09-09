Return-Path: <SRS0=McoT=XE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74446C4740A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 12:42:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49040218DE
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 12:42:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49040218DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7Iza-0006c7-0j
	for qemu-devel@archiver.kernel.org; Mon, 09 Sep 2019 08:42:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51354)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1i7Iyt-0006BA-W8
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 08:41:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1i7Iys-0001jA-W4
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 08:41:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46646)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1i7Iys-0001ir-Ot
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 08:41:18 -0400
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 160212D0FCE
 for <qemu-devel@nongnu.org>; Mon,  9 Sep 2019 12:41:18 +0000 (UTC)
Received: by mail-qk1-f200.google.com with SMTP id v143so16045181qka.21
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2019 05:41:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ZCuJG1Cac2wjmQE4JT82x3FrrbXbh6IGBXW9SAccfpE=;
 b=JtZ6xlwBcbQHQn0SHhA5YAiVUMhzLbnc/ef3UsMUESRCn8CIFHbVGjbXNkDbnoJCzd
 OUa2mNQDrNZiQJoRm/d4n98rycs3drRbem+7E8qccuyrvd7kOCTM6xYe3Zb28Rp9Y+j6
 zLiw79J8tBx/L0H7sT3RRRd7/hqY/A5RMOS4zJDGT708HiVyCD9638tEBQj7QbmCPbh5
 PY7UVxz0FlpBxrem7QH08rAfCb6k+GWF7TSo9+143Xtnde6XlMYsuSgb5f4FgQdS4Ggi
 tWeUCToKpkKtYUylO9AiG84sotr0Qb3dNqr2Ef7S/g+/ZcZvN59g9K8vBntVxyV7u6YW
 qjlQ==
X-Gm-Message-State: APjAAAUx9RQ1YUYVQ7kSXoYEtWtb+q3Z8YFH+fI+v8roAOixnLN8g8nl
 LIXY2Z3yiCr4XDTVitbp9c5tuB60Ul1oIALGnHb2XGkmY/FqwXXU5Rzkn/orZGVOUYgIn2SCXrU
 GksnFgpRxLmW3Uh8=
X-Received: by 2002:ad4:4524:: with SMTP id l4mr14493627qvu.69.1568032876899; 
 Mon, 09 Sep 2019 05:41:16 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzQm+zO+c+xuiMd1s40AMx1xBvDmILqQZMX3Uck16iELOqg6iVXqxgkaLZV6y5+yoAgO7oO2Q==
X-Received: by 2002:ad4:4524:: with SMTP id l4mr14493613qvu.69.1568032876657; 
 Mon, 09 Sep 2019 05:41:16 -0700 (PDT)
Received: from redhat.com ([80.74.107.118])
 by smtp.gmail.com with ESMTPSA id a3sm6712872qta.68.2019.09.09.05.41.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2019 05:41:15 -0700 (PDT)
Date: Mon, 9 Sep 2019 08:41:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Johannes Berg <johannes@sipsolutions.net>
Message-ID: <20190909083902-mutt-send-email-mst@kernel.org>
References: <20190902121233.13382-1-johannes@sipsolutions.net>
 <20190906121350.29202-1-johannes@sipsolutions.net>
 <20190906102217-mutt-send-email-mst@kernel.org>
 <be405c3ba658cdac7f68c91213c3b714ac24c1e3.camel@sipsolutions.net>
 <20190906110340-mutt-send-email-mst@kernel.org>
 <fe0f3f7bfa730088454790dc2d863285c4461134.camel@sipsolutions.net>
 <20190908091207-mutt-send-email-mst@kernel.org>
 <8a9cf8a1726afce7fed8992a4f19fc808004ef88.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a9cf8a1726afce7fed8992a4f19fc808004ef88.camel@sipsolutions.net>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC] libvhost-user: implement
 VHOST_USER_PROTOCOL_F_KICK_CALL_MSGS
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Sep 09, 2019 at 01:35:19PM +0200, Johannes Berg wrote:
> On Sun, 2019-09-08 at 09:13 -0400, Michael S. Tsirkin wrote:
> 
> > > I think the only use for this extension would be for simulation
> > > purposes, and even then only combined with the REPLY_ACK and SLAVE_REQ
> > > extensions, i.e. you explicitly *want* your virtual machine to lock up /
> > > wait for a response to the KICK command (and respectively, the device to
> > > wait for a response to the CALL command).
> > 
> > OK so when combined with these, it's OK I think.
> 
> OK.
> 
> > Do we want to force this restriction in code maybe then?
> 
> Unlike in this patch, I was planning to not actually advertise
> VHOST_USER_PROTOCOL_F_KICK_CALL_MSGS, and do that only if the user of
> the library wants to advertise it, since devices used for simulation
> also have to be careful about how they use this.
> 
> However, if I understand correctly we cannot enforce that all of them
> are used at the same time - we're the device side, so we only advertise
> our features and the master actually sets the ones it wants to use, no?
> 
> The only thing we could do is crash if it wants to use this feature
> without the others, but would that really be helpful?

We can return failure from SET_PROTOCOL_FEATURES.
We can also fail all following messages.


> I'm starting to actually get this working, so I'll post new patches in a
> few days or so.
> 
> johannes

