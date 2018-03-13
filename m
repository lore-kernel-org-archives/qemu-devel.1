Received: from eggs.gnu.org ([2001:4830:134:3::10]:49492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evm5Y-0005Gb-MD
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 11:43:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evm5X-0002XJ-Ru
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 11:43:44 -0400
References: <20180312152126.286890-1-vsementsov@virtuozzo.com>
	<20180312152126.286890-8-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <15a6e980-2303-b3ab-fcaa-6269d57a6f96@redhat.com>
Date: Tue, 13 Mar 2018 10:43:32 -0500
MIME-Version: 1.0
In-Reply-To: <20180312152126.286890-8-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 7/8] iotests: add file_path helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org

On 03/12/2018 10:21 AM, Vladimir Sementsov-Ogievskiy wrote:
> Simple way to have auto generated filenames with auto cleanup. Like
> FilePath but without using 'with' statement and without additional
> indentation of the whole test.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
> 

> +def file_path(*names):
> +    ''' Another way to get auto-generated filename that cleans itself up.
> +
> +    Use it as simple as:

s/it/is/

> +
> +    img_a, img_b = file_path('a.img', 'b.img')
> +    sock = file_path('socket')
> +    '''
> +
> +    if not hasattr(file_path_remover, 'paths'):
> +        file_path_remover.paths = []
> +        atexit.register(file_path_remover)
> +
> +    paths = []
> +    for name in names:
> +        filename = '{0}-{1}'.format(os.getpid(), name)
> +        path = os.path.join(test_dir, filename)
> +        file_path_remover.paths.append(path)
> +        paths.append(path)
> +
> +    return paths[0] if len(paths) == 1 else paths
> +
> +
>   class VM(qtest.QEMUQtestMachine):
>       '''A QEMU VM'''
>   

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
