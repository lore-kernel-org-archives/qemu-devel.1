Received: from eggs.gnu.org ([209.51.188.92]:47217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gtG9J-0003JH-JB
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 13:17:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gtG9I-0002Im-Gn
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 13:17:45 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:33919)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gtG9H-0002G0-Up
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 13:17:44 -0500
Received: by mail-pg1-x544.google.com with SMTP id d9so5321389pgl.1
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 10:17:43 -0800 (PST)
Date: Mon, 11 Feb 2019 10:17:41 -0800 (PST)
In-Reply-To: <CAKmqyKOr5eX1hQXURdz6Y7qDgygGOwYyFeKKZCH83UuuRkuR9w@mail.gmail.com>
From: Palmer Dabbelt <palmer@sifive.com>
Message-ID: <mhng-f2a3d61b-68dc-4842-a695-0eff3c6d81e4@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 5/5 v3] RISC-V: Add hooks to use the gdb
 xml files.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: alistair23@gmail.com
Cc: Jim Wilson <jimw@sifive.com>, qemu-riscv@nongnu.org, qemu-devel@nongnu.org

On Fri, 08 Feb 2019 11:28:48 PST (-0800), alistair23@gmail.com wrote:
> On Fri, Feb 8, 2019 at 11:09 AM Jim Wilson <jimw@sifive.com> wrote:
>>
>> On Fri, Feb 8, 2019 at 10:17 AM Alistair Francis <alistair23@gmail.com> wrote:
>> > Can we just write a wrapper function then that sets and unsets the variable?
>> > Something like this:
>> >
>> > riscv_csrrw_debug(...) {
>> >     #if !defined(CONFIG_USER_ONLY)
>> >             env->debugger = true;
>> >     #endif
>> >             result = riscv_csrrw(env, ...);
>> >     #if !defined(CONFIG_USER_ONLY)
>> >             env->debugger = false;
>> >     #endif
>> > }
>>
>> Yes, that would work.  Do you want me to resubmit a fixed part 5 patch?
>
> It's probably best to send out a new version of the whole series.
> Include all the Reviewed-by tags and then that should be the last
> version and Palmer can apply that series directly.

Ya, that's the best way to do it.  That way everyone is on the same page about 
exactly what is going in.
