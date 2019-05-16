Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB10DC04AB4
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 11:42:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 721F420833
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 11:42:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 721F420833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52609 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hREmb-0006Hj-Nk
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 07:42:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hRElm-0005yP-6n
	for qemu-devel@nongnu.org; Thu, 16 May 2019 07:41:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hRElf-0006hB-DX
	for qemu-devel@nongnu.org; Thu, 16 May 2019 07:41:50 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36069)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hREle-0006e3-Qm
	for qemu-devel@nongnu.org; Thu, 16 May 2019 07:41:47 -0400
Received: by mail-wr1-f67.google.com with SMTP id s17so3051498wru.3
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 04:41:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=cwM7Z0ItkF9iERjTRBY8FN+qQ+ewQQxTeHMuLXAGwag=;
	b=H7vUzyKZwskgEWnaKH1wk2xaGBf+ZsBu1JKA2f2ZIxUNqphHzshD59p19et/Ff0sd1
	JCm6mcjWnLDNJVlGPn4QYMos6AZ3Um52Uih7Nyw+Csn5w3IsXWVZWInnncsETNioCd+x
	Yah59VP1Yq+0BkHA3yQmo+mbg4XGi91FlL3uYY+7vN92/mJRzRNTSQ8CMKu4ZYzQu+r6
	si/gJF7B3ECdOu6ZvNvk3RlCmlZZV9x6C0iDPNsfUROQp+K3J6cTdbu67qUULgNhVysa
	GnuDB7ykNoEq4ifVkLnzBDr0Cntoi8K87iFQ3oKGDhTblJCKMoOkCSaQRDdDGGDWwrEW
	0fZg==
X-Gm-Message-State: APjAAAWG4BwoQkOkcu48XWnZXlXuuE6AN9l2G0hwbOUR8GrUPraKMcqE
	+uFEHnNDXaVtArgal3Q2RsPVdQ==
X-Google-Smtp-Source: APXvYqzy4HiW+g0G80P1xI2YlCf5mZL1L2NVbl2RSztzzJXnPo5GEof8a1yDqhTW+IFHLiFSb4wAnQ==
X-Received: by 2002:adf:d4c8:: with SMTP id w8mr23757592wrk.2.1558006903623;
	Thu, 16 May 2019 04:41:43 -0700 (PDT)
Received: from steredhat (host151-251-static.12-87-b.business.telecomitalia.it.
	[87.12.251.151]) by smtp.gmail.com with ESMTPSA id
	y40sm8635987wrd.96.2019.05.16.04.41.42
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 16 May 2019 04:41:43 -0700 (PDT)
Date: Thu, 16 May 2019 13:41:35 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Message-ID: <20190516114135.udslyqtyid6xfzid@steredhat>
References: <20190509130345.227526-1-sgarzare@redhat.com>
	<20190509130345.227526-3-sgarzare@redhat.com>
	<877eaqvlej.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877eaqvlej.fsf@dusky.pond.sub.org>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH v2 2/4] net: avoid using variable length
 array in net_client_init()
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
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, May 16, 2019 at 10:44:20AM +0200, Markus Armbruster wrote:
> Stefano Garzarella <sgarzare@redhat.com> writes:
> 
> > net_client_init() uses a variable length array to store the prefix
> > of 'ipv6-net' parameter (e.g. if ipv6-net=fec0::0/64, the prefix
> > is 'fec0::0').
> > This patch introduces g_strsplit() to split the 'ipv6-net' parameter,
> > so we can remove the variable length array.
> >
> > Suggested-by: Markus Armbruster <armbru@redhat.com>
> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > ---
> >  net/net.c | 33 +++++++++++++++++++++------------
> >  1 file changed, 21 insertions(+), 12 deletions(-)
> >
> > diff --git a/net/net.c b/net/net.c
> > index d5071e49e2..932fa5abb5 100644
> > --- a/net/net.c
> > +++ b/net/net.c
> > @@ -1118,29 +1118,38 @@ static int net_client_init(QemuOpts *opts, bool is_netdev, Error **errp)
> >          const char *ip6_net = qemu_opt_get(opts, "ipv6-net");
> >  
> >          if (ip6_net) {
> > -            char buf[strlen(ip6_net) + 1];
> > +            gchar **substrings;
> > +            char *prefix_addr;
> > +            unsigned long prefix_len = 64; /* Default 64bit prefix length. */
> >  
> > -            if (get_str_sep(buf, sizeof(buf), &ip6_net, '/') < 0) {
> > -                /* Default 64bit prefix length.  */
> > -                qemu_opt_set(opts, "ipv6-prefix", ip6_net, &error_abort);
> > -                qemu_opt_set_number(opts, "ipv6-prefixlen", 64, &error_abort);
> > -            } else {
> > +            substrings = g_strsplit(ip6_net, "/", 2);
> > +            if (!substrings || !substrings[0]) {
> > +                    error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
> > +                               "ipv6-net", "a valid IPv6 prefix");
> > +                    g_strfreev(substrings);
> > +                    goto out;
> 
> Indentation's off.
> 

Copy and past issue :(

> > +            }
> > +
> > +            *prefix_addr = substrings[0];
> > +
> > +            if (substrings[1]) {
> >                  /* User-specified prefix length.  */
> > -                unsigned long len;
> >                  int err;
> >  
> > -                qemu_opt_set(opts, "ipv6-prefix", buf, &error_abort);
> > -                err = qemu_strtoul(ip6_net, NULL, 10, &len);
> > -
> > +                err = qemu_strtoul(substrings[1], NULL, 10, &prefix_len);
> >                  if (err) {
> >                      error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
> >                                 "ipv6-prefixlen", "a number");
> > +                    g_strfreev(substrings);
> >                      goto out;
> 
> Two g_strfreev() before goto out.  Avoidable: declare substrings at the
> function level, initialize to NULL, then call g_strfreev(substrings) ...o

I'll fix it in the v3, it's cleaner.

> 
> >                  }
> > -
> > -                qemu_opt_set_number(opts, "ipv6-prefixlen", len, &error_abort);
> >              }
> > +
> > +            qemu_opt_set(opts, "ipv6-prefix", prefix_addr, &error_abort);
> > +            qemu_opt_set_number(opts, "ipv6-prefixlen", prefix_len,
> > +                                &error_abort);
> >              qemu_opt_unset(opts, "ipv6-net");
> > +            g_strfreev(substrings);
> >          }
> >      }
> 
>        if (is_netdev) {
>            visit_type_Netdev(v, NULL, (Netdev **)&object, &err);
>        } else {
>            visit_type_NetLegacy(v, NULL, (NetLegacy **)&object, &err);
>        }
> 
>        if (!err) {
>            ret = net_client_init1(object, is_netdev, &err);
>        }
> 
>        if (is_netdev) {
>            qapi_free_Netdev(object);
>        } else {
>            qapi_free_NetLegacy(object);
>        }
> 
>    out:
>        error_propagate(errp, err);
> 
> ... here.  Your choice.
> 
>        visit_free(v);
>        return ret;
>    }
> 
> With at least the indentation fixed:
> Reviewed-by: Markus Armbruster <armbru@redhat.com>

Thanks!

> 
> 
> Not this patch's problem: when visit_type_FOO() fails with an input
> visitor such as @v, you should not call qapi_free_FOO().  Nothing bad
> happens when you do, it's just sloppy.  See visitor.h's big comment for
> details.
> 
> Cleaner:
> 
>        if (is_netdev) {
>            visit_type_Netdev(v, NULL, (Netdev **)&object, &err);
>        } else {
>            visit_type_NetLegacy(v, NULL, (NetLegacy **)&object, &err);
>        }
>        if (err) {
>            goto out;
>        }
> 
>        ret = net_client_init1(object, is_netdev, &err);
> 
>        if (is_netdev) {
>            qapi_free_Netdev(object);
>        } else {
>            qapi_free_NetLegacy(object);
>        }
> 
>    out:
> 
> Or maybe:
> 
>        if (is_netdev) {
>            visit_type_Netdev(v, NULL, &netdev, &err);
>            if (err) {
>                goto out;
>            }
>            ret = net_client_init1(netdev, is_netdev, &err);
>            qapi_free_Netdev(netdev);
>        } else {
>            visit_type_NetLegacy(v, NULL, &netlegacy, &err);
>            if (err) {
>                goto out;
>            }
>            ret = net_client_init1(netlegacy, is_netdev, &err);
>            qapi_free_NetLegacy(netlegacy);
>        }
> 
>    out:
> 
> with
> 
>        Netdev *netdev;
>        NetLegacy *netlegacy;
> 
> replacing @object.
> 
> Or one step further: observe net_client_init() is always called with a
> compile-time constant second argument.  Split it into two functions,
> factor the common part into a helper.

Yeah, I think could be better!
I'll create an helper to parse the IPv6 prefix and two separated
functions to initialize Netdev or NetLegacy.

I'll put the new patch in the v3, are you agree?

Thanks,
Stefano

