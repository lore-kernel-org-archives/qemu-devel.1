Received: from eggs.gnu.org ([2001:4830:134:3::10]:60789)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1dtscn-00012a-Uz
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 05:46:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1dtsck-0006Lj-Sd
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 05:45:58 -0400
References: <20170817091542.9403-1-pbutsykin@virtuozzo.com>
	<9e6b08b2-6f01-3d35-2644-a86955770844@redhat.com>
	<f67eb552-e0d1-c566-a798-2e9c73a69cd2@redhat.com>
From: Pavel Butsykin <pbutsykin@virtuozzo.com>
Message-ID: <ead8f62b-8fb5-b7c0-9432-c6c7a424a088@virtuozzo.com>
Date: Mon, 18 Sep 2017 12:45:36 +0300
MIME-Version: 1.0
In-Reply-To: <f67eb552-e0d1-c566-a798-2e9c73a69cd2@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 0/4] Add shrink image for qcow2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, den@openvz.org

On 16.09.2017 17:56, Max Reitz wrote:
> On 2017-08-22 01:31, John Snow wrote:
>>
>>
>> On 08/17/2017 05:15 AM, Pavel Butsykin wrote:
>>> This patch add shrinking of the image file for qcow2. As a result, this allows
>>> us to reduce the virtual image size and free up space on the disk without
>>> copying the image. Image can be fragmented and shrink is done by punching holes
>>> in the image file.
>>>
>>> # ./qemu-img create -f qcow2 image.qcow2 4G
>>> Formatting 'image.qcow2', fmt=qcow2 size=4294967296 encryption=off cluster_size=65536 lazy_refcounts=off refcount_bits=16
>>>
>>> # ./qemu-io -c "write -P 0x22 0 1G" image.qcow2
>>> wrote 1073741824/1073741824 bytes at offset 0
>>> 1 GiB, 1 ops; 0:00:04.59 (222.886 MiB/sec and 0.2177 ops/sec)
>>>
>>> # ./qemu-img resize image.qcow2 512M
>>> warning: qemu-img: Shrinking an image will delete all data beyond the shrunken image's end. Before performing such an operation, make sure there is no important data there.
>>> error: qemu-img: Use the --shrink option to perform a shrink operation.
>>>
>>> # ./qemu-img resize --shrink image.qcow2 128M
>>> Image resized.
>>>
>>> # ./qemu-img info image.qcow2
>>> image: image.qcow2
>>> file format: qcow2
>>> virtual size: 128M (134217728 bytes)
>>> disk size: 128M
>>> cluster_size: 65536
>>> Format specific information:
>>>      compat: 1.1
>>>      lazy refcounts: false
>>>      refcount bits: 16
>>>      corrupt: false
>>>
>>> # du -h image.qcow2
>>> 129M    image.qcow2
>>>
>>
>> It looks sane to me, and already has a full set of R-Bs from Max. Are we
>> waiting for Kevin?
> 
> Now I found that I was waiting for my own R-b for patch 3.  I hadn't yet
> reviewed that patch in its current state (I had reviewed it for v5, but
> it has changed quite a bit in v6)

I decided that small changes are not considered :) I'm sorry for the
confusion with the R-b.


> Max
> 
