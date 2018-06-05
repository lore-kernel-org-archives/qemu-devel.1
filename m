Received: from eggs.gnu.org ([2001:4830:134:3::10]:42993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fQCvz-00045n-1H
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 10:27:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fQCvu-0007do-Sw
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 10:27:38 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:45087)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fQCvu-0007dQ-IK
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 10:27:34 -0400
References: <20180531224911.23725-1-richard.henderson@linaro.org>
	<20180531224911.23725-7-richard.henderson@linaro.org>
	<788ee514-a026-d415-73ce-67cc996e6259@vivier.eu>
	<149da730-950c-a527-2373-9cb0433543b1@linaro.org>
	<8c43947d-4c20-bf71-78fe-691e5c567fda@vivier.eu>
	<c977351a-bd74-a2e6-375a-110b36fb7440@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <080b17da-d3c2-0e35-913e-064d70033619@vivier.eu>
Date: Tue, 5 Jun 2018 16:27:31 +0200
MIME-Version: 1.0
In-Reply-To: <c977351a-bd74-a2e6-375a-110b36fb7440@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, evgreen@chromium.org

Le 05/06/2018 à 16:18, Richard Henderson a écrit :
> On 06/04/2018 11:33 PM, Laurent Vivier wrote:
>> Yes, but Fedora has debootstrap.
> 
> Fair enough.  That's new to me.
> 
> I don't see how your script is supposed to work wrt binfmt-misc.  If you're
> copying in the static qemu, you need to adjust, or install, the interpreter.

Yes, I use scripts/qemu-binfmt-conf.sh to do that:

./scripts/qemu-binfmt-conf.sh --qemu-path / --systemd ppc64le
--credential yes
systemctl restart systemd-binfmt.service

And it is restored on any reboot.

Thanks,
Laurent
