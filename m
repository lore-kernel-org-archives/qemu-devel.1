Received: from eggs.gnu.org ([2001:4830:134:3::10]:55596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fII8J-0008EP-SP
	for qemu-devel@nongnu.org; Mon, 14 May 2018 14:23:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fII8F-0001Ji-Sv
	for qemu-devel@nongnu.org; Mon, 14 May 2018 14:23:39 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:35223)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fII8F-0001Ir-Je
	for qemu-devel@nongnu.org; Mon, 14 May 2018 14:23:35 -0400
References: <20180514174616.19601-1-peter.maydell@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <ca599aa8-05b0-b44a-c756-dfa8b443d3b4@vivier.eu>
Date: Mon, 14 May 2018 20:23:22 +0200
MIME-Version: 1.0
In-Reply-To: <20180514174616.19601-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] linux-user: Assert on bad type in
 thunk_type_align() and thunk_type_size()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org, Riku Voipio <riku.voipio@iki.fi>

Le 14/05/2018 à 19:46, Peter Maydell a écrit :
> In thunk_type_align() and thunk_type_size() we currently return
> -1 if the value at the type_ptr isn't one of the TYPE_* values
> we understand. However, this should never happen, and if it does
> then the calling code will go confusingly wrong because none
> of the callsites try to handle an error return. Switch to an
> assertion instead, so that if this does somehow happen we'll have
> a nice clear backtrace of what happened rather than a weird crash
> or misbehaviour.
> 
> This also silences various Coverity complaints about not handling
> the negative return value (CID 1005735, 1005736, 1005738, 1390582).
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  include/exec/user/thunk.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
