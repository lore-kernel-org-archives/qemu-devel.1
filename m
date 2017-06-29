Received: from eggs.gnu.org ([2001:4830:134:3::10]:39030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dQcST-0003xJ-Aq
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 12:38:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dQcSS-00067n-IH
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 12:38:21 -0400
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <eb27d632-fae4-23da-48cc-e0c94b9bc584@redhat.com>
References: <cover.1498607452.git.alistair.francis@xilinx.com>
	<6955f1684346baf57b619ca407cd71363027307a.1498607452.git.alistair.francis@xilinx.com>
	<eb27d632-fae4-23da-48cc-e0c94b9bc584@redhat.com>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Thu, 29 Jun 2017 09:37:48 -0700
Message-ID: <CAKmqyKMvOukarSU_KG0CF8pY04Yp7RB1RxBV8pZPhWUm2b-Jcg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC v1 2/4] util/oslib-win32: Remove invalid check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alistair Francis <alistair.francis@xilinx.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Edgar Iglesias <edgar.iglesias@xilinx.com>, qemu-block@nongnu.org

On Thu, Jun 29, 2017 at 6:32 AM, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 28/06/2017 01:57, Alistair Francis wrote:
>> There is no way nhandles can be zero in this section so that part of the
>> if statement will always be false. Let's just remove it to make the code
>> easier to read.
>>
>> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
>> Acked-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
>> ---
>>
>>  util/oslib-win32.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/util/oslib-win32.c b/util/oslib-win32.c
>> index 80e4668935..7ec0f8e083 100644
>> --- a/util/oslib-win32.c
>> +++ b/util/oslib-win32.c
>> @@ -414,7 +414,7 @@ static int poll_rest(gboolean poll_msgs, HANDLE *handles, gint nhandles,
>>          /* If we have a timeout, or no handles to poll, be satisfied
>>           * with just noticing we have messages waiting.
>>           */
>> -        if (timeout != 0 || nhandles == 0) {
>> +        if (timeout != 0) {
>>              return 1;
>>          }
>>
>>
>
> Hmm, I think it's possible, poll_msgs is true here.

poll_msgs?

If nhandles is 0 then we have already entered an earlier if statement
and set ready to either WAIT_FAILED or WAIT_TIMEOUT in which case we
can't enter this part of the if statement.

Thanks,
Alistair

>
> Paolo
