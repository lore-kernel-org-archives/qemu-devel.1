Received: from eggs.gnu.org ([2001:4830:134:3::10]:34599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dQcM3-0008J6-1M
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 12:31:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dQcM1-0001Tg-Sq
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 12:31:43 -0400
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <188253dd-dc0f-17b8-8c0d-4a3d14a6a94f@redhat.com>
References: <cover.1498607452.git.alistair.francis@xilinx.com>
	<2c339ec0264c85f9c8a4884ffb8ebe059b3b9e4b.1498607452.git.alistair.francis@xilinx.com>
	<188253dd-dc0f-17b8-8c0d-4a3d14a6a94f@redhat.com>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Thu, 29 Jun 2017 09:31:08 -0700
Message-ID: <CAKmqyKN0+JEAS5PVvHWmLPLxMsK0=RFiktuqsqGaeV8TT=p-KQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC v1 3/4] util/oslib-win32: Fix up if
 conditional
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

On Thu, Jun 29, 2017 at 5:25 AM, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
>
> On 28/06/2017 01:57, Alistair Francis wrote:
>> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
>> Acked-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
>> ---
>>
>>  util/oslib-win32.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/util/oslib-win32.c b/util/oslib-win32.c
>> index 7ec0f8e083..a015e1ac96 100644
>> --- a/util/oslib-win32.c
>> +++ b/util/oslib-win32.c
>> @@ -438,7 +438,7 @@ static int poll_rest(gboolean poll_msgs, HANDLE *handles, gint nhandles,
>>          if (timeout == 0 && nhandles > 1) {
>>              /* Remove the handle that fired */
>>              int i;
>> -            if (ready < nhandles - 1) {
>> +            if ((ready - WAIT_OBJECT_0) < nhandles - 1) {
>>                  for (i = ready - WAIT_OBJECT_0 + 1; i < nhandles; i++) {
>>                      handles[i-1] = handles[i];
>>                  }
>>
>
> WAIT_OBJECT_0 is zero, but I agree it's better to add it.
>
> However, the condition can be rewritten as ready - WAIT_OBJECT_0 + 1 <
> nhandles, which is the same as the first iteration's "i < nhandles".  So
> I'd just remove the "if" and "unindent" the for loop.

Ah, good spot. I'll remove it.

Thanks,
Alistair

>
> Paolo
