Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CB6EC4CEC6
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 20:38:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E46B12081B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 20:38:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E46B12081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8VrP-0004jq-UB
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 16:38:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51834)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <johannes@sipsolutions.net>) id 1i8VqR-0004I0-Cj
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 16:37:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <johannes@sipsolutions.net>) id 1i8VqQ-0000ke-AV
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 16:37:35 -0400
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]:42272
 helo=sipsolutions.net)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <johannes@sipsolutions.net>)
 id 1i8VqP-0000i6-HX
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 16:37:33 -0400
Received: by sipsolutions.net with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <johannes@sipsolutions.net>)
 id 1i8VqJ-0000Mt-TZ; Thu, 12 Sep 2019 22:37:28 +0200
Message-ID: <b7ddb3f2f546b5f25b1e90c917306b11d5245608.camel@sipsolutions.net>
From: Johannes Berg <johannes@sipsolutions.net>
To: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 12 Sep 2019 22:37:26 +0200
In-Reply-To: <20190912122253.GH23174@stefanha-x1.localdomain>
 (sfid-20190912_142301_873866_C4E851C8)
References: <20190902121233.13382-1-johannes@sipsolutions.net>
 <20190902121233.13382-2-johannes@sipsolutions.net>
 <CAJSP0QXhOQg98FyLzcTnruG7B=b+uUqEd5HvevRKmuP3HhCSmw@mail.gmail.com>
 <45d6dc06b9973aa231f1076a0de279fd5292d2d3.camel@sipsolutions.net>
 <20190912122253.GH23174@stefanha-x1.localdomain>
 (sfid-20190912_142301_873866_C4E851C8)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a01:4f8:191:4433::2
Subject: Re: [Qemu-devel] [RFC] docs: vhost-user: add in-band kick/call
 messages
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
Cc: =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 2019-09-12 at 14:22 +0200, Stefan Hajnoczi wrote:
> 
> The vhost-user spec is unclear and inconsistent.  Patches are welcome.

:)

> A footnote describing the old terminology would be necessary so that
> existing documentation, code, etc can still be decyphered when the spec
> changes the terminology :).

Yeah.

But we (you) would have to decide first what the terminology actually
*should* be :-)

I'd have said something like "host" and "device", but then "host" can
get confusing in the context of qemu, is it the host that the VM is
running on? It's the VM that's hosting the device, but that's a bit confusing in this context.

Client/server might work, but it's not very obvious either (**), and
quite a bit of the text actually gets it wrong right now, so it'd be
very confusing to swap that and have a footnote or similar indicate that
it was described the other way around previously ...

Calling it master/slave as the text does now is a bit confusing to me
because it has DMA (of sorts) and that's called "bus mastering" in most
other contexts, but perhaps that's what would work best nonetheless,
though I'm not really a fan of that terminology.

Perhaps master/device would be nicer, getting the term "device" in there
somewhere would seem appropriate, even if it's not really actually a
device, but from the view inside the "master" VM it is a device...


(**) Btw, is it really true that there's a way to have the device make
the connection to a listening unix domain socket, as implied by the
spec? I cannot find evidence for such a mode in any code...

johannes


