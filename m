Received: from eggs.gnu.org ([2001:4830:134:3::10]:55950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.yang@ucloud.cn>) id 1dhSw6-0002Ca-Ap
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 23:54:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.yang@ucloud.cn>) id 1dhSw1-0000si-G5
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 23:54:34 -0400
Received: from m97136.mail.qiye.163.com ([220.181.97.136]:20878)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.yang@ucloud.cn>) id 1dhSvT-0000kn-Cm
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 23:54:29 -0400
References: <20170814084838.12233-1-wei.yang@ucloud.cn>
	<20170814185545-mutt-send-email-mst@kernel.org>
	<59925A94.4070502@ucloud.cn>
	<20170815053445-mutt-send-email-mst@kernel.org>
	<59926083.4030708@ucloud.cn>
	<20170815054903-mutt-send-email-mst@kernel.org>
From: wyang <wei.yang@ucloud.cn>
Message-ID: <59927039.9000700@ucloud.cn>
Date: Tue, 15 Aug 2017 11:53:29 +0800
MIME-Version: 1.0
In-Reply-To: <20170815054903-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] bios-tables-test: delete a assert about
 block name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: imammedo@redhat.com, qemu-devel@nongnu.org


On 2017年08月15日 10:49, Michael S. Tsirkin wrote:
> BTW sizeof(BLOCK_NAME_END) is actually 2. I think it works
> because there's a space after ,. It is better to replace it with
> strlen so it will work without a space too.

MST,

I double check the failure of assert, it has already been fixed by the 
following commit,

commit a3973f551dbee91f1f6f2c78e9942fb113b5d30b
Author: Marcel Apfelbaum <marcel@redhat.com>
Date:   Mon Apr 4 20:00:57 2016 +0300

     tests/bios-tables-test: fix assert

     Newer iasl does not add the aml file name to the Definition Block.
     See acpica tools commit  1ecbb3d5:
       "Emit the AMLFilename as a zero-length string. Allows the 
compiler to create
        the name later -- making it easier to rename the parent ASL 
(DSL) file."

     That causes an assert in acpi tests:
        tests/bios-tables-test.c:455:normalize_asl: assertion failed: 
(block_name)

     Fix it by striping the start of the definition block line until the 
first comma.
     The block name is always the first parameter and
     the grammar does not allow comma in between, so it is safe.

     Reported-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
     Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
     Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
     Signed-off-by: Michael S. Tsirkin <mst@redhat.com>


I am sorry for my fault,  my qemu version does not contain the patch.:-(

Seems the only place, which needs to be fixed, is to replace sizeof with 
strlen.  Just like what you said, it is not fault but just refinement.
If you need it, I am glad to send patch to fix it.

Wei

-- 
Wei Yang(杨伟)
Mobile: +86-13436682065
Email: wei.yang@ucloud.cn
