Received: from eggs.gnu.org ([209.51.188.92]:53296)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gpqsC-00037g-7z
	for qemu-devel@nongnu.org; Sat, 02 Feb 2019 03:42:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gpqs8-0003yO-C5
	for qemu-devel@nongnu.org; Sat, 02 Feb 2019 03:41:58 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530]:42594)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gpqs4-0003oP-G2
	for qemu-devel@nongnu.org; Sat, 02 Feb 2019 03:41:54 -0500
Received: by mail-ed1-x530.google.com with SMTP id y20so7366175edw.9
	for <qemu-devel@nongnu.org>; Sat, 02 Feb 2019 00:41:45 -0800 (PST)
Date: Sat, 02 Feb 2019 00:41:44 -0800 (PST)
In-Reply-To: <CAFEAcA_hP=iuqWrVoqRjRhge27uC8VOJTjfATj2DMY0Hh5HHxA@mail.gmail.com>
From: Palmer Dabbelt <palmer@sifive.com>
Message-ID: <mhng-99c129ef-4e70-4840-b80f-7b3c6b806083@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PR RFC] RISC-V Patches for 3.2, Part 3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: thuth@redhat.com, eblake@redhat.com, qemu-riscv@nongnu.org, qemu-devel@nongnu.org

On Thu, 31 Jan 2019 01:51:52 PST (-0800), Peter Maydell wrote:
> On Thu, 31 Jan 2019 at 06:39, Thomas Huth <thuth@redhat.com> wrote:
>>
>> On 2019-01-30 20:01, Palmer Dabbelt wrote:
>> > On Wed, 30 Jan 2019 09:45:33 PST (-0800), eblake@redhat.com wrote:
>> >> On 1/30/19 11:35 AM, Palmer Dabbelt wrote:
>> >>> The following changes since commit
>> >>> 5385a5988c8a55bebdc878c05b96648579b5d6e0:
>> >>>
>> >>>   hw/virtio/virtio-balloon: zero-initialize the virtio_balloon_config
>> >>> struct (2019-01-21 17:20:36 +0000)
>> >>>
>> >>> are available in the Git repository at:
>> >>>
>> >>>   git://github.com/palmer-dabbelt/qemu.git
>> >>> tags/riscv-for-master-3.2-part3
>> >>>
>> >>> for you to fetch changes up to 461ab9de46d085a37b0da6f096aadc4e0dda4d4c:
>> >>>
>> >>>   target/riscv: fix counter-enable checks in ctr() (2019-01-29
>> >>> 11:33:38 -0800)
>> >>>
>> >>> ----------------------------------------------------------------
>> >>> RISC-V Patches for 3.2, Part 3
>> >>
>> >> There is no 3.2 release; the next release is named 4.0.  However, if you
>> >> don't want to bother with sending a v2 pull request just to fix the
>> >> merge commit message, that's okay with me.
>> >
>> > Ah, sorry.  I think I'm just going to leave it as is, I'll get it right
>> > next time.
>>
>> Also note that you used "PR RFC" in the title ... so not sure whether
>> Peter's scripts will catch this PR as a valid one...
>
> My mail filter finds these RFC pullrequests, yes. I'm then
> relying on my manual brain to not actually apply them.
> (If it's a slow day I might do a test merge on them, but
> usually my queue is full enough that I don't get to them
> before the real PR appears.)

Ah, OK -- do you want me to do something else?
