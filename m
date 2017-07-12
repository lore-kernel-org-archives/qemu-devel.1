Received: from eggs.gnu.org ([2001:4830:134:3::10]:60241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dVFDh-0002VF-Kp
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 06:50:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dVFDd-0008Dt-GY
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 06:50:13 -0400
Received: from mail-wr0-f173.google.com ([209.85.128.173]:34572)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1dVFDd-0008Cc-A1
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 06:50:09 -0400
Received: by mail-wr0-f173.google.com with SMTP id 77so28230454wrb.1
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 03:50:09 -0700 (PDT)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <87k23eay0f.fsf@dusky.pond.sub.org>
References: <cover.1499774331.git.alistair.francis@xilinx.com>
	<b0192a116ac0fdd125f49f257c6c6dbbc2666969.1499774331.git.alistair.francis@xilinx.com>
	<87k23eay0f.fsf@dusky.pond.sub.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Wed, 12 Jul 2017 12:48:37 +0200
Message-ID: <CAKmqyKOQVA_zBsj5C994i8gjasg4Yw-46GDB0MysxFNow+615Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 2/8] error: Functions to report warnings
 and informational messages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Alistair Francis <alistair.francis@xilinx.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, philippe@mathieu-daude.net

On Wed, Jul 12, 2017 at 9:57 AM, Markus Armbruster <armbru@redhat.com> wrote:
> Alistair Francis <alistair.francis@xilinx.com> writes:
>
>> Add warn_report(), warn_vreport() for reporting warnings, and
>> info_report(), info_vreport() for informational messages.
>>
>> These are implemented them with a helper function factored out of
>> error_vreport(), suitably generalized. This patch makes no changes
>> to the output of the original error_report() function.
>>
>> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
>> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>> ---
>> v2:
>>  - Don't add *vreport() functions to checkpatch
>>  - Maintain original comments for the reporting functions
>>  - Don't change the error report output in this patch
>> v1:
>>  - Don't expose the generic report and vreport() functions
>>  - Prefix error messages
>>  - Use vreport instead of qmsg_vreport()
>> RFC V3:
>>  - Change the function and enum names to be more descriptive
>>  - Add wrapper functions for *_report() and *_vreport()
>>
>>  include/qemu/error-report.h |   7 +++
>>  scripts/checkpatch.pl       |   6 ++-
>>  util/qemu-error.c           | 102 +++++++++++++++++++++++++++++++++++++++++---
>>  3 files changed, 109 insertions(+), 6 deletions(-)
> [...]
>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
>> index 73efc927a9..60b1f320a1 100755
>> --- a/scripts/checkpatch.pl
>> +++ b/scripts/checkpatch.pl
>> @@ -2535,7 +2535,11 @@ sub process {
>>                               error_prepend|
>>                               error_reportf_err|
>>                               error_vreport|
>> -                             error_report}x;
>> +                             report_vreport|
>
> Should be warn_vreport, oops.  I can fix this on commit.

I have to send a new version anyway so I'll just fix it.

Thanks,
Alistair

>
>> +                             info_vreport|
>> +                             error_report|
>> +                             warn_report|
>> +                             info_report}x;
>>
>>       if ($rawline =~ /\b(?:$qemu_error_funcs)\s*\(.*\".*\\n/) {
>>               ERROR("Error messages should not contain newlines\n" . $herecurr);
> [...]
