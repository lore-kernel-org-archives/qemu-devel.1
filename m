Received: from eggs.gnu.org ([2001:4830:134:3::10]:54088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dqKL6-000380-9U
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 10:33:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dqKL3-0000F3-5U
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 10:33:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58478)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dqKL2-0000Ef-VB
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 10:32:57 -0400
Date: Fri, 8 Sep 2017 15:32:50 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170908143250.GI32645@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170908135831.10556-1-berrange@redhat.com>
	<150488090978.210.8841793665432135928@6d89bd104fc3>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <150488090978.210.8841793665432135928@6d89bd104fc3>
Subject: Re: [Qemu-devel] [PATCH v3 0/3] Improve websock response / error
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

On Fri, Sep 08, 2017 at 07:28:30AM -0700, no-reply@patchew.org wrote:

> /tmp/qemu-test/src/io/channel-websock.c: In function 'qio_channel_websock_date_str':
> /tmp/qemu-test/src/io/channel-websock.c:178:14: error: passing argument 1 of 'gmtime_r' from incompatible pointer type [-Werror=incompatible-pointer-types]
>      gmtime_r(&tv.tv_sec, &tm);
>               ^
> In file included from /tmp/qemu-test/src/include/qemu/osdep.h:76:0,
>                  from /tmp/qemu-test/src/io/channel-websock.c:21:
> /usr/x86_64-w64-mingw32/sys-root/mingw/include/time.h:272:34: note: expected 'const time_t * {aka const long long int *}' but argument is of type 'long int *'
>  __forceinline struct tm *__cdecl gmtime_r(const time_t *_Time, struct tm *_Tm) {
>                                   ^~~~~~~~
> cc1: all warnings being treated as errors

Ok that's interesting - Linux documents   'struct timeval' as containing
time_t type, but Mingw uses a plain 'long'. So much for standards :-(

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
