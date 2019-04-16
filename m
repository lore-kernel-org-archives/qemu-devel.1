Received: from eggs.gnu.org ([209.51.188.92]:51808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1hGKgz-00010k-Us
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 05:47:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1hGKgy-0008S5-Ih
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 05:47:53 -0400
References: <20190326211742.26140-1-danielhb413@gmail.com>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-ID: <00afefc4-7fd7-1f62-ea21-acb31ac79373@gmail.com>
Date: Tue, 16 Apr 2019 06:47:42 -0300
MIME-Version: 1.0
In-Reply-To: <20190326211742.26140-1-danielhb413@gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 0/3] delete created files when
 block_crypto_co_create_opts_luks fails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, berrange@redhat.com

Ping

On 3/26/19 6:17 PM, Daniel Henrique Barboza wrote:
> In this new interation, the following changes were made from
> the previous version [1]:
> - moved the 'generic' code from block.c to file-posix.c
> - moved the file delete call from qemu_img to the error path
> of block_crypto_co_create_opts_luks
>
> [1] https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg06444.html
>
>
> Daniel Henrique Barboza (3):
>    block: introducing 'bdrv_co_delete_file' interface
>    block.c: adding bdrv_delete_file
>    crypto.c: cleanup created file when block_crypto_co_create_opts_luks
>      fails
>
>   block.c                   | 82 +++++++++++++++++++++++++++++++++++++++
>   block/crypto.c            | 31 +++++++++++++++
>   block/file-posix.c        | 28 +++++++++++++
>   include/block/block.h     |  3 ++
>   include/block/block_int.h |  6 +++
>   5 files changed, 150 insertions(+)
>
