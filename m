Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A61C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 07:59:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02CFB217D6
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 07:59:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02CFB217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38565 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP0RC-0005eK-6e
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 03:59:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54986)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hP0QF-0005EL-TB
	for qemu-devel@nongnu.org; Fri, 10 May 2019 03:58:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hP0QE-0000Qd-S5
	for qemu-devel@nongnu.org; Fri, 10 May 2019 03:58:27 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37277)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hP0QE-0000Pv-M0
	for qemu-devel@nongnu.org; Fri, 10 May 2019 03:58:26 -0400
Received: by mail-wm1-f68.google.com with SMTP id 7so316202wmo.2
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 00:58:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=PZFZyLTwwZF9KVviz+T8UozFNuQHGICocSf+qqE6fVw=;
	b=hGENAlT+VzQrKqKFswdBypu61t1Gr7CScXZfU65GKlf/LuwpZ3kzkHQ6on35IJM2De
	juefgLXdSO18Bb0QBIVFr6JhtHchuspFXR7Um8JI1wgonITZxLN7Vf90cdMnJ7tdiYb6
	sntZp7U+JUnIKkUql0hPJNl4kTTdc19psZZx83+HipuOkc9WuuERpC365/EwJHxISp0j
	sbCD51TvbPsbLlg3rIZRMZA3zyDfoaUkxEPuj6GR69QGck7awP5Zv7evhgk4TcNUI28N
	Sd430e7r9TYEu3+ni6LdHKGENi3q7HhHIoCCH/YmkZIzrP7PE0bhrN2kUjxHVAbJRIzp
	woYA==
X-Gm-Message-State: APjAAAUM7pdzwxATWVNRLpoAHQd5Pqi3MEBycwhsOGpVVxy96ebRGOjq
	YWsGpVHssIdpe7JBPwd8jDQYgA==
X-Google-Smtp-Source: APXvYqzgyco0+YgwnuX9FzZN2dxe1W6zSFEnqiONtTHwPVtEyc2s/ffbFB5iLbcJfh/T9N18eN3SfA==
X-Received: by 2002:a1c:f312:: with SMTP id q18mr5824391wmq.96.1557475105489; 
	Fri, 10 May 2019 00:58:25 -0700 (PDT)
Received: from steredhat (host151-251-static.12-87-b.business.telecomitalia.it.
	[87.12.251.151]) by smtp.gmail.com with ESMTPSA id
	s11sm13176231wrb.71.2019.05.10.00.58.24
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 10 May 2019 00:58:24 -0700 (PDT)
Date: Fri, 10 May 2019 09:58:21 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Message-ID: <20190510075821.v2vvcvrb2ofptvi6@steredhat>
References: <20190509133737.242548-1-sgarzare@redhat.com>
	<87y33f1xw4.fsf@dusky.pond.sub.org>
	<20190509151636.xcon4rt7ybdo32pz@steredhat>
	<87h8a2x36o.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h8a2x36o.fsf@dusky.pond.sub.org>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.68
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

On Fri, May 10, 2019 at 07:56:47AM +0200, Markus Armbruster wrote:
> Stefano Garzarella <sgarzare@redhat.com> writes:
> 
> > On Thu, May 09, 2019 at 04:54:35PM +0200, Markus Armbruster wrote:
> >> Stefano Garzarella <sgarzare@redhat.com> writes:
> >> 
> >> > Add a missing parentheses at the end of the error message,
> >> > when we have an invalid prefix len.
> >> >
> >> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> >> > ---
> >> >  net/slirp.c | 3 ++-
> >> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >> >
> >> > diff --git a/net/slirp.c b/net/slirp.c
> >> > index 95934fb36d..0f4ae0abc0 100644
> >> > --- a/net/slirp.c
> >> > +++ b/net/slirp.c
> >> > @@ -498,7 +498,8 @@ static int net_slirp_init(NetClientState *peer, const char *model,
> >> >      }
> >> >      if (vprefix6_len < 0 || vprefix6_len > 126) {
> >> >          error_setg(errp,
> >> > -                   "Invalid prefix provided (prefix len must be in range 0-126");
> >> > +                   "Invalid prefix provided "
> >> > +                   "(prefix len must be in range 0-126)");
> >> >          return -1;
> >> >      }
> >> 
> >> Preexisting: the error message fails to identify the offending
> >> parameter.  The user needs to make the connection to "ipv6-prefixlen"
> >> based on the fact that the only parameters with "prefix" in name or
> >> description are "ipv6-prefix" and "ipv6-prefixlen", and only the latter
> >> is a length.
> >> 
> >> What about "Parameter 'ipv6-prefixlen' expects a length below 127", or
> >> "Parameter 'ipv6-prefixlen' expects a value between 0 and 126"?
> >
> > "Parameter 'ipv6-prefixlen' expects a value between 0 and 126" should be
> > fine.
> >
> > Otherwise, since other errors didn't refer to the parameter name, we can
> > simply add IPv6 in this way:
> > "Invalid IPv6 prefix provided (IPv6 prefix len must be between 0 and 126)"
> 
> "len" is not a word.  Either say "ipv6-prefixlen", or say "IPv6 prefix
> length".
> 
> > But I'm fine also with your proposal.
> 
> It's just a suggestion.  Feel free to leave the error messages
> consistently vague (apply your patch as is), improve just this one, or
> improve more messages.

Your suggestions are very appreciated!

I'll resend this patch fixing this error message and I'll check also
the other messages.

Thanks,
Stefano

