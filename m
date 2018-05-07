Received: from eggs.gnu.org ([2001:4830:134:3::10]:57005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hsp.cat7@gmail.com>) id 1fFmgz-0006gr-FH
	for qemu-devel@nongnu.org; Mon, 07 May 2018 16:25:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hsp.cat7@gmail.com>) id 1fFmgy-0008D8-I7
	for qemu-devel@nongnu.org; Mon, 07 May 2018 16:25:05 -0400
MIME-Version: 1.0
In-Reply-To: <539d5d61-8d58-0ffc-e56a-a3ddec5cea86@redhat.com>
References: <CABLmASE-AqqfVEZ5Q-vWBuXRTHTHhW9=c5f2PRZ34tVCMiRfdg@mail.gmail.com>
	<539d5d61-8d58-0ffc-e56a-a3ddec5cea86@redhat.com>
From: Howard Spoelstra <hsp.cat7@gmail.com>
Date: Mon, 7 May 2018 22:25:01 +0200
Message-ID: <CABLmASG6GLixmciH7Q-Q7=yQDZEbp0=wyUtb+v91CJY2un9gMQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Compilation error for qemu-system-ppc on Fedora 28
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-ppc <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Greg Kurz <groug@kaod.org>

On Mon, May 7, 2018 at 7:51 PM, Eric Blake <eblake@redhat.com> wrote:
> On 05/06/2018 05:56 AM, Howard Spoelstra wrote:
>>
>> Hi all,
>>
>> I get these errors compiling qemu-system-ppc on Fedora 28, gcc 8.0.1:
>>
>> /home/hsp/src/qemu-master/hw/ppc/e500.c: In function
>> =E2=80=98ppce500_load_device_tree=E2=80=99:
>> /home/hsp/src/qemu-master/hw/ppc/e500.c:442:37: error: =E2=80=98/pic@=E2=
=80=99
>> directive output may be truncated writing 5 bytes into a region of
>> size between 1 and 128 [-Werror=3Dformat-truncation=3D]
>>       snprintf(mpic, sizeof(mpic), "%s/pic@%llx", soc,
>> MPC8544_MPIC_REGS_OFFSET);
>>                                       ^~~~~
>
>
> Looks like this fixes it:
> https://lists.gnu.org/archive/html/qemu-devel/2018-05/msg01359.html
>

Yes it does. I already did let Greg know, but forget to reply to all. Thank=
s.

Best, Howard
