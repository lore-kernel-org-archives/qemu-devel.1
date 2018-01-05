Received: from eggs.gnu.org ([2001:4830:134:3::10]:42520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anthoine.bourgeois@gmail.com>) id 1eXV81-0004dx-Fe
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 11:45:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anthoine.bourgeois@gmail.com>) id 1eXV80-0000XB-RM
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 11:45:57 -0500
Date: Fri, 5 Jan 2018 17:45:47 +0100
From: Anthoine Bourgeois <anthoine.bourgeois@gmail.com>
Message-ID: <20180105164546.uowtoxppyjpafxcs@gmail.com>
References: <20180104024228.11780-1-famz@redhat.com>
	<a288c5a1-e9ff-b50a-ee1e-1b48ab29e31a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <a288c5a1-e9ff-b50a-ee1e-1b48ab29e31a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] scsi: Don't deference in_buf if NULL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org

On Thu, Jan 04, 2018 at 11:02:25AM -0600, Eric Blake wrote:
>On 01/03/2018 08:42 PM, Fam Zheng wrote:
>> scsi_disk_emulate_command passes in_buf=NULL and in_len=0 in the
>> REQUEST_SENSE branch. Inline the fixed_in evaluation and put it after
>> the in_len test.
>>
>> Signed-off-by: Fam Zheng <famz@redhat.com>
>> ---
>>  scsi/utils.c | 4 +---
>>  1 file changed, 1 insertion(+), 3 deletions(-)
>
>Huh?  'fixed' is already a bool, so '!!fixed' is just extra typing that
>makes things harder to read.  Did you mean:
>
>if (in_len && fixed == !(in_buf[0] & 2))
>
>as something that is slightly more legible (the LHS is already bool, the
>RHS uses a single ! to convert a bitwise test into a bool with the
>correct sense)?

It seems correct and clearer.

With Eric's modification:
Tested-by: Anthoine Bourgeois <anthoine.bourgeois@gmail.com>
