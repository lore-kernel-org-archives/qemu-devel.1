Received: from eggs.gnu.org ([2001:4830:134:3::10]:34030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ebjlg-00065L-Mp
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 04:12:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ebjlc-00005S-LJ
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 04:12:24 -0500
From: Thomas Huth <thuth@redhat.com>
References: <1516034665-27606-1-git-send-email-walling@linux.vnet.ibm.com>
	<1516034665-27606-6-git-send-email-walling@linux.vnet.ibm.com>
	<315c794c-7e75-fd90-8327-b22847247983@redhat.com>
Message-ID: <a3545fd6-0756-9328-0790-ede139fcc996@redhat.com>
Date: Wed, 17 Jan 2018 10:12:13 +0100
MIME-Version: 1.0
In-Reply-To: <315c794c-7e75-fd90-8327-b22847247983@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v3 5/8] s390-ccw: interactive
 boot menu for eckd dasd (read stage2 data)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Collin L. Walling" <walling@linux.vnet.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: alifm@linux.vnet.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, david@redhat.com, frankja@linux.vnet.ibm.com

On 17.01.2018 09:38, Thomas Huth wrote:
> On 15.01.2018 17:44, Collin L. Walling wrote:
[...]
>> +        if (find_zipl_boot_menu_banner(&offset)) {
>> +            /* Load the adjacent blocks to account for the
>> +             * possibility of menu data spanning multiple blocks.
>> +             */
>> +            if (prev_block_nr) {
> 
> You did not pre-initialize prev_block_nr = 0 at the beginning of the
> function. Do you feel confident enough that the first block never
> contains the zipl banner? If not, please set prev_block_nr = 0 before
> entering the for-loop.

Ah, I just noticed that this is also the issue that has been reported by
patchew. So you've got to set prev_block_nr = 0 anyway to keep all
compilers happy ;-)

 Thomas
