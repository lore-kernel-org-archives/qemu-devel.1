Received: from eggs.gnu.org ([2001:4830:134:3::10]:53390)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dYZoB-0008A3-Mf
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 11:25:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dYZo7-0000MG-IO
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 11:25:36 -0400
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:34329)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dYZo7-0000Lf-C5
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 11:25:35 -0400
Received: by mail-wr0-x236.google.com with SMTP id 12so83883655wrb.1
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 08:25:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5de01cad-5a63-ff42-8c6f-25210aa8348d@redhat.com>
References: <1500395194-21455-1-git-send-email-peter.maydell@linaro.org>
	<1500395194-21455-4-git-send-email-peter.maydell@linaro.org>
	<5de01cad-5a63-ff42-8c6f-25210aa8348d@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 21 Jul 2017 16:25:11 +0100
Message-ID: <CAFEAcA8nk2W2EBVyD16n1c8F3TZMb-7FBJ9HVuX86A+KyxtuYA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-2.10 3/4] bsd-user/bsdload.c: Remove
 write-only id_change variable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Juan Quintela <quintela@redhat.com>

On 21 July 2017 at 12:12, Thomas Huth <thuth@redhat.com> wrote:
> On 18.07.2017 18:26, Peter Maydell wrote:
>> On OpenBSD the compiler complains:
>> bsd-user/bsdload.c:54:17: warning: variable 'id_change' set but not used [-Wunused-but-set-variable]
>>
>> This is dead code that was originally copied from linux-user.
>> We fixed this in linux-user in commit 331c23b5ca44293d1 in 2011;
>> delete the useless code from bsd-user too.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---

>
> Matches the commit from linux-user, and looks sane to me, so:
>
> Reviewed-by: Thomas Huth <thuth@redhat.com>

Thanks; applied to master.

-- PMM
