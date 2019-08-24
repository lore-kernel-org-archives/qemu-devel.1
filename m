Return-Path: <SRS0=NWXH=WU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E3F4C3A59E
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Aug 2019 06:48:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8CEB20656
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Aug 2019 06:48:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=grep.be header.i=@grep.be header.b="Mp1GXIgz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8CEB20656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grep.be
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1Pr6-0000m7-SA
	for qemu-devel@archiver.kernel.org; Sat, 24 Aug 2019 02:48:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59769)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wouter@grep.be>) id 1i1PnI-0008I1-JL
 for qemu-devel@nongnu.org; Sat, 24 Aug 2019 02:45:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wouter@grep.be>) id 1i1PnH-0004fx-DL
 for qemu-devel@nongnu.org; Sat, 24 Aug 2019 02:45:00 -0400
Received: from latin.grep.be ([2a01:4f8:140:52e5::2]:57724)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wouter@grep.be>)
 id 1i1PnE-0004cl-09; Sat, 24 Aug 2019 02:44:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=grep.be;
 s=2017.latin; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=QbzStQInNB4hU8rRjd8L+RZunigs5FJZ8Dbn0BTnbJQ=; b=Mp1GXIgzLkfET1+2aVrTaZRcLR
 KVR/dALRnUaof+W4SjyubdR0p19ibFr/hl8A5oSw7c0tl0zldi8k9nMKdd6ShPKUN4/ML5siYdssB
 gL42/2Xl8NZRpuudZeD+LsK7w6cjyfIcdA3qs3Q4fJFbLA8lb5Qn1T88uW+D2HCZEhCKru67f/FXQ
 Rr9UZGUHjckumGKfPU0pogpj7bdRVnWGrNH2tt67Wxrob5npIwfxA6hO/zb/66c3kBFjJn8YfJ2x7
 svCk206ZXGDL5Fl17E5tnV5t2JT+saQf75KABfBc8NnNVfBUpAonhQUxGlfe9++HVmPNzWJ3HPyHk
 L5ZYwHkw==;
Received: from wouter by latin.grep.be with local (Exim 4.89)
 (envelope-from <wouter@grep.be>)
 id 1i1Pn6-00089I-Sk; Sat, 24 Aug 2019 08:44:48 +0200
Date: Sat, 24 Aug 2019 08:44:48 +0200
From: Wouter Verhelst <wouter@grep.be>
To: Eric Blake <eblake@redhat.com>
Message-ID: <20190824064448.q62iwelqjn2safao@grep.be>
References: <25ead363-4f37-5450-b985-1876374e314d@redhat.com>
 <20190823143426.26838-1-eblake@redhat.com>
 <20190823143426.26838-2-eblake@redhat.com>
 <20190823184834.brhsfbc4sdq5xuij@grep.be>
 <d3d1590e-e276-e449-c3da-0bdc4d4977d7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3d1590e-e276-e449-c3da-0bdc4d4977d7@redhat.com>
X-Speed: Gates' Law: Every 18 months, the speed of software halves.
User-Agent: NeoMutt/20170113 (1.7.2)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a01:4f8:140:52e5::2
Subject: Re: [Qemu-devel] [PATCH 1/1] protocol: Add NBD_CMD_FLAG_FAST_ZERO
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
Cc: Wouter Verhelst <w@uter.be>, libguestfs@redhat.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, nbd@other.debian.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Aug 23, 2019 at 01:58:44PM -0500, Eric Blake wrote:
> On 8/23/19 1:48 PM, Wouter Verhelst wrote:
> > On Fri, Aug 23, 2019 at 09:34:26AM -0500, Eric Blake wrote:
> >> +- bit 4, `NBD_CMD_FLAG_FAST_ZERO`; valid during
> >> +  `NBD_CMD_WRITE_ZEROES`. If set, but the server cannot perform the
> >> +  write zeroes any faster than it would for an equivalent
> >> +  `NBD_CMD_WRITE`,
> > 
> > One way of fulfilling the letter of this requirement but not its spirit
> > could be to have background writes; that is, the server makes a note
> > that the zeroed region should contain zeroes, makes an error-free reply
> > to the client, and then starts updating things in the background (with
> > proper layering so that an NBD_CMD_READ would see zeroes).
> 
> For writes, this should still be viable IF the server can also cancel
> that background write of zeroes in favor of a foreground request for
> actual data to be written to the same offset.  In other words, as long
> as the behavior to the client is "as if" there is no duplicated I/O
> cost, the zero appears fast, even if it kicked off a long-running async
> process to actually accomplish it.

That's kind of what I was thinking of, yeah.

A background write would cause disk I/O, which *will* cause any write
that happen concurrently with it to slow down. If we need to write
several orders of magnitude of zeroes, then the "fast zero" will
actually cause the following writes to slow down, which could impact
performance.

The cancelling should indeed happen (otherwise ordering of writes will
be wrong, as per the spec), but that doesn't negate the performance
impact.

> > This could negatively impact performance after that command to the
> > effect that syncing the device would be slower rather than faster, if
> > not done right.
> 
> Oh. I see - for flush requests, you're worried about the cost of the
> flush forcing the I/O for the background zero to complete before flush
> can return.
> 
> Perhaps that merely means that a client using fast zero requests as a
> means of probing whether it can do a bulk pre-zero pass even though it
> will be rewriting part of that image with data later SHOULD NOT attempt
> to flush the disk until all other interesting write requests are also
> ready to queue.  In the 'qemu-img convert' case which spawned this
> discussion, that's certainly the case (qemu-img does not call flush
> after the pre-zeroing, but only after all data is copied - and then it
> really DOES want to wait for any remaining backgrounded zeroing to land
> on the disk along with any normal writes when it does its final flush).

Not what I meant, but also a good point, thanks :)

> > Do we want to keep that in consideration?
> 
> Ideas on how best to add what I mentioned above into the specification?

Perhaps clarify that the "fast zero" flag is meant to *improve*
performance, and that it therefore should either be implemented in a way
that does in fact improve performance, or not at all?

-- 
<Lo-lan-do> Home is where you have to wash the dishes.
  -- #debian-devel, Freenode, 2004-09-22

