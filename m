Received: from eggs.gnu.org ([2001:4830:134:3::10]:50059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f73IW-0001JY-UP
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 14:19:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f73IV-0002rz-OU
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 14:19:44 -0400
Received: from mail-pf0-x236.google.com ([2607:f8b0:400e:c00::236]:34123)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1f73IV-0002rX-Hs
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 14:19:43 -0400
Received: by mail-pf0-x236.google.com with SMTP id q9so6526264pff.1
	for <qemu-devel@nongnu.org>; Fri, 13 Apr 2018 11:19:43 -0700 (PDT)
References: <20180411184556.17200-1-laurent@vivier.eu>
	<20180411184556.17200-21-laurent@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0a5e08a6-e321-bde9-e179-2d5206443d77@linaro.org>
Date: Thu, 12 Apr 2018 19:02:49 -1000
MIME-Version: 1.0
In-Reply-To: <20180411184556.17200-21-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for 2.13 v3 20/20] linux-user: define
 TARGET_ARCH_HAS_SETUP_FRAME
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Cornelia Huck <cohuck@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-s390x@nongnu.org, Riku Voipio <riku.voipio@iki.fi>

On 04/11/2018 08:45 AM, Laurent Vivier wrote:
> Instead of calling setup_frame() conditionally to a list of known targets,
> define TARGET_ARCH_HAS_SETUP_FRAME if the target provides the function
> and call it only if the macro is defined.
> 
> Move declarations of setup_frame() and setup_rt_frame() to
> linux-user/signal-common.h
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
> 
> Notes:
>     v3: move declarations of functions to signal-common.h
>         fix comment in handle_pending_signal()

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
