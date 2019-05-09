Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 487E6C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 15:18:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B3B820989
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 15:18:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B3B820989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56365 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOkoF-00044Y-Qe
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 11:18:11 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hOkmn-0003Ml-TC
	for qemu-devel@nongnu.org; Thu, 09 May 2019 11:16:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hOkmm-0003jF-VB
	for qemu-devel@nongnu.org; Thu, 09 May 2019 11:16:41 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44738)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hOkmm-0003hp-O8
	for qemu-devel@nongnu.org; Thu, 09 May 2019 11:16:40 -0400
Received: by mail-wr1-f65.google.com with SMTP id c5so3560734wrs.11
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 08:16:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=Qv21UG6PYs6XfxcKFP3vb31xomhEI8qGAEW0Lzkhx7o=;
	b=AoCgqL5QheHL1S9o2yKEy/pcnsaav+7tMZc6BWcFIP6rfgTJnh/i/JElWySRTCznW0
	CWDFL1sowzlVXti+HS2Am7Sg9D/6rdU5yCIm3vHIESmImnkWRqVoJKk9OAmkoBlmpolb
	uorzFi8Fg/+9kXeER+453UT+f5xQ5L9+CjrhnxCE5tm5/EEH0F8rCx3HF0I/CEfI1NbD
	uyBVSYke4B3OD7Z0MuaCiaQUuncLZ5rSrq6xd9zbTAwawEqpC1N908QCYCw3kksA3eDD
	5dNSzS710SyKBmvkPnx+CSaB7ZQB+Vf+Sk6e164FQtJn4R6DVbttPw5zlyC84AfYKN3m
	MI5g==
X-Gm-Message-State: APjAAAWWVPCcc4jJKX8l29tJMQ+0u0uOHrsy7iR95vdDmiYFbrpnnhGJ
	pQ/D6xDhLKxqi757Sgf2ciYKaQ==
X-Google-Smtp-Source: APXvYqzzqS5lDB6na5PrI+thN3kmicuan3RYFlTdCFpIbyPZX5iVs4+9ryLMuxmkKoDlerLFPGXEqQ==
X-Received: by 2002:a5d:4111:: with SMTP id l17mr3559227wrp.242.1557414999488; 
	Thu, 09 May 2019 08:16:39 -0700 (PDT)
Received: from steredhat (host151-251-static.12-87-b.business.telecomitalia.it.
	[87.12.251.151]) by smtp.gmail.com with ESMTPSA id
	q24sm1604065wmc.18.2019.05.09.08.16.38
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 09 May 2019 08:16:38 -0700 (PDT)
Date: Thu, 9 May 2019 17:16:36 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Message-ID: <20190509151636.xcon4rt7ybdo32pz@steredhat>
References: <20190509133737.242548-1-sgarzare@redhat.com>
	<87y33f1xw4.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y33f1xw4.fsf@dusky.pond.sub.org>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH] net/slirp: fix the error message when the
 prefix len is invalid
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
Cc: qemu-trivial@nongnu.org, Jan Kiszka <jan.kiszka@siemens.com>,
	Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
	Samuel Thibault <samuel.thibault@ens-lyon.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, May 09, 2019 at 04:54:35PM +0200, Markus Armbruster wrote:
> Stefano Garzarella <sgarzare@redhat.com> writes:
> 
> > Add a missing parentheses at the end of the error message,
> > when we have an invalid prefix len.
> >
> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > ---
> >  net/slirp.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/slirp.c b/net/slirp.c
> > index 95934fb36d..0f4ae0abc0 100644
> > --- a/net/slirp.c
> > +++ b/net/slirp.c
> > @@ -498,7 +498,8 @@ static int net_slirp_init(NetClientState *peer, const char *model,
> >      }
> >      if (vprefix6_len < 0 || vprefix6_len > 126) {
> >          error_setg(errp,
> > -                   "Invalid prefix provided (prefix len must be in range 0-126");
> > +                   "Invalid prefix provided "
> > +                   "(prefix len must be in range 0-126)");
> >          return -1;
> >      }
> 
> Preexisting: the error message fails to identify the offending
> parameter.  The user needs to make the connection to "ipv6-prefixlen"
> based on the fact that the only parameters with "prefix" in name or
> description are "ipv6-prefix" and "ipv6-prefixlen", and only the latter
> is a length.
> 
> What about "Parameter 'ipv6-prefixlen' expects a length below 127", or
> "Parameter 'ipv6-prefixlen' expects a value between 0 and 126"?

"Parameter 'ipv6-prefixlen' expects a value between 0 and 126" should be
fine.

Otherwise, since other errors didn't refer to the parameter name, we can
simply add IPv6 in this way:
"Invalid IPv6 prefix provided (IPv6 prefix len must be between 0 and 126)"

But I'm fine also with your proposal.

Thanks,
Stefano

