Received: from eggs.gnu.org ([2001:4830:134:3::10]:50034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fDvjp-00032r-0S
	for qemu-devel@nongnu.org; Wed, 02 May 2018 13:40:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fDvjo-0000Bf-88
	for qemu-devel@nongnu.org; Wed, 02 May 2018 13:40:20 -0400
References: <20180421165423.30759-1-mreitz@redhat.com>
	<20180421165423.30759-6-mreitz@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <b743804c-6532-3ad8-3d1e-5303686d10da@redhat.com>
Date: Wed, 2 May 2018 13:40:06 -0400
MIME-Version: 1.0
In-Reply-To: <20180421165423.30759-6-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 5/7] qemu-img: Recognize no
 creation support in -o help
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org



On 04/21/2018 12:54 PM, Max Reitz wrote:
> The only users of print_block_option_help() are qemu-img create and
> qemu-img convert for the output image, so this function is always used
> for image creation (it used to be used for amendment also, but that is
> no longer the case).
> 
> So if image creation is not supported by either the format or the
> protocol, there is no need to print any option description, because the
> user cannot create an image like this anyway.
> 
> This also fixes an assertion failure:
> 
>     $ qemu-img create -f bochs -o help
>     Supported options:
>     qemu-img: util/qemu-option.c:219:
>     qemu_opts_print_help: Assertion `list' failed.
>     [1]    24831 abort (core dumped)  qemu-img create -f bochs -o help
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>

This is great.

3-5: Reviewed-by: John Snow <jsnow@redhat.com>
