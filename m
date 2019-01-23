Received: from eggs.gnu.org ([209.51.188.92]:34930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gmKVF-0007fY-8y
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 10:31:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gmKVE-0005yh-Hf
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 10:31:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44836)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eric.auger@redhat.com>)
	id 1gmKVE-0005yQ-C0
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 10:31:44 -0500
References: <154825338186.21.2661799743092991292@ebba9967afc0>
	<e15a4bfd-ce73-62c8-3338-d35a429951b8@redhat.com>
	<47263739-35c6-b711-dc94-3af62f5a2bbe@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <2c8154ca-0e6f-8c52-dced-9dda1bb7ea4d@redhat.com>
Date: Wed, 23 Jan 2019 16:31:36 +0100
MIME-Version: 1.0
In-Reply-To: <47263739-35c6-b711-dc94-3af62f5a2bbe@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] hw/vfio/common: Refactor container
 initialization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, no-reply@patchew.org
Cc: fam@euphon.net, aik@ozlabs.ru, alex.williamson@redhat.com, groug@kaod.org, eric.auger.pro@gmail.com

Hi Eric,

On 1/23/19 4:01 PM, Eric Blake wrote:
> On 1/23/19 8:44 AM, Auger Eric wrote:
> 
>>> /tmp/qemu-test/src/block/sheepdog.c: In function 'find_vdi_name':
>>> /tmp/qemu-test/src/block/sheepdog.c:1239:5: error: 'strncpy' specified bound 256 equals destination size [-Werror=stringop-truncation]
>>>      strncpy(buf + SD_MAX_VDI_LEN, tag, SD_MAX_VDI_TAG_LEN);
>>>      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> does not seem to be related to my patch.
> 
> Known false alarm; the patchew processing queue is backlogged, and is
> testing patches against a version of qemu.git that does not yet have
> patches for newer gcc compliance incorporated, while at the same time
> having recently upgraded its testing environment to use the newer gcc
> that warns.  Commit 97b583f4 will silence the noise, once patchew
> catches up to using it.
Thank you for the explanation.

Eric
> 
