Received: from eggs.gnu.org ([2001:4830:134:3::10]:42184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eAZ36-0002pX-2I
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 06:18:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eAZ31-0000eY-5F
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 06:18:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43890)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eAZ30-0000dz-Vi
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 06:17:59 -0400
References: <20171031112457.10516.8971.stgit@pasha-VirtualBox>
	<20171031112633.10516.44062.stgit@pasha-VirtualBox>
	<92aa3279-66b5-b765-b36b-2acb6413bd47@redhat.com>
	<001301d35484$75071110$5f153330$@ru> <87tvybhewj.fsf@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6ef0c3d0-41e5-d3cf-e84d-857ff1b47e48@redhat.com>
Date: Fri, 3 Nov 2017 11:17:50 +0100
MIME-Version: 1.0
In-Reply-To: <87tvybhewj.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 17/26] replay: push replay_mutex_lock
 up the call tree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Pavel Dovgalyuk <dovgaluk@ispras.ru>
Cc: 'Pavel Dovgalyuk' <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org, kwolf@redhat.com, peter.maydell@linaro.org, boost.lists@gmail.com, quintela@redhat.com, jasowang@redhat.com, mst@redhat.com, zuban32s@gmail.com, maria.klimushenkova@ispras.ru, kraxel@redhat.com

On 03/11/2017 10:47, Alex Benn=C3=A9e wrote:
>   As deadlocks are easy to introduce a new rule is introduced that the
>   replay_mutex_lock is taken before any BQL locks. Conversely you canno=
t
>   release the replay_lock while the BQL is still held.

I agree with the former, but the latter is unnecessary.

Paolo
