Received: from eggs.gnu.org ([2001:4830:134:3::10]:37456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gSpmX-00056M-K5
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 15:53:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gSpmW-0004a4-NF
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 15:53:01 -0500
References: <cover.1543610035.git.alifm@linux.ibm.com>
	<3130ecca88d5f7d97860c05cf1346164938cb15d.1543610035.git.alifm@linux.ibm.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <cbd1ca87-b547-5649-7449-2f4de203dfd9@redhat.com>
Date: Fri, 30 Nov 2018 14:52:48 -0600
MIME-Version: 1.0
In-Reply-To: <3130ecca88d5f7d97860c05cf1346164938cb15d.1543610035.git.alifm@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC for 3.1? or 4 v3 1/1] qemu-iotests: Don't run
 the test when user is root
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Farhan Ali <alifm@linux.ibm.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, kwolf@redhat.com

On 11/30/18 2:37 PM, Farhan Ali wrote:
> Test 232 creates image files with read-only permission and
> expects an error message when trying to access the image
> files with read-only and auto-read-only turned off.
> 
> Don't run as root user, since root can open files with read/write
> access for read-only files.
> 
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> ---
>   tests/qemu-iotests/232 | 5 +++++
>   1 file changed, 5 insertions(+)

Did you mean to keep RFC in the subject line?  Will patchew even spot it 
without PATCH in the subject line?

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
