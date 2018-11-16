Received: from eggs.gnu.org ([2001:4830:134:3::10]:35108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gNfLA-0002UW-61
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 09:43:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gNfL7-0007ev-V9
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 09:43:23 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:38230)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gNfL7-0007cD-MY
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 09:43:21 -0500
Received: by mail-ot1-x342.google.com with SMTP id u3so16404948ota.5
	for <qemu-devel@nongnu.org>; Fri, 16 Nov 2018 06:43:19 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20181105185046.2802-2-aaron@os.amperecomputing.com>
References: <20181105185046.2802-1-aaron@os.amperecomputing.com>
	<20181105185046.2802-2-aaron@os.amperecomputing.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 16 Nov 2018 14:42:58 +0000
Message-ID: <CAFEAcA_M=KfiFdtVbyuiFPfAh1r+p=vQT+CHBpRNdiqPBxN_4g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v7 01/12] migration: Add post_save function
 to VMStateDescription
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aaron Lindsay <aaron@os.amperecomputing.com>
Cc: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <richard.henderson@linaro.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Michael Spradling <mspradli@codeaurora.org>, Digant Desai <digantd@codeaurora.org>, Aaron Lindsay <aclindsa@gmail.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On 5 November 2018 at 18:51, Aaron Lindsay <aaron@os.amperecomputing.com> wrote:
> In some cases it may be helpful to modify state before saving it for
> migration, and then modify the state back after it has been saved. The
> existing pre_save function provides half of this functionality. This
> patch adds a post_save function to provide the second half.
>
> Signed-off-by: Aaron Lindsay <aclindsa@gmail.com>
> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

David: do you want to provide a reviewed-by/acked-by for
the migration vmstate API change ?

thanks
-- PMM
