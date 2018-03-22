Received: from eggs.gnu.org ([2001:4830:134:3::10]:45027)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ez5qo-0007A8-Q3
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 15:26:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ez5qn-0006O5-W5
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 15:26:14 -0400
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:38100)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ez5qn-0006Nt-QJ
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 15:26:13 -0400
Received: by mail-ot0-x243.google.com with SMTP id 95-v6so10727192ote.5
	for <qemu-devel@nongnu.org>; Thu, 22 Mar 2018 12:26:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180319162502.GA21259@stefanha-x1.localdomain>
References: <20180319131743.3885-1-peter.maydell@linaro.org>
	<20180319162502.GA21259@stefanha-x1.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Mar 2018 19:25:52 +0000
Message-ID: <CAFEAcA81dKOLKtUcrHLQGNuzps4uvqZQJRFa16+78pNbr3qstA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-2.12] gitmodules: Use the QEMU mirror
 of qemu-palcode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Richard Henderson <rth@twiddle.net>

On 19 March 2018 at 16:25, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> On Mon, Mar 19, 2018 at 01:17:43PM +0000, Peter Maydell wrote:
>> We have a mirror of the qemu-palcode repository on
>> git.qemu.org; use that instead of the upstream github,
>> in line with our general policy of keeping and using
>> a mirror for submodules.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>> We also currently have two submodules we don't have mirroring
>> for: seabios-hppa and u-boot-sam460ex.
>>
>>  .gitmodules | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> The git.qemu.org mirror appears up-to-date:
>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

Thanks; applied to master.

-- PMM
