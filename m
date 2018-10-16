Received: from eggs.gnu.org ([2001:4830:134:3::10]:47634)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gCOot-00017U-17
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 08:51:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gCOor-0003H9-TJ
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 08:51:30 -0400
Date: Tue, 16 Oct 2018 14:51:10 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181016125110.GG5620@dhcp-200-186.str.redhat.com>
References: <20181015200319.23076-1-crosa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181015200319.23076-1-crosa@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH] iotests: make 083 specific to raw
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org

Am 15.10.2018 um 22:03 hat Cleber Rosa geschrieben:
> While testing the Python 3 changes which touch the 083 test, I noticed
> that it would fail with qcow2.  Expanding the testing, I noticed it
> had nothing to do with the Python 3 changes, and in fact, it would not
> pass on anything but raw:
> 
>  raw: pass
>  bochs: not generic
>  cloop: not generic
>  parallels: fail
>  qcow: fail
>  qcow2: fail
>  qed: fail
>  vdi: fail
>  vhdx: fail
>  vmdk: fail
>  vpc: fail
>  luks: fail
> 
> The errors are a mixture I/O and "image not in xxx format", such as:
> 
>   === Check disconnect before data ===
> 
>   Unexpected end-of-file before all bytes were read
>  -read failed: Input/output error
>  +can't open device nbd+tcp://127.0.0.1:PORT/foo: Could not open 'nbd://127.0.0.1:PORT/foo': Input/output error
> 
>   === Check disconnect after data ===
> 
>  -read 512/512 bytes at offset 0
>  -512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>  +can't open device nbd+tcp://127.0.0.1:PORT/foo: Image not in qcow format
> 
> I'm not aware if there's a quick fix, so, for the time being, it looks
> like the honest approach is to make the test known to work on raw
> only.
> 
> Signed-off-by: Cleber Rosa <crosa@redhat.com>

Yes, that makes sense to me.

Thanks, applied to the block branch.

Kevin
