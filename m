Received: from eggs.gnu.org ([2001:4830:134:3::10]:39964)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eCN68-0001kC-SR
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 04:56:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eCN68-0002W4-7b
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 04:56:40 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20171107164349.GE4706@localhost.localdomain>
References: <cover.1509718618.git.berto@igalia.com>
	<f9750f50c80359babba11062e88f5075a47e8e16.1509718618.git.berto@igalia.com>
	<20171107164349.GE4706@localhost.localdomain>
Date: Wed, 08 Nov 2017 10:55:56 +0100
Message-ID: <w51tvy5ytzn.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 4/7] qcow2: Don't open
 images with header.refcount_table_clusters == 0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, "R . Nageswara Sastry" <nasastry@in.ibm.com>

On Tue 07 Nov 2017 05:43:49 PM CET, Kevin Wolf wrote:
>> +echo
>> +echo "=== Testing zero refcount table size ==="
>> +echo
>> +_make_test_img 64M
>> +poke_file "$TEST_IMG" "56"                "\x00\x00\x00\x00"
>> +$QEMU_IO -c "write 0 64k" "$TEST_IMG" 2>&1 | _filter_testdir | _filter_imgfmt
>
> In the commit message, you claim that the image can be repaired. Would
> it be worth actually testing the repair here?

Good idea. Max already merged this series in his branch, so I'll just
send a follow-up patch with this.

Berto
