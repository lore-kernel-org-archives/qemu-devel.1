Received: from eggs.gnu.org ([2001:4830:134:3::10]:60085)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gRw63-0007NH-6C
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 04:25:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gRw60-0006cN-06
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 04:25:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:4469)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gRw5w-0006Yv-6y
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 04:25:22 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <cover.1542384802.git.xiezhide@huawei.com>
	<a4bc041444fd76d5da1d8e5321007f416df4ab84.1542384802.git.xiezhide@huawei.com>
Date: Wed, 28 Nov 2018 10:25:15 +0100
In-Reply-To: <a4bc041444fd76d5da1d8e5321007f416df4ab84.1542384802.git.xiezhide@huawei.com>
	(xiezhide's message of "Fri, 16 Nov 2018 15:59:35 +0800")
Message-ID: <87ftvlh7us.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v5 2/6] fsdev-throttle-qmp: Rename the
 ThrottleLimits member names
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: xiezhide <xiezhide@huawei.com>
Cc: qemu-devel@nongnu.org, berto@igalia.com, armbru@redhat.com, zengcanfu@huawei.com, groug@kaod.org, aneesh.kumar@linux.vnet.ibm.com, jinxuefeng@huawei.com, chenhui.rtos@huawei.com

xiezhide <xiezhide@huawei.com> writes:

> Rename the ThrottleLimits member names and modify related code
>
> Signed-off-by: xiezhide <xiezhide@huawei.com>
> ---
>  qapi/block-core.json |  70 +++++++++++-----------
>  util/throttle.c      | 163 +++++++++++++++++++++++++--------------------------
>  2 files changed, 116 insertions(+), 117 deletions(-)
>
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index d4fe710..4ffaaea 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -2240,45 +2240,45 @@
>  # transaction. All fields are optional. When setting limits, if a field is
>  # missing the current value is not changed.
>  #
> -# @iops-total:             limit total I/O operations per second
> -# @iops-total-max:         I/O operations burst
> -# @iops-total-max-length:  length of the iops-total-max burst period, in seconds
> -#                          It must only be set if @iops-total-max is set as well.
> -# @iops-read:              limit read operations per second
> -# @iops-read-max:          I/O operations read burst
> -# @iops-read-max-length:   length of the iops-read-max burst period, in seconds
> -#                          It must only be set if @iops-read-max is set as well.
> -# @iops-write:             limit write operations per second
> -# @iops-write-max:         I/O operations write burst
> -# @iops-write-max-length:  length of the iops-write-max burst period, in seconds
> -#                          It must only be set if @iops-write-max is set as well.
> -# @bps-total:              limit total bytes per second
> -# @bps-total-max:          total bytes burst
> -# @bps-total-max-length:   length of the bps-total-max burst period, in seconds.
> -#                          It must only be set if @bps-total-max is set as well.
> -# @bps-read:               limit read bytes per second
> -# @bps-read-max:           total bytes read burst
> -# @bps-read-max-length:    length of the bps-read-max burst period, in seconds
> -#                          It must only be set if @bps-read-max is set as well.
> -# @bps-write:              limit write bytes per second
> -# @bps-write-max:          total bytes write burst
> -# @bps-write-max-length:   length of the bps-write-max burst period, in seconds
> -#                          It must only be set if @bps-write-max is set as well.
> -# @iops-size:              when limiting by iops max size of an I/O in bytes
> +# @iops:             limit total I/O operations per second
> +# @iops_max:         I/O operations burst
> +# @iops_max_length:  length of the iops_total_max burst period, in seconds
> +#                          It must only be set if @iops_total_max is set as well.
> +# @iops_rd:              limit read operations per second
> +# @iops_rd_max:          I/O operations read burst
> +# @iops_rd_max_length:   length of the iops_read_max burst period, in seconds
> +#                          It must only be set if @iops_read_max is set as well.
> +# @iops_wr:             limit write operations per second
> +# @iops_wr_max:         I/O operations write burst
> +# @iops_wr_max_length:  length of the iops_write_max burst period, in seconds
> +#                          It must only be set if @iops_write_max is set as well.
> +# @bps:              limit total bytes per second
> +# @bps_max:          total bytes burst
> +# @bps_max_length:   length of the bps_total_max burst period, in seconds.
> +#                          It must only be set if @bps_total_max is set as well.
> +# @bps_rd:               limit read bytes per second
> +# @bps_rd_max:           total bytes read burst
> +# @bps_rd_max_length:    length of the bps_read_max burst period, in seconds
> +#                          It must only be set if @bps_read_max is set as well.
> +# @bps_wr:              limit write bytes per second
> +# @bps_wr_max:          total bytes write burst
> +# @bps_wr_max_length:   length of the bps_write_max burst period, in seconds
> +#                          It must only be set if @bps_write_max is set as well.
> +# @iops_size:              when limiting by iops max size of an I/O in bytes
>  #
>  # Since: 2.11
>  ##
>  { 'struct': 'ThrottleLimits',
> -  'data': { '*iops-total' : 'int', '*iops-total-max' : 'int',
> -            '*iops-total-max-length' : 'int', '*iops-read' : 'int',
> -            '*iops-read-max' : 'int', '*iops-read-max-length' : 'int',
> -            '*iops-write' : 'int', '*iops-write-max' : 'int',
> -            '*iops-write-max-length' : 'int', '*bps-total' : 'int',
> -            '*bps-total-max' : 'int', '*bps-total-max-length' : 'int',
> -            '*bps-read' : 'int', '*bps-read-max' : 'int',
> -            '*bps-read-max-length' : 'int', '*bps-write' : 'int',
> -            '*bps-write-max' : 'int', '*bps-write-max-length' : 'int',
> -            '*iops-size' : 'int' } }
> +  'data': { '*iops' : 'int', '*iops_max' : 'int',
> +            '*iops_max_length' : 'int', '*iops_rd' : 'int',
> +            '*iops_rd_max' : 'int', '*iops_rd_max_length' : 'int',
> +            '*iops_wr' : 'int', '*iops_wr_max' : 'int',
> +            '*iops_wr_max_length' : 'int', '*bps' : 'int',
> +            '*bps_max' : 'int', '*bps_max_length' : 'int',
> +            '*bps_rd' : 'int', '*bps_rd_max' : 'int',
> +            '*bps_rd_max_length' : 'int', '*bps_wr' : 'int',
> +            '*bps_wr_max' : 'int', '*bps_wr_max_length' : 'int',
> +            '*iops_size' : 'int' } }

Compatibility break.  Why is that okay?

Even if it is, you still run afoul of docs/devel/qapi-code-gen.txt:

    Command names, and member names within a type, should be all lower
    case with words separated by a hyphen.  However, some existing older
    commands and complex types use underscore; when extending such
    expressions, consistency is preferred over blindly avoiding
    underscore.

The exception doesn't apply here.

>  
>  ##
>  # @block-stream:
[...]
