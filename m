Received: from eggs.gnu.org ([2001:4830:134:3::10]:40396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1cst32-0007ip-7C
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 11:28:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1cst2y-00073U-4E
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 11:28:40 -0400
Received: from mail.weilnetz.de ([37.120.169.71]:38182
	helo=v2201612906741603.powersrv.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sw@weilnetz.de>) id 1cst2x-00072Y-UM
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 11:28:36 -0400
References: <1490707129-12622-1-git-send-email-peter.maydell@linaro.org>
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <8c1e5775-b088-0270-a919-588e074ff70b@weilnetz.de>
Date: Tue, 28 Mar 2017 17:28:34 +0200
MIME-Version: 1.0
In-Reply-To: <1490707129-12622-1-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.9] configure: Don't claim
 'unsupported host OS' when better message available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org

Am 28.03.2017 um 15:18 schrieb Peter Maydell:
> The change in commit 898be3e0415c6d which made completely
> unrecognized OSes cause an error_exit "Unsupported host OS"
> has some unfortunate unintended effects:
>  * if you run 'configure --help' on an unsupported host OS
>    (eg if intending to use it as a build machine for a
>    cross compile to a supported host) then the message
>    is printed instead of --help
>  * if the C compiler doesn't work or is missing (eg if
>    you passed an incorrect --cross-prefix by mistake)
>    the message is printed instead of the more useful
>    'compiler does not exist or does not work' message
>
> Fix this by postponing the error_exit in this situation
> until later, when we have already identified the more
> useful cases for this.
>
> The long term fix for this would be to move handling
> of --help much further up in the configure script,
> and make its output not dependent on checks that configure
> runs. However for 2.9 this would be too invasive.

That's true.

> Reported-by: Stefan Weil <sw@weilnetz.de>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  configure | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)

Reviewed-by: Stefan Weil <sw@weilnetz.de>
Tested-by: Stefan Weil <sw@weilnetz.de>

Thanks.
Stefan
