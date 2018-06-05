Received: from eggs.gnu.org ([2001:4830:134:3::10]:40276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fQCms-0004Pk-LG
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 10:18:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fQCmn-0002HU-Jw
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 10:18:14 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:33181)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fQCmn-0002HC-CT
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 10:18:09 -0400
Received: by mail-pg0-x242.google.com with SMTP id e11-v6so1308540pgq.0
	for <qemu-devel@nongnu.org>; Tue, 05 Jun 2018 07:18:09 -0700 (PDT)
References: <20180531224911.23725-1-richard.henderson@linaro.org>
	<20180531224911.23725-7-richard.henderson@linaro.org>
	<788ee514-a026-d415-73ce-67cc996e6259@vivier.eu>
	<149da730-950c-a527-2373-9cb0433543b1@linaro.org>
	<8c43947d-4c20-bf71-78fe-691e5c567fda@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c977351a-bd74-a2e6-375a-110b36fb7440@linaro.org>
Date: Tue, 5 Jun 2018 07:18:05 -0700
MIME-Version: 1.0
In-Reply-To: <8c43947d-4c20-bf71-78fe-691e5c567fda@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 6/6] linux-user: Use *at functions to
 implement interp_prefix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, evgreen@chromium.org

On 06/04/2018 11:33 PM, Laurent Vivier wrote:
> Yes, but Fedora has debootstrap.

Fair enough.  That's new to me.

I don't see how your script is supposed to work wrt binfmt-misc.  If you're
copying in the static qemu, you need to adjust, or install, the interpreter.

Therefore I am unsurprised to find that your script fails at

    cp "$QEMU_PATH" $CHROOT/ && \
    chroot $CHROOT ./debootstrap/debootstrap --second-stage || exit


r~
