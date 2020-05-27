Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F368C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 10:04:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5642C2084C
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 10:04:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i/KQJdRJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5642C2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdsv8-0002il-Jn
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 06:04:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49852)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rjones@redhat.com>) id 1jdsua-0002IF-CK
 for qemu-devel@nongnu.org; Wed, 27 May 2020 06:03:48 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:38157
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <rjones@redhat.com>) id 1jdsuY-0004Kr-7a
 for qemu-devel@nongnu.org; Wed, 27 May 2020 06:03:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590573824;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ysg8gHT/CbOT0Xcs2vQ0VTnMi3OCbtCNbt/3RnIlB1c=;
 b=i/KQJdRJ4m+5zRqqAqP77k6pqa6FS+KWXqHl1gM2Mm++JdwmvvtY4dqWNzBUGG8ojZGDgF
 KsL6Sb0ixN1+x3yeanLpUPkRKIWgtoqIkXcNBRHDEGXWbIq9syEBxhRyawZwb8e9ExLcSB
 edRmO0PN8MbP+UQrdugRDMubkdFu6R4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-tFk73bm0P7CZx8gwamWCSA-1; Wed, 27 May 2020 06:03:39 -0400
X-MC-Unique: tFk73bm0P7CZx8gwamWCSA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 81D60835B44
 for <qemu-devel@nongnu.org>; Wed, 27 May 2020 10:03:38 +0000 (UTC)
Received: from localhost (ovpn-112-79.ams2.redhat.com [10.36.112.79])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 17BC05D9E8;
 Wed, 27 May 2020 10:03:37 +0000 (UTC)
Date: Wed, 27 May 2020 11:03:37 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH] crypto: Remove use of GCRYPT_VERSION macro.
Message-ID: <20200527100337.GF3888@redhat.com>
References: <20200527093409.3588189-1-rjones@redhat.com>
 <20200527094206.GD2665520@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200527094206.GD2665520@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=rjones@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 00:45:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, May 27, 2020 at 10:42:06AM +0100, Daniel P. Berrangé wrote:
> On Wed, May 27, 2020 at 10:34:09AM +0100, Richard W.M. Jones wrote:
> > According to the gcrypt documentation it's intended that
> > gcry_check_version() is called with the minimum version of gcrypt
> > needed by the program, not the version from the <gcrypt.h> header file
> > that happened to be installed when qemu was compiled.  Indeed the
> > gcrypt.h header says that you shouldn't use the GCRYPT_VERSION macro.
> 
> That's awesome, because the API docs illustrate gcry_check_version
> with passing GCRYPT_VERSION !

They also do it on their internal tests, but I guess that's because
they want to ensure those tests run with the currently compiled
version of libgcrypt (and not the installed package).

However the info file does make it clear that it's the needed version
not the current version.  The example from the info file is:

       /* Version check should be the very first call because it
          makes sure that important subsystems are initialized.
          #define NEED_LIBGCRYPT_VERSION to the minimum required version. */
       if (!gcry_check_version (NEED_LIBGCRYPT_VERSION))
         {
           fprintf (stderr, "libgcrypt is too old (need %s, have %s)\n",
              NEED_LIBGCRYPT_VERSION, gcry_check_version (NULL));
           exit (2);
         }

Rich.


> > This causes the following failure:
> > 
> >   qemu-img: Unable to initialize gcrypt
> > 
> > if a slightly older version of libgcrypt is installed with a newer
> > qemu, even though the slightly older version works fine.  This can
> > happen with RPM packaging which uses symbol versioning to determine
> > automatically which libgcrypt is required by qemu, which caused the
> > following bug in RHEL 8:
> > 
> >   https://bugzilla.redhat.com/show_bug.cgi?id=1840485
> > 
> > qemu actually requires libgcrypt >= 1.5.0, so we might put the string
> > "1.5.0" here.  However since 1.5.0 was released in 2011, it hardly
> > seems we need to check that.  So I replaced GCRYPT_VERSION with NULL.
> > Perhaps in future if we move to requiring a newer version of gcrypt we
> > could put a literal string here.
> 
> I checked that v1.5.0 still accepts NULL and it does, so we're
> fine. We validate the 1.5.0 version in configure, and any
> runtime usage would be hanlded by ELF symbol versioning as
> you say.
> 
> > 
> > Signed-off-by: Richard W.M. Jones <rjones@redhat.com>
> > ---
> >  crypto/init.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/crypto/init.c b/crypto/init.c
> > index b305381ec5..ea233b9192 100644
> > --- a/crypto/init.c
> > +++ b/crypto/init.c
> > @@ -122,7 +122,7 @@ int qcrypto_init(Error **errp)
> >  #endif
> >  
> >  #ifdef CONFIG_GCRYPT
> > -    if (!gcry_check_version(GCRYPT_VERSION)) {
> > +    if (!gcry_check_version(NULL)) {
> >          error_setg(errp, "Unable to initialize gcrypt");
> >          return -1;
> >      }
> 
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> 
> and queued.
> 
> Regards,
> Daniel
> -- 
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
Fedora Windows cross-compiler. Compile Windows programs, test, and
build Windows installers. Over 100 libraries supported.
http://fedoraproject.org/wiki/MinGW


