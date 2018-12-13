Received: from eggs.gnu.org ([2001:4830:134:3::10]:55998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gXGYv-0003c7-29
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 21:17:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gXGYt-0003E4-QF
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 21:17:16 -0500
References: <20181213015013.15350-1-jsnow@redhat.com>
	<20181213015013.15350-6-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <84894365-2493-6a52-373a-c75e641cf5a2@redhat.com>
Date: Wed, 12 Dec 2018 20:16:49 -0600
MIME-Version: 1.0
In-Reply-To: <20181213015013.15350-6-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 5/7] iotests: add
 filter_generated_node_ids
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
> To mimic the common filter of the same name, but for the python tests.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   tests/qemu-iotests/iotests.py | 3 +++
>   1 file changed, 3 insertions(+)

Reviewed-by: Eric Blake <eblake@redhat.com>

> 
> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
> index a34e66813a..9595429fea 100644
> --- a/tests/qemu-iotests/iotests.py
> +++ b/tests/qemu-iotests/iotests.py
> @@ -239,6 +239,9 @@ def filter_testfiles(msg):
>       prefix = os.path.join(test_dir, "%s-" % (os.getpid()))
>       return msg.replace(prefix, 'TEST_DIR/PID-')
>   
> +def filter_generated_node_ids(msg):
> +    return re.sub("#block[0-9]+", "NODE_NAME", msg)
> +
>   def filter_img_info(output, filename):
>       lines = []
>       for line in output.split('\n'):
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
