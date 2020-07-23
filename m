Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22480C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 13:07:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D00062064C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 13:07:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RTfy0M3y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D00062064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyawd-0004jE-Qu
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 09:07:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46760)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jyaw4-0004Dk-Jn
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 09:06:56 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:34215
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jyaw2-0001mK-Pk
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 09:06:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595509614;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MwAN3nFC59Jo4xpZwX2a5jOw0mrhoh//LIbncPqHMqg=;
 b=RTfy0M3y/zNB0iSdbytMXKOeU/tg+dmLjdA6geDVSjedA6NBPP48I/ZjyBOupC1GZXlU5I
 CxREBpyaj1dX6HtnaWhcZEgpK3N4hvwbylGeu3nIuYbmysYDM3Rxzje1t1BtT735NgUBRD
 9ywEcXFtV3ZfZmtXAYFluwQHdKKziL4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-311-u353iP_sPCiDP8XLANTDgA-1; Thu, 23 Jul 2020 09:06:50 -0400
X-MC-Unique: u353iP_sPCiDP8XLANTDgA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A71401DE0;
 Thu, 23 Jul 2020 13:06:48 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.60])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 17BFA5C1BD;
 Thu, 23 Jul 2020 13:06:42 +0000 (UTC)
Date: Thu, 23 Jul 2020 14:06:40 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Subject: Re: [PATCH 13/13] ssh: add GUri-based URI parsing
Message-ID: <20200723130640.GL2615312@redhat.com>
References: <20200709194234.2117650-1-marcandre.lureau@redhat.com>
 <20200709194234.2117650-14-marcandre.lureau@redhat.com>
 <20200723123141.GP3888@redhat.com>
 <CAJ+F1CKW8gEQ1fEng_W3HnBVk0Suxu21AyGuLKWGroQ8QTWsrA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CKW8gEQ1fEng_W3HnBVk0Suxu21AyGuLKWGroQ8QTWsrA@mail.gmail.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 02:26:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, integration@gluster.org,
 sheepdog@lists.wpkg.org, "open list:Block layer core" <qemu-block@nongnu.org>,
 Peter Lieven <pl@kamp.de>, "Richard W.M. Jones" <rjones@redhat.com>,
 QEMU <qemu-devel@nongnu.org>, Liu Yuan <namei.unix@gmail.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 23, 2020 at 04:58:48PM +0400, Marc-André Lureau wrote:
> Hi
> 
> On Thu, Jul 23, 2020 at 4:33 PM Richard W.M. Jones <rjones@redhat.com>
> wrote:
> 
> > On Thu, Jul 09, 2020 at 11:42:34PM +0400, Marc-André Lureau wrote:
> > > Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> > > ---
> > >  block/ssh.c | 75 +++++++++++++++++++++++++++++++++++++++++------------
> > >  1 file changed, 58 insertions(+), 17 deletions(-)
> > >
> > > diff --git a/block/ssh.c b/block/ssh.c
> > > index c8f6ad79e3c..d2bc6277613 100644
> > > --- a/block/ssh.c
> > > +++ b/block/ssh.c
> > > @@ -180,9 +180,37 @@ static void sftp_error_trace(BDRVSSHState *s, const
> > char *op)
> > >
> > >  static int parse_uri(const char *filename, QDict *options, Error **errp)
> > >  {
> > > +    g_autofree char *port_str = NULL;
> > > +    const char *scheme, *server, *path, *user, *key, *value;
> > > +    gint port;
> > > +
> > > +#ifdef HAVE_GLIB_GURI
> > > +    g_autoptr(GUri) uri = NULL;
> > > +    g_autoptr(GHashTable) params = NULL;
> > > +    g_autoptr(GError) err = NULL;
> > > +    GHashTableIter iter;
> > > +
> > > +    uri = g_uri_parse(filename, G_URI_FLAGS_ENCODED_QUERY, &err);
> > > +    if (!uri) {
> > > +        error_setg(errp, "Failed to parse SSH URI: %s", err->message);
> > > +        return -EINVAL;
> > > +    }
> > > +
> > > +    params = g_uri_parse_params(g_uri_get_query(uri), -1,
> > > +                                "&;", G_URI_PARAMS_NONE, &err);
> > > +    if (err) {
> > > +        error_report("Failed to parse SSH URI query: %s", err->message);
> > > +        return -EINVAL;
> > > +    }
> > > +
> > > +    scheme = g_uri_get_scheme(uri);
> > > +    user = g_uri_get_user(uri);
> > > +    server = g_uri_get_host(uri);
> > > +    path = g_uri_get_path(uri);
> > > +    port = g_uri_get_port(uri);
> > > +#else
> > >      g_autoptr(URI) uri = NULL;
> > >      g_autoptr(QueryParams) qp = NULL;
> > > -    g_autofree char *port_str = NULL;
> > >      int i;
> >
> > As Dan said already, this conditional code looks horrible and is going
> > to be a maintenance burden.  Was there a later version of this patch
> > series that resolved this?  I don't think I saw one.
> >
> 
> The patch is quite experimental. glib didn't even yet receive a release
> with GUri! But since I am working on the glib side, I wanted to make sure
> it covers qemu needs.
> 
> I will revisit the series once GUri is frozen & released (in
> mid-september),and use a copy version fallback.
> 
> Although, as I said in the cover, this is a bit riskier than having a
> transition period with both the old libxml-based parser and glib-based one
> for very recent distro.

The risk here is that the GUri has different semantics/behaviour to the
libxml one.

If that risk is large, then we shouldn't use GUri at all.

If the risk is low enough that we consider GUri a viable option, then
we should use it exclusively IMHO. This guarantees that all deployments
of QEMU will have identical behaviour, which will lower our support
burden in the event that bugs do appear, as we'll only have one codepath
to worry about.

The test suite you provided for GUri looks pretty comprehensive, and
QEMU's iotests are pretty decent too, so I think between the two we
have enough coverage that we should have confidence in using GUri
exclusively. If we hit obscure edge cases, we can just deal with it
as it arises.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


