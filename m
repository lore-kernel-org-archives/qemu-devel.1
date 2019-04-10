Received: from eggs.gnu.org ([209.51.188.92]:50172)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arekm@maven.pl>) id 1hE8HU-0003Hu-KK
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 04:08:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arekm@maven.pl>) id 1hE8HS-0004u0-Me
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 04:08:28 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:36315)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arekm@maven.pl>) id 1hE8HO-0004pv-UJ
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 04:08:25 -0400
Received: by mail-lj1-x241.google.com with SMTP id r24so1248521ljg.3
	for <qemu-devel@nongnu.org>; Wed, 10 Apr 2019 01:08:20 -0700 (PDT)
References: <20190410040826.24371-1-pagupta@redhat.com>
From: =?UTF-8?Q?Arkadiusz_Mi=c5=9bkiewicz?= <arekm@maven.pl>
Message-ID: <946ba5b9-62c1-aaec-9ca7-a71e154340db@maven.pl>
Date: Wed, 10 Apr 2019 10:08:15 +0200
MIME-Version: 1.0
In-Reply-To: <20190410040826.24371-1-pagupta@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: pl
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 0/6] virtio pmem driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pankaj Gupta <pagupta@redhat.com>, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-acpi@vger.kernel.org, qemu-devel@nongnu.org, linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
Cc: dan.j.williams@intel.com, zwisler@kernel.org, vishal.l.verma@intel.com, dave.jiang@intel.com, mst@redhat.com, jasowang@redhat.com, willy@infradead.org, rjw@rjwysocki.net, hch@infradead.org, lenb@kernel.org, jack@suse.cz, tytso@mit.edu, adilger.kernel@dilger.ca, darrick.wong@oracle.com, lcapitulino@redhat.com, kwolf@redhat.com, imammedo@redhat.com, jmoyer@redhat.com, nilal@redhat.com, riel@surriel.com, stefanha@redhat.com, aarcange@redhat.com, david@redhat.com, david@fromorbit.com, cohuck@redhat.com, xiaoguangrong.eric@gmail.com, pbonzini@redhat.com, kilobyte@angband.pl, yuval.shaia@oracle.com

On 10/04/2019 06:08, Pankaj Gupta wrote:
>  This patch series has implementation for "virtio pmem". 
>  "virtio pmem" is fake persistent memory(nvdimm) in guest 
>  which allows to bypass the guest page cache. This also

Will kernel pstore be able to use this persistent memory for storing
crash dumps?

-- 
Arkadiusz Miśkiewicz, arekm / ( maven.pl | pld-linux.org )
