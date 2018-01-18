Received: from eggs.gnu.org ([2001:4830:134:3::10]:48800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ec6kh-0002Am-O3
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 04:44:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ec6kf-0006q9-3R
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 04:44:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47860)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ec6ke-0006pm-T6
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 04:44:53 -0500
References: <20180110131832.16623-1-klim.kireev@virtuozzo.com>
	<71031eb9-06a0-21fe-dd89-4b49e23b97be@redhat.com>
	<fe310a84-9ffd-b167-0c42-5073e01afb04@virtuozzo.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <084aa452-486e-4784-9595-abeff8102713@redhat.com>
Date: Thu, 18 Jan 2018 10:44:43 +0100
MIME-Version: 1.0
In-Reply-To: <fe310a84-9ffd-b167-0c42-5073e01afb04@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] chardev/char-socket: add POLLHUP handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: klim <klim.kireev@virtuozzo.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, den@virtuozzo.com

On 18/01/2018 10:41, klim wrote:
>>>
>>> I propose to install a separate pullhup watcher regardless of
>>> whether the device waits for data or not. After closing the connection,
>>> the guest has a capability to read the data within timeout.
>> I don't understand the timeout part.
> The timeout is important, because of following situation:
> client sends to the guest big bunch of data and closes his end of socket.
> if we just destroy the connection on the qemu's side, the guest can't
> read remaining data in channel.
> (which can be much more than guest's buffer), although he would do it
> later.
> For this case timeout after POLLHUP is added. It is set after receiving
> POLLHUP and reset after each reading.

But why would one second be enough?

Paolo
