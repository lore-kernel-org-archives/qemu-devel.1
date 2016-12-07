Received: from eggs.gnu.org ([2001:4830:134:3::10]:45439)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cEbO9-00037T-LP
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 07:32:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cEbO5-00063U-HP
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 07:31:57 -0500
Received: from mail-ua0-f177.google.com ([209.85.217.177]:35373)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cEbO5-00062y-Cw
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 07:31:53 -0500
Received: by mail-ua0-f177.google.com with SMTP id 12so413534562uas.2
	for <qemu-devel@nongnu.org>; Wed, 07 Dec 2016 04:31:53 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20161207120419.GA1476@redhat.com>
References: <CAFEAcA9kODkdK96a=rdZS7+xSW0drj4vLMev-AVio-uewm6Cbw@mail.gmail.com>
	<20161207120419.GA1476@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 7 Dec 2016 12:30:31 +0000
Message-ID: <CAFEAcA8UofRa9Yo93vsFYDqJaW5YuKKF68X+2ae=GKdp8w9HWg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] qemu -netdev tun/tap support can't handle macvtap
 type devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>

On 7 December 2016 at 12:04, Daniel P. Berrange <berrange@redhat.com> wrote:
> On Wed, Dec 07, 2016 at 12:01:14PM +0000, Peter Maydell wrote:
>> The usual suggested workaround is to use the -netdev fd option, like
>>   fd=3 3<>/dev/tap$(< /sys/class/net/tap0/ifindex)
>> (which gets the shell to open the right /dev/tap device).
>> Unfortunately this isn't compatible with multi-queue support
>> because netdev complains
>> "ifname=, script=, downscript=, vnet_hdr=, helper=, queues=, fds=,
>> and vhostfds= are invalid with fd="
>> so you can't pass options like "queues=4"...
>
> FWIW you should be able to instead do
>
>    fds=3 3<>/dev/tap$(< /sys/class/net/tap0/ifindex)
>
> note 'fds' plural, instead of 'fd'

What's the difference between that and the "usual suggested workaround"
I described above that doesn't work with queues=... ?

thanks
-- PMM
