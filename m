Received: from eggs.gnu.org ([2001:4830:134:3::10]:36552)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dVGla-0005HA-V3
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 08:29:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dVGlX-0002Qn-QJ
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 08:29:19 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35494)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1dVGlX-0002QZ-Jj
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 08:29:15 -0400
Received: by mail-wr0-f196.google.com with SMTP id y28so908575wrd.2
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 05:29:15 -0700 (PDT)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <040c4483-73f0-7f3b-d2af-b56bc83b0e53@redhat.com>
References: <cover.1499774331.git.alistair.francis@xilinx.com>
	<12e6dde67e57a0ecf09fbe6103512543113ca07a.1499774331.git.alistair.francis@xilinx.com>
	<040c4483-73f0-7f3b-d2af-b56bc83b0e53@redhat.com>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Wed, 12 Jul 2017 14:27:43 +0200
Message-ID: <CAKmqyKP+cpiAXMN5eE5D=Q8ewqZtttnUz=LJY+Hj2TUoGKGE+Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 8/8] error: Add a 'error: ' prefix to
 error_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: Alistair Francis <alistair.francis@xilinx.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, philippe@mathieu-daude.net, Markus Armbruster <armbru@redhat.com>

On Tue, Jul 11, 2017 at 7:44 PM, Max Reitz <mreitz@redhat.com> wrote:
> On 2017-07-11 14:07, Alistair Francis wrote:
>> As we don't regard error messages as a stable API the let's add a
>> 'error: ' prefix to the original error_report() messages.
>>
>> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
>> ---
>>
>>  util/qemu-error.c | 1 +
>>  1 file changed, 1 insertion(+)
>
> This breaks quite a few qemu-iotests.

Hmmm... Ok, I'll have to dig into that.

I'm traveling at the moment so I won't get a chance to fix this. I'm
going to send the next version of this series, but remove this patch
and I can look at adding it again when I get back. There is already a
few things that have been pointed out that need to be fixed after this
patch set.

Do people think we should add this prefix or leave the error messages
as is? I haven't heard a definitive answer if people think this is the
right path to take.

Thanks,
Alistair

>
> Max
>
