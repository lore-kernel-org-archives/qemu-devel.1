Received: from eggs.gnu.org ([2001:4830:134:3::10]:44022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gCABW-0007dE-KP
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 17:13:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gCABV-0006iZ-Co
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 17:13:54 -0400
References: <20181015141453.32632-1-mreitz@redhat.com>
	<20181015141453.32632-5-mreitz@redhat.com>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <b5f45c50-eb78-837e-e1be-114fe758aae6@redhat.com>
Date: Mon, 15 Oct 2018 17:13:43 -0400
MIME-Version: 1.0
In-Reply-To: <20181015141453.32632-5-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/9] iotests: Use // for Python integer
 division
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>



On 10/15/18 10:14 AM, Max Reitz wrote:
> In Python 3, / is always a floating-point division.  We usually do not
> want this, and as Python 2.7 understands // as well, change all integer
> divisions to use that.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  tests/qemu-iotests/040        |  4 ++--
>  tests/qemu-iotests/044        |  2 +-
>  tests/qemu-iotests/093        | 18 +++++++++---------
>  tests/qemu-iotests/149        |  6 +++---
>  tests/qemu-iotests/151        | 12 ++++++------
>  tests/qemu-iotests/163        |  2 +-
>  tests/qemu-iotests/iotests.py |  2 +-
>  7 files changed, 23 insertions(+), 23 deletions(-)
> 
> diff --git a/tests/qemu-iotests/040 b/tests/qemu-iotests/040
> index 1cb1ceeb33..b81133a474 100755
> --- a/tests/qemu-iotests/040
> +++ b/tests/qemu-iotests/040
> @@ -195,7 +195,7 @@ class TestSingleDrive(ImageCommitTestCase):
>  
>          self.assert_no_active_block_jobs()
>          result = self.vm.qmp('block-commit', device='drive0', top=mid_img,
> -                             base=backing_img, speed=(self.image_len / 4))
> +                             base=backing_img, speed=(self.image_len // 4))
>          self.assert_qmp(result, 'return', {})
>          result = self.vm.qmp('device_del', id='scsi0')
>          self.assert_qmp(result, 'return', {})
> @@ -225,7 +225,7 @@ class TestSingleDrive(ImageCommitTestCase):
>  
>          self.assert_no_active_block_jobs()
>          result = self.vm.qmp('block-commit', device='drive0', top=mid_img,
> -                             base=backing_img, speed=(self.image_len / 4))
> +                             base=backing_img, speed=(self.image_len // 4))
>          self.assert_qmp(result, 'return', {})
>  
>          result = self.vm.qmp('query-block')
> diff --git a/tests/qemu-iotests/044 b/tests/qemu-iotests/044
> index 69e736f687..7ef5e46fe9 100755
> --- a/tests/qemu-iotests/044
> +++ b/tests/qemu-iotests/044
> @@ -86,7 +86,7 @@ class TestRefcountTableGrowth(iotests.QMPTestCase):
>                  off = off + 1024 * 512
>  
>              table = b''.join(struct.pack('>Q', (1 << 63) | off + 512 * j)
> -                for j in xrange(0, remaining / 512))
> +                for j in xrange(0, remaining // 512))
>              fd.write(table)
>  
>  
> diff --git a/tests/qemu-iotests/093 b/tests/qemu-iotests/093
> index 9d1971a56c..d88fbc182e 100755
> --- a/tests/qemu-iotests/093
> +++ b/tests/qemu-iotests/093
> @@ -69,18 +69,18 @@ class ThrottleTestCase(iotests.QMPTestCase):
>          # in. The throttled requests won't be executed until we
>          # advance the virtual clock.
>          rq_size = 512
> -        rd_nr = max(params['bps'] / rq_size / 2,
> -                    params['bps_rd'] / rq_size,
> -                    params['iops'] / 2,
> +        rd_nr = max(params['bps'] // rq_size // 2,
> +                    params['bps_rd'] // rq_size,
> +                    params['iops'] // 2,
>                      params['iops_rd'])
>          rd_nr *= seconds * 2
> -        rd_nr /= ndrives
> -        wr_nr = max(params['bps'] / rq_size / 2,
> -                    params['bps_wr'] / rq_size,
> -                    params['iops'] / 2,
> +        rd_nr //= ndrives
> +        wr_nr = max(params['bps'] // rq_size // 2,
> +                    params['bps_wr'] // rq_size,
> +                    params['iops'] // 2,
>                      params['iops_wr'])
>          wr_nr *= seconds * 2
> -        wr_nr /= ndrives
> +        wr_nr //= ndrives
>  
>          # Send I/O requests to all drives
>          for i in range(rd_nr):
> @@ -196,7 +196,7 @@ class ThrottleTestCase(iotests.QMPTestCase):
>              self.configure_throttle(ndrives, settings)
>  
>              # Wait for the bucket to empty so we can do bursts
> -            wait_ns = nsec_per_sec * burst_length * burst_rate / rate
> +            wait_ns = nsec_per_sec * burst_length * burst_rate // rate
>              self.vm.qtest("clock_step %d" % wait_ns)
>  
>              # Test I/O at the max burst rate
> diff --git a/tests/qemu-iotests/149 b/tests/qemu-iotests/149
> index 1225334cb8..4f363f295f 100755
> --- a/tests/qemu-iotests/149
> +++ b/tests/qemu-iotests/149
> @@ -314,13 +314,13 @@ def test_once(config, qemu_img=False):
>      image_size = 4 * oneTB
>      if qemu_img:
>          iotests.log("# Create image")
> -        qemu_img_create(config, image_size / oneMB)
> +        qemu_img_create(config, image_size // oneMB)
>      else:
>          iotests.log("# Create image")
> -        create_image(config, image_size / oneMB)
> +        create_image(config, image_size // oneMB)
>  
>      lowOffsetMB = 100
> -    highOffsetMB = 3 * oneTB / oneMB
> +    highOffsetMB = 3 * oneTB // oneMB
>  
>      try:
>          if not qemu_img:
> diff --git a/tests/qemu-iotests/151 b/tests/qemu-iotests/151
> index fe53b9f446..1bb74d67c4 100755
> --- a/tests/qemu-iotests/151
> +++ b/tests/qemu-iotests/151
> @@ -67,9 +67,9 @@ class TestActiveMirror(iotests.QMPTestCase):
>                              'write -P 1 0 %i' % self.image_len);
>  
>          # Start some background requests
> -        for offset in range(1 * self.image_len / 8, 3 * self.image_len / 8, 1024 * 1024):
> +        for offset in range(1 * self.image_len // 8, 3 * self.image_len // 8, 1024 * 1024):
>              self.vm.hmp_qemu_io('source', 'aio_write -P 2 %i 1M' % offset)
> -        for offset in range(2 * self.image_len / 8, 3 * self.image_len / 8, 1024 * 1024):
> +        for offset in range(2 * self.image_len // 8, 3 * self.image_len // 8, 1024 * 1024):
>              self.vm.hmp_qemu_io('source', 'aio_write -z %i 1M' % offset)
>  
>          # Start the block job
> @@ -83,9 +83,9 @@ class TestActiveMirror(iotests.QMPTestCase):
>          self.assert_qmp(result, 'return', {})
>  
>          # Start some more requests
> -        for offset in range(3 * self.image_len / 8, 5 * self.image_len / 8, 1024 * 1024):
> +        for offset in range(3 * self.image_len // 8, 5 * self.image_len // 8, 1024 * 1024):
>              self.vm.hmp_qemu_io('source', 'aio_write -P 3 %i 1M' % offset)
> -        for offset in range(4 * self.image_len / 8, 5 * self.image_len / 8, 1024 * 1024):
> +        for offset in range(4 * self.image_len // 8, 5 * self.image_len // 8, 1024 * 1024):
>              self.vm.hmp_qemu_io('source', 'aio_write -z %i 1M' % offset)
>  
>          # Wait for the READY event
> @@ -95,9 +95,9 @@ class TestActiveMirror(iotests.QMPTestCase):
>          # the source) should be settled using the active mechanism.
>          # The mirror code itself asserts that the source BDS's dirty
>          # bitmap will stay clean between READY and COMPLETED.
> -        for offset in range(5 * self.image_len / 8, 7 * self.image_len / 8, 1024 * 1024):
> +        for offset in range(5 * self.image_len // 8, 7 * self.image_len // 8, 1024 * 1024):
>              self.vm.hmp_qemu_io('source', 'aio_write -P 3 %i 1M' % offset)
> -        for offset in range(6 * self.image_len / 8, 7 * self.image_len / 8, 1024 * 1024):
> +        for offset in range(6 * self.image_len // 8, 7 * self.image_len // 8, 1024 * 1024):
>              self.vm.hmp_qemu_io('source', 'aio_write -z %i 1M' % offset)
>  
>          if sync_source_and_target:
> diff --git a/tests/qemu-iotests/163 b/tests/qemu-iotests/163
> index 403842354e..5fd424761b 100755
> --- a/tests/qemu-iotests/163
> +++ b/tests/qemu-iotests/163
> @@ -38,7 +38,7 @@ class ShrinkBaseClass(iotests.QMPTestCase):
>          entry_bits = 3
>          entry_size = 1 << entry_bits
>          l1_mask = 0x00fffffffffffe00
> -        div_roundup = lambda n, d: (n + d - 1) / d
> +        div_roundup = lambda n, d: (n + d - 1) // d
>  
>          def split_by_n(data, n):
>              for x in xrange(0, len(data), n):
> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
> index 7290c0b159..7ca94e9278 100644
> --- a/tests/qemu-iotests/iotests.py
> +++ b/tests/qemu-iotests/iotests.py
> @@ -199,7 +199,7 @@ def create_image(name, size):
>      file = open(name, 'wb')
>      i = 0
>      while i < size:
> -        sector = struct.pack('>l504xl', i / 512, i / 512)
> +        sector = struct.pack('>l504xl', i // 512, i // 512)
>          file.write(sector)
>          i = i + 512
>      file.close()
> 

Found a few other occurrences:

030:''' % (event, errno, self.STREAM_BUFFER_SIZE / 512, event, event))
041:''' % (event, errno, self.MIRROR_GRANULARITY / 512, event, event))
041:''' % (event, errno, self.MIRROR_GRANULARITY / 512, event, event))

- Cleber.
