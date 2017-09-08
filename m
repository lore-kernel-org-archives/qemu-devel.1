Received: from eggs.gnu.org ([2001:4830:134:3::10]:37627)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dqJXi-0001xb-8H
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 09:41:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dqJXf-0004uf-41
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 09:41:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47238)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dqJXe-0004tp-Ro
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 09:41:55 -0400
Date: Fri, 8 Sep 2017 14:41:45 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170908134145.GF32645@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170908103011.25821-1-berrange@redhat.com>
	<150486803677.210.12147319216227977632@6d89bd104fc3>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <150486803677.210.12147319216227977632@6d89bd104fc3>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 0/3] Improve websock response / error
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, brak@vultr.com, f4bug@amsat.org

On Fri, Sep 08, 2017 at 03:53:57AM -0700, no-reply@patchew.org wrote:
> /tmp/qemu-test/src/io/channel-websock.c: In function =E2=80=98qio_chann=
el_websock_date_str=E2=80=99:
> /tmp/qemu-test/src/io/channel-websock.c:171: error: =E2=80=98GTimeZone=E2=
=80=99 undeclared (first use in this function)
> /tmp/qemu-test/src/io/channel-websock.c:171: error: (Each undeclared id=
entifier is reported only once
> /tmp/qemu-test/src/io/channel-websock.c:171: error: for each function i=
t appears in.)
> /tmp/qemu-test/src/io/channel-websock.c:171: error: =E2=80=98utc=E2=80=99=
 undeclared (first use in this function)
> /tmp/qemu-test/src/io/channel-websock.c:171: warning: implicit declarat=
ion of function =E2=80=98g_time_zone_new_utc=E2=80=99
> /tmp/qemu-test/src/io/channel-websock.c:171: warning: nested extern dec=
laration of =E2=80=98g_time_zone_new_utc=E2=80=99
> /tmp/qemu-test/src/io/channel-websock.c:172: error: =E2=80=98GDateTime=E2=
=80=99 undeclared (first use in this function)
> /tmp/qemu-test/src/io/channel-websock.c:172: error: =E2=80=98now=E2=80=99=
 undeclared (first use in this function)
> /tmp/qemu-test/src/io/channel-websock.c:172: warning: implicit declarat=
ion of function =E2=80=98g_date_time_new_now=E2=80=99
> /tmp/qemu-test/src/io/channel-websock.c:172: warning: nested extern dec=
laration of =E2=80=98g_date_time_new_now=E2=80=99
> /tmp/qemu-test/src/io/channel-websock.c:173: warning: implicit declarat=
ion of function =E2=80=98g_date_time_format=E2=80=99
> /tmp/qemu-test/src/io/channel-websock.c:173: warning: nested extern dec=
laration of =E2=80=98g_date_time_format=E2=80=99
> /tmp/qemu-test/src/io/channel-websock.c:175: warning: implicit declarat=
ion of function =E2=80=98g_date_time_unref=E2=80=99
> /tmp/qemu-test/src/io/channel-websock.c:175: warning: nested extern dec=
laration of =E2=80=98g_date_time_unref=E2=80=99
> /tmp/qemu-test/src/io/channel-websock.c:176: warning: implicit declarat=
ion of function =E2=80=98g_time_zone_unref=E2=80=99
> /tmp/qemu-test/src/io/channel-websock.c:176: warning: nested extern dec=
laration of =E2=80=98g_time_zone_unref=E2=80=99

Urgh,  GTimeZone arrived in glib 2.26 and we hav 2.22 as the min :-(

I'll have to switch to strftime....

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
