Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E5DBCA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 11:37:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70E8920854
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 11:37:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70E8920854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLQZp-00067x-Kn
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 07:37:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35023)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iLQZC-0005fo-Im
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 07:37:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iLQZB-00082J-72
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 07:37:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39470)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>)
 id 1iLQZA-00081t-VA; Fri, 18 Oct 2019 07:37:09 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0FE5E99C43;
 Fri, 18 Oct 2019 11:37:08 +0000 (UTC)
Received: from redhat.com (ovpn-112-62.ams2.redhat.com [10.36.112.62])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1DC851001B05;
 Fri, 18 Oct 2019 11:37:05 +0000 (UTC)
Date: Fri, 18 Oct 2019 12:37:03 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] Do not use %m in common code to print error messages
Message-ID: <20191018113703.GE28271@redhat.com>
References: <20191018104438.6158-1-thuth@redhat.com>
 <20191018105710.GD28271@redhat.com>
 <4bb84a56-30b1-72e7-7df1-770505744b39@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4bb84a56-30b1-72e7-7df1-770505744b39@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Fri, 18 Oct 2019 11:37:08 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Kamil Rytarowski <kamil@netbsd.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 18, 2019 at 01:31:34PM +0200, Thomas Huth wrote:
> On 18/10/2019 12.57, Daniel P. Berrang=C3=A9 wrote:
> > On Fri, Oct 18, 2019 at 12:44:38PM +0200, Thomas Huth wrote:
> >> The %m format specifier is an extension from glibc - and when compil=
ing
> >> QEMU for NetBSD, the compiler correctly complains, e.g.:
> >>
> >> /home/qemu/qemu-test.ELjfrQ/src/util/main-loop.c: In function 'sigfd=
_handler':
> >> /home/qemu/qemu-test.ELjfrQ/src/util/main-loop.c:64:13: warning: %m =
is only
> >>  allowed in syslog(3) like functions [-Wformat=3D]
> >>              printf("read from sigfd returned %zd: %m\n", len);
> >>              ^
> >> Let's use g_strerror() here instead, which is an easy-to-use wrapper
> >> around the thread-safe strerror_r() function.
> >>
> >> While we're at it, also convert the "printf()" in main-loop.c into
> >> the preferred "error_report()".
> >>
> >> Signed-off-by: Thomas Huth <thuth@redhat.com>
> >> ---
> >>  hw/misc/tmp421.c | 8 ++++++--
> >>  util/main-loop.c | 4 +++-
> >>  util/systemd.c   | 5 +++--
> >>  3 files changed, 12 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/hw/misc/tmp421.c b/hw/misc/tmp421.c
> >> index 9f044705fa..f23c46a40a 100644
> >> --- a/hw/misc/tmp421.c
> >> +++ b/hw/misc/tmp421.c
> >> @@ -120,7 +120,9 @@ static void tmp421_get_temperature(Object *obj, =
Visitor *v, const char *name,
> >>      int tempid;
> >> =20
> >>      if (sscanf(name, "temperature%d", &tempid) !=3D 1) {
> >> -        error_setg(errp, "error reading %s: %m", name);
> >> +        const char *errmsg =3D g_strerror(errno);
> >> +        error_setg(errp, "error reading %s: %s", name, errmsg);
> >> +        g_free((gpointer)errmsg);
> >=20
> > Kaboom crash. This is trying to free a const string that is the calle=
r
> > doesn't own. It remains under ownership of g_strerror forever.
>=20
> Well, if you look at the implementation of g_strerror(), you can see
> that glib returns allocated memory here (with g_strdup() for example).
> So if we don't free, this will leak memory over time.

This is *not* a leak, it is a cache.

It is maintaining a static hash table that caches the mapping from
errno -> string. So many calls all with the same errno value will
return the same cached string. So by free'ing the string you're
causing a use-after-free flaw the next time the same errno is
passed to g_strerror. The memory usage here is finite, bounded
by the number of possible errnos that we see.

> But you're right, the "const" and documentation of the function indicat=
e
> that the caller should rather not free the memory. What a bummer, sound=
s
> like g_strerror() is pretty much useless unless you immediately exit()
> afterwards (and you care about not leaking memory).
>=20
> I guess we have to implement our own wrapper, qemu_strerror() instead?

No, g_strerror is working fine without free'ing the result.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

