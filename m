Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A05C04E53
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 13:02:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E5BB2082E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 13:02:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E5BB2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36944 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQtXx-00050V-J8
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 09:02:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hQtWx-0004Zm-FF
	for qemu-devel@nongnu.org; Wed, 15 May 2019 09:01:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hQtWw-0007Cb-DA
	for qemu-devel@nongnu.org; Wed, 15 May 2019 09:01:11 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52687)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hQtWw-0007BT-6u
	for qemu-devel@nongnu.org; Wed, 15 May 2019 09:01:10 -0400
Received: by mail-wm1-f68.google.com with SMTP id y3so2586217wmm.2
	for <qemu-devel@nongnu.org>; Wed, 15 May 2019 06:01:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:content-transfer-encoding
	:in-reply-to:user-agent;
	bh=YbhfH9nn7lcnNo7iVuw9vm+oRfYBEau4tD6FtClKqoI=;
	b=n1si8JyJtT2AkCYXYHzQcHjO4xDBer/mgVXvi8hnYANCpfUPmzkZOGXiUuQZMmoTxU
	JnrsEWY6xE36A1QjVg0fgSLsFWrNyz1UvZI+Q29Kc7blfilL3kPQhOHWnD2MKWOYCxak
	9bp5msqvSZ/v9dZPD6wiIOAKFLxHX9rEH8SLZFHVaArE9ut4koUq5YGVqx8I8MqSfPyj
	pcR2EcCHLVS/q7swsD8yaJd7M8me1lkZCXnpy5XO+vVB6btyAWTnBBeM89DS+jVB+1jS
	NC8uGcE1myklSakeHVqUZPteq6f9o0qe6vqq5gH3GwRn0laW6nvg5+b2KqsZrW+M7qAW
	OFDQ==
X-Gm-Message-State: APjAAAU7LfWz6meO/0E+oF5rQHEUtsKJ+93eAanYjoYwX6/TAgpmMVB9
	aJiuQ8ZfvYLjNHuXaFz/apc1HA==
X-Google-Smtp-Source: APXvYqyvmvYqFdr7+kgYZQ5Eof+hNosyjOiWg3Thol6A7qy3jx2AJlsh5fekyur20ZISKIBMsOztPg==
X-Received: by 2002:a1c:7a12:: with SMTP id v18mr7718965wmc.69.1557925268965; 
	Wed, 15 May 2019 06:01:08 -0700 (PDT)
Received: from steredhat (host151-251-static.12-87-b.business.telecomitalia.it.
	[87.12.251.151])
	by smtp.gmail.com with ESMTPSA id x6sm2829342wru.36.2019.05.15.06.01.07
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 15 May 2019 06:01:08 -0700 (PDT)
Date: Wed, 15 May 2019 15:01:00 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Message-ID: <20190515130100.rth7dnluusk75v23@steredhat>
References: <20190515090805.44785-1-sgarzare@redhat.com>
	<875zqb7v9c.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <875zqb7v9c.fsf@dusky.pond.sub.org>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [PATCH v2] net/slirp: fix the IPv6 prefix length
 error message
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
	Samuel Thibault <samuel.thibault@ens-lyon.org>,
	=?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, May 15, 2019 at 02:33:03PM +0200, Markus Armbruster wrote:
> Stefano Garzarella <sgarzare@redhat.com> writes:
> 
> > Reword and add a missing parentheses at the end of the
> > error message.
> >
> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> > ---
> > v2:
> >   - Reworded the error message (Markus)
> >   - Added Marc-André's R-b
> >     I made a little change to the error message, let me now
> >     if I should remove yuor R-b.
> > ---
> >  net/slirp.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/slirp.c b/net/slirp.c
> > index 95934fb36d..b34cb29276 100644
> > --- a/net/slirp.c
> > +++ b/net/slirp.c
> > @@ -498,7 +498,8 @@ static int net_slirp_init(NetClientState *peer, const char *model,
> >      }
> >      if (vprefix6_len < 0 || vprefix6_len > 126) {
> >          error_setg(errp,
> > -                   "Invalid prefix provided (prefix len must be in range 0-126");
> > +                   "Invalid IPv6 prefix provided "
> > +                   "(IPv6 prefix length must be between 0 and 126)");
> >          return -1;
> >      }
> 
> "Parameter 'ipv6-prefixlen' expects a value between 0 and 126" would be
> closer to how we report similar errors elsewhere.

This error is shown when 'ipv6-net' or 'ipv6-prefixlen' parameters are
used, so I preferred to leave a more generic error to fit both cases.

> 
> Regardless:
> Reviewed-by: Markus Armbruster <armbru@redhat.com>

Thanks,
Stefano

