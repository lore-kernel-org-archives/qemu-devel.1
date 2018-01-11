Received: from eggs.gnu.org ([2001:4830:134:3::10]:44700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eZcqi-0000ND-Nv
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 08:24:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eZcqh-0005aU-V4
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 08:24:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:29105)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eZcqh-0005Zi-Oq
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 08:24:51 -0500
References: <20180110134846.12940.99993.stgit@pasha-VirtualBox>
	<029858e0-c6e5-939d-d79e-c7ad7e5069a1@linaro.org>
	<CAFEAcA9ZMZyhV_MLvdpKD74895rXJ4cw3sX1sMHYJASe2h3LMw@mail.gmail.com>
	<b5273c61-3db0-c171-4b92-c273def5feb7@redhat.com>
	<CAFEAcA9c7=g68jE6zXJBxkKvvKG9m1u9aFxbf87AnvfuqQo3bw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7823c962-6940-9e8a-9d2c-784505db9bda@redhat.com>
Date: Thu, 11 Jan 2018 14:24:45 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9c7=g68jE6zXJBxkKvvKG9m1u9aFxbf87AnvfuqQo3bw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] cpu: flush TB cache when loading VMState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, QEMU Developers <qemu-devel@nongnu.org>, maria.klimushenkova@ispras.ru, Pavel Dovgalyuk <dovgaluk@ispras.ru>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>

On 11/01/2018 11:20, Peter Maydell wrote:
> On 11 January 2018 at 10:15, Paolo Bonzini <pbonzini@redhat.com> wrote:
>> RAM contents are memcpy'd blindly during loadvm.  I think that's what
>> requires a tb_flush.
> 
> Ah, that makes sense. Could we have a comment documenting the
> rationale, please? Something like:
> 
> /* vmload has just updated the content of RAM, bypassing the
>  * usual mechanisms that ensure we flush TBs for writes to
>  * memory we've translated code from. So we must flush all TBs,
>  * which will now be stale.
>  */
> 
> thanks
> -- PMM
> 

Sure, will add it.

Paolo
