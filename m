Received: from eggs.gnu.org ([2001:4830:134:3::10]:54449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fx1cd-0007wu-Nw
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 23:03:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fx1cZ-0004Ha-N0
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 23:03:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51850 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1fx1cZ-0004FH-J1
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 23:03:15 -0400
References: <20180830142708.14311-1-sameeh@daynix.com>
	<20180830142708.14311-7-sameeh@daynix.com>
	<1d1aa7eb-3700-f358-f2a9-2daaf28bb9db@redhat.com>
	<CAKPgXcEywpG_J3KbMGG-UBt8PX4bT1yrn2=szKG-o40NK0PmYQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <ae905d79-4029-9697-1fa6-7bc4abcf9609@redhat.com>
Date: Tue, 4 Sep 2018 11:03:07 +0800
MIME-Version: 1.0
In-Reply-To: <CAKPgXcEywpG_J3KbMGG-UBt8PX4bT1yrn2=szKG-o40NK0PmYQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC 6/6] virtio-net: rss: Add bpf filter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sameeh Jubran <sameeh@daynix.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Yan Vugenfirer <yan@daynix.com>



On 2018=E5=B9=B409=E6=9C=8803=E6=97=A5 21:16, Sameeh Jubran wrote:
>> I may miss something, but it looks to me the indirection table should =
be implemented through a map as well? Since it was accessible by guest an=
d qemu need to trap the access and convert it to eBPF map updating?
> makes  sense, I'll convert it to map structure.
>
>
>> This looks tricky as well, should we search the BPF_LD and replace the=
 imm?
> Hmm yes this approach is better I guess.
>
>> I believe those bpf helpers should be moved to tap-linux.c.
> All of them?  I actually thought about moving them to a standalone
> file in the virtio-net.c dir.
> Can you explain the motive for this?
>

Because you're using Linux specific syscall, so it should be moved to=20
Linux specific implementation.

Thakns
