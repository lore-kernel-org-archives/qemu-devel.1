Received: from eggs.gnu.org ([2001:4830:134:3::10]:55632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gXGYC-0003Kx-FQ
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 21:16:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gXGYB-00022l-IF
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 21:16:32 -0500
References: <20181213015013.15350-1-jsnow@redhat.com>
	<20181213015013.15350-5-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f20a33f7-3bc8-958e-0569-58be6ac92cb5@redhat.com>
Date: Wed, 12 Dec 2018 20:16:13 -0600
MIME-Version: 1.0
In-Reply-To: <20181213015013.15350-5-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 4/7] iotests.py: don't abort if
 IMGKEYSECRET is undefined
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>

On 12/12/18 7:50 PM, John Snow wrote:
> Instead of using os.environ[], use .get with a default of empty string
> to match the setup in check to allow us to import the iotests module
> (for debugging, say) without needing a crafted environment just to
> import the module.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   tests/qemu-iotests/iotests.py | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
> index d537538ba0..a34e66813a 100644
> --- a/tests/qemu-iotests/iotests.py
> +++ b/tests/qemu-iotests/iotests.py
> @@ -63,7 +63,7 @@ socket_scm_helper = os.environ.get('SOCKET_SCM_HELPER', 'socket_scm_helper')
>   debug = False
>   
>   luks_default_secret_object = 'secret,id=keysec0,data=' + \
> -                             os.environ['IMGKEYSECRET']
> +                             os.environ.get('IMGKEYSECRET', '')
>   luks_default_key_secret_opt = 'key-secret=keysec0'
>   
>   
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
