Received: from eggs.gnu.org ([2001:4830:134:3::10]:39124)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d5YQW-0006Yr-EV
	for qemu-devel@nongnu.org; Tue, 02 May 2017 10:05:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d5YQS-0006M8-GT
	for qemu-devel@nongnu.org; Tue, 02 May 2017 10:05:16 -0400
Date: Tue, 2 May 2017 16:04:55 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170502140455.GB5805@noname.redhat.com>
References: <20170502081832.9546-1-famz@redhat.com>
	<20170502081832.9546-6-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170502081832.9546-6-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v16 05/22] qemu-img: Update documentation
 for -U
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Am 02.05.2017 um 10:18 hat Fam Zheng geschrieben:
> Signed-off-by: Fam Zheng <famz@redhat.com>

>  DEF("convert", img_convert,
> -    "convert [--object objectdef] [--image-opts] [-c] [-p] [-q] [-n] [-f fmt] [-t cache] [-T src_cache] [-O output_fmt] [-B backing_file] [-o options] [-s snapshot_id_or_name] [-l snapshot_param] [-S sparse_size] [-m num_coroutines] [-W] filename [filename2 [...]] output_filename")
> +    "convert [--object objectdef] [--image-opts] [-U] [-c] [-p] [-q] [-n] [-f fmt] [-t cache] [-T src_cache] [-O output_fmt] [-o options] [-s snapshot_id_or_name] [-l snapshot_param] [-S sparse_size] [-m num_coroutines] [-W] [-U] filename [filename2 [...]] output_filename")
>  STEXI
> -@item convert [--object @var{objectdef}] [--image-opts] [-c] [-p] [-q] [-n] [-f @var{fmt}] [-t @var{cache}] [-T @var{src_cache}] [-O @var{output_fmt}] [-B @var{backing_file}] [-o @var{options}] [-s @var{snapshot_id_or_name}] [-l @var{snapshot_param}] [-S @var{sparse_size}] [-m @var{num_coroutines}] [-W] @var{filename} [@var{filename2} [...]] @var{output_filename}
> +@item convert [--object @var{objectdef}] [--image-opts] [-U] [-c] [-p] [-q] [-n] [-f @var{fmt}] [-t @var{cache}] [-T @var{src_cache}] [-O @var{output_fmt}] [-o @var{options}] [-s @var{snapshot_id_or_name}] [-l @var{snapshot_param}] [-S @var{sparse_size}] [-m @var{num_coroutines}] [-W] [-U] @var{filename} [@var{filename2} [...]] @var{output_filename}
>  ETEXI

v15 got this change right, but v16 adds -U twice for convert.

Kevin
