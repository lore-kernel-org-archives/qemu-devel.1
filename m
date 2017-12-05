Received: from eggs.gnu.org ([2001:4830:134:3::10]:43888)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eM4we-0005Ck-K9
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 23:35:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eM4wd-00034D-I0
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 23:35:00 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1510087611-1851-1-git-send-email-cota@braap.org>
	<49151b79-7ec4-b728-1ea9-d5c393a5bada@amsat.org>
	<CAFEAcA-pwxfR-+XSu+q117Po=Lh2aRDGtW9jNAEZuPZNjbFC_Q@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <26366f15-b8a2-9e87-30f4-56253ec6ca9b@amsat.org>
Date: Tue, 5 Dec 2017 01:34:46 -0300
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-pwxfR-+XSu+q117Po=Lh2aRDGtW9jNAEZuPZNjbFC_Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH] arm/translate-a64: mark path as
 unreachable to eliminate warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "Emilio G. Cota" <cota@braap.org>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>

Hi Peter,

On 11/13/2017 08:26 AM, Peter Maydell wrote:
> On 8 November 2017 at 12:37, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>> On 11/07/2017 05:46 PM, Emilio G. Cota wrote:
>>> Fixes the following warning when compiling with gcc 5.4.0 with -O1
>>> optimizations and --enable-debug:
>>>
>>> target/arm/translate-a64.c: In function ‘aarch64_tr_translate_insn’:
>>> target/arm/translate-a64.c:2361:8: error: ‘post_index’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
>>>      if (!post_index) {
>>>         ^
>>> target/arm/translate-a64.c:2307:10: note: ‘post_index’ was declared here
>>>      bool post_index;
>>>           ^
>>> target/arm/translate-a64.c:2386:8: error: ‘writeback’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
>>>      if (writeback) {
>>>         ^
>>> target/arm/translate-a64.c:2308:10: note: ‘writeback’ was declared here
>>>      bool writeback;
>>>           ^
>>>
>>> Note that idx comes from selecting 2 bits, and therefore its value
>>> can be at most 3.
>>>
>>> Signed-off-by: Emilio G. Cota <cota@braap.org>
> 
> Applied to target-arm.next, thanks. (It's a bit sad that
> gcc can't figure out that the result of x & 3 is constrained
> to [0,3], but there you go.)
> 
>> Acked-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> 
> By the way, Philippe, what are you intending to convey with
> an acked-by tag? Usually "acked-by" means "I'm the maintainer
> for this area and I haven't actually reviewed this but I don't
> object to it"...

I still feel new into the FOSS community and am happy to learn and
understand from such comments :)
Reading thru the list I wondered what means this tag, asked to some
maintainers on IRC and read the Linux kernel "Submitting patches guide"
[1] bullet 12) "When to use Acked-by":

'''
Acked-by: is often used by the maintainer of the affected code when that
maintainer neither contributed to nor forwarded the patch.

Acked-by: is not as formal as Signed-off-by:. It is a record that the
acker has at least reviewed the patch and has indicated acceptance.
Hence patch mergers will sometimes manually convert an acker’s “yep,
looks good to me” into an Acked-by: (but note that it is usually better
to ask for an explicit ack).

Acked-by: does not necessarily indicate acknowledgement of the entire
patch. For example, if a patch affects multiple subsystems and has an
Acked-by: from one subsystem maintainer then this usually indicates
acknowledgement of just the part which affects that maintainer’s code. [...]
'''

It is not obvious that the 2nd case is restricted to maintainer, but now
than you explain it I understand.

I intended to express "I don't think this is the best way to solve this
problem, however this is probably the best fix when freezed for a
Release, and since I did have reviewed this in details (and tested it)
but I don't object to it, instead of signing with my Reviewed-by tag I
lower it to an Acked-by".

Next time I'll keep it simple and use a R-b :)

Thanks to take time to correct me!

Regards,

Phil.

[1]
https://www.kernel.org/doc/html/v4.12/process/submitting-patches.html#when-to-use-acked-by-and-cc
