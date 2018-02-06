Received: from eggs.gnu.org ([2001:4830:134:3::10]:45679)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ej73Z-00046N-L0
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 12:29:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ej73Y-0001Pd-G5
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 12:29:21 -0500
Date: Tue, 6 Feb 2018 17:29:07 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180206172907.GL20001@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180206171642.19826-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180206171642.19826-1-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH] iotests: 205: support luks format
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org, eblake@redhat.com

On Tue, Feb 06, 2018 at 08:16:42PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> Support default luks options in VM.add_drive and in new library
> function qemu_img_create. Use it in 205 iotests.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
> 
> instead of
>   [PATCH] iotests: 205: support only raw format
> 
> let's just support luks. This patch also makes it simple to support
> luks in any other python iotest.
> 
>  tests/qemu-iotests/205        |  4 ++--
>  tests/qemu-iotests/iotests.py | 33 +++++++++++++++++++++++++++++++++
>  2 files changed, 35 insertions(+), 2 deletions(-)
> 

> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
> index 5a10b2d534..4b9a4445cd 100644
> --- a/tests/qemu-iotests/iotests.py
> +++ b/tests/qemu-iotests/iotests.py
> @@ -58,6 +58,13 @@ qemu_default_machine = os.environ.get('QEMU_DEFAULT_MACHINE')
>  socket_scm_helper = os.environ.get('SOCKET_SCM_HELPER', 'socket_scm_helper')
>  debug = False
>  
> +luks_default_secret_id = 'luks_secret_default_iotests_id'

Can we just call this  "keysec0", so we matchh convention used by
the shell script based tests.

> +luks_default_secret_data = '12345'

The 'check' script exports an environment variable IMGKEYSECRET
that is intended to be used as the default password for LUKS.

> +luks_default_secret_object = 'secret,id=' + luks_default_secret_id + \
> +                             ',data=' + luks_default_secret_data
> +luks_default_key_secret_opt = 'key-secret=' + luks_default_secret_id


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
