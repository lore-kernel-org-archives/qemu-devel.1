Received: from eggs.gnu.org ([2001:4830:134:3::10]:46897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eQwDx-00089o-RY
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 09:16:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eQwDw-0002S7-Mk
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 09:16:57 -0500
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:35132)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eQwDw-0002RT-1g
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 09:16:56 -0500
Received: by mail-ot0-x244.google.com with SMTP id q3so13437874oth.2
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 06:16:56 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <dd0cf724-3696-0ed3-343a-7ce2645645a9@redhat.com>
References: <20171218124943.28529-1-ybettan@redhat.com>
	<CAFEAcA-vsJ-6MntBB6LuMzHhA+X-YZv=XJwZRuhD5m0wj-o+AA@mail.gmail.com>
	<dd0cf724-3696-0ed3-343a-7ce2645645a9@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 Dec 2017 14:16:34 +0000
Message-ID: <CAFEAcA_OVxUw+rnKuDw5h_KrbxYoGSCJZ-+g_VFr2XuKcw9==g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH V2] vl.c && linux-user/main.c : removed
 **envp from main() arguments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yoni Bettan <ybettan@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 18 December 2017 at 13:13, Yoni Bettan <ybettan@redhat.com> wrote:
> On 12/18/2017 02:54 PM, Peter Maydell wrote:
>> Did you test this on OSX? I'm pretty sure it will break,
>> because now the main() function in ui/cocoa.m will
>> recursively call itself, rather than calling the
>> function in vl.c. (Either that or it just won't
>> link at all because there are two main() functions.)
>
>
> I didn't checked it on OSX.
> I was actually convinced it is Ok but when  I rethink it
> I understand that on Mac OSX the third argument is required (char **envp)
> as it seems to use it here:  "return qemu_main(gArgc, gArgv,
> *_NSGetEnviron());"
> so the patch *idea* will literally break ui/coca.m.

No, the general idea of removing the 3rd argument from
qemu_main() is fine (you can just not pass the environment
to it from the ui/cocoa.m code). But you can't get rid
of the ifdef stuff that allows cocoa.m to provide its
own main() function and rename the vl.c one to qemu_main.

thanks
-- PMM
