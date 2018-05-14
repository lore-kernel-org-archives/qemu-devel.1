Received: from eggs.gnu.org ([2001:4830:134:3::10]:40114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIIMN-0007OM-Fy
	for qemu-devel@nongnu.org; Mon, 14 May 2018 14:38:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIIMM-0003f8-MU
	for qemu-devel@nongnu.org; Mon, 14 May 2018 14:38:11 -0400
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:41707)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fIIMM-0003eA-HM
	for qemu-devel@nongnu.org; Mon, 14 May 2018 14:38:10 -0400
Received: by mail-ot0-x244.google.com with SMTP id t1-v6so15465108oth.8
	for <qemu-devel@nongnu.org>; Mon, 14 May 2018 11:38:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180514212856-mutt-send-email-mst@kernel.org>
References: <1526303228-486609-1-git-send-email-mst@redhat.com>
	<CAFEAcA_bWJupL7oj=uxNAi3=1RGUZxpEeKx1L=JBZa6J4CuuYA@mail.gmail.com>
	<20180514212856-mutt-send-email-mst@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 May 2018 19:37:49 +0100
Message-ID: <CAFEAcA_mLsbULijnaWfVShO0ZHSJx7QQTB32Cs+FU-HZiFbFSw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v6 0/3] linux-headers: arch fixups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, James Hogan <jhogan@kernel.org>

On 14 May 2018 at 19:29, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Mon, May 14, 2018 at 04:10:42PM +0100, Peter Maydell wrote:
>> On 14 May 2018 at 14:07, Michael S. Tsirkin <mst@redhat.com> wrote:
>> > It turns out that we have unistd.h and kvm headers for some
>> > architectures but not others.  We are thus unable to use e.g. usefaultfd
>> > on these systems unless system headers have been updated.
>> >
>> > Fix up update-linux-headers.sh to make sure we auto-updates
>> > all architectures which have linux-headers/
>> > (unfortunately this still does not mean "all linux systems").
>> >
>> > Tested on x86 only.
>> >
>> > Pls consider merging this through the ARM tree.
>> >
>> > Changes from v5:
>> >     rebase to master
>>
>> Still doesn't apply:
>
> Against which commit?

bbd87423ea0c436c55bb, but the last change in master
to scripts/update-linux-headers.sh is 7afcfd32a65688 a
month ago, so this won't apply to anything since then
and wouldn't have applied before that either. I think you
have based your patchset on some other changes to the script
which are not in master (at a guess, your "move kvm_para.h
to standard-headers" series).

thanks
-- PMM
