Received: from eggs.gnu.org ([2001:4830:134:3::10]:45886)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dQj4T-0000wI-Su
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 19:42:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dQj4S-0005k8-Mo
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 19:42:01 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:36803)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1dQj4S-0005jm-GR
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 19:42:00 -0400
Received: by mail-wr0-x241.google.com with SMTP id 77so37882526wrb.3
	for <qemu-devel@nongnu.org>; Thu, 29 Jun 2017 16:42:00 -0700 (PDT)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <df960468-b202-d523-d390-6d246a4091aa@redhat.com>
References: <cover.1498761179.git.alistair.francis@xilinx.com>
	<453bac0f21aa525d7c9de38d4c8c509b44c4ecda.1498761179.git.alistair.francis@xilinx.com>
	<df960468-b202-d523-d390-6d246a4091aa@redhat.com>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Thu, 29 Jun 2017 16:41:28 -0700
Message-ID: <CAKmqyKN4KFJKSdGT3-OTgoL5krXZADbW053Cm+5W3uqCyM8umg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC v2 3/3] char-socket: Report TCP socket
 waiting as information
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Alistair Francis <alistair.francis@xilinx.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, philippe@mathieu-daude.net

On Thu, Jun 29, 2017 at 1:48 PM, Eric Blake <eblake@redhat.com> wrote:
> On 06/29/2017 02:42 PM, Alistair Francis wrote:
>> When QEMU is waiting for a TCP socket connection it reports that message as
>> an error. This isn't an error it is just informaiton so let's change the
>> report to use report() instead.
>>
>> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
>> ---
>>
>>  chardev/char-socket.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
>> index ccc499cfa1..ad1b3d6e93 100644
>> --- a/chardev/char-socket.c
>> +++ b/chardev/char-socket.c
>> @@ -765,7 +765,7 @@ static int tcp_chr_wait_connected(Chardev *chr, Error **errp)
>>       * in TLS and telnet cases, only wait for an accepted socket */
>>      while (!s->ioc) {
>>          if (s->is_listen) {
>> -            error_report("QEMU waiting for connection on: %s",
>> +            report(INFO, "QEMU waiting for connection on: %s",
>>                           chr->filename);
>
> Indentation looks off now; I'd scoot chr->filename to live right under INFO.

Woops I missed that. Thanks, I made your fixes to both patches.

Thanks,
Alistair

>
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
>
