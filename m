Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDEBDC04A6B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 17:54:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBC1F2053B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 17:54:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBC1F2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60192 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNhpI-00029F-4b
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 13:54:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hNhdO-0000o3-Ez
	for qemu-devel@nongnu.org; Mon, 06 May 2019 13:42:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hNhdL-0007wF-CH
	for qemu-devel@nongnu.org; Mon, 06 May 2019 13:42:37 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37088)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hNhdI-0007rm-2N
	for qemu-devel@nongnu.org; Mon, 06 May 2019 13:42:32 -0400
Received: by mail-wr1-f65.google.com with SMTP id a12so8277807wrn.4
	for <qemu-devel@nongnu.org>; Mon, 06 May 2019 10:42:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=b9w9Fi/gUkrgIISZq5cmNR6T2ByfGEhwUV+lk/bz3q8=;
	b=iAG+IjRxhS20oMpDOBLxLUP7cYpTG3H3QXPQVBS+m9MmbOnNJZOsRpL3qi16NKXOlO
	rGvGOvielRog/abT6+tJWpD7LpTqg977a6TCde9F5G1vNkDWSg20TisG7o1jMhRaKUiF
	Vd+xX70lE8Lc0dpvxjT7QA7m7BnpmUxdGMWVwgxSWREq22GFynYI8WPu2xfpLwb+oql/
	BcPB0RW9t7qWMalFMO/ApU0uP2V0SjfFLWTpbdgAOjiAjWhNkeBuateevUahdli477qG
	pOBagl2ZvGrPCPab5MGrOmNRH2jQYkl1FmX8jjG7pgLuQdWOnO0BuuySMoyOqaJAeIFp
	HM4w==
X-Gm-Message-State: APjAAAVPTh6GmjYzEO/YU3qwBZHdlCQMYnaRcSnUOfiQbjND6LMgbXkV
	ukW7JwSu9GxC2vF+0EW83h/ptw==
X-Google-Smtp-Source: APXvYqyLbKAC373y5269aIPtIOvMeMLjDzva8dU5kQFP0n3IiAUDUTgA1x57wl26hUiojumgQOpkwg==
X-Received: by 2002:a5d:438d:: with SMTP id i13mr8725224wrq.33.1557164545366; 
	Mon, 06 May 2019 10:42:25 -0700 (PDT)
Received: from steredhat (host103-125-dynamic.46-79-r.retail.telecomitalia.it.
	[79.46.125.103])
	by smtp.gmail.com with ESMTPSA id w2sm7216571wrm.74.2019.05.06.10.42.24
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 06 May 2019 10:42:24 -0700 (PDT)
Date: Mon, 6 May 2019 19:42:22 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Message-ID: <20190506174222.dvpxouohlgtsi6qu@steredhat>
References: <20190503170631.228487-1-sgarzare@redhat.com>
	<878svjra2r.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878svjra2r.fsf@dusky.pond.sub.org>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH] net: avoid to use variable length array in
 net_client_init()
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 06, 2019 at 03:23:08PM +0200, Markus Armbruster wrote:
> Stefano Garzarella <sgarzare@redhat.com> writes:
> 
> > net_client_init() uses a variable length array to store the prefix
> > of 'ipv6-net' parameter (e.g. if ipv6-net=fec0::0/64, the prefix
> > is 'fec0::0').
> > Since the IPv6 prefix can be at most as long as an IPv6 address,
> > we can use an array with fixed size equals to INET6_ADDRSTRLEN.
> >
> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > ---
> >  net/net.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/net/net.c b/net/net.c
> > index f3a3c5444c..2e5f27e121 100644
> > --- a/net/net.c
> > +++ b/net/net.c
> > @@ -1118,7 +1118,7 @@ static int net_client_init(QemuOpts *opts, bool is_netdev, Error **errp)
> >          const char *ip6_net = qemu_opt_get(opts, "ipv6-net");
> >  
> >          if (ip6_net) {
> > -            char buf[strlen(ip6_net) + 1];
> > +            char buf[INET6_ADDRSTRLEN];
> >  
> >              if (get_str_sep(buf, sizeof(buf), &ip6_net, '/') < 0) {
> >                  /* Default 64bit prefix length.  */
> 
> Hmm.
> 
> Parameter "ipv6-net" is of the form ADDRESS[/PREFIX-SIZE].  If
> /PREFIX-SIZE is present, get_str_sep() copies the ADDRESS part to buf[].
> 
> However, nothing stops the user from passing in an ADDRESS longer than
> INET6_ADDRSTRLEN, say by adding a enough leading zeros.  get_str_sep()
> will then silently truncate ADDRESS.
> 
> Suggest to avoid get_str_sep() like this (not even compile-tested):
> 
>         if (ip6_net) {
>             char *slashp = strchr(ip6_net, '/');
> 
>             if (!slashp) {
>                 /* Default 64bit prefix length.  */
>                 qemu_opt_set(opts, "ipv6-prefix", ip6_net, &error_abort);
>                 qemu_opt_set_number(opts, "ipv6-prefixlen", 64, &error_abort);
>             } else {
>                 /* User-specified prefix length.  */
>                 unsigned long len;
>                 int err;
>                 char *addr = g_strndup(ip6_net, slashp - ip6_net);
> 
>                 qemu_opt_set(opts, "ipv6-prefix", addr, &error_abort);
>                 g_free(addr);
>                 err = qemu_strtoul(slashp + 1, NULL, 10, &len);
>                 if (err) {
>                     error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
>                               "ipv6-prefix", "a number");
>                 } else {
>                     qemu_opt_set_number(opts, "ipv6-prefixlen", len,
>                                         &error_abort);
>                 }
>             }
>             qemu_opt_unset(opts, "ipv6-net");
>         }
>     }

Thank you for the suggestion! It seems much better to me.
I'll follow your idea for the v2.

> 
> I'd be tempted to clean up further; de-duplicate the qemu_opt_set() and
> qemu_opt_set_number().

Yes, it seems simple to de-duplicate in this way:
        if (ip6_net) {
            char *slashp = strchr(ip6_net, '/');
            char *addr = ip6_net;
            unsigned long len = 64;

            if (slashp) {
                ...
            }

            qemu_opt_set(opts, "ipv6-prefix", addr, &error_abort);
            qemu_opt_set_number(opts, "ipv6-prefixlen", len, &error_abort);
            qemu_opt_unset(opts, "ipv6-net");
        }

> 
> There's just one more use of get_str_sep(), in parse_host_port(), and it
> looks just as prone to silent truncation.

I'll check it.

Thanks,
Stefano

