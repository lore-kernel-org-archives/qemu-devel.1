Return-Path: <SRS0=McoT=XE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A00C4740C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 15:27:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6371720863
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 15:27:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6371720863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7LZP-000082-IU
	for qemu-devel@archiver.kernel.org; Mon, 09 Sep 2019 11:27:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53646)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <johannes@sipsolutions.net>) id 1i7LYc-00080g-FU
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 11:26:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <johannes@sipsolutions.net>) id 1i7LYa-0000et-Ep
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 11:26:22 -0400
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]:49230
 helo=sipsolutions.net)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <johannes@sipsolutions.net>)
 id 1i7LYY-0000aJ-F6
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 11:26:19 -0400
Received: by sipsolutions.net with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <johannes@sipsolutions.net>)
 id 1i7LYV-0008AQ-1g; Mon, 09 Sep 2019 17:26:15 +0200
Message-ID: <49378faefb98abafb64ff105a7941c47395426e7.camel@sipsolutions.net>
From: Johannes Berg <johannes@sipsolutions.net>
To: "Michael S. Tsirkin" <mst@redhat.com>
Date: Mon, 09 Sep 2019 17:26:13 +0200
In-Reply-To: <20190909105057-mutt-send-email-mst@kernel.org>
References: <20190906102217-mutt-send-email-mst@kernel.org>
 <be405c3ba658cdac7f68c91213c3b714ac24c1e3.camel@sipsolutions.net>
 <20190906110340-mutt-send-email-mst@kernel.org>
 <fe0f3f7bfa730088454790dc2d863285c4461134.camel@sipsolutions.net>
 <20190908091207-mutt-send-email-mst@kernel.org>
 <8a9cf8a1726afce7fed8992a4f19fc808004ef88.camel@sipsolutions.net>
 <20190909083902-mutt-send-email-mst@kernel.org>
 <89f25546ffa71c799c533e50658a3a58e066f436.camel@sipsolutions.net>
 <20190909094609-mutt-send-email-mst@kernel.org>
 <d2e750aaec396bd0aa7ea8c05ef5705567d16595.camel@sipsolutions.net>
 <20190909105057-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a01:4f8:191:4433::2
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

On Mon, 2019-09-09 at 10:59 -0400, Michael S. Tsirkin wrote:

> > > Next command is GET_FEATURES. Return an error response from that
> > > and device init will fail.
> > 
> > Hmm, what's an error here though? You can only return a value, no?
> 
> Either returning id that does not match GET_FEATURES or
> returning size != 8 bytes will work.

Hmm, right.

> Using 0 size payload has precedent in VHOST_USER_GET_CONFIG:
> 	vhost-user slave uses zero length of
> 	  payload to indicate an error to vhost-user master.

OK, I think zero-len makes sense, that's certainly something that must
be checked by the receiver already.

> It's annoying that we don't get an error indicator in that case though.
> Worth returning e.g. a 4 byte code?

That also would need to be checked by the receiver, but

1) Then we have to start defining an error code enum, as there's no
   natural space. Is that worth it for what's basically a corner case?
2) It'd also be annoying that we now have a 4-byte error code, but with
   F_REPLY_ACK / need_reply you get an 8-byte status code, which would
   be incompatible in a way.

> And let's generalize for all other messages with response?

We could theoretically have a message in the future that wants a 4-byte
response, though by convention basically everything uses u64 anyway ...

OTOH, 0-byte as error doesn't generalize, VHOST_USER_POSTCOPY_ADVISE has
only a file descriptor as slave payload AFAICT... But then possibly in
those cases the master also wouldn't check the response size at all,
since it never uses it. Qemu does though, and is probably the currently
relevant implementation? Our UML implementation doesn't use this.


Maybe instead we should just add a "VHOST_USER_REPLY_ERROR" bit (e.g.
bit 4 after NEED_REPLY). Qemu in vhost_user_read_header() validates that
it received REPLY_MASK | VERSION, so it would reject the message at that
point.

Another possibility would be to define the highest bit of the 'request'
field to indicate an error, so for GET_FEATURES we'd return the value
0x80000000 | GET_FEATURES.

For even more safety we could make a 4-byte response which is never
valid for anything right now, but it feels overly cautious given that we
currently do check both the request and flag fields. If you think a
response status is needed and want to define an enum with possible
values, then I'd probably prefer an 8-byte status since that's the way
everything works now, but I don't really care much either way.

johannes


