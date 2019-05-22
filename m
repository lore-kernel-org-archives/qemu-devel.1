Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA86C282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 13:48:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 537A820863
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 13:48:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 537A820863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43652 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTRbL-00072a-Bt
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 09:48:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43325)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <johannes@sipsolutions.net>) id 1hTRa4-0006cR-2j
	for qemu-devel@nongnu.org; Wed, 22 May 2019 09:46:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <johannes@sipsolutions.net>) id 1hTRa3-0002MW-7T
	for qemu-devel@nongnu.org; Wed, 22 May 2019 09:46:56 -0400
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]:55204
	helo=sipsolutions.net)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <johannes@sipsolutions.net>)
	id 1hTRa3-0002L6-0Y
	for qemu-devel@nongnu.org; Wed, 22 May 2019 09:46:55 -0400
Received: by sipsolutions.net with esmtpsa
	(TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
	(envelope-from <johannes@sipsolutions.net>)
	id 1hTRZw-0004Ak-Sb; Wed, 22 May 2019 15:46:48 +0200
Message-ID: <8b30e5cea2692d62fd7f486fc98effdb589a1412.camel@sipsolutions.net>
From: Johannes Berg <johannes@sipsolutions.net>
To: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>, 
	linux-um@lists.infradead.org, virtualization@lists.linux-foundation.org,
	qemu-devel@nongnu.org
Date: Wed, 22 May 2019 15:46:47 +0200
In-Reply-To: <ddeee710-d546-ff05-5c53-991a7d807067@kot-begemot.co.uk>
References: <0952696452f5ff4e38d2417029243fc60efa33d6.camel@sipsolutions.net>
	<ddeee710-d546-ff05-5c53-991a7d807067@kot-begemot.co.uk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a01:4f8:191:4433::2
Subject: Re: [Qemu-devel] custom virt-io support (in user-mode-linux)
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Anton,

> > I'm thinking about adding virt-io support to UML, but the tricky part is
> > that while I want to use the virt-io basics (because it's a nice
> > interface from the 'inside'), I don't actually want the stock drivers
> > that are part of the kernel now (like virtio-net etc.) but rather
> > something that integrates with wifi (probably building on hwsim).

> I have looked at using virtio semantics in UML in the past around the 
> point when I wanted to make the recvmmsg/sendmmsg vector drivers common 
> in UML and QEMU. It is certainly possible,
> 
> I went for the native approach at the end though.

Hmm. I'm not sure what you mean by either :-)

Is there any commonality between the vector drivers? I can't see how
that'd work without a bus abstraction (like virtio) in qemu? I mean, the
kernel driver just calls uml_vector_sendmmsg(), which I'd say belongs
more to the 'outside world', but that can't really be done in qemu?

Ok, I guess then I see what you mean by 'native' though.

Similarly, of course, I can implement arbitrary virt-io devices - just
the kernel side doesn't call a function like uml_vector_sendmmsg()
directly, but instead the virt-io model, and the model calls the
function, which essentially is the same just with a (convenient)
abstraction layer.

But this leaves the fundamental fact the model code ("vector_user.c" or
a similar "virtio_user.c") is still part of the build.

I guess what I'm thinking is have something like "virtio_user_rpc.c"
that uses some appropriate RPC to interact with the real model. IOW,
rather than having all the model-specific logic actually be here (like
vector_user.c actually knows how to send network packets over a real
socket fd), try to call out to some RPC that contains the real model.

Now that I thought about it further, I guess my question boils down to
"did anyone ever think about doing RPC for Virt-IO instead of putting
the entire device model into the hypervisor/emulator/...".

johannes


