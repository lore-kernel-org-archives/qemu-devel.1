Received: from eggs.gnu.org ([2001:4830:134:3::10]:52445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fMEAr-0001fE-5u
	for qemu-devel@nongnu.org; Fri, 25 May 2018 10:58:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fMEAn-0008KO-A6
	for qemu-devel@nongnu.org; Fri, 25 May 2018 10:58:33 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:42377)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fMEAn-0008K2-4Z
	for qemu-devel@nongnu.org; Fri, 25 May 2018 10:58:29 -0400
Received: by mail-pf0-x241.google.com with SMTP id p14-v6so2716234pfh.9
	for <qemu-devel@nongnu.org>; Fri, 25 May 2018 07:58:28 -0700 (PDT)
References: <20180525132755.21839-1-peter.maydell@linaro.org>
	<20180525132755.21839-4-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5596f57d-6a92-f3f3-4ca0-04abe0a4ac9b@linaro.org>
Date: Fri, 25 May 2018 07:58:23 -0700
MIME-Version: 1.0
In-Reply-To: <20180525132755.21839-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/6] scripts/update-linux-headers: Handle
 kernel license no longer being one file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, patches@linaro.org

On 05/25/2018 06:27 AM, Peter Maydell wrote:
> The kernel has changed its license documentation, so instead of COPYING
> being a stand-alone file that defines the license, it refers to various
> other files under LICENSES/. This means we need to copy not just COPYING
> but also these other files to our copy of the kernel headers.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> We could copy the whole of LICENSES/ but that seems like overkill.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
