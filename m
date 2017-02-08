Received: from eggs.gnu.org ([2001:4830:134:3::10]:41893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ashmit602@gmail.com>) id 1cbZhl-0000iu-Uq
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 16:23:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ashmit602@gmail.com>) id 1cbZhl-0001fK-8l
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 16:23:09 -0500
Received: from mail-io0-x244.google.com ([2607:f8b0:4001:c06::244]:36547)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ashmit602@gmail.com>) id 1cbZhl-0001eo-3X
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 16:23:09 -0500
Received: by mail-io0-x244.google.com with SMTP id q20so212077ioi.3
	for <qemu-devel@nongnu.org>; Wed, 08 Feb 2017 13:23:09 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170202100856.GA22164@stefanha-x1.localdomain>
References: <20161115124417.GC9226@lemon>
	<20161115144551.GB17672@stefanha-x1.localdomain>
	<20161115150016.GD9226@lemon>
	<20161115192026.GA26428@stefanha-x1.localdomain>
	<CAAo6VWN9uO9-jjEfHxLHCBE5V5tr5Sx52tGY5vu3g8JgcCRqvQ@mail.gmail.com>
	<87eg2bokx0.fsf@dusky.pond.sub.org> <20161116094901.GA31999@lemon>
	<CAJSP0QWvsO8480gsOa=1jiY-8WLwTt6cgPtP6O-CAOfehZab3A@mail.gmail.com>
	<CAAo6VWNMw2GdR-MznT5np7ov+hSGZZ-6t69bm5+TqAjmHZJZPQ@mail.gmail.com>
	<CAAo6VWM26xdQhjX9YGiPAXBBxzUNwSi+AUohWyO1HEXxfPv+LQ@mail.gmail.com>
	<20170202100856.GA22164@stefanha-x1.localdomain>
From: ashish mittal <ashmit602@gmail.com>
Date: Wed, 8 Feb 2017 13:23:07 -0800
Message-ID: <CAAo6VWMY4rcKOpb7zYzKYMLM5o_BNVhhUvy-gg+CDkmvenB3Kw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v6 1/2] block/vxhs.c: Add support for a new
 block device type called "vxhs"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Fam Zheng <famz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, "Venkatesha M.G." <Venkatesha.Mg@veritas.com>, Ashish Mittal <ashish.mittal@veritas.com>, Jeff Cody <jcody@redhat.com>, Rakesh Ranjan <Rakesh.Ranjan@veritas.com>, Ketan Nilangekar <Ketan.Nilangekar@veritas.com>, Abhijit Dey <Abhijit.Dey@veritas.com>, Paolo Bonzini <pbonzini@redhat.com>, Buddhi Madhav <Buddhi.Madhav@veritas.com>, John Ferlan <jferlan@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Nitin Jerath <Nitin.Jerath@veritas.com>, Suraj Singh <Suraj.Singh@veritas.com>, Peter Krempa <pkrempa@redhat.com>

We have retained the original syntax in v7 per the following
suggestion on libvirt thread -

>> That is correct. Above syntax would also work for us. I will pose this
>> suggestion to the qemu community and update with their response.
>>

It's not that important... I was looking for a simplification and
generation of only what's required. You can continue using the server
syntax - perhaps just leave a note/comment in the code indicating the
decision point and move on.


On Thu, Feb 2, 2017 at 2:08 AM, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> On Tue, Jan 31, 2017 at 05:55:47PM -0800, ashish mittal wrote:
>> Hi,
>>
>> There has been some work going on on the VxHS libvirt patches and we
>> are making good progress.
>>
>> A suggestion has been made on the libvirt community to check if we can
>> change the qemu VxHS device specification syntax as follows.
>>
>> Replace
>>
>> (a) +file.server.host=192.168.0.1,file.server.port=9999
>>
>> with
>>
>> (b) +file.host=192.168.0.1,file.port=9999
>>
>> The reasoning being that since we have only one host (true as the
>> failover is now being handled completely/transparently) within the
>> libqnio library), the "server" part is redundant.
>
> Sounds good to me.
>
> Stefan
